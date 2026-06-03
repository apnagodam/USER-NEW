// To parse this JSON data, do
//
//     final purchaseOrdersListingModel = purchaseOrdersListingModelFromJson(jsonString);

import 'dart:convert';

PurchaseOrdersListingModel purchaseOrdersListingModelFromJson(String str) =>
    PurchaseOrdersListingModel.fromJson(json.decode(str));

String purchaseOrdersListingModelToJson(PurchaseOrdersListingModel data) =>
    json.encode(data.toJson());

class PurchaseOrdersListingModel {
  dynamic status;
  dynamic message;
  List<Datum>? data;

  PurchaseOrdersListingModel({
    this.status,
    this.message,
    this.data,
  });

  factory PurchaseOrdersListingModel.fromJson(Map<String, dynamic> json) =>
      PurchaseOrdersListingModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic id;
  dynamic uniqueId;
  dynamic commodityName;
  dynamic weight;
  dynamic deliverdQty;
  dynamic avaiQty;
  dynamic holdQty;
  dynamic pendingQty;
  dynamic rate;
  dynamic date;
  dynamic expiryDate;
  dynamic poNumber;
  dynamic poImage;
  dynamic broker;
  dynamic warehouseName;
  dynamic buyerName;
  dynamic buyerGstnumber;
  dynamic buyerPhone;
  dynamic buyerAddress;
  dynamic deliveryPincode;
  dynamic qualityCondition;
  dynamic remark;
  dynamic imageUrl;
  dynamic activeStatus;
  dynamic status;

  Datum({
    this.id,
    this.uniqueId,
    this.commodityName,
    this.weight,
    this.deliverdQty,
    this.avaiQty,
    this.holdQty,
    this.pendingQty,
    this.rate,
    this.date,
    this.expiryDate,
    this.poNumber,
    this.poImage,
    this.broker,
    this.warehouseName,
    this.buyerName,
    this.buyerGstnumber,
    this.buyerPhone,
    this.buyerAddress,
    this.deliveryPincode,
    this.qualityCondition,
    this.remark,
    this.imageUrl,
    this.activeStatus,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        uniqueId: json["unique_id"],
        commodityName: json["commodity_name"],
        weight: json["weight"],
        deliverdQty: json["deliverd_qty"],
        avaiQty: json["avai_qty"],
        holdQty: json["hold_qty"],
        pendingQty: json["pending_qty"],
        rate: json["rate"],
        date: json["date"],
        expiryDate: json["expiry_date"],
        poNumber: json["po_number"],
        poImage: json["po_image"],
        broker: json["broker"],
        warehouseName: json["warehouse_name"],
        buyerName: json["buyer_name"],
        buyerGstnumber: json["buyer_gstnumber"],
        buyerPhone: json["buyer_phone"],
        buyerAddress: json["buyer_address"],
        deliveryPincode: json["delivery_pincode"],
        qualityCondition: json["quality_condition"],
        remark: json["remark"],
        imageUrl: json["image_url"],
        activeStatus: json['active_status'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "commodity_name": commodityName,
        "weight": weight,
        "deliverd_qty": deliverdQty,
        "avai_qty": avaiQty,
        "hold_qty": holdQty,
        "pending_qty": pendingQty,
        "rate": rate,
        "date": date,
        "expiry_date": expiryDate,
        "po_number": poNumber,
        "po_image": poImage,
        "broker": broker,
        "warehouse_name": warehouseName,
        "buyer_name": buyerName,
        "buyer_gstnumber": buyerGstnumber,
        "buyer_phone": buyerPhone,
        "buyer_address": buyerAddress,
        "delivery_pincode": deliveryPincode,
        "quality_condition": qualityCondition,
        "remark": remark,
        "image_url": imageUrl,
        "active_status": activeStatus,
        "status": status
      };
}
