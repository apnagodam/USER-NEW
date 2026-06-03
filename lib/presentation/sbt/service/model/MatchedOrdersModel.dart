// To parse this JSON data, do
//
//     final matchedOrdersModel = matchedOrdersModelFromMap(jsonString);

import 'dart:convert';

MatchedOrdersModel matchedOrdersModelFromMap(String str) =>
    MatchedOrdersModel.fromMap(json.decode(str));

String matchedOrdersModelToMap(MatchedOrdersModel data) =>
    json.encode(data.toMap());

class MatchedOrdersModel {
  List<MatchedOrdersDatum>? data;
  dynamic status;
  dynamic message;

  MatchedOrdersModel({
    this.data,
    this.status,
    this.message,
  });

  factory MatchedOrdersModel.fromMap(Map<String, dynamic> json) =>
      MatchedOrdersModel(
        data: json["data"] == null
            ? []
            : List<MatchedOrdersDatum>.from(
                json["data"]!.map((x) => MatchedOrdersDatum.fromMap(x))),
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

class MatchedOrdersDatum {
  dynamic id;
  dynamic orderId;
  dynamic type;
  dynamic qty;
  dynamic deliveryQty;
  dynamic price;
  dynamic districtName;
  dynamic districtId;
  dynamic commodityName;
  dynamic sellerName;
  dynamic buyerName;
  dynamic commodityId;
  dynamic createdAt;

  MatchedOrdersDatum({
    this.id,
    this.orderId,
    this.type,
    this.qty,
    this.deliveryQty,
    this.price,
    this.districtName,
    this.districtId,
    this.commodityName,
    this.sellerName,
    this.buyerName,
    this.commodityId,
    this.createdAt,
  });

  factory MatchedOrdersDatum.fromMap(Map<String, dynamic> json) =>
      MatchedOrdersDatum(
        id: json["id"],
        orderId: json["order_id"],
        type: json["type"],
        qty: json["qty"],
        deliveryQty: json["delivery_qty"],
        price: json["price"],
        districtName: json["district_name"],
        districtId: json['district_id'],
        commodityName: json["commodity_name"],
        sellerName: json['seller_fname'],
        buyerName: json['buyer_fname'],
        commodityId: json['commodity_id'],
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
        "district_id": districtId,
        "commodity_name": commodityName,
        "seller_fname":sellerName,
        "buyer_fname":buyerName,
        "commodity_id": commodityId,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}
