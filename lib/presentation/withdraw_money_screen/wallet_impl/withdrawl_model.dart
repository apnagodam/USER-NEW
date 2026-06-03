// To parse this JSON data, do
//
//     final walletWithdrawlModel = walletWithdrawlModelFromMap(jsonString);

import 'dart:convert';

WalletWithdrawlModel walletWithdrawlModelFromMap(String str) =>
    WalletWithdrawlModel.fromMap(json.decode(str));

String walletWithdrawlModelToMap(WalletWithdrawlModel data) =>
    json.encode(data.toMap());

class WalletWithdrawlModel {
  List<Datum>? data;
  dynamic status;
  String? message;

  WalletWithdrawlModel({
    this.data,
    this.status,
    this.message,
  });

  factory WalletWithdrawlModel.fromMap(Map<String, dynamic> json) =>
      WalletWithdrawlModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "status": status,
        "message": message,
      };
}

class Datum {
  dynamic id;
  String? wrr;
  dynamic userId;
  dynamic requestedAmount;
  dynamic approvedAmount;
  dynamic paymentBy;
  dynamic referenceNo;
  dynamic file;
  String? remark;
  dynamic approvedBy;
  dynamic verifiedBy;
  String? poutId;
  String? fundAccountId;
  String? contactId;
  dynamic status;
  dynamic approvedDate;
  String? createdAt;
  String? updatedAt;

  Datum({
    this.id,
    this.wrr,
    this.userId,
    this.requestedAmount,
    this.approvedAmount,
    this.paymentBy,
    this.referenceNo,
    this.file,
    this.remark,
    this.approvedBy,
    this.verifiedBy,
    this.poutId,
    this.fundAccountId,
    this.contactId,
    this.status,
    this.approvedDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        wrr: json["wrr"],
        userId: json["user_id"],
        requestedAmount: json["requested_amount"],
        approvedAmount: json["approved_amount"],
        paymentBy: json["payment_by"],
        referenceNo: json["reference_no"],
        file: json["file"],
        remark: json["remark"],
        approvedBy: json["approved_by"],
        verifiedBy: json["verified_by"],
        poutId: json["pout_id"],
        fundAccountId: json["fund_account_id"],
        contactId: json["contact_id"],
        status: json["status"],
        approvedDate: json["approved_date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "wrr": wrr,
        "user_id": userId,
        "requested_amount": requestedAmount,
        "approved_amount": approvedAmount,
        "payment_by": paymentBy,
        "reference_no": referenceNo,
        "file": file,
        "remark": remark,
        "approved_by": approvedBy,
        "verified_by": verifiedBy,
        "pout_id": poutId,
        "fund_account_id": fundAccountId,
        "contact_id": contactId,
        "status": status,
        "approved_date": approvedDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
