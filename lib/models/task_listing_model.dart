// To parse this JSON data, do
//
//     final taskListingModel = taskListingModelFromJson(jsonString);


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
    shop: json["shop"] != null
        ? List<TaskList>.from(json["shop"].map((x) => TaskList.fromJson(x)))
        : [],
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
  Status? status; // Using Status enum
  String? createdBy;
  String? taskDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  TaskList({
    this.id,
    this.task,
    this.assignedTo,
    this.status,
    this.createdBy,
    this.taskDate,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
    id: json["id"],
    task: json["task"],
    assignedTo: json["assigned_to"],
    status: statusValues.map[json["status"]], // Convert status from String to Enum
    createdBy: json["created_by"],
    taskDate: json["task_date"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task": task,
    "assigned_to": assignedTo,
    "status": statusValues.reverse[status], // Convert status back to String
    "created_by": createdBy,
    "task_date": taskDate,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

enum Status { COMPLETED, NEW }

final statusValues = EnumValues({
  "Completed": Status.COMPLETED,
  "New": Status.NEW,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}




// TaskListingModel taskListingModelFromJson(String str) => TaskListingModel.fromJson(json.decode(str));
//
// String taskListingModelToJson(TaskListingModel data) => json.encode(data.toJson());
//
// class TaskListingModel {
//   String? message;
//   List<TaskList>? shop;
//
//   TaskListingModel({
//     this.message,
//     this.shop,
//   });
//
//   factory TaskListingModel.fromJson(Map<String, dynamic> json) => TaskListingModel(
//     message: json["message"],
//     shop: List<TaskList>.from(json["shop"].map((x) => TaskList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "shop": List<dynamic>.from(shop!.map((x) => x.toJson())),
//   };
// }
//
// class TaskList {
//   int? id;
//   String? task;
//   String? assignedTo;
//   String? status;
//   String? taskDate;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   TaskList({
//     this.id,
//     this.task,
//     this.assignedTo,
//     this.status,
//     this.taskDate,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
//     id: json["id"],
//     task: json["task"],
//     assignedTo: json["assigned_to"],
//     status: json["status"],
//     taskDate: json["task_date"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "task": task,
//     "assigned_to": assignedTo,
//     "status": status,
//     "task_date": taskDate,
//     "created_at": createdAt!.toIso8601String(),
//     "updated_at": updatedAt!.toIso8601String(),
//   };
// }
