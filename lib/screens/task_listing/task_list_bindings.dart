import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:smart_taurus/screens/task_listing/task_list_controller.dart';

class TaskListingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskListingController>(
          () => TaskListingController(),
    );
  }
}