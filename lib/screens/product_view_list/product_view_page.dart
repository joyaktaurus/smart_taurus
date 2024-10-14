import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/screens/product_list/product_list_controller.dart';
import 'package:smart_taurus/screens/product_view_list/product_view_controller.dart';

import '../../components/app_empty.dart';
import '../../components/app_searchbar.dart';
import '../../components/rounded_loader.dart';
import '../../models/product_listing_model.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import '../add_order/add_order_view.dart';

class ProductViewPage extends GetView<ProductViewController> {
  const ProductViewPage({Key? key}) : super(key: key);

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
                icon:  Icon(Icons.arrow_back, color: MyTheme.appColor,),
                onPressed: () {
                  Get.back();
                },
              ),
              title: Text(
                'Product Listing',
                style: TextStyle(color: Colors.black),
              ),
              // actions: [
              //   IconButton(
              //     icon: Icon(Icons.search, color: Colors.black),
              //     onPressed: () {
              //       Get.toNamed(Routes.dashBoard);
              //     },
              //   ),
              //   IconButton(
              //     icon:
              //         Icon(Icons.notification_add_outlined, color: Colors.black),
              //     onPressed: () {
              //       // Add functionality for notifications icon
              //     },
              //   ),
              // ],
              centerTitle: true, // Ensure the title is centered
            ),
            drawer: Drawer(
                // Add a drawer if needed
                ),
            body: Stack(children: [
              Container(
                height: 0.3, // Height of the grey divider
                decoration: BoxDecoration(
                  color: Colors.grey, // Grey color for the line
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // Adds elevation effect
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20,),
                  child: Obx(() => controller.isScreenProgress.value
                      ? Center(child: RoundedLoader())
                      : Column(children: [
                      MASearchBar(
                        hintText: 'Search a Product ',
                        controller: controller.searchCntrl,
                        searchFn: () => controller.searchBtn(),
                        searchTypeChosenValue:
                            controller.searchTypeChosenValue.value,
                        suffixIconBtnFn: () =>
                            controller.searchSuffixIconBtn(),
                        textInputAction: TextInputAction.search,
                        textFieldOnchanged: (val) =>
                            controller.searchOnChangeFn(val),
                        onFieldSubmitted: (val) =>
                            controller.onFieldSubmittedFn(val),
                      ),
                      controller.proData.isEmpty
                          ? Expanded(
                              child: MAResultEmpty(msg: 'Results Empty'),
                            )
                          : Expanded(
                              child: ListView.builder(
                              itemCount: controller.proData.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                final customers = controller.proData[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10,top: 10),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey
                                                .withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(
                                                0, 3), // Shadow offset
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 10.0),
                                                child: Container(
                                                  height: 110,
                                                  width: 110,
                                                  decoration: BoxDecoration(
                                                    shape:
                                                        BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10),
                                                    border: Border.all(
                                                        color: Colors
                                                            .black12), // Grey border
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      height: 110,
                                                      width: 110,
                                                      decoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10),
                                                        shape: BoxShape
                                                            .rectangle,
                                                        image:
                                                            DecorationImage(
                                                          image:
                                                              NetworkImage(
                                                            controller
                                                                .proData[
                                                                    index]
                                                                .imageurl
                                                                .toString(),
                                                          ),
                                                          fit: BoxFit
                                                              .cover, // Ensures the image covers the circle area
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: Get.width * .03),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20,
                                                    bottom: 10,
                                                    left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(
                                                      (controller
                                                                  .proData[
                                                                      index]
                                                                  .productName ??
                                                              "----")
                                                          .toString(),
                                                      style: MyTheme
                                                          .regularTextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: MyTheme
                                                            .myBlueDark,
                                                        fontSize:
                                                            Get.height *
                                                                .018,
                                                      ),
                                                    ),
                                                    // SizedBox(
                                                    //   height: 10,
                                                    // ),
                                                    // Text(
                                                    //   (controller.proData[index]
                                                    //       .productId ??
                                                    //       "----")
                                                    //       .toString(),
                                                    //   style: MyTheme.regularTextStyle(
                                                    //     fontWeight: FontWeight.w600,
                                                    //     color: MyTheme.myBlueDark,
                                                    //     fontSize: Get.height * .018,
                                                    //   ),
                                                    // ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SingleChildScrollView(
                                                        child: Container(
                                                      width: 200,
                                                      height: 60,
                                                      child: Text(
                                                        (controller
                                                                    .proData[
                                                                        index]
                                                                    .productDescription ??
                                                                "----")
                                                            .toString(),
                                                        style: MyTheme
                                                            .regularTextStyle(
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                          color:
                                                              Colors.grey,
                                                          fontSize:
                                                              Get.height *
                                                                  .013,
                                                        ),
                                                      ),
                                                    )),
                                                    SizedBox(
                                                        height: Get.height *
                                                            .01),
                                                    Text(
                                                      "Price",
                                                      style: MyTheme
                                                          .regularTextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: MyTheme.appColor,

                                                        fontSize:
                                                            Get.height *
                                                                .018,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: Get.height *
                                                            .01),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .currency_rupee_outlined,
                                                          size: 14,
                                                        ),
                                                        Text(
                                                          controller
                                                              .proData[
                                                                  index]
                                                              .price
                                                              .toString(),
                                                          style: MyTheme
                                                              .regularTextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: Colors
                                                                .black,
                                                            fontSize:
                                                                Get.height *
                                                                    .018,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Padding(
                                          //   padding:
                                          //   EdgeInsets.only(bottom: 10, right: 20),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.end,
                                          //     children: [
                                          //       GestureDetector(
                                          //         onTap: () {
                                          //           // Pass the selected product details back to AddOrderView using Get.back()
                                          //           final selectedProduct = ProductListing(
                                          //             productId: customers.productId ?? "Unknown ID",
                                          //             productName: customers.productName ?? "Unknown Product",
                                          //             price: customers.price != null ? customers.price : '0.0',
                                          //             // Add more fields if needed from the ProductListing class
                                          //           );
                                          //           Get.back(result: selectedProduct);  // Return the selected product
                                          //         },
                                          //         child: Container(
                                          //           height: Get.height * 0.05,
                                          //           width: Get.width * 0.2,
                                          //           decoration: BoxDecoration(
                                          //             borderRadius: BorderRadius.circular(15),
                                          //             color: MyTheme.myBlueDark,
                                          //           ),
                                          //           child: Center(
                                          //             child: Text(
                                          //               "ADD",
                                          //               style: MyTheme.regularTextStyle(
                                          //                 fontWeight: FontWeight.w600,
                                          //                 color: MyTheme.whiteColor,
                                          //                 fontSize: Get.height * .018,
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //
                                          //
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      )),
                                );
                              },
                            ))
                        ])))
            ])));
  }
}

