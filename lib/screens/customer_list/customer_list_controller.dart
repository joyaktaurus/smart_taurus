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
  final TextEditingController CustomersSearchCntrl = TextEditingController(text: '');

  RxBool isCloseButtonVisible = false.obs;
  RxString searchTypeChosenValue = 'Name / P/N or SKU'.obs;

  List<Shop> originalList = [];

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
        customerData.assignAll(profileDetails.shop ?? []);
        originalList = List<Shop>.from(customerData);
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
        isCloseButtonVisible.value = true; // Show the close button
      } else {
        print('Search request failed: ${response.msgs[0]}');
      }
    }
  }

  void searchOnChangeFn(val) {
    if (val.isEmpty) {
      searchCntrl.clear();
      isCloseButtonVisible.value = false; // Hide the close button when the input is cleared
    }
  }

  void onFieldSubmittedFn(val) async {
    searchBtn();
  }

  void searchSuffixIconBtn() {
    customersListApiPayload.clear();
    CustomersSearchCntrl.clear();
    customerData.value = List<Shop>.from(originalList);
    searchCntrl.clear();
    isCloseButtonVisible.value = false; // Hide the close button
  }
}