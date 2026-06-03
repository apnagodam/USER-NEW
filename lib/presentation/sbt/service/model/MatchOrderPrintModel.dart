// To parse this JSON data, do
//
//     final matchOrderPrintModel = matchOrderPrintModelFromMap(jsonString);

import 'dart:convert';

MatchOrderPrintModel matchOrderPrintModelFromMap(String str) =>
    MatchOrderPrintModel.fromMap(json.decode(str));

String matchOrderPrintModelToMap(MatchOrderPrintModel data) =>
    json.encode(data.toMap());

class MatchOrderPrintModel {
  String? status;
  String? message;
  TradeOrderData? tradeOrderData;

  MatchOrderPrintModel({
    this.status,
    this.message,
    this.tradeOrderData,
  });

  factory MatchOrderPrintModel.fromMap(Map<String, dynamic> json) =>
      MatchOrderPrintModel(
        status: json["status"],
        message: json["message"],
        tradeOrderData: json["trade_order_data"] == null
            ? null
            : TradeOrderData.fromMap(json["trade_order_data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "trade_order_data": tradeOrderData?.toMap(),
      };
}

class TradeOrderData {
  String? noteNo;
  String? buyerAdd;
  String? sellerAdd;
  String? buyerName;
  String? sellerName;
  String? product;
  String? quantity;
  String? deliverdQty;
  dynamic rate;
  String? omDate;
  String? expDate;

  TradeOrderData({
    this.noteNo,
    this.buyerAdd,
    this.sellerAdd,
    this.buyerName,
    this.sellerName,
    this.product,
    this.quantity,
    this.deliverdQty,
    this.rate,
    this.omDate,
    this.expDate,
  });

  factory TradeOrderData.fromMap(Map<String, dynamic> json) => TradeOrderData(
        noteNo: json["note_no"],
        buyerAdd: json["buyer_add"],
        sellerAdd: json["seller_add"],
        buyerName: json["buyer_name"],
        sellerName: json["seller_name"],
        product: json["product"],
        quantity: json["quantity"],
        deliverdQty: json["deliverd_qty"],
        rate: json["rate"],
        omDate: json["om_date"],
        expDate: json["exp_date"],
      );

  Map<String, dynamic> toMap() => {
        "note_no": noteNo,
        "buyer_add": buyerAdd,
        "seller_add": sellerAdd,
        "buyer_name": buyerName,
        "seller_name": sellerName,
        "product": product,
        "quantity": quantity,
        "deliverd_qty": deliverdQty,
        "rate": rate,
        "om_date": omDate,
        "exp_date": expDate,
      };
}