// void ProductShow(BuildContext context, String productId, String productName, String imageUrl, String price, ProductListingController controller) {
//   controller.quantityCntrl.text = "";
//   double rate = double.tryParse(price) ?? 0.0;
//
//   // Listen to quantity changes
//   controller.quantityCntrl.addListener(() {
//     controller.updateFinalAmount(controller.quantityCntrl.text, rate);
//   });
//
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (ctx) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Container(
//           width: Get.width * .9,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: Icon(Icons.close, color: MyTheme.myBlueDark, size: 15),
//                   ),
//                 ],
//               ),
//               Text(
//                 productName,
//                 style: MyTheme.regularTextStyle(
//                   color: Colors.black,
//                   fontSize: Get.height * .017,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Container(
//                 width: Get.width * .20,
//                 height: Get.height * .20,
//                 child: Image.network(imageUrl),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Rate",
//                     style: MyTheme.regularTextStyle(
//                       fontSize: Get.height * .016,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Text(
//                     price,
//                     style: MyTheme.regularTextStyle(
//                       fontSize: Get.height * .016,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Quantity",
//                     style: MyTheme.regularTextStyle(
//                       fontSize: Get.height * .016,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Container(
//                     width: Get.width * 0.2,
//                     child: TextFormField(
//                       controller: controller.quantityCntrl,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: UnderlineInputBorder(),
//                         hintText: "Enter quantity",
//                       ),
//                       style: MyTheme.regularTextStyle(
//                         fontSize: Get.height * .016,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Final Amount",
//                     style: MyTheme.regularTextStyle(
//                       fontSize: Get.height * .016,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Obx(() => Text(
//                     "${controller.finalAmount.value.toStringAsFixed(2)}",
//                     style: MyTheme.regularTextStyle(
//                       fontSize: Get.height * .016,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   )),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate with product ID and final amount
//                       controller.addProductToOrder(productId, productName, controller.finalAmount.value);
//                     },
//                     child: Container(
//                       height: Get.height * 0.05,
//                       width: Get.width * 0.2,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: MyTheme.myBlueDark,
//                       ),
//                       child: Center(
//                         child: Text(
//                           "ADD",
//                           style: MyTheme.regularTextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: MyTheme.whiteColor,
//                             fontSize: Get.height * .018,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
InputDecoration textBoxDecoration(hintText) {
  return InputDecoration(
    hintText: hintText,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    hintStyle: MyTheme.regularTextStyle(
        fontSize: Get.height * .018, color: Colors.black),
  );
}
