// To parse this JSON data, do
//
//     final sbtHoldSummaryModel = sbtHoldSummaryModelFromMap(jsonString);

import 'dart:convert';

SbtHoldSummaryModel sbtHoldSummaryModelFromMap(String str) => SbtHoldSummaryModel.fromMap(json.decode(str));

String sbtHoldSummaryModelToMap(SbtHoldSummaryModel data) => json.encode(data.toMap());

class SbtHoldSummaryModel {
  dynamic status;
  dynamic message;
  List<Datum>? data;

  SbtHoldSummaryModel({
    this.status,
    this.message,
    this.data,
  });

  factory SbtHoldSummaryModel.fromMap(Map<String, dynamic> json) => SbtHoldSummaryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  dynamic id;
  dynamic userId;
  dynamic type;
  dynamic parentTradeId;
  dynamic productId;
  dynamic districtId;
  dynamic qty;
  dynamic commodity;
  dynamic price;
  dynamic sbtHold;
  dynamic walletHold;
  dynamic uniqueTradeId;
  dynamic cancelledBy;
  dynamic cancelledReason;
  dynamic cancelledDate;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic uName;
  dynamic uPhone;
  dynamic category;
  dynamic disName;

  Datum({
    this.id,
    this.userId,
    this.type,
    this.parentTradeId,
    this.productId,
    this.districtId,
    this.qty,
    this.commodity,
    this.price,
    this.sbtHold,
    this.walletHold,
    this.uniqueTradeId,
    this.cancelledBy,
    this.cancelledReason,
    this.cancelledDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.uName,
    this.uPhone,
    this.category,
    this.disName,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    parentTradeId: json["parent_trade_id"],
    productId: json["product_id"],
    districtId: json["district_id"],
    qty: json["qty"],
    commodity: json["commodity"],
    price: json["price"],
    sbtHold: json["sbt_hold"],
    walletHold: json["wallet_hold"],
    uniqueTradeId: json["unique_trade_id"],
    cancelledBy: json["cancelled_by"],
    cancelledReason: json["cancelled_reason"],
    cancelledDate: json["cancelled_date"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    uName: json["u_name"],
    uPhone: json["u_phone"],
    category: json["category"],
    disName: json["dis_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "type": type,
    "parent_trade_id": parentTradeId,
    "product_id": productId,
    "district_id": districtId,
    "qty": qty,
    "commodity": commodity,
    "price": price,
    "sbt_hold": sbtHold,
    "wallet_hold": walletHold,
    "unique_trade_id": uniqueTradeId,
    "cancelled_by": cancelledBy,
    "cancelled_reason": cancelledReason,
    "cancelled_date": cancelledDate,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "u_name": uName,
    "u_phone": uPhone,
    "category": category,
    "dis_name": disName,
  };
}
