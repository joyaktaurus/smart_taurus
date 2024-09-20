import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'add_order_controller.dart';

class AddOrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrderController>(
          () => AddOrderController(),
    );
  }
}