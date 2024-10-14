import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../models/api_resp.dart';
import '../../models/shop_res.dart';
import '../../services/expenses_services.dart';
import '../../services/lead_submit_services.dart';
import '../../services/new_task_services.dart';
import '../../utils/my_utils.dart';

class NewTaskController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController traFromCtrl = TextEditingController(text: '');
  final TextEditingController traDateCtrl = TextEditingController(text: '');

  // Rxn<DateTime> allows nullable Rx for selected date
  Rxn<DateTime> selectedDate = Rxn<DateTime>();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Step 4: Store selected date and time in Rx variable
        selectedDate.value = fullDateTime;

        // Format the datetime for the text field and API request
        String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(fullDateTime);
        traDateCtrl.text = formattedDateTime;
      }
    }
  }

  void shopRegister() async {
    log("Shop registration called");

    // Check if the date is selected before making the API request
    if (selectedDate.value == null) {
     // MyUtils.msg("h");
      return;
    }

    ApiResp resp = await NewTaskServices.fetchNewTasks(
      task: traFromCtrl.text,
      task_date: traDateCtrl.text, // Make sure traDateCtrl.text is populated
    );

    if (!resp.ok) {
      MyUtils.msg(resp.msgs);
      return;
    }

    Shop shop = Shop.fromJson(resp.rdata);
    if (shop.message == 'Task Details Entered Successfully') {
      Get.snackbar(
        'Success',
        'Shop Details Entered Successfully',
        backgroundColor: Colors.white,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
      );
    }

    clearFields();
  }

  void clearFields() {
    traFromCtrl.clear();
    traDateCtrl.clear();
    selectedDate.value = null; // Reset selected date to null
  }
}
