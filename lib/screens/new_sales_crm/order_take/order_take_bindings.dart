import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'order_take_controller.dart';

class OrderTakeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderTakeController>(
          () => OrderTakeController(),
    );
  }
}