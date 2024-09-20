// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Shop shopFromJson(String str) => Shop.fromJson(json.decode(str));

String shopToJson(Shop data) => json.encode(data.toJson());

class Shop {
  String message;

  Shop({
    required this.message,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
