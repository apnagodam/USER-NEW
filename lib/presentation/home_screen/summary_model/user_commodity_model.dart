class UserCommodityModel {
  UserCommodityModel({
      dynamic status, 
      String? message, 
      List<CommodityDataL>? data, 
      List<WareHousedata>? wareHousedata,}){
    _status = status;
    _message = message;
    _data = data;
    _wareHousedata = wareHousedata;
}

  UserCommodityModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CommodityDataL.fromJson(v));
      });
    }
    if (json['ware_housedata'] != null) {
      _wareHousedata = [];
      json['ware_housedata'].forEach((v) {
        _wareHousedata?.add(WareHousedata.fromJson(v));
      });
    }
  }
  dynamic _status;
  String? _message;
  List<CommodityDataL>? _data;
  List<WareHousedata>? _wareHousedata;
UserCommodityModel copyWith({  dynamic status,
  String? message,
  List<CommodityDataL>? data,
  List<WareHousedata>? wareHousedata,
}) => UserCommodityModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
  wareHousedata: wareHousedata ?? _wareHousedata,
);
  dynamic get status => _status;
  String? get message => _message;
  List<CommodityDataL>? get data => _data;
  List<WareHousedata>? get wareHousedata => _wareHousedata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_wareHousedata != null) {
      map['ware_housedata'] = _wareHousedata?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class WareHousedata {
  WareHousedata({
      dynamic id, 
      String? warehouseName,}){
    _id = id;
    _warehouseName = warehouseName;
}

  WareHousedata.fromJson(dynamic json) {
    _id = json['id'];
    _warehouseName = json['warehouse_name'];
  }
  dynamic _id;
  String? _warehouseName;
WareHousedata copyWith({  dynamic id,
  String? warehouseName,
}) => WareHousedata(  id: id ?? _id,
  warehouseName: warehouseName ?? _warehouseName,
);
  dynamic get id => _id;
  String? get warehouseName => _warehouseName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['warehouse_name'] = _warehouseName;
    return map;
  }

}

class CommodityDataL {
  CommodityDataL({
      dynamic id, 
      String? commodityName,}){
    _id = id;
    _commodityName = commodityName;
}

  CommodityDataL.fromJson(dynamic json) {
    _id = json['id'];
    _commodityName = json['commodity_name'];
  }
  dynamic _id;
  String? _commodityName;
CommodityDataL copyWith({  dynamic id,
  String? commodityName,
}) => CommodityDataL(  id: id ?? _id,
  commodityName: commodityName ?? _commodityName,
);
  dynamic get id => _id;
  String? get commodityName => _commodityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['commodity_name'] = _commodityName;
    return map;
  }

}