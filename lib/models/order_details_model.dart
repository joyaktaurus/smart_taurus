// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  String message;
  List<Detail> details;
  List<Order> order;

  OrderDetailsModel({
    required this.message,
    required this.details,
    required this.order,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    message: json["message"],
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "details": List<dynamic>.from(details!.map((x) => x.toJson())),
    "order": List<dynamic>.from(order!.map((x) => x.toJson())),
  };
}

class Detail {
  int? id;
  String? orderId;
  String? intShopId;
  dynamic intShopVisitId;
  String? productName;
  String? productQuantity;
  DateTime? createdAt;
  String? updatedAt;
  String? amount;
  String? productId;
  String? imageurl;

  Detail({
    this.id,
    this.orderId,
    this.intShopId,
    this.intShopVisitId,
    this.productName,
    this.productQuantity,
    this.createdAt,
    this.updatedAt,
    this.amount,
    this.productId,
    this.imageurl,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    orderId: json["order_id"],
    intShopId: json["int_shop_id"],
    intShopVisitId: json["int_shop_visit_id"],
    productName: json["product_name"],
    productQuantity: json["product_quantity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    amount: json["amount"],
    productId: json["product_id"],
    imageurl: json["imageurl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "int_shop_id": intShopId,
    "int_shop_visit_id": intShopVisitId,
    "product_name": productName,
    "product_quantity": productQuantity,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt,
    "amount": amount,
    "product_id": productId,
    "imageurl": imageurl,
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
  DateTime? createdAt;
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
