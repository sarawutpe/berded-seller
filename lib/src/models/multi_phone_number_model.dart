// To parse this JSON data, do
//
//     final multiplePhoneNumberModel = multiplePhoneNumberModelFromJson(jsonString);

import 'dart:convert';

import 'package:berded_seller/src/models/phone_number_model.dart';

MultiplePhoneNumberModel multiplePhoneNumberModelFromJson(String str) => MultiplePhoneNumberModel.fromJson(json.decode(str));

String multiplePhoneNumberModelToJson(MultiplePhoneNumberModel data) => json.encode(data.toJson());

class MultiplePhoneNumberModel {
  MultiplePhoneNumberModel({
    required this.data,
  });

  List<PhoneNumberModel> data;

  factory MultiplePhoneNumberModel.fromJson(Map<String, dynamic> json) => MultiplePhoneNumberModel(
    data: List<PhoneNumberModel>.from(json["data"].map((x) => PhoneNumberModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
