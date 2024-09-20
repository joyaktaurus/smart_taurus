import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'lead_listing_controller.dart';

class LeadListingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadListingController>(
          () => LeadListingController(),
    );
  }
}