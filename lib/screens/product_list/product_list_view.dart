import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/screens/product_list/product_list_controller.dart';

import '../../components/app_empty.dart';
import '../../components/app_searchbar.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';

class ProductListingView extends GetView<ProductListingController> {
  const ProductListingView({Key? key}) : super(key: key);

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
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            title: Center(
              child: Text(
                'Product Listing',
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  Get.toNamed(Routes.dashBoard);
                },
              ),
              IconButton(
                icon:
                    Icon(Icons.notification_add_outlined, color: Colors.black),
                onPressed: () {
                  // Add functionality for notifications icon
                },
              ),
            ],
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
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
              child: MASearchBar(
                hintText: 'Search a Shop',
                controller: controller.searchCntrl,
                searchFn: () => controller.searchBtn(),
                searchTypeChosenValue: controller.searchTypeChosenValue.value,
                suffixIconBtnFn: () => controller.searchSuffixIconBtn(),
                textInputAction: TextInputAction.search,
                textFieldOnchanged: (val) => controller.searchOnChangeFn(val),
                // dropDownOnchanged: (val) =>
                //     controller.searchDropdownOnChangeFn(val),
                onFieldSubmitted: (val) => controller.onFieldSubmittedFn(val),
                // goToQRScan: () => controller.qrScanBtn(),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: Get.height * .13, left: 20, right: 20),
              child: Obx(
                () {
                  bool isLoading = controller.isScreenProgress.value;
                  final cusDetail = controller.proData;
                  if (isLoading) {
                    Future.delayed(Duration(seconds: 2), () {
                      controller.isScreenProgress.value = false;
                    });
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.3),
                        child: RoundedLoader(),
                      ),
                    );
                  } else if (cusDetail.isEmpty) {
                    return Center(
                      child: MAResultEmpty(
                        msg: 'Results Empty',
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.proData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final customers = controller.proData[index];
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
                                    offset: Offset(0, 3), // Shadow offset
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
                                            const EdgeInsets.only(left: 10.0),
                                        child:  Container(
                                          height: 110,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors
                                                    .black12), // Grey border
                                          ),
                                          child: Center(
                                            child: Container(
                                              height: 110,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                shape: BoxShape.rectangle,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    controller
                                                        .proData[index].imageurl
                                                        .toString(),),
                                                  fit: BoxFit
                                                      .cover, // Ensures the image covers the circle area
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
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
                                              (controller.proData[index].productName ?? "----").toString(),
                                              style: MyTheme.regularTextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: MyTheme.myBlueDark,
                                                fontSize: Get.height * .018,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SingleChildScrollView(
                                                child: Container(
                                              width: 200,
                                              height: 50,
                                              child: Text(
                                                (controller.proData[index].productDescription ?? "----").toString(),
                                                style: MyTheme.regularTextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                  fontSize: Get.height * .013,
                                                ),
                                              ),
                                            )),
                                            SizedBox(height: Get.height * .01),
                                            Text(
                                              controller
                                                  .proData[index].price
                                                  .toString(),
                                              style: MyTheme.regularTextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: Get.height * .018,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 10, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            ProductShow(context);
                                          },
                                          child: Container(
                                            height: Get.height * 0.05,
                                            width: Get.width * 0.2,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: MyTheme.myBlueDark),
                                            child: Center(
                                              child: Text(
                                                "ADD",
                                                style: MyTheme.regularTextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: MyTheme.whiteColor,
                                                  fontSize: Get.height * .018,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ]),
        ));
  }
}

void AddToList(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Container(
            width: Get.width * .9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close,
                            color: MyTheme.myBlueDark, size: 15))
                  ],
                ),
                ProfileRows("Rate  :   ", "10000.00"),
                Divider(thickness: 1),
                ProfileRows("Rate  :   ", "10000.00"),
                Divider(thickness: 1),
                ProfileRows("Quantity  :   ", "1"),
                SizedBox(height: Get.height * .01),
                Divider(thickness: 1),
                SizedBox(height: Get.height * .01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ProductShow(context);
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: MyTheme.myBlueDark),
                        child: Center(
                          child: Text(
                            "ADD",
                            style: MyTheme.regularTextStyle(
                              fontWeight: FontWeight.w600,
                              color: MyTheme.whiteColor,
                              fontSize: Get.height * .018,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

Padding ProfileRows(String text, text1) {
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: MyTheme.regularTextStyle(
              fontSize: Get.height * .016,
              color: Colors.black,
              fontWeight: FontWeight.w400),
        ),
        Text(
          text1,
          style: MyTheme.regularTextStyle(
              fontSize: Get.height * .016,
              color: Colors.black,
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

void ProductShow(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Container(
            width: Get.width * .9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close,
                            color: MyTheme.myBlueDark, size: 15))
                  ],
                ),
                Text(
                  "Product Name",
                  style: MyTheme.regularTextStyle(
                      color: Colors.black,
                      fontSize: Get.height * .017,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                    width: Get.width * .20,
                    height: Get.height * .20,
                    decoration: BoxDecoration(),
                    child: Image.asset("assets/images/img_2.png")),
                ProfileRows("Rate  :   ", "10000.00"),
                ProfileRows("Quantity  :   ", "1"),
                SizedBox(height: Get.height * .01),
                Divider(thickness: 1),
                SizedBox(height: Get.height * .01),
                ProfileRows("Final Amount  :   ", "10000.00"),
                SizedBox(height: Get.height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ProductShow(context);
                      },
                      child: Container(
                        height: Get.height * 0.05,
                        width: Get.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: MyTheme.myBlueDark),
                        child: Center(
                          child: Text(
                            "ADD",
                            style: MyTheme.regularTextStyle(
                              fontWeight: FontWeight.w600,
                              color: MyTheme.whiteColor,
                              fontSize: Get.height * .018,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
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
