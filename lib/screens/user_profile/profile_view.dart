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
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              title: Center(
                child: Text(
                  'Profile Detail',
                  style: TextStyle(color: Colors.black),
                ),
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
                                          Text(
                                            controller.employee.value.id.toString() ??
                                                '',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 10),
                              child: Wrap(
                                spacing: Get.width * 0.04, // Horizontal space between items
                                runSpacing: Get.height * 0.02, // Vertical space between rows
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  _buildIconWithText(
                                    icon: Icons.phone,
                                    label: controller.employee.value.phone ?? '',
                                  ),
                                  _buildIconWithText(
                                    icon: Icons.mail_outline_outlined,
                                    label: controller.employee.value.email ?? '',
                                    width: Get.width * 0.4, // Set width for longer content like email
                                  ),
                                  _buildIconWithText(
                                    icon: Icons.business_outlined,
                                    label: controller.employee.value.gender ?? '',
                                  ),
                                  _buildIconWithText(
                                    icon: Icons.location_on_outlined,
                                    label: controller.employee.value.job ?? '----',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Get.height * 0.018),
                          ]))),
                ]);
              }),
            )));
  }
}
Widget _buildIconWithText({required IconData icon, required String label, double? width}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
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
      SizedBox(width: Get.width * 0.01),
      width != null
          ? Container(
        width: width,
        child: Text(label),
      )
          : Text(label),
    ],
  );
}