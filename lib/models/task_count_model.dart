// To parse this JSON data, do
//
//     final taskCountModel = taskCountModelFromJson(jsonString);

import 'dart:convert';

TaskCountModel taskCountModelFromJson(String str) => TaskCountModel.fromJson(json.decode(str));

String taskCountModelToJson(TaskCountModel data) => json.encode(data.toJson());

class TaskCountModel {
  String? message;
  int? totalTaskCount;
  int? completedTaskCount;

  TaskCountModel({
    this.message,
    this.totalTaskCount,
    this.completedTaskCount,
  });

  factory TaskCountModel.fromJson(Map<String, dynamic> json) => TaskCountModel(
    message: json["message"],
    totalTaskCount: json["total_task_count"],
    completedTaskCount: json["completed_task_count"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "total_task_count": totalTaskCount,
    "completed_task_count": completedTaskCount,
  };
}
