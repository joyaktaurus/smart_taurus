import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailController> {
  const OrderDetailsView({Key? key}) : super(key: key);

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
              'Order Details',
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
              padding: EdgeInsets.only(bottom: 80.0, top: 10),
              child: Obx(() {
                bool isLoading = controller.isScreenProgress.value;
                final detailList = controller.orderDetailData;

                if (isLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.3),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (detailList.isEmpty) {
                  return Center(
                    child: Text('No Orders Found', style: TextStyle(fontSize: 16)),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("TAURUS CRM",style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: MyTheme.appColor
                              ),),
                              Text("INVOICE",style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0,bottom: 4),
                          child: Text("# INV-00009",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 25),
                          child: Text("PAID",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: MyTheme.appColor,
                              fontSize: 14
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 4),
                          child: Text("Bill To",style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 4),
                          child: Text(
                            "${controller.orderData.value.first.shop?.customerName ?? 'N/A'}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey[700]
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 4),
                          child: Text(
                            "${controller.orderData.value.first.shop?.shopName.toString() ?? 'N/A'}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              color: Colors.grey[700]
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 4),
                          child: Text(
                            "${controller.orderData.value.first.shop?.addressLine1 ?? 'N/A'}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey[700]
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 10,top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Invoice Date : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                ),),
                              Text(
                                "2024-01-20",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                ),),
                            ],
                          ),
                        ),
                        Table(
                          border: TableBorder.all(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          columnWidths: {
                            0: FixedColumnWidth(100), // Width of the Product Name column
                            1: FixedColumnWidth(50),   // Width of the Quantity column
                            2: FixedColumnWidth(80),   // Width of the Quantity column
                            3: FixedColumnWidth(80),   // Width of the Price column
                            4: FixedColumnWidth(80),   // Width of the Price column
                          },
                          children: [
                            // Table Header
                            TableRow(
                              decoration: BoxDecoration(color: MyTheme.appColor),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Items',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Qty',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Rate',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Tax',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Amount',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),

                            // Table Rows
                            for (var detail in detailList)
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${detail.productName ?? 'N/A'}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${detail.productQuantity ?? 'N/A'}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13),

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${detail.amount ?? 'N/A'}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13),

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("GST 5.0%",
                                      //"${detail.amount ?? 'N/A'}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13),

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${detail.amount ?? 'N/A'}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 13),

                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }),
            ),
          ),
        ]),
        bottomNavigationBar: Container(
          child: Container(
            height: 100,
            child: Center(
              child: Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub Total",
                                style: MyTheme.regularTextStyle(
                                  fontSize: Get.height * .018,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              // Check if orderData has any items before accessing the first element
                              Text(
                                controller.orderData.value.isNotEmpty
                                    ? '${controller.orderData.value.first.total.toString()}'
                                    : '', // Provide a fallback value if empty
                                style: MyTheme.regularTextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "GST(%)",
                                  style: MyTheme.regularTextStyle(
                                    fontSize: Get.height * .018,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                // Check if orderData has any items before accessing the first element
                                Text(
                                  controller.orderData.value.isNotEmpty
                                      ? '${controller.orderData.value.first.total.toString()}'
                                      : '', // Provide a fallback value if empty
                                  style: MyTheme.regularTextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: MyTheme.regularTextStyle(
                                        fontSize: Get.height * .018,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    // Check if orderData has any items before accessing the first element
                                    Text(
                                      controller.orderData.value.isNotEmpty
                                          ? '${controller.orderData.value.first.total.toString()}'
                                          : '', // Provide a fallback value if empty
                                      style: MyTheme.regularTextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
