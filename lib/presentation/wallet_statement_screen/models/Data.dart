class Data {
  Data({
      int? id, 
      int? userId, 
      String? label, 
      String? narration, 
      String? referenceNo, 
      String? amount, 
      String? type, 
      String? balance, 
      String? days, 
      String? remark, 
      String? date, 
      int? status,}){
    _id = id;
    _userId = userId;
    _label = label;
    _narration = narration;
    _referenceNo = referenceNo;
    _amount = amount;
    _type = type;
    _balance = balance;
    _days = days;
    _remark = remark;
    _date = date;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _label = json['label'];
    _narration = json['narration'];
    _referenceNo = json['reference_no'];
    _amount = json['amount'];
    _type = json['type'];
    _balance = json['balance'];
    _days = json['days'];
    _remark = json['remark'];
    _date = json['date'];
    _status = json['status'];
  }
  int? _id;
  int? _userId;
  String? _label;
  String? _narration;
  String? _referenceNo;
  String? _amount;
  String? _type;
  String? _balance;
  String? _days;
  String? _remark;
  String? _date;
  int? _status;
Data copyWith({  int? id,
  int? userId,
  String? label,
  String? narration,
  String? referenceNo,
  String? amount,
  String? type,
  String? balance,
  String? days,
  String? remark,
  String? date,
  int? status,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  label: label ?? _label,
  narration: narration ?? _narration,
  referenceNo: referenceNo ?? _referenceNo,
  amount: amount ?? _amount,
  type: type ?? _type,
  balance: balance ?? _balance,
  days: days ?? _days,
  remark: remark ?? _remark,
  date: date ?? _date,
  status: status ?? _status,
);
  int? get id => _id;
  int? get userId => _userId;
  String? get label => _label;
  String? get narration => _narration;
  String? get referenceNo => _referenceNo;
  String? get amount => _amount;
  String? get type => _type;
  String? get balance => _balance;
  String? get days => _days;
  String? get remark => _remark;
  String? get date => _date;
  int? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['label'] = _label;
    map['narration'] = _narration;
    map['reference_no'] = _referenceNo;
    map['amount'] = _amount;
    map['type'] = _type;
    map['balance'] = _balance;
    map['days'] = _days;
    map['remark'] = _remark;
    map['date'] = _date;
    map['status'] = _status;
    return map;
  }

}