import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/api_resp.dart';
import '../../models/shop_res.dart';
import '../../services/expenses_services.dart';
import '../../services/lead_submit_services.dart';
import '../../utils/my_utils.dart';

class ExpenseController extends GetxController {

  RxList additionalFields = [].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController traFromCtrl = TextEditingController(text: '');
  final TextEditingController traToCtrl = TextEditingController(text: '');
  final TextEditingController amountCtrl = TextEditingController(text: '');
  final TextEditingController purposeCtrl = TextEditingController(text: '');
  final TextEditingController traTypeCtrl = TextEditingController(text: '');
  final TextEditingController otherExCtrl = TextEditingController(text: '');
  final TextEditingController traDateCtrl = TextEditingController(text: '');


  final FocusNode traFromCtrlfNode = FocusNode();
  final FocusNode traToCtrlNode = FocusNode();
  final FocusNode amountCtrlfNode = FocusNode();
  final FocusNode purposeCtrlfNode = FocusNode();
  final FocusNode traTypeCtrlfNode = FocusNode();
  final FocusNode otherExCtrlfNode = FocusNode();
  final FocusNode traDateCtrlfNode = FocusNode();


  void shopRegister() async {
    log("Shop registraion called");
    ApiResp resp = await ExpensesServices.fetchExpenses(
      travel_from: traFromCtrl.text,
      travel_to: traToCtrl.text,
      amount: amountCtrl.text,
      purpose: purposeCtrl.text,
      travel_type: traTypeCtrl.text,
      other_expenses: otherExCtrl.text,
      travel_date: traDateCtrl.text,
        );
    if (!resp.ok == false) {
      MyUtils.msg(resp.msgs);
      return;
    }
    Shop shop = Shop.fromJson(resp.rdata);
    if (shop.message == 'Shop Details Entered Successfully') {
      traFromCtrl.clear();
      traToCtrl.clear();
      amountCtrl.clear();
      purposeCtrl.clear();
      traTypeCtrl.clear();
      otherExCtrl.clear();
      traDateCtrl.clear();
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