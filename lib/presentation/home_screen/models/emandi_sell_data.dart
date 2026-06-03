class EmandiSellData {
  EmandiSellData({
    Data? data,
    int? salesStatus,
    dynamic mandiTax,
    int? interstDaysCount,
    String? status,
    String? message,
  }) {
    _data = data;
    _salesStatus = salesStatus;
    _mandiTax = mandiTax;
    _interstDaysCount = interstDaysCount;
    _status = status;
    _message = message;
  }

  EmandiSellData.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _salesStatus = json['sales_status'];
    _mandiTax = json['mandi_tax'];
    _interstDaysCount = json['interst_daysCount'];
    _status = json['status'];
    _message = json['message'];
  }
  Data? _data;
  int? _salesStatus;
  dynamic _mandiTax;
  int? _interstDaysCount;
  String? _status;
  String? _message;
  EmandiSellData copyWith({
    Data? data,
    int? salesStatus,
    dynamic mandiTax,
    int? interstDaysCount,
    String? status,
    String? message,
  }) =>
      EmandiSellData(
        data: data ?? _data,
        salesStatus: salesStatus ?? _salesStatus,
        mandiTax: mandiTax ?? _mandiTax,
        interstDaysCount: interstDaysCount ?? _interstDaysCount,
        status: status ?? _status,
        message: message ?? _message,
      );
  Data? get data => _data;
  int? get salesStatus => _salesStatus;
  dynamic get mandiTax => _mandiTax;
  int? get interstDaysCount => _interstDaysCount;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['sales_status'] = _salesStatus;
    map['mandi_tax'] = _mandiTax;
    map['interst_daysCount'] = _interstDaysCount;
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}

class Data {
  Data({
    int? principalAmount,
    int? rateOfInterest,
    String? loanApproveDate,
    String? interestFromDate,
    String? interestToDate,
    dynamic totalInterestAmount,
    int? totalInterestDays,
    String? rentToDate,
    String? rentFromDate,
    dynamic totalRentAmount,
    int? totalRentDays,
    dynamic bankId,
    String? bankName,
    dynamic mandiTax,
    int? bnplAmount,
    int? bnplInterest,
  }) {
    _principalAmount = principalAmount;
    _rateOfInterest = rateOfInterest;
    _loanApproveDate = loanApproveDate;
    _interestFromDate = interestFromDate;
    _interestToDate = interestToDate;
    _totalInterestAmount = totalInterestAmount;
    _totalInterestDays = totalInterestDays;
    _rentToDate = rentToDate;
    _rentFromDate = rentFromDate;
    _totalRentAmount = totalRentAmount;
    _totalRentDays = totalRentDays;
    _bankId = bankId;
    _bankName = bankName;
    _mandiTax = mandiTax;
    _bnplAmount = bnplAmount;
    _bnplInterest = bnplInterest;
  }

  Data.fromJson(dynamic json) {
    _principalAmount = json['principal_amount'];
    _rateOfInterest = json['rate_of_interest'];
    _loanApproveDate = json['loan_approve_date'];
    _interestFromDate = json['interest_from_date'];
    _interestToDate = json['interest_to_date'];
    _totalInterestAmount = json['total_interest_amount'];
    _totalInterestDays = json['total_interest_days'];
    _rentToDate = json['rent_to_date'];
    _rentFromDate = json['rent_from_date'];
    _totalRentAmount = json['total_rent_amount'];
    _totalRentDays = json['total_rent_days'];
    _bankId = json['bank_id'];
    _bankName = json['bank_name'];
    _mandiTax = json['mandi_tax'];
    _bnplAmount = json['bnpl_amount'];
    _bnplInterest = json['bnpl_interest'];
  }
  int? _principalAmount;
  int? _rateOfInterest;
  String? _loanApproveDate;
  String? _interestFromDate;
  String? _interestToDate;
  dynamic _totalInterestAmount;
  int? _totalInterestDays;
  String? _rentToDate;
  String? _rentFromDate;
  dynamic _totalRentAmount;
  int? _totalRentDays;
  dynamic _bankId;
  String? _bankName;
  dynamic _mandiTax;
  int? _bnplAmount;
  int? _bnplInterest;
  Data copyWith({
    int? principalAmount,
    int? rateOfInterest,
    String? loanApproveDate,
    String? interestFromDate,
    String? interestToDate,
    dynamic totalInterestAmount,
    int? totalInterestDays,
    String? rentToDate,
    String? rentFromDate,
    dynamic totalRentAmount,
    int? totalRentDays,
    dynamic bankId,
    String? bankName,
    dynamic mandiTax,
    int? bnplAmount,
    int? bnplInterest,
  }) =>
      Data(
        principalAmount: principalAmount ?? _principalAmount,
        rateOfInterest: rateOfInterest ?? _rateOfInterest,
        loanApproveDate: loanApproveDate ?? _loanApproveDate,
        interestFromDate: interestFromDate ?? _interestFromDate,
        interestToDate: interestToDate ?? _interestToDate,
        totalInterestAmount: totalInterestAmount ?? _totalInterestAmount,
        totalInterestDays: totalInterestDays ?? _totalInterestDays,
        rentToDate: rentToDate ?? _rentToDate,
        rentFromDate: rentFromDate ?? _rentFromDate,
        totalRentAmount: totalRentAmount ?? _totalRentAmount,
        totalRentDays: totalRentDays ?? _totalRentDays,
        bankId: bankId ?? _bankId,
        bankName: bankName ?? _bankName,
        mandiTax: mandiTax ?? _mandiTax,
        bnplAmount: bnplAmount ?? _bnplAmount,
        bnplInterest: bnplInterest ?? _bnplInterest,
      );
  int? get principalAmount => _principalAmount;
  int? get rateOfInterest => _rateOfInterest;
  String? get loanApproveDate => _loanApproveDate;
  String? get interestFromDate => _interestFromDate;
  String? get interestToDate => _interestToDate;
  dynamic get totalInterestAmount => _totalInterestAmount;
  int? get totalInterestDays => _totalInterestDays;
  String? get rentToDate => _rentToDate;
  String? get rentFromDate => _rentFromDate;
  dynamic get totalRentAmount => _totalRentAmount;
  int? get totalRentDays => _totalRentDays;
  int? get bankId => _bankId;
  String? get bankName => _bankName;
  dynamic get mandiTax => _mandiTax;
  int? get bnplAmount => _bnplAmount;
  int? get bnplInterest => _bnplInterest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['principal_amount'] = _principalAmount;
    map['rate_of_interest'] = _rateOfInterest;
    map['loan_approve_date'] = _loanApproveDate;
    map['interest_from_date'] = _interestFromDate;
    map['interest_to_date'] = _interestToDate;
    map['total_interest_amount'] = _totalInterestAmount;
    map['total_interest_days'] = _totalInterestDays;
    map['rent_to_date'] = _rentToDate;
    map['rent_from_date'] = _rentFromDate;
    map['total_rent_amount'] = _totalRentAmount;
    map['total_rent_days'] = _totalRentDays;
    map['bank_id'] = _bankId;
    map['bank_name'] = _bankName;
    map['mandi_tax'] = _mandiTax;
    map['bnpl_amount'] = _bnplAmount;
    map['bnpl_interest'] = _bnplInterest;
    return map;
  }
}
