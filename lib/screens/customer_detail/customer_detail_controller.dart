import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/api_resp.dart';
import '../../models/customer_detail_model.dart';
import '../../services/customer_detail_services.dart';

class CustomerDetailController extends GetxController {

  RxBool isScreenProgress = false.obs;
  Rx<Shopp?> customerDetails = Rx<Shopp?>(null);
  int? shopId;

  CustomerDetailController(int i); // Define amcId property to hold the current amcId

  @override
  void onInit() {
    super.onInit();
    // Retrieve amcId from arguments and safely cast/convert it to an integer
    if (Get.arguments is String) {
      shopId = int.tryParse(Get.arguments); // Safely convert from String to int
    } else {
      shopId = Get.arguments as int?; // If already int, just cast
    }

    if (shopId != null) {
      fetchDetails();
    } else {
      print("Error: shopId is null or invalid");
    }
  }


  void fetchDetails() async {
    if (shopId != null) {
      await initialDataFetching(shopId!);
    } else {
      print("Error: amcId is null");
    }
  }

  Future<void> initialDataFetching(int shopId) async {
    isScreenProgress.value = true;
    final ApiResp itemDetailsResp = await CustomerDetailServices.fetchCustomerDetails(shopId);

    if (itemDetailsResp.ok == null || !itemDetailsResp.ok!) {
      isScreenProgress.value = false;
      return;
    } else {
      if (itemDetailsResp.rdata['shop'] != null) {
        // Parse the first shop from the list
        customerDetails.value = Shopp.fromJson(itemDetailsResp.rdata['shop'][0]);
      } else {
        print('Error: Shop data is null');
      }

      isScreenProgress.value = false;
    }
  }



}