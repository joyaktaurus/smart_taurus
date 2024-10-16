import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smart_taurus/components/app_refresh.dart';
import 'package:smart_taurus/screens/task_listing/task_list_controller.dart';
import 'package:smart_taurus/utils/my_theme.dart';

import '../../components/app_empty.dart';
import '../../components/rounded_loader.dart';
import '../../models/task_listing_model.dart';
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
          //  backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: MyTheme.appColor,
              ),
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
                      color: MyTheme.appColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(child: Text('Assigned Task')),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      color: MyTheme.appColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(child: Text('Completed Task')),
                  ),
                ),
              ],
            ),
          ),
          body: AppRefresh(
            refreshFunction: () => controller.refresh(),
            child: Container(
              height: Get.height * 0.75,
              child: TabBarView(
                children: [
                  _buildTaskList(false), // New Tasks
                  _buildTaskList(true), // Completed Tasks
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Action when FAB is pressed (e.g., navigate to lead creation screen)
              Get.toNamed(Routes.newTask);
            },
            backgroundColor: MyTheme.appColor,

            child: Icon(Icons.add), // Icon for adding new leads
          ),
        ),
      ),
    );
  }

  // Widget for building task list
  Widget _buildTaskList(bool isCompleted) {
    return Obx(() {
      // This checks if the screen is still loading
      bool isScreenProgress = controller.isScreenProgress.value;

      // Get the list of tasks based on the completion status
      final tasks =
          isCompleted ? controller.completedTasks : controller.newTasks;

      // If still loading, show the loader
      if (isScreenProgress) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.1),
            child: RoundedLoader(),
          ),
        );
      }

      // After loading is complete, show the tasks if they exist
      else if (tasks.isNotEmpty) {
        return AppRefresh(
          refreshFunction: () => controller.refresh(),
          child: ListView.builder(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${task.taskDate}",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 14)),
                            Text(
                              "Assigned by ${task.user?.getFormattedName()}",
                              style: TextStyle(
                                  color: MyTheme.appColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _buildTaskTextWithReadMore(task.task.toString(), index),
                        if (!isCompleted)
                          Align(
                              alignment: Alignment.centerRight,
                              child:
                              CustomCheckbox(
                                value: task.status == Status.COMPLETED,
                                onChanged: (bool? newValue) {
                                  if (newValue != null) {
                                    _showConfirmationDialog(task, newValue);
                                  }
                                },
                              )
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }

      // If loading is done and no tasks are available, show "Results Empty"
      else {
        return Center(
          child: MAResultEmpty(
            msg: 'Results Empty',
          ),
        );
      }
    });
  }

  void _showConfirmationDialog(TaskList task, bool newValue) {
    Get.defaultDialog(
      buttonColor: MyTheme.appColor,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      title: "Confirm Completion",
      middleText: "Are you sure about you complete the task?",
      textConfirm: "OK",
      textCancel: "Cancel",
      onConfirm: () {
        controller.toggleTaskStatus(task, newValue);
        Get.back(); // Close the dialog
      },
      onCancel: () {
        Get.toNamed(Routes.taskListing);
      },
      barrierDismissible: false, // Prevent closing by tapping outside
    );
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

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value; // Initialize the checkbox with the given value
  }

  void _showTaskCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Task Complete?'),
          content: const Text('Are you sure the task is completed?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog and uncheck the checkbox (revert)
                setState(() {
                  isChecked = false; // Revert to unchecked
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Keep the checkbox checked and call the onChanged callback
                widget.onChanged(isChecked);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // First, color the checkbox (toggle its state)
        setState(() {
          isChecked = !isChecked;
        });

        // Then, show the confirmation dialog
        Future.delayed(const Duration(milliseconds: 200), () {
          _showTaskCompletionDialog(context);
        });
      },
      child: Container(
        width: 20, // Width for visibility of the tick icon
        height: 20, // Height for visibility of the tick icon
        decoration: BoxDecoration(
          color: isChecked ? Colors.green : Colors.transparent,
          // Green background if checked, transparent if unchecked
          border: Border.all(
            color: MyTheme.appColor, // Border color
            width: 2, // Border width for visibility
          ),
          borderRadius: BorderRadius.circular(4), // Rounded corners
        ),
        child: isChecked
            ? Icon(
          Icons.check, // Tick mark icon
          color: Colors.black, // Tick mark color
          size: 16, // Size of the tick mark
        )
            : null, // No tick mark if not checked
      ),
    );
  }
}
