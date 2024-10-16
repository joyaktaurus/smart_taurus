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
  User? user;
  bool? isChecked; // Add this property

  TaskList({
    this.id,
    this.task,
    this.assignedTo,
    this.status,
    this.createdBy,
    this.taskDate,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.isChecked = false, // Default to false (unchecked)
  });

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
    id: json["id"],
    task: json["task"],
    assignedTo: json["assigned_to"],
    status: statusValues.map[json["status"]],
    createdBy: json["created_by"],
    taskDate: json["task_date"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task": task,
    "assigned_to": assignedTo,
    "status": statusValues.reverse[status],
    "created_by": createdBy,
    "task_date": taskDate,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "user": user!.toJson(),
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
  Name? name;
  Email? email;
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
    this.name,
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
    name: nameValues.map[json["name"]],
    email: emailValues.map[json["email"]],
    emailVerifiedAt: json["email_verified_at"],
    type: typeValues.map[json["type"]],
    avatar: avatarValues.map[json["avatar"]],
    lang: langValues.map[json["lang"]],
    lastLogin: DateTime.parse(json["last_login"]),
    isActive: json["is_active"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    messengerColor: messengerColorValues.map[json["messenger_color"]],
    darkMode: json["dark_mode"],
    activeStatus: json["active_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "email": emailValues.reverse[email],
    "email_verified_at": emailVerifiedAt,
    "type": typeValues.reverse[type],
    "avatar": avatarValues.reverse[avatar],
    "lang": langValues.reverse[lang],
    "last_login": lastLogin!.toIso8601String(),
    "is_active": isActive,
    "created_by": createdBy,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "messenger_color": messengerColorValues.reverse[messengerColor],
    "dark_mode": darkMode,
    "active_status": activeStatus,
  };

  // New method to get formatted name
  String getFormattedName() {
    // Ensure the name is not null
    if (name == null) return '';
    // Get the string value of the enum
    String nameStr = nameValues.reverse[name] ?? '';
    // Capitalize the first letter and lowercase the rest
    return nameStr.isNotEmpty
        ? '${nameStr[0].toUpperCase()}${nameStr.substring(1).toLowerCase()}'
        : '';
  }
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
//     shop: json["shop"] != null
//         ? List<TaskList>.from(json["shop"].map((x) => TaskList.fromJson(x)))
//         : [],
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
//   Status? status; // Using Status enum
//   String? createdBy;
//   String? taskDate;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   TaskList({
//     this.id,
//     this.task,
//     this.assignedTo,
//     this.status,
//     this.createdBy,
//     this.taskDate,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
//     id: json["id"],
//     task: json["task"],
//     assignedTo: json["assigned_to"],
//     status: statusValues.map[json["status"]], // Convert status from String to Enum
//     createdBy: json["created_by"],
//     taskDate: json["task_date"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "task": task,
//     "assigned_to": assignedTo,
//     "status": statusValues.reverse[status], // Convert status back to String
//     "created_by": createdBy,
//     "task_date": taskDate,
//     "created_at": createdAt!.toIso8601String(),
//     "updated_at": updatedAt!.toIso8601String(),
//   };
// }
//
// enum Status { COMPLETED, NEW }
//
// final statusValues = EnumValues({
//   "Completed": Status.COMPLETED,
//   "New": Status.NEW,
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }



