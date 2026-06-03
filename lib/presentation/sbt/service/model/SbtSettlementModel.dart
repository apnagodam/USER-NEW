// To parse this JSON data, do
//
//     final sbtSettlementModel = sbtSettlementModelFromMap(jsonString);

import 'dart:convert';

SbtSettlementModel sbtSettlementModelFromMap(String str) =>
    SbtSettlementModel.fromMap(json.decode(str));

String sbtSettlementModelToMap(SbtSettlementModel data) =>
    json.encode(data.toMap());

class SbtSettlementModel {
  List<SettlementDatum>? data;
  int? status;
  String? message;

  SbtSettlementModel({
    this.data,
    this.status,
    this.message,
  });

  factory SbtSettlementModel.fromMap(Map<String, dynamic> json) =>
      SbtSettlementModel(
        data: json["data"] == null
            ? []
            : List<SettlementDatum>.from(
                json["data"]!.map((x) => SettlementDatum.fromMap(x))),
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

class SettlementDatum {
  int? id;
  String? reportType;
  String? createdAt;
  String? buyerName;
  String? sellerName;
  String? commodity;
  int? rate;
  double? quantity;
  int? gatepass;
  String? deliveryCenter;
  int? bags;
  double? weight;
  int? entryLoad;
  String? labour;
  String? client;
  int? qualityClaim;
  int? mandi;
  int? rent;
  int? wsa;
  int? netAmount;

  SettlementDatum({
    this.id,
    this.reportType,
    this.createdAt,
    this.buyerName,
    this.sellerName,
    this.commodity,
    this.rate,
    this.quantity,
    this.gatepass,
    this.deliveryCenter,
    this.bags,
    this.weight,
    this.entryLoad,
    this.labour,
    this.client,
    this.qualityClaim,
    this.mandi,
    this.rent,
    this.wsa,
    this.netAmount,
  });

  factory SettlementDatum.fromMap(Map<String, dynamic> json) => SettlementDatum(
        id: json["id"],
        reportType: json["report_type"],
        createdAt: json["created_at"],
        buyerName: json["buyer_name"],
        sellerName: json["seller_name"],
        commodity: json["commodity"],
        rate: json["rate"],
        quantity: json["quantity"]?.toDouble(),
        gatepass: json["gatepass"],
        deliveryCenter: json["delivery_center"],
        bags: json["bags"],
        weight: json["weight"]?.toDouble(),
        entryLoad: json["entry_load"],
        labour: json["labour"],
        client: json["client"],
        qualityClaim: json["quality_claim"],
        mandi: json["mandi"],
        rent: json["rent"],
        wsa: json["wsa"],
        netAmount: json["net_amount"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "report_type": reportType,
        "created_at": createdAt,
        "buyer_name": buyerName,
        "seller_name": sellerName,
        "commodity": commodity,
        "rate": rate,
        "quantity": quantity,
        "gatepass": gatepass,
        "delivery_center": deliveryCenter,
        "bags": bags,
        "weight": weight,
        "entry_load": entryLoad,
        "labour": labour,
        "client": client,
        "quality_claim": qualityClaim,
        "mandi": mandi,
        "rent": rent,
        "wsa": wsa,
        "net_amount": netAmount,
      };
}
