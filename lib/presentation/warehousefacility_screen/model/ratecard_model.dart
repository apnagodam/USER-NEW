class RateCard {
  RateCard({
      RateCardData? data, 
      String? status, 
      String? message,}){
    _data = data;
    _status = status;
    _message = message;
}

  RateCard.fromJson(dynamic json) {
    _data = json['data'] != null ? RateCardData.fromJson(json['data']) : null;
    _status = json['status'];
    _message = json['message'];
  }
  RateCardData? _data;
  String? _status;
  String? _message;
RateCard copyWith({  RateCardData? data,
  String? status,
  String? message,
}) => RateCard(  data: data ?? _data,
  status: status ?? _status,
  message: message ?? _message,
);
  RateCardData? get data => _data;
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

class RateCardData {
  RateCardData({
      int? id, 
      int? stackId, 
      int? stackRequestId, 
      int? userId, 
      int? warehouseId, 
      int? commodityId, 
      String? interestRate, 
      String? processingFee, 
      String? labourCharge, 
      String? warehouseRent, 
      int? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _stackId = stackId;
    _stackRequestId = stackRequestId;
    _userId = userId;
    _warehouseId = warehouseId;
    _commodityId = commodityId;
    _interestRate = interestRate;
    _processingFee = processingFee;
    _labourCharge = labourCharge;
    _warehouseRent = warehouseRent;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  RateCardData.fromJson(dynamic json) {
    _id = json['id'];
    _stackId = json['stack_id'];
    _stackRequestId = json['stack_request_id'];
    _userId = json['user_id'];
    _warehouseId = json['warehouse_id'];
    _commodityId = json['commodity_id'];
    _interestRate = json['interest_rate'];
    _processingFee = json['processing_fee'];
    _labourCharge = json['labour_charge'];
    _warehouseRent = json['warehouse_rent'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _stackId;
  int? _stackRequestId;
  int? _userId;
  int? _warehouseId;
  int? _commodityId;
  String? _interestRate;
  String? _processingFee;
  String? _labourCharge;
  String? _warehouseRent;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
RateCardData copyWith({  int? id,
  int? stackId,
  int? stackRequestId,
  int? userId,
  int? warehouseId,
  int? commodityId,
  String? interestRate,
  String? processingFee,
  String? labourCharge,
  String? warehouseRent,
  int? status,
  String? createdAt,
  String? updatedAt,
}) => RateCardData(  id: id ?? _id,
  stackId: stackId ?? _stackId,
  stackRequestId: stackRequestId ?? _stackRequestId,
  userId: userId ?? _userId,
  warehouseId: warehouseId ?? _warehouseId,
  commodityId: commodityId ?? _commodityId,
  interestRate: interestRate ?? _interestRate,
  processingFee: processingFee ?? _processingFee,
  labourCharge: labourCharge ?? _labourCharge,
  warehouseRent: warehouseRent ?? _warehouseRent,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  int? get stackId => _stackId;
  int? get stackRequestId => _stackRequestId;
  int? get userId => _userId;
  int? get warehouseId => _warehouseId;
  int? get commodityId => _commodityId;
  String? get interestRate => _interestRate;
  String? get processingFee => _processingFee;
  String? get labourCharge => _labourCharge;
  String? get warehouseRent => _warehouseRent;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['stack_id'] = _stackId;
    map['stack_request_id'] = _stackRequestId;
    map['user_id'] = _userId;
    map['warehouse_id'] = _warehouseId;
    map['commodity_id'] = _commodityId;
    map['interest_rate'] = _interestRate;
    map['processing_fee'] = _processingFee;
    map['labour_charge'] = _labourCharge;
    map['warehouse_rent'] = _warehouseRent;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}