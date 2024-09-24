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

class NewLeadSubmitController extends GetxController {

  RxList additionalFields = [].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController cusnameCtrl = TextEditingController(text: '');
  final TextEditingController phonenumCtrl = TextEditingController(text: '');

  final FocusNode cusnameCtrlfNode = FocusNode();
  final FocusNode phonenumCtrlfNode = FocusNode();

  void shopRegister() async {
    log("Shop registraion called");
    ApiResp resp = await ShopRegisterServices.fetchUser(
        customername: cusnameCtrl.text,
        phonenumber: phonenumCtrl.text,
      );
    if (!resp.ok == false) {
      MyUtils.msg(resp.msgs);
      return;
    }
    Shop shop = Shop.fromJson(resp.rdata);
    if (shop.message == 'Shop Details Entered Successfully') {
      cusnameCtrl.clear();
      phonenumCtrl.clear();
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