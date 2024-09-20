// To parse this JSON data, do
//
//     final taskListingModel = taskListingModelFromJson(jsonString);

import 'dart:convert';

TaskListingModel taskListingModelFromJson(String str) => TaskListingModel.fromJson(json.decode(str));

String taskListingModelToJson(TaskListingModel data) => json.encode(data.toJson());

class TaskListingModel {
  String? message;
  List<TaskList>? shop;

  TaskListingModel({
    this.message,
    this.shop,
  });

  factory TaskListingModel.fromJson(Map<String, dynamic> json) => TaskListingModel(
    message: json["message"],
    shop: List<TaskList>.from(json["shop"].map((x) => TaskList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "shop": List<dynamic>.from(shop!.map((x) => x.toJson())),
  };
}

class TaskList {
  int? id;
  String? task;
  String? assignedTo;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  TaskList({
    this.id,
    this.task,
    this.assignedTo,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
    id: json["id"],
    task: json["task"],
    assignedTo: json["assigned_to"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task": task,
    "assigned_to": assignedTo,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
