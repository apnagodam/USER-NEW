import 'dart:convert';

UserTradeLimitReqModel userTradeLimitReqModelFromMap(String str) =>
    UserTradeLimitReqModel.fromMap(json.decode(str));

String userTradeLimitReqModelToMap(UserTradeLimitReqModel data) =>
    json.encode(data.toMap());

class UserTradeLimitReqModel {
  dynamic status;
  String? message;
  List<UserTradeLimitItem>? data;

  UserTradeLimitReqModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserTradeLimitReqModel.fromJson(String str) =>
      UserTradeLimitReqModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserTradeLimitReqModel.fromMap(Map<String, dynamic> json) =>
      UserTradeLimitReqModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<UserTradeLimitItem>.from(
                json["data"]!.map((x) => UserTradeLimitItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class UserTradeLimitItem {
  dynamic id;
  String? tmName;
  String? clientSecurityType;
  dynamic amount;
  dynamic hairCut;
  dynamic tradelimit;
  String? date;

  UserTradeLimitItem({
    this.id,
    this.tmName,
    this.clientSecurityType,
    this.amount,
    this.hairCut,
    this.tradelimit,
    this.date,
  });

  factory UserTradeLimitItem.fromJson(String str) =>
      UserTradeLimitItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserTradeLimitItem.fromMap(Map<String, dynamic> json) =>
      UserTradeLimitItem(
        id: json["id"],
        tmName: json["tmName"] ?? json["tm_name"],
        clientSecurityType:
            json["client_security_type"] ?? json["clientSecurityType"],
        amount: json["amount"],
        hairCut: json["hairCut"] ?? json["hair_cut"],
        tradelimit: json["tradelimit"] ?? json["trade_limit"],
        date: json["date"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tmName": tmName,
        "client_security_type": clientSecurityType,
        "amount": amount,
        "hairCut": hairCut,
        "tradelimit": tradelimit,
        "date": date,
      };
}
