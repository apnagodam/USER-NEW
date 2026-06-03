import 'dart:convert';

class WarehouseGetTerminalStack {
  WarehouseGetTerminalStack({
    String? status,
    String? message,
    List<WarehousegetData>? data,
    dynamic stackCommQtlVal,
    String? whRentData,
  }) {
    _status = status;
    _message = message;
    _data = data;
    _stackCommQtlVal = stackCommQtlVal;
    _whRentData = whRentData;
  }

  WarehouseGetTerminalStack.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WarehousegetData.fromJson(v));
      });
    }
    _stackCommQtlVal = json['stack_comm_qtl_val'];
    _whRentData = json['wh_rent_data'];
  }

  String? _status;
  String? _message;
  List<WarehousegetData>? _data;
  dynamic _stackCommQtlVal;
  String? _whRentData;

  WarehouseGetTerminalStack copyWith({
    String? status,
    String? message,
    List<WarehousegetData>? data,
    dynamic stackCommQtlVal,
    String? whRentData,
  }) =>
      WarehouseGetTerminalStack(
        status: status ?? "0",
        message: message ?? "0",
        data: data ?? [],
        stackCommQtlVal: stackCommQtlVal ?? "0",
        whRentData: whRentData ?? "0",
      );

  String? get status => _status;

  String? get message => _message;

  List<WarehousegetData>? get data => _data;

  dynamic get stackCommQtlVal => _stackCommQtlVal;

  String? get whRentData => _whRentData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['stack_comm_qtl_val'] = _stackCommQtlVal;
    map['wh_rent_data'] = _whRentData;
    return map;
  }
}

