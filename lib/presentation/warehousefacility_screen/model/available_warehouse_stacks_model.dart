// To parse this JSON data, do
//
//     final availableWarehouseStacksModel = availableWarehouseStacksModelFromMap(jsonString);

import 'dart:convert';

AvailableWarehouseStacksModel availableWarehouseStacksModelFromMap(
        String str) =>
    AvailableWarehouseStacksModel.fromMap(json.decode(str));

String availableWarehouseStacksModelToMap(AvailableWarehouseStacksModel data) =>
    json.encode(data.toMap());

class AvailableWarehouseStacksModel {
  dynamic status;
  dynamic message;
  List<AvailableStackDatum>? data;
  dynamic wsaCharge;
  dynamic entryLoad;
  dynamic exitLoad;
  dynamic stackCommQtlVal;
  dynamic whRentData;
  dynamic lockIn;
  dynamic labourCharge;

  AvailableWarehouseStacksModel(
      {this.status,
      this.message,
      this.data,
      this.wsaCharge,
      this.entryLoad,
      this.exitLoad,
      this.stackCommQtlVal,
      this.whRentData,
      this.lockIn,
      this.labourCharge});

  factory AvailableWarehouseStacksModel.fromMap(Map<String, dynamic> json) =>
      AvailableWarehouseStacksModel(
          status: json["status"],
          message: json["message"],
          data: json["data"] == null
              ? []
              : List<AvailableStackDatum>.from(json["data"]!.map((x) => AvailableStackDatum.fromMap(x))),
          wsaCharge: json["wsa_charge"]?.toDouble(),
          entryLoad: json["entry_load"],
          exitLoad: json["exit_load"],
          stackCommQtlVal: json["stack_comm_qtl_val"]?.toDouble(),
          whRentData: json["wh_rent_data"] ?? "0",
          labourCharge: json['labour_charge'],
          lockIn: json['lockin_month'] ?? "0");

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "wsa_charge": wsaCharge,
        "entry_load": entryLoad,
        "exit_load": exitLoad,
        "stack_comm_qtl_val": stackCommQtlVal,
        "wh_rent_data": whRentData,
        "labour_charge": labourCharge,
      };
}

class AvailableStackDatum {
  dynamic id;
  dynamic stackNumber;
  dynamic stackType;
  dynamic comodityId;
  dynamic terminalId;
  dynamic stackMaxCapacity;
  dynamic stackAccupiedCapacity;
  dynamic stackRemCapacity;
  dynamic dedicatedBookUserId;
  dynamic bookingStatus;
  dynamic stackLength;
  dynamic stackWidth;
  dynamic rentRate;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  AvailableStackDatum({
    this.id,
    this.stackNumber,
    this.stackType,
    this.comodityId,
    this.terminalId,
    this.stackMaxCapacity,
    this.stackAccupiedCapacity,
    this.stackRemCapacity,
    this.dedicatedBookUserId,
    this.bookingStatus,
    this.stackLength,
    this.stackWidth,
    this.rentRate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AvailableStackDatum.fromMap(Map<String, dynamic> json) => AvailableStackDatum(
        id: json["id"],
        stackNumber: json["stack_number"],
        stackType: json["stack_type"],
        comodityId: json["comodity_id"],
        terminalId: json["terminal_id"],
        stackMaxCapacity: json["stack_max_capacity"],
        stackAccupiedCapacity: json["stack_accupied_capacity"],
        stackRemCapacity: json["stack_rem_capacity"],
        dedicatedBookUserId: json["dedicated_book_user_id"],
        bookingStatus: json["booking_status"],
        stackLength: json["stack_length"],
        stackWidth: json["stack_width"],
        rentRate: json["rent_rate"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "stack_number": stackNumber,
        "stack_type": stackType,
        "comodity_id": comodityId,
        "terminal_id": terminalId,
        "stack_max_capacity": stackMaxCapacity,
        "stack_accupied_capacity": stackAccupiedCapacity,
        "stack_rem_capacity": stackRemCapacity,
        "dedicated_book_user_id": dedicatedBookUserId,
        "booking_status": bookingStatus,
        "stack_length": stackLength,
        "stack_width": stackWidth,
        "rent_rate": rentRate,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
