// To parse this JSON data, do
//
//     final poModel = poModelFromMap(jsonString);

import 'dart:convert';

PoModel poModelFromMap(String str) => PoModel.fromMap(json.decode(str));

String poModelToMap(PoModel data) => json.encode(data.toMap());

class PoModel {
  List<Datum>? data;
  String? status;
  String? message;

  PoModel({
    this.data,
    this.status,
    this.message,
  });

  factory PoModel.fromMap(Map<String, dynamic> json) => PoModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "status": status,
        "message": message,
      };
}

class Datum {
  String? id;
  String? poIds;

  Datum({
    this.id,
    this.poIds,
  });

  bool userFilterByCreationDate(String filter) {
    return poIds.toString().toLowerCase().trim().contains(filter);
  }

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        poIds: json["po_ids"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "po_ids": poIds,
      };
}
