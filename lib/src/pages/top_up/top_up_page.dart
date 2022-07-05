import 'dart:io';

import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/bloc/top_up/top_up_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/utils/webviewUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../../app.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  int _currentSelection = 0;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: ThemeColors.lightPrimary,
        child: SafeArea(
          left: false,
          right: false,
          bottom: false,
          child: BlocBuilder<TopUpBloc, TopUpState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      color: Colors.white,
                      height: double.infinity,
                      width: double.infinity,
                      child: Stack(
                        children: [
                           WebView(
                            onWebViewCreated: (controller) {
                              Map<String, String> headers = {"Authorization": "Bearer " + context.read<LoginBloc>().state.result!.token};
                              controller.loadUrl("https://www.berded.in.th/login/?username=login", headers: headers);
                              context.read<TopUpBloc>().add(TopUpEventInitial(controller));
                            },
                             initialUrl: 'https://www.berded.in.th/login/?username=login',
                            javascriptMode: JavascriptMode.unrestricted,
                            onProgress: (int progress) {
                              print('WebView is loading (progress : $progress%)');
                              //Handle remove html on progress
                              final webviewController = context.read<TopUpBloc>().state.webViewController;
                              if (progress > 1) {
                                // ขอแนะนำให้ใช้งานผ่าน Google Chrome
                                runJavascript('document.querySelector(".alert.alert-info.text-center").remove();', webVC: webviewController);
                                // teamViewer quickSupport
                                runJavascript('document.querySelector(".col-xs-12.col-sm-12.col-md-12.col-lg-12.text-center").remove();', webVC: webviewController);
                                // footer html
                                runJavascript('document.querySelector(".page-prefooter").remove(); document.querySelector(".page-footer").remove();', webVC: webviewController);
                                runJavascript('document.querySelector(".row.box_footer").remove();', webVC: webviewController);
                                runJavascript('document.querySelector("#footer").remove();', webVC: webviewController);
                                // footer packages
                                runJavascript('document.querySelector(".navbar.navbar-fixed-top.navbar-custom").remove();', webVC: webviewController);

                                // footer cookie banner
                                runJavascript('document.getElementById("cookit").remove();', webVC: webviewController);

                              }
                            },
                            javascriptChannels: <JavascriptChannel>{},
                            navigationDelegate: (NavigationRequest request) async {
                              // Handel prevent all http
                              // if (request.url.startsWith('http:')) {
                              //   return NavigationDecision.prevent;
                              // }
                              // // Handel prevent links.
                              // if (!request.url.startsWith('https://www.berded.in.th/portal/payments/')) {
                              //   return NavigationDecision.prevent;
                              // }
                              // // Handle prevent external links.
                              // List<String> blockUrl = const [
                              //   "https://www.berded.in.th/login/",
                              //   "https://www.berded.in.th/seller/register.php",
                              // ];
                              // for (var i = 0; i < blockUrl.length; i++) {
                              //   if (request.url.startsWith(blockUrl[i])) {
                              //     return NavigationDecision.prevent;
                              //   }
                              // }
                              // // Handle tel popup.
                              // if (request.url.startsWith('tel:')) {
                              //   // await launch('${request.url}');
                              //   return NavigationDecision.prevent;
                              // }
                              return NavigationDecision.navigate;
                            },
                            onPageStarted: (String url) {
                              print('Page started loading: $url');
                              context.read<TopUpBloc>().add(TopUpEventSetLoading(isLoading: true));
                            },
                            onPageFinished: (String url) {
                              logger.d('=> $url');
                              print('Page finished loading: $url');
                              context.read<TopUpBloc>().add(TopUpEventSetLoading(isLoading: false));
                              if (!url.contains("payments") && !url.contains("login") && !url.contains("package")){
                                // https://www.berded.in.th/package.php
                                context.read<TopUpBloc>().state.webViewController?.loadUrl("https://www.berded.in.th/portal/payments/");
                              }
                            },
                            gestureNavigationEnabled: true,

                          ),
                          state.isLoading
                              ? Center(
                            child: CircularProgressIndicator(),
                          )
                              : Stack(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    child: AppBar(
                      backgroundColor: ThemeColors.lightPrimary,
                      centerTitle: true,
                      title: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: MaterialSegmentedControl<int>(
                                children: _buildSegmentedMenu,
                                selectionIndex: _currentSelection,
                                borderColor: Colors.grey,
                                selectedColor: Colors.white,
                                unselectedColor: ThemeColors.lightPrimary,
                                borderRadius: 10.0,
                                onSegmentChosen: (index) {
                                  setState(() {
                                    _currentSelection = index;
                                    if (_currentSelection == 0) {
                                      context.read<TopUpBloc>().state.webViewController?.loadUrl("https://www.berded.in.th/portal/payments/");
                                    } else {
                                      context.read<TopUpBloc>().state.webViewController?.loadUrl("https://www.berded.in.th/package.php");
                                    }
                                  });
                                },
                              ),
                            ),
                            // _buildSegmentContent(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  Map<int, Widget> _buildSegmentedMenu = {
    0: Padding(padding: EdgeInsets.only( left: 16, right: 16), child: Text('ชำระเงิน', style: TextStyle(fontSize: 16))),
    1: Padding(padding: EdgeInsets.only(left: 16, right: 16), child: Text('แพ็กเกจ', style: TextStyle(fontSize: 16))),
  };
}



