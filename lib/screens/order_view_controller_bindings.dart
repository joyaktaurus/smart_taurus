// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
// import 'package:smart_taurus/components/rounded_loader.dart';
// import '../../models/customer_detail_model.dart';
// import '../../models/product_listing_model.dart';
// import '../../utils/my_theme.dart';
// import '../../utils/my_utils.dart';
// import '../../utils/routes.dart';
// import 'add_order_controller.dart';
//
// // class AddOrderVieww extends GetView<AddOrderController> {
// //   const AddOrderVieww(
// //       {Key? key, required this.productName, required this.finalAmount})
// //       : super(key: key);
// //
// //   final String productName;
// //   final double finalAmount;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     Get.put(
// //         AddOrderController(productName: productName, finalAmount: finalAmount));
// //
// //     return GestureDetector(
// //       onTap: () {
// //         MyUtils.hideKeyboard();
// //       },
// //       child: Scaffold(
// //         backgroundColor: Colors.white,
// //         body: Padding(
// //           padding: const EdgeInsets.only(left: 10.0, right: 10.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // Display added products
// //               Expanded(
// //                 child: Obx(() {
// //                   return ListView.builder(
// //                     itemCount: controller.products.length,
// //                     itemBuilder: (context, index) {
// //                       final product = controller.products[index];
// //
// //                       return Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(5),
// //                             color: Colors.grey[300],
// //                           ),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.end,
// //                               children: [
// //                                 Padding(
// //                                   padding: const EdgeInsets.all(8.0),
// //                                   child: Row(
// //                                     mainAxisAlignment:
// //                                         MainAxisAlignment.spaceBetween,
// //                                     children: [
// //                                       Text(product.productName ?? ''),
// //                                       // Display price based on quantity
// //                                       Text(
// //                                           "\$${(double.tryParse(product.price ?? '0')! * product.quantity).toStringAsFixed(2)}"),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Container(
// //                                   width: 130,
// //                                   height: 30,
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(5),
// //                                     color: Colors.green,
// //                                   ),
// //                                   child: Row(
// //                                     mainAxisAlignment:
// //                                         MainAxisAlignment.spaceBetween,
// //                                     children: [
// //                                       IconButton(
// //                                         onPressed: () {
// //                                           // Decrement quantity and update price
// //                                           controller.countDecrement(product);
// //                                         },
// //                                         icon: Icon(Icons.remove,
// //                                             color: Colors.white, size: 20),
// //                                       ),
// //                                       Text(
// //                                         "${product.quantity}",
// //                                         // Display the quantity
// //                                         style: TextStyle(color: Colors.white),
// //                                       ),
// //                                       IconButton(
// //                                         onPressed: () {
// //                                           // Increment quantity and update price
// //                                           controller.countIncrement(product);
// //                                         },
// //                                         icon: Icon(Icons.add,
// //                                             color: Colors.white, size: 20),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 }),
// //               ),
// //
// //               // Button to add a product
// //               Padding(
// //                 padding: EdgeInsets.only(top: 15.0),
// //                 child: GestureDetector(
// //                   onTap: () {
// //                     // Navigate to ProductListingView and wait for the result (the selected product)
// //                     Get.toNamed(Routes.productListing)?.then((result) {
// //                       if (result != null && result is ProductListing) {
// //                         controller
// //                             .addProduct(result); // Add product and update UI
// //                       }
// //                     });
// //                   },
// //                   child: Container(
// //                     height: 50,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(15),
// //                       color: MyTheme.appColor,
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         IconButton(
// //                           onPressed: () {},
// //                           icon: Icon(Icons.add),
// //                           color: Colors.white,
// //                         ),
// //                         SizedBox(width: 100),
// //                         Text("Add Product",
// //                             style: TextStyle(color: Colors.white)),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //
// //               // Final Amount
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text("Final Amount"),
// //                   Obx(() {
// //                     return Text(
// //                         "\$${controller.finalAmount.value.toStringAsFixed(2)}");
// //                   }),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// class AddOrderView extends GetView<AddOrderController> {
//   final String productName;
//   final double finalAmount;
//
//   const AddOrderView({
//     Key? key,
//     required this.productName,
//     required this.finalAmount,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(
//         AddOrderController(productName: productName, finalAmount: finalAmount));
//     final List<ProductListing> addedProducts = <ProductListing>[].obs;
//     return GestureDetector(
//       onTap: () {
//         MyUtils.hideKeyboard();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           iconTheme: const IconThemeData(color: Colors.black),
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: MyTheme.appColor,
//             ),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//           title: Text(
//             'Add Order',
//             style: TextStyle(color: Colors.black),
//           ),
//           // actions: [
//           //   IconButton(
//           //     icon: const Icon(Icons.notification_add_outlined,
//           //         color: Colors.black),
//           //     onPressed: () {
//           //       Get.toNamed(Routes.dashBoard);
//           //     },
//           //   ),
//           // ],
//           centerTitle: true,
//         ),
//         drawer: Drawer(),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 0.3,
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 5,
//                         offset: const Offset(0, 1),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 90,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: MyTheme.appColor,
//                         width: 2,
//                       ),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 // Show the dropdown by fetching customer data
//                                 controller.showDropdown
//                                     .toggle(); // Toggle dropdown visibility
//                                 controller.initialCustomersList();
//                               },
//                               icon: const Icon(Icons.add),
//                               color: MyTheme.appColor,
//                             ),
//                             const Text(
//                               "Add Party",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                           ],
//                         ),
//                         Obx(() {
//                           // Show the selected shop name if any shop is selected
//                           if (controller.selectedShop.isNotEmpty) {
//                             final selectedShop =
//                             controller.customerData.firstWhere(
//                                   (shop) =>
//                               shop.intShopId.toString() ==
//                                   controller.selectedShop.value,
//                             );
//                             return Text(
//                               selectedShop.shopName ?? 'Unnamed Shop',
//                               style: TextStyle(
//                                   color: Colors.grey[800],
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600),
//                             );
//                           }
//                           return const SizedBox();
//                         }),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Obx(() {
//                   // Show dropdown only when `showDropdown` is true
//                   if (controller.showDropdown.isTrue) {
//                     if (controller.isScreenProgress.isTrue) {
//                       return Center(child: const RoundedLoader());
//                     }
//                     if (controller.customerData.isEmpty) {
//                       return Center(child: const Text('No shops available'));
//                     }
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: MyTheme.appColor, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: DropdownButton<String>(
//                           isExpanded: true,
//                           hint: const Text('Select Shop'),
//                           value: controller.selectedShop.isNotEmpty
//                               ? controller.selectedShop.value
//                               : null,
//                           // Selected value from the dropdown
//                           items: controller.customerData.map((shop) {
//                             return DropdownMenuItem<String>(
//                               value: shop.intShopId.toString(),
//                               child: Text(shop.shopName ?? 'Unnamed Shop'),
//                             );
//                           }).toList(),
//                           onChanged: (selectedValue) {
//                             // Handle shop selection and hide dropdown
//                             controller.selectedShop(selectedValue!);
//                             controller.showDropdown.value =
//                             false; // Hide the dropdown
//                             print('Selected shop: $selectedValue');
//                           },
//                         ),
//                       ),
//                     );
//                   } else {
//                     return const SizedBox(); // Hide dropdown when not active
//                   }
//                 }),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text(
//                     "Products",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[700],
//                         fontSize: 18),
//                   ),
//                 ),
//                 Container(
//                   height: 300,
//                   width: 800,
//                   color: Colors.grey[200],
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Obx(() {
//                       return Container(
//                         height: 300,
//                         width: 800,
//                         color: Colors.grey[200],
//                         child: Padding(
//                           padding:
//                           const EdgeInsets.only(left: 8.0, bottom: 8.0),
//                           child: controller.products.isEmpty
//                               ? Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.image_outlined,
//                                   size: 100,
//                                   color: Colors.grey,
//                                 ),
//                                 Text(
//                                   "Click below to add products",
//                                   style: TextStyle(
//                                       color: Colors.grey[600],
//                                       fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           )
//                               : ListView.builder(
//                             itemCount: controller.products.length,
//                             itemBuilder: (context, index) {
//                               final product = controller.products[index];
//
//                               return Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 0.0,
//                                     top: 8.0,
//                                     bottom: 8.0,
//                                     right: 8.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                     BorderRadius.circular(5),
//                                     color: Colors.white,
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.end,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 8.0,
//                                               top: 8.0,
//                                               bottom: 8.0,
//                                               right: 50.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceBetween,
//                                             children: [
//                                               Text(product.productName ??
//                                                   ''),
//                                               // Display price based on quantity
//                                               Text(
//                                                   "\$${(double.tryParse(product.price ?? '0')! * product.quantity).toStringAsFixed(2)}"),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                           EdgeInsets.only(left: 8.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                             children: [
//                                               Container(
//                                                 width: 130,
//                                                 height: 30,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                   BorderRadius
//                                                       .circular(5),
//                                                   color: MyTheme.appColor,
//                                                 ),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                                   children: [
//                                                     IconButton(
//                                                       onPressed: () {
//                                                         // Decrement quantity and update price
//                                                         controller
//                                                             .countDecrement(
//                                                             product);
//                                                       },
//                                                       icon: Icon(
//                                                           Icons.remove,
//                                                           color: Colors
//                                                               .white,
//                                                           size: 20),
//                                                     ),
//                                                     Text(
//                                                       "${product.quantity}",
//                                                       style: TextStyle(
//                                                           color: Colors
//                                                               .white),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {
//                                                         // Increment quantity and update price
//                                                         controller
//                                                             .countIncrement(
//                                                             product);
//                                                       },
//                                                       icon: Icon(
//                                                           Icons.add,
//                                                           color: Colors
//                                                               .white,
//                                                           size: 20),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               IconButton(
//                                                 onPressed: () {
//                                                   controller.deleteProduct(
//                                                       product); // Call deleteProduct method
//                                                 },
//                                                 icon: Icon(
//                                                     Icons
//                                                         .delete_outline_outlined,
//                                                     color:
//                                                     Colors.red[900],
//                                                     size: 25),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 30.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       // Navigate to ProductListingView and wait for the result (the selected product)
//                       Get.toNamed(Routes.productListing)?.then((result) {
//                         if (result != null && result is ProductListing) {
//                           controller
//                               .addProduct(result); // Add product and update UI
//                         }
//                       });
//                     },
//                     child: Container(
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: MyTheme.appColor,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // IconButton(
//                           //   onPressed: () {},
//                           //   icon: Icon(Icons.add, size: 30),
//                           //   color: Colors.white,
//                           // ),
//                           Icon(
//                             Icons.add,
//                             size: 30,
//                             color: Colors.white,
//                           ),
//                           //Icon: Icon(Icons.add, size: 30),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "Add Product",
//                             style: TextStyle(color: Colors.white, fontSize: 14),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Final Amount",
//                         style: MyTheme.regularTextStyle(
//                           fontSize: Get.height * .016,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Obx(() {
//                         return Text(
//                           "\$${controller.finalAmount.value.toStringAsFixed(2)}",
//                           style: MyTheme.regularTextStyle(
//                             fontSize: Get.height * .016,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 40.0, bottom: 10),
//                   child: GestureDetector(
//                     onTap: () {
//                       controller.submitOrder();
//                     },
//                     child: Container(
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: Colors.red[900],
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Submit",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// //////////////////////////////////////////////
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import '../../models/customer_list_model.dart';
//
// import '../../app.dart';
// import '../../models/api_resp.dart';
//
// import '../../models/product_listing_model.dart';
// import '../../services/add_order_submit_services.dart';
// import '../../services/customerlist_services.dart';
// import '../../utils/my_theme.dart';
//
// class AddOrderController extends GetxController {
//   var products = <ProductListing>[].obs; // Observable list to hold products
//   var productIds = <String>[].obs; // Observable list to hold product IDs
//   RxString selectedShop = ''.obs; // To hold the selected shop ID
//
//   RxList<Shop> customerData = <Shop>[].obs;
//   RxBool isScreenProgress = true.obs;
//   RxBool showDropdown = false.obs; // To control the visibility of the dropdown
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
//     if (product.quantity > 1) {
//       product.quantity--; // Decrease the quantity
//       updateFinalAmount(); // Update the final amount
//       products.refresh(); // Refresh the list to update UI
//     }
//   }
//
//   // Add new product to the list and store its ID
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
//   // Delete product from the list
//   void deleteProduct(ProductListing product) {
//     products.remove(product); // Remove the product from the list
//     updateFinalAmount(); // Update the final amount after deletion
//     products.refresh(); // Refresh the list to update the UI
//   }
//
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
//       // Parse shop ID
//       int shopId = int.parse(selectedShop.value);
//
//       // Prepare product data
//       List<String> productNames = products.map((p) => p.productName ?? '').toList();
//       List<String> productIds = products.map((p) {
//         if (p.productId != null && p.productId!.isNotEmpty) {
//           return p.productId!;
//         } else {
//           throw Exception('Product ID is missing for ${p.productName}');
//         }
//       }).toList();
//       List<String> productQtys = products.map((p) => p.quantity.toString()).toList();
//       List<String> productAmts = products.map((p) {
//         double price = double.tryParse(p.price ?? '0') ?? 0.0;
//         return (price * p.quantity).toStringAsFixed(2);
//       }).toList();
//
//       // Calculate total (optional)
//       int total = finalAmount.value.toInt();
//
//       // Submit the order as query parameters
//       ApiResp response = await AddOrderSubmitServices.fetchUser(
//         shop_id: shopId,
//         total: total,
//         product_names: jsonEncode(productNames), // Convert to JSON string
//         product_qtys: jsonEncode(productQtys),   // Convert to JSON string
//         product_ids: jsonEncode(productIds),     // Convert to JSON string
//         product_amts: jsonEncode(productAmts),   // Convert to JSON string
//       );
//
//       // Handle the API response
//       if (response.ok) {
//         var responseData = response.rdata; // Directly use the response data
//         String message = responseData["message"] ?? "Order submitted successfully";
//         Get.snackbar('Success', message, backgroundColor: MyTheme.appColor,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.TOP,);
//
//         // Clear the product list and reset the final amount
//         products.clear();
//         updateFinalAmount(); // Reset final amount to 0
//         products.refresh(); // Refresh the list to update the UI
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
//
//
// // class AddOrderController extends GetxController {
// //   var products = <ProductListing>[].obs; // Observable list to hold products
// //   RxString selectedShop = ''.obs; // To hold the selected shop ID
// //
// //   RxList<Shop> customerData = <Shop>[].obs;
// //   RxBool isScreenProgress = true.obs;
// //   RxBool showDropdown = false.obs; // To control the visibility of the dropdown
// //
// //
// //   final String productName; // Declare productName as final
// //   RxDouble finalAmount = 0.0.obs; // Observable for final amount
// //
// //   // Initialize productName and finalAmount in the constructor
// //   AddOrderController({required this.productName, required double finalAmount}) {
// //     this.finalAmount.value = finalAmount; // Assign the initial value to RxDouble
// //   }
// //
// //   // Increment product quantity
// //   void countIncrement(ProductListing product) {
// //     product.quantity++; // Increment the quantity
// //     updateFinalAmount(); // Update the final amount
// //     products.refresh(); // Refresh the list to update UI
// //   }
// //
// //   // Decrement product quantity
// //   void countDecrement(ProductListing product) {
// //     if (product.quantity > 0) {
// //       product.quantity--; // Decrease the quantity
// //       updateFinalAmount(); // Update the final amount
// //       products.refresh(); // Refresh the list to update UI
// //     }
// //   }
// //   void addProduct(ProductListing product) {
// //     if (product.productId != null && product.productId!.isNotEmpty) {
// //       product.quantity = 1;
// //       products.add(product); // Add the product to the list
// //       productIds.add(product.productId!); // Store the product ID
// //       updateFinalAmount(); // Update the final amount
// //     } else {
// //       Get.snackbar('Error', 'Product ID is missing');
// //     }
// //   }
// //
// //
// //   // Add new product and recalculate final amount
// //   // void addProduct(ProductListing product) {
// //   //   product.quantity = 1;
// //   //   products.add(product); // Add the product to the list
// //   //   updateFinalAmount(); // Update the final amount
// //   // }
// //
// //   // Update final amount based on product prices and quantities
// //   void updateFinalAmount() {
// //     finalAmount.value = products.fold(0.0, (sum, item) {
// //       double price = double.tryParse(item.price.toString()) ?? 0.0;
// //       return sum + (price * item.quantity); // Calculate total based on quantity
// //     });
// //   }
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     initialCustomersList();
// //   }
// //
// //   // Fetch customer list
// //   Future<void> initialCustomersList() async {
// //     isScreenProgress.value = true; // Show progress indicator
// //     try {
// //       final ApiResp resp = await CustomerServices.getList();
// //       if (resp.ok) {
// //         final profileDetails = CustomerList.fromJson(resp.rdata);
// //         customerData.assignAll(profileDetails.shop ?? []);
// //         App.cusdetails = customerData;
// //         isScreenProgress.value = false; // Hide progress indicator
// //         print('Profile data fetched successfully: ${customerData.length} items');
// //       } else {
// //         isScreenProgress.value = false;
// //         print('Error fetching profile data: ${resp.msgs}');
// //       }
// //     } catch (e) {
// //       isScreenProgress.value = false;
// //       print('Error fetching profile data: $e');
// //     }
// //   }
// //
// //   Future<void> submitOrder() async {
// //     if (selectedShop.isEmpty || products.isEmpty) {
// //       Get.snackbar('Error', 'Please select a shop and add products');
// //       return;
// //     }
// //
// //     try {
// //       // Prepare data
// //       int shopId = int.parse(selectedShop.value);
// //       List<String> productNames = products.map((p) => p.productName ?? '').toList();
// //       List<String> productIds = products.map((p) {
// //         if (p.productId != null && p.productId!.isNotEmpty) {
// //           return p.productId!;
// //         } else {
// //           throw Exception('Product ID missing for ${p.productName}');
// //         }
// //       }).toList();
// //       List<String> productQtys = products.map((p) => p.quantity.toString()).toList();
// //       List<String> productAmts = products.map((p) {
// //         double price = double.tryParse(p.price ?? '0') ?? 0.0;
// //         return (price * p.quantity).toStringAsFixed(2);
// //       }).toList();
// //
// //       // Submit data to API
// //       ApiResp response = await AddOrderSubmitServices.fetchUser(
// //         shop_id: shopId,
// //         total: finalAmount.value.toInt(),
// //         product_names: productNames.join(','),
// //         product_qtys: productQtys.join(','),
// //         product_ids: productIds.join(','), // Valid product IDs
// //         product_amts: productAmts.join(','),
// //       );
// //
// //       if (response.ok) {
// //         Get.snackbar('Success', 'Order submitted successfully');
// //       } else {
// //         Get.snackbar('Error', 'Failed to submit order');
// //       }
// //     } catch (e) {
// //       print('Error during order submission: $e');
// //       Get.snackbar('Error', 'Something went wrong: $e');
// //     }
// //   }
// //
// //
// // }
// ////////////////////////////////////////////////////////
//
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/bindings_interface.dart';
//
// import 'add_order_controller.dart';
//
// class AddOrderBindings extends Bindings {
//   @override
//   void dependencies() {
//     final args = Get.arguments; // Get the arguments passed
//     Get.lazyPut<AddOrderController>(
//           () => AddOrderController(
//         productName: args['productName'] ?? '',
//         finalAmount: args['finalAmount'] ?? 0.0,
//       ),
//     );
//   }
// }
