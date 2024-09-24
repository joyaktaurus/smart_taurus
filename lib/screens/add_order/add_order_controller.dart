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
  final String productName; // Declare productName as final
  RxDouble finalAmount = 0.0.obs; // Observable for final amount

  // Initialize productName and finalAmount in the constructor
  AddOrderController({required this.productName, required double finalAmount}) {
    this.finalAmount.value = finalAmount; // Assign the initial value to RxDouble
  }

  void addProduct(ProductListing product) {
    products.add(product); // Add the product to the list
    updateFinalAmount(); // Update final amount when a new product is added
  }

  void updateFinalAmount() {
    finalAmount.value = products.fold(0.0, (sum, item) {
      double price = double.tryParse(item.price.toString()) ?? 0.0; // Ensure price is parsed as double
      return sum + (price * item.quantity); // Calculate total based on price and quantity
    });
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
      }
    } catch (e) {
      // Handle error
    } finally {
      isScreenProgress.value = false;
    }
  }
}

