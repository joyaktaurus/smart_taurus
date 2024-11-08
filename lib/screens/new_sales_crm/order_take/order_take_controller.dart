import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../app.dart';
import '../../../models/api_resp.dart';
import '../../../models/customer_list_model.dart';
import '../../../models/product_listing_model.dart';
import '../../../services/add_order_submit_services.dart';
import '../../../services/customerlist_services.dart';
import '../../../utils/my_theme.dart';

class OrderTakeController extends GetxController {
  var products = <ProductListing>[].obs; // Observable list to hold products
  var productIds = <String>[].obs; // Observable list to hold product IDs
  RxString selectedShop = ''.obs; // To hold the selected shop ID

  RxList<Shop> customerData = <Shop>[].obs;
  RxBool isScreenProgress = true.obs;
  RxBool showDropdown = false.obs; // To control the visibility of the dropdown

  // final String productName; // Declare productName as final
  RxDouble finalAmount = 0.0.obs; // Observable for final amount

  // // Initialize productName and finalAmount in the constructor
  // AddOrderController({required this.productName, required double finalAmount}) {
  //   this.finalAmount.value = finalAmount; // Assign the initial value to RxDouble
  // }
 // var products = <ProductListing>[].obs;

  // Update this method to get a controller for each product
  TextEditingController getTextEditingController(ProductListing product) {
    return TextEditingController(
      text: product.quantity.toString(),
    );
  }

  void countIncrement(ProductListing product, TextEditingController controller) {
    product.quantity++; // Increment the quantity
    controller.text = product.quantity.toString(); // Update the TextField
    updateFinalAmount(); // Update the final amount
    products.refresh(); // Refresh the list to update the UI
  }

  void countDecrement(ProductListing product, TextEditingController controller) {
    if (product.quantity > 1) {
      product.quantity--; // Decrease the quantity
      controller.text = product.quantity.toString(); // Update the TextField
      updateFinalAmount(); // Update the final amount
      products.refresh(); // Refresh the list to update the UI
    }
  }
  // // Increment product quantity
  // void countIncrement(ProductListing product) {
  //   product.quantity++; // Increment the quantity
  //   updateFinalAmount(); // Update the final amount
  //   products.refresh(); // Refresh the list to update UI
  // }
  //
  // // Decrement product quantity
  // void countDecrement(ProductListing product) {
  //   if (product.quantity > 1) {
  //     product.quantity--; // Decrease the quantity
  //     updateFinalAmount(); // Update the final amount
  //     products.refresh(); // Refresh the list to update UI
  //   }
  // }

  // Add new product to the list and store its ID
  void addProduct(ProductListing product) {
    if (product.productId != null && product.productId!.isNotEmpty) {
      product.quantity = 1;
      products.add(product); // Add the product to the list
      productIds.add(product.productId!); // Store the product ID
      updateFinalAmount(); // Update the final amount
    } else {
      Get.snackbar('Error', 'Product ID is missing');
    }
  }

  // Delete product from the list
  void deleteProduct(ProductListing product) {
    products.remove(product); // Remove the product from the list
    updateFinalAmount(); // Update the final amount after deletion
    products.refresh(); // Refresh the list to update the UI
  }


  // Update final amount based on product prices and quantities
  void updateFinalAmount() {
    finalAmount.value = products.fold(0.0, (sum, item) {
      double price = double.tryParse(item.price.toString()) ?? 0.0;
      return sum + (price * item.quantity); // Calculate total based on quantity
    });
  }

  @override
  void onInit() {
    super.onInit();
    initialCustomersList();
  }

  int get totalQuantity {
    int total = 0;
    for (var product in products) {
      total += product.quantity;
    }
    return total;
  }



  // Fetch customer list
  Future<void> initialCustomersList() async {
    isScreenProgress.value = true; // Show progress indicator
    try {
      final ApiResp resp = await CustomerServices.getList();
      if (resp.ok) {
        final profileDetails = CustomerList.fromJson(resp.rdata);
        customerData.assignAll(profileDetails.shop ?? []);
        App.cusdetails = customerData;
        isScreenProgress.value = false; // Hide progress indicator
        print('Profile data fetched successfully: ${customerData.length} items');
      } else {
        isScreenProgress.value = false;
        print('Error fetching profile data: ${resp.msgs}');
      }
    } catch (e) {
      isScreenProgress.value = false;
      print('Error fetching profile data: $e');
    }
  }

  Future<void> submitOrder() async {
    if (selectedShop.isEmpty || products.isEmpty) {
      Get.snackbar('Error', 'Please select a shop and add products');
      return;
    }

    try {
      // Parse shop ID
      int shopId = int.parse(selectedShop.value);

      // Prepare product data
      List<String> productNames = products.map((p) => p.productName ?? '').toList();
      List<String> productIds = products.map((p) {
        if (p.productId != null && p.productId!.isNotEmpty) {
          return p.productId!;
        } else {
          throw Exception('Product ID is missing for ${p.productName}');
        }
      }).toList();
      List<String> productQtys = products.map((p) => p.quantity.toString()).toList();
      List<String> productAmts = products.map((p) {
        double price = double.tryParse(p.price ?? '0') ?? 0.0;
        return (price * p.quantity).toStringAsFixed(2);
      }).toList();

      // Calculate total (optional)
      int total = finalAmount.value.toInt();

      // Submit the order as query parameters
      ApiResp response = await AddOrderSubmitServices.fetchUser(
        shop_id: shopId,
        total: total,
        product_names: jsonEncode(productNames), // Convert to JSON string
        product_qtys: jsonEncode(productQtys),   // Convert to JSON string
        product_ids: jsonEncode(productIds),     // Convert to JSON string
        product_amts: jsonEncode(productAmts),   // Convert to JSON string
      );

      // Handle the API response
      if (response.ok) {
        var responseData = response.rdata; // Directly use the response data
        String message = responseData["message"] ?? "Order submitted successfully";
        Get.snackbar('Success', message, backgroundColor: MyTheme.appColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,);

        // Clear the product list and reset the final amount
        products.clear();
        updateFinalAmount(); // Reset final amount to 0
        products.refresh(); // Refresh the list to update the UI
      } else {
        Get.snackbar('Error', 'Failed to submit order');
      }
    } catch (e) {
      print('Error during order submission: $e');
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }
  void updateQuantity(ProductListing product, int newQuantity) {
    if (newQuantity > 0) { // Ensure the quantity is a positive value
      product.quantity = newQuantity;
      updateFinalAmount(); // Update the final amount
      products.refresh(); // Refresh the product list to update the UI
    } else {
      Get.snackbar('Invalid Quantity', 'Quantity must be greater than zero');
    }
  }

}