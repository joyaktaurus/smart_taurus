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
import 'order_take_view.dart';

class OrderTakeController extends GetxController {
  var products = <ProductListing>[].obs; // Observable list to hold products
  var productIds = <String>[].obs; // Observable list to hold product IDs
  RxString selectedShop = ''.obs; // To hold the selected shop ID

  RxList<Shop> customerData = <Shop>[].obs;
  RxBool isScreenProgress = true.obs;
  RxBool showDropdown = false.obs; // To control the visibility of the dropdown

  // final String productName; // Declare productName as final
  RxDouble finalAmount = 0.0.obs; // Observable for final amount
  RxString selectedPaymentStatus =
      ''.obs; // To hold the selected payment method
  RxString selectedPaymentMethod = ''.obs;
  var isPaymentAdded = false.obs; // Track if payment has been added
  RxString shopName = ''.obs;  // Declare shopName to hold the name of the shop
  RxString customerName = ''.obs;  // Declare shopName to hold the name of the shop
  RxString addressLine1 = ''.obs;  // Declare shopName to hold the name of the shop
  RxString paymentStatus = ''.obs;  // Declare shopName to hold the name of the shop

  var chequeNumber = ''.obs;
  var chequeDate = ''.obs;
  var gpayid = ''.obs;
  var cardnumber = ''.obs;

  void submitPayment() {
    // Handle your payment submission logic here
    isPaymentAdded.value = true; // Set to true after payment submission
  }

  void selectPaymentStatus(String method) {
    selectedPaymentStatus.value = method;
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

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

  void countIncrement(
      ProductListing product, TextEditingController controller) {
    product.quantity++; // Increment the quantity
    controller.text = product.quantity.toString(); // Update the TextField
    updateFinalAmount(); // Update the final amount
    products.refresh(); // Refresh the list to update the UI
  }

  void countDecrement(
      ProductListing product, TextEditingController controller) {
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

  RxString selectedCustomerName =
      ''.obs; // Add this line to define selectedCustomerName

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
        print(
            'Profile data fetched successfully: ${customerData.length} items');
      } else {
        isScreenProgress.value = false;
        print('Error fetching profile data: ${resp.msgs}');
      }
    } catch (e) {
      isScreenProgress.value = false;
      print('Error fetching profile data: $e');
    }
  }
  RxString successMessage = ''.obs;  // New field to track the message

  var isOrderSubmitted = false.obs; // New variable to track order submission

  Future<void> submitOrder() async {
    if (selectedShop.isEmpty || products.isEmpty) {
      Get.snackbar('Error', 'Please select a shop and add products');
      return;
    }

    try {
      // Parse shop ID
      int shopId = int.parse(selectedShop.value);

      // Prepare product data
      List<String> productNames =
          products.map((p) => p.productName ?? '').toList();
      List<String> productIds = products.map((p) {
        if (p.productId != null && p.productId!.isNotEmpty) {
          return p.productId!;
        } else {
          throw Exception('Product ID is missing for ${p.productName}');
        }
      }).toList();
      List<String> productQtys =
          products.map((p) => p.quantity.toString()).toList();
      List<String> productAmts = products.map((p) {
        double price = double.tryParse(p.price ?? '0') ?? 0.0;
        return (price * p.quantity).toStringAsFixed(2);
      }).toList();

      // Calculate total amount
      int total = finalAmount.value.toInt();

      // Prepare payment details
      String paymentStatus = selectedPaymentStatus.value.isNotEmpty
          ? selectedPaymentStatus.value
          : 'Pending';
      String paymentMethod = selectedPaymentMethod.value.isNotEmpty
          ? selectedPaymentMethod.value
          : 'Unknown';
       String cheque_number = chequeNumber.value;
       String cheque_date = chequeDate.value;
      // String chequeDate = chequeDate.value.isNotEmpty ? chequeDate.value : '';

      // Submit the order with payment details
      ApiResp response = await AddOrderSubmitServices.fetchUser(
        shop_id: shopId,
        total: total,
        product_names: jsonEncode(productNames),
        product_qtys: jsonEncode(productQtys),
        product_ids: jsonEncode(productIds),
        product_amts: jsonEncode(productAmts),
        payment_status: paymentStatus,
        payment_method: paymentMethod,
        cheque_number: cheque_number,
        cheque_date: cheque_date,
      );

      // Handle the API response
      if (response.ok) {
        var responseData = response.rdata;
        String message =
            responseData["message"] ?? "Order submitted successfully";
        Get.snackbar(
          'Success',
          message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Clear inputs and refresh UI
        //   products.clear();
        updateFinalAmount(); // Reset final amount
        //  products.refresh();
        isOrderSubmitted.value = true;

        // Show thank you dialog
        // Get.dialog(
        //   Dialog(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.all(20.0),
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Icon(
        //             Icons.sentiment_satisfied_alt,
        //             size: 80,
        //             color: Colors.green,
        //           ),
        //           SizedBox(height: 20),
        //           Text(
        //             'Thank you for your order!',
        //             textAlign: TextAlign.center,
        //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //           ),
        //           SizedBox(height: 20),
        //           ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               backgroundColor: Colors.red[900],
        //             ),
        //             onPressed: () {
        //              Get.back(); // Close dialog
        //               // Navigate to the Invoice Page directly after closing the dialog
        //               Get.to(() => InvoicePage(
        //                 products: products,
        //                 totalQuantity: products.length, // Adjust accordingly
        //                 finalAmount: finalAmount.value,
        //                 shopName: shopName.value,
        //                 customerName: customerName.value,
        //                 customerData: customerData,
        //               ));
        //             },
        //             child: Text('Generate Invoice'.toUpperCase()),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );

      } else {
        Get.snackbar('Error', response.message ?? 'Failed to submit order');
      }
    } catch (e) {
      print('Error during order submission: $e');
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  void clearOrderData() {
    products.clear(); // Clear the product list
    selectedPaymentStatus.value = '';
    selectedPaymentMethod.value = '';
    finalAmount.value = 0; // Reset the total amount
    isOrderSubmitted.value = false; // Reset the order status
    // Reset the total quantity
  }
}
