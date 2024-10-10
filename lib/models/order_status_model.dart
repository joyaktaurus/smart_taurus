// To parse this JSON data, do
//
//     final orderStatusModel = orderStatusModelFromJson(jsonString);

import 'dart:convert';

OrderStatusModel orderStatusModelFromJson(String str) => OrderStatusModel.fromJson(json.decode(str));

String orderStatusModelToJson(OrderStatusModel data) => json.encode(data.toJson());

class OrderStatusModel {
  String? message;
  List<Order>? orders;

  OrderStatusModel({
    this.message,
    this.orders,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) => OrderStatusModel(
    message: json["message"],
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  int? id;
  String? shopId;
  String? createdBy;
  String? status;
  String? total;
  DateTime? createdAt;
  DateTime? updatedAt;
  Shop? shop;

  Order({
    this.id,
    this.shopId,
    this.createdBy,
    this.status,
    this.total,
    this.createdAt,
    this.updatedAt,
    this.shop,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    shopId: json["shop_id"],
    createdBy: json["created_by"],
    status: json["status"],
    total: json["total"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    shop: Shop.fromJson(json["shop"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "created_by": createdBy,
    "status": status,
    "total": total,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "shop": shop!.toJson(),
  };
}

class Shop {
  String? intShopId;
  String? shopName;
  String? customerName;
  String? phoneNumber;
  String? strEmail;
  String? addressLine1;
  String? organization;
  String? gstNumber;
  dynamic pancard;
  dynamic categoryInfo;
  dynamic budgetInfo;
  dynamic brandInfo;
  String? strInstructions;
  dynamic createdBy;
  DateTime ?createdAt;
  DateTime? updatedAt;

  Shop({
    this.intShopId,
    this.shopName,
    this.customerName,
    this.phoneNumber,
    this.strEmail,
    this.addressLine1,
    this.organization,
    this.gstNumber,
    this.pancard,
    this.categoryInfo,
    this.budgetInfo,
    this.brandInfo,
    this.strInstructions,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    intShopId: json["int_shop_id"],
    shopName: json["shop_name"],
    customerName: json["customer_name"],
    phoneNumber: json["phone_number"],
    strEmail: json["str_email"],
    addressLine1: json["address_line1"],
    organization: json["organization"],
    gstNumber: json["gst_number"],
    pancard: json["pancard"],
    categoryInfo: json["category_info"],
    budgetInfo: json["budget_info"],
    brandInfo: json["brand_info"],
    strInstructions: json["str_instructions"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "int_shop_id": intShopId,
    "shop_name": shopName,
    "customer_name": customerName,
    "phone_number": phoneNumber,
    "str_email": strEmail,
    "address_line1": addressLine1,
    "organization": organization,
    "gst_number": gstNumber,
    "pancard": pancard,
    "category_info": categoryInfo,
    "budget_info": budgetInfo,
    "brand_info": brandInfo,
    "str_instructions": strInstructions,
    "created_by": createdBy,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
