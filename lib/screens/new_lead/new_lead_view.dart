import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../components/app_buttons.dart';
import '../../components/app_empty.dart';
import '../../components/rounded_loader.dart';
import '../../models/customer_list_model.dart';
import '../../utils/err_m.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'new_lead_controller.dart';

class NewLeadSubmit extends GetView<NewLeadSubmitController> {
  const NewLeadSubmit({Key? key}) : super(key: key);

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
              'Lead Form',
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notification_add_outlined, color: Colors.black),
              onPressed: () {
                Get.toNamed(Routes.dashBoard);
              },
            ),
          ],
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
            // Rest of your body content
            Expanded(
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyTheme.appColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Show the dropdown by fetching customer data
                                        controller.showDropdown
                                            .toggle(); // Toggle dropdown visibility
                                        controller.initialCustomersList();
                                      },
                                      icon: const Icon(Icons.add),
                                      color: MyTheme.appColor,
                                    ),
                                    const Text(
                                      "Add Party",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                Obx(() {
                                  // Show the selected shop name if any shop is selected
                                  if (controller.selectedShop.isNotEmpty) {
                                    final selectedShop =
                                    controller.customerData.firstWhere(
                                          (shop) =>
                                      shop.intShopId.toString() ==
                                          controller.selectedShop.value,
                                    );
                                    return Text(
                                      selectedShop.shopName ?? 'Unnamed Shop',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    );
                                  }
                                  return const SizedBox();
                                }),
                              ],
                            ),
                          ),
                        ),
                        Obx(() {
                          // Show dropdown only when `showDropdown` is true
                          if (controller.showDropdown.isTrue) {
                            if (controller.isScreenProgress.isTrue) {
                              return const CircularProgressIndicator();
                            }
                            if (controller.customerData.isEmpty) {
                              return const Text('No shops available');
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.deepPurpleAccent, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Select Shop'),
                                  value: controller.selectedShop.isNotEmpty
                                      ? controller.selectedShop.value
                                      : null,
                                  // Selected value from the dropdown
                                  items: controller.customerData.map((shop) {
                                    return DropdownMenuItem<String>(
                                      value: shop.intShopId.toString(),
                                      child: Text(shop.shopName ?? 'Unnamed Shop'),
                                    );
                                  }).toList(),
                                  onChanged: (selectedValue) {
                                    // Handle shop selection and hide dropdown
                                    controller.selectedShop(selectedValue!);
                                    controller.showDropdown.value =
                                    false; // Hide the dropdown
                                    print('Selected shop: $selectedValue');
                                  },
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox(); // Hide dropdown when not active
                          }
                        }),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            // Define the border color here
                            borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0),
                            // Padding inside the container

                            child: TextFormField(
                            controller: controller.cusnameCtrl,
                            focusNode: controller.cusnameCtrlfNode,
                              decoration: InputDecoration(
                                labelText: 'Title',
                                border: InputBorder.none,
                                // Removes the default underline
                                labelStyle: TextStyle(
                                    color: Colors.grey), // Label color
                              ),                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s")),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please title';
                              }
                              if (value.length < 3) {
                                return 'Invalid title. Title must be at least 3 characters long.';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          )   ),
                        SizedBox(height: Get.height * .01),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            // Define the border color here
                            borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0),
                            // Padding inside the container

                          child: TextFormField(
                            controller: controller.phonenumCtrl,
                            focusNode: controller.phonenumCtrlfNode,
                            decoration: InputDecoration(
                              labelText: 'Note',
                              border: InputBorder.none,
                              // Removes the default underline
                              labelStyle: TextStyle(
                                  color: Colors.grey), // Label color
                            ),
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s")),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please title';
                              }
                              if (value.length < 3) {
                                return 'Invalid title. Title must be at least 3 characters long.';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          )  ),
                        SizedBox(height: Get.height * .03),
                        Center(
                          child: MAButton(
                            text: 'Submit',
                            buttonPress: () {
                              MyUtils.hideKeyboard();
                              if (controller.formKey.currentState!.validate()) {
                                // Call the submit function to send the lead details to the server
                                controller.submitLeadDetails();
                              }
                            },
                            colors: Colors.white,
                            color: MyTheme.appColor,
                            isEnabled: true,
                            padding: const EdgeInsets.all(30),
                            height: Get.height * 0.07,
                            width: Get.width * 0.4,
                            clipBehavior: 0,
                            radius: 30,
                            fontSize: 20,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration textBoxDecoration(hintText) {
  return InputDecoration(
    hintText: hintText,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    hintStyle: MyTheme.regularTextStyle(
        fontSize: Get.height * .018, color: Colors.black),
  );
}
