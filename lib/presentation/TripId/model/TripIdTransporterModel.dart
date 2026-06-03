// To parse this JSON data, do
//
//     final tripTransporterModel = tripTransporterModelFromMap(jsonString);

import 'dart:convert';

TripTransporterModel tripTransporterModelFromMap(String str) =>
    TripTransporterModel.fromMap(json.decode(str));

String tripTransporterModelToMap(TripTransporterModel data) =>
    json.encode(data.toMap());

class TripTransporterModel {
  List<Datum>? data;
  String? status;
  String? message;

  TripTransporterModel({
    this.data,
    this.status,
    this.message,
  });

  factory TripTransporterModel.fromMap(Map<String, dynamic> json) =>
      TripTransporterModel(
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
  dynamic id;
  String? name;
  String? number;

  Datum({
    this.id,
    this.name,
    this.number,
  });
  bool userFilterByCreationDate(String filter) {
    return name.toString().toLowerCase().trim().contains(filter);
  }

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        number: json["number"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "number": number,
      };
}
