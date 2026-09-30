// To parse this JSON data, do
//
//     final sbtRequestListModel = sbtRequestListModelFromMap(jsonString);

import 'dart:convert';

SbtRequestListModel sbtRequestListModelFromMap(String str) =>
    SbtRequestListModel.fromMap(json.decode(str));

String sbtRequestListModelToMap(SbtRequestListModel data) =>
    json.encode(data.toMap());

class SbtRequestListModel {
  List<Datum>? data;
  dynamic status;
  dynamic message;

  SbtRequestListModel({
    this.data,
    this.status,
    this.message,
  });

  factory SbtRequestListModel.fromMap(Map<String, dynamic> json) =>
      SbtRequestListModel(
        data: json["data"] == null ? [] : List<Datum>.from(
            json["data"]!.map((x) => Datum.fromMap(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() =>
      {
        "data": data == null ? [] : List<dynamic>.from(
            data!.map((x) => x.toMap())),
        "status": status,
        "message": message,
      };
}

class Datum {
  dynamic id;
  dynamic type;
  dynamic districtId;
  dynamic commodity;
  dynamic qty;
  dynamic price;
  dynamic uniqueTradeId;
  dynamic status;
  dynamic createdAt;
  dynamic walletHold;
  dynamic sbtType;
  dynamic tlType;

  Datum({
    this.id,
    this.type,
    this.districtId,
    this.commodity,
    this.qty,
    this.price,
    this.uniqueTradeId,
    this.status,
    this.createdAt,
    this.walletHold,
    this.sbtType,
    this.tlType,
  });

  /// Show Truck Load button only when sbt_type==2 && tlType==1
  bool get isTruckLoad {
    final sbtStr = (sbtType ?? '').toString().trim();
    final tlStr = (tlType ?? '').toString().trim();
    return sbtStr == '2' && (tlStr == '1' || tlType == 1);
  }

  factory Datum.fromMap(Map<String, dynamic> json) =>
      Datum(
        id: json["id"],
        type: json["type"],
        districtId: json["district_id"],
        commodity: json["commodity"],
        qty: json["qty"],
        price: json["price"],
        uniqueTradeId: json["unique_trade_id"],
        status: json["status"],
        walletHold: json['wallet_hold'],
        createdAt: json["created_at"] == null ? null : DateTime.parse(
            json["created_at"]),
        sbtType: json["sbt_type"],
        tlType: json["tlType"] ?? json["tl_type"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "type": type,
        "district_id": districtId,
        "commodity": commodity,
        "qty": qty,
        "price": price,
        "unique_trade_id": uniqueTradeId,
        "status": status,
        'wallet_hold': walletHold,
        "created_at": "${createdAt!.year.toString().padLeft(
            4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!
            .day.toString().padLeft(2, '0')}",
      };
}
