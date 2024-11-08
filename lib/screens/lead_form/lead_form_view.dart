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
import 'lead_form_controller.dart';

class LeadSubmit extends GetView<LeadSubmitController> {
  const LeadSubmit({Key? key}) : super(key: key);

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
            'Lead Form',
            style: TextStyle(color: Colors.black),
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.notification_add_outlined, color: Colors.black),
          //     onPressed: () {
          //       Get.toNamed(Routes.dashBoard);
          //     },
          //   ),
          // ],
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
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.appColor),
                              // Define the border color here
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              // Padding inside the container
                              child: TextFormField(
                                controller: controller.shopnameCtrl,
                                focusNode: controller.shopnameCtrlfNode,
                                decoration: InputDecoration(
                                  labelText: 'Shop Name',
                                  border: InputBorder.none,
                                  // Removes the default underline
                                  labelStyle: TextStyle(
                                      color: Colors.grey), // Label color
                                ),
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[a-zA-Z\s]+")),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a shop name';
                                  }
                                  if (value.length < 3) {
                                    return 'Invalid name. Name must be at least 3 characters long.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * .02),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: MyTheme.appColor),
                                // Define the border color here
                                borderRadius: BorderRadius.circular(
                                    30), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.cusnameCtrl,
                                  focusNode: controller.cusnameCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Customer Name',
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
                                      return 'Please enter customer name';
                                    }
                                    if (value.length < 3) {
                                      return 'Invalid name. Name must be at least 3 characters long.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                ),
                              )),
                          SizedBox(height: Get.height * .02),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: MyTheme.appColor),
                                // Define the border color here
                                borderRadius: BorderRadius.circular(
                                    30), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: controller.phonenumCtrl,
                                  focusNode: controller.phonenumCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    border: InputBorder.none,
                                    // Removes the default underline
                                    labelStyle: TextStyle(
                                        color: Colors.grey), // Label color
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    String patttern =
                                        r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
                                    RegExp regExp = new RegExp(patttern);
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter mobile number';
                                    } else if (!regExp.hasMatch(value)) {
                                      return 'Please enter valid mobile number';
                                    }
                                    return null;
                                  },
                                ),
                              )),
                          SizedBox(height: Get.height * .02),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: MyTheme.appColor),
                                // Define the border color here
                                borderRadius: BorderRadius.circular(
                                    30), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.emailCtrl,
                                  focusNode: controller.emailCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'E-mail',
                                    border: InputBorder.none,
                                    // Removes the default underline
                                    labelStyle: TextStyle(
                                        color: Colors.grey), // Label color
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    String pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = RegExp(pattern);
                                    if (!regex.hasMatch(value!))
                                      return 'Enter Valid Email';
                                    else
                                      return null;
                                  },
                                ),
                              )),
                          SizedBox(height: Get.height * .02),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: MyTheme.appColor),
                                // Define the border color here
                                borderRadius: BorderRadius.circular(
                                    30), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.orgCtrl,
                                  focusNode: controller.orgCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Organisation',
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
                                      return 'Please enter organization';
                                    }
                                    if (value.length < 3) {
                                      return 'Invalid name. Name must be at least 3 characters long.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                ),
                              )),
                          SizedBox(height: Get.height * .02),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: MyTheme.appColor),
                                // Define the border color here
                                borderRadius: BorderRadius.circular(
                                    30), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.gstCtrl,
                                  focusNode: controller.gstCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'GST Number',
                                    border: InputBorder.none,
                                    // Removes the default underline
                                    labelStyle: TextStyle(
                                        color: Colors.grey), // Label color
                                  ),
                                  textInputAction: TextInputAction.next,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                                  // ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter GST number';
                                    }
                                    if (value.length < 3) {
                                      return 'Invalid name. Name must be at least 3 characters long.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                ),
                              )),
                          SizedBox(height: Get.height * .02),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.appColor),
                              // Define the border color here
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.pancardCtrl,
                                  focusNode: controller.pancardCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Pancard',
                                    border: InputBorder.none,
                                    // Removes the default underline
                                    labelStyle: TextStyle(
                                        color: Colors.grey), // Label color
                                  ),
                                  textInputAction: TextInputAction.next,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                                  // ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter pancard details';
                                    }
                                    if (value.length < 3) {
                                      return 'Invalid name. Name must be at least 3 characters long.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                )),
                          ),
                          SizedBox(height: Get.height * .02),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.appColor),
                              // Define the border color here
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.categoryCtrl,
                                  focusNode: controller.categoryCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Category',
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
                                      return 'Please enter category information';
                                    }
                                    if (value.length < 3) {
                                      return 'Invalid name. Name must be at least 3 characters long.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                )),
                          ),
                          SizedBox(height: Get.height * .02),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.appColor),
                              // Define the border color here
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,

                                  controller: controller.budgetCtrl,
                                  focusNode: controller.budgetCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Budget Informations',
                                    border: InputBorder.none,
                                    // Removes the default underline
                                    labelStyle: TextStyle(
                                        color: Colors.grey), // Label color
                                  ),
                                  textInputAction: TextInputAction.next,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                                  // ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter budget informations';
                                    }
                                    if (value.length < 3) {
                                      return 'Invalid name. Name must be at least 3 characters long.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                )),
                          ),
                          SizedBox(height: Get.height * .02),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: MyTheme.appColor),
                                // Define the border color here
                                borderRadius: BorderRadius.circular(
                                    30), // Rounded corners
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.brandCtrl,
                                  focusNode: controller.brandCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Brand Informations',
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
                                      return 'Please enter brand informations';
                                    }
                                    if (value.length < 3) {
                                      return 'Invalid name. Name must be at least 3 characters long.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                ),
                              )),
                          SizedBox(height: Get.height * .02),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.appColor),
                              // Define the border color here
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.addressoneCtrl,
                                  focusNode: controller.addressoneCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Address Line 1',
                                    border: InputBorder.none,
                                    // Removes the default underline
                                    labelStyle: TextStyle(
                                        color: Colors.grey), // Label color
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter address';
                                    }
                                    if (value.length < 3) {
                                      return 'Invalid address. Address must be at least 3 characters long.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                )),
                          ),
                          SizedBox(height: Get.height * .02),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.appColor),
                              // Define the border color here
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.addresstwoCtrl,
                                  focusNode: controller.addresstwoCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Address Line 2',
                                    border: InputBorder.none,
                                    // Removes the default underline
                                    labelStyle: TextStyle(
                                        color: Colors.grey), // Label color
                                  ),
                                  textInputAction: TextInputAction.next,
                                )),
                          ),
                          SizedBox(height: Get.height * .02),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.appColor),
                              // Define the border color here
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: controller.pincodeCtrl,
                                    focusNode: controller.pincodeCtrlfNode,
                                    decoration: InputDecoration(
                                      labelText: 'Pincode',
                                      border: InputBorder.none,
                                      // Removes the default underline
                                      labelStyle: TextStyle(
                                          color: Colors.grey), // Label color
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      String patttern =
                                          r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
                                      RegExp regExp = new RegExp(patttern);
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter pincode';
                                      } else {
                                        return null;
                                      }
                                    })),
                          ),
                          SizedBox(height: Get.height * .02),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.appColor),
                              // Define the border color here
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.instructCtrl,
                                  focusNode: controller.instructCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Instructions',
                                    border: InputBorder.none,
                                    // Removes the default underline
                                    labelStyle: TextStyle(
                                        color: Colors.grey), // Label color
                                  ),
                                  textInputAction: TextInputAction.next,
                                )),
                          ),
                          SizedBox(height: Get.height * .03),
                          Center(
                            child: MAButton(
                              text: 'Submit',
                              buttonPress: () {
                                MyUtils.hideKeyboard();
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  // All fields are valid, perform the submit operation
                                  errM(() => controller.shopRegister());
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
