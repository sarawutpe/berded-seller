import 'dart:convert';

Email emailFromJson(String str) => Email.fromJson(json.decode(str));

String emailToJson(Email data) => json.encode(data.toJson());

class Email {
  Email({
    this.email,
  });

  String? email;

  factory Email.fromJson(Map<String, dynamic> json) => Email(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}