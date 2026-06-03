// To parse this JSON data, do
//
//     final candFModel = candFModelFromJson(jsonString);

import 'dart:convert';

CandFModel candFModelFromJson(String str) =>
    CandFModel.fromJson(json.decode(str));

String candFModelToJson(CandFModel data) => json.encode(data.toJson());

class CandFModel {
  dynamic status;
  dynamic message;
  List<CandFDatum>? data;

  CandFModel({
    this.status,
    this.message,
    this.data,
  });

  factory CandFModel.fromJson(Map<String, dynamic> json) => CandFModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CandFDatum>.from(
                json["data"]!.map((x) => CandFDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CandFDatum {
  dynamic id;
  dynamic userName;

  CandFDatum({
    this.id,
    this.userName,
  });
  bool stateFilterByName(String filter) {
    return userName.toString().toLowerCase().trim().contains(filter);
  }

  factory CandFDatum.fromJson(Map<String, dynamic> json) => CandFDatum(
        id: json["id"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
      };
}
