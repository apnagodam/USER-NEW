class AddSummaryModel {
  AddSummaryModel({
      List<Adddata>? data,}){
    _data = data;
}

  AddSummaryModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Adddata.fromJson(v));
      });
    }
  }
  List<Adddata>? _data;
AddSummaryModel copyWith({  List<Adddata>? data,
}) => AddSummaryModel(  data: data ?? _data,
);
  List<Adddata>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Adddata {
  Adddata({
      dynamic id, 
      dynamic userId, 
      dynamic uniqueLoanReqNo, 
      dynamic paymentType, 
      dynamic receptNo, 
      dynamic appliedAmount, 
      dynamic recivedAmount, 
      dynamic paymentImage, 
      dynamic paymentApproveBy, 
      dynamic paymentVerifyBy, 
      dynamic notes, 
      dynamic verifyStatus, 
      dynamic paymentStatus, 
      dynamic status, 
      dynamic createdAt, 
      dynamic updatedAt, 
      dynamic fname, 
      dynamic phone,}){
    _id = id;
    _userId = userId;
    _uniqueLoanReqNo = uniqueLoanReqNo;
    _paymentType = paymentType;
    _receptNo = receptNo;
    _appliedAmount = appliedAmount;
    _recivedAmount = recivedAmount;
    _paymentImage = paymentImage;
    _paymentApproveBy = paymentApproveBy;
    _paymentVerifyBy = paymentVerifyBy;
    _notes = notes;
    _verifyStatus = verifyStatus;
    _paymentStatus = paymentStatus;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _fname = fname;
    _phone = phone;
}

  Adddata.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _uniqueLoanReqNo = json['unique_loan_req_no'];
    _paymentType = json['payment_type'];
    _receptNo = json['recept_no'];
    _appliedAmount = json['applied_amount'];
    _recivedAmount = json['recived_amount'];
    _paymentImage = json['payment_image'];
    _paymentApproveBy = json['payment_approve_by'];
    _paymentVerifyBy = json['payment_verify_by'];
    _notes = json['notes'];
    _verifyStatus = json['verify_status'];
    _paymentStatus = json['payment_status'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _fname = json['fname'];
    _phone = json['phone'];
  }
  dynamic _id;
  dynamic _userId;
  dynamic _uniqueLoanReqNo;
  dynamic _paymentType;
  dynamic _receptNo;
  dynamic _appliedAmount;
  dynamic _recivedAmount;
  dynamic _paymentImage;
  dynamic _paymentApproveBy;
  dynamic _paymentVerifyBy;
  dynamic _notes;
  dynamic _verifyStatus;
  dynamic _paymentStatus;
  dynamic _status;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _fname;
  dynamic _phone;
Adddata copyWith({  dynamic id,
  dynamic userId,
  dynamic uniqueLoanReqNo,
  dynamic paymentType,
  dynamic receptNo,
  dynamic appliedAmount,
  dynamic recivedAmount,
  dynamic paymentImage,
  dynamic paymentApproveBy,
  dynamic paymentVerifyBy,
  dynamic notes,
  dynamic verifyStatus,
  dynamic paymentStatus,
  dynamic status,
  dynamic createdAt,
  dynamic updatedAt,
  dynamic fname,
  dynamic phone,
}) => Adddata(  id: id ?? _id,
  userId: userId ?? _userId,
  uniqueLoanReqNo: uniqueLoanReqNo ?? _uniqueLoanReqNo,
  paymentType: paymentType ?? _paymentType,
  receptNo: receptNo ?? _receptNo,
  appliedAmount: appliedAmount ?? _appliedAmount,
  recivedAmount: recivedAmount ?? _recivedAmount,
  paymentImage: paymentImage ?? _paymentImage,
  paymentApproveBy: paymentApproveBy ?? _paymentApproveBy,
  paymentVerifyBy: paymentVerifyBy ?? _paymentVerifyBy,
  notes: notes ?? _notes,
  verifyStatus: verifyStatus ?? _verifyStatus,
  paymentStatus: paymentStatus ?? _paymentStatus,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  fname: fname ?? _fname,
  phone: phone ?? _phone,
);
  dynamic get id => _id;
  dynamic get userId => _userId;
  dynamic get uniqueLoanReqNo => _uniqueLoanReqNo;
  dynamic get paymentType => _paymentType;
  dynamic get receptNo => _receptNo;
  dynamic get appliedAmount => _appliedAmount;
  dynamic get recivedAmount => _recivedAmount;
  dynamic get paymentImage => _paymentImage;
  dynamic get paymentApproveBy => _paymentApproveBy;
  dynamic get paymentVerifyBy => _paymentVerifyBy;
  dynamic get notes => _notes;
  dynamic get verifyStatus => _verifyStatus;
  dynamic get paymentStatus => _paymentStatus;
  dynamic get status => _status;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get fname => _fname;
  dynamic get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['unique_loan_req_no'] = _uniqueLoanReqNo;
    map['payment_type'] = _paymentType;
    map['recept_no'] = _receptNo;
    map['applied_amount'] = _appliedAmount;
    map['recived_amount'] = _recivedAmount;
    map['payment_image'] = _paymentImage;
    map['payment_approve_by'] = _paymentApproveBy;
    map['payment_verify_by'] = _paymentVerifyBy;
    map['notes'] = _notes;
    map['verify_status'] = _verifyStatus;
    map['payment_status'] = _paymentStatus;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['fname'] = _fname;
    map['phone'] = _phone;
    return map;
  }

}