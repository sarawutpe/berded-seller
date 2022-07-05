// To parse this JSON data, do
//
//     final authorizedBranches = authorizedBranchesFromJson(jsonString);

import 'dart:convert';

List<AuthorizedBranch> authorizedBranchesFromJson(String str) => List<AuthorizedBranch>.from(json.decode(str).map((x) => AuthorizedBranch.fromJson(x)));

String authorizedBranchesToJson(List<AuthorizedBranch> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorizedBranch {
  AuthorizedBranch({
    required this.email,
    required this.sellerId,
    required this.jwt,
  });

  String email;
  String sellerId;
  String jwt;

  factory AuthorizedBranch.fromJson(Map<String, dynamic> json) => AuthorizedBranch(
    email: json["email"],
    sellerId: json["seller_id"],
    jwt: json["jwt"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "seller_id": sellerId,
    "jwt": jwt,
  };
}
