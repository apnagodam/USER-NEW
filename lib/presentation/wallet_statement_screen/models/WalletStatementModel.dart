import 'Data.dart';
class WalletStatementModel {
  WalletStatementModel({
      List<Data>? data, 
      double? openingBalance, 
      String? closingBalance, 
      int? status, 
      String? message,}){
    _data = data;
    _openingBalance = openingBalance;
    _closingBalance = closingBalance;
    _status = status;
    _message = message;
}

  WalletStatementModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _openingBalance = json['opening_balance'];
    _closingBalance = json['closing_balance'];
    _status = json['status'];
    _message = json['message'];
  }
  List<Data>? _data;
  double? _openingBalance;
  String? _closingBalance;
  int? _status;
  String? _message;
WalletStatementModel copyWith({  List<Data>? data,
  double? openingBalance,
  String? closingBalance,
  int? status,
  String? message,
}) => WalletStatementModel(  data: data ?? _data,
  openingBalance: openingBalance ?? _openingBalance,
  closingBalance: closingBalance ?? _closingBalance,
  status: status ?? _status,
  message: message ?? _message,
);
  List<Data>? get data => _data;
  double? get openingBalance => _openingBalance;
  String? get closingBalance => _closingBalance;
  int? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['opening_balance'] = _openingBalance;
    map['closing_balance'] = _closingBalance;
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

