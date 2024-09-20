import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smart_taurus/screens/task_listing/task_list_controller.dart';

import '../../components/app_empty.dart';
import '../../components/rounded_loader.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';

class TaskListingView extends GetView<TaskListingController> {
  const TaskListingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyUtils.hideKeyboard();
      },
      child: DefaultTabController(
        length: 2, // Two tabs: New and Completed
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              'Tasks',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  Get.toNamed(Routes.dashBoard);
                },
              ),
              IconButton(
                icon: Icon(Icons.notification_add_outlined, color: Colors.black),
                onPressed: () {
                  // Add functionality for notifications icon
                },
              ),
            ],
            centerTitle: true,
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'New'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildTaskList(false), // New Tasks
              _buildTaskList(true),  // Completed Tasks
            ],
          ),
        ),
      ),
    );
  }

  // Widget for building task list
  Widget _buildTaskList(bool isCompleted) {
    return Obx(() {
      bool isLoading = controller.isScreenProgress.value;
      final tasks = isCompleted ? controller.completedTasks : controller.newTasks;

      if (isLoading) {
        return Center(child: RoundedLoader());
      } else if (tasks.isEmpty) {
        return Center(child: MAResultEmpty(msg: 'No Tasks Available'));
      } else {
        return ListView.builder(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return InkWell(
              onTap: () {
                // Handle task tap if necessary
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Task Name
                      Expanded(
                        child: Text(
                          task.task.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Get.height * 0.018,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis, // Handles overflow
                        ),
                      ),
                      // Show Checkbox only for New Tasks
                      if (!isCompleted)
                        Checkbox(
                          value: task.status == 'Completed',
                          onChanged: (bool? newValue) {
                            if (newValue != null) {
                              controller.toggleTaskStatus(task, newValue);
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }

}


