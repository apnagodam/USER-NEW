import 'dart:convert';

CheckUserModel checkUserModelFromMap(String str) =>
    CheckUserModel.fromMap(json.decode(str));

String checkUserModelToMap(CheckUserModel data) =>
    json.encode(data.toMap());

class CheckUserModel {
  dynamic status;
  String? message;
  List<CheckUserData>? data;

  CheckUserModel({
    this.status,
    this.message,
    this.data,
  });

  factory CheckUserModel.fromMap(Map<String, dynamic> json) => CheckUserModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CheckUserData>.from(
                json["data"]!.map((x) => CheckUserData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class CheckUserData {
  String? name;
  dynamic userId;
  String? phone;

  CheckUserData({
    this.name,
    this.userId,
    this.phone,
  });

  factory CheckUserData.fromMap(Map<String, dynamic> json) => CheckUserData(
        name: json["name"],
        userId: json["user_id"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "user_id": userId,
        "phone": phone,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckUserData &&
          runtimeType == other.runtimeType &&
          userId.toString() == other.userId.toString();

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() => name ?? "";
}
