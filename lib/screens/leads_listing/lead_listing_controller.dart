import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/lead_listing_model.dart';
import '../../services/lead_listing_services.dart';

class LeadListingController extends GetxController {
  var selectedIndex = Rx<int?>(null); // Track selected item index
  RxList<Leads> leadListData = <Leads>[].obs; // Store Leads data
  RxBool isScreenProgress = true.obs;

  @override
  void onInit() {
    initialCustomersList();
    super.onInit();
  }

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  Future<void> initialCustomersList() async {
    try {
      final ApiResp resp = await LeadListingServices.getLeadList();
      if (resp.ok) {
        final leadListing = LeadListing.fromJson(resp.rdata);

        // Assign the full Leads data to leadListData
        final leadsData = leadListing.leads ?? [];
        leadListData.assignAll(leadsData);

        isScreenProgress.value = false; // Hide progress indicator
        print('Profile data fetched successfully: ${leadListData.length} items');
      } else {
        // Handle API response failure
        isScreenProgress.value = false;
        print('Error fetching profile data: ${resp.msgs}');
      }
    } catch (e) {
      // Handle errors during data fetching
      isScreenProgress.value = false;
      print('Error fetching profile data: $e');
    }
  }
}


