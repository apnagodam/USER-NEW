// To parse this JSON data, do
//
//     final orderInventoryModel = orderInventoryModelFromMap(jsondynamic);

import 'dart:convert';

OrderInventoryModel orderInventoryModelFromMap(dynamic str) =>
    OrderInventoryModel.fromMap(json.decode(str));

dynamic orderInventoryModelToMap(OrderInventoryModel data) =>
    json.encode(data.toMap());

class OrderInventoryModel {
  dynamic status;
  List<Datum>? data;
  dynamic message;

  OrderInventoryModel({
    this.status,
    this.data,
    this.message,
  });

  factory OrderInventoryModel.fromMap(Map<dynamic, dynamic> json) =>
      OrderInventoryModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        message: json["Message"],
      );

  Map<dynamic, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "Message": message,
      };
}

class Datum {
  dynamic id;
  dynamic gatePass;
  dynamic quantity;
  dynamic bag;
  dynamic warehouseName;
  dynamic commodityName;
  dynamic stackNo;

  Datum({
    this.id,
    this.gatePass,
    this.quantity,
    this.bag,
    this.warehouseName,
    this.commodityName,
    this.stackNo,
  });

  factory Datum.fromMap(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        gatePass: json["gate_pass"],
        quantity: json["quantity"],
        bag: json["bag"],
        warehouseName: json["warehouse_name"],
        commodityName: json["commodity_name"],
        stackNo: json["stack_no"],
      );

  Map<dynamic, dynamic> toMap() => {
        "id": id,
        "gate_pass": gatePass,
        "quantity": quantity,
        "bag": bag,
        "warehouse_name": warehouseName,
        "commodity_name": commodityName,
        "stack_no": stackNo,
      };
}
