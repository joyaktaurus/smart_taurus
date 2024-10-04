import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/customer_list_model.dart';
import '../../services/customerlist_services.dart';
import '../../services/lead_submit_services.dart';
import '../../services/new_lead_services.dart';
import '../../utils/err_m.dart';
import '../../utils/my_utils.dart';

class NewLeadSubmitController extends GetxController {
  RxList additionalFields = [].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool showDropdown = false.obs; // To control the visibility of the dropdown

  final TextEditingController cusnameCtrl = TextEditingController(text: '');
  final TextEditingController phonenumCtrl = TextEditingController(text: '');
  RxBool isScreenProgress = true.obs;
  RxList<Shop> customerData = <Shop>[].obs;
  RxString selectedShop = ''.obs; // To hold the selected shop ID

  final FocusNode cusnameCtrlfNode = FocusNode();
  final FocusNode phonenumCtrlfNode = FocusNode();

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

  // Function to submit the shop details
  Future<void> submitLeadDetails() async {
    if (!formKey.currentState!.validate()) {
      // If form is not valid, don't proceed
      return;
    }

    if (selectedShop.isEmpty) {
      // If no shop is selected, show a message
      showMsg('Please select a shop', 'Submission Failed');
      return;
    }

    String shopId = selectedShop.value;
    String title = cusnameCtrl.text.trim();
    String note = phonenumCtrl.text.trim();

    isScreenProgress.value = true; // Show progress indicator

    try {
      final ApiResp response = await NewLeadServices.fetchUser(
        shop_id: shopId,
        title: title,
        note: note,
      );

      if (response.ok) {
        showMsg('Lead submitted successfully', 'Success');
      } else {
        showMsg('Failed to submit lead', 'Error');
      }
    } catch (e) {
      print('Error during lead submission: $e');
      showMsg('Something went wrong. Please try again later', 'Error');
    } finally {
      isScreenProgress.value = false; // Hide progress indicator
    }
  }
}
