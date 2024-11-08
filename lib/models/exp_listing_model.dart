// To parse this JSON data, do
//
//     final expensesListing = expensesListingFromJson(jsonString);

import 'dart:convert';

ExpensesListing expensesListingFromJson(String str) => ExpensesListing.fromJson(json.decode(str));

String expensesListingToJson(ExpensesListing data) => json.encode(data.toJson());

class ExpensesListing {
  String? message;
  List<Expense>? expenses;

  ExpensesListing({
    this.message,
    this.expenses,
  });

  factory ExpensesListing.fromJson(Map<String, dynamic> json) => ExpensesListing(
    message: json["message"],
    expenses: List<Expense>.from(json["expenses"].map((x) => Expense.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "expenses": List<dynamic>.from(expenses!.map((x) => x.toJson())),
  };
}

class Expense {
  int? id;
  String? travelFrom;
  String? travelTo;
  String? amount;
  String? purpose;
  String? travelType;
  String? otherExpenses;
  String? travelDate;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Expense({
    this.id,
    this.travelFrom,
    this.travelTo,
    this.amount,
    this.purpose,
    this.travelType,
    this.otherExpenses,
    this.travelDate,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json["id"],
    travelFrom: json["travel_from"],
    travelTo: json["travel_to"],
    amount: json["amount"],
    purpose: json["purpose"],
    travelType: json["travel_type"],
    otherExpenses: json["other_expenses"],
    travelDate: json["travel_date"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "travel_from": travelFrom,
    "travel_to": travelTo,
    "amount": amount,
    "purpose": purpose,
    "travel_type": travelType,
    "other_expenses": otherExpenses,
    "travel_date": travelDate,
    "created_by": createdBy,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
