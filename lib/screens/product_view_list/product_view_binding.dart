import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:smart_taurus/screens/product_list/product_list_controller.dart';
import 'package:smart_taurus/screens/product_view_list/product_view_controller.dart';

class ProductViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductViewController>(
          () => ProductViewController(),
    );
  }
}