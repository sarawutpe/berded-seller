import 'dart:io';

import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/bloc/store_menu/store_menu_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/utils/webviewUtil.dart';
import 'package:berded_seller/src/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:provider/src/provider.dart';

class StoreMenuPage extends StatefulWidget {
  @override
  StoreMenuPageState createState() => StoreMenuPageState();
}

class StoreMenuPageState extends State<StoreMenuPage> {
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
    return WillPopScope(
      onWillPop: () async {
        context.read<StoreMenuBloc>().add(StoreMenuEventGoBack());
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
            child: BlocBuilder<StoreMenuBloc, StoreMenuState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                        color: Colors.white,
                        height: double.infinity,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            WebView(
                              onWebViewCreated: (controller) {
                                context.read<StoreMenuBloc>().add(StoreMenuEventInitial(controller));
                              },
                              initialUrl: 'https://www.berded.in.th/${context.read<LoginBloc>().state.result?.subdomain ?? context.read<LoginBloc>().state.result?.seller_id}',
                              javascriptMode: JavascriptMode.unrestricted,
                              onProgress: (int progress) {
                                print('WebView is loading (progress : $progress%)');
                                //Handle remove html on progress
                                final webviewController = context.read<StoreMenuBloc>().state.webViewController;
                                if (progress >= 1) {
                                  // header html
                                  runJavascript('document.querySelector(".navbar.navbar-fixed-top.navbar-custom").remove();', webVC: webviewController);

                                  // banner
                                  // if (Platform.isIOS) runJavascript('document.querySelector(".carousel-inner").remove();', webVC: webviewController);

                                  // search box
                                  if (Platform.isIOS) runJavascript('document.querySelector(".search-box").remove();', webVC: webviewController);

                                  // footer html
                                  runJavascript('document.getElementById("footer").remove(); document.getElementById("underfooter").remove();', webVC: webviewController);

                                  // footer cookie banner
                                  runJavascript('document.getElementById("cookit").remove();', webVC: webviewController);
                                }
                              },
                              javascriptChannels: <JavascriptChannel>{},
                              navigationDelegate: (NavigationRequest request) async {
                                // Handel prevent all http
                                if (request.url.startsWith('http:')) {
                                  return NavigationDecision.prevent;
                                }
                                // Handel prevent links.
                                if (!request.url.startsWith('https://www.berded.in.th/${context.read<LoginBloc>().state.result?.subdomain ?? context.read<LoginBloc>().state.result?.seller_id}')) {
                                  return NavigationDecision.prevent;
                                }
                                // Handle prevent external links.
                                List<String> blockUrl = const [
                                  "https://www.berded.in.th/login/",
                                  "https://www.berded.in.th/seller/register.php",
                                ];
                                for (var i = 0; i < blockUrl.length; i++) {
                                  if (request.url.startsWith(blockUrl[i])) {
                                    return NavigationDecision.prevent;
                                  }
                                }
                                // Handle tel popup.
                                if (request.url.startsWith('tel:')) {
                                  // await launch('${request.url}');
                                  return NavigationDecision.prevent;
                                }

                                return NavigationDecision.navigate;
                              },
                              onPageStarted: (String url) {
                                print('Page started loading: $url');
                                context.read<StoreMenuBloc>().add(StoreMenuEventSetLoading(isLoading: true));
                              },
                              onPageFinished: (String url) {
                                print('Page finished loading: $url');
                                context.read<StoreMenuBloc>().add(StoreMenuEventSetLoading(isLoading: false));
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
                    CustomAppBar(
                      title: 'หน้าร้าน',
                      onGoHome: () async {
                        state.webViewController?.loadUrl('https://www.berded.in.th/${context.read<LoginBloc>().state.result?.subdomain ?? context.read<LoginBloc>().state.result?.seller_id}');
                        await state.webViewController?.scrollTo(0, 0);
                      },
                      onGoBack: () => context.read<StoreMenuBloc>().add(StoreMenuEventGoBack()),
                      onGoForward: () {
                        final webViewController = state.webViewController;
                        webViewController?.goForward();
                      },
                      onReload: () {
                        final webViewController = state.webViewController;
                        webViewController?.reload();
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
