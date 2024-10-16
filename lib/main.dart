import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_taurus/utils/my_theme.dart';
import 'package:smart_taurus/utils/routes.dart';

import 'app.dart';

void main() async{
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title', // Set your app title
      theme: ThemeData(
        primaryColor: Colors.blue, // Primary app color
        unselectedWidgetColor: Colors.blue, // Color for unselected widgets (e.g., checkboxes)
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.green), // Checkbox background color when checked
          checkColor: MaterialStateProperty.all(Colors.black), // Tick mark color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Rounded corners
        ),
      ),
      initialRoute: Routes.splash, // Ensure you have defined your routes
      getPages: Routes.routes,
    ),
  );
}