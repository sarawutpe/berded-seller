// To parse this JSON data, do
//
//     final studioResponse = studioResponseFromJson(jsonString);

import 'dart:convert';

StudioResponse studioResponseFromJson(String str) => StudioResponse.fromJson(json.decode(str));

String studioResponseToJson(StudioResponse data) => json.encode(data.toJson());

class StudioResponse {
  StudioResponse({
    required this.number,
    required this.price,
  });

  String number;
  String price;

  factory StudioResponse.fromJson(Map<String, dynamic> json) => StudioResponse(
        number: json["number"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "price": price,
      };

  @override
  String toString() {
    // TODO: implement toString
    return 'number: $number, price: $price';
  }
}
