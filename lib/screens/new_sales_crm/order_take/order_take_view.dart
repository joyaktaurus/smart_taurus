import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/components/rounded_loader.dart';

import '../../../models/customer_detail_model.dart';
import '../../../models/customer_list_model.dart';
import '../../../models/product_listing_model.dart';
import '../../../utils/my_theme.dart';
import '../../../utils/my_utils.dart';
import '../../../utils/routes.dart';
import 'order_take_controller.dart';

// class OrderTakeVieww extends GetView<OrderTakeController> {
//   const OrderTakeVieww(
//       {Key? key,
//        // required this.productName, required this.finalAmount
//       }
//       )
//       : super(key: key);
//
//   // final String productName;
//   // final double finalAmount;
//
//   @override
//   Widget build(BuildContext context) {
//     // Get.put(
//     //     AddOrderController(productName: productName, finalAmount: finalAmount));
//
//     return GestureDetector(
//       onTap: () {
//         MyUtils.hideKeyboard();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                 return Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.grey[300],
//                               ),
//                 );
//               })
//               // Display added products
//               // Expanded(
//               //   child: Obx(() {
//               //     return ListView.builder(
//               //       itemCount: controller.products.length,
//               //       itemBuilder: (context, index) {
//               //         final product = controller.products[index];
//               //
//               //         return Padding(
//               //           padding: const EdgeInsets.all(8.0),
//               //           child: Container(
//               //             decoration: BoxDecoration(
//               //               borderRadius: BorderRadius.circular(5),
//               //               color: Colors.grey[300],
//               //             ),
//               //             child: Padding(
//               //               padding: const EdgeInsets.all(8.0),
//               //               child: Column(
//               //                 crossAxisAlignment: CrossAxisAlignment.end,
//               //                 children: [
//               //                   Padding(
//               //                     padding: const EdgeInsets.all(8.0),
//               //                     child: Row(
//               //                       mainAxisAlignment:
//               //                       MainAxisAlignment.spaceBetween,
//               //                       children: [
//               //                         Text(product.productName ?? ''),
//               //                         // Display price based on quantity
//               //                         Text(
//               //                             "\$${(double.tryParse(product.price ?? '0')! * product.quantity).toStringAsFixed(2)}"),
//               //                       ],
//               //                     ),
//               //                   ),
//               //                   Container(
//               //                     width: 130,
//               //                     height: 30,
//               //                     decoration: BoxDecoration(
//               //                       borderRadius: BorderRadius.circular(5),
//               //                       color: Colors.green,
//               //                     ),
//               //                     child: Row(
//               //                       mainAxisAlignment:
//               //                       MainAxisAlignment.spaceBetween,
//               //                       children: [
//               //                         IconButton(
//               //                           onPressed: () {
//               //                             // Decrement quantity and update price
//               //                             controller.countDecrement(product);
//               //                           },
//               //                           icon: Icon(Icons.remove,
//               //                               color: Colors.white, size: 20),
//               //                         ),
//               //                         Text(
//               //                           "${product.quantity}",
//               //                           // Display the quantity
//               //                           style: TextStyle(color: Colors.white),
//               //                         ),
//               //                         IconButton(
//               //                           onPressed: () {
//               //                             // Increment quantity and update price
//               //                             controller.countIncrement(product);
//               //                           },
//               //                           icon: Icon(Icons.add,
//               //                               color: Colors.white, size: 20),
//               //                         ),
//               //                       ],
//               //                     ),
//               //                   ),
//               //                 ],
//               //               ),
//               //             ),
//               //           ),
//               //         );
//               //       },
//               //     );
//               //   }),
//               // ),
//
//               // Button to add a product
//               // Padding(
//               //   padding: EdgeInsets.only(top: 15.0),
//               //   child: GestureDetector(
//               //     onTap: () {
//               //       // Navigate to ProductListingView and wait for the result (the selected product)
//               //       Get.toNamed(Routes.productListing)?.then((result) {
//               //         if (result != null && result is ProductListing) {
//               //           controller
//               //               .addProduct(result); // Add product and update UI
//               //         }
//               //       });
//               //     },
//               //     child: Container(
//               //       height: 50,
//               //       decoration: BoxDecoration(
//               //         borderRadius: BorderRadius.circular(15),
//               //         color: MyTheme.appColor,
//               //       ),
//               //       child: Row(
//               //         children: [
//               //           IconButton(
//               //             onPressed: () {},
//               //             icon: Icon(Icons.add),
//               //             color: Colors.white,
//               //           ),
//               //           SizedBox(width: 100),
//               //           Text("Add Product",
//               //               style: TextStyle(color: Colors.white)),
//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               // ),
//
//               // Final Amount
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Text("Final Amount"),
//               //     Obx(() {
//               //       return Text(
//               //           "\$${controller.finalAmount.value.toStringAsFixed(2)}");
//               //     }),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class OrderTakeView extends GetView<OrderTakeController> {
  const OrderTakeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyUtils.hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: MyTheme.appColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Add Order',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(),
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 0.3,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyTheme.appColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Show the dropdown by fetching customer data
                                controller.showDropdown
                                    .toggle(); // Toggle dropdown visibility
                                controller.initialCustomersList();
                              },
                              icon: const Icon(Icons.add),
                              color: MyTheme.appColor,
                            ),
                            const Text(
                              "Add Party",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                        Obx(() {
                          // Show the selected shop name if any shop is selected
                          if (controller.selectedShop.isNotEmpty) {
                            final selectedShop =
                                controller.customerData.firstWhere(
                              (shop) =>
                                  shop.intShopId.toString() ==
                                  controller.selectedShop.value,
                            );
                            return Text(
                              selectedShop.shopName ?? 'Unnamed Shop',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            );
                          }
                          return const SizedBox();
                        }),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  // Show dropdown only when `showDropdown` is true
                  if (controller.showDropdown.isTrue) {
                    if (controller.isScreenProgress.isTrue) {
                      return Center(child: const RoundedLoader());
                    }
                    if (controller.customerData.isEmpty) {
                      return Center(child: const Text('No shops available'));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyTheme.appColor, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Select Shop'),
                          value: controller.selectedShop.isNotEmpty
                              ? controller.selectedShop.value
                              : null,
                          // Selected value from the dropdown
                          items: controller.customerData.map((shop) {
                            return DropdownMenuItem<String>(
                              value: shop.intShopId.toString(),
                              child: Text(shop.shopName ?? 'Unnamed Shop'),
                            );
                          }).toList(),
                          onChanged: (selectedValue) {
                            // Handle shop selection and hide dropdown
                            controller.selectedShop(selectedValue!);
                            controller.showDropdown.value =
                                false; // Hide the dropdown
                            print('Selected shop: $selectedValue');
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox(); // Hide dropdown when not active
                  }
                }),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Products",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontSize: 18),
                  ),
                ),
                Container(
                  height: 300,
                  width: 800,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Check if there are products in the list, and show the "Items" heading
                          if (controller.products.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 0.0, left: 15, right: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red[900],
                                    ),
                                  ),
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red[900],
                                    ),
                                  ),
                                  Text(
                                    "Quantity",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red[900],
                                    ),
                                  ),
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red[900],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Expanded(
                            child: controller.products.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_outlined,
                                          size: 100,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          "Click below to add products",
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: controller.products.length,
                                    itemBuilder: (context, index) {
                                      final product =
                                          controller.products[index];
                                      double price = double.tryParse(
                                              product.price ?? '0') ??
                                          0.0;
                                      double totalAmount =
                                          price * product.quantity;

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          left: 0.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                          right: 8.0,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8.0,
                                                    top: 8.0,
                                                    right: 10.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          product.productName ??
                                                              ''),
                                                      Container(
                                                        height: 29,
                                                        width: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: MyTheme
                                                                .appColor,
                                                            width: 2,
                                                          ),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                              product.price ??
                                                                  ""),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 80,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color:
                                                              MyTheme.appColor,
                                                        ),
                                                        child: Center(
                                                          child: TextField(
                                                            textAlign: TextAlign
                                                                .center,
                                                            controller: controller
                                                                .getTextEditingController(
                                                                    product),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            onChanged: (value) {
                                                              int? newQuantity =
                                                                  int.tryParse(
                                                                      value);
                                                              if (newQuantity !=
                                                                      null &&
                                                                  newQuantity >
                                                                      0) {
                                                                product.quantity =
                                                                    newQuantity;
                                                                // Automatically update the total amount
                                                                controller
                                                                    .updateFinalAmount();
                                                                controller
                                                                    .products
                                                                    .refresh();
                                                              } else {
                                                                Get.snackbar(
                                                                  'Invalid Quantity',
                                                                  'Quantity must be greater than zero',
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      // Display the total amount for the product
                                                      Text(
                                                        '₹${(price * product.quantity).toStringAsFixed(2)}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .deleteProduct(
                                                                  product);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .delete_outline_outlined,
                                                          color:
                                                              Colors.red[900],
                                                          size: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to ProductListingView and wait for the result (the selected product)
                      Get.toNamed(Routes.categoryView)?.then((result) {
                        if (result != null && result is ProductListing) {
                          controller
                              .addProduct(result); // Add product and update UI
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MyTheme.appColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                          //Icon: Icon(Icons.add, size: 30),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Product",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Net Total",
                        style: MyTheme.regularTextStyle(
                          fontSize: Get.height * .016,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: Get.width * 0.13),
                      Obx(() {
                        return Text(
                          "${controller.totalQuantity}",
                          style: MyTheme.regularTextStyle(
                            fontSize: Get.height * .016,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                      Obx(() {
                        return Text(
                          "\₹${controller.finalAmount.value.toStringAsFixed(2)}",
                          style: MyTheme.regularTextStyle(
                            fontSize: Get.height * .016,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      if (controller.selectedShop.isEmpty) {
                        Get.snackbar(
                          'Shop Name Required',
                          'Please select a shop name before proceeding.',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                      } else {
                        // Get the selected shop from customerData
                        final selectedShop = controller.customerData.firstWhere(
                          (shop) =>
                              shop.intShopId.toString() ==
                              controller.selectedShop.value,
                        );

                        final shopName =
                            selectedShop.shopName ?? 'Unnamed Shop';
                        final customerName =
                            selectedShop.customerName ?? 'Unnamed Shop';
                        final addressLine1 =
                            selectedShop.addressLine1 ?? 'Unnamed Shop';
                        // final customerName =
                        //     controller.selectedCustomerName.value;

                        // Pass the entire customerData (or selected shop data) to ViewOrderPage
                        Get.to(ViewOrderPage(), arguments: {
                          'shopName': shopName,
                          'customerName': customerName,
                          // 'addressLine1': addressLine1,
                          'customerData': controller.customerData.toList(),
                          // Passing the entire customerData list
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red[900],
                      ),
                      child: Center(
                        child: Text(
                          "View Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ViewOrderPage extends StatelessWidget {
  final OrderTakeController controller = Get.find<OrderTakeController>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments ?? {};
    final String shopName = arguments['shopName'] as String? ?? 'Unnamed Shop';
    final String customerName =
        arguments['customerName'] as String? ?? 'Unknown Customer';
    final String addressLine1 =
        arguments['addressLine1'] as String? ?? 'Unknown Customer';
    final List<Shop> customerData =
        arguments['customerData'] as List<Shop>? ?? [];

    return GestureDetector(
      onTap: () {
        MyUtils.hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: MyTheme.appColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'View Order',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(),
        body: Column(
          children: [
            Container(
              height: 0.3,
              decoration: BoxDecoration(
                color: Colors.grey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
            Container(
              height: Get.height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(color: MyTheme.appColor),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Text(
                      "Price",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Get.width * 0.06,
                    ),
                    Text(
                      "Quantity",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Get.width * 0.08,
                    ),
                    // Text(
                    //   "Tax",
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w500),
                    // ),
                    // SizedBox(width: Get.width * 0.1),
                    Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  double price = double.tryParse(product.price ?? '0') ?? 0.0;
                  double totalAmount = price * product.quantity;

                  return Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Table(
                      border: TableBorder(
                        horizontalInside: BorderSide(color: Colors.grey[300]!),
                      ),
                      columnWidths: {
                        0: FlexColumnWidth(2.5),
                        1: FlexColumnWidth(2.5),
                        2: FlexColumnWidth(1.5),
                        3: FlexColumnWidth(2.5),
                      },
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '${product.productName}',
                                style: TextStyle(color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '${product.price}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '${product.quantity}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Text(
                            //     "GST 5.0%",
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(fontSize: 13),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '${totalAmount.toStringAsFixed(2)}',
                                style: TextStyle(color: Colors.red[900]),
                              ),
                            ),
                            SizedBox(width: Get.width * 0.001),
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.edit,
                                color: MyTheme.appColor,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.deleteProduct(product);
                              },
                              icon: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red[900],
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 20, left: 10, right: 10),
              child: Container(
                height: Get.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: MyTheme.appColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Obx(() {
                            return Text(
                              '${controller.totalQuantity}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Net Total',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Obx(() {
                            return Text(
                              '₹${controller.finalAmount.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Payment Status: ${controller.selectedPaymentStatus.isNotEmpty ? controller.selectedPaymentStatus.value : 'None'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: Get.height * 0.02),
                  Obx(() {
                    if (controller.selectedPaymentStatus.value == 'CashCarry') {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Payment Method: ${controller.selectedPaymentMethod.isNotEmpty ? controller.selectedPaymentMethod.value : 'None'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      );
                    } else {
                      return SizedBox
                          .shrink(); // If 'Cash' is not selected, hide the payment method options
                    }
                  }),
                  SizedBox(height: Get.height * 0.02),
                  Obx(() {
                    if (controller.selectedPaymentMethod.value == 'Cheque') {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Display entered cheque number and date
                            if (controller.chequeNumber.value.isNotEmpty)
                              Text(
                                'Cheque Number: ${controller.chequeNumber.value}',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            if (controller.chequeDate.value.isNotEmpty)
                              Text(
                                'Cheque Date: ${controller.chequeDate.value}',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                  SizedBox(height: Get.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          child: Wrap(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Add Payment',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Text(
                                      'Select payment status',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Obx(() {
                                      return GestureDetector(
                                        onTap: () {
                                          controller
                                              .selectPaymentStatus('CashCarry');
                                          controller
                                              .selectedPaymentMethod.value = '';
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: controller
                                                          .selectedPaymentStatus
                                                          .value ==
                                                      'CashCarry'
                                                  ? Colors.green
                                                  : Colors.transparent,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.money,
                                                  color: Colors.green[900]),
                                              SizedBox(width: 12),
                                              Text('CashCarry',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                    Obx(() {
                                      return GestureDetector(
                                        onTap: () {
                                          controller
                                              .selectPaymentStatus('Credit');
                                          controller
                                              .selectedPaymentMethod.value = '';
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: controller
                                                          .selectedPaymentStatus
                                                          .value ==
                                                      'Credit'
                                                  ? Colors.blue
                                                  : Colors.transparent,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.credit_card,
                                                  color: Colors.blue),
                                              SizedBox(width: 12),
                                              Text('Credit',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                    // Display payment methods only for Cash
                                    Obx(() {
                                      if (controller
                                              .selectedPaymentStatus.value ==
                                          'CashCarry') {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: Get.height * 0.02),
                                            Text(
                                              'Select payment method',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: Get.height * 0.01),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectPaymentMethod(
                                                    'Cheque'); // When Cheque is selected
                                              },
                                              child: PaymentMethodContainer(
                                                method: 'Cheque',
                                                selectedMethod: controller
                                                    .selectedPaymentMethod
                                                    .value,
                                                icon: Icons.receipt,
                                              ),
                                            ),
                                            if (controller.selectedPaymentMethod
                                                    .value ==
                                                'Cheque')
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Cheque Number',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.01),
                                                  TextField(
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Enter Cheque Number',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      controller.chequeNumber
                                                          .value = value;
                                                    },
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.02),
                                                  Text(
                                                    'Cheque Date',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.01),
                                                  TextField(
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Enter Cheque Date',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    onChanged: (value) {
                                                      controller.chequeDate
                                                          .value = value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectPaymentMethod(
                                                    'GPay');
                                              },
                                              child: PaymentMethodContainer(
                                                method: 'GPay',
                                                selectedMethod: controller
                                                    .selectedPaymentMethod
                                                    .value,
                                                icon: Icons.phone_android,
                                              ),
                                            ),
                                            if (controller.selectedPaymentMethod
                                                    .value ==
                                                'GPay')
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Transaction ID',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.01),
                                                  TextField(
                                                    decoration: InputDecoration(
                                                      labelText: 'G-pay Id',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      controller.gpayid.value =
                                                          value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectPaymentMethod(
                                                    'Card');
                                              },
                                              child: PaymentMethodContainer(
                                                method: 'Card',
                                                selectedMethod: controller
                                                    .selectedPaymentMethod
                                                    .value,
                                                icon: Icons.credit_card,
                                              ),
                                            ),
                                            // Only show the Cheque fields if 'Cheque' is selected
                                            if (controller.selectedPaymentMethod
                                                    .value ==
                                                'Card')
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Card Number',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.01),
                                                  TextField(
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Enter Card Number',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      controller.cardnumber
                                                          .value = value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                          ],
                                        );
                                      } else {
                                        return SizedBox
                                            .shrink(); // If 'Cash' is not selected, hide the payment method options
                                      }
                                    }),

                                    SizedBox(height: Get.height * 0.02),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.submitPayment();
                                        print(
                                            'Selected Payment: ${controller.selectedPaymentStatus.value} - ${controller.selectedPaymentMethod.value}');
                                        Get.back(); // Close the bottom sheet
                                      },
                                      child: Text('Submit'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[900],
                                        minimumSize: Size(double.infinity, 50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        isDismissible: true,
                        isScrollControlled: true, // Enable scroll control
                      );
                    },
                    child: Obx(() {
                      return Container(
                        height: Get.height * 0.05,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green[900],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            controller.isPaymentAdded.value
                                ? "Change Payment Type"
                                : "Add Payment Type",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Obx(() {
                    return !controller.isOrderSubmitted.value &&
                            controller.selectedPaymentStatus.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              controller.submitOrder();
                            },
                            child: Container(
                              height: Get.height * 0.05,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "Submit".toUpperCase(),
                                  style: MyTheme.regularTextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox.shrink();
                  }),

                  SizedBox(height: Get.height * 0.02),
                  Obx(() {
                    if (controller.isOrderSubmitted.value) {
                      // Show dialog directly in the view
                      Future.delayed(Duration.zero, () {
                        Get.dialog(
                          Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.sentiment_satisfied_alt,
                                    size: 80,
                                    color: Colors.green,
                                  ),
                                  SizedBox(height: 20),
                                  Text("Thank You For Your Order..!",
                                    //controller.successMessage.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[900],
                                    ),
                                    onPressed: () {
                                      Get.back(); // Close dialog
                                      Get.to(() => InvoicePage(
                                        products: controller.products,
                                        totalQuantity: controller.totalQuantity,
                                        finalAmount: controller.finalAmount.value,
                                        paymentStatus:controller.selectedPaymentStatus.value,
                                        paymentMethod:controller.selectedPaymentMethod.value,
                                        shopName: shopName,
                                        customerName: customerName,
                                        customerData: customerData,
                                        addressLine1: addressLine1,
                                      ));
                                    },
                                    child: Text('Generate Invoice'.toUpperCase()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        // Reset submission flag after showing the dialog
                        controller.isOrderSubmitted.value = false;
                      });
                    }
                    return SizedBox.shrink();  // No widget when not submitted
                  }),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Obx(() {
//   return controller.selectedPaymentStatus.isNotEmpty
//       ? GestureDetector(
//           onTap: () {
//             Get.to(() => InvoicePage(
//                   products: controller.products,
//                   totalQuantity: controller.totalQuantity,
//                   finalAmount: controller.finalAmount.value,
//                   shopName: shopName,
//                   customerName: customerName,
//                   customerData: customerData,
//                 ));
//           },
//           child: Container(
//             height: Get.height * 0.05,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color: Colors.red[900],
//                 borderRadius: BorderRadius.circular(5)),
//             child: Center(
//               child: Text(
//                 "Generate Invoice".toUpperCase(),
//                 style: MyTheme.regularTextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         )
//       : SizedBox.shrink();
// }),

class PaymentMethodContainer extends StatelessWidget {
  final String method;
  final String selectedMethod;
  final IconData icon;

  PaymentMethodContainer({
    required this.method,
    required this.selectedMethod,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: selectedMethod == method ? Colors.green : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green[900]),
          SizedBox(width: 12),
          Text(method, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// Widget PaymentOption({required String title, required IconData icon, required bool isSelected}) {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//     margin: EdgeInsets.symmetric(vertical: 8),
//     decoration: BoxDecoration(
//       color: Colors.grey[200],
//       borderRadius: BorderRadius.circular(8),
//       border: Border.all(
//         color: isSelected ? Colors.green : Colors.transparent,
//         width: 2,
//       ),
//     ),
//     child: Row(
//       children: [
//         Icon(icon, color: Colors.green[900]),
//         SizedBox(width: 12),
//         Text(title, style: TextStyle(fontSize: 16)),
//       ],
//     ),
//   );
// }

// class AddPayment extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: MyTheme.appColor,
//           ),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: Text(
//           'Add Payment',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(top: 8.0, left: 20.0),
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               'Add Your Payment Information',
//               style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                   color: MyTheme.appColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class InvoicePage extends StatelessWidget {
  final List<ProductListing> products;
  final int totalQuantity;
  final double finalAmount;
  final String shopName;
  final String paymentStatus;
  final String paymentMethod;
  final String addressLine1;
  final String customerName;
  final List<Shop> customerData; // Customer data list

  InvoicePage({
    required this.products,
    required this.totalQuantity,
    required this.finalAmount,
    required this.shopName,
    required this.customerName,
     required this.addressLine1,
    required this.customerData,
    required this.paymentStatus,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MyTheme.appColor,
          ),
          onPressed: () {
            Get.toNamed(Routes.dashBoard);
          },
        ),
        title: Text(
          'Invoice',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TAURUS CRM",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: MyTheme.appColor),
                ),
                Text(
                  "INVOICE",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 4),
            child: Text(
              "# INV-00009",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 20),
            child: Text(
              paymentStatus == 'CashCarry' ? 'PAID' : paymentStatus == 'credit' ? 'UNPAID' : 'UNPAID',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: paymentStatus == 'CashCarry' ? Colors.green[900] : Colors.red[900], // Different colors for PAID and UNPAID
                fontSize: 14,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 5),
            child: Text.rich(
              TextSpan(
                text: 'Payment Status: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: paymentStatus?.isNotEmpty == true ? paymentStatus : 'No status available',
                    style: TextStyle(
                      color:MyTheme.appColor, // Different color for the value
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

// Conditional check for showing paymentMethod
          if (paymentStatus == "CashCarry")
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 5),
              child: Text.rich(
                TextSpan(
                  text: 'Payment Method: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: paymentMethod?.isNotEmpty == true ? paymentMethod : 'No method available',
                      style: TextStyle(
                        color: MyTheme.appColor, // Base color for the label
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),


          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 4),
            child: Text(
              "Bill To",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 4),
            child: Text(
              '$customerName',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 4),
            child: Text(
              '$shopName',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 4),
            child: Text(
              addressLine1?.isNotEmpty == true ? addressLine1 : 'No status available',
              //'$addressLine1',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 10, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Invoice Date : ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "2024-01-20",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Get.height * 0.05,
            width: double.infinity,
            decoration: BoxDecoration(color: MyTheme.appColor),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Items",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: Get.width * 0.1),
                  Text(
                    "Qty",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: Get.width * 0.15),
                  Text(
                    "Rate",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: Get.width * 0.1),
                  Text(
                    "Tax",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: Get.width * 0.1),
                  Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                double price = double.tryParse(product.price ?? '0') ?? 0.0;
                double totalAmount = price * product.quantity;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey[300]!),
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1.5),
                      2: FlexColumnWidth(1.5),
                      3: FlexColumnWidth(1.5),
                      4: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '${product.productName}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '${product.quantity}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '${product.price}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "GST 5.0%",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '${totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.red[900]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(
                left: 5.0, right: 10.0, top: 10.0, bottom: 20.0),
            child: Container(
              height: Get.height * 0.07,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: MyTheme.appColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '$totalQuantity',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Net Total',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '₹${finalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//   width: 130,
//   height: 30,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(5),
//     color: MyTheme.appColor,
//   ),
//   child: Row(
//     mainAxisAlignment:
//     MainAxisAlignment.spaceBetween,
//     children: [
//       IconButton(
//         onPressed: () {
//           // Decrement quantity and update price
//           controller.countDecrement(product);
//         },
//         icon: Icon(
//           Icons.remove,
//           color: Colors.white,
//           size: 20,
//         ),
//       ),
//       Text(
//         "${product.quantity}",
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       IconButton(
//         onPressed: () {
//           // Increment quantity and update price
//           controller.countIncrement(product);
//         },
//         icon: Icon(
//           Icons.add,
//           color: Colors.white,
//           size: 20,
//         ),
//       ),
//     ],
//   ),
// ),

// Container(
//   height: 25,
//   width: 100,
//   decoration: BoxDecoration(
//     border: Border.all(
//       color: MyTheme.appColor,
//       width: 2,
//     ),
//     shape: BoxShape.rectangle,
//     borderRadius: BorderRadius.circular(5),
//   ),
// ),

// Display price based on quantity
// Text(
//   "\$${(double.tryParse(product.price ?? '0')! * product.quantity).toStringAsFixed(2)}",
// ),
