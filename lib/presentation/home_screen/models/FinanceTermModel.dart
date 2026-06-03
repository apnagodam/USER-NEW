// To parse this JSON data, do
//
//     final financeTermModel = financeTermModelFromMap(jsonString);

import 'dart:convert';

FinanceTermModel financeTermModelFromMap(String str) => FinanceTermModel.fromMap(json.decode(str));

String financeTermModelToMap(FinanceTermModel data) => json.encode(data.toMap());

class FinanceTermModel {
  Data? data;
  String? view;
  String? status;
  String? message;

  FinanceTermModel({
    this.data,
    this.view,
    this.status,
    this.message,
  });

  factory FinanceTermModel.fromMap(Map<String, dynamic> json) => FinanceTermModel(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    view: json["view"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
    "view": view,
    "status": status,
    "message": message,
  };
}

class Data {
  String? ltv;
  String? processingFess;
  String? cgst;
  String? sgst;
  dynamic gurentyFees;
  String? netPayment;

  Data({
    this.ltv,
    this.processingFess,
    this.cgst,
    this.sgst,
    this.gurentyFees,
    this.netPayment,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    ltv: json["ltv"],
    processingFess: json["processing_fess"],
    cgst: json["cgst"],
    sgst: json["sgst"],
    gurentyFees: json["gurenty_fees"],
    netPayment: json["net_payment"],
  );

  Map<String, dynamic> toMap() => {
    "ltv": ltv,
    "processing_fess": processingFess,
    "cgst": cgst,
    "sgst": sgst,
    "gurenty_fees": gurentyFees,
    "net_payment": netPayment,
  };
}
