// To parse this JSON data, do
//
//     final summaryCommodityModel = summaryCommodityModelFromMap(jsonString);

import 'dart:convert';

SummaryCommodityModel summaryCommodityModelFromMap(String str) =>
    SummaryCommodityModel.fromMap(json.decode(str));

String summaryCommodityModelToMap(SummaryCommodityModel data) =>
    json.encode(data.toMap());

class SummaryCommodityModel {
  dynamic status;
  String? message;
  List<Datum>? data;
  List<WareHousedatum>? wareHousedata;

  SummaryCommodityModel({
    this.status,
    this.message,
    this.data,
    this.wareHousedata,
  });

  factory SummaryCommodityModel.fromMap(Map<String, dynamic> json) =>
      SummaryCommodityModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        wareHousedata: json["ware_housedata"] == null
            ? []
            : List<WareHousedatum>.from(
                json["ware_housedata"]!.map((x) => WareHousedatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "ware_housedata": wareHousedata == null
            ? []
            : List<dynamic>.from(wareHousedata!.map((x) => x.toMap())),
      };
}

class Datum {
  dynamic id;
  String? commodityName;

  Datum({
    this.id,
    this.commodityName,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        commodityName: json["commodity_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "commodity_name": commodityName,
      };
  bool userFilterByCreationDate(String filter) {
    return commodityName.toString().toLowerCase().trim().contains(filter);
  }
}

class WareHousedatum {
  dynamic id;
  String? warehouseName;

  WareHousedatum({
    this.id,
    this.warehouseName,
  });

  factory WareHousedatum.fromMap(Map<String, dynamic> json) => WareHousedatum(
        id: json["id"],
        warehouseName: json["warehouse_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "warehouse_name": warehouseName,
      };
  bool userFilterByCreationDate(String filter) {
    return warehouseName.toString().toLowerCase().trim().contains(filter);
  }
}
