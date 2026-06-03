// To parse this JSON data, do
//
//     final purchaseOrderTypeModel = purchaseOrderTypeModelFromJson(jsonString);

import 'dart:convert';

PurchaseOrderTypeModel purchaseOrderTypeModelFromJson(String str) => PurchaseOrderTypeModel.fromJson(json.decode(str));

String purchaseOrderTypeModelToJson(PurchaseOrderTypeModel data) => json.encode(data.toJson());

class PurchaseOrderTypeModel {
    List<PurchaseOrderDatum>? data;
    String? status;
    String? message;

    PurchaseOrderTypeModel({
        this.data,
        this.status,
        this.message,
    });

    factory PurchaseOrderTypeModel.fromJson(Map<String, dynamic> json) => PurchaseOrderTypeModel(
        data: json["data"] == null ? [] : List<PurchaseOrderDatum>.from(json["data"]!.map((x) => PurchaseOrderDatum.fromJson(x))),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
    };
}

class PurchaseOrderDatum {
    int? id;
    String? poIds;

    PurchaseOrderDatum({
        this.id,
        this.poIds,
    });

    factory PurchaseOrderDatum.fromJson(Map<String, dynamic> json) => PurchaseOrderDatum(
        id: json["id"],
        poIds: json["po_ids"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "po_ids": poIds,
    };
}
