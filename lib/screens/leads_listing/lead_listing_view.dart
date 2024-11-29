import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/utils/my_theme.dart';

import '../../components/app_empty.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'lead_listing_controller.dart';

class LeadListingView extends GetView<LeadListingController> {
  const LeadListingView({Key? key}) : super(key: key);

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
            'Order Status',
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
          //     icon: Icon(Icons.notification_add_outlined, color: Colors.black),
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
        body: Column(children: [
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0, top: 15),
              child: Obx(() {
                bool isLoading = controller.isScreenProgress.value;
                final orderList = controller.orderListData;

                if (isLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.15),
                      child: RoundedLoader(), // Replace with your RoundedLoader
                    ),
                  );
                } else if (orderList.isEmpty) {
                  return Center(
                    child:
                        Text('No Orders Found', style: TextStyle(fontSize: 16)),
                  );
                } else {
                  return ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final order = orderList[index]; // Get the Order object
                      final shop = order.shop; // Get the nested Shop object

                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Shadow offset
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 15.0, bottom: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            color: MyTheme.appColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                              "assets/images/building.png")),
                                      SizedBox(width: Get.width * 0.05),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            shop?.customerName != null &&
                                                    shop!.customerName!
                                                        .isNotEmpty
                                                ? shop!.customerName![0]
                                                        .toUpperCase() +
                                                    shop!.customerName!
                                                        .substring(1)
                                                : '', // Show customer name
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: Get.height * 0.001),
                                          Text(
                                            shop?.shopName != null &&
                                                    shop!.shopName!.isNotEmpty
                                                ? shop!.shopName![0]
                                                        .toUpperCase() +
                                                    shop!.shopName!.substring(1)
                                                : '', // Show shop name
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${controller.orderListData[index].status}",
                                    //   "New", // Show total or other details
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Colors.green[700]),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.orderDetails,
                                      arguments: order.id,
                                    );
                                  },
                                  child: Container(
                                    width: Get.width * 0.25,
                                    height: Get.height * 0.045,
                                    decoration: BoxDecoration(
                                        color: MyTheme.appColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Colors.white),
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
          ),
        ]),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Action when FAB is pressed (e.g., navigate to lead creation screen)
        //     Get.toNamed(Routes.addOrder);
        //   },
        //   backgroundColor: MyTheme.appColor,
        //
        //   child: Icon(Icons.add), // Icon for adding new leads
        // ),
      ),
    );
  }
}
