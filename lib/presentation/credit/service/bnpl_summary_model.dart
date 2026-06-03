// To parse this JSON data, do
//
//     final bnplSummaryModel = bnplSummaryModelFromMap(jsonString);

import 'dart:convert';

BnplSummaryModel bnplSummaryModelFromMap(String str) => BnplSummaryModel.fromMap(json.decode(str));

String bnplSummaryModelToMap(BnplSummaryModel data) => json.encode(data.toMap());

class BnplSummaryModel {
  List<Datum>? data;
  dynamic status;
  dynamic message;

  BnplSummaryModel({
    this.data,
    this.status,
    this.message,
  });

  factory BnplSummaryModel.fromMap(Map<String, dynamic> json) => BnplSummaryModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "status": status,
    "message": message,
  };
}

class Datum {
  dynamic id;
  dynamic userId;
  dynamic bnplRequestId;
  dynamic uniqueId;
  dynamic amount;
  dynamic remainingAmount;
  dynamic interestRate;
  dynamic remark;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic interestCount;

  Datum({
    this.id,
    this.userId,
    this.bnplRequestId,
    this.uniqueId,
    this.amount,
    this.remainingAmount,
    this.interestRate,
    this.remark,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.interestCount,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    bnplRequestId: json["bnpl_request_id"],
    uniqueId: json["unique_id"],
    amount: json["amount"],
    remainingAmount: json["remaining_amount"],
    interestRate: json["interest_rate"],
    remark: json["remark"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    interestCount: json["interest_count"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "bnpl_request_id": bnplRequestId,
    "unique_id": uniqueId,
    "amount": amount,
    "remaining_amount": remainingAmount,
    "interest_rate": interestRate,
    "remark": remark,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "interest_count": interestCount,
  };
}
