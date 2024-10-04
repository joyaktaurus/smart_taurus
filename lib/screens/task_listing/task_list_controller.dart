import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app.dart';
import '../../models/api_resp.dart';
import '../../models/task_listing_model.dart';
import '../../services/task_listing_services.dart';
import '../../services/task_update_services.dart';


class TaskListingController extends GetxController {
  RxList<TaskList> taskData = <TaskList>[].obs;
  // RxBool isScreenProgress = true.obs;
  // RxList<TaskList> newTasks = <TaskList>[].obs;  // List for new tasks
  // RxList<TaskList> completedTasks = <TaskList>[].obs;  // List for completed tasks

  var isScreenProgress = false.obs;
  var newTasks = <TaskList>[].obs;
  var completedTasks = <TaskList>[].obs;

  var expandedTasks = <int, bool>{}.obs; // Track which tasks are expanded

  void toggleExpandedTask(int index) {
    expandedTasks[index] = !(expandedTasks[index] ?? false);
  }
  @override
  void onInit() {
    super.onInit();
    fetchTaskList();  // Fetch task list on initialization
  }

  // Fetch task list and filter into new and completed
  Future<void> fetchTaskList() async {
    try {
      final ApiResp resp = await TaskServices.getTaskList();
      if (resp.ok) {
        final taskList = TaskListingModel.fromJson(resp.rdata).shop ?? [];
        taskData.assignAll(taskList);

        // Separate tasks into new and completed
        newTasks.assignAll(taskList.where((task) => task.status != 'Completed').toList());
        completedTasks.assignAll(taskList.where((task) => task.status == 'Completed').toList());

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
    final status = isCompleted ? 'Completed' : 'New';
    task.status = status;

    // Update task status in API
    await TaskUpdateServices.fetchtaskUpdate(task_id: task.id.toString(), status: status);

    // Refresh the task lists
    fetchTaskList();
  }
}

