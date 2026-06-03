// To parse this JSON data, do
//
//     final emandiSellResponseModel = emandiSellResponseModelFromMap(jsonString);

import 'dart:convert';

EmandiSellResponseModel emandiSellResponseModelFromMap(String str) =>
    EmandiSellResponseModel.fromMap(json.decode(str));

String emandiSellResponseModelToMap(EmandiSellResponseModel data) =>
    json.encode(data.toMap());

class EmandiSellResponseModel {
  Data? data;
  num? salesStatus;
  num? mandiTax;
  num? interstDaysCount;
  String? status;
  String? message;

  EmandiSellResponseModel({
    this.data,
    this.salesStatus,
    this.mandiTax,
    this.interstDaysCount,
    this.status,
    this.message,
  });

  factory EmandiSellResponseModel.fromMap(Map<String, dynamic> json) =>
      EmandiSellResponseModel(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        salesStatus: json["sales_status"],
        mandiTax: json["mandi_tax"],
        interstDaysCount: json["interst_daysCount"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "sales_status": salesStatus,
        "mandi_tax": mandiTax,
        "interst_daysCount": interstDaysCount,
        "status": status,
        "message": message,
      };
}

class Data {
  dynamic principalAmount;
  dynamic rateOfInterest;
  String? loanApproveDate;
  String? interestFromDate;
  String? interestToDate;
  dynamic totalInterestAmount;
  dynamic totalInterestDays;
  String? rentToDate;
  String? rentFromDate;
  dynamic totalRentAmount;
  dynamic totalRentDays;
  dynamic bankId;
  String? bankName;
  dynamic mandiTax;
  dynamic bnplAmount;
  dynamic bnplInterest;

  Data({
    this.principalAmount,
    this.rateOfInterest,
    this.loanApproveDate,
    this.interestFromDate,
    this.interestToDate,
    this.totalInterestAmount,
    this.totalInterestDays,
    this.rentToDate,
    this.rentFromDate,
    this.totalRentAmount,
    this.totalRentDays,
    this.bankId,
    this.bankName,
    this.mandiTax,
    this.bnplAmount,
    this.bnplInterest,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        principalAmount: json["principal_amount"],
        rateOfInterest: json["rate_of_interest"],
        loanApproveDate: json["loan_approve_date"],
        interestFromDate: json["interest_from_date"],
        interestToDate: json["interest_to_date"],
        totalInterestAmount: json["total_interest_amount"],
        totalInterestDays: json["total_interest_days"],
        rentToDate: json["rent_to_date"],
        rentFromDate: json["rent_from_date"],
        totalRentAmount: json["total_rent_amount"]?.toDouble(),
        totalRentDays: json["total_rent_days"],
        bankId: json["bank_id"],
        bankName: json["bank_name"],
        mandiTax: json["mandi_tax"],
        bnplAmount: json["bnpl_amount"],
        bnplInterest: json["bnpl_interest"],
      );

  Map<String, dynamic> toMap() => {
        "principal_amount": principalAmount,
        "rate_of_interest": rateOfInterest,
        "loan_approve_date": loanApproveDate,
        "interest_from_date": interestFromDate,
        "interest_to_date": interestToDate,
        "total_interest_amount": totalInterestAmount,
        "total_interest_days": totalInterestDays,
        "rent_to_date": rentToDate,
        "rent_from_date": rentFromDate,
        "total_rent_amount": totalRentAmount,
        "total_rent_days": totalRentDays,
        "bank_id": bankId,
        "bank_name": bankName,
        "mandi_tax": mandiTax,
        "bnpl_amount": bnplAmount,
        "bnpl_interest": bnplInterest,
      };
}
