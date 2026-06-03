// To parse this JSON data, do
//
//     final summaryFilterResponseModel = summaryFilterResponseModelFromMap(jsonString);

import 'dart:convert';

SummaryFilterResponseModel summaryFilterResponseModelFromMap(String str) => SummaryFilterResponseModel.fromMap(json.decode(str));

String summaryFilterResponseModelToMap(SummaryFilterResponseModel data) => json.encode(data.toMap());

class SummaryFilterResponseModel {
  dynamic status;
  dynamic message;
  Data? data;

  SummaryFilterResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory SummaryFilterResponseModel.fromMap(Map<String, dynamic> json) => SummaryFilterResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  dynamic wiLoanWgt;
  dynamic wiLoanBeg;
  dynamic wiLoanPer;
  dynamic loanTotalWgt;
  dynamic loanTotalBeg;
  dynamic loanPer;
  dynamic totalWgt;
  dynamic totalBeg;

  Data({
    this.wiLoanWgt,
    this.wiLoanBeg,
    this.wiLoanPer,
    this.loanTotalWgt,
    this.loanTotalBeg,
    this.loanPer,
    this.totalWgt,
    this.totalBeg,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    wiLoanWgt: json["wi_loan_wgt"],
    wiLoanBeg: json["wi_loan_beg"],
    wiLoanPer: json["wi_loan_per"],
    loanTotalWgt: json["loan_total_wgt"],
    loanTotalBeg: json["loan_total_beg"],
    loanPer: json["loan_per"],
    totalWgt: json["total_wgt"],
    totalBeg: json["total_beg"],
  );

  Map<String, dynamic> toMap() => {
    "wi_loan_wgt": wiLoanWgt,
    "wi_loan_beg": wiLoanBeg,
    "wi_loan_per": wiLoanPer,
    "loan_total_wgt": loanTotalWgt,
    "loan_total_beg": loanTotalBeg,
    "loan_per": loanPer,
    "total_wgt": totalWgt,
    "total_beg": totalBeg,
  };
}
