// To parse this JSON data, do
//
//     final financeBankListResponse = financeBankListResponseFromMap(jsonString);

import 'dart:convert';

FinanceBankListResponse financeBankListResponseFromMap(String str) => FinanceBankListResponse.fromMap(json.decode(str));

String financeBankListResponseToMap(FinanceBankListResponse data) => json.encode(data.toMap());

class FinanceBankListResponse {
  List<Bank>? banks;
  String? status;
  String? message;

  FinanceBankListResponse({
    this.banks,
    this.status,
    this.message,
  });

  factory FinanceBankListResponse.fromMap(Map<String, dynamic> json) => FinanceBankListResponse(
    banks: json["banks"] == null ? [] : List<Bank>.from(json["banks"]!.map((x) => Bank.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "banks": banks == null ? [] : List<dynamic>.from(banks!.map((x) => x.toMap())),
    "status": status,
    "message": message,
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
  dynamic guarantor;
  dynamic guaranteeFee;
  dynamic tenor;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic sanctionLimit;
  String? apr;

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
    this.sanctionLimit,
    this.apr,
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    sanctionLimit: json["sanction_limit"],
    apr: json["apr"],
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "sanction_limit": sanctionLimit,
    "apr": apr,
  };
}
