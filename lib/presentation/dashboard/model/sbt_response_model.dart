// To parse this JSON data, do
//
//     final sbtResponseModel = sbtResponseModelFromMap(jsonString);

import 'dart:convert';

SbtResponseModel sbtResponseModelFromMap(String str) => SbtResponseModel.fromMap(json.decode(str));

String sbtResponseModelToMap(SbtResponseModel data) => json.encode(data.toMap());

class SbtResponseModel {
  dynamic status;
  dynamic message;
  dynamic data;

  SbtResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory SbtResponseModel.fromMap(Map<String, dynamic> json) => SbtResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
