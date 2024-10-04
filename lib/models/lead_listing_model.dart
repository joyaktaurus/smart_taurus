// To parse this JSON data, do
//
//     final leadListing = leadListingFromJson(jsonString);

import 'dart:convert';

// LeadListing leadListingFromJson(String str) => LeadListing.fromJson(json.decode(str));
//
// String leadListingToJson(LeadListing data) => json.encode(data.toJson());
//
// class LeadListing {
//   String? message;
//   List<ShopElement>? leads;
//
//   LeadListing({
//     this.message,
//     this.leads,
//   });
//
//   factory LeadListing.fromJson(Map<String, dynamic> json) => LeadListing(
//     message: json["message"],
//     leads: List<ShopElement>.from(json["shop"].map((x) => ShopElement.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "shop": List<dynamic>.from(leads!.map((x) => x.toJson())),
//   };
// }
//
// class ShopElement {
//   int? id;
//   String? shopId;
//   String? createdBy;
//   String? title;
//   String? note;
//   dynamic status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   ShopShop? shop;
//
//   ShopElement({
//     this.id,
//     this.shopId,
//     this.createdBy,
//     this.title,
//     this.note,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.shop,
//   });
//
//   factory ShopElement.fromJson(Map<String, dynamic> json) => ShopElement(
//     id: json["id"],
//     shopId: json["shop_id"],
//     createdBy: json["created_by"],
//     title: json["title"],
//     note: json["note"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     shop: ShopShop.fromJson(json["shop"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "shop_id": shopId,
//     "created_by": createdBy,
//     "title": title,
//     "note": note,
//     "status": status,
//     "created_at": createdAt!.toIso8601String(),
//     "updated_at": updatedAt!.toIso8601String(),
//     "shop": shop!.toJson(),
//   };
// }
//
// class ShopShop {
//   String? intShopId;
//   String? shopName;
//   String? customerName;
//   String? phoneNumber;
//   String? strEmail;
//   String? addressLine1;
//   String? organization;
//   String? gstNumber;
//   dynamic pancard;
//   dynamic categoryInfo;
//   dynamic budgetInfo;
//   dynamic brandInfo;
//   String? strInstructions;
//   dynamic createdBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   ShopShop({
//     this.intShopId,
//     this.shopName,
//     this.customerName,
//     this.phoneNumber,
//     this.strEmail,
//     this.addressLine1,
//     this.organization,
//     this.gstNumber,
//     this.pancard,
//     this.categoryInfo,
//     this.budgetInfo,
//     this.brandInfo,
//     this.strInstructions,
//     this.createdBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory ShopShop.fromJson(Map<String, dynamic> json) => ShopShop(
//     intShopId: json["int_shop_id"],
//     shopName: json["shop_name"],
//     customerName: json["customer_name"],
//     phoneNumber: json["phone_number"],
//     strEmail: json["str_email"],
//     addressLine1: json["address_line1"],
//     organization: json["organization"],
//     gstNumber: json["gst_number"],
//     pancard: json["pancard"],
//     categoryInfo: json["category_info"],
//     budgetInfo: json["budget_info"],
//     brandInfo: json["brand_info"],
//     strInstructions: json["str_instructions"],
//     createdBy: json["created_by"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "int_shop_id": intShopId,
//     "shop_name": shopName,
//     "customer_name": customerName,
//     "phone_number": phoneNumber,
//     "str_email": strEmail,
//     "address_line1": addressLine1,
//     "organization": organization,
//     "gst_number": gstNumber,
//     "pancard": pancard,
//     "category_info": categoryInfo,
//     "budget_info": budgetInfo,
//     "brand_info": brandInfo,
//     "str_instructions": strInstructions,
//     "created_by": createdBy,
//     "created_at": createdAt!.toIso8601String(),
//     "updated_at": updatedAt!.toIso8601String(),
//   };
// }


class LeadListing {
  String? message;
  List<Leads>? leads;

  LeadListing({this.message, this.leads});

  LeadListing.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['leads'] != null) {
      leads = <Leads>[];
      json['leads'].forEach((v) {
        leads!.add(new Leads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.leads != null) {
      data['leads'] = this.leads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leads {
  int? id;
  String? shopId;
  String? createdBy;
  String? title;
  String? note;
  String? status;
  String? createdAt;
  String? updatedAt;
  ShopShop? shop;

  Leads(
      {this.id,
        this.shopId,
        this.createdBy,
        this.title,
        this.note,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.shop});

  Leads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    createdBy = json['created_by'];
    title = json['title'];
    note = json['note'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shop = json['shop'] != null ? new ShopShop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['created_by'] = this.createdBy;
    data['title'] = this.title;
    data['note'] = this.note;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    return data;
  }
}

class ShopShop {
  String? intShopId;
  String? shopName;
  String? customerName;
  String? phoneNumber;
  String? strEmail;
  String? addressLine1;
  String? organization;
  String? gstNumber;
  String? pancard;
  String? categoryInfo;
  String? budgetInfo;
  String? brandInfo;
  String? strInstructions;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  ShopShop(
      {this.intShopId,
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
        this.updatedAt});

  ShopShop.fromJson(Map<String, dynamic> json) {
    intShopId = json['int_shop_id'];
    shopName = json['shop_name'];
    customerName = json['customer_name'];
    phoneNumber = json['phone_number'];
    strEmail = json['str_email'];
    addressLine1 = json['address_line1'];
    organization = json['organization'];
    gstNumber = json['gst_number'];
    pancard = json['pancard'];
    categoryInfo = json['category_info'];
    budgetInfo = json['budget_info'];
    brandInfo = json['brand_info'];
    strInstructions = json['str_instructions'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['int_shop_id'] = this.intShopId;
    data['shop_name'] = this.shopName;
    data['customer_name'] = this.customerName;
    data['phone_number'] = this.phoneNumber;
    data['str_email'] = this.strEmail;
    data['address_line1'] = this.addressLine1;
    data['organization'] = this.organization;
    data['gst_number'] = this.gstNumber;
    data['pancard'] = this.pancard;
    data['category_info'] = this.categoryInfo;
    data['budget_info'] = this.budgetInfo;
    data['brand_info'] = this.brandInfo;
    data['str_instructions'] = this.strInstructions;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
