// To parse this JSON data, do
//
//     final customerDetail = customerDetailFromJson(jsonString);

import 'dart:convert';

CustomerDetail customerDetailFromJson(String str) => CustomerDetail.fromJson(json.decode(str));

String customerDetailToJson(CustomerDetail data) => json.encode(data.toJson());

class CustomerDetail {
  String? message;
  List<Shopp>? shop;

  CustomerDetail({
    this.message,
    this.shop,
  });

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
    message: json["message"],
    shop: List<Shopp>.from(json["shop"].map((x) => Shopp.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "shop": List<dynamic>.from(shop!.map((x) => x.toJson())),
  };
}

class Shopp {
  String? intShopId;
  String? shopName;
  String? customerName;
  String? phoneNumber;
  String? strEmail;
  dynamic addressLine1;
  String? organization;
  String? gstNumber;
  String? pancard;
  String? categoryInfo;
  String? budgetInfo;
  String? brandInfo;
  String? shopImage;
  String? strInstructions;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Shopp({
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
    this.shopImage,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Shopp.fromJson(Map<String, dynamic> json) => Shopp(
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
    shopImage: json["shop_image"],
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
    "shop_image": shopImage,
    "created_by": createdBy,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
