// To parse this JSON data, do
//
//     final holdStatementListModel = holdStatementListModelFromMap(jsonString);

import 'dart:convert';

HoldStatementListModel holdStatementListModelFromMap(String str) =>
    HoldStatementListModel.fromMap(json.decode(str));

String holdStatementListModelToMap(HoldStatementListModel data) =>
    json.encode(data.toMap());

class HoldStatementListModel {
  List<Datum>? data;
  dynamic status;
  dynamic message;

  HoldStatementListModel({
    this.data,
    this.status,
    this.message,
  });

  factory HoldStatementListModel.fromMap(Map<String, dynamic> json) =>
      HoldStatementListModel(
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
  dynamic type;
  dynamic amount;

  Datum({
    this.type,
    this.amount,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        type: json["type"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "amount": amount,
      };
}
