// To parse this JSON data, do
//
//     final walletTransactionListModel = walletTransactionListModelFromMap(jsonString);

import 'dart:convert';

WalletTransactionListModel walletTransactionListModelFromMap(String str) =>
    WalletTransactionListModel.fromMap(json.decode(str));

String walletTransactionListModelToMap(WalletTransactionListModel data) =>
    json.encode(data.toMap());

class WalletTransactionListModel {
  List<Datum>? data;
  dynamic openingBalance;
  dynamic closingBalance;
  int? status;
  String? message;

  WalletTransactionListModel({
    this.data,
    this.openingBalance,
    this.closingBalance,
    this.status,
    this.message,
  });

  factory WalletTransactionListModel.fromMap(Map<String, dynamic> json) =>
      WalletTransactionListModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        openingBalance: json["opening_balance"]?.toDouble(),
        closingBalance: json["closing_balance"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "opening_balance": openingBalance,
        "closing_balance": closingBalance,
        "status": status,
        "message": message,
      };
}

class Datum {
  int? id;
  int? userId;
  String? label;
  String? narration;
  String? referenceNo;
  String? amount;
  String? type;
  String? balance;
  String? days;
  String? remark;
  String? date;
  int? status;

  Datum({
    this.id,
    this.userId,
    this.label,
    this.narration,
    this.referenceNo,
    this.amount,
    this.type,
    this.balance,
    this.days,
    this.remark,
    this.date,
    this.status,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        label: json["label"],
        narration: json["narration"],
        referenceNo: json["reference_no"],
        amount: json["amount"],
        type: json["type"],
        balance: json["balance"],
        days: json["days"],
        remark: json["remark"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "label": label,
        "narration": narration,
        "reference_no": referenceNo,
        "amount": amount,
        "type": type,
        "balance": balance,
        "days": days,
        "remark": remark,
        "date": date,
        "status": status,
      };
}