class WarehousegetData {
  WarehousegetData({
    dynamic id,
    dynamic stackreleaseinvid,
    dynamic stacktotalinv,
    String? stackNumber,
    dynamic stackType,
    dynamic comodityId,
    dynamic terminalId,
    dynamic stackMaxCapacity,
    dynamic stackAccupiedCapacity,
    dynamic stackRemCapacity,
    String? dedicatedBookUserId,
    dynamic bookingStatus,
    dynamic stackLength,
    dynamic stackWidth,
    dynamic status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _stackreleaseinvid = stackreleaseinvid;
    _stacktotalinv = stacktotalinv;
    _stackNumber = stackNumber;
    _stackType = stackType;
    _comodityId = comodityId;
    _terminalId = terminalId;
    _stackMaxCapacity = stackMaxCapacity;
    _stackAccupiedCapacity = stackAccupiedCapacity;
    _stackRemCapacity = stackRemCapacity;
    _dedicatedBookUserId = dedicatedBookUserId;
    _bookingStatus = bookingStatus;
    _stackLength = stackLength;
    _stackWidth = stackWidth;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  WarehousegetData.fromJson(dynamic json) {
    _id = json['id'];
    _stackreleaseinvid = json['stack_release_inv'];
    _stacktotalinv = json['stack_total_inv'];
    _stackNumber = json['stack_number'];
    _stackType = json['stack_type'];
    _comodityId = json['comodity_id'];
    _terminalId = json['terminal_id'];
    _stackMaxCapacity = json['stack_max_capacity'];
    _stackAccupiedCapacity = json['stack_accupied_capacity'];
    _stackRemCapacity = json['stack_rem_capacity'];
    _dedicatedBookUserId = json['dedicated_book_user_id'];
    _bookingStatus = json['booking_status'];
    _stackLength = json['stack_length'];
    _stackWidth = json['stack_width'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  dynamic _id;
  dynamic _stackreleaseinvid;
  dynamic _stacktotalinv;
  String? _stackNumber;
  dynamic _stackType;
  dynamic _comodityId;
  dynamic _terminalId;
  dynamic _stackMaxCapacity;
  dynamic _stackAccupiedCapacity;
  dynamic _stackRemCapacity;
  String? _dedicatedBookUserId;
  dynamic _bookingStatus;
  dynamic _stackLength;
  dynamic _stackWidth;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;

  WarehousegetData copyWith({
    dynamic id,
    dynamic stackreleaseinvid,
    dynamic stacktotalinv,
    String? stackNumber,
    dynamic stackType,
    dynamic comodityId,
    dynamic terminalId,
    dynamic stackMaxCapacity,
    dynamic stackAccupiedCapacity,
    dynamic stackRemCapacity,
    String? dedicatedBookUserId,
    dynamic bookingStatus,
    dynamic stackLength,
    dynamic stackWidth,
    dynamic status,
    String? createdAt,
    String? updatedAt,
  }) =>
      WarehousegetData(
        id: id ?? _id,
        stackreleaseinvid: stackreleaseinvid ?? _stackreleaseinvid,
        stacktotalinv: stacktotalinv ?? _stacktotalinv,
        stackNumber: stackNumber ?? _stackNumber,
        stackType: stackType ?? _stackType,
        comodityId: comodityId ?? _comodityId,
        terminalId: terminalId ?? _terminalId,
        stackMaxCapacity: stackMaxCapacity ?? _stackMaxCapacity,
        stackAccupiedCapacity: stackAccupiedCapacity ?? _stackAccupiedCapacity,
        stackRemCapacity: stackRemCapacity ?? _stackRemCapacity,
        dedicatedBookUserId: dedicatedBookUserId ?? _dedicatedBookUserId,
        bookingStatus: bookingStatus ?? _bookingStatus,
        stackLength: stackLength ?? _stackLength,
        stackWidth: stackWidth ?? _stackWidth,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  dynamic get id => _id;

  dynamic get stackreleaseinvid => _stackreleaseinvid;

  dynamic get stacktotalinv => _stacktotalinv;

  String? get stackNumber => _stackNumber;

  dynamic get stackType => _stackType;

  dynamic get comodityId => _comodityId;

  dynamic get terminalId => _terminalId;

  dynamic get stackMaxCapacity => _stackMaxCapacity;

  dynamic get stackAccupiedCapacity => _stackAccupiedCapacity;

  dynamic get stackRemCapacity => _stackRemCapacity;

  String? get dedicatedBookUserId => _dedicatedBookUserId;

  dynamic get bookingStatus => _bookingStatus;

  dynamic get stackLength => _stackLength;

  dynamic get stackWidth => _stackWidth;

  dynamic get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['stack_release_inv'] = _stackreleaseinvid;
    map['stack_total_inv'] = _stacktotalinv;
    map['stack_number'] = _stackNumber;
    map['stack_type'] = _stackType;
    map['comodity_id'] = _comodityId;
    map['terminal_id'] = _terminalId;
    map['stack_max_capacity'] = _stackMaxCapacity;
    map['stack_accupied_capacity'] = _stackAccupiedCapacity;
    map['stack_rem_capacity'] = _stackRemCapacity;
    map['dedicated_book_user_id'] = _dedicatedBookUserId;
    map['booking_status'] = _bookingStatus;
    map['stack_length'] = _stackLength;
    map['stack_width'] = _stackWidth;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

// To parse this JSON data, do
//
//     final outRequestResponseModel = outRequestResponseModelFromMap(jsonString);

// To parse this JSON data, do
//
//     final outRequestResponseModel = outRequestResponseModelFromMap(jsonString);

OutRequestResponseModel outRequestResponseModelFromMap(String str) =>
    OutRequestResponseModel.fromMap(json.decode(str));

String outRequestResponseModelToMap(OutRequestResponseModel data) =>
    json.encode(data.toMap());

class OutRequestResponseModel {
  String? status;
  String? message;
  List<Datum>? data;
  dynamic wsaCharge;
  dynamic lockinMonth;
  dynamic entryLoad;
  dynamic exitLoad;
  dynamic stackCommQtlVal;
  String? whRentData;

  OutRequestResponseModel({
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

  factory OutRequestResponseModel.fromMap(Map<String, dynamic> json) =>
      OutRequestResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        wsaCharge: json["wsa_charge"]?.toDouble(),
        lockinMonth: json["lockin_month"],
        entryLoad: json["entry_load"],
        exitLoad: json["exit_load"],
        stackCommQtlVal: json["stack_comm_qtl_val"]?.toDouble(),
        whRentData: json["wh_rent_data"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
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
  String? stackNumber;
  String? stackType;
  dynamic comodityId;
  dynamic terminalId;
  dynamic stackMaxCapacity;
  dynamic stackAccupiedCapacity;
  dynamic stackRemCapacity;
  String? dedicatedBookUserId;
  dynamic bookingStatus;
  dynamic stackLength;
  dynamic stackWidth;
  dynamic rentRate;
  dynamic status;
  String? createdAt;
  String? updatedAt;
  dynamic stackTotalInv;
  dynamic stackReleaseInv;
  dynamic stackReleaseBags;

  Datum(
      {this.id,
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
      this.stackReleaseInv,
      this.stackReleaseBags});

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
      stackReleaseInv: json["stack_release_inv"],
      stackReleaseBags: json['stack_release_bags']);

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
        "stack_release_inv": stackReleaseInv,
        "stack_release_bags": stackReleaseBags
      };
}
