// To parse this JSON data, do
//
//     final warehouseListModel = warehouseListModelFromMap(jsonString);

import 'dart:convert';

WarehouseListModel warehouseListModelFromMap(String str) =>
    WarehouseListModel.fromMap(json.decode(str));

String warehouseListModelToMap(WarehouseListModel data) =>
    json.encode(data.toMap());

class WarehouseListModel {
  List<Datum>? data;
  dynamic status;
  dynamic message;

  WarehouseListModel({
    this.data,
    this.status,
    this.message,
  });

  factory WarehouseListModel.fromMap(Map<String, dynamic> json) =>
      WarehouseListModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
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

class Datum {
  dynamic id;
  dynamic warehouseName;
  dynamic warehouseAddress;
  dynamic labourRate;
  dynamic entryLoad;
  dynamic exitLoad;
  dynamic wsa;
  dynamic rent;
  dynamic agCommission;
  dynamic emptySpace;
  dynamic lat;
  dynamic long;
  dynamic content;
  dynamic buyCommission;   
  dynamic sellCommission;  

  Datum({
    this.id,
    this.warehouseName,
    this.warehouseAddress,
    this.labourRate,
    this.entryLoad,
    this.exitLoad,
    this.wsa,
    this.rent,
    this.agCommission,
    this.emptySpace,
    this.lat,
    this.long,
    this.content,
    this.buyCommission,   
    this.sellCommission, 
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    warehouseName: json["warehouse_name"],
    warehouseAddress: json["warehouse_address"],
    labourRate: json["labour_rate"],
    entryLoad: json["entry_load"],
    exitLoad: json["exit_load"],
    wsa: json["wsa"],
    rent: json["rent"],
    agCommission: json['ag_comm'],
    emptySpace: json['empty_space'],
    lat: json['lat'],
    long: json['long'],
    content: json['content'],
    buyCommission: json['buyCommission'],   // ADD THIS
    sellCommission: json['sellCommission'], // ADD THIS
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "warehouse_name": warehouseName,
    "warehouse_address": warehouseAddress,
    "labour_rate": labourRate,
    "entry_load": entryLoad,
    "exit_load": exitLoad,
    "wsa": wsa,
    "rent": rent,
    "ag_comm": agCommission,
    "empty_space": emptySpace,
    "lat": lat,
    "long": long,
    "content": content,
    "buyCommission": buyCommission,   // ADD THIS
    "sellCommission": sellCommission, // ADD THIS
  };
}
