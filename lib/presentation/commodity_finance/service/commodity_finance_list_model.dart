// To parse this JSON data, do
//
//     final commodityFinanceListModel = commodityFinanceListModelFromMap(jsonString);

import 'dart:convert';

CommodityFinanceListModel commodityFinanceListModelFromMap(String str) => CommodityFinanceListModel.fromMap(json.decode(str));

String commodityFinanceListModelToMap(CommodityFinanceListModel data) => json.encode(data.toMap());

class CommodityFinanceListModel {
  List<Datum>? data;
  String? status;
  String? message;

  CommodityFinanceListModel({
    this.data,
    this.status,
    this.message,
  });

  factory CommodityFinanceListModel.fromMap(Map<String, dynamic> json) => CommodityFinanceListModel(
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
  dynamic bankId;
  String? uniqueId;
  dynamic requestedAmount;
  dynamic approvedAmount;
  String? remark;
  dynamic sanctionLatter;
  dynamic pda;
  dynamic pdc;
  dynamic agreement;
  dynamic approvedBy;
  dynamic verifiedBy;
  dynamic rejectedBy;
  String? approvedDate;
  String? verifiedDate;
  dynamic finalVerification;
  dynamic docVerifyedBy;
  dynamic status;
  String? createdAt;
  String? updatedAt;
  String? bankName;
  Bank? bank;

  Datum({
    this.id,
    this.userId,
    this.bankId,
    this.uniqueId,
    this.requestedAmount,
    this.approvedAmount,
    this.remark,
    this.sanctionLatter,
    this.pda,
    this.pdc,
    this.agreement,
    this.approvedBy,
    this.verifiedBy,
    this.rejectedBy,
    this.approvedDate,
    this.verifiedDate,
    this.finalVerification,
    this.docVerifyedBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.bankName,
    this.bank,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    bankId: json["bank_id"],
    uniqueId: json["unique_id"],
    requestedAmount: json["requested_amount"],
    approvedAmount: json["approved_amount"],
    remark: json["remark"],
    sanctionLatter: json["sanction_latter"],
    pda: json["pda"],
    pdc: json["pdc"],
    agreement: json["agreement"],
    approvedBy: json["approved_by"],
    verifiedBy: json["verified_by"],
    rejectedBy: json["rejected_by"],
    approvedDate: json["approved_date"],
    verifiedDate: json["verified_date"],
    finalVerification: json["final_verification"],
    docVerifyedBy: json["doc_verifyed_by"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    bankName: json["bank_name"],
    bank: json["bank"] == null ? null : Bank.fromMap(json["bank"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "bank_id": bankId,
    "unique_id": uniqueId,
    "requested_amount": requestedAmount,
    "approved_amount": approvedAmount,
    "remark": remark,
    "sanction_latter": sanctionLatter,
    "pda": pda,
    "pdc": pdc,
    "agreement": agreement,
    "approved_by": approvedBy,
    "verified_by": verifiedBy,
    "rejected_by": rejectedBy,
    "approved_date": approvedDate,
    "verified_date": verifiedDate,
    "final_verification": finalVerification,
    "doc_verifyed_by": docVerifyedBy,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "bank_name": bankName,
    "bank": bank?.toMap(),
  };
}

class Bank {
  dynamic id;
  String? bankName;
  String? url;
  String? address;
  String? interestRate;
  String? loanPassDays;
  String? processingFee;
  String? loanPerTotalAmount;
  String? guarantor;
  dynamic guaranteeFee;
  dynamic tenor;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  Bank({
    this.id,
    this.bankName,
    this.url,
    this.address,
    this.interestRate,
    this.loanPassDays,
    this.processingFee,
    this.loanPerTotalAmount,
    this.guarantor,
    this.guaranteeFee,
    this.tenor,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Bank.fromMap(Map<String, dynamic> json) => Bank(
    id: json["id"],
    bankName: json["bank_name"],
    url: json["url"],
    address: json["address"],
    interestRate: json["interest_rate"],
    loanPassDays: json["loan_pass_days"],
    processingFee: json["processing_fee"],
    loanPerTotalAmount: json["loan_per_total_amount"],
    guarantor: json["guarantor"],
    guaranteeFee: json["guarantee_fee"],
    tenor: json["tenor"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "bank_name": bankName,
    "url": url,
    "address": address,
    "interest_rate": interestRate,
    "loan_pass_days": loanPassDays,
    "processing_fee": processingFee,
    "loan_per_total_amount": loanPerTotalAmount,
    "guarantor": guarantor,
    "guarantee_fee": guaranteeFee,
    "tenor": tenor,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
