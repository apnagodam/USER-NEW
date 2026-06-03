// To parse this JSON data, do
//
//     final addMoneySummaryModel = addMoneySummaryModelFromMap(jsonString);

import 'dart:convert';

AddMoneySummaryModel addMoneySummaryModelFromMap(String str) =>
    AddMoneySummaryModel.fromMap(json.decode(str));

String addMoneySummaryModelToMap(AddMoneySummaryModel data) =>
    json.encode(data.toMap());

class AddMoneySummaryModel {
  List<Datum>? data;
  dynamic status;
  dynamic message;

  AddMoneySummaryModel({
    this.data,
    this.status,
    this.message,
  });

  factory AddMoneySummaryModel.fromMap(Map<String, dynamic> json) =>
      AddMoneySummaryModel(
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
  dynamic userId;
  dynamic uniqueLoanReqNo;
  dynamic paymentType;
  dynamic receptNo;
  dynamic appliedAmount;
  dynamic recivedAmount;
  dynamic paymentImage;
  dynamic paymentApproveBy;
  dynamic paymentVerifyBy;
  dynamic notes;
  dynamic verifyStatus;
  dynamic paymentStatus;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic fname;
  dynamic phone;

  Datum({
    this.id,
    this.userId,
    this.uniqueLoanReqNo,
    this.paymentType,
    this.receptNo,
    this.appliedAmount,
    this.recivedAmount,
    this.paymentImage,
    this.paymentApproveBy,
    this.paymentVerifyBy,
    this.notes,
    this.verifyStatus,
    this.paymentStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.fname,
    this.phone,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        uniqueLoanReqNo: json["unique_loan_req_no"],
        paymentType: json["payment_type"],
        receptNo: json["recept_no"],
        appliedAmount: json["applied_amount"],
        recivedAmount: json["recived_amount"],
        paymentImage: json["payment_image"],
        paymentApproveBy: json["payment_approve_by"],
        paymentVerifyBy: json["payment_verify_by"],
        notes: json["notes"],
        verifyStatus: json["verify_status"],
        paymentStatus: json["payment_status"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        fname: json["fname"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "unique_loan_req_no": uniqueLoanReqNo,
        "payment_type": paymentType,
        "recept_no": receptNo,
        "applied_amount": appliedAmount,
        "recived_amount": recivedAmount,
        "payment_image": paymentImage,
        "payment_approve_by": paymentApproveBy,
        "payment_verify_by": paymentVerifyBy,
        "notes": notes,
        "verify_status": verifyStatus,
        "payment_status": paymentStatus,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "fname": fname,
        "phone": phone,
      };
}
