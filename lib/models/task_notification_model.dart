import 'dart:convert';

TaskNotification taskNotificationFromJson(String str) => TaskNotification.fromJson(json.decode(str));

String taskNotificationToJson(TaskNotification data) => json.encode(data.toJson());

class TaskNotification {
  String? message;
  int? task;

  TaskNotification({
    this.message,
    this.task,
  });

  factory TaskNotification.fromJson(Map<String, dynamic> json) => TaskNotification(
    message: json["message"],
    task: json["task"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "task": task,
  };
}
