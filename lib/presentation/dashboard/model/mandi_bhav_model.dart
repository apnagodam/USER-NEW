// To parse this JSON data, do
//
//     final mandiBhavModel = mandiBhavModelFromMap(jsonString);

import 'dart:convert';

MandiBhavModel mandiBhavModelFromMap(String str) =>
    MandiBhavModel.fromMap(json.decode(str));

String mandiBhavModelToMap(MandiBhavModel data) => json.encode(data.toMap());

class MandiBhavModel {
  List<Datum>? orderData;
  List<Datum>? emandiData;
  dynamic status;
  dynamic message;

  MandiBhavModel({
    this.orderData,
    this.emandiData,
    this.status,
    this.message,
  });

  factory MandiBhavModel.fromMap(Map<String, dynamic> json) => MandiBhavModel(
        orderData: json["order_data"] == null
            ? []
            : List<Datum>.from(
                json["order_data"]!.map((x) => Datum.fromMap(x))),
        emandiData: json["emandi_data"] == null
            ? []
            : List<Datum>.from(
                json["emandi_data"]!.map((x) => Datum.fromMap(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "order_data": orderData == null
            ? []
            : List<dynamic>.from(orderData!.map((x) => x.toMap())),
        "emandi_data": emandiData == null
            ? []
            : List<dynamic>.from(emandiData!.map((x) => x.toMap())),
        "status": status,
        "message": message,
      };
}

class Datum {
  dynamic price;
  dynamic commodity;
  dynamic commodityImg;
  dynamic state;
  dynamic mandiName;
  dynamic createdAt;

  Datum({
    this.price,
    this.commodity,
    this.commodityImg,
    this.state,
    this.mandiName,
    this.createdAt,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        price: json["price"],
        commodity: json["commodity"],
        commodityImg: json["commodity_img"],
        state: json["state"],
        mandiName: json["mandi_name"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "price": price,
        "commodity": commodity,
        "commodity_img": commodityImg,
        "state": state,
        "mandi_name": mandiName,
        "created_at": createdAt,
      };
}
