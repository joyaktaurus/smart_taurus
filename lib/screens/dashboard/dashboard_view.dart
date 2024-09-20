import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'dashboard_controller.dart';
import 'package:pie_chart/pie_chart.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);
  final dataMap = <String, double>{
    "Flutter": 5,
  };

  final colorList = <Color>[
    Colors.greenAccent,
  ];

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
              icon: Icon(Icons.menu_outlined),
              onPressed: () {
                // Add functionality for the drawer icon
              },
            ),
            title: Center(
              child: Text(
                'Dashboard',
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  Get.toNamed(Routes.leadSubmit);
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
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.black12), // Grey border
                            ),
                            child: Center(
                              child: Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/img.png"),
                                    fit: BoxFit
                                        .cover, // Ensures the image covers the circle area
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hey, John",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                                Text(
                                  "Sales Manager",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Get.width * 0.35),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("..."),
                          ),
                        ]),
                  )),
              Container(
                width: double.infinity,
                height: Get.height * 0.2,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(77, 82, 225, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Shadow offset
                    ),
                  ],
                ),
                child: Center(
                  child: SizedBox(
                    width: 200, // Adjust the width to decrease chart size
                    height: 200, // Adjust the height to decrease chart size
                    child: PieChart(
                      dataMap: dataMap,
                      chartType: ChartType.ring,
                      baseChartColor: Colors.grey[50]!.withOpacity(0.15),
                      colorList: colorList,
                      ringStrokeWidth: 7,
                      // Decrease this value to make the ring thinner
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: false,
                      ),
                      totalValue: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                  width: double.infinity,
                  height: Get.height * 0.2,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Field CRM",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.taskListing);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people_alt_outlined,
                                    color: Colors.purple,
                                    size: 40,
                                  ),
                                  Text(
                                    "Tasks",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.customerList);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people_alt_outlined,
                                    color: Colors.purple,
                                    size: 40,
                                  ),
                                  Text(
                                    "Customers",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.leadListing);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people_alt_outlined,
                                    color: Colors.purple,
                                    size: 40,
                                  ),
                                  Text(
                                    "Leads",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
              SizedBox(height: Get.height * 0.02),
              Container(
                  width: double.infinity,
                  height: Get.height * 0.2,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sales CRM",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.addOrder);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people_alt_outlined,
                                    color: Colors.purple,
                                    size: 40,
                                  ),
                                  Text(
                                    "Orders",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.productListing);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people_alt_outlined,
                                    color: Colors.purple,
                                    size: 40,
                                  ),
                                  Text(
                                    "Products",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.expenses);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people_alt_outlined,
                                    color: Colors.purple,
                                    size: 40,
                                  ),
                                  Text(
                                    "Expenses",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}

// Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//             onTap: () {
//               Get.toNamed(Routes.customerList);
//             },
//             child: Text("Customer List Page")),
//         GestureDetector(
//             onTap: () {
//               Get.toNamed(Routes.leadSubmit);
//             },
//             child: Text("Lead Form Page")),
//       ],
//     ))
