import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
              icon: Icon(
                Icons.arrow_back,
                color: MyTheme.appColor,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              'Product Listing',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          drawer: Drawer(), // Add a drawer if needed
          body: Stack(children: [
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: MASearchBar(
                hintText: 'Search a Product',
                controller: controller.searchCntrl,
                searchFn: controller.searchBtn,
                searchTypeChosenValue:
                controller.searchTypeChosenValue.value,
                suffixIconBtnFn: controller.searchSuffixIconBtn,
                textInputAction: TextInputAction.search,
                textFieldOnchanged: controller.searchOnChangeFn,
                onFieldSubmitted: controller.onFieldSubmittedFn,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 100),
              child: Obx(() {
                return Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyTheme.appColor,
                      // Set the background color of the container
                      borderRadius: BorderRadius.circular(
                          20), // Add some border radius if you like
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    // Add padding inside the container
                    child: DropdownButton<String>(
                      dropdownColor: MyTheme.appColor,
                      // Set the dropdown background color to blue
                      value: controller.selectedCategory.value,
                      hint: Text(
                        "Select a Category",
                        style: TextStyle(
                            color:
                                Colors.white), // Set hint text color to white
                      ),
                      isExpanded: true,
                      items: controller.categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: TextStyle(
                                color: Colors
                                    .white), // Set item text color to white
                          ),
                        );
                      }).toList(),
                      onChanged: controller.onCategorySelected,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors
                            .white, // Set the dropdown icon color to white
                      ),
                      underline: SizedBox(), // Remove the underline
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: Get.height * .20, left: 20, right: 20),
              child: Obx(() {
                if (controller.isScreenProgress.value) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.1),
                      child: RoundedLoader(),
                    ),
                  );
                } else if (controller.proData.isEmpty) {
                  return Center(
                    child: MAResultEmpty(msg: 'Results Empty'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.proData.length,
                    itemBuilder: (context, index) {
                      final product = controller.proData[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.productName ?? "----",
                                  style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: MyTheme.appColor,
                                    fontSize: Get.height * .018,
                                  ),
                                ),
                                SizedBox(height: Get.height * .01),
                                Row(
                                  children: [
                                    Text(
                                      "Price",
                                      style: MyTheme.regularTextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: MyTheme.appColor,
                                        fontSize: Get.height * .016,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.currency_rupee_outlined,
                                          size: 14,
                                        ),
                                        Text(
                                          product.price.toString(),
                                          style: MyTheme.regularTextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: Get.height * .018,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ]),
        ));
  }
}

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
