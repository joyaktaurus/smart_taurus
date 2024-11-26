import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/screens/user_profile/profile_controller.dart';

import '../../components/rounded_loader.dart';
import '../../models/customer_detail_model.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

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
                'Profile Detail',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true, // Ensure the title is centered
            ),
            drawer: Drawer(
                // Add a drawer if needed
                ),
            body: Container(
              child: Obx(() {
                // Observe changes in the loading state and employee data
                if (controller.isLoading.value) {
                  return Center(
                      child:
                          RoundedLoader()); // Show loader while fetching data
                }
                if (controller.employee.value.name == null) {
                  return Center(child: Text("No data available"));
                }
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
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
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
                                                    image: controller
                                                                .employee
                                                                .value
                                                                .profilePic !=
                                                            null
                                                        ? NetworkImage(
                                                            '${controller.imagePath.value}/${controller.employee.value.profilePic}')
                                                        : AssetImage(
                                                                "assets/images/img.png")
                                                            as ImageProvider,
                                                    fit: BoxFit
                                                        .cover, // Ensures the image covers the circle area
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                    SizedBox(width: Get.width * 0.02),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.employee.value.name ??
                                                '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Emp ID: ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                controller.employee.value.id
                                                        .toString() ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 30,
                              ),
                              child: Wrap(
                                spacing: Get.width * 0.04,
                                // Horizontal space between items
                                runSpacing: Get.height * 0.02,
                                // Vertical space between rows
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  _buildIconWithText(
                                    icon: Icons.phone,
                                    label:
                                        controller.employee.value.phone ?? '',
                                  ),
                                  _buildIconWithText(
                                    icon: Icons.mail_outline_outlined,
                                    label:
                                        controller.employee.value.email ?? '',
                                    width: Get.width *
                                        0.7, // Set width for longer content like email
                                  ),
                                  _buildIconWithText(
                                    icon: Icons.workspaces_outlined,
                                    label:
                                        controller.employee.value.job ?? '----',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Get.height * 0.018),
                          ]))),
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
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Attendance",
                                style: MyTheme.regularTextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyTheme.appColor),
                                      ),
                                      SizedBox(width: Get.width * 0.02),
                                      Text(("Presents"))
                                    ],
                                  ),
                                  SizedBox(width: Get.width * 0.05),
                                  Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red[900]),
                                      ),
                                      SizedBox(width: Get.width * 0.02),
                                      Text(("Leaves"))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Obx(() => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green[900]!, width: 1), // Border styling
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButton<String>(
                                    value: controller.selectedMonth.value,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    underline: SizedBox(), // Remove the underline
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green[900],
                                    ),
                                    isExpanded: true, // Expand to fill width
                                    onChanged: (String? newValue) {
                                      controller.selectedMonth.value = newValue!;
                                    },
                                    items: controller.months.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                )),
                              ),
                              SizedBox(
                                width: Get.width * 0.04,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "24",
                                          style: MyTheme.regularTextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: MyTheme.appColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.04,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "4",
                                          style: MyTheme.regularTextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.red[900],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sales Report",
                                style: MyTheme.regularTextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                              Text(
                                "November 2024",
                                style: MyTheme.regularTextStyle(
                                    color: MyTheme.appColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.025),
                          Table(
                            border: TableBorder.all(
                              color: Colors.grey.withOpacity(0.5),
                              width: 1,
                            ),
                            columnWidths: {
                              0: FlexColumnWidth(0.8),
                              // Adjust column width ratios
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(2),
                            },
                            children: [
                              // Table Header
                              TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: [
                                  tableCell("No", isHeader: true),
                                  tableCell("Shop Name", isHeader: true),
                                  tableCell("Invoice Number", isHeader: true),
                                  tableCell("Sale Amount", isHeader: true),
                                ],
                              ),
                              // Example Data Rows
                              tableRowData(1, "Shop 1", "INV-00001", "\$200"),
                              tableRowData(2, "Shop 2", "INV-00002", "\$350"),
                              tableRowData(3, "Shop 3", "INV-00003", "\$500"),
                              tableRowData(4, "Shop 4", "INV-00004", "\$500"),
                              tableRowData(5, "Shop 5", "INV-00005", "\$500"),
                              tableRowData(6, "Shop 6", "INV-00006", "\$500"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]);
              }),
            )));
  }
}

// Helper function to create table header and cells
Widget tableCell(String text, {bool isHeader = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.black : Colors.grey[800],
        ),
      ),
    ),
  );
}

// Function for generating data rows
TableRow tableRowData(
    int siNo, String shopName, String customerName, String orderCollected) {
  return TableRow(
    children: [
      tableCell(siNo.toString()),
      tableCell(shopName),
      tableCell(customerName),
      tableCell(orderCollected),
    ],
  );
}

Widget _buildIconWithText(
    {required IconData icon, required String label, double? width}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    // Align the text and icon to the start
    children: [
      Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: MyTheme.appColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 17,
        ),
      ),
      SizedBox(width: Get.width * 0.02), // Add space between icon and text
      width != null
          ? Container(
              width: width,
              child: Text(label),
            )
          : Text(label),
    ],
  );
}
