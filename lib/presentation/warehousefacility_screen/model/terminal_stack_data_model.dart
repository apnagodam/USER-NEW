// To parse this JSON data, do
//
//     final terminalStackDataModel = terminalStackDataModelFromMap(jsonString);

import 'dart:convert';

TerminalStackDataModel terminalStackDataModelFromMap(String str) => TerminalStackDataModel.fromMap(json.decode(str));

String terminalStackDataModelToMap(TerminalStackDataModel data) => json.encode(data.toMap());

class TerminalStackDataModel {
  dynamic status;
  dynamic message;
  List<Datum>? data;
  dynamic wsaCharge;
  dynamic lockinMonth;
  dynamic entryLoad;
  dynamic exitLoad;
  dynamic stackCommQtlVal;
  dynamic whRentData;

  TerminalStackDataModel({
    this.status,
    this.message,
    this.data,
    this.wsaCharge,
    this.lockinMonth,
    this.entryLoad,
    this.exitLoad,
    this.stackCommQtlVal,
    this.whRentData,
  });

  factory TerminalStackDataModel.fromMap(Map<String, dynamic> json) => TerminalStackDataModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    wsaCharge: json["wsa_charge"],
    lockinMonth: json["lockin_month"],
    entryLoad: json["entry_load"]?.toDouble(),
    exitLoad: json["exit_load"]?.toDouble(),
    stackCommQtlVal: json["stack_comm_qtl_val"]?.toDouble(),
    whRentData: json["wh_rent_data"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "wsa_charge": wsaCharge,
    "lockin_month": lockinMonth,
    "entry_load": entryLoad,
    "exit_load": exitLoad,
    "stack_comm_qtl_val": stackCommQtlVal,
    "wh_rent_data": whRentData,
  };
}

class Datum {
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
  dynamic stackTotalInv;
  dynamic stackTotalBags;
  dynamic stackReleaseInv;
  dynamic stackReleaseBags;

  Datum({
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
    this.stackTotalInv,
    this.stackTotalBags,
    this.stackReleaseInv,
    this.stackReleaseBags,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
    stackTotalInv: json["stack_total_inv"],
    stackTotalBags: json["stack_total_bags"],
    stackReleaseInv: json["stack_release_inv"],
    stackReleaseBags: json["stack_release_bags"],
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
    "stack_total_inv": stackTotalInv,
    "stack_total_bags": stackTotalBags,
    "stack_release_inv": stackReleaseInv,
    "stack_release_bags": stackReleaseBags,
  };
}
