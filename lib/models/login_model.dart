import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? status;
  String? token;
  EmployeeDetails? employeeDetails;
  String? imageUrl;
  String? defaultImagePath;
  String? message;

  User({
    this.status,
    this.token,
    this.employeeDetails,
    this.imageUrl,
    this.defaultImagePath,
    this.message,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    status: json["status"] as String? ?? '',
    token: json["token"] as String? ?? '',
    employeeDetails: json["Employee Details"] != null
        ? EmployeeDetails.fromJson(json["Employee Details"])
        : null,
    imageUrl: json["image_url"] as String? ?? '',
    defaultImagePath: json["default_image_path"] as String? ?? '',
    message: json["message"] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "Employee Details": employeeDetails?.toJson(),
    "image_url": imageUrl,
    "default_image_path": defaultImagePath,
    "message": message,
  };
}

class EmployeeDetails {
  int? id;
  String? userId;
  String? name;
  DateTime? dob;
  String? gender;
  String? phone;
  String? email;
  String? profilePic;
  String? apiToken;

  EmployeeDetails({
    this.id,
    this.userId,
    this.name,
    this.dob,
    this.gender,
    this.phone,
    this.email,
    this.profilePic,
    this.apiToken,
  });

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) => EmployeeDetails(
    id: json["id"] as int? ?? 0,
    userId: json["user_id"] as String? ?? '',
    name: json["name"] as String? ?? '',
    dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
    gender: json["gender"] as String? ?? '',
    phone: json["phone"] as String? ?? '',
    email: json["email"] as String? ?? '',
    profilePic: json["profile_pic"] as String? ?? '',
    apiToken: json["api_token"] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "dob": dob?.toIso8601String(),
    "gender": gender,
    "phone": phone,
    "email": email,
    "profile_pic": profilePic,
    "api_token": apiToken,
  };
}
