// To parse this JSON data, do
//
//     final stacksListModel = stacksListModelFromMap(jsonString);

import 'dart:convert';

StacksListModel stacksListModelFromMap(String str) =>
    StacksListModel.fromMap(json.decode(str));

String stacksListModelToMap(StacksListModel data) => json.encode(data.toMap());

class StacksListModel {
  dynamic status;
  dynamic message;
  List<StacksDatum>? data;

  StacksListModel({
    this.status,
    this.message,
    this.data,
  });

  factory StacksListModel.fromMap(Map<String, dynamic> json) => StacksListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<StacksDatum>.from(
                json["data"]!.map((x) => StacksDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class StacksDatum {
  dynamic bags;
  dynamic quantity;
  dynamic stackNumber;
  dynamic stackType;
  dynamic stackId;

  StacksDatum(
      {this.bags,
      this.quantity,
      this.stackNumber,
      this.stackType,
      this.stackId});

  factory StacksDatum.fromMap(Map<String, dynamic> json) => StacksDatum(
      bags: json["bags"],
      quantity: json["quantity"],
      stackNumber: json["stack_number"],
      stackType: json["stack_type"],
      stackId: json['stack_id']);

  Map<String, dynamic> toMap() => {
        "bags": bags,
        "quantity": quantity,
        "stack_number": stackNumber,
        "stack_type": stackType,
        "stack_id": stackId
      };
}
