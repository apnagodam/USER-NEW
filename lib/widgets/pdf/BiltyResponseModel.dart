// To parse this JSON data, do
//
//     final biltyResponseData = biltyResponseDataFromMap(jsonString);

import 'dart:convert';

BiltyResponseData biltyResponseDataFromMap(String str) =>
    BiltyResponseData.fromMap(json.decode(str));

String biltyResponseDataToMap(BiltyResponseData data) =>
    json.encode(data.toMap());

class BiltyResponseData {
  String? status;
  String? message;
  Data? data;

  BiltyResponseData({
    this.status,
    this.message,
    this.data,
  });

  factory BiltyResponseData.fromMap(Map<String, dynamic> json) =>
      BiltyResponseData(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  String? transporterName;
  String? transporterPhone;
  String? transporterAddress;
  String? fromAddress;
  String? warehouseAddress;
  String? toAddress;
  dynamic biltiyNumber;
  String? fromUser;
  String? toUser;
  String? truckNumber;
  String? driverName;
  String? weight;
  dynamic bags;
  dynamic rate;
  String? commodityName;
  dynamic totalRate;
  dynamic advance;
  dynamic baki;
  String? bilty;
  dynamic goodsPrice;
  String? biltyDate;

  Data({
    this.transporterName,
    this.transporterPhone,
    this.transporterAddress,
    this.fromAddress,
    this.warehouseAddress,
    this.toAddress,
    this.biltiyNumber,
    this.fromUser,
    this.toUser,
    this.truckNumber,
    this.driverName,
    this.weight,
    this.bags,
    this.rate,
    this.commodityName,
    this.totalRate,
    this.advance,
    this.baki,
    this.bilty,
    this.goodsPrice,
    this.biltyDate,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
      transporterName: json["transporter_name"],
      transporterPhone: json["transporter_phone"],
      transporterAddress: json["transporter_address"],
      fromAddress: json["from_address"],
      warehouseAddress: json["warehouse_address"],
      toAddress: json["to_address"],
      biltiyNumber: json["biltiy_number"],
      fromUser: json["from_user"],
      toUser: json["to_user"],
      truckNumber: json["truck_number"],
      driverName: json["driver_name"],
      weight: json["weight"],
      bags: json["bags"],
      rate: json["rate"],
      commodityName: json["commodity_name"],
      totalRate: json["total_rate"],
      advance: json["advance"],
      baki: json["baki"],
      bilty: json["bilty"],
      goodsPrice: json["goods_price"],
      biltyDate: json['bilty_date'] ?? "");

  Map<String, dynamic> toMap() => {
        "transporter_name": transporterName,
        "transporter_phone": transporterPhone,
        "transporter_address": transporterAddress,
        "from_address": fromAddress,
        "warehouse_address": warehouseAddress,
        "to_address": toAddress,
        "biltiy_number": biltiyNumber,
        "from_user": fromUser,
        "to_user": toUser,
        "truck_number": truckNumber,
        "driver_name": driverName,
        "weight": weight,
        "bags": bags,
        "rate": rate,
        "commodity_name": commodityName,
        "total_rate": totalRate,
        "advance": advance,
        "baki": baki,
        "bilty": bilty,
        "goods_price": goodsPrice,
        'bilty_date': biltyDate
      };
}
