// To parse this JSON data, do
//
//     final stacksCommodityListModel = stacksCommodityListModelFromMap(jsonString);

import 'dart:convert';

StacksCommodityListModel stacksCommodityListModelFromMap(String str) =>
    StacksCommodityListModel.fromMap(json.decode(str));

String stacksCommodityListModelToMap(StacksCommodityListModel data) =>
    json.encode(data.toMap());

class StacksCommodityListModel {
  dynamic status;
  dynamic message;
  List<StacksCommodityDatum>? data;

  StacksCommodityListModel({
    this.status,
    this.message,
    this.data,
  });

  factory StacksCommodityListModel.fromMap(Map<String, dynamic> json) =>
      StacksCommodityListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<StacksCommodityDatum>.from(
                json["data"]!.map((x) => StacksCommodityDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class StacksCommodityDatum {
  dynamic id;
  dynamic name;

  StacksCommodityDatum({
    this.id,
    this.name,
  });

  factory StacksCommodityDatum.fromMap(Map<String, dynamic> json) =>
      StacksCommodityDatum(
        id: json["id"],
        name: json["name"],
      );
  bool userFilterByCreationDate(String filter) {
    return name.toString().toLowerCase().trim().contains(filter);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
