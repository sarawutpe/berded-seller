import 'dart:convert';

Seller sellerFromJson(String str) => Seller.fromJson(json.decode(str));

String sellerToJson(Seller data) => json.encode(data.toJson());

class Seller {
  Seller({
    this.seller,
  });

  String? seller;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    seller: json["seller"],
  );

  Map<String, dynamic> toJson() => {
    "seller": seller,
  };
}