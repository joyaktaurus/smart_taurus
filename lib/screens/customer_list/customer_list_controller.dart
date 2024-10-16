import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/customer_list_model.dart';
import '../../services/customerlist_services.dart';
import '../../services/shop_search_services.dart';
import '../../utils/routes.dart';

class CustomerListController extends GetxController {
  var selectedIndex = Rx<int?>(null); // Track selected item index
  Map customersListApiPayload = {};

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  RxList<Shop> customerData = (List<Shop>.of([])).obs;
  RxBool isScreenProgress = true.obs;
  final TextEditingController searchCntrl = TextEditingController(text: '');

  List<Shop> originalList = []; // Store the original list of customers here

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

  void searchOnChangeFn(String val) {
    if (val.isEmpty) {
      searchCntrl.clear();
      restoreOriginalList(); // Restore original list when search field is empty
    } else {
      // Filter the original list based on the input
      List<Shop> filteredList = originalList.where((customer) {
        // Check if customerName and shopName are not null
        final customerName = customer.customerName?.toLowerCase() ?? '';
        final shopName = customer.shopName?.toLowerCase() ?? '';
        return customerName.startsWith(val.toLowerCase()) || shopName.startsWith(val.toLowerCase());
      }).toList();

      customerData.assignAll(filteredList); // Update the customerData with filtered list
    }
  }


  void onFieldSubmittedFn(val) async {
    searchBtn();
  }

  Future<void> initialCustomersList() async {
    try {
      final ApiResp resp = await CustomerServices.getList();
      if (resp.ok) {
        final profileDetails = CustomerList.fromJson(resp.rdata);
        customerData.assignAll(profileDetails.shop ?? []);
        originalList = List.from(customerData); // Store the original list
        App.cusdetails = customerData;
        isScreenProgress.value = false; // Hide progress indicator
      } else {
        isScreenProgress.value = false;
        print('Error fetching profile data: ${resp.msgs}');
      }
    } catch (e) {
      isScreenProgress.value = false;
      print('Error fetching profile data: $e');
    }
  }
  RxString searchTypeChosenValue = 'Name / P/N or SKU'.obs;

  void searchSuffixIconBtn() {
    searchCntrl.clear();
    restoreOriginalList(); // Restore the original list when clear is clicked
  }

  void restoreOriginalList() {
    customerData.assignAll(originalList); // Restore the original list
    isScreenProgress.value = false; // No need to show progress bar
  }

  @override
  void onInit() {
    initialCustomersList();
    super.onInit();
  }
}
