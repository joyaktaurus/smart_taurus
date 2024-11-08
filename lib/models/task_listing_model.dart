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
  Status? status;
  String? createdBy;
  String? taskDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  User? user;
  bool? isChecked;
  bool isSeen; // Add the isSeen property here

  TaskList({
    this.id,
    this.task,
    this.assignedTo,
    this.status,
    this.createdBy,
    this.taskDate,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.user,
    this.isChecked = false,
    this.isSeen = false, // Set a default value for isSeen
  });

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
    id: json["id"],
    task: json["task"],
    assignedTo: json["assigned_to"],
    status: statusValues.map[json["status"]],
    createdBy: json["created_by"],
    taskDate: json["task_date"],
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    name: json["name"],
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
    isChecked: json["is_checked"] ?? false,
    isSeen: json["is_seen"] ?? false, // Parse from JSON or default to false
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task": task,
    "assigned_to": assignedTo,
    "status": statusValues.reverse[status],
    "created_by": createdBy,
    "task_date": taskDate,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "name": name,
    "user": user?.toJson(),
    "is_checked": isChecked,
    "is_seen": isSeen, // Include isSeen in the JSON output
  };
}


enum Status {
  COMPLETED,
  NEW
}

final statusValues = EnumValues({
  "Completed": Status.COMPLETED,
  "New": Status.NEW
});

class User {
  int? id;
  String? name; // Changed from `Name?` to `String?`
  String? email;
  dynamic emailVerifiedAt;
  Type? type;
  Avatar? avatar;
  Lang? lang;
  DateTime? lastLogin;
  String? isActive;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  MessengerColor? messengerColor;
  String? darkMode;
  String? activeStatus;

  User({
    this.id,
    this.name, // Updated to use String
    this.email,
    this.emailVerifiedAt,
    this.type,
    this.avatar,
    this.lang,
    this.lastLogin,
    this.isActive,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.messengerColor,
    this.darkMode,
    this.activeStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"], // Directly assign the name as a string
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    type: typeValues.map[json["type"]],
    avatar: avatarValues.map[json["avatar"]],
    lang: langValues.map[json["lang"]],
    lastLogin: json["last_login"] != null ? DateTime.parse(json["last_login"]) : null,
    isActive: json["is_active"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    messengerColor: messengerColorValues.map[json["messenger_color"]],
    darkMode: json["dark_mode"],
    activeStatus: json["active_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name, // Use the name string directly
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "type": typeValues.reverse[type],
    "avatar": avatarValues.reverse[avatar],
    "lang": langValues.reverse[lang],
    "last_login": lastLogin?.toIso8601String(),
    "is_active": isActive,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "messenger_color": messengerColorValues.reverse[messengerColor],
    "dark_mode": darkMode,
    "active_status": activeStatus,
  };
}

enum Avatar {
  DESERT_1712216029_JPG,
  NANTUCKET_ISLAND_EN_US7343633791_1920_X1080_1725448938_JPG
}

final avatarValues = EnumValues({
  "Desert_1712216029.jpg": Avatar.DESERT_1712216029_JPG,
  "NantucketIsland_EN-US7343633791_1920x1080_1725448938.jpg": Avatar.NANTUCKET_ISLAND_EN_US7343633791_1920_X1080_1725448938_JPG
});

enum Email {
  COMPANY_EXAMPLE_COM,
  MANEESHAGANESH2021_GMAIL_COM
}

final emailValues = EnumValues({
  "company@example.com": Email.COMPANY_EXAMPLE_COM,
  "maneeshaganesh2021@gmail.com": Email.MANEESHAGANESH2021_GMAIL_COM
});

enum Lang {
  EN
}

final langValues = EnumValues({
  "en": Lang.EN
});

enum MessengerColor {
  THE_2180_F3
}

final messengerColorValues = EnumValues({
  "#2180f3": MessengerColor.THE_2180_F3
});

enum Name {
  COMPANY,
  MANEESHA
}

final nameValues = EnumValues({
  "company": Name.COMPANY,
  "Maneesha": Name.MANEESHA
});

enum Type {
  COMPANY,
  EMPLOYEE
}

final typeValues = EnumValues({
  "company": Type.COMPANY,
  "employee": Type.EMPLOYEE
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


