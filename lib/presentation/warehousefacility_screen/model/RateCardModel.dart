// To parse this JSON data, do
//
//     final rateCardModel = rateCardModelFromMap(jsonString);

import 'dart:convert';

RateCardModel rateCardModelFromMap(String str) => RateCardModel.fromMap(json.decode(str));

String rateCardModelToMap(RateCardModel data) => json.encode(data.toMap());

class RateCardModel {
  Data? data;
  String? status;
  String? message;

  RateCardModel({
    this.data,
    this.status,
    this.message,
  });

  factory RateCardModel.fromMap(Map<String, dynamic> json) => RateCardModel(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
    "status": status,
    "message": message,
  };
}

class Data {
  dynamic id;
  dynamic stackId;
  dynamic stackRequestId;
  dynamic userId;
  dynamic warehouseId;
  dynamic commodityId;
  String? interestRate;
  String? processingFee;
  String? labourCharge;
  String? warehouseRent;
  String? wsaCharge;
  String? entryLoad;
  String? exitLoad;
  dynamic lockInCheck;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.stackId,
    this.stackRequestId,
    this.userId,
    this.warehouseId,
    this.commodityId,
    this.interestRate,
    this.processingFee,
    this.labourCharge,
    this.warehouseRent,
    this.wsaCharge,
    this.entryLoad,
    this.exitLoad,
    this.lockInCheck,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    stackId: json["stack_id"],
    stackRequestId: json["stack_request_id"],
    userId: json["user_id"],
    warehouseId: json["warehouse_id"],
    commodityId: json["commodity_id"],
    interestRate: json["interest_rate"],
    processingFee: json["processing_fee"],
    labourCharge: json["labour_charge"],
    warehouseRent: json["warehouse_rent"],
    wsaCharge: json["wsa_charge"],
    entryLoad: json["entry_load"],
    exitLoad: json["exit_load"],
    lockInCheck: json["lock_in_check"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "stack_id": stackId,
    "stack_request_id": stackRequestId,
    "user_id": userId,
    "warehouse_id": warehouseId,
    "commodity_id": commodityId,
    "interest_rate": interestRate,
    "processing_fee": processingFee,
    "labour_charge": labourCharge,
    "warehouse_rent": warehouseRent,
    "wsa_charge": wsaCharge,
    "entry_load": entryLoad,
    "exit_load": exitLoad,
    "lock_in_check": lockInCheck,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
