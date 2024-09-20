import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smart_taurus/utils/my_extensions.dart';
import 'dart:io';
import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/login_model.dart';
import '../../services/login_services.dart';
import '../../utils/err_m.dart';
import '../../utils/local_store.dart';
import '../../utils/routes.dart';

class LoginViewController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool showPassword = false.obs;

  RxBool isLoggedIn = false.obs;
  final FocusNode userCtrlfocusNode = FocusNode();
  final FocusNode pswdCtrlfocusNode = FocusNode();
  RxBool isLoggingProgress = false.obs;

  // Controller for the image file
  Rx<File?> selfiePicFile = Rx<File?>(null);

  void togglePasswordVisibility() {
    showPassword.toggle();
  }

  Future<void> doLogin() async {
    log("Starting login process");
    LocalStore.clearData();
    isLoggingProgress.value = true;
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (!username.isValidEmail()) {
      userCtrlfocusNode.requestFocus();
      showMsg('Please provide a valid User Name', 'Invalid');
      isLoggingProgress.value = false;
    } else if (!password.isValidPassword()['isValid']) {
      pswdCtrlfocusNode.requestFocus();
      showMsg('Please provide a valid Password', 'Invalid');
      isLoggingProgress.value = false;
    } else if (selfiePicFile.value == null) {
      showMsg('Please provide a selfie picture', 'Invalid');
      isLoggingProgress.value = false;
    } else {
      try {
        // Get the current location
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Get placemark from the current location
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        //
        String subLocality = placemarks.isNotEmpty ? placemarks[0].subLocality ?? '' : '';
        String locality = placemarks.isNotEmpty ? placemarks[0].locality ?? '' : '';

        // Combine subLocality and locality with a comma
        String place = '$subLocality, $locality';

        log("Login data: ${jsonEncode({'username': username, 'password': password,
          'latitude': position.latitude, 'longitude': position.longitude,
          'place': place
        })}");

        final ApiResp resp = await LoginServices.fetchUser(
          username,
          password,
          selfiePicFile.value!,
          position.latitude.toString(),
          position.longitude.toString(),
          place,
        );

        log("Response received: ${jsonEncode(resp)}");

        if (resp.ok == false) {
          Get.snackbar(
            "Incorrect credentials",
            "Please check your username and password",
            backgroundColor: Colors.red,
          );
          isLoggingProgress.value = false;
          return;
        }

        if (resp.rdata == null || resp.rdata is! Map<String, dynamic>) {
          Get.snackbar(
            "Error",
            "Unexpected response format",
            backgroundColor: Colors.red,
          );
          isLoggingProgress.value = false;
          return;
        }

        try {
          User user = User.fromJson(resp.rdata);
          if (user.employeeDetails == null || user.employeeDetails!.apiToken == null) {
            Get.snackbar("Failed", "Login failed", backgroundColor: Colors.red);
            isLoggingProgress.value = false;
            return;
          }

          LocalStore.setData('user_id', user.employeeDetails!.id);
          LocalStore.setData('token', user.employeeDetails!.apiToken);
          LocalStore.setData('name', user.employeeDetails!.name);
          LocalStore.setData('phone', user.employeeDetails!.phone);
          LocalStore.setData('email', user.employeeDetails!.email);
          isLoggingProgress.value = false;
          App.user = user.employeeDetails!;
          App.token = user.employeeDetails!.apiToken!;

          Get.offAllNamed(Routes.dashBoard);
        } catch (e) {
          Get.snackbar(
            "Error",
            "Failed to parse user data",
            backgroundColor: Colors.red,
          );
          isLoggingProgress.value = false;
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Failed to get location data",
          backgroundColor: Colors.red,
        );
        isLoggingProgress.value = false;
      }
    }
  }
}

void log(String message) {
  debugPrint('Log: $message');
}