import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../models/customer_detail_model.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'customer_detail_controller.dart';

class CustomerDetailView extends GetView<CustomerDetailController> {
  const CustomerDetailView({Key? key}) : super(key: key);

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
                  'Customer Detail',
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
              //     icon: Icon(Icons.notification_add_outlined,
              //         color: Colors.black),
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
            body: Container(
              child: Obx(() {
                if (controller.isScreenProgress.value) {
                  // Show a loading spinner while data is being fetched
                  return Center(child: CircularProgressIndicator());
                } else if (controller.customerDetails.value?.intShopId ==
                    null) {
                  // Show a message if there are no customer details
                  return Center(child: Text("No customer details available."));
                } else {
                  // Show customer details when data is available
                  Shop? customer = controller.customerDetails.value;

                  return Column(children: [
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
                    Container(
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
                            padding: EdgeInsets.all(6.0),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/img.png"),
                                                    fit: BoxFit
                                                        .cover, // Ensures the image covers the circle area
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller.customerDetails
                                                          .value!.customerName
                                                          .toString() ??
                                                      "----",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 17),
                                                ),
                                                Text(
                                                  controller.customerDetails
                                                          .value!.shopName
                                                          .toString() ??
                                                      "----",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        controller.customerDetails.value
                                                    ?.categoryInfo?.isNotEmpty ==
                                                true
                                            ? controller.customerDetails.value!
                                                .categoryInfo!
                                            : "----",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 10),
                                child: Row(
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
                                            Icons.phone,
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                        ),
                                        SizedBox(width: Get.width * 0.01),
                                        Text(
                                          controller.customerDetails.value
                                              ?.phoneNumber?.isNotEmpty ==
                                              true
                                              ? controller.customerDetails.value!
                                              .phoneNumber!
                                              : "----",
                                        )
                                      ],
                                    ),
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
                                            Icons.mail_outline_outlined,
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                        ),
                                        SizedBox(width: Get.width * 0.01),
                                        Text(
                                          controller.customerDetails.value
                                              ?.strEmail?.isNotEmpty ==
                                              true
                                              ? controller.customerDetails.value!
                                              .strEmail!
                                              : "----",
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 10),
                                child: Row(
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
                                        Text(
                                          controller.customerDetails.value
                                              ?.shopName?.isNotEmpty ==
                                              true
                                              ? controller.customerDetails.value!
                                              .shopName!
                                              : "----",
                                        )
                                      ],
                                    ),
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
                                            Icons.location_on_outlined,
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                        ),
                                        SizedBox(width: Get.width * 0.01),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.customerDetails.value
                                                  ?.addressLine1?.isNotEmpty ==
                                                  true
                                                  ? controller.customerDetails.value!
                                                  .addressLine1!
                                                  : "----",
                                            ),
                                            Text(
                                              controller.customerDetails.value
                                                  ?.addressLine1?.isNotEmpty ==
                                                  true
                                                  ? controller.customerDetails.value!
                                                  .addressLine1!
                                                  : "----",
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]))),
                    Container(
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
                              left: 20.0, right: 20, top: 15.0, bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      Text("GST"),
                                      Text(
                                        controller.customerDetails.value
                                            ?.gstNumber?.isNotEmpty ==
                                            true
                                            ? controller.customerDetails.value!
                                            .gstNumber!
                                            : "----",
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                      size: 17,
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.01),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Pan Card"),
                                      Text(
                                        controller.customerDetails.value
                                            ?.pancard?.isNotEmpty ==
                                            true
                                            ? controller.customerDetails.value!
                                            .pancard!
                                            : "----",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                    Container(
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
                              left: 20.0, right: 20, top: 15.0, bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      Text("Budget Info"),
                                      Text(
                                        controller.customerDetails.value
                                            ?.budgetInfo?.isNotEmpty ==
                                            true
                                            ? controller.customerDetails.value!
                                            .budgetInfo!
                                            : "----",
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                      size: 17,
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.01),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Brand Info"),
                                      Text(
                                        controller.customerDetails.value
                                            ?.brandInfo?.isNotEmpty ==
                                            true
                                            ? controller.customerDetails.value!
                                            .brandInfo!
                                            : "----",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                    Container(
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
                              left: 20.0, right: 20, top: 15.0, bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      Text("Notes"),
                                      Text(  controller.customerDetails.value
                                          ?.categoryInfo?.isNotEmpty ==
                                          true
                                          ? controller.customerDetails.value!
                                          .categoryInfo!
                                          : "----",),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ))
                  ]);
                }
              }),
            )));
  }
}
