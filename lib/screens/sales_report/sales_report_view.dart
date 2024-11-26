import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/screens/sales_report/sales_report_controller.dart';

import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';

class SalesReportView extends GetView<SalesReportController> {
  const SalesReportView({Key? key}) : super(key: key);

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
              'Sales Analytics',
              style: TextStyle(color: Colors.black),
            ),
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
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Container(
                  height: Get.height * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.appColor),
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "sales today".toUpperCase(),
                                  style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.001,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.monetization_on,
                                      size: 20,
                                    ),
                                    Text(" 10k",
                                        style: MyTheme.regularTextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 15)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "items sold".toUpperCase(),
                                  style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.001,
                                ),
                                Text("100",
                                    style: MyTheme.regularTextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 15)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: Get.height * 0.03,
                  left: 10,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Sales Text
                        GestureDetector(
                          onTap: () => controller.onTextClick(0),
                          // Change the index to 0 for Sales
                          child: Obx(() {
                            return Text(
                              "Sales",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: controller.selectedIndex.value == 0
                                    ? Colors.red[900]
                                    : Colors.black,
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: Get.width * 0.05),
                        // Revenue Text
                        GestureDetector(
                          onTap: () => controller.onTextClick(1),
                          // Change the index to 1 for Revenue
                          child: Obx(() {
                            return Text(
                              "Revenue",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: controller.selectedIndex.value == 1
                                    ? Colors.red[900]
                                    : Colors.black,
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: Get.width * 0.05),
                        // Orders Text
                        GestureDetector(
                          onTap: () => controller.onTextClick(2),
                          // Change the index to 2 for Orders
                          child: Obx(() {
                            return Text(
                              "Orders",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: controller.selectedIndex.value == 2
                                    ? Colors.red[900]
                                    : Colors.black,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    Container(
                      width: Get.width * 0.3,
                      height: Get.height * 0.03,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: MyTheme.appColor, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // The Dropdown Button
                          Obx(() {
                            return DropdownButton<String>(
                              value: controller.selectedValue.value,
                              // Bind to the controller
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: MyTheme.appColor,
                              ),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.updateSelectedValue(
                                      newValue); // Update the value
                                }
                              },
                              items: <String>[
                                'Weeks',
                                'Months'
                              ] // The dropdown options
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: MyTheme.regularTextStyle(
                                        color: MyTheme.appColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  height: 300, // Adjust height as needed
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 100,
                      // Adjust based on your data
                      barGroups: controller.getBarChartData(),
                      // Fetch from controller
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 10, // Show labels at 0, 10, 20, etc.
                            getTitlesWidget: controller.getLeftTitles,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: controller.getBottomTitles,
                          ),
                        ),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        // Hide right side
                        topTitles: AxisTitles(
                            sideTitles:
                                SideTitles(showTitles: false)), // Hide top
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: true),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.045,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.45,
                      height: Get.height * 0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: MyTheme.appColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_active_outlined,
                            color: Colors.lightBlueAccent,
                            size: 50,
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Order",
                                style: MyTheme.regularTextStyle(
                                    color: Colors.white70),
                              ),
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              Text(
                                "100",
                                style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 25),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width * 0.45,
                      height: Get.height * 0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: MyTheme.appColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_fire_department_outlined,
                            color: Colors.lightBlueAccent,
                            size: 50,
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Revenue",
                                style: MyTheme.regularTextStyle(
                                    color: Colors.white70),
                              ),
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              Text(
                                "40,000",
                                style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 25),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.45,
                      height: Get.height * 0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: MyTheme.appColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.bullseye,
                            color: Colors.lightBlueAccent,
                            size: 50,
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sales Target",
                                style: MyTheme.regularTextStyle(
                                    color: Colors.white70),
                              ),
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              Text(
                                "100",
                                style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 25),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width * 0.45,
                      height: Get.height * 0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: MyTheme.appColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_events_outlined,
                            color: Colors.lightBlueAccent,
                            size: 50,
                          ),
                          SizedBox(width: Get.width * 0.02),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Acheived Target",
                                style: MyTheme.regularTextStyle(
                                    color: Colors.white70),
                              ),
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              Text(
                                "70 %",
                                style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 25),
                              ),
                              Text(
                                "7/10",
                                style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
