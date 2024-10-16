// To parse this JSON data, do
//
//     final newTask = newTaskFromJson(jsonString);

import 'dart:convert';

NewTask newTaskFromJson(String str) => NewTask.fromJson(json.decode(str));

String newTaskToJson(NewTask data) => json.encode(data.toJson());

class NewTask {
  String message;

  NewTask({
    required this.message,
  });

  factory NewTask.fromJson(Map<String, dynamic> json) => NewTask(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
