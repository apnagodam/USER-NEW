// To parse this JSON data, do
//
//     final districtWiseCommodityModel = districtWiseCommodityModelFromMap(jsonString);

import 'dart:convert';

DistrictWiseCommodityModel districtWiseCommodityModelFromMap(String str) =>
    DistrictWiseCommodityModel.fromMap(json.decode(str));

String districtWiseCommodityModelToMap(DistrictWiseCommodityModel data) =>
    json.encode(data.toMap());

class DistrictWiseCommodityModel {
  List<Datum>? data;
  dynamic status;
  dynamic message;

  DistrictWiseCommodityModel({
    this.data,
    this.status,
    this.message,
  });

  factory DistrictWiseCommodityModel.fromMap(Map<String, dynamic> json) =>
      DistrictWiseCommodityModel(
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
  dynamic commodity;

  Datum({
    this.id,
    this.commodity,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        commodity: json["commodity"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "commodity": commodity,
      };
}
