// To parse this JSON data, do
//
//     final holdSummaryModel = holdSummaryModelFromMap(jsonString);

import 'dart:convert';

HoldSummaryModel holdSummaryModelFromMap(String str) =>
    HoldSummaryModel.fromMap(json.decode(str));

String holdSummaryModelToMap(HoldSummaryModel data) =>
    json.encode(data.toMap());

class HoldSummaryModel {
  List<Datum>? data;
  dynamic message;
  dynamic status;
  dynamic totalSum;

  HoldSummaryModel({this.data, this.message, this.status, this.totalSum});

  factory HoldSummaryModel.fromMap(Map<String, dynamic> json) =>
      HoldSummaryModel(
          data: json["data"] == null
              ? []
              : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
          message: json["Message"],
          status: json["status"],
          totalSum: json['total_sum']);

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "Message": message,
        "status": status,
        'total_sum': totalSum
      };
}

class Datum {
  dynamic amount;
  dynamic commodityName;
  dynamic pfAmount;
  dynamic date;
  dynamic gatepass;
  dynamic warehouseName;
  dynamic createdAt;
  dynamic districtId;
  dynamic price;
  dynamic qty;
  dynamic type;
  dynamic uniqueTradeId;
  dynamic taxRate;
  dynamic loadCharge;
  dynamic dealtype;

  Datum(
      {this.amount,
      this.pfAmount,
      this.commodityName,
      this.date,
      this.gatepass,
      this.warehouseName,
      this.createdAt,
      this.districtId,
      this.price,
      this.qty,
      this.type,
      this.uniqueTradeId,
      this.taxRate,
      this.loadCharge,
      this.dealtype});

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
      amount: json["amount"],
      pfAmount: json['pf_amount'],
      commodityName: json["commodity_name"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      gatepass: json["gatepass"],
      warehouseName: json["warehouse_name"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      districtId: json["district_id"],
      price: json["price"],
      qty: json["qty"],
      type: json["type"],
      uniqueTradeId: json["unique_trade_id"],
      taxRate: json['taxrate'],
      loadCharge: json['load_charge'],
      dealtype: json['dealtype']);

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "pf_amount": pfAmount,
        "commodity_name": commodityName,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "gatepass": gatepass,
        "warehouse_name": warehouseName,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "district_id": districtId,
        "price": price,
        "qty": qty,
        "type": type,
        "unique_trade_id": uniqueTradeId,
        "taxrate": taxRate,
        "load_charge": loadCharge,
        "dealtype": dealtype
      };
}
