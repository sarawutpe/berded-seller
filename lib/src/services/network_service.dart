import 'dart:convert';
import 'dart:math';

import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/constants/api_path.dart';
import 'package:berded_seller/src/models/response/branch_response_model.dart';
import 'package:berded_seller/src/models/response/login_response_model.dart';
import 'package:berded_seller/src/models/seller_model.dart';
import 'package:berded_seller/src/models/user_model.dart';
import 'package:berded_seller/src/services/interceptors.dart';
import 'package:dio/dio.dart';

class NetworkService {
  NetworkService._internal();
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;

  // NOTE: Interceptors.
  static final Dio _dio = Dio()
    ..interceptors.add(
      AppInterceptors(),
    );

  // NOTE: Login service.
  Future<LoginResponse> login(User payload) async {
      final response = await _dio.post(NetworkAPI.login, data: payload);
      if (response.statusCode == 200) return loginResponseFromJson(jsonEncode(response.data));
      throw Exception();
  }

  // NOTE: getCurrentBranch service.
  Future<LoginResponse> getCurrentBranch() async {
    final response = await _dio.get(NetworkAPI.selected_branches);
    if (response.statusCode == 200) return loginResponseFromJson(jsonEncode(response.data));
    throw Exception();
  }

  //  NOTE: Fetch branches service.
  Future<List<MyBranchesResponse>> branches() async {
    final response = await _dio.get('${NetworkAPI.branches}');
    logger.d(response);
    if (response.statusCode == 200) return myBranchesResponseFromJson(jsonEncode(response.data));
    throw Exception();
  }
}
