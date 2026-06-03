class BnplRequestListModel {
  BnplRequestListModel({
      List<BnplListData>? data,
      dynamic bnplPower, 
      dynamic status, 
      String? message,}){
    _data = data;
    _bnplPower = bnplPower;
    _status = status;
    _message = message;
}

  BnplRequestListModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BnplListData.fromJson(v));
      });
    }
    _bnplPower = json['bnpl_power'];
    _status = json['status'];
    _message = json['message'];
  }
  List<BnplListData>? _data;
  dynamic _bnplPower;
  dynamic _status;
  String? _message;

  List<BnplListData>? get data => _data;
  dynamic get bnplPower => _bnplPower;
  dynamic get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['bnpl_power'] = _bnplPower;
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class BnplListData {
  BnplListData({
      dynamic id, 
      dynamic userId, 
      String? uniqueId, 
      dynamic requestedAmount, 
      dynamic approvedAmount, 
      dynamic usedAmount, 
      dynamic interestRate, 
      dynamic approvedBy, 
      String? approvedDate, 
      dynamic verifiedBy, 
      String? verifiedDate, 
      dynamic remark, 
      dynamic status, 
      dynamic createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _userId = userId;
    _uniqueId = uniqueId;
    _requestedAmount = requestedAmount;
    _approvedAmount = approvedAmount;
    _usedAmount = usedAmount;
    _interestRate = interestRate;
    _approvedBy = approvedBy;
    _approvedDate = approvedDate;
    _verifiedBy = verifiedBy;
    _verifiedDate = verifiedDate;
    _remark = remark;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  BnplListData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _uniqueId = json['unique_id'];
    _requestedAmount = json['requested_amount'];
    _approvedAmount = json['approved_amount'];
    _usedAmount = json['used_amount'];
    _interestRate = json['interest_rate'];
    _approvedBy = json['approved_by'];
    _approvedDate = json['approved_date'];
    _verifiedBy = json['verified_by'];
    _verifiedDate = json['verified_date'];
    _remark = json['remark'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  dynamic _id;
  dynamic _userId;
  String? _uniqueId;
  dynamic _requestedAmount;
  dynamic _approvedAmount;
  dynamic _usedAmount;
  dynamic _interestRate;
  dynamic _approvedBy;
  String? _approvedDate;
  dynamic _verifiedBy;
  String? _verifiedDate;
  dynamic _remark;
  dynamic _status;
  dynamic _createdAt;
  dynamic _updatedAt;

  dynamic get id => _id;
  dynamic get userId => _userId;
  String? get uniqueId => _uniqueId;
  dynamic get requestedAmount => _requestedAmount;
  dynamic get approvedAmount => _approvedAmount;
  dynamic get usedAmount => _usedAmount;
  dynamic get interestRate => _interestRate;
  dynamic get approvedBy => _approvedBy;
  String? get approvedDate => _approvedDate;
  dynamic get verifiedBy => _verifiedBy;
  String? get verifiedDate => _verifiedDate;
  dynamic get remark => _remark;
  dynamic get status => _status;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['unique_id'] = _uniqueId;
    map['requested_amount'] = _requestedAmount;
    map['approved_amount'] = _approvedAmount;
    map['used_amount'] = _usedAmount;
    map['interest_rate'] = _interestRate;
    map['approved_by'] = _approvedBy;
    map['approved_date'] = _approvedDate;
    map['verified_by'] = _verifiedBy;
    map['verified_date'] = _verifiedDate;
    map['remark'] = _remark;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}