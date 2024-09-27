// To parse this JSON data, do
//
//     final submitOrder = submitOrderFromJson(jsonString);

import 'dart:convert';

SubmitOrder submitOrderFromJson(String str) => SubmitOrder.fromJson(json.decode(str));

String submitOrderToJson(SubmitOrder data) => json.encode(data.toJson());

class SubmitOrder {
  String? message;

  SubmitOrder({
    this.message,
  });

  factory SubmitOrder.fromJson(Map<String, dynamic> json) => SubmitOrder(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
