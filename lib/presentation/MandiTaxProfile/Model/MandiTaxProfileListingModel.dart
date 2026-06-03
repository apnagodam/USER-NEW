// To parse this JSON data, do
//
//     final mandiTaxProfileListingModel = mandiTaxProfileListingModelFromJson(jsonString);

import 'dart:convert';

MandiTaxProfileListingModel mandiTaxProfileListingModelFromJson(String str) =>
    MandiTaxProfileListingModel.fromJson(json.decode(str));

String mandiTaxProfileListingModelToJson(MandiTaxProfileListingModel data) =>
    json.encode(data.toJson());

class MandiTaxProfileListingModel {
  dynamic status;
  dynamic message;
  List<Datum>? data;

  MandiTaxProfileListingModel({
    this.status,
    this.message,
    this.data,
  });

  factory MandiTaxProfileListingModel.fromJson(Map<String, dynamic> json) =>
      MandiTaxProfileListingModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic id;
  dynamic userName;
  dynamic phone;
  dynamic stateName;
  dynamic districtName;
  dynamic isLicence;
  dynamic licanceType;
  dynamic licanceNumber;
  dynamic issueDate;
  dynamic expiryDate;
  dynamic referenceNumber;
  dynamic candf;
  dynamic image;
  dynamic status;
  dynamic activeStatus;

  Datum({
    this.id,
    this.userName,
    this.phone,
    this.stateName,
    this.districtName,
    this.isLicence,
    this.licanceType,
    this.licanceNumber,
    this.issueDate,
    this.expiryDate,
    this.referenceNumber,
    this.candf,
    this.image,
    this.status,
    this.activeStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userName: json["user_name"],
        phone: json["phone"],
        stateName: json["state_name"],
        districtName: json["district_name"],
        isLicence: json["is_licence"],
        licanceType: json["licance_type"],
        licanceNumber: json["licance_number"],
        issueDate: json["issue_date"],
        expiryDate: json["expiry_date"],
        referenceNumber: json["reference_number"],
        candf: json["candf"],
        image: json["image"],
        status: json["status"],
        activeStatus: json["active_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "phone": phone,
        "state_name": stateName,
        "district_name": districtName,
        "is_licence": isLicence,
        "licance_type": licanceType,
        "licance_number": licanceNumber,
        "issue_date": issueDate,
        "expiry_date": expiryDate,
        "reference_number": referenceNumber,
        "candf": candf,
        "image": image,
        "status": status,
        "active_status": activeStatus,
      };
}
