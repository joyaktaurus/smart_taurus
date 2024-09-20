class CustomerList {
  String? message;
  List<Shop>? shop;

  CustomerList({this.message, this.shop});

  CustomerList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['shop'] != null) {
      shop = <Shop>[];
      json['shop'].forEach((v) {
        shop!.add(new Shop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.shop != null) {
      data['shop'] = this.shop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shop {
  String? intShopId;
  String? shopName;
  String? customerName;
  String? phoneNumber;
  String? strEmail;
  String? addressLine1;
  String? addressLine2;
  String? pincode;
  String? strInstructions;
  String? createdAt;
  String? updatedAt;

  Shop(
      {this.intShopId,
        this.shopName,
        this.customerName,
        this.phoneNumber,
        this.strEmail,
        this.addressLine1,
        this.addressLine2,
        this.pincode,
        this.strInstructions,
        this.createdAt,
        this.updatedAt});

  Shop.fromJson(Map<String, dynamic> json) {
    intShopId = json['int_shop_id'];
    shopName = json['shop_name'];
    customerName = json['customer_name'];
    phoneNumber = json['phone_number'];
    strEmail = json['str_email'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    pincode = json['pincode'];
    strInstructions = json['str_instructions'];
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
    data['address_line2'] = this.addressLine2;
    data['pincode'] = this.pincode;
    data['str_instructions'] = this.strInstructions;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
