// To parse this JSON data, do
//
//     final otpResponseModel = otpResponseModelFromMap(jsonString);

import 'dart:convert';

OtpResponseModel otpResponseModelFromMap(String str) => OtpResponseModel.fromMap(json.decode(str));

String otpResponseModelToMap(OtpResponseModel data) => json.encode(data.toMap());

class OtpResponseModel {
  String? phone;
  String? status;
  String? message;

  OtpResponseModel({
    this.phone,
    this.status,
    this.message,
  });

  factory OtpResponseModel.fromMap(Map<String, dynamic> json) => OtpResponseModel(
    phone: json["phone"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "phone": phone,
    "status": status,
    "message": message,
  };
}
