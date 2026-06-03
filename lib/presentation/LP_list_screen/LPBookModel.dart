class LpBookModel {
  LpBookModel({
      Data? data, 
      String? status, 
      String? message,}){
    _data = data;
    _status = status;
    _message = message;
}

  LpBookModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _status = json['status'];
    _message = json['message'];
  }
  Data? _data;
  String? _status;
  String? _message;
LpBookModel copyWith({  Data? data,
  String? status,
  String? message,
}) => LpBookModel(  data: data ?? _data,
  status: status ?? _status,
  message: message ?? _message,
);
  Data? get data => _data;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class Data {
  Data({
      String? tLpUserId, 
      String? lpDistance, 
      String? lpLatitude, 
      String? lpLongitude, 
      String? vehicleType,}){
    _tLpUserId = tLpUserId;
    _lpDistance = lpDistance;
    _lpLatitude = lpLatitude;
    _lpLongitude = lpLongitude;
    _vehicleType = vehicleType;
}

  Data.fromJson(dynamic json) {
    _tLpUserId = json['tLpUserId'];
    _lpDistance = json['LpDistance'];
    _lpLatitude = json['LpLatitude'];
    _lpLongitude = json['LpLongitude'];
    _vehicleType = json['VehicleType'];
  }
  String? _tLpUserId;
  String? _lpDistance;
  String? _lpLatitude;
  String? _lpLongitude;
  String? _vehicleType;
Data copyWith({  String? tLpUserId,
  String? lpDistance,
  String? lpLatitude,
  String? lpLongitude,
  String? vehicleType,
}) => Data(  tLpUserId: tLpUserId ?? _tLpUserId,
  lpDistance: lpDistance ?? _lpDistance,
  lpLatitude: lpLatitude ?? _lpLatitude,
  lpLongitude: lpLongitude ?? _lpLongitude,
  vehicleType: vehicleType ?? _vehicleType,
);
  String? get tLpUserId => _tLpUserId;
  String? get lpDistance => _lpDistance;
  String? get lpLatitude => _lpLatitude;
  String? get lpLongitude => _lpLongitude;
  String? get vehicleType => _vehicleType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tLpUserId'] = _tLpUserId;
    map['LpDistance'] = _lpDistance;
    map['LpLatitude'] = _lpLatitude;
    map['LpLongitude'] = _lpLongitude;
    map['VehicleType'] = _vehicleType;
    return map;
  }

}