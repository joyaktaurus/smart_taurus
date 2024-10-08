import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/api_resp.dart';
import '../../models/shop_res.dart';
import '../../services/lead_submit_services.dart';
import '../../utils/my_utils.dart';

class LeadSubmitController extends GetxController {

  RxList additionalFields = [].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController shopnameCtrl = TextEditingController(text: '');
  final TextEditingController cusnameCtrl = TextEditingController(text: '');
  final TextEditingController phonenumCtrl = TextEditingController(text: '');
  final TextEditingController emailCtrl = TextEditingController(text: '');
  final TextEditingController orgCtrl = TextEditingController(text: '');
  final TextEditingController gstCtrl = TextEditingController(text: '');
  final TextEditingController pancardCtrl = TextEditingController(text: '');
  final TextEditingController categoryCtrl = TextEditingController(text: '');
  final TextEditingController budgetCtrl = TextEditingController(text: '');
  final TextEditingController brandCtrl = TextEditingController(text: '');
  final TextEditingController addressoneCtrl = TextEditingController(text: '');
  final TextEditingController addresstwoCtrl = TextEditingController(text: '');
  final TextEditingController pincodeCtrl = TextEditingController(text: '');
  final TextEditingController instructCtrl = TextEditingController(text: '');
  final TextEditingController additionalFieldKeyCtrl =
  TextEditingController(text: '');

  final FocusNode shopnameCtrlfNode = FocusNode();
  final FocusNode cusnameCtrlfNode = FocusNode();
  final FocusNode phonenumCtrlfNode = FocusNode();
  final FocusNode emailCtrlfNode = FocusNode();
  final FocusNode orgCtrlfNode = FocusNode();
  final FocusNode gstCtrlfNode = FocusNode();
  final FocusNode pancardCtrlfNode = FocusNode();
  final FocusNode categoryCtrlfNode = FocusNode();
  final FocusNode budgetCtrlfNode = FocusNode();
  final FocusNode brandCtrlfNode = FocusNode();
  final FocusNode addressoneCtrlfNode = FocusNode();
  final FocusNode addresstwoCtrlfNode = FocusNode();
  final FocusNode pincodeCtrlfNode = FocusNode();
  final FocusNode instructCtrlfNode = FocusNode();

  void shopRegister() async {
    log("Shop registraion called");
    ApiResp resp = await ShopRegisterServices.fetchUser(
        shopname: shopnameCtrl.text,
        customername: cusnameCtrl.text,
        phonenumber: phonenumCtrl.text,
        organization: orgCtrl.text,
        gst_number: gstCtrl.text,
        pancard: pancardCtrl.text,
        category_info: categoryCtrl.text,
        budget_info: budgetCtrl.text,
        brand_info: brandCtrl.text,
        email: emailCtrl.text,
        addressline1: addressoneCtrl.text,
        addressline2: addresstwoCtrl.text,
        pincode: pincodeCtrl.text,
        instructions: instructCtrl.text);
    if (!resp.ok == false) {
      MyUtils.msg(resp.msgs);
      return;
    }
    Shop shop = Shop.fromJson(resp.rdata);
    if (shop.message == 'Shop Details Entered Successfully') {
      shopnameCtrl.clear();
      cusnameCtrl.clear();
      phonenumCtrl.clear();
      emailCtrl.clear();
      orgCtrl.clear();
      gstCtrl.clear();
      pancardCtrl.clear();
      categoryCtrl.clear();
      budgetCtrl.clear();
      brandCtrl.clear();
      addressoneCtrl.clear();
      addresstwoCtrl.clear();
      pincodeCtrl.clear();
      instructCtrl.clear();
      Get.snackbar(
        'Success',
        'Travel Details Entered Successfully',
        backgroundColor: Colors.white,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

}