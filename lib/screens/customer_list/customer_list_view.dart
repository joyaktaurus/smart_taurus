import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../components/app_empty.dart';
import '../../components/app_load_more.dart';
import '../../components/app_searchbar.dart';
import '../../components/rounded_loader.dart';
import '../../models/customer_list_model.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'customer_list_controller.dart';

class CustomerListView extends GetView<CustomerListController> {
  const CustomerListView({Key? key}) : super(key: key);

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
                'Customer List',
                style: TextStyle(color: Colors.black),
              ),
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
          body: Column(
            children: [
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
              SizedBox(height: Get. height * 0.03),
              Obx(
                () => controller.isScreenProgress.value
                    ? Center(child: RoundedLoader())
                    : Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 20.0, right: 20.0),
                              child: MASearchBar(
                                hintText: 'Search a Shop',
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
                            ),
                            controller.customerData.isEmpty
                                ? Expanded(
                                    child:
                                        MAResultEmpty(msg: 'Results Empty'),
                                  )
                                : Expanded(
                                    child: GridView.builder(
                                      padding: EdgeInsets.only(top: 15.0),
                                      itemCount:
                                          controller.customerData.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                        childAspectRatio:
                                            3 / 3.6, // Adjust as needed
                                      ),
                                      itemBuilder: (context, index) {
                                        final customers =
                                            controller.customerData[index];
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.customerDetail,
                                              arguments: customers.intShopId,
                                              preventDuplicates: true,
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
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
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, left: 80),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        Routes.customerDetail,
                                                        arguments: customers
                                                            .intShopId,
                                                        preventDuplicates:
                                                            true,
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration:
                                                          BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                            color: MyTheme.appColor,

                                                          ),
                                                      child: Image.asset(
                                                          "assets/images/Vector.png"),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors
                                                            .black12), // Grey border
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      height: 65,
                                                      width: 65,
                                                      decoration:
                                                          BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        image:
                                                            DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/img.png"),
                                                          fit: BoxFit
                                                              .cover, // Ensures the image covers the circle area
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .customerData[
                                                                index]
                                                            .customerName
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        controller
                                                            .customerData[
                                                                index]
                                                            .shopName
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ));
  }
}
