class WithdrawalModel {
  WithdrawalModel({
      List<Withdrawdata>? data, 
      int? status, 
      String? message,}){
    _data = data;
    _status = status;
    _message = message;
}

  WithdrawalModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Withdrawdata.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<Withdrawdata>? _data;
  int? _status;
  String? _message;
WithdrawalModel copyWith({  List<Withdrawdata>? data,
  int? status,
  String? message,
}) => WithdrawalModel(  data: data ?? _data,
  status: status ?? _status,
  message: message ?? _message,
);
  List<Withdrawdata>? get data => _data;
  int? get status => _status;
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

class Withdrawdata {
  Withdrawdata({
      int? id, 
      String? wrr, 
      int? userId,
      dynamic requestedAmount,
      dynamic approvedAmount, 
      dynamic paymentBy, 
      dynamic referenceNo, 
      dynamic file, 
      String? remark, 
      int? approvedBy, 
      dynamic verifiedBy, 
      String? poutId, 
      String? fundAccountId, 
      String? contactId, 
      int? status, 
      dynamic approvedDate, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _wrr = wrr;
    _userId = userId;
    _requestedAmount = requestedAmount;
    _approvedAmount = approvedAmount;
    _paymentBy = paymentBy;
    _referenceNo = referenceNo;
    _file = file;
    _remark = remark;
    _approvedBy = approvedBy;
    _verifiedBy = verifiedBy;
    _poutId = poutId;
    _fundAccountId = fundAccountId;
    _contactId = contactId;
    _status = status;
    _approvedDate = approvedDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Withdrawdata.fromJson(dynamic json) {
    _id = json['id'];
    _wrr = json['wrr'];
    _userId = json['user_id'];
    _requestedAmount = json['requested_amount'];
    _approvedAmount = json['approved_amount'];
    _paymentBy = json['payment_by'];
    _referenceNo = json['reference_no'];
    _file = json['file'];
    _remark = json['remark'];
    _approvedBy = json['approved_by'];
    _verifiedBy = json['verified_by'];
    _poutId = json['pout_id'];
    _fundAccountId = json['fund_account_id'];
    _contactId = json['contact_id'];
    _status = json['status'];
    _approvedDate = json['approved_date'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _wrr;
  int? _userId;
  dynamic _requestedAmount;
  dynamic _approvedAmount;
  dynamic _paymentBy;
  dynamic _referenceNo;
  dynamic _file;
  String? _remark;
  int? _approvedBy;
  dynamic _verifiedBy;
  String? _poutId;
  String? _fundAccountId;
  String? _contactId;
  int? _status;
  dynamic _approvedDate;
  String? _createdAt;
  String? _updatedAt;
Withdrawdata copyWith({  int? id,
  String? wrr,
  int? userId,
  dynamic requestedAmount,
  dynamic approvedAmount,
  dynamic paymentBy,
  dynamic referenceNo,
  dynamic file,
  String? remark,
  int? approvedBy,
  dynamic verifiedBy,
  String? poutId,
  String? fundAccountId,
  String? contactId,
  int? status,
  dynamic approvedDate,
  String? createdAt,
  String? updatedAt,
}) => Withdrawdata(  id: id ?? _id,
  wrr: wrr ?? _wrr,
  userId: userId ?? _userId,
  requestedAmount: requestedAmount ?? _requestedAmount,
  approvedAmount: approvedAmount ?? _approvedAmount,
  paymentBy: paymentBy ?? _paymentBy,
  referenceNo: referenceNo ?? _referenceNo,
  file: file ?? _file,
  remark: remark ?? _remark,
  approvedBy: approvedBy ?? _approvedBy,
  verifiedBy: verifiedBy ?? _verifiedBy,
  poutId: poutId ?? _poutId,
  fundAccountId: fundAccountId ?? _fundAccountId,
  contactId: contactId ?? _contactId,
  status: status ?? _status,
  approvedDate: approvedDate ?? _approvedDate,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  String? get wrr => _wrr;
  int? get userId => _userId;
  dynamic get requestedAmount => _requestedAmount;
  dynamic get approvedAmount => _approvedAmount;
  dynamic get paymentBy => _paymentBy;
  dynamic get referenceNo => _referenceNo;
  dynamic get file => _file;
  String? get remark => _remark;
  int? get approvedBy => _approvedBy;
  dynamic get verifiedBy => _verifiedBy;
  String? get poutId => _poutId;
  String? get fundAccountId => _fundAccountId;
  String? get contactId => _contactId;
  int? get status => _status;
  dynamic get approvedDate => _approvedDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['wrr'] = _wrr;
    map['user_id'] = _userId;
    map['requested_amount'] = _requestedAmount;
    map['approved_amount'] = _approvedAmount;
    map['payment_by'] = _paymentBy;
    map['reference_no'] = _referenceNo;
    map['file'] = _file;
    map['remark'] = _remark;
    map['approved_by'] = _approvedBy;
    map['verified_by'] = _verifiedBy;
    map['pout_id'] = _poutId;
    map['fund_account_id'] = _fundAccountId;
    map['contact_id'] = _contactId;
    map['status'] = _status;
    map['approved_date'] = _approvedDate;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}