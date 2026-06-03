// To parse this JSON data, do
//
//     final baseResponseModel = baseResponseModelFromMap(jsonString);

import 'dart:convert';

BaseResponseModel baseResponseModelFromMap(String str) => BaseResponseModel.fromMap(json.decode(str));

String baseResponseModelToMap(BaseResponseModel data) => json.encode(data.toMap());

class BaseResponseModel {
  dynamic status;
  String? message;

  BaseResponseModel({
    this.status,
    this.message,
  });

  factory BaseResponseModel.fromMap(Map<String, dynamic> json) => BaseResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
  };
}
