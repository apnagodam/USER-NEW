// To parse this JSON data, do
//
//     final stackBookHistoryModel = stackBookHistoryModelFromJson(jsonString);

import 'dart:convert';

StackBookHistoryModel stackBookHistoryModelFromJson(String str) =>
    StackBookHistoryModel.fromJson(json.decode(str));

String stackBookHistoryModelToJson(StackBookHistoryModel data) =>
    json.encode(data.toJson());

class StackBookHistoryModel {
  dynamic status;
  dynamic message;
  List<Datum>? data;

  StackBookHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory StackBookHistoryModel.fromJson(Map<String, dynamic> json) =>
      StackBookHistoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic id;
  dynamic stackId;
  dynamic commodityName;
  dynamic stackType;
  dynamic weight;
  dynamic stackNumber;
  dynamic warehosueName;
  dynamic status;
  DateTime? date;

  Datum({
    this.id,
    this.stackId,
    this.commodityName,
    this.stackType,
    this.weight,
    this.stackNumber,
    this.warehosueName,
    this.status,
    this.date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        stackId: json["stack_id"],
        commodityName: json["commodity_name"],
        stackType: json["stack_type"],
        weight: json["weight"],
        stackNumber: json["stack_number"],
        warehosueName: json["warehosue_name"],
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stack_id": stackId,
        "commodity_name": commodityName,
        "stack_type": stackType,
        "weight": weight,
        "stack_number": stackNumber,
        "warehosue_name": warehosueName,
        "status": status,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}
