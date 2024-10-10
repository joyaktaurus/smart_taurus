import 'dart:convert';

// Function to parse JSON string to TaskModel
TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

// Function to convert TaskModel to JSON string
String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  String? message;
  List<Shop> shop;

  TaskModel({
    this.message,
    List<Shop>? shop, // Allow null for incoming list
  }) : shop = shop ?? []; // Initialize shop to an empty list if null

  // Factory method to create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    message: json["message"],
    shop: List<Shop>.from(json["shop"]?.map((x) => Shop.fromJson(x)) ?? []), // Handle potential null
  );

  // Method to convert TaskModel to JSON
  Map<String, dynamic> toJson() => {
    "message": message,
    "shop": List<dynamic>.from(shop.map((x) => x.toJson())),
  };
}

class Shop {
  int? id;
  String? task;
  String? assignedTo;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Shop({
    this.id,
    this.task,
    this.assignedTo,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create Shop from JSON
  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    task: json["task"],
    assignedTo: json["assigned_to"],
    status: json["status"],
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : null, // Handle potential null
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : null, // Handle potential null
  );

  // Method to convert Shop to JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "task": task,
    "assigned_to": assignedTo,
    "status": status,
    "created_at": createdAt?.toIso8601String(), // Use ? to avoid null exception
    "updated_at": updatedAt?.toIso8601String(), // Use ? to avoid null exception
  };
}
