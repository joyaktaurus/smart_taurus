import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/empdetails.dart';
import '../../models/task_count_model.dart';
import '../../models/task_listing_model.dart';
import '../../models/task_notification_model.dart';
import '../../services/task_count_services.dart';
import '../../services/task_notif_services.dart';
import '../../services/user_services.dart';
import '../task_listing/task_list_controller.dart';

class DashboardController extends GetxController {
  var employee = Employee().obs;
  var imagePath = ''.obs;
  var isLoading = true.obs;
  //var notificationCount = 0.obs;
  var unseenTaskCount = 0.obs;
  final String unseenTaskCountKey = 'unseenTaskCount';
  var totalTaskCount = 0.obs;

  // void resetUnseenCount() {
  //   unseenTaskCount.value = 0;
  // }
  // Load unseen task count from local storage
  Future<void> loadUnseenTaskCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    unseenTaskCount.value = prefs.getInt(unseenTaskCountKey) ?? 0;
  }

  // Save unseen task count to local storage
  Future<void> saveUnseenTaskCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(unseenTaskCountKey, unseenTaskCount.value);
  }

  // Method to fetch unseen tasks and update the count
  void fetchUnseenTasks(List<TaskList> tasks) {
    int newUnseenCount = tasks.where((task) => !task.isSeen).length;
    if (newUnseenCount != unseenTaskCount.value) {
      unseenTaskCount.value = newUnseenCount;
      saveUnseenTaskCount(); // Save the updated count
    }
  }

  // Reset unseen count when tasks are viewed
  void resetUnseenCount() {
    unseenTaskCount.value = 0;
    saveUnseenTaskCount(); // Save the reset count
  }

  // Method to fetch unseen tasks and update the count
  // void fetchUnseenTasks(List<TaskList> tasks) {
  //   unseenTaskCount.value = tasks.where((task) => !task.isSeen).length;
  // }


  @override
  void onInit() {
    super.onInit();
    fetchEmployeeDetails();
   // fetchUnseenTaskCount(); // Fetch unseen task count
    loadUnseenTaskCount();
    fetchTaskCount();// Load unseen task count from local storage
  }

  var completedTaskCount = 0.obs; // Declare completedTaskCount as an observable

  void fetchTaskCount() async {
    try {
      isLoading(true);
      var response = await TaskCountServices.getTaskCount();
      if (response.ok) {
        var jsonData = response.rdata;
        var taskCountData = TaskCountModel.fromJson(jsonData);

        totalTaskCount.value = taskCountData.totalTaskCount ?? 0;
        completedTaskCount.value = taskCountData.completedTaskCount ?? 0;
      } else {
        totalTaskCount.value = 0;
        completedTaskCount.value = 0;
      }
    } catch (e) {
      print("Error fetching task count: $e");
    } finally {
      isLoading(false);
    }
  }

  // void fetchUnseenTaskCount() {
  //   final taskListingController = Get.find<TaskListingController>();
  //   unseenTaskCount.value = taskListingController.unseenTaskCount.value;
  //
  //   // Update unseenTaskCount when it changes in TaskListingController
  //   ever(taskListingController.unseenTaskCount, (count) {
  //     unseenTaskCount.value = count as int;
  //   });
  // }
  // Fetch employee details from the API
  void fetchEmployeeDetails() async {
    try {
      isLoading(true);
      var response = await EmpDetailServices.fetchEmpDetails(1);
      if (response.ok) {
        var jsonData = response.rdata;
        var employeeData = LeadListing.fromJson(jsonData);
        employee.value = employeeData.employee!;
        imagePath.value = employeeData.imagePath ?? '';
      } else {
        employee.value = Employee();
      }
    } catch (e) {
      print("Error fetching employee details: $e");
    } finally {
      isLoading(false);
    }
  }

  // Fetch notification count from the API
  // void fetchNotificationCount() async {
  //   try {
  //     var response = await NotificationServices.fetchNotificationList(1);
  //     if (response.ok) {
  //       var taskNotification = response.rdata as TaskNotification;
  //       notificationCount.value = taskNotification.task ?? 0;
  //     }
  //   } catch (e) {
  //     print("Error fetching notification count: $e");
  //   }
  // }
}


// The error occurs because the imagePath field is part of the EmpDetails
// class, not the Employee class. Since you're trying to access
// imagePath from the Employee object, it results in the error.
//
// To fix this, you'll need to pass the imagePath from the EmpDetails
// object to the view or use it directly from where EmpDetails is parsed in your controller.
//
// Here's the solution:
//
// Add imagePath as an observable in your controller (since it belongs to EmpDetails).
// Use this observable in your view when constructing the image URL.
// Modify the Controller:
// Update the DashboardController to store the imagePath as well.