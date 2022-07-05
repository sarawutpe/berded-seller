
import 'package:berded_seller/src/app.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

runJavascript(String script, {WebViewController? webVC}){
  try {
    webVC?.evaluateJavascript(script);
  }catch(e){
    logger.e(e.toString());
  }
}