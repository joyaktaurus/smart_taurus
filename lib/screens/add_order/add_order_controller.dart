import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../models/customer_list_model.dart';

import '../../app.dart';
import '../../models/api_resp.dart';

import '../../models/product_listing_model.dart';
import '../../services/customerlist_services.dart';

class AddOrderController extends GetxController {
  var products = <ProductListing>[].obs; // Observable list to hold products

  final String productName;
  final double finalAmount;

  RxList<Shop> customerData = <Shop>[].obs;
  RxBool isScreenProgress = true.obs;
  RxString selectedShop = ''.obs; // To hold the selected shop ID
  RxBool showDropdown = false.obs; // To control the visibility of the dropdown
  AddOrderController({required this.productName, required this.finalAmount});

  void addProduct(String name, String price) {
    products.add(ProductListing(productName: name, price: price)); // Add product
   // updateFinalAmount();
  }
  // void updateFinalAmount() {
  //   finalAmount.value = products.fold(0, (sum, item) => sum + item.amount);
  // }

  @override
  void onInit() {
    super.onInit();
    // Optionally load the customer list at the start
    initialCustomersList();
  }

  // Method to fetch customer list and update the observable list
  Future<void> initialCustomersList() async {
    isScreenProgress.value = true; // Show progress indicator
    try {
      final ApiResp resp = await CustomerServices.getList();
      if (resp.ok) {
        final profileDetails = CustomerList.fromJson(resp.rdata);
        customerData.assignAll(profileDetails.shop ?? []);
        App.cusdetails = customerData;
        isScreenProgress.value = false; // Hide progress indicator
        print('Profile data fetched successfully: ${customerData.length} items');
      } else {
        isScreenProgress.value = false;
        print('Error fetching profile data: ${resp.msgs}');
      }
    } catch (e) {
      isScreenProgress.value = false;
      print('Error fetching profile data: $e');
    }
  }

  // Method to handle the selection of a shop from the dropdown
  void selectShop(String shopId) {
    selectedShop.value = shopId;
    showDropdown.value = false; // Hide the dropdown after selection
    print('Selected Shop ID: $shopId');
  }
}