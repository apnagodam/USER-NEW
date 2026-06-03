class BnplSummaryListModel {
  BnplSummaryListModel({
      List<BnplSummaryData>? data,
      dynamic status, 
      String? message,}){
    _data = data;
    _status = status;
    _message = message;
}

  BnplSummaryListModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BnplSummaryData.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<BnplSummaryData>? _data;
  dynamic _status;
  String? _message;

  List<BnplSummaryData>? get data => _data;
  dynamic get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class BnplSummaryData {
  BnplSummaryData({
      dynamic id, 
      dynamic userId, 
      dynamic bnplRequestId, 
      String? uniqueId, 
      dynamic amount, 
      dynamic remainingAmount, 
      dynamic interestRate, 
      String? remark, 
      dynamic status, 
      String? createdAt, 
      String? updatedAt, 
      dynamic interestCount,}){
    _id = id;
    _userId = userId;
    _bnplRequestId = bnplRequestId;
    _uniqueId = uniqueId;
    _amount = amount;
    _remainingAmount = remainingAmount;
    _interestRate = interestRate;
    _remark = remark;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _interestCount = interestCount;
}

  BnplSummaryData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _bnplRequestId = json['bnpl_request_id'];
    _uniqueId = json['unique_id'];
    _amount = json['amount'];
    _remainingAmount = json['remaining_amount'];
    _interestRate = json['interest_rate'];
    _remark = json['remark'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _interestCount = json['interest_count'];
  }
  dynamic _id;
  dynamic _userId;
  dynamic _bnplRequestId;
  String? _uniqueId;
  dynamic _amount;
  dynamic _remainingAmount;
  dynamic _interestRate;
  String? _remark;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _interestCount;

  dynamic get id => _id;
  dynamic get userId => _userId;
  dynamic get bnplRequestId => _bnplRequestId;
  String? get uniqueId => _uniqueId;
  dynamic get amount => _amount;
  dynamic get remainingAmount => _remainingAmount;
  dynamic get interestRate => _interestRate;
  String? get remark => _remark;
  dynamic get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get interestCount => _interestCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['bnpl_request_id'] = _bnplRequestId;
    map['unique_id'] = _uniqueId;
    map['amount'] = _amount;
    map['remaining_amount'] = _remainingAmount;
    map['interest_rate'] = _interestRate;
    map['remark'] = _remark;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['interest_count'] = _interestCount;
    return map;
  }

}