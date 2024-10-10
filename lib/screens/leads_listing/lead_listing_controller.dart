import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/lead_listing_model.dart';
import '../../models/order_status_model.dart';
import '../../services/lead_listing_services.dart';
import '../../services/order_status_services.dart';

class LeadListingController extends GetxController {
  var selectedIndex = Rx<int?>(null); // Track selected item index
  RxList<Order> orderListData = <Order>[].obs; // Store Order data
  RxBool isScreenProgress = true.obs;

  @override
  void onInit() {
    fetchOrderList();
    super.onInit();
  }

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchOrderList() async {
    try {
      final ApiResp resp = await OrderStatusServices.getOrderList();
      if (resp.ok) {
        // Parse the order list data
        final orderStatusModel = OrderStatusModel.fromJson(resp.rdata);
        final ordersData = orderStatusModel.orders ?? [];

        // Assign the full Order data to orderListData
        orderListData.assignAll(ordersData);

        isScreenProgress.value = false; // Hide progress indicator
        print('Order data fetched successfully: ${orderListData.length} items');
      } else {
        // Handle API response failure
        isScreenProgress.value = false;
        print('Error fetching order data: ${resp.msgs}');
      }
    } catch (e) {
      // Handle errors during data fetching
      isScreenProgress.value = false;
      print('Error fetching order data: $e');
    }
  }
}
