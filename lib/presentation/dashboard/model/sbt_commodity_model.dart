// To parse this JSON data, do
//
//     final sbtCommodityModel = sbtCommodityModelFromMap(jsonString);

import 'dart:convert';

SbtCommodityModel sbtCommodityModelFromMap(String str) =>
    SbtCommodityModel.fromMap(json.decode(str));

String sbtCommodityModelToMap(SbtCommodityModel data) =>
    json.encode(data.toMap());

class SbtCommodityModel {
  dynamic status;
  dynamic message;
  List<SbtDatum>? data;

  SbtCommodityModel({
    this.status,
    this.message,
    this.data,
  });

  factory SbtCommodityModel.fromMap(Map<String, dynamic> json) =>
      SbtCommodityModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SbtDatum>.from(
                json["data"]!.map((x) => SbtDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class SbtDatum {
  dynamic productId;
  dynamic districtId;
  dynamic district;
  dynamic commodityId;
  dynamic commodity;
  int? upperCircuit;
  int? lowerCircuit;
  int? quantityLimit;
  dynamic bestBuyer;
  dynamic bestSeller;
  dynamic date;
  dynamic ltp;
  dynamic sbtType;

  SbtDatum(
      {this.productId,
      this.districtId,
      this.district,
      this.commodityId,
      this.commodity,
      this.upperCircuit,
      this.lowerCircuit,
      this.quantityLimit,
      this.bestBuyer,
      this.bestSeller,
      this.date,
      this.ltp,
      this.sbtType});

  static int _safeParseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.round();
    final str = value.toString().trim();
    if (str.isEmpty) return 0;
    final parsedInt = int.tryParse(str);
    if (parsedInt != null) return parsedInt;
    final parsedDouble = double.tryParse(str);
    if (parsedDouble != null) return parsedDouble.round();
    return 0;
  }

  factory SbtDatum.fromMap(Map<String, dynamic> json) => SbtDatum(
      productId: json['product_id'],
      districtId: json["district_id"],
      district: json["district"],
      commodityId: json["commodity_id"],
      commodity: json["commodity"],
      upperCircuit: _safeParseInt(json["upper_circuit"]),
      lowerCircuit: _safeParseInt(json["lower_circuit"]),
      quantityLimit: _safeParseInt(json["quantity_limit"]),
      bestBuyer: json['best_buyer'],
      bestSeller: json['best_seller'],
      date: json["date"],
      ltp: json['ltp'],
      sbtType: json['sbt_type']);

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "district_id": districtId,
        "district": district,
        "commodity_id": commodityId,
        "commodity": commodity,
        "upper_circuit": upperCircuit,
        "lower_circuit": lowerCircuit,
        "quantity_limit": quantityLimit,
        "best_buyer": bestBuyer,
        "best_seller": bestSeller,
        "date": date,
        "ltp": ltp,
        "sbt_type": sbtType
      };
}
