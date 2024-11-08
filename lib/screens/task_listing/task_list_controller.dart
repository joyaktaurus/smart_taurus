import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/task_listing_model.dart';
import '../../services/task_listing_services.dart';
import '../../services/task_update_services.dart';
import '../dashboard/dashboard_controller.dart';

class TaskListingController extends GetxController {
  RxList<TaskList> taskData = <TaskList>[].obs;
  var isScreenProgress = true.obs;
  var newTasks = <TaskList>[].obs;
  var completedTasks = <TaskList>[].obs;
  var unseenTaskCount = 0.obs; // New variable to track unseen task count

  var expandedTasks = <int, bool>{}.obs; // Track which tasks are expanded
  var checkedTasks = <int, bool>{}.obs; // Track checkbox state by task id

  // Method to set unseen count to zero
  void resetUnseenCount() {
    unseenTaskCount.value = 0;
  }

  // Method to fetch unseen tasks and update the count
  void fetchUnseenTasks(List<TaskList> tasks) {
    unseenTaskCount.value = tasks.where((task) => !task.isSeen).length;
  }


  void toggleExpandedTask(int index) {
    expandedTasks[index] = !(expandedTasks[index] ?? false);
  }

  @override
  Future<void> refresh() async {
    await fetchTaskList(); // Refresh the task list
  }

  @override
  void onInit() {
    super.onInit();
    fetchTaskList();
  }

  // Method to toggle the checkbox state for a specific task
  void toggleCheckbox(int taskId, bool? value) {
    checkedTasks[taskId] = value ?? false; // Update the observable map
  }

  void toggleTaskStatus(TaskList task, bool isCompleted) async {
    final status = isCompleted ? Status.COMPLETED : Status.NEW;
    task.status = status;

    // Update task status in API
    await TaskUpdateServices.fetchtaskUpdate(
      task_id: task.id.toString(),
      status: statusValues.reverse[status],
    );

    // Refresh the task lists after update
    fetchTaskList();
  }

// Inside TaskListingController
  void onViewTasks() {
    final dashboardController = Get.find<DashboardController>();
    dashboardController.resetUnseenCount();
    // Additional logic to display tasks can go here
  }

  Future<void> fetchTaskList() async {
    try {
      final ApiResp resp = await TaskServices.getTaskList();
      if (resp.ok) {
        final taskList = TaskListingModel.fromJson(resp.rdata).shop ?? [];
        taskData.assignAll(taskList);

        // Filter tasks into new and completed
        newTasks.assignAll(taskList.where((task) => task.status == Status.NEW).toList());
        completedTasks.assignAll(taskList.where((task) => task.status == Status.COMPLETED).toList());

        // Update unseenTaskCount with count of tasks in newTasks that are unseen
        unseenTaskCount.value = newTasks.where((task) => !task.isSeen).length;

        isScreenProgress.value = false;
      } else {
        isScreenProgress.value = false;
        print('Error fetching task list: ${resp.msgs}');
      }
    } catch (e) {
      isScreenProgress.value = false;
      print('Error fetching task list: $e');
    }
  }

  // Fetch task list and categorize into new and completed
  // Future<void> fetchTaskList() async {
  //   try {
  //     final ApiResp resp = await TaskServices.getTaskList();
  //     if (resp.ok) {
  //       final taskList = TaskListingModel.fromJson(resp.rdata).shop ?? [];
  //       taskData.assignAll(taskList);
  //
  //       newTasks.assignAll(taskList.where((task) => task.status == Status.NEW).toList());
  //       completedTasks.assignAll(taskList.where((task) => task.status == Status.COMPLETED).toList());
  //
  //       isScreenProgress.value = false;
  //     } else {
  //       isScreenProgress.value = false;
  //       print('Error fetching task list: ${resp.msgs}');
  //     }
  //   } catch (e) {
  //     isScreenProgress.value = false;
  //     print('Error fetching task list: $e');
  //   }
  // }
}


