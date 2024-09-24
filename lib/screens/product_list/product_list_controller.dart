import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/product_listing_model.dart';
import '../../services/product_listing_services.dart';
import '../../utils/routes.dart';

class ProductListingController extends GetxController {
  final TextEditingController searchCntrl = TextEditingController(text: '');
  final TextEditingController quantityCntrl = TextEditingController(text: '');
  void addProduct(ProductListing product) {
    proData.add(product); // Add the product to the list
  }
  var proData = <ProductListing>[].obs; // Observable list of products

 // RxList<ProductListing> proData = <ProductListing>[].obs;
  RxBool isScreenProgress = true.obs;
  RxDouble finalAmount = 0.0.obs; // Add this line for final amount
  void updateFinalAmount(String quantity, double rate) {
    int qty = int.tryParse(quantity) ?? 0;
    finalAmount.value = qty * rate; // Use the reactive variable
  }
  @override
  void onInit() {
    initialCustomersList();
    super.onInit();
  }
  void addProductToOrder(String productName, double amount) {
    // Logic for adding the product to the order
    Get.toNamed(Routes.addOrder, arguments: {
      'productName': productName,
      'finalAmount': amount,
    });
  }


  Future<void> initialCustomersList() async {
    try {
      final ApiResp resp = await ProductServices.getproductList();
      if (resp.ok) {
        final prodDetails = ProductListingModel.fromJson(resp.rdata);
        // Assign the list or an empty list if shop is null
        proData.assignAll(prodDetails.shop ?? []);
        App.prodDetails = proData;
        isScreenProgress.value = false; // Hide progress indicator
        print('Profile data fetched successfully: ${proData.length} items');
      } else {
        // Handle the case when the API response is not successful
        isScreenProgress.value = false;
        print('Error fetching profile data: ${resp.msgs}');
      }
    } catch (e) {
      // Handle errors during data fetching
      isScreenProgress.value = false;
      print('Error fetching profile data: $e');
    }
  }


  void searchBtn() async {
    // String shopName = searchCntrl.text.trim();
    // if (shopName.isNotEmpty) {
    //   ApiResp response = await SearchListServices.fetchSearchList(shopName);
    //   if (response.ok) {
    //     if (response.rdata is List) {
    //       myList.assignAll(response.rdata.map((data) => Shop.fromJson(data)));
    //     } else if (response.rdata is Map<String, dynamic>) {
    //       Map<String, dynamic> data = response.rdata;
    //       if (data.containsKey('shop')) {
    //         myList.assignAll((data['shop'] as List).map((data) => Shop.fromJson(data)));
    //       }
    //     }
    //   } else {
    //     print('Search request failed: ${response.msgs[0].msg}');
    //   }
    // }
  }

  void searchOnChangeFn(val) async {
    if (val.isEmpty) {
      searchCntrl.clear();
    }
  }


  void onFieldSubmittedFn(val) async {
    searchBtn();
  }


  void searchSuffixIconBtn() {
    // Clear API payload and search controller
    // customersListApiPayload.clear();
    // CustomersSearchCntrl.clear();
    //
    // // Set progress state to false as no progress indicator is needed
    // isScreenProgress.value = false;
    //
    // // Restore the original list to myList
    // myList.value = List<Shop>.from(originalList);
    //
    // // Clear the search term
    // searchCntrl.clear();
    //
    // // Hide the close button
    // isCloseButtonVisible.value = false; // Ensure you have a variable to control visibility
  }

  RxString searchTypeChosenValue = 'Name / P/N or SKU'.obs;

}