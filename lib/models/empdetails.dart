// To parse this JSON data, do
//
//     final empDetails = empDetailsFromJson(jsonString);

import 'dart:convert';

EmpDetails empDetailsFromJson(String str) => EmpDetails.fromJson(json.decode(str));

String empDetailsToJson(EmpDetails data) => json.encode(data.toJson());

class EmpDetails {
  String? message;
  String? imagePath;
  List<Employee>? employee;

  EmpDetails({
    this.message,
    this.imagePath,
    this.employee,
  });

  factory EmpDetails.fromJson(Map<String, dynamic> json) => EmpDetails(
    message: json["message"],
    imagePath: json["image_path"],
    employee: List<Employee>.from(json["employee"].map((x) => Employee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "image_path": imagePath,
    "employee": List<dynamic>.from(employee!.map((x) => x.toJson())),
  };
}

class Employee {
  int? id;
  String? name;
  DateTime? dob;
  String? gender;
  String? phone;
  String? email;
  String? profilePic;
  String? job;

  Employee({
    this.id,
    this.name,
    this.dob,
    this.gender,
    this.phone,
    this.email,
    this.profilePic,
    this.job,

  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    phone: json["phone"],
    email: json["email"],
    profilePic: json["profile_pic"],
    job: json["job"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "phone": phone,
    "email": email,
    "profile_pic": profilePic,
    "job": job,

  };
}
