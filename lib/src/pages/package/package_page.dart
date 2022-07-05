import 'dart:io';

import 'package:berded_seller/src/bloc/login/login_bloc.dart';
import 'package:berded_seller/src/bloc/top_up/top_up_bloc.dart';
import 'package:berded_seller/src/constants/app_theme.dart';
import 'package:berded_seller/src/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

import '../../app.dart';

class PackagePage extends StatefulWidget {
  const PackagePage({Key? key}) : super(key: key);

  @override
  _PackagePageState createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {

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
        context.read<TopUpBloc>().add(TopUpEventGoBack());
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
                                  webviewController?.evaluateJavascript('document.querySelector(".alert.alert-info.text-center").remove();');
                                  // teamViewer quickSupport
                                  webviewController?.evaluateJavascript('document.querySelector(".col-xs-12.col-sm-12.col-md-12.col-lg-12.text-center").remove();');
                                  // footer html
                                  webviewController?.evaluateJavascript('document.querySelector(".page-prefooter").remove(); document.querySelector(".page-footer").remove();');
                                  webviewController?.evaluateJavascript('document.querySelector(".row.box_footer").remove();');
                                }
                              },
                              javascriptChannels: <JavascriptChannel>{},
                              navigationDelegate: (NavigationRequest request) async {
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
                                  context.read<TopUpBloc>().state.webViewController?.loadUrl("https://www.berded.in.th/package.php/");
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
                    CustomAppBar(
                      title: 'แจ้งชำระเงิน',
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
