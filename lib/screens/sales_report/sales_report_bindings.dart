import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:smart_taurus/screens/sales_report/sales_report_controller.dart';

class SalesReportBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesReportController>(
          () => SalesReportController(),
    );
  }
}