import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../app.dart';
import 'customer_detail_controller.dart';

class CustomerDetaildBindings extends Bindings {
  @override
  void dependencies() {
    int? userId = App.user.id;
    Get.lazyPut<CustomerDetailController>(
          () => CustomerDetailController(userId!),
    );
  }
}