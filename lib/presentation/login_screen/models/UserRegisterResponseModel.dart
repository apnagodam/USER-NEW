import 'dart:convert';

UserRegisterResponseModel userRegisterResponseModelFromMap(String str) =>
    UserRegisterResponseModel.fromMap(json.decode(str));

String userRegisterResponseModelToMap(UserRegisterResponseModel data) =>
    json.encode(data.toMap());

class UserRegisterResponseModel {
  String? authorization;
  dynamic userId;
  dynamic status;
  String? message;

  UserRegisterResponseModel({
    this.authorization,
    this.userId,
    this.status,
    this.message,
  });

  factory UserRegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      UserRegisterResponseModel(
        authorization: json["Authorization"],
        userId: json["user_id"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "Authorization": authorization,
        "user_id": userId,
        "status": status,
        "message": message,
      };
}
