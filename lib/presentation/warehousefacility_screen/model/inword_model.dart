class InwordModel {
  InwordModel({
      List<TerminalData>? terminalData, 
      List<CommodityData>? commodityData, 
      List<StackNumber>? stackNumber, 
      dynamic status, 
      String? message,}){
    _terminalData = terminalData;
    _commodityData = commodityData;
    _stackNumber = stackNumber;
    _status = status;
    _message = message;
}

  InwordModel.fromJson(dynamic json) {
    if (json['terminal_data'] != null) {
      _terminalData = [];
      json['terminal_data'].forEach((v) {
        _terminalData?.add(TerminalData.fromJson(v));
      });
    }
    if (json['commodity_data'] != null) {
      _commodityData = [];
      json['commodity_data'].forEach((v) {
        _commodityData?.add(CommodityData.fromJson(v));
      });
    }
    if (json['stack_number'] != null) {
      _stackNumber = [];
      json['stack_number'].forEach((v) {
        _stackNumber?.add(StackNumber.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<TerminalData>? _terminalData;
  List<CommodityData>? _commodityData;
  List<StackNumber>? _stackNumber;
  dynamic _status;
  String? _message;
InwordModel copyWith({  List<TerminalData>? terminalData,
  List<CommodityData>? commodityData,
  List<StackNumber>? stackNumber,
  dynamic status,
  String? message,
}) => InwordModel(  terminalData: terminalData ?? _terminalData,
  commodityData: commodityData ?? _commodityData,
  stackNumber: stackNumber ?? _stackNumber,
  status: status ?? _status,
  message: message ?? _message,
);
  List<TerminalData>? get terminalData => _terminalData;
  List<CommodityData>? get commodityData => _commodityData;
  List<StackNumber>? get stackNumber => _stackNumber;
  dynamic get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_terminalData != null) {
      map['terminal_data'] = _terminalData?.map((v) => v.toJson()).toList();
    }
    if (_commodityData != null) {
      map['commodity_data'] = _commodityData?.map((v) => v.toJson()).toList();
    }
    if (_stackNumber != null) {
      map['stack_number'] = _stackNumber?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class StackNumber {
  StackNumber({
      String? stackNumber, 
      dynamic stackRequestId, 
      String? stackType,}){
    _stackNumber = stackNumber;
    _stackRequestId = stackRequestId;
    _stackType = stackType;
}

  StackNumber.fromJson(dynamic json) {
    _stackNumber = json['stack_number'];
    _stackRequestId = json['stack_request_id'];
    _stackType = json['stack_type'];
  }
  String? _stackNumber;
  dynamic _stackRequestId;
  String? _stackType;
StackNumber copyWith({  String? stackNumber,
  dynamic stackRequestId,
  String? stackType,
}) => StackNumber(  stackNumber: stackNumber ?? _stackNumber,
  stackRequestId: stackRequestId ?? _stackRequestId,
  stackType: stackType ?? _stackType,
);
  String? get stackNumber => _stackNumber;
  dynamic get stackRequestId => _stackRequestId;
  String? get stackType => _stackType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stack_number'] = _stackNumber;
    map['stack_request_id'] = _stackRequestId;
    map['stack_type'] = _stackType;
    return map;
  }

}

class CommodityData {
  CommodityData({
      String? commodityName, 
      dynamic commodityId, 
      String? commodityTax,}){
    _commodityName = commodityName;
    _commodityId = commodityId;
    _commodityTax = commodityTax;
}

  CommodityData.fromJson(dynamic json) {
    _commodityName = json['commodity_name'];
    _commodityId = json['commodity_id'];
    _commodityTax = json['commodity_tax'];
  }
  String? _commodityName;
  dynamic _commodityId;
  String? _commodityTax;
CommodityData copyWith({  String? commodityName,
  dynamic commodityId,
  String? commodityTax,
}) => CommodityData(  commodityName: commodityName ?? _commodityName,
  commodityId: commodityId ?? _commodityId,
  commodityTax: commodityTax ?? _commodityTax,
);
  String? get commodityName => _commodityName;
  dynamic get commodityId => _commodityId;
  String? get commodityTax => _commodityTax;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commodity_name'] = _commodityName;
    map['commodity_id'] = _commodityId;
    map['commodity_tax'] = _commodityTax;
    return map;
  }

}

class TerminalData {
  TerminalData({
      String? terminalName, 
      dynamic terminalId,}){
    _terminalName = terminalName;
    _terminalId = terminalId;
}

  TerminalData.fromJson(dynamic json) {
    _terminalName = json['terminal_name'];
    _terminalId = json['terminal_id'];
  }
  String? _terminalName;
  dynamic _terminalId;
TerminalData copyWith({  String? terminalName,
  dynamic terminalId,
}) => TerminalData(  terminalName: terminalName ?? _terminalName,
  terminalId: terminalId ?? _terminalId,
);
  String? get terminalName => _terminalName;
  dynamic get terminalId => _terminalId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['terminal_name'] = _terminalName;
    map['terminal_id'] = _terminalId;
    return map;
  }

}