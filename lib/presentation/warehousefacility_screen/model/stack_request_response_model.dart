// To parse this JSON data, do
//
//     final stackBookResponseModel = stackBookResponseModelFromMap(jsonString);

import 'dart:convert';

StackBookResponseModel stackBookResponseModelFromMap(String str) =>
    StackBookResponseModel.fromMap(json.decode(str));

String stackBookResponseModelToMap(StackBookResponseModel data) =>
    json.encode(data.toMap());

class StackBookResponseModel {
  int? data;
  String? status;
  String? message;

  StackBookResponseModel({
    this.data,
    this.status,
    this.message,
  });

  factory StackBookResponseModel.fromMap(Map<String, dynamic> json) =>
      StackBookResponseModel(
        data: json["data"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data,
        "status": status,
        "message": message,
      };
}
