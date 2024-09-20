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
import 'expenses_controller.dart';

class ExpenseView extends GetView<ExpenseController> {
  const ExpenseView({Key? key}) : super(key: key);

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
              'Expenses',
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.traFromCtrl,
                            focusNode: controller.traFromCtrlfNode,
                            decoration: textBoxDecoration('Travel From'),
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s")),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter travel from';
                              }
                              if (value.length < 3) {
                                return 'Invalid name. Name must be at least 3 characters long.';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          SizedBox(height: Get.height * .01),
                          TextFormField(
                            controller: controller.traToCtrl,
                            focusNode: controller.traToCtrlNode,
                            decoration: textBoxDecoration('Travel To'),
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s")),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter travel to info';
                              }
                              if (value.length < 3) {
                                return 'Invalid name. Name must be at least 3 characters long.';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          SizedBox(height: Get.height * .01),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: controller.amountCtrl,
                            focusNode: controller.amountCtrlfNode,
                            decoration: textBoxDecoration('Amount'),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter travel amount';
                              }
                              if (value.length < 3) {
                                return 'Invalid data.';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          SizedBox(height: Get.height * .01),
                          TextFormField(
                            controller: controller.purposeCtrl,
                            focusNode: controller.purposeCtrlfNode,
                            decoration: textBoxDecoration('Purpose'),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter travel purpose';
                              }
                              if (value.length < 3) {
                                return 'Invalid data. Name must be at least 3 characters long.';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          SizedBox(height: Get.height * .01),
                          TextFormField(
                            controller: controller.traTypeCtrl,
                            focusNode: controller.traTypeCtrlfNode,
                            decoration: textBoxDecoration('Travel Type'),
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s")),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter travel type';
                              }
                              if (value.length < 3) {
                                return 'Invalid name. Name must be at least 3 characters long.';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          SizedBox(height: Get.height * .01),
                          TextFormField(
                            controller: controller.otherExCtrl,
                            focusNode: controller.otherExCtrlfNode,
                            decoration: textBoxDecoration('Other Expenses'),
                            textInputAction: TextInputAction.next,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                            // ],
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter GST number';
                            //   }
                            //   if (value.length < 3) {
                            //     return 'Invalid name. Name must be at least 3 characters long.';
                            //   }
                            //   return null; // Return null if the input is valid
                            // },
                          ),
                          SizedBox(height: Get.height * .01),
                          TextFormField(
                            controller: controller.traDateCtrl,
                            focusNode: controller.traDateCtrlfNode,
                            decoration: textBoxDecoration('Travel Date'),
                            textInputAction: TextInputAction.next,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                            // ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter travel date';
                              }
                              if (value.length < 3) {
                                return 'Invalid date';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          SizedBox(height: Get.height * .01),
                          Center(
                            child: MAButton(
                              text: 'Submit',
                              buttonPress: () {
                                MyUtils.hideKeyboard();
                                if (controller.formKey.currentState!.validate()) {
                                  // All fields are valid, perform the submit operation
                                  errM(() => controller.shopRegister());
                                }
                              },
                              colors: Colors.white,
                              color: Colors.deepPurpleAccent,
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
