import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../models/customer_list_model.dart';

import '../../app.dart';
import '../../models/api_resp.dart';

import '../../models/product_listing_model.dart';
import '../../services/customerlist_services.dart';

class AddOrderController extends GetxController {
  var products = <ProductListing>[].obs; // Observable list to hold products
  RxString selectedShop = ''.obs; // To hold the selected shop ID

  RxList<Shop> customerData = <Shop>[].obs;
  RxBool isScreenProgress = true.obs;
  RxBool showDropdown = false.obs; // To control the visibility of the dropdown


  final String productName; // Declare productName as final
  RxDouble finalAmount = 0.0.obs; // Observable for final amount

  // Initialize productName and finalAmount in the constructor
  AddOrderController({required this.productName, required double finalAmount}) {
    this.finalAmount.value = finalAmount; // Assign the initial value to RxDouble
  }

  // Increment product quantity
  void countIncrement(ProductListing product) {
    product.quantity++; // Increment the quantity
    updateFinalAmount(); // Update the final amount
    products.refresh(); // Refresh the list to update UI
  }

  // Decrement product quantity
  void countDecrement(ProductListing product) {
    if (product.quantity > 0) {
      product.quantity--; // Decrease the quantity
      updateFinalAmount(); // Update the final amount
      products.refresh(); // Refresh the list to update UI
    }
  }
  // void addProduct(ProductListing product) {
  //   // Check if the product with the same ID already exists in the list
  //   final existingProduct = products.firstWhereOrNull((p) => p.productId == product.productId);
  //
  //   if (existingProduct == null) {
  //     // If product is being added for the first time, set its quantity to 1
  //     product.quantity = 1;
  //     products.add(product); // Add the product to the list
  //     updateFinalAmount(); // Update the final amount
  //   } else {
  //     // Optionally, show a message that the product already exists
  //    // print("Product with ID ${product.id} is already in the list.");
  //    // print("Product with ID ${product.id} is already in the list.");
  //   }
  // }

  // Add new product and recalculate final amount
  void addProduct(ProductListing product) {
    product.quantity = 1;
    products.add(product); // Add the product to the list
    updateFinalAmount(); // Update the final amount
  }

  // Update final amount based on product prices and quantities
  void updateFinalAmount() {
    finalAmount.value = products.fold(0.0, (sum, item) {
      double price = double.tryParse(item.price.toString()) ?? 0.0;
      return sum + (price * item.quantity); // Calculate total based on quantity
    });
  }

  @override
  void onInit() {
    super.onInit();
    initialCustomersList();
  }

  // Fetch customer list
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
}
