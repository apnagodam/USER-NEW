// To parse this JSON data, do
//
//     final pdfResponseModel = pdfResponseModelFromMap(jsonString);

import 'dart:convert';

PdfResponseModel pdfResponseModelFromMap(String str) => PdfResponseModel.fromMap(json.decode(str));

String pdfResponseModelToMap(PdfResponseModel data) => json.encode(data.toMap());

class PdfResponseModel {
  String? data;
  String? status;
  String? message;

  PdfResponseModel({
    this.data,
    this.status,
    this.message,
  });

  factory PdfResponseModel.fromMap(Map<String, dynamic> json) => PdfResponseModel(
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
