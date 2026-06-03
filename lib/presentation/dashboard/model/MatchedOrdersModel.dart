// To parse this JSON data, do
//
//     final matchedOrdersModel = matchedOrdersModelFromMap(jsonString);

import 'dart:convert';

MatchedOrdersModel matchedOrdersModelFromMap(String str) =>
    MatchedOrdersModel.fromMap(json.decode(str));

String matchedOrdersModelToMap(MatchedOrdersModel data) =>
    json.encode(data.toMap());

class MatchedOrdersModel {
  dynamic status;
  dynamic message;
  List<TradeOrderDatum>? tradeOrderData;

  MatchedOrdersModel({
    this.status,
    this.message,
    this.tradeOrderData,
  });

  factory MatchedOrdersModel.fromMap(Map<String, dynamic> json) =>
      MatchedOrdersModel(
        status: json["status"],
        message: json["message"],
        tradeOrderData: json["trade_order_data"] == null
            ? []
            : List<TradeOrderDatum>.from(json["trade_order_data"]!
                .map((x) => TradeOrderDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "trade_order_data": tradeOrderData == null
            ? []
            : List<dynamic>.from(tradeOrderData!.map((x) => x.toMap())),
      };
}

class TradeOrderDatum {
  dynamic orderId;
  dynamic seller;
  dynamic buyer;
  dynamic commodity;
  dynamic district;
  dynamic rate;
  dynamic qty;
  dynamic deliverQty;
  dynamic date;
  dynamic expiryDate;

  TradeOrderDatum(
      {this.orderId,
      this.seller,
      this.buyer,
      this.commodity,
      this.district,
      this.rate,
      this.qty,
      this.deliverQty,
      this.date,
      this.expiryDate});

  factory TradeOrderDatum.fromMap(Map<String, dynamic> json) => TradeOrderDatum(
        orderId: json["order_id"],
        seller: json["seller"],
        buyer: json["Buyer"],
        commodity: json["commodity"],
        district: json["district"],
        rate: json["rate"],
        qty: json["qty"],
        deliverQty: json['delivery_qty'],
        date: json["date"],
        expiryDate: json["expiry_date"],
      );

  Map<String, dynamic> toMap() => {
        "order_id": orderId,
        "seller": seller,
        "Buyer": buyer,
        "commodity": commodity,
        "district": district,
        "rate": rate,
        "qty": qty,
        "delivery_qty": deliverQty,
        "date": date,
        "expiry_date": expiryDate
      };
}
