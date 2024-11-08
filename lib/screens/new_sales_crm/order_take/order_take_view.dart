import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/components/rounded_loader.dart';

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
  // final String productName;
  // final double finalAmount;

  const OrderTakeView({
    Key? key,
    // required this.productName,
    // required this.finalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put(
    //     OrderTakeController(productName: productName, finalAmount: finalAmount)
    // );
    // final List<ProductListing> addedProducts = <ProductListing>[].obs;
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
                      Get.to(ViewOrderPage());
                      // controller.submitOrder();
                      // Get.toNamed(Routes.viewOrder);
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
class ViewOrderPage extends StatelessWidget {
  final OrderTakeController controller = Get.find<OrderTakeController>();

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
                    Text(
                      "Price",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Quantity",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
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

                  return Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey[300]!),
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(1.5), // Adjust width as needed
                      1: FlexColumnWidth(1.5),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1.5),
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
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '${totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.red[900]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                controller.deleteProduct(product);
                              },
                              icon: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red[900],
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 50, left: 10, right: 10),
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
              padding: EdgeInsets.only(bottom: 50.0, left: 10.0, right: 10.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(ViewOrderPage());
                },
                child: Container(
                  height: Get.height * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Generate  Invoice".toUpperCase(),
                      style: MyTheme.regularTextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
