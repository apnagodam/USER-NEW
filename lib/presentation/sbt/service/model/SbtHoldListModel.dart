// To parse this JSON data, do
//
//     final sbtHoldListModel = sbtHoldListModelFromMap(jsonString);

import 'dart:convert';

SbtHoldListModel sbtHoldListModelFromMap(String str) => SbtHoldListModel.fromMap(json.decode(str));

String sbtHoldListModelToMap(SbtHoldListModel data) => json.encode(data.toMap());

class SbtHoldListModel {
  List<Datum>? data;
  Power? power;
  dynamic status;
  dynamic message;

  SbtHoldListModel({
    this.data,
    this.power,
    this.status,
    this.message,
  });

  factory SbtHoldListModel.fromMap(Map<String, dynamic> json) => SbtHoldListModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    power: json["power"] == null ? null : Power.fromMap(json["power"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "power": power?.toMap(),
    "status": status,
    "message": message,
  };
}

class Datum {
  dynamic id;
  dynamic type;
  dynamic qty;
  dynamic price;
  dynamic uniqueTradeId;
  dynamic walletHold;
  dynamic createdAt;

  Datum({
    this.id,
    this.type,
    this.qty,
    this.price,
    this.uniqueTradeId,
    this.walletHold,
    this.createdAt,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    qty: json["qty"],
    price: json["price"],
    uniqueTradeId: json["unique_trade_id"],
    walletHold: json["wallet_hold"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "type": type,
    "qty": qty,
    "price": price,
    "unique_trade_id": uniqueTradeId,
    "wallet_hold": walletHold,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
  };
}

class Power {
  dynamic power;
  dynamic holdPower;
  dynamic sbtHold;

  Power({
    this.power,
    this.holdPower,
    this.sbtHold,
  });

  factory Power.fromMap(Map<String, dynamic> json) => Power(
    power: json["power"],
    holdPower: json["hold_power"],
    sbtHold: json["sbt_hold"],
  );

  Map<String, dynamic> toMap() => {
    "power": power,
    "hold_power": holdPower,
    "sbt_hold": sbtHold,
  };
}
