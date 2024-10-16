import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import '../../components/app_buttons.dart';
import '../../utils/err_m.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import 'new_task_controller.dart';

class NewTaskView extends GetView<NewTaskController> {
  const NewTaskView({Key? key}) : super(key: key);

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
            'New Task',
            style: TextStyle(color: Colors.black),
          ),
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
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                // Padding inside the container
                                child: TextFormField(
                                  controller: controller.traFromCtrl,
                                //  focusNode: controller.traFromCtrlfNode,
                                  decoration: InputDecoration(
                                    labelText: 'Task',
                                    border: InputBorder.none,

                                    // Removes the default underline
                                    labelStyle: TextStyle(
                                        color: Colors.grey), // Label color
                                  ),
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[a-zA-Z]+|\s")),
                                  ],maxLines: 100,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter task';
                                    }
                                    if (value.length < 3) {
                                      return 'Invalid task. task must be at least 3 characters long.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                )),
                          ),
                          SizedBox(height: Get.height * .03),
                        Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: Get.width * .9,
                            height: Get.height * .08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.selectDate(context);
                                    },
                                    icon: Icon(Icons.calendar_month, color: MyTheme.myBlueDark),
                                  ),

                                  SizedBox(width: Get.width * 0.01),

                                  // Wrap the text or widget that might be causing the overflow in Expanded
                                  Expanded(
                                    child: Obx(
                                          () => Text(
                                        controller.selectedDate.value == null // If no date is selected
                                            ? "Select a Date and Time" // Placeholder text
                                            : DateFormat('yyyy-MM-dd – HH:mm').format(controller.selectedDate.value!), // Date and time formatted
                                        style: MyTheme.regularTextStyle(
                                          fontSize: Get.height * 0.018,
                                          color: controller.selectedDate.value == null
                                              ? Colors.grey  // Grey color for placeholder text
                                              : Colors.black, // Black for selected date and time
                                        ),
                                        overflow: TextOverflow.ellipsis,  // Ensures long text doesn't overflow
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                          SizedBox(height: Get.height * .01),
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


