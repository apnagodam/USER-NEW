class CommodityFinanceModel {
  CommodityFinanceModel({
    List<ComFinanceData>? data,
    String? status,
    String? message,
  }) {
    _data = data;
    _status = status;
    _message = message;
  }

  CommodityFinanceModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ComFinanceData.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<ComFinanceData>? _data;
  dynamic _status;
  String? _message;
  CommodityFinanceModel copyWith({
    List<ComFinanceData>? data,
    String? status,
    String? message,
  }) =>
      CommodityFinanceModel(
        data: data ?? _data,
        status: status ?? _status,
        message: message ?? _message,
      );
  List<ComFinanceData>? get data => _data;
  String? get status => _status;
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

class ComFinanceData {
  ComFinanceData({
    int? id,
    int? userId,
    int? bankId,
    String? uniqueId,
    int? requestedAmount,
    int? approvedAmount,
    String? remark,
    int? sanctionLatter,
    int? pda,
    int? pdc,
    int? agreement,
    dynamic approvedBy,
    dynamic verifiedBy,
    int? rejectedBy,
    dynamic approvedDate,
    dynamic verifiedDate,
    int? finalVerification,
    dynamic docVerifyedBy,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? bankName,
    Bank? bank,
  }) {
    _id = id;
    _userId = userId;
    _bankId = bankId;
    _uniqueId = uniqueId;
    _requestedAmount = requestedAmount;
    _approvedAmount = approvedAmount;
    _remark = remark;
    _sanctionLatter = sanctionLatter;
    _pda = pda;
    _pdc = pdc;
    _agreement = agreement;
    _approvedBy = approvedBy;
    _verifiedBy = verifiedBy;
    _rejectedBy = rejectedBy;
    _approvedDate = approvedDate;
    _verifiedDate = verifiedDate;
    _finalVerification = finalVerification;
    _docVerifyedBy = docVerifyedBy;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _bankName = bankName;
    _bank = bank;
  }

  ComFinanceData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _bankId = json['bank_id'];
    _uniqueId = json['unique_id'];
    _requestedAmount = json['requested_amount'];
    _approvedAmount = json['approved_amount'];
    _remark = json['remark'];
    _sanctionLatter = json['sanction_latter'];
    _pda = json['pda'];
    _pdc = json['pdc'];
    _agreement = json['agreement'];
    _approvedBy = json['approved_by'];
    _verifiedBy = json['verified_by'];
    _rejectedBy = json['rejected_by'];
    _approvedDate = json['approved_date'];
    _verifiedDate = json['verified_date'];
    _finalVerification = json['final_verification'];
    _docVerifyedBy = json['doc_verifyed_by'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _bankName = json['bank_name'];
    _bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
  }
  int? _id;
  int? _userId;
  int? _bankId;
  String? _uniqueId;
  int? _requestedAmount;
  int? _approvedAmount;
  String? _remark;
  int? _sanctionLatter;
  int? _pda;
  int? _pdc;
  int? _agreement;
  dynamic _approvedBy;
  dynamic _verifiedBy;
  int? _rejectedBy;
  dynamic _approvedDate;
  dynamic _verifiedDate;
  int? _finalVerification;
  dynamic _docVerifyedBy;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  String? _bankName;
  Bank? _bank;
  ComFinanceData copyWith({
    int? id,
    int? userId,
    int? bankId,
    String? uniqueId,
    int? requestedAmount,
    int? approvedAmount,
    String? remark,
    int? sanctionLatter,
    int? pda,
    int? pdc,
    int? agreement,
    dynamic approvedBy,
    dynamic verifiedBy,
    int? rejectedBy,
    dynamic approvedDate,
    dynamic verifiedDate,
    int? finalVerification,
    dynamic docVerifyedBy,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? bankName,
    Bank? bank,
  }) =>
      ComFinanceData(
        id: id ?? _id,
        userId: userId ?? _userId,
        bankId: bankId ?? _bankId,
        uniqueId: uniqueId ?? _uniqueId,
        requestedAmount: requestedAmount ?? _requestedAmount,
        approvedAmount: approvedAmount ?? _approvedAmount,
        remark: remark ?? _remark,
        sanctionLatter: sanctionLatter ?? _sanctionLatter,
        pda: pda ?? _pda,
        pdc: pdc ?? _pdc,
        agreement: agreement ?? _agreement,
        approvedBy: approvedBy ?? _approvedBy,
        verifiedBy: verifiedBy ?? _verifiedBy,
        rejectedBy: rejectedBy ?? _rejectedBy,
        approvedDate: approvedDate ?? _approvedDate,
        verifiedDate: verifiedDate ?? _verifiedDate,
        finalVerification: finalVerification ?? _finalVerification,
        docVerifyedBy: docVerifyedBy ?? _docVerifyedBy,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        bankName: bankName ?? _bankName,
        bank: bank ?? _bank,
      );
  int? get id => _id;
  int? get userId => _userId;
  int? get bankId => _bankId;
  String? get uniqueId => _uniqueId;
  int? get requestedAmount => _requestedAmount;
  int? get approvedAmount => _approvedAmount;
  String? get remark => _remark;
  int? get sanctionLatter => _sanctionLatter;
  int? get pda => _pda;
  int? get pdc => _pdc;
  int? get agreement => _agreement;
  dynamic get approvedBy => _approvedBy;
  dynamic get verifiedBy => _verifiedBy;
  int? get rejectedBy => _rejectedBy;
  dynamic get approvedDate => _approvedDate;
  dynamic get verifiedDate => _verifiedDate;
  int? get finalVerification => _finalVerification;
  dynamic get docVerifyedBy => _docVerifyedBy;
  dynamic get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get bankName => _bankName;
  Bank? get bank => _bank;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['bank_id'] = _bankId;
    map['unique_id'] = _uniqueId;
    map['requested_amount'] = _requestedAmount;
    map['approved_amount'] = _approvedAmount;
    map['remark'] = _remark;
    map['sanction_latter'] = _sanctionLatter;
    map['pda'] = _pda;
    map['pdc'] = _pdc;
    map['agreement'] = _agreement;
    map['approved_by'] = _approvedBy;
    map['verified_by'] = _verifiedBy;
    map['rejected_by'] = _rejectedBy;
    map['approved_date'] = _approvedDate;
    map['verified_date'] = _verifiedDate;
    map['final_verification'] = _finalVerification;
    map['doc_verifyed_by'] = _docVerifyedBy;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['bank_name'] = _bankName;
    if (_bank != null) {
      map['bank'] = _bank?.toJson();
    }
    return map;
  }
}

class Bank {
  Bank({
    int? id,
    String? bankName,
    String? url,
    dynamic address,
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
  }

  Bank.fromJson(dynamic json) {
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
  }
  int? _id;
  String? _bankName;
  String? _url;
  dynamic _address;
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
  Bank copyWith({
    int? id,
    String? bankName,
    String? url,
    dynamic address,
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
  }) =>
      Bank(
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
      );
  int? get id => _id;
  String? get bankName => _bankName;
  String? get url => _url;
  dynamic get address => _address;
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
    return map;
  }
}
