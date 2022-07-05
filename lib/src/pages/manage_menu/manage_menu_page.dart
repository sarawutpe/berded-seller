import 'dart:io';

import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/bloc/manage_menu/manage_menu_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/constants/constants.dart';
import 'package:berded_seller/src/models/multi_phone_number_model.dart';
import 'package:berded_seller/src/models/phone_number_model.dart';
import 'package:berded_seller/src/utils/formatter.dart';
import 'package:berded_seller/src/utils/webviewUtil.dart';
import 'package:berded_seller/src/widgets/two_confirm_dialog.dart';
import 'package:berded_seller/src/widgets/custom_appbar.dart';
import 'package:berded_seller/src/widgets/search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:share_extend/share_extend.dart';
import 'package:sizer/sizer.dart';
import '../../app.dart';
import '../router.dart';
import 'sidebar_menu.dart';

class ManageMenuPage extends StatefulWidget {
  @override
  ManageMenuPageState createState() => ManageMenuPageState();
}

class ManageMenuPageState extends State<ManageMenuPage> {
  bool isSwipeMenu = true;
  bool showSearchBar = false;
  bool isMobileDisplay = true;
  String currentUrl = "";
  String appBarTitle = "จัดการเบอร์";

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    isMobileDisplay = (SizerUtil.deviceType == DeviceType.mobile);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ManageMenuBloc>().add(ManageMenuEventGoBack());
        return false;
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          color: ThemeColors.lightPrimary,
          child: SafeArea(
            left: false,
            right: false,
            bottom: false,
            child: BlocBuilder<ManageMenuBloc, ManageMenuState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    // content
                    Container(
                      padding: EdgeInsets.only(top: showSearchBar ? 220.0 : 50.0),
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Expanded(
                                  child: WebView(
                                    onWebViewCreated: (controller) {
                                      Map<String, String> headers = {"Authorization": "Bearer " + context.read<LoginBloc>().state.result!.token};
                                      controller.loadUrl("https://www.berded.in.th/login/?username=login", headers: headers);
                                      context.read<ManageMenuBloc>().add(ManageMenuEventInitial(controller));
                                    },
                                    initialUrl: 'https://www.berded.in.th/login/?username=login',
                                    javascriptMode: JavascriptMode.unrestricted,
                                    onProgress: (int progress) {
                                      print('WebView is loading (progress : $progress%)');
                                      //Handle remove html on progress
                                      final webviewController = context.read<ManageMenuBloc>().state.webViewController;
                                      if (progress > 1) {
                                        // footer html
                                        runJavascript('document.querySelector(".page-prefooter").remove(); document.querySelector(".page-footer").remove();',
                                            webVC: webviewController);

                                        // footer cookie banner
                                        runJavascript('document.getElementById("cookit").remove();', webVC: webviewController);

                                        // backup field html
                                        runJavascript('document.querySelector(".field_backup").remove();', webVC: webviewController);

                                        if (currentUrl.contains("dashboard")) {
                                          // compact field html
                                          runJavascript('document.querySelector(".page-header-top").remove(); document.querySelector(".box_fiter").remove();',
                                              webVC: webviewController);

                                          // filter
                                          runJavascript('document.querySelector(".box_fiter").remove();', webVC: webviewController);

                                          // remove header
                                          runJavascript('document.querySelector(".page-head").remove();', webVC: webviewController);

                                          if (SizerUtil.deviceType == DeviceType.mobile) {
                                            runJavascript('document.getElementById("add_phone_one_btn").style.display="none";', webVC: webviewController);
                                            runJavascript('document.getElementById("add_phone_multiple_btn").style.display="none";', webVC: webviewController);
                                          }
                                        }
                                      }
                                    },

                                    // clickSharePhoneInfo.postMessage("")
                                    // window.clickSharePhoneInfo.postMessage("")
                                    javascriptChannels: <JavascriptChannel>[
                                      _handleJavacriptSendPhotoDataToFlutterChannel(context),
                                      _handleJavacriptSharePhotoToFlutterChannel(context),
                                    ].toSet(),
                                    navigationDelegate: (NavigationRequest request) async {
                                      // Handle prevent all http
                                      if (request.url.startsWith('http:')) {
                                        return NavigationDecision.prevent;
                                      }
                                      // Handle prevent links.
                                      if (!(request.url.startsWith('https://www.berded.in.th/portal/') || request.url.startsWith('https://www.berded.in.th/login/'))) {
                                        return NavigationDecision.prevent;
                                      }
                                      // Handle tel popup.
                                      if (request.url.startsWith('tel:')) {
                                        // await launch('${request.url}');
                                        return NavigationDecision.prevent;
                                      }

                                      if (!request.url.contains("device=native") && !request.url.contains("login")) {
                                        if (request.url.contains("?")) {
                                          state.webViewController?.loadUrl(request.url + "&device=native");
                                        } else {
                                          state.webViewController?.loadUrl(request.url + "?device=native");
                                        }
                                        return NavigationDecision.prevent;
                                      }
                                      return NavigationDecision.navigate;
                                    },
                                    onPageStarted: (String url) {
                                      currentUrl = url;
                                      print('Page started loading: $url');
                                      context.read<ManageMenuBloc>().add(ManageMenuEventSetLoading(isLoading: true));
                                    },
                                    onPageFinished: (String url) {
                                      changeAppBarTitle(url);
                                      print('Page finished loading: $url');
                                      context.read<ManageMenuBloc>().add(ManageMenuEventSetLoading(isLoading: false));
                                    },
                                    gestureNavigationEnabled: true,
                                  ),
                                ),
                                if (isSwipeMenu)
                                  Container(
                                    color: Color(0xff2d2d2d),
                                    width: 45,
                                    height: double.infinity,
                                    padding: EdgeInsets.only(top: 0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                if (SizerUtil.deviceType == DeviceType.mobile)
                                                  SideBarMenu(
                                                    title: "เพิ่ม",
                                                    icon: Icons.add,
                                                    onPressed: () async {
                                                      if (!currentUrl.contains("dashboard")) {
                                                        state.webViewController?.loadUrl(Constants.MANAGE_PAGE_DASHBOARD_MENU + "&device=native");
                                                        await Future.delayed(Duration(seconds: 2));
                                                      }
                                                      _showAddOptionDlg(state.webViewController);
                                                    },
                                                  ),
                                                SideBarMenu(
                                                  title: "ทั้งหมด",
                                                  icon: Icons.home,
                                                  onPressed: () {
                                                    state.webViewController?.loadUrl(Constants.MANAGE_PAGE_DASHBOARD_MENU + "&device=native");
                                                  },
                                                ),
                                                SideBarMenu(
                                                  title: "ส่วนตัว",
                                                  icon: Icons.person_pin,
                                                  onPressed: () {
                                                    setState(() {
                                                      showSearchBar = false;
                                                    });
                                                    state.webViewController?.loadUrl(Constants.MANAGE_PAGE_SELLER_PROFILE_MENU);
                                                  },
                                                ),
                                                SideBarMenu(
                                                  title: "สถิติ",
                                                  icon: Icons.pie_chart,
                                                  onPressed: () {
                                                    setState(() {
                                                      showSearchBar = false;
                                                    });
                                                    state.webViewController?.loadUrl(Constants.MANAGE_PAGE_SELLER_STATS_MENU);
                                                  },
                                                ),
                                                SideBarMenu(
                                                  title: "เมล",
                                                  icon: Icons.email,
                                                  onPressed: () {
                                                    setState(() {
                                                      showSearchBar = false;
                                                    });
                                                    state.webViewController?.loadUrl(Constants.MANAGE_PAGE_SELLER_EMAIL_MENU);
                                                  },
                                                ),
                                                SideBarMenu(
                                                  title: "จัดส่ง",
                                                  icon: Icons.local_shipping,
                                                  onPressed: () {
                                                    setState(() {
                                                      showSearchBar = false;
                                                    });
                                                    state.webViewController?.loadUrl(Constants.MANAGE_PAGE_SELLER_EMS_MENU);
                                                  },
                                                ),
                                                SideBarMenu(
                                                  title: "บทความ",
                                                  fontSize: 10,
                                                  icon: Icons.article,
                                                  onPressed: () {
                                                    setState(() {
                                                      showSearchBar = false;
                                                    });
                                                    state.webViewController?.loadUrl(Constants.MANAGE_PAGE_SELLER_ARTICLE_MENU);
                                                  },
                                                ),
                                                SideBarMenu(
                                                  title: "Help",
                                                  icon: Icons.help,
                                                  onPressed: () {
                                                    setState(() {
                                                      showSearchBar = false;
                                                    });
                                                    state.webViewController?.loadUrl(Constants.MANAGE_PAGE_SELLER_HELP_MENU);
                                                  },
                                                ),
                                                SideBarMenu(
                                                  title: isMobileDisplay ? "เล็ก" : "ใหญ่",
                                                  icon: isMobileDisplay ? Icons.mobile_friendly_rounded : Icons.desktop_windows,
                                                  onPressed: () {
                                                    state.webViewController?.loadUrl(isMobileDisplay ? Constants.MANAGE_PAGE_DESKTOP_MODE : Constants.MANAGE_PAGE_MOBILE_MODE);
                                                    setState(() {
                                                      isMobileDisplay = !isMobileDisplay;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          state.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Stack(),
                        ],
                      ),
                    ),
                    if (!showSearchBar)
                      CustomAppBar(
                          title: appBarTitle,
                          onOpenSideMenu: () {
                            setState(() {
                              isSwipeMenu = !isSwipeMenu;
                            });
                          },
                          onGoBack: () => context.read<ManageMenuBloc>().add(ManageMenuEventGoBack()),
                          onOpenSearch: () {
                            setState(() {
                              showSearchBar = true;
                            });
                          }),
                    if (showSearchBar)
                      SearchAppBar(
                        title: "ค้นหาเบอร์",
                        onClose: () {
                          setState(() {
                            showSearchBar = false;
                          });
                        },
                        onSearchSubmit: (text) {
                          state.webViewController?.loadUrl(text + "&device=native");
                        },
                      )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _handleJavacriptSendPhotoDataToFlutterChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'SendPhotoDataToFlutter',
        onMessageReceived: (JavascriptMessage message) {
          logger.d(message.message);
          TwoConfirmDialog(
            context: context,
            title: 'กรุณาเลือก',
            firstLabel: 'แก้ไข',
            secondLabel: 'แชร์',
            onPressFirstButton: () async {
              Navigator.pop(context);
              final phoneModel = phoneNumberFromJson(message.message);
              final webVC = context.read<ManageMenuBloc>().state.webViewController;
              webVC?.evaluateJavascript("editPhoneFromFlutter('${phoneModel.phone}', '${phoneModel.table_name}')");
            },
            onPressSecondButton: () async {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoute.studio, arguments: {"phoneNumberModel": phoneNumberFromJson(message.message)});
            },
          );
        });
  }

  _handleJavacriptSharePhotoToFlutterChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'SharePhoneToFlutter',
        onMessageReceived: (JavascriptMessage message) async {
          print(message.message);
          final multiNumbers = multiplePhoneNumberModelFromJson(message.message);
          // Navigator.pushNamed(context, AppRoute.studio, arguments: {"phoneNumberModel": multiNumbers.data[0]});

          String shareContent = "ร้าน${context.read<LoginBloc>().state.result?.branch_name}" +
              "\n" +
              "LINE: ${context.read<LoginBloc>().state.result?.branch_line_id}" +
              "\n" +
              "Tel: ${context.read<LoginBloc>().state.result?.branch_phone}" +
              "\n" +
              "https://www.berded.in.th/${context.read<LoginBloc>().state.result?.subdomain ?? context.read<LoginBloc>().state.result?.seller_id}" +
              "\n";

          String numberList = "";
          multiNumbers.data.forEach((item) {
            numberList = numberList + "${item.phone} (${item.sum}) (${item.operator?.toUpperCase()})\t ${FormatterConvert().currency(int.parse(item.price!))}.-\n";
          });

          shareContent = shareContent + numberList;
          Clipboard.setData(ClipboardData(text: shareContent));
          await ShareExtend.share(shareContent, "text");
        });
  }

