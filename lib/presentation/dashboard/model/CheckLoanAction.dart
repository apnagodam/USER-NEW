// To parse this JSON data, do
//
//     final checkLoanActionResponse = checkLoanActionResponseFromMap(jsonString);

import 'dart:convert';

CheckLoanActionResponse checkLoanActionResponseFromMap(String str) => CheckLoanActionResponse.fromMap(json.decode(str));

String checkLoanActionResponseToMap(CheckLoanActionResponse data) => json.encode(data.toMap());

class CheckLoanActionResponse {
  dynamic loanStatus;
  dynamic commodityPrice;
  dynamic status;
  dynamic message;

  CheckLoanActionResponse({
    this.loanStatus,
    this.commodityPrice,
    this.status,
    this.message,
  });

  factory CheckLoanActionResponse.fromMap(Map<String, dynamic> json) => CheckLoanActionResponse(
    loanStatus: json["loan_status"],
    commodityPrice: json["commodity_price"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "loan_status": loanStatus,
    "commodity_price": commodityPrice,
    "status": status,
    "message": message,
  };
}
