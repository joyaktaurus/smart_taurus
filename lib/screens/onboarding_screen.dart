import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/my_theme.dart';
import '../utils/routes.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(219, 233, 246, 1),
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/logo_blue.png"),
                SizedBox(height: Get.height * 0.02),
                Text(
                  "Manage Your",
                  style: MyTheme.regularTextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Get.height * 0.035,
                      color: Colors.black),
                ),
                Text(
                  "daily tasks",
                  style: MyTheme.regularTextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Get.height * 0.035,
                      color: Colors.black),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  "daily tasks fhfgh rfthrthyrtrt rtyrtyrty tryrtyry\n"
                  "tyrty rtyrtyr tryrtyrtyrtyrty tryrtyrty rtyrty",
                  style: MyTheme.regularTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Get.height * 0.018,
                      color: Colors.black),
                ),
                Row(
                  children: [
                    Container(
                        height: Get.height * 0.1,
                        width: Get.width * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(77, 82, 225, 1),
                        )),
                    SizedBox(width: Get.width * 0.015),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.login);
                      },
                      child: Text(
                        "Get Started",
                        style: MyTheme.regularTextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Get.height * 0.018,
                            color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
