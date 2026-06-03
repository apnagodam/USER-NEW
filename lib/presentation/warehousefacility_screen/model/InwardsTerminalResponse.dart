// To parse this JSON data, do
//
//     final inwardsTerminalResponse = inwardsTerminalResponseFromMap(jsonString);

import 'dart:convert';

InwardsTerminalResponse inwardsTerminalResponseFromMap(String str) => InwardsTerminalResponse.fromMap(json.decode(str));

String inwardsTerminalResponseToMap(InwardsTerminalResponse data) => json.encode(data.toMap());

class InwardsTerminalResponse {
  List<TerminalDatum>? terminalData;
  List<CommodityDatum>? commodityData;
  List<StackNumber>? stackNumber;
  int? status;
  String? message;

  InwardsTerminalResponse({
    this.terminalData,
    this.commodityData,
    this.stackNumber,
    this.status,
    this.message,
  });

  factory InwardsTerminalResponse.fromMap(Map<String, dynamic> json) => InwardsTerminalResponse(
    terminalData: json["terminal_data"] == null ? [] : List<TerminalDatum>.from(json["terminal_data"]!.map((x) => TerminalDatum.fromMap(x))),
    commodityData: json["commodity_data"] == null ? [] : List<CommodityDatum>.from(json["commodity_data"]!.map((x) => CommodityDatum.fromMap(x))),
    stackNumber: json["stack_number"] == null ? [] : List<StackNumber>.from(json["stack_number"]!.map((x) => StackNumber.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "terminal_data": terminalData == null ? [] : List<dynamic>.from(terminalData!.map((x) => x.toMap())),
    "commodity_data": commodityData == null ? [] : List<dynamic>.from(commodityData!.map((x) => x.toMap())),
    "stack_number": stackNumber == null ? [] : List<dynamic>.from(stackNumber!.map((x) => x.toMap())),
    "status": status,
    "message": message,
  };
}

class CommodityDatum {
  String? commodityName;
  int? commodityId;
  String? commodityTax;

  CommodityDatum({
    this.commodityName,
    this.commodityId,
    this.commodityTax,
  });

  factory CommodityDatum.fromMap(Map<String, dynamic> json) => CommodityDatum(
    commodityName: json["commodity_name"],
    commodityId: json["commodity_id"],
    commodityTax: json["commodity_tax"],
  );

  Map<String, dynamic> toMap() => {
    "commodity_name": commodityName,
    "commodity_id": commodityId,
    "commodity_tax": commodityTax,
  };
}

class StackNumber {
  String? stackNumber;
  int? stackRequestId;
  String? stackType;

  StackNumber({
    this.stackNumber,
    this.stackRequestId,
    this.stackType,
  });

  factory StackNumber.fromMap(Map<String, dynamic> json) => StackNumber(
    stackNumber: json["stack_number"],
    stackRequestId: json["stack_request_id"],
    stackType: json["stack_type"],
  );

  Map<String, dynamic> toMap() => {
    "stack_number": stackNumber,
    "stack_request_id": stackRequestId,
    "stack_type": stackType,
  };
}

class TerminalDatum {
  String? terminalName;
  int? terminalId;

  TerminalDatum({
    this.terminalName,
    this.terminalId,
  });

  factory TerminalDatum.fromMap(Map<String, dynamic> json) => TerminalDatum(
    terminalName: json["terminal_name"],
    terminalId: json["terminal_id"],
  );

  Map<String, dynamic> toMap() => {
    "terminal_name": terminalName,
    "terminal_id": terminalId,
  };
}
