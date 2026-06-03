// To parse this JSON data, do
//
//     final customerSupportModel = customerSupportModelFromJson(jsonString);

import 'dart:convert';

CustomerSupportModel customerSupportModelFromJson(String str) =>
    CustomerSupportModel.fromJson(json.decode(str));

String customerSupportModelToJson(CustomerSupportModel data) =>
    json.encode(data.toJson());

class CustomerSupportModel {
  dynamic status;
  dynamic message;
  List<Datum>? data;

  CustomerSupportModel({
    this.status,
    this.message,
    this.data,
  });

  factory CustomerSupportModel.fromJson(Map<String, dynamic> json) =>
      CustomerSupportModel(
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
  dynamic type;

  Datum({
    this.id,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}
