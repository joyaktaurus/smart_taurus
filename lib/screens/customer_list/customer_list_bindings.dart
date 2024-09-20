import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'customer_list_controller.dart';


class CustomerlistdBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerListController>(
          () => CustomerListController(),
    );
  }
}