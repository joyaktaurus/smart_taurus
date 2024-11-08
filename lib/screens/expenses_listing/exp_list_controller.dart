import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/api_resp.dart';
import '../../models/exp_listing_model.dart';
import '../../services/expenses_list_services.dart';

class ExpenseListingController extends GetxController {
  RxList<Expense> expListData = <Expense>[].obs; // Store Order data

  RxBool isScreenProgress = true.obs;

  @override
  void onInit() {
    fetchOrderList();
    super.onInit();
  }

  Future<void> fetchOrderList() async {
    try {
      final ApiResp resp = await ExpListingServices.getList();
      if (resp.ok) {
        // Parse the order list data
        final orderStatusModel = ExpensesListing.fromJson(resp.rdata);
        final ordersData = orderStatusModel.expenses ?? [];

        // Assign the full Order data to orderListData
        expListData.assignAll(ordersData);

        isScreenProgress.value = false; // Hide progress indicator
        print('Order data fetched successfully: ${expListData.length} items');
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