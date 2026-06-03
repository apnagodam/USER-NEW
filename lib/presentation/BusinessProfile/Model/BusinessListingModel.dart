// To parse this JSON data, do
//
//     final businessLIstingModel = businessLIstingModelFromJson(jsonString);

import 'dart:convert';

BusinessLIstingModel businessLIstingModelFromJson(String str) =>
    BusinessLIstingModel.fromJson(json.decode(str));

String businessLIstingModelToJson(BusinessLIstingModel data) =>
    json.encode(data.toJson());

class BusinessLIstingModel {
  dynamic status;
  dynamic message;
  Data? data;

  BusinessLIstingModel({
    this.status,
    this.message,
    this.data,
  });

  factory BusinessLIstingModel.fromJson(Map<String, dynamic> json) =>
      BusinessLIstingModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  dynamic id;
  dynamic type;
  dynamic userId;
  dynamic stateId;
  dynamic districtId;
  dynamic tehsil;
  dynamic khasraNo;
  dynamic landMap;
  dynamic annualCapicity;
  dynamic investerAnnualCapicity;
  dynamic milsType;
  dynamic dailyCapacity;
  dynamic commodityId;
  dynamic generatedBy;
  dynamic approveBy;
  dynamic verifyBy;
  dynamic rejectBy;
  dynamic approveDate;
  dynamic verifyDate;
  dynamic rejectDate;
  dynamic image;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic userType;
  dynamic summery;
  dynamic state;
  dynamic district;
  dynamic commodity;
  StateName? stateName;
  DistrictName? districtName;

  Data({
    this.id,
    this.type,
    this.userId,
    this.stateId,
    this.districtId,
    this.tehsil,
    this.khasraNo,
    this.landMap,
    this.annualCapicity,
    this.investerAnnualCapicity,
    this.milsType,
    this.dailyCapacity,
    this.commodityId,
    this.generatedBy,
    this.approveBy,
    this.verifyBy,
    this.rejectBy,
    this.approveDate,
    this.verifyDate,
    this.rejectDate,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userType,
    this.summery,
    this.state,
    this.district,
    this.commodity,
    this.stateName,
    this.districtName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        userId: json["user_id"],
        stateId: json["state_id"],
        districtId: json["district_id"],
        tehsil: json["tehsil"],
        khasraNo: json["khasra_no"],
        landMap: json["land_map"],
        annualCapicity: json["annual_capicity"],
        investerAnnualCapicity: json["invester_annual_capicity"],
        milsType: json["mils_type"],
        dailyCapacity: json["daily_capacity"],
        commodityId: json["commodity_id"],
        generatedBy: json["generated_by"],
        approveBy: json["approve_by"],
        verifyBy: json["verify_by"],
        rejectBy: json["reject_by"],
        approveDate: json["approve_date"],
        verifyDate: json["verify_date"],
        rejectDate: json["reject_date"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userType: json["user_type"],
        summery: json["summery"],
        state: json["state"],
        district: json["district"],
        commodity: json["commodity"],
        stateName: json["state_name"] == null
            ? null
            : StateName.fromJson(json["state_name"]),
        districtName: json["district_name"] == null
            ? null
            : DistrictName.fromJson(json["district_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "user_id": userId,
        "state_id": stateId,
        "district_id": districtId,
        "tehsil": tehsil,
        "khasra_no": khasraNo,
        "land_map": landMap,
        "annual_capicity": annualCapicity,
        "invester_annual_capicity": investerAnnualCapicity,
        "mils_type": milsType,
        "daily_capacity": dailyCapacity,
        "commodity_id": commodityId,
        "generated_by": generatedBy,
        "approve_by": approveBy,
        "verify_by": verifyBy,
        "reject_by": rejectBy,
        "approve_date": approveDate,
        "verify_date": verifyDate,
        "reject_date": rejectDate,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_type": userType,
        "summery": summery,
        "state": state,
        "district": district,
        "commodity": commodity,
        "state_name": stateName?.toJson(),
        "district_name": districtName?.toJson(),
      };
}

class DistrictName {
  dynamic id;
  dynamic stateCode;
  dynamic districtCode;
  dynamic name;

  DistrictName({
    this.id,
    this.stateCode,
    this.districtCode,
    this.name,
  });

  factory DistrictName.fromJson(Map<String, dynamic> json) => DistrictName(
        id: json["id"],
        stateCode: json["state_code"],
        districtCode: json["district_code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_code": stateCode,
        "district_code": districtCode,
        "name": name,
      };
}

class StateName {
  dynamic id;
  dynamic name;
  dynamic code;
  dynamic countryId;

  StateName({
    this.id,
    this.name,
    this.code,
    this.countryId,
  });

  factory StateName.fromJson(Map<String, dynamic> json) => StateName(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "country_id": countryId,
      };
}
