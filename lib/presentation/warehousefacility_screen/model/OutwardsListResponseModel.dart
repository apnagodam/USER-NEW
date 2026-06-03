// To parse this JSON data, do
//
//     final outwardsListResponseModel = outwardsListResponseModelFromMap(jsonString);

import 'dart:convert';

OutwardsListResponseModel outwardsListResponseModelFromMap(String str) => OutwardsListResponseModel.fromMap(json.decode(str));

String outwardsListResponseModelToMap(OutwardsListResponseModel data) => json.encode(data.toMap());

class OutwardsListResponseModel {
  List<Datum>? data;
  dynamic status;
  dynamic message;

  OutwardsListResponseModel({
    this.data,
    this.status,
    this.message,
  });

  factory OutwardsListResponseModel.fromMap(Map<String, dynamic> json) => OutwardsListResponseModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "status": status,
    "message": message,
  };
}

class Datum {
  dynamic id;
  dynamic requestDate;
  dynamic vehicleNo;
  dynamic driverNumber;
  dynamic stackNumber;
  dynamic weight;
  dynamic commodityName;
  dynamic warehouseName;
  dynamic status;

  Datum({
    this.id,
    this.requestDate,
    this.vehicleNo,
    this.driverNumber,
    this.stackNumber,
    this.weight,
    this.commodityName,
    this.warehouseName,
    this.status,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    requestDate: json["request_date"],
    vehicleNo: json["vehicle_no"],
    driverNumber: json["driver_number"],
    stackNumber: json["stack_number"],
    weight: json["weight"],
    commodityName: json["commodity_name"],
    warehouseName: json["warehouse_name"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "request_date": requestDate,
    "vehicle_no": vehicleNo,
    "driver_number": driverNumber,
    "stack_number": stackNumber,
    "weight": weight,
    "commodity_name": commodityName,
    "warehouse_name": warehouseName,
    "status": status,
  };
}
