import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../components/app_background.dart';
import '../../components/app_buttons.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginViewController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MyUtils.hideKeyboard();
        },
        child: Scaffold(
            body: Background(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/logowhite.png"),
                SizedBox(height: 30),
                Text(
                  "Login",
                  style: MyTheme.regularTextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Get.height * 0.035,
                  ),
                ),
                Text(
                  "Let's get to work",
                  style: MyTheme.regularTextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.022,
                  ),
                ),
                SizedBox(height:  Get.height * 0.02),
                Container(
                  // width: Get.width * 0.9,  // Set your desired width
                  // height: Get.height * 0.07,  // Set your desired height
                  decoration: BoxDecoration(
                    color:  Color.fromRGBO(255, 255, 255, 0.56), // Background color of the container
                    borderRadius: BorderRadius.circular(30),  // Circular border
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: controller.usernameController,
                      style: TextStyle(color: Colors.white,fontSize: 18.0),  // Set text color to white
                      decoration: InputDecoration(
                        hintText: 'User Name',
                        hintStyle: TextStyle(color: Colors.white70),  // Set hint text color to a lighter shade of white
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person_outline, color: Colors.white),
                        // Remove default border
                      ),
                      contextMenuBuilder: (BuildContext context,
                          EditableTextState editableTextState) {
                        return AdaptiveTextSelectionToolbar(
                          anchors: editableTextState.contextMenuAnchors,
                          children: [
                            TextSelectionToolbarTextButton(
                              onPressed: () => editableTextState
                                  .cutSelection(SelectionChangedCause.toolbar),
                              padding: EdgeInsets.all(8),
                              child: const Text('Cut'),
                            ),
                            TextSelectionToolbarTextButton(
                              onPressed: () => editableTextState
                                  .copySelection(SelectionChangedCause.toolbar),
                              child: const Text('Copy'),
                              padding: EdgeInsets.all(8),
                            ),
                            TextSelectionToolbarTextButton(
                              onPressed: () => editableTextState
                                  .pasteText(SelectionChangedCause.toolbar),
                              child: const Text('Paste'),
                              padding: EdgeInsets.all(8),
                            ),
                            TextSelectionToolbarTextButton(
                              onPressed: () => editableTextState
                                  .selectAll(SelectionChangedCause.toolbar),
                              child: const Text('Select All'),
                              padding: EdgeInsets.all(8),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height:  Get.height * 0.02),
                Obx( () =>
                   Container(
                    // width: Get.width * 0.9,  // Set your desired width
                    // height: Get.height * 0.07,  // Set your desired height
                    decoration: BoxDecoration(
                      color:  Color.fromRGBO(255, 255, 255, 0.56), // Background color of the container
                      borderRadius: BorderRadius.circular(30),  // Circular border
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        obscureText: !controller.showPassword.value,
                        controller: controller.passwordController,
                        style: TextStyle(color: Colors.white,fontSize: 18.0),  // Set text color to white
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white70),  // Set hint text color to a lighter shade of white
                          border: InputBorder.none,
                          suffixIcon:  IconButton(
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                            icon: Icon(controller.showPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,color: Colors.white,),
                          ),
                          prefixIcon: Icon(Icons.lock_open_outlined, color: Colors.white),// Remove default border
                        ),
                        textInputAction: TextInputAction.next,
                        contextMenuBuilder: (BuildContext context,
                            EditableTextState editableTextState) {
                          return AdaptiveTextSelectionToolbar(
                            anchors: editableTextState.contextMenuAnchors,
                            children: [
                              TextSelectionToolbarTextButton(
                                onPressed: () => editableTextState
                                    .cutSelection(SelectionChangedCause.toolbar),
                                padding: EdgeInsets.all(8),
                                child: const Text('Cut'),
                              ),
                              TextSelectionToolbarTextButton(
                                onPressed: () => editableTextState
                                    .copySelection(SelectionChangedCause.toolbar),
                                child: const Text('Copy'),
                                padding: EdgeInsets.all(8),
                              ),
                              TextSelectionToolbarTextButton(
                                onPressed: () => editableTextState
                                    .pasteText(SelectionChangedCause.toolbar),
                                child: const Text('Paste'),
                                padding: EdgeInsets.all(8),
                              ),
                              TextSelectionToolbarTextButton(
                                onPressed: () => editableTextState
                                    .selectAll(SelectionChangedCause.toolbar),
                                child: const Text('Select All'),
                                padding: EdgeInsets.all(8),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height:  Get.height * 0.02),
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      controller.selfiePicFile.value = File(pickedFile.path);
                    }
                  },
                  child: Obx(
                        () => controller.selfiePicFile.value == null
                        ? Container(
                      height: Get.height * 0.2,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: Get.height * .05,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Tap to take a selfie",
                            style: MyTheme.regularTextStyle(
                              fontSize: Get.height * .018,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: Image.file(
                          controller.selfiePicFile.value!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ), Center(
                  child: Obx(
                        () => controller.isLoggingProgress.value == true
                        ? Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: const RoundedLoader(),
                    )
                        : MAButton(
                      text: 'Login',
                      buttonPress: () async {
                        controller.doLogin();
                      },
                          color: Colors.white,
                          colors:MyTheme.appColor,
                      isEnabled: true,
                      padding: const EdgeInsets.all(30),
                      height: Get.height * 0.06,
                      width: Get.width * 0.5,
                      clipBehavior: 0,
                      radius: 30,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.03,),
                Padding(
                  padding:  EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      // Define the border color here
                      borderRadius:
                      BorderRadius.circular(30), // Rounded corners
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/goog.png",width: 40,height: 40,),
                        SizedBox(width: Get.width * 0.03),
                        Text("Continue with google", style: TextStyle(color: Colors.white),)
                        // TextButton.icon(icon:  Icon(FontAwesomeIcons.google, color: Colors.white),
                        //   onPressed: () {},
                        //   style: TextButton.styleFrom(
                        //     side: const BorderSide(color: Colors.red),fixedSize: const Size(200, 40),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(40),
                        //     ),
                        //   ),
                        //   label: (const Text("Continue with google", style: TextStyle(color: Colors.white),)),
                        //
                        //   // child: Text("Continue with google"),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
