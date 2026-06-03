// To parse this JSON data, do
//
//     final stacksTerminalListModel = stacksTerminalListModelFromMap(jsonString);

import 'dart:convert';

StacksTerminalListModel stacksTerminalListModelFromMap(String str) =>
    StacksTerminalListModel.fromMap(json.decode(str));

String stacksTerminalListModelToMap(StacksTerminalListModel data) =>
    json.encode(data.toMap());

class StacksTerminalListModel {
  dynamic status;
  dynamic message;
  List<StacksTerminalDatum>? data;

  StacksTerminalListModel({
    this.status,
    this.message,
    this.data,
  });

  factory StacksTerminalListModel.fromMap(Map<String, dynamic> json) =>
      StacksTerminalListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<StacksTerminalDatum>.from(
                json["data"]!.map((x) => StacksTerminalDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class StacksTerminalDatum {
  dynamic id;
  dynamic name;

  StacksTerminalDatum({
    this.id,
    this.name,
  });

  factory StacksTerminalDatum.fromMap(Map<String, dynamic> json) =>
      StacksTerminalDatum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
  bool userFilterByCreationDate(String filter) {
    return name.toString().toLowerCase().trim().contains(filter);
  }
}
