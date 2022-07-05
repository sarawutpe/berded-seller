import 'dart:io';

import 'package:berded_seller/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/pages/forgot_password/widgets/forgot_password_app_bar.dart';
import 'package:berded_seller/src/utils/webviewUtil.dart';
import 'package:berded_seller/src/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
        context.read<ForgotPasswordBloc>().add(ForgotPasswordEventGoBack());
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
            child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            WebView(
                              onWebViewCreated: (controller) {
                                context.read<ForgotPasswordBloc>().add(ForgotPasswordEventInitial(controller));
                              },
                              initialUrl: 'https://www.berded.in.th/forgot_password/?device=${Platform.isIOS ? 'ios' : 'android'}',
                              javascriptMode: JavascriptMode.unrestricted,
                              onProgress: (int progress) {
                                //Handle remove html on progress
                                final webviewController = context.read<ForgotPasswordBloc>().state.webViewController;
                                if (progress > 1) {
                                  // footer html
                                  runJavascript('document.querySelector(".row.box_footer").remove();', webVC: webviewController);

                                  // footer cookie banner
                                  runJavascript('document.getElementById("cookit").remove();', webVC: webviewController);
                                }

                                print('WebView is loading (progress : $progress%)');
                              },
                              javascriptChannels: <JavascriptChannel>{},
                              navigationDelegate: (NavigationRequest request) async {
                                // Handel prevent all http
                                if (request.url.startsWith('http:')) {
                                  return NavigationDecision.prevent;
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
                                context.read<ForgotPasswordBloc>().add(ForgotPasswordEventSetLoading(isLoading: true));
                              },
                              onPageFinished: (String url) {
                                print('Page finished loading: $url');
                                context.read<ForgotPasswordBloc>().add(ForgotPasswordEventSetLoading(isLoading: false));
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
                    ForgotPasswordAppBar(
                      title: 'ลืมรหัสผ่าน',
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
