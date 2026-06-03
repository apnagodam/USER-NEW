// To parse this JSON data, do
//
//     final tripIdModel = tripIdModelFromMap(jsonString);

import 'dart:convert';

TripIdModel tripIdModelFromMap(String str) =>
    TripIdModel.fromMap(json.decode(str));

String tripIdModelToMap(TripIdModel data) => json.encode(data.toMap());

class TripIdModel {
  String? status;
  String? message;
  List<Datum>? data;

  TripIdModel({
    this.status,
    this.message,
    this.data,
  });

  factory TripIdModel.fromMap(Map<String, dynamic> json) => TripIdModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  int? id;
  String? tripRequestId;

  Datum({
    this.id,
    this.tripRequestId,
  });
  bool userFilterByCreationDate(String filter) {
    return tripRequestId.toString().toLowerCase().trim().contains(filter);
  }

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        tripRequestId: json["trip_request_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "trip_request_id": tripRequestId,
      };
}
