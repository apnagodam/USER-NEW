// To parse this JSON data, do
//
//     final sbtContractNoteModel = sbtContractNoteModelFromMap(jsonString);

import 'dart:convert';

SbtContractNoteModel sbtContractNoteModelFromMap(String str) =>
    SbtContractNoteModel.fromMap(json.decode(str));

String sbtContractNoteModelToMap(SbtContractNoteModel data) =>
    json.encode(data.toMap());

class SbtContractNoteModel {
  List<SbtContractDatum>? data;
  dynamic status;
  dynamic message;

  SbtContractNoteModel({
    this.data,
    this.status,
    this.message,
  });

  factory SbtContractNoteModel.fromMap(Map<String, dynamic> json) =>
      SbtContractNoteModel(
        data: json["data"] == null
            ? []
            : List<SbtContractDatum>.from(
                json["data"]!.map((x) => SbtContractDatum.fromMap(x))),
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

class SbtContractDatum {
  dynamic id;
  dynamic orderId;
  dynamic type;
  dynamic qty;
  dynamic deliveryQty;
  dynamic price;
  dynamic districtName;
  dynamic commodityName;
  dynamic createdAt;

  SbtContractDatum({
    this.id,
    this.orderId,
    this.type,
    this.qty,
    this.deliveryQty,
    this.price,
    this.districtName,
    this.commodityName,
    this.createdAt,
  });

  factory SbtContractDatum.fromMap(Map<String, dynamic> json) =>
      SbtContractDatum(
        id: json["id"],
        orderId: json["order_id"],
        type: json["type"],
        qty: json["qty"],
        deliveryQty: json["delivery_qty"],
        price: json["price"],
        districtName: json["district_name"],
        commodityName: json["commodity_name"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "type": type,
        "qty": qty,
        "delivery_qty": deliveryQty,
        "price": price,
        "district_name": districtName,
        "commodity_name": commodityName,
        "created_at": createdAt,
      };
}
