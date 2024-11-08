import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../models/api_resp.dart';
import '../../../models/order_details_model.dart';
import '../../../services/order_detail_sevices.dart';

class ViewOrderController extends GetxController {
  var selectedIndex = Rx<int?>(null); // Track selected item index
  RxList<Detail> orderDetailData = <Detail>[].obs; // Store Detail data
  RxList<Order> orderData = <Order>[].obs; // Store Order data
  RxBool isScreenProgress = true.obs;
  int? orderId;

  @override
  void onInit() {
    super.onInit();
    // Retrieve orderId from arguments and safely cast/convert it to an integer
    if (Get.arguments is String) {
      orderId = int.tryParse(Get.arguments); // Safely convert from String to int
    } else {
      orderId = Get.arguments as int?; // If already int, just cast
    }

    if (orderId != null) {
      fetchDetails();
    } else {
      print("Error: orderId is null or invalid");
    }
  }

  void fetchDetails() async {
    if (orderId != null) {
      await fetchOrderList(orderId!);
    } else {
      print("Error: orderId is null");
    }
  }

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchOrderList(int orderId) async {
    isScreenProgress.value = true;
    final ApiResp itemDetailsResp = await OrderDetailServices.fetchOrderDetails(orderId);

    if (itemDetailsResp.ok == null || !itemDetailsResp.ok!) {
      isScreenProgress.value = false;
      return;
    } else {
      try {
        // Parse the OrderDetailsModel from the response
        final OrderDetailsModel orderDetails = OrderDetailsModel.fromJson(itemDetailsResp.rdata);

        // Assign parsed details and order data
        if (orderDetails.details != null) {
          orderDetailData.value = orderDetails.details!;
        } else {
          print('Error: Details data is null');
        }

        if (orderDetails.order != null) {
          orderData.value = orderDetails.order!;
        } else {
          print('Error: Order data is null');
        }
      } catch (e) {
        print('Error parsing data: $e');
      }

      isScreenProgress.value = false;
    }
  }

}
