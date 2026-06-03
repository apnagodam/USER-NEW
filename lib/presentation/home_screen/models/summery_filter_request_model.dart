// To parse this JSON data, do
//
//     final summaryFilterModel = summaryFilterModelFromMap(jsonString);

import 'dart:convert';

SummaryFilterRequestModel summaryFilterModelFromMap(String str) => SummaryFilterRequestModel.fromMap(json.decode(str));

String summaryFilterModelToMap(SummaryFilterRequestModel data) => json.encode(data.toMap());

class SummaryFilterRequestModel {
  List<String>? commodityId;
  List<String>? warehouseId;

  SummaryFilterRequestModel({
    this.commodityId,
    this.warehouseId,
  });

  factory SummaryFilterRequestModel.fromMap(Map<String, dynamic> json) => SummaryFilterRequestModel(
    commodityId: json["commodity_id"] == null ? [] : List<String>.from(json["commodity_id"]!.map((x) => x)),
    warehouseId: json["warehouse_id"] == null ? [] : List<String>.from(json["warehouse_id"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "commodity_id": commodityId == null ? [] : List<dynamic>.from(commodityId!.map((x) => x)),
    "warehouse_id": warehouseId == null ? [] : List<dynamic>.from(warehouseId!.map((x) => x)),
  };
}
