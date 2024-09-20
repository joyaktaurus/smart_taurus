import 'dart:convert';

TaskUpdate shopListFromJson(String str) => TaskUpdate.fromJson(json.decode(str));

String shopListToJson(TaskUpdate data) => json.encode(data.toJson());

class TaskUpdate {
  String message;

  TaskUpdate({
    required this.message,
  });

  factory TaskUpdate.fromJson(Map<String, dynamic> json) => TaskUpdate(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}