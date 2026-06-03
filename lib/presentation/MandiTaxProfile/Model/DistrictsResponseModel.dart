// To parse this JSON data, do
//
//     final districtsResponseModel = districtsResponseModelFromMap(jsonString);

import 'dart:convert';

DistrictsResponseModel districtsResponseModelFromMap(String str) =>
    DistrictsResponseModel.fromMap(json.decode(str));

String districtsResponseModelToMap(DistrictsResponseModel data) =>
    json.encode(data.toMap());

class DistrictsResponseModel {
  List<DistrictDatum>? data;
  dynamic status;
  dynamic message;

  DistrictsResponseModel({
    this.data,
    this.status,
    this.message,
  });

  factory DistrictsResponseModel.fromMap(Map<String, dynamic> json) =>
      DistrictsResponseModel(
        data: json["data"] == null
            ? []
            : List<DistrictDatum>.from(
                json["data"]!.map((x) => DistrictDatum.fromMap(x))),
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

class DistrictDatum {
  dynamic id;
  dynamic stateCode;
  dynamic districtCode;
  dynamic name;

  DistrictDatum({
    this.id,
    this.stateCode,
    this.districtCode,
    this.name,
  });

  factory DistrictDatum.fromMap(Map<String, dynamic> json) => DistrictDatum(
        id: json["id"],
        stateCode: json["state_code"],
        districtCode: json["district_code"],
        name: json["name"],
      );

  bool districtFilterByName(String filter) {
    return name.toString().toLowerCase().trim().contains(filter);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "state_code": stateCode,
        "district_code": districtCode,
        "name": name,
      };
}
