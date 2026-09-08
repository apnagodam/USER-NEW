import 'dart:convert';

UserSendOtpResponseModel userSendOtpResponseModelFromMap(String str) =>
    UserSendOtpResponseModel.fromMap(json.decode(str));

String userSendOtpResponseModelToMap(UserSendOtpResponseModel data) =>
    json.encode(data.toMap());

class UserSendOtpResponseModel {
  dynamic userId;
  dynamic status;
  String? otp;
  String? message;

  UserSendOtpResponseModel({
    this.userId,
    this.status,
    this.otp,
    this.message,
  });

  factory UserSendOtpResponseModel.fromMap(Map<String, dynamic> json) =>
      UserSendOtpResponseModel(
        userId: json["user_id"],
        status: json["status"],
        otp: json["otp"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "status": status,
        "otp": otp,
        "message": message,
      };
}
