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
            centerTitle: true,
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              indicator: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(40),
              ),
              tabs: [
                Tab(
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(child: Text('New Task')),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(child: Text('Completed Task')),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildTaskList(false), // New Tasks
              _buildTaskList(true), // Completed Tasks
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Task Name with Read More functionality
                      _buildTaskTextWithReadMore(task.task.toString(), index),

                      // Show Checkbox only for New Tasks
                      if (!isCompleted)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Checkbox(
                            value: task.status == 'Completed',
                            onChanged: (bool? newValue) {
                              if (newValue != null) {
                                controller.toggleTaskStatus(task, newValue);
                              }
                            },
                          ),
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

  // Method to build task text with Read More/Read Less functionality
  Widget _buildTaskTextWithReadMore(String taskText, int index) {
    final TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: Get.height * 0.020,
      color: Colors.black,
    );

    // Measure the number of lines required to display the text
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: taskText, style: textStyle),
      maxLines: 4,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: Get.width - 50); // Adjust according to layout

    bool exceedsMaxLines = textPainter.didExceedMaxLines;

    return Obx(() {
      bool isExpanded = controller.expandedTasks[index] ?? false;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            taskText,
            style: textStyle,
            maxLines: isExpanded ? null : 4,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          if (exceedsMaxLines) // Show Read More/Read Less only if it exceeds 4 lines
            InkWell(
              onTap: () {
                controller.toggleExpandedTask(index);
              },
              child: Text(
                isExpanded ? 'Read Less' : 'Read More',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      );
    });
  }
}
