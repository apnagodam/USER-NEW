// To parse this JSON data, do
//
//     final sbtTerminalsListModel = sbtTerminalsListModelFromJson(jsonString);

import 'dart:convert';

SbtTerminalsListModel sbtTerminalsListModelFromJson(String str) =>
    SbtTerminalsListModel.fromJson(json.decode(str));

String sbtTerminalsListModelToJson(SbtTerminalsListModel data) =>
    json.encode(data.toJson());

class SbtTerminalsListModel {
  dynamic status;
  dynamic message;
  List<SbtTerminalDatum>? data;

  SbtTerminalsListModel({
    this.status,
    this.message,
    this.data,
  });

  factory SbtTerminalsListModel.fromJson(Map<String, dynamic> json) =>
      SbtTerminalsListModel(
        status: json["status"],
        message: json["Message"],
        data: json["data"] == null
            ? []
            : List<SbtTerminalDatum>.from(
                json["data"]!.map((x) => SbtTerminalDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SbtTerminalDatum {
  dynamic id;
  dynamic warehouseName;

  SbtTerminalDatum({
    this.id,
    this.warehouseName,
  });

  factory SbtTerminalDatum.fromJson(Map<String, dynamic> json) =>
      SbtTerminalDatum(
        id: json["id"],
        warehouseName: json["warehouse_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "warehouse_name": warehouseName,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SbtTerminalDatum &&
          runtimeType == other.runtimeType &&
          id.toString() == other.id.toString();

  @override
  int get hashCode => id.toString().hashCode;
}
