import 'dart:convert';

PhoneNumberModel phoneNumberFromJson(String str) => PhoneNumberModel.fromJson(json.decode(str));

String numberToJson(PhoneNumberModel data) => json.encode(data.toJson());

class PhoneNumberModel {
  PhoneNumberModel({
    this.phone,
    this.price,
    this.operator,
    this.sum,
    this.descrption,
    this.table_name,
  });

  String? phone;
  String? price;
  String? operator;
  String? sum;
  String? descrption;
  String? table_name;

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) => PhoneNumberModel(
    phone: json["phone"],
    price: json["price"],
    sum: json["sum"],
    operator: json["operator"],
    descrption: json["descrption"],
    table_name: json["table_name"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "price": price,
    "sum": sum,
    "operator": operator,
    "descrption": descrption,
    "table_name": table_name,
  };
}