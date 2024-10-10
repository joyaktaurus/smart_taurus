import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../app.dart';
import 'order_details_controller.dart';

class OrderDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailController>(
          () => OrderDetailController(),
    );
  }
}