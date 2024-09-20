import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:smart_taurus/screens/product_list/product_list_controller.dart';

class ProductListingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListingController>(
          () => ProductListingController(),
    );
  }
}