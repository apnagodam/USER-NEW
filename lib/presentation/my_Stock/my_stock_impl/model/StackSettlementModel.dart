// To parse this JSON data, do
//
//     final stackSettlementModel = stackSettlementModelFromMap(jsonString);

import 'dart:convert';

StackSettlementModel stackSettlementModelFromMap(String str) =>
    StackSettlementModel.fromMap(json.decode(str));

String stackSettlementModelToMap(StackSettlementModel data) =>
    json.encode(data.toMap());

class StackSettlementModel {
  dynamic status;
  dynamic message;
  Data? data;

  StackSettlementModel({
    this.status,
    this.message,
    this.data,
  });

  factory StackSettlementModel.fromMap(Map<String, dynamic> json) =>
      StackSettlementModel(
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
  dynamic stackType;
  dynamic qty;
  dynamic invRent;
  dynamic idleTime;
  dynamic idletimeDays;
  dynamic idleCapacity;
  dynamic idlecapacityDays;
  dynamic wsa;
  dynamic wsaDays;
  dynamic wsaAmount;
  dynamic bnpl;
  dynamic bnplIntrest;
  dynamic loan;
  dynamic intrest;
  dynamic panelIntrest;
  dynamic todayStockValue;
  dynamic settlementAmt;
  dynamic walletBalance;
  dynamic sellerAgCommisionAmount;

  Data(
      {this.stackType,
      this.qty,
      this.invRent,
      this.idleTime,
      this.idletimeDays,
      this.idleCapacity,
      this.idlecapacityDays,
      this.wsa,
      this.wsaDays,
      this.wsaAmount,
      this.bnpl,
      this.bnplIntrest,
      this.loan,
      this.intrest,
      this.panelIntrest,
      this.todayStockValue,
      this.settlementAmt,
      this.walletBalance,
      this.sellerAgCommisionAmount});

  factory Data.fromMap(Map<String, dynamic> json) => Data(
      stackType: json["stack_type"],
      qty: json["qty"],
      invRent: json["inv_rent"],
      idleTime: json["idle_time"],
      idletimeDays: json["idletime_days"],
      idleCapacity: json["idle_capacity"],
      idlecapacityDays: json["idlecapacity_days"],
      wsa: json["wsa"],
      wsaDays: json["wsa_days"],
      wsaAmount: json["wsa_amount"],
      bnpl: json["bnpl"],
      bnplIntrest: json["bnpl_intrest"],
      loan: json["loan"],
      intrest: json["intrest"],
      panelIntrest: json["panel_intrest"],
      todayStockValue: json["today_stock_value"],
      settlementAmt: json["settlement_amt"],
      walletBalance: json['wallet_amt'],
      sellerAgCommisionAmount: json['seller_ag_comm_amt']);

  Map<String, dynamic> toMap() => {
        "stack_type": stackType,
        "qty": qty,
        "inv_rent": invRent,
        "idle_time": idleTime,
        "idletime_days": idletimeDays,
        "idle_capacity": idleCapacity,
        "idlecapacity_days": idlecapacityDays,
        "wsa": wsa,
        "wsa_days": wsaDays,
        "wsa_amount": wsaAmount,
        "bnpl": bnpl,
        "bnpl_intrest": bnplIntrest,
        "loan": loan,
        "intrest": intrest,
        "panel_intrest": panelIntrest,
        "today_stock_value": todayStockValue,
        "settlement_amt": settlementAmt,
        "wallet_amt": walletBalance,
        "seller_ag_comm_amt": sellerAgCommisionAmount
      };
}
