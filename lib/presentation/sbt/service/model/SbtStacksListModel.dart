// To parse this JSON data, do
//
//     final sbtStacksListModel = sbtStacksListModelFromJson(jsonString);

import 'dart:convert';

SbtStacksListModel sbtStacksListModelFromJson(String str) =>
    SbtStacksListModel.fromJson(json.decode(str));

String sbtStacksListModelToJson(SbtStacksListModel data) =>
    json.encode(data.toJson());

class SbtStacksListModel {
  dynamic status;
  dynamic message;
  List<StacksListDatum>? data;

  SbtStacksListModel({
    this.status,
    this.message,
    this.data,
  });

  factory SbtStacksListModel.fromJson(Map<String, dynamic> json) =>
      SbtStacksListModel(
        status: json["status"],
        message: json["Message"],
        data: json["data"] == null
            ? []
            : List<StacksListDatum>.from(
                json["data"]!.map((x) => StacksListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class StacksListDatum {
  dynamic warehouseId;
  dynamic stackNo;

  StacksListDatum({
    this.warehouseId,
    this.stackNo,
  });

  factory StacksListDatum.fromJson(Map<String, dynamic> json) =>
      StacksListDatum(
        warehouseId: json["warehouse_id"],
        stackNo: json["stack_no"],
      );

  Map<String, dynamic> toJson() => {
        "warehouse_id": warehouseId,
        "stack_no": stackNo,
      };
}
