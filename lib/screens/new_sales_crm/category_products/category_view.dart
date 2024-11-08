import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../components/app_empty.dart';
import '../../../components/app_searchbar.dart';
import '../../../components/rounded_loader.dart';
import '../../../models/product_listing_model.dart';
import '../../../utils/my_theme.dart';
import '../../../utils/my_utils.dart';
import 'category_controller.dart';

class CategoryListingView extends GetView<CategoryListingController> {
  const CategoryListingView({Key? key}) : super(key: key);

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
              'Category Listing',
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
                      color: MyTheme.appColor, // Set the background color of the container
                      borderRadius: BorderRadius.circular(20), // Add some border radius if you like
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5), // Add padding inside the container
                    child: DropdownButton<String>(
                      dropdownColor: MyTheme.appColor, // Set the dropdown background color to blue
                      value: controller.selectedCategory.value,
                      hint: Text(
                        "Select a Category",
                        style: TextStyle(color: Colors.white), // Set hint text color to white
                      ),
                      isExpanded: true,
                      items: controller.categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: TextStyle(color: Colors.white), // Set item text color to white
                          ),
                        );
                      }).toList(),
                      onChanged: controller.onCategorySelected,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white, // Set the dropdown icon color to white
                      ),
                      underline: SizedBox(), // Remove the underline
                    ),
                  ),
                );
              }),
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: Get.height * .20, left: 20, right: 20),
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
                            borderRadius: BorderRadius.circular(20),
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
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                  ),
                                  SizedBox(width: Get.width * .03),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, bottom: 10, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                                  Icons
                                                      .currency_rupee_outlined,
                                                  size: 14,
                                                ),
                                                Text(
                                                  product.price.toString(),
                                                  style: MyTheme
                                                      .regularTextStyle(
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
                                ],
                              ),
                              Padding(
                                padding:
                                EdgeInsets.only(bottom: 10, right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    final selectedProduct = ProductListing(
                                      productId: product.productId ?? "Unknown ID",
                                      productName: product.productName ?? "Unknown Product",
                                      price: product.price ?? '0.0',
                                    );
                                    Get.back(result: selectedProduct);
                                  },
                                  child: Container(
                                    height: Get.height * 0.035,
                                    width: Get.width * 0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red[900],
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "ADD",
                                            style: MyTheme.regularTextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: MyTheme.whiteColor,
                                              fontSize: Get.height * .016,
                                            ),
                                          ),
                                          Icon(
                                            Icons.add_circle_outline_outlined,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
