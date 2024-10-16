import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/product_listing_model.dart';
import '../../services/product_listing_services.dart';
import '../../services/product_search_services.dart';
import '../../utils/routes.dart';

class ProductViewController extends GetxController {
  final TextEditingController searchCntrl = TextEditingController(text: '');
  final TextEditingController quantityCntrl = TextEditingController(text: '');

  // Observable list of products
  var proData = <ProductListing>[].obs;

  // Reactive variables for UI states
  RxBool isScreenProgress = true.obs;
  RxDouble finalAmount = 0.0.obs;
  List<ProductListing> originalList = []; // Store the original product list here

  // Updates final amount based on quantity and rate
  void updateFinalAmount(String quantity, double rate) {
    int qty = int.tryParse(quantity) ?? 0;
    finalAmount.value = qty * rate;
  }

  @override
  void onInit() {
    initialCustomersList();
    super.onInit();
  }

  // Method to add product to the order, including product ID
  void addProductToOrder(String productId, String productName, double amount) {
    Get.toNamed(Routes.addOrder, arguments: {
      'productId': productId,
      'productName': productName,
      'finalAmount': amount,
    });
  }

  // Fetch the product list from API
  Future<void> initialCustomersList() async {
    try {
      final ApiResp resp = await ProductServices.getproductList();
      if (resp.ok) {
        final prodDetails = ProductListingModel.fromJson(resp.rdata);
        originalList = prodDetails.shop ?? []; // Store the original list
        proData.assignAll(originalList); // Assign to the reactive list
        isScreenProgress.value = false;
        print('Product data fetched successfully: ${proData.length} items');
      } else {
        isScreenProgress.value = false;
        print('Error fetching product data: ${resp.msgs}');
      }
    } catch (e) {
      isScreenProgress.value = false;
      print('Error fetching product data: $e');
    }
  }

  void searchBtn() async {
    String productName = searchCntrl.text.trim();
    if (productName.isNotEmpty) {
      ApiResp response = await ProductSearchServices.fetchSearchListProduct(productName);
      if (response.ok) {
        if (response.rdata is Map<String, dynamic> && response.rdata.containsKey('product')) {
          List<dynamic> products = response.rdata['product'];
          proData.assignAll(products.map((data) => ProductListing.fromJson(data)).toList());
        } else {
          print('No products found.');
        }
      } else {
        print('Search request failed: ${response.msgs[0]}');
      }
    }
  }

  void restoreOriginalList() {
    proData.assignAll(originalList); // Restore the original list
    isScreenProgress.value = false; // No need to show progress bar
  }

  void searchSuffixIconBtn() {
    // Clear the search term and restore original product list
    searchCntrl.clear();
    proData.assignAll(originalList); // Restore the original list
    isScreenProgress.value = false; // No need to show progress bar
  }

  void searchOnChangeFn(String val) {
    if (val.isEmpty) {
      searchCntrl.clear();
      restoreOriginalList(); // Restore original list when search field is empty
    } else {
      // Filter the original list based on the input
      List<ProductListing> filteredList = originalList.where((customer) {
        // Check if customerName and shopName are not null
        final customerName = customer.productName?.toLowerCase() ?? '';
        // final shopName = customer.shopName?.toLowerCase() ?? '';
        return customerName.startsWith(val.toLowerCase());
      }).toList();

      proData.assignAll(filteredList); // Update the customerData with filtered list
    }
  }


  void onFieldSubmittedFn(val) async {
    searchBtn();
  }

  Map customersListApiPayload = {};
  final TextEditingController ProductSearchCntrl = TextEditingController(text: '');
  RxBool isCloseButtonVisible = true.obs;


  // void searchSuffixIconBtn() {
  //   // Clear API payload and search controller
  //   customersListApiPayload.clear();
  //   ProductSearchCntrl.clear();
  //
  //   // Set progress state to false as no progress indicator is needed
  //   isScreenProgress.value = false;
  //
  //   // Restore the original list to myList
  //   proData.value = List<ProductListing>.from(originalList);
  //
  //   // Clear the search term
  //   searchCntrl.clear();
  //
  //   // Hide the close button
  //   isCloseButtonVisible.value = false; // Ensure you have a variable to control visibility
  // }

  RxString searchTypeChosenValue = 'Name / P/N or SKU'.obs;

}