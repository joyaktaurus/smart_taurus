import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../models/customer_list_model.dart';

import '../../app.dart';
import '../../models/api_resp.dart';

import '../../models/product_listing_model.dart';
import '../../services/customerlist_services.dart';

class AddOrderController extends GetxController {
  var products = <ProductListing>[].obs; // Observable list to hold products

  RxList<Shop> customerData = <Shop>[].obs;
  RxBool isScreenProgress = true.obs;
  RxString selectedShop = ''.obs; // To hold the selected shop ID
  RxBool showDropdown = false.obs; // To control the visibility of the dropdown

  AddOrderController();

  void addProduct(ProductListing product) {
    products.add(product); // Add the product to the list
  }

  @override
  void onInit() {
    super.onInit();
    initialCustomersList();
  }

  // Fetch customer list
  Future<void> initialCustomersList() async {
    isScreenProgress.value = true;
    try {
      final ApiResp resp = await CustomerServices.getList();
      if (resp.ok) {
        final profileDetails = CustomerList.fromJson(resp.rdata);
        customerData.assignAll(profileDetails.shop ?? []);
        isScreenProgress.value = false;
      } else {
        isScreenProgress.value = false;
      }
    } catch (e) {
      isScreenProgress.value = false;
    }
  }

  void selectShop(String shopId) {
    selectedShop.value = shopId;
    showDropdown.value = false;
  }
}
