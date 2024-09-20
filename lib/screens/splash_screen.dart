import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../app.dart';
import '../components/app_background.dart';
import '../utils/local_store.dart';
import '../utils/my_theme.dart';
import '../utils/routes.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(
  //     Duration(seconds: 3),
  //         () {
  //       Navigator.pushReplacementNamed(context, Routes.onboarding);
  //     },
  //   );
  // }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await FetchDataFromLocalStore().userData();
      App.token = App.user.apiToken ?? '';
      log("token>>${App.user.apiToken}");
      await checkAlreadyLogged();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/smart_logo.png"),
                  SizedBox(height: Get.height * 0.02),
                  Text(
                    "Smart Taurus",
                    style: MyTheme.regularTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.height * 0.037,
                    ),
                  ),
                  Text(
                    "Marketing App",
                    style: MyTheme.regularTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.height * 0.024,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  //
  Future<void> checkAlreadyLogged() async {
    await Future.delayed(const Duration(milliseconds: 1400));

    if (App.token.isNotEmpty) {
      Get.offAllNamed(Routes.dashBoard);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
