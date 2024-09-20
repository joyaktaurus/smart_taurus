import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'lead_form_controller.dart';

class LeadSubmitBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadSubmitController>(
          () => LeadSubmitController(),
    );
  }
}