  void _showAddOptionDlg(WebViewController? _webViewController) {
    TwoConfirmDialog(
      context: context,
      title: 'เพิ่ม 1 เบอร์ หรือหลายเบอร์',
      firstLabel: '1 เบอร์',
      secondLabel: 'หลายเบอร์',
      onPressFirstButton: () async {
        Navigator.pop(context);
        if (currentUrl.contains("multiPhone")) {
          _webViewController?.loadUrl(Constants.MANAGE_PAGE_DASHBOARD_MENU);
          await Future.delayed(Duration(seconds: 2));
        }
        _webViewController?.evaluateJavascript("addPhoneFromFlutter()");
      },
      onPressSecondButton: () async {
        Navigator.pop(context);
        _webViewController?.loadUrl("https://www.berded.in.th/portal/dashboard/multiPhone?action=add");
      },
    );
  }

  void changeAppBarTitle(String url) {
    if (url.contains('portal/profile')) {
      appBarTitle = "ข้อมูลส่วนตัว";
    } else if (url.contains('portal/config')) {
      appBarTitle = "ตั้งค่าร้านค้า";
    } else if (url.contains('portal/stat')) {
      appBarTitle = "สถิติ";
    } else if (url.contains('portal/email')) {
      appBarTitle = "อีเมล์";
    } else if (url.contains('portal/ems')) {
      appBarTitle = "แจ้ง EMS";
    } else if (url.contains('portal/articles')) {
      appBarTitle = "บทความ";
    } else if (url.contains('portal/payments')) {
      appBarTitle = "แจ้งชำระ";
    } else if (url.contains('portal/help')) {
      appBarTitle = "Help";
    } else {
      appBarTitle = "จัดการเบอร์";
    }
  }
}
