// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:berded_seller/src/utils/Util.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.result,
    required this.token,
    required this.error,
    required this.username,
    required this.seller_id,
    required this.branch_name,
    required this.branch_phone,
    required this.branch_line_id,
    required this.branch_avatar,
    required this.branch_banner,
    required this.expired,
    required this.package_id,
    required this.total_number,
    required this.status,
    required this.subdomain,
    required this.rating,
    required this.count_berded,
    required this.count_recommend,
    required this.certified,
  });

  String result;
  String token;
  String error;
  String username;
  String seller_id;
  String branch_name;
  String branch_phone;
  String branch_line_id;
  String branch_avatar;
  String branch_banner;
  String expired;
  int package_id;
  int total_number;
  String status;
  String subdomain;
  double rating;
  int count_berded;
  int count_recommend;
  bool certified;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        result: json["result"],
        token: json["token"],
        error: json["error"],
        username: json["username"],
        seller_id: json["seller_id"],
        branch_name: json["branch_name"],
        branch_phone: json["branch_phone"],
        branch_line_id: json["branch_line_id"],
        branch_avatar: json["branch_avatar"],
        branch_banner: json["branch_banner"],
        expired: json["expired"],
        package_id: json["package_id"] ?? 0,
        total_number: json["total_number"],
        status: json["status"],
        subdomain: json["subdomain"],
        rating: forceToDouble(json['rating']),
        count_berded: json['count_berded'],
        count_recommend: json['count_recommend'],
        certified: json['certified'],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "token": token,
        "error": error,
        "username": username,
        "seller_id": seller_id,
        "branch_name": branch_name,
        "branch_phone": branch_phone,
        "branch_line_id": branch_line_id,
        "branch_avatar": branch_avatar,
        "branch_banner": branch_banner,
        "expired": expired,
        "package_id": package_id,
        "total_number": total_number,
        "status": status,
        "subdomain": subdomain,
        "rating": rating,
        "count_berded": count_berded,
        "count_recommend": count_recommend,
        "certified": certified,
      };

  @override
  String toString() {
    // TODO: implement toString
    return '''{result: $result,\ 
    token: $token,\ 
    error: $error,\
    username: $username,\ 
    seller_id: $seller_id,\ 
    branch_name: $branch_name,\ 
    branch_avatar: $branch_avatar,\ 
    branch_banner: $branch_banner,\ 
    expired: $expired,\ 
    total_number: $total_number,\
    status: $status,\
    subdomain: $subdomain,\
    rating: $rating,\
    count_berded: $count_berded,\
    count_recommend: $count_recommend,\
    certified: $certified}''';
  }
}

