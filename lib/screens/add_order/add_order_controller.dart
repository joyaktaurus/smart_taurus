import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../models/customer_list_model.dart';

import '../../app.dart';
import '../../models/api_resp.dart';

import '../../models/product_listing_model.dart';
import '../../services/add_order_submit_services.dart';
import '../../services/customerlist_services.dart';

class AddOrderController extends GetxController {
  var products = <ProductListing>[].obs; // Observable list to hold products
  var productIds = <String>[].obs; // Observable list to hold product IDs
  RxString selectedShop = ''.obs; // To hold the selected shop ID

  RxList<Shop> customerData = <Shop>[].obs;
  RxBool isScreenProgress = true.obs;
  RxBool showDropdown = false.obs; // To control the visibility of the dropdown

  final String productName; // Declare productName as final
  RxDouble finalAmount = 0.0.obs; // Observable for final amount

  // Initialize productName and finalAmount in the constructor
  AddOrderController({required this.productName, required double finalAmount}) {
    this.finalAmount.value = finalAmount; // Assign the initial value to RxDouble
  }

  // Increment product quantity
  void countIncrement(ProductListing product) {
    product.quantity++; // Increment the quantity
    updateFinalAmount(); // Update the final amount
    products.refresh(); // Refresh the list to update UI
  }

  // Decrement product quantity
  void countDecrement(ProductListing product) {
    if (product.quantity > 0) {
      product.quantity--; // Decrease the quantity
      updateFinalAmount(); // Update the final amount
      products.refresh(); // Refresh the list to update UI
    }
  }

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
      // Prepare data
      int shopId = int.parse(selectedShop.value);
      List<String> productNames = products.map((p) => p.productName ?? '').toList();
      List<String> productIds = products.map((p) {
        if (p.productId != null && p.productId!.isNotEmpty) {
          return p.productId!; // Assuming productId is already a string
        } else {
          throw Exception('Product ID missing for ${p.productName}');
        }
      }).toList();
      List<String> productQtys = products.map((p) => p.quantity.toString()).toList(); // Changed to string
      List<String> productAmts = products.map((p) {
        double price = double.tryParse(p.price ?? '0') ?? 0.0;
        return (price * p.quantity).toString(); // Changed to string
      }).toList();

      // Submit data to API
      ApiResp response = await AddOrderSubmitServices.fetchUser(
        shop_id: shopId,
        total: finalAmount.value.toInt(),
        product_names: productNames,
        product_qtys: productQtys,
        product_ids: productIds,
        product_amts: productAmts,
      );

      if (response.ok) {
        var responseData = jsonDecode(response.rdata);
        String message = responseData["message"] ?? "Order submitted successfully";

        Get.snackbar('Success', message);
      } else {
        Get.snackbar('Error', 'Failed to submit order');
      }
    } catch (e) {
      print('Error during order submission: $e');
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }


}


// class AddOrderController extends GetxController {
//   var products = <ProductListing>[].obs; // Observable list to hold products
//   RxString selectedShop = ''.obs; // To hold the selected shop ID
//
//   RxList<Shop> customerData = <Shop>[].obs;
//   RxBool isScreenProgress = true.obs;
//   RxBool showDropdown = false.obs; // To control the visibility of the dropdown
//
//
//   final String productName; // Declare productName as final
//   RxDouble finalAmount = 0.0.obs; // Observable for final amount
//
//   // Initialize productName and finalAmount in the constructor
//   AddOrderController({required this.productName, required double finalAmount}) {
//     this.finalAmount.value = finalAmount; // Assign the initial value to RxDouble
//   }
//
//   // Increment product quantity
//   void countIncrement(ProductListing product) {
//     product.quantity++; // Increment the quantity
//     updateFinalAmount(); // Update the final amount
//     products.refresh(); // Refresh the list to update UI
//   }
//
//   // Decrement product quantity
//   void countDecrement(ProductListing product) {
//     if (product.quantity > 0) {
//       product.quantity--; // Decrease the quantity
//       updateFinalAmount(); // Update the final amount
//       products.refresh(); // Refresh the list to update UI
//     }
//   }
//   void addProduct(ProductListing product) {
//     if (product.productId != null && product.productId!.isNotEmpty) {
//       product.quantity = 1;
//       products.add(product); // Add the product to the list
//       productIds.add(product.productId!); // Store the product ID
//       updateFinalAmount(); // Update the final amount
//     } else {
//       Get.snackbar('Error', 'Product ID is missing');
//     }
//   }
//
//
//   // Add new product and recalculate final amount
//   // void addProduct(ProductListing product) {
//   //   product.quantity = 1;
//   //   products.add(product); // Add the product to the list
//   //   updateFinalAmount(); // Update the final amount
//   // }
//
//   // Update final amount based on product prices and quantities
//   void updateFinalAmount() {
//     finalAmount.value = products.fold(0.0, (sum, item) {
//       double price = double.tryParse(item.price.toString()) ?? 0.0;
//       return sum + (price * item.quantity); // Calculate total based on quantity
//     });
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     initialCustomersList();
//   }
//
//   // Fetch customer list
//   Future<void> initialCustomersList() async {
//     isScreenProgress.value = true; // Show progress indicator
//     try {
//       final ApiResp resp = await CustomerServices.getList();
//       if (resp.ok) {
//         final profileDetails = CustomerList.fromJson(resp.rdata);
//         customerData.assignAll(profileDetails.shop ?? []);
//         App.cusdetails = customerData;
//         isScreenProgress.value = false; // Hide progress indicator
//         print('Profile data fetched successfully: ${customerData.length} items');
//       } else {
//         isScreenProgress.value = false;
//         print('Error fetching profile data: ${resp.msgs}');
//       }
//     } catch (e) {
//       isScreenProgress.value = false;
//       print('Error fetching profile data: $e');
//     }
//   }
//
//   Future<void> submitOrder() async {
//     if (selectedShop.isEmpty || products.isEmpty) {
//       Get.snackbar('Error', 'Please select a shop and add products');
//       return;
//     }
//
//     try {
//       // Prepare data
//       int shopId = int.parse(selectedShop.value);
//       List<String> productNames = products.map((p) => p.productName ?? '').toList();
//       List<String> productIds = products.map((p) {
//         if (p.productId != null && p.productId!.isNotEmpty) {
//           return p.productId!;
//         } else {
//           throw Exception('Product ID missing for ${p.productName}');
//         }
//       }).toList();
//       List<String> productQtys = products.map((p) => p.quantity.toString()).toList();
//       List<String> productAmts = products.map((p) {
//         double price = double.tryParse(p.price ?? '0') ?? 0.0;
//         return (price * p.quantity).toStringAsFixed(2);
//       }).toList();
//
//       // Submit data to API
//       ApiResp response = await AddOrderSubmitServices.fetchUser(
//         shop_id: shopId,
//         total: finalAmount.value.toInt(),
//         product_names: productNames.join(','),
//         product_qtys: productQtys.join(','),
//         product_ids: productIds.join(','), // Valid product IDs
//         product_amts: productAmts.join(','),
//       );
//
//       if (response.ok) {
//         Get.snackbar('Success', 'Order submitted successfully');
//       } else {
//         Get.snackbar('Error', 'Failed to submit order');
//       }
//     } catch (e) {
//       print('Error during order submission: $e');
//       Get.snackbar('Error', 'Something went wrong: $e');
//     }
//   }
//
//
// }
