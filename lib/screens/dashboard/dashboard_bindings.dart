import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'dashboard_controller.dart';


class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
          () => DashboardController(),
    );
  }
}