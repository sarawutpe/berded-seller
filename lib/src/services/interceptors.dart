import 'package:berded_seller/src/constants/api_path.dart';
import 'package:berded_seller/src/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO: implement onRequest
    options.connectTimeout = 5000;
    options.receiveTimeout = 5000;
    options.headers['content-Type'] = 'application/json';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Constants.ACCESS_TOKEN);
    if (token != null && token != '') {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.baseUrl = NetworkAPI.baseURL;
    super.onRequest(options, handler);
  }

  @override
  Future<dynamic> onResponse(Response response, ResponseInterceptorHandler handler) async {
    // TODO: implement onResponse
    // switch (response.statusCode) {
    //   case 301:
    //     break;
    //   case 401:
    //     break;
    //   default:
    // }
    return super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    // TODO: implement onError
    return super.onError(err, handler);
  }

}