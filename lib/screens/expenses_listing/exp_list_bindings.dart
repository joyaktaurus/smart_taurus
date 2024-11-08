import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'exp_list_controller.dart';

class ExpenseListingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseListingController>(
          () => ExpenseListingController(),
    );
  }
}