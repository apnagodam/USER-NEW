// To parse this JSON data, do
//
//     final bnplListModel = bnplListModelFromMap(jsonString);

import 'dart:convert';

BnplListModel bnplListModelFromMap(String str) => BnplListModel.fromMap(json.decode(str));

String bnplListModelToMap(BnplListModel data) => json.encode(data.toMap());

class BnplListModel {
  List<Datum>? data;
  dynamic bnplPower;
  dynamic status;
  String? message;

  BnplListModel({
    this.data,
    this.bnplPower,
    this.status,
    this.message,
  });

  factory BnplListModel.fromMap(Map<String, dynamic> json) => BnplListModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    bnplPower: json["bnpl_power"]?.toDouble(),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "bnpl_power": bnplPower,
    "status": status,
    "message": message,
  };
}

class Datum {
  dynamic id;
  dynamic userId;
  String? uniqueId;
  dynamic requestedAmount;
  dynamic approvedAmount;
  dynamic usedAmount;
  dynamic interestRate;
  dynamic approvedBy;
  String? approvedDate;
  dynamic verifiedBy;
  String? verifiedDate;
  dynamic remark;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Datum({
    this.id,
    this.userId,
    this.uniqueId,
    this.requestedAmount,
    this.approvedAmount,
    this.usedAmount,
    this.interestRate,
    this.approvedBy,
    this.approvedDate,
    this.verifiedBy,
    this.verifiedDate,
    this.remark,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    uniqueId: json["unique_id"],
    requestedAmount: json["requested_amount"],
    approvedAmount: json["approved_amount"],
    usedAmount: json["used_amount"],
    interestRate: json["interest_rate"],
    approvedBy: json["approved_by"],
    approvedDate: json["approved_date"],
    verifiedBy: json["verified_by"],
    verifiedDate: json["verified_date"],
    remark: json["remark"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "unique_id": uniqueId,
    "requested_amount": requestedAmount,
    "approved_amount": approvedAmount,
    "used_amount": usedAmount,
    "interest_rate": interestRate,
    "approved_by": approvedBy,
    "approved_date": approvedDate,
    "verified_by": verifiedBy,
    "verified_date": verifiedDate,
    "remark": remark,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
