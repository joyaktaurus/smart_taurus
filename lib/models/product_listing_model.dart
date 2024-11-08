// To parse this JSON data, do
//
//     final productListingModel = productListingModelFromJson(jsonString);

import 'dart:convert';

ProductListingModel productListingModelFromJson(String str) =>
    ProductListingModel.fromJson(json.decode(str));

String productListingModelToJson(ProductListingModel data) =>
    json.encode(data.toJson());

class ProductListingModel {
  String? message;
  List<ProductListing>? shop;

  ProductListingModel({
    this.message,
    this.shop,
  });

  factory ProductListingModel.fromJson(Map<String, dynamic> json) =>
      ProductListingModel(
        message: json["message"],
        shop: List<ProductListing>.from(
            json["shop"].map((x) => ProductListing.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "shop": List<dynamic>.from(shop!.map((x) => x.toJson())),
      };
}

class ProductListing {
  String? productId;
  String? productName;
  String? productDescription;
  String? price;
  String? image;
  String? categoryId;
  String? status;
  String? imageurl;
  int quantity;
  String? categoryName;

  ProductListing({
    this.productId,
    this.productName,
    this.productDescription,
    this.price,
    this.image,
    this.categoryId,
    this.status,
    this.imageurl,
    this.categoryName,
    this.quantity = 0, // Initialize with 0
  });

  factory ProductListing.fromJson(Map<String, dynamic> json) => ProductListing(
    productId: json["product_id"],
    productName: json["product_name"],
    productDescription: json["product_description"],
    price: json["price"],
    categoryId: json["category_id"],
    image: json["image"],
    status: json["status"],
    categoryName: json["category_name"],
    imageurl: json["imageurl"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_description": productDescription,
    "price": price,
    "category_id": categoryId,
    "image": image,
    "status": status,
    "category_name": categoryName,
    "imageurl": imageurl,
  };
}
