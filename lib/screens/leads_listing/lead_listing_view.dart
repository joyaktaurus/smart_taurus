import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

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
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              title: Center(
                child: Text(
                  'Leads',
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
                  icon: Icon(Icons.notification_add_outlined,
                      color: Colors.black),
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
                  padding: EdgeInsets.only(bottom: 80.0, top: 15),
                  child: Obx(() {
                    bool isLoading = controller.isScreenProgress.value;
                    final cusDetail = controller.leadListData;
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
                        itemCount: controller.leadListData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: double.infinity,
                              //   height: Get.height * 0.2,
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
                                    left: 20.0,
                                    right: 20,
                                    top: 15.0,
                                    bottom: 15.0),
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
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.deepPurpleAccent,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.business_outlined,
                                                color: Colors.white,
                                                size: 17,
                                              ),
                                            ),
                                            SizedBox(width: Get.width * 0.01),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(controller
                                                    .leadListData[index]
                                                    .customerName
                                                    .toString()),
                                                Text(controller
                                                    .leadListData[index]
                                                    .customerName
                                                    .toString()),
                                              ],
                                            ),
                                            SizedBox(width: Get.width * 0.35),
                                            Text("Contacted"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    Container(
                                        width: Get.width * 0.25,
                                        height: Get.height * 0.035,
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurpleAccent,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            "View Details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                color: Colors.white),
                                          ),
                                        )),
                                  ],
                                ),
                              ));
                        },
                      );
                    }
                  }),
                ),
              ),
            ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Action when FAB is pressed (e.g., navigate to lead creation screen)
              Get.toNamed(Routes.leadSubmit);
            },
            backgroundColor: Colors.deepPurpleAccent,
            child: Icon(Icons.add), // Icon for adding new leads
          ),
        ),
    );
  }
}

