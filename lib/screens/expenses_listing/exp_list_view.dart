import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/utils/my_theme.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'exp_list_controller.dart';

class ExpensesListingView extends GetView<ExpenseListingController> {
  const ExpensesListingView({Key? key}) : super(key: key);

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
            icon:  Icon(Icons.arrow_back, color: MyTheme.appColor,),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Expenses View',
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
              child:
              Obx(() {
                bool isLoading = controller.isScreenProgress.value;
                final orderList = controller.expListData;

                if (isLoading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.1),
                      child:
                      RoundedLoader(), // Replace with your RoundedLoader
                    ),
                  );
                } else if (orderList.isEmpty) {
                  return Center(
                    child:
                    Text('No Orders Found', style: TextStyle(fontSize: 16)),
                  );
                } else {
                  return
                    ListView.builder(
                    itemCount: controller.expListData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final expList = controller.expListData[index]; // Get the Order object
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
                                children: [
                                  Text("Travel From : "),
                                  Text("${controller.expListData[index].travelFrom}")
                                ],
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Row(
                                children: [
                                  Text("Travel To : "),
                                  Text("${controller.expListData[index].travelTo}")
                                ],
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Row(
                                children: [
                                  Text("Travel Date : "),
                                  Text("${controller.expListData[index].travelDate}")
                                ],
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Row(
                                children: [
                                  Text("Travel Type : "),
                                  Text("${controller.expListData[index].travelType}")
                                ],
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Row(
                                children: [
                                  Text("Purpose : "),
                                  Text("${controller.expListData[index].purpose}")
                                ],
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Row(
                                children: [
                                  Text("Amount : "),
                                  Text("${controller.expListData[index].amount}")
                                ],
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Row(
                                children: [
                                  Text("Other Expenses : "),
                                  Text("${controller.expListData[index].otherExpenses}")
                                ],
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
