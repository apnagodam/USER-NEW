class FinanceBankModel {
  FinanceBankModel({
    List<Banks>? banks,
    String? status,
    String? message,
  }) {
    _banks = banks;
    _status = status;
    _message = message;
  }

  FinanceBankModel.fromJson(dynamic json) {
    if (json['banks'] != null) {
      _banks = [];
      json['banks'].forEach((v) {
        _banks?.add(Banks.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<Banks>? _banks;
  dynamic _status;
  String? _message;
  FinanceBankModel copyWith({
    List<Banks>? banks,
    String? status,
    String? message,
  }) =>
      FinanceBankModel(
        banks: banks ?? _banks,
        status: status ?? _status,
        message: message ?? _message,
      );
  List<Banks>? get banks => _banks;
  dynamic get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_banks != null) {
      map['banks'] = _banks?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}

class Banks {
  Banks({
    int? id,
    String? bankName,
    String? url,
    String? address,
    String? interestRate,
    String? loanPassDays,
    String? processingFee,
    String? loanPerTotalAmount,
    dynamic guarantor,
    int? guaranteeFee,
    int? tenor,
    int? status,
    String? createdAt,
    String? updatedAt,
    int? sanctionLimit,
    dynamic apr,
  }) {
    _id = id;
    _bankName = bankName;
    _url = url;
    _address = address;
    _interestRate = interestRate;
    _loanPassDays = loanPassDays;
    _processingFee = processingFee;
    _loanPerTotalAmount = loanPerTotalAmount;
    _guarantor = guarantor;
    _guaranteeFee = guaranteeFee;
    _tenor = tenor;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _sanctionLimit = sanctionLimit;
    _apr = apr;
  }

  Banks.fromJson(dynamic json) {
    _id = json['id'];
    _bankName = json['bank_name'];
    _url = json['url'];
    _address = json['address'];
    _interestRate = json['interest_rate'];
    _loanPassDays = json['loan_pass_days'];
    _processingFee = json['processing_fee'];
    _loanPerTotalAmount = json['loan_per_total_amount'];
    _guarantor = json['guarantor'];
    _guaranteeFee = json['guarantee_fee'];
    _tenor = json['tenor'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _sanctionLimit = json['sanction_limit'];
    _apr = json['apr'];
  }
  int? _id;
  String? _bankName;
  String? _url;
  String? _address;
  String? _interestRate;
  String? _loanPassDays;
  String? _processingFee;
  String? _loanPerTotalAmount;
  dynamic _guarantor;
  int? _guaranteeFee;
  int? _tenor;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  int? _sanctionLimit;
  dynamic _apr;
  Banks copyWith({
    int? id,
    String? bankName,
    String? url,
    String? address,
    String? interestRate,
    String? loanPassDays,
    String? processingFee,
    String? loanPerTotalAmount,
    dynamic guarantor,
    int? guaranteeFee,
    int? tenor,
    int? status,
    String? createdAt,
    String? updatedAt,
    int? sanctionLimit,
    dynamic apr,
  }) =>
      Banks(
        id: id ?? _id,
        bankName: bankName ?? _bankName,
        url: url ?? _url,
        address: address ?? _address,
        interestRate: interestRate ?? _interestRate,
        loanPassDays: loanPassDays ?? _loanPassDays,
        processingFee: processingFee ?? _processingFee,
        loanPerTotalAmount: loanPerTotalAmount ?? _loanPerTotalAmount,
        guarantor: guarantor ?? _guarantor,
        guaranteeFee: guaranteeFee ?? _guaranteeFee,
        tenor: tenor ?? _tenor,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        sanctionLimit: sanctionLimit ?? _sanctionLimit,
        apr: apr ?? _apr,
      );
  int? get id => _id;
  String? get bankName => _bankName;
  String? get url => _url;
  String? get address => _address;
  String? get interestRate => _interestRate;
  String? get loanPassDays => _loanPassDays;
  String? get processingFee => _processingFee;
  String? get loanPerTotalAmount => _loanPerTotalAmount;
  dynamic get guarantor => _guarantor;
  int? get guaranteeFee => _guaranteeFee;
  int? get tenor => _tenor;
  dynamic get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get sanctionLimit => _sanctionLimit;
  dynamic get apr => _apr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['bank_name'] = _bankName;
    map['url'] = _url;
    map['address'] = _address;
    map['interest_rate'] = _interestRate;
    map['loan_pass_days'] = _loanPassDays;
    map['processing_fee'] = _processingFee;
    map['loan_per_total_amount'] = _loanPerTotalAmount;
    map['guarantor'] = _guarantor;
    map['guarantee_fee'] = _guaranteeFee;
    map['tenor'] = _tenor;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['sanction_limit'] = _sanctionLimit;
    map['apr'] = _apr;
    return map;
  }
}
