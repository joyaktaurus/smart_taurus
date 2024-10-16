import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/task_listing_model.dart';
import '../../services/task_listing_services.dart';
import '../../services/task_update_services.dart';

class TaskListingController extends GetxController {
  RxList<TaskList> taskData = <TaskList>[].obs;
  var isScreenProgress = true.obs;
  var newTasks = <TaskList>[].obs;
  var completedTasks = <TaskList>[].obs;

  var expandedTasks = <int, bool>{}.obs; // Track which tasks are expanded
  var isChecked = false.obs; // Using .obs makes it observable

  // Method to toggle the checkbox state
  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false; // Update the observable variable
  }
  // Toggle task expansion state
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

  // Fetch task list and categorize into new and completed
  Future<void> fetchTaskList() async {
    try {
      final ApiResp resp = await TaskServices.getTaskList();
      if (resp.ok) {
        final taskList = TaskListingModel.fromJson(resp.rdata).shop ?? [];
        taskData.assignAll(taskList);

        // Separate tasks into new and completed using status
        newTasks.assignAll(taskList.where((task) => task.status == Status.NEW).toList());
        completedTasks.assignAll(taskList.where((task) => task.status == Status.COMPLETED).toList());

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

  // Toggle task status between New and Completed
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
}
