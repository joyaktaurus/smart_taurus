import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/customer_list_model.dart';
import '../../services/customerlist_services.dart';
import '../../services/shop_search_services.dart';

class CustomerListController extends GetxController {
  var selectedIndex = Rx<int?>(null); // Track selected item index
  Map customersListApiPayload = {};

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  RxList<Shop> customerData = <Shop>[].obs;
  RxBool isScreenProgress = true.obs;
  final TextEditingController searchCntrl = TextEditingController(text: '');

  void searchBtn() async {
    String shopName = searchCntrl.text.trim();
    if (shopName.isNotEmpty) {
      ApiResp response = await SearchListServices.fetchSearchList(shopName);
      if (response.ok) {
        if (response.rdata is List) {
          customerData.assignAll(response.rdata.map((data) => Shop.fromJson(data)));
        } else if (response.rdata is Map<String, dynamic>) {
          Map<String, dynamic> data = response.rdata;
          if (data.containsKey('shop')) {
            customerData.assignAll((data['shop'] as List).map((data) => Shop.fromJson(data)));
          }
        }
      } else {
        print('Search request failed: ${response.msgs[0]}');
      }
    }
  }

  void searchOnChangeFn(val) async {
    if (val.isEmpty) {
      searchCntrl.clear();
    }
  }


  void onFieldSubmittedFn(val) async {
    searchBtn();
  }

  Future<bool> loadMore() async {
    log("onLoadMore");
    return true;
  }
  final TextEditingController CustomersSearchCntrl = TextEditingController(text: '');
  List<Shop>originalList=[];
  RxBool isCloseButtonVisible = true.obs;


  void searchSuffixIconBtn() {
   // Clear API payload and search controller
    customersListApiPayload.clear();
    CustomersSearchCntrl.clear();

    // Set progress state to false as no progress indicator is needed
    isScreenProgress.value = false;

    // Restore the original list to myList
    customerData.value = List<Shop>.from(originalList);

    // Clear the search term
    searchCntrl.clear();

    // Hide the close button
    isCloseButtonVisible.value = false; // Ensure you have a variable to control visibility
  }

  RxString searchTypeChosenValue = 'Name / P/N or SKU'.obs;

  @override
  void onInit() {
    initialCustomersList();
    super.onInit();
  }

  Future<void> initialCustomersList() async {
    try {
      final ApiResp resp = await CustomerServices.getList();
      if (resp.ok) {
        final profileDetails = CustomerList.fromJson(resp.rdata);
        // Assign the list or an empty list if shop is null
        customerData.assignAll(profileDetails.shop ?? []);
        App.cusdetails = customerData;
        isScreenProgress.value = false; // Hide progress indicator
        print('Profile data fetched successfully: ${customerData.length} items');
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

}