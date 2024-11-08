import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:smart_taurus/screens/new_sales_crm/view_complete_order/view_order_controller.dart';


class ViewOrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewOrderController>(
          () => ViewOrderController(),
    );
  }
}