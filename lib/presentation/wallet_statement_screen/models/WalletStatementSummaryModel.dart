// To parse this JSON data, do
//
//     final walletStatementSummaryModel = walletStatementSummaryModelFromJson(jsonString);

import 'dart:convert';

WalletStatementSummaryModel walletStatementSummaryModelFromJson(String str) =>
    WalletStatementSummaryModel.fromJson(json.decode(str));

String walletStatementSummaryModelToJson(WalletStatementSummaryModel data) =>
    json.encode(data.toJson());

class WalletStatementSummaryModel {
  List<WalletStatementSummaryDatum>? data;
  dynamic openingBalance;
  dynamic closingBalance;
  dynamic status;
  dynamic message;

  WalletStatementSummaryModel({
    this.data,
    this.openingBalance,
    this.closingBalance,
    this.status,
    this.message,
  });

  factory WalletStatementSummaryModel.fromJson(Map<String, dynamic> json) =>
      WalletStatementSummaryModel(
        data: json["data"] == null
            ? []
            : List<WalletStatementSummaryDatum>.from(json["data"]!
                .map((x) => WalletStatementSummaryDatum.fromJson(x))),
        openingBalance: json["opening_balance"],
        closingBalance: json["closing_balance"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "opening_balance": openingBalance,
        "closing_balance": closingBalance,
        "status": status,
        "message": message,
      };
}

class WalletStatementSummaryDatum {
  dynamic label;
  dynamic type;
  dynamic amount;

  WalletStatementSummaryDatum({
    this.label,
    this.type,
    this.amount,
  });

  factory WalletStatementSummaryDatum.fromJson(Map<String, dynamic> json) =>
      WalletStatementSummaryDatum(
        label: json["label"],
        type: json["type"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "type": type,
        "amount": amount,
      };
}
