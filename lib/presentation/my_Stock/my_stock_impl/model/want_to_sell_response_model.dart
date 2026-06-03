// To parse this JSON data, do
//
//     final wantToSellResponseModel = wantToSellResponseModelFromMap(jsonString);

import 'dart:convert';

WantToSellResponseModel wantToSellResponseModelFromMap(String str) =>
    WantToSellResponseModel.fromMap(json.decode(str));

String wantToSellResponseModelToMap(WantToSellResponseModel data) =>
    json.encode(data.toMap());

class WantToSellResponseModel {
  String? data;
  String? status;
  String? message;

  WantToSellResponseModel({
    this.data,
    this.status,
    this.message,
  });

  factory WantToSellResponseModel.fromMap(Map<String, dynamic> json) =>
      WantToSellResponseModel(
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
