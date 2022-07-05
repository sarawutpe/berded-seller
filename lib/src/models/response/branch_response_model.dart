// To parse this JSON data, do
//
//     final myBranchesResponse = myBranchesResponseFromJson(jsonString);

import 'dart:convert';

List<MyBranchesResponse> myBranchesResponseFromJson(String str) => List<MyBranchesResponse>.from(json.decode(str).map((x) => MyBranchesResponse.fromJson(x)));

String myBranchesResponseToJson(List<MyBranchesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBranchesResponse {
  MyBranchesResponse({
    required this.email,
    required this.sellerId,
    required this.branchName,
    required this.branchPhone,
    required this.branchLineId,
    required this.branchAvatar,
    required this.expired,
    required this.status,
    required this.subdomain,
    this.isAuth,
  });

  String email;
  String sellerId;
  String branchName;
  String branchPhone;
  String branchLineId;
  String branchAvatar;
  String expired;
  String status;
  String subdomain;
  bool? isAuth;
  

  factory MyBranchesResponse.fromJson(Map<String, dynamic> json) => MyBranchesResponse(
    email: json["email"],
    sellerId: json["seller_id"],
    branchName: json["branch_name"],
    branchPhone: json["branch_phone"],
    branchLineId: json["branch_line_id"],
    branchAvatar: json["branch_avatar"],
    expired: json["expired"],
    status: json["status"],
    subdomain: json["subdomain"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "seller_id": sellerId,
    "branch_name": branchName,
    "branch_phone": branchPhone,
    "branch_line_id": branchLineId,
    "branch_avatar": branchAvatar,
    "expired": expired,
    "status": status,
    "subdomain": subdomain,
  };

  @override
  String toString() {
    // TODO: implement toString
    return '''email: $email, seller_id: $sellerId, branch_name: $branchName, branch_avatar: $branchAvatar''';
  }
}
