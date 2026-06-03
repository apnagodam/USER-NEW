class LoanModel {
  LoanModel({
      Finances? finances, 
      dynamic status, 
      dynamic message,}){
    _finances = finances;
    _status = status;
    _message = message;
}

  LoanModel.fromJson(dynamic json) {
    _finances = json['finances'] != null ? Finances.fromJson(json['finances']) : null;
    _status = json['status'];
    _message = json['message'];
  }
  Finances? _finances;
  dynamic _status;
  dynamic _message;
LoanModel copyWith({  Finances? finances,
  dynamic status,
  dynamic message,
}) => LoanModel(  finances: finances ?? _finances,
  status: status ?? _status,
  message: message ?? _message,
);
  Finances? get finances => _finances;
  dynamic get status => _status;
  dynamic get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_finances != null) {
      map['finances'] = _finances?.toJson();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class Finances {
  Finances({
      dynamic currentPage, 
      List<LoanfinaceData>? data, 
      dynamic firstPageUrl, 
      dynamic from, 
      dynamic lastPage, 
      dynamic lastPageUrl, 
      List<Links>? links, 
      dynamic nextPageUrl, 
      dynamic path, 
      dynamic perPage, 
      dynamic prevPageUrl, 
      dynamic to, 
      dynamic total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  Finances.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LoanfinaceData.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  dynamic _currentPage;
  List<LoanfinaceData>? _data;
  dynamic _firstPageUrl;
  dynamic _from;
  dynamic _lastPage;
  dynamic _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  dynamic _path;
  dynamic _perPage;
  dynamic _prevPageUrl;
  dynamic _to;
  dynamic _total;
Finances copyWith({  dynamic currentPage,
  List<LoanfinaceData>? data,
  dynamic firstPageUrl,
  dynamic from,
  dynamic lastPage,
  dynamic lastPageUrl,
  List<Links>? links,
  dynamic nextPageUrl,
  dynamic path,
  dynamic perPage,
  dynamic prevPageUrl,
  dynamic to,
  dynamic total,
}) => Finances(  currentPage: currentPage ?? _currentPage,
  data: data ?? _data,
  firstPageUrl: firstPageUrl ?? _firstPageUrl,
  from: from ?? _from,
  lastPage: lastPage ?? _lastPage,
  lastPageUrl: lastPageUrl ?? _lastPageUrl,
  links: links ?? _links,
  nextPageUrl: nextPageUrl ?? _nextPageUrl,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  prevPageUrl: prevPageUrl ?? _prevPageUrl,
  to: to ?? _to,
  total: total ?? _total,
);
  dynamic get currentPage => _currentPage;
  List<LoanfinaceData>? get data => _data;
  dynamic get firstPageUrl => _firstPageUrl;
  dynamic get from => _from;
  dynamic get lastPage => _lastPage;
  dynamic get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  dynamic get path => _path;
  dynamic get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  dynamic get to => _to;
  dynamic get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class Links {
  Links({
      dynamic url, 
      dynamic label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  dynamic _label;
  bool? _active;
Links copyWith({  dynamic url,
  dynamic label,
  bool? active,
}) => Links(  url: url ?? _url,
  label: label ?? _label,
  active: active ?? _active,
);
  dynamic get url => _url;
  dynamic get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

class LoanfinaceData {
  LoanfinaceData({
      dynamic id, 
      dynamic drfNo, 
      dynamic userId, 
      dynamic bankId, 
      dynamic amountIn, 
      dynamic price, 
      dynamic pan, 
      dynamic balanceSheet, 
      dynamic bankStatement, 
      dynamic commodityId, 
      dynamic quantity, 
      dynamic processingFee, 
      dynamic loanTotalPAmount, 
      dynamic rateOfInterest, 
      dynamic ltv, 
      dynamic valueOfCommodity, 
      dynamic amount, 
      dynamic compoundPIAmount, 
      dynamic remainingAmount, 
      dynamic disbursement, 
      dynamic bankName, 
      dynamic ifsc, 
      dynamic accountNo, 
      dynamic utrNo, 
      dynamic rejectReason, 
      dynamic doneBy, 
      dynamic approvedBy, 
      dynamic approvedDate, 
      dynamic amountAccType, 
      dynamic status, 
      dynamic tallyUpdateBy, 
      dynamic tallyUpdate, 
      dynamic tallyUpdateDate, 
      dynamic paymentUpdateBy, 
      dynamic paymentRef, 
      dynamic paymentDate, 
      dynamic poutId, 
      dynamic fundAccountId, 
      dynamic contactId, 
      dynamic loanIvr, 
      dynamic approveStatus, 
      dynamic closed, 
      dynamic createdAt, 
      dynamic updatedAt, 
      dynamic netWeight, 
      dynamic category, 
      dynamic name, 
      dynamic loanBankName, 
      dynamic caseId, 
      dynamic interestRate, 
      dynamic loanPerTotalAmount, 
      dynamic loanPassDays,}){
    _id = id;
    _drfNo = drfNo;
    _userId = userId;
    _bankId = bankId;
    _amountIn = amountIn;
    _price = price;
    _pan = pan;
    _balanceSheet = balanceSheet;
    _bankStatement = bankStatement;
    _commodityId = commodityId;
    _quantity = quantity;
    _processingFee = processingFee;
    _loanTotalPAmount = loanTotalPAmount;
    _rateOfInterest = rateOfInterest;
    _ltv = ltv;
    _valueOfCommodity = valueOfCommodity;
    _amount = amount;
    _compoundPIAmount = compoundPIAmount;
    _remainingAmount = remainingAmount;
    _disbursement = disbursement;
    _bankName = bankName;
    _ifsc = ifsc;
    _accountNo = accountNo;
    _utrNo = utrNo;
    _rejectReason = rejectReason;
    _doneBy = doneBy;
    _approvedBy = approvedBy;
    _approvedDate = approvedDate;
    _amountAccType = amountAccType;
    _status = status;
    _tallyUpdateBy = tallyUpdateBy;
    _tallyUpdate = tallyUpdate;
    _tallyUpdateDate = tallyUpdateDate;
    _paymentUpdateBy = paymentUpdateBy;
    _paymentRef = paymentRef;
    _paymentDate = paymentDate;
    _poutId = poutId;
    _fundAccountId = fundAccountId;
    _contactId = contactId;
    _loanIvr = loanIvr;
    _approveStatus = approveStatus;
    _closed = closed;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _netWeight = netWeight;
    _category = category;
    _name = name;
    _loanBankName = loanBankName;
    _caseId = caseId;
    _interestRate = interestRate;
    _loanPerTotalAmount = loanPerTotalAmount;
    _loanPassDays = loanPassDays;
}

  LoanfinaceData.fromJson(dynamic json) {
    _id = json['id'];
    _drfNo = json['drf_no'];
    _userId = json['user_id'];
    _bankId = json['bank_id'];
    _amountIn = json['amount_in'];
    _price = json['price'];
    _pan = json['pan'];
    _balanceSheet = json['balance_sheet'];
    _bankStatement = json['bank_statement'];
    _commodityId = json['commodity_id'];
    _quantity = json['quantity'];
    _processingFee = json['processing_fee'];
    _loanTotalPAmount = json['loan_total_p_amount'];
    _rateOfInterest = json['rate_of_interest'];
    _ltv = json['ltv'];
    _valueOfCommodity = json['value_of_commodity'];
    _amount = json['amount'];
    _compoundPIAmount = json['compound_p_i_amount'];
    _remainingAmount = json['remaining_amount'];
    _disbursement = json['disbursement'];
    _bankName = json['bank_name'];
    _ifsc = json['ifsc'];
    _accountNo = json['account_no'];
    _utrNo = json['utr_no'];
    _rejectReason = json['reject_reason'];
    _doneBy = json['done_by'];
    _approvedBy = json['approved_by'];
    _approvedDate = json['approved_date'];
    _amountAccType = json['amount_acc_type'];
    _status = json['status'];
    _tallyUpdateBy = json['tally_update_by'];
    _tallyUpdate = json['tally_update'];
    _tallyUpdateDate = json['tally_update_date'];
    _paymentUpdateBy = json['payment_update_by'];
    _paymentRef = json['payment_ref'];
    _paymentDate = json['payment_date'];
    _poutId = json['pout_id'];
    _fundAccountId = json['fund_account_id'];
    _contactId = json['contact_id'];
    _loanIvr = json['loan_ivr'];
    _approveStatus = json['approve_status'];
    _closed = json['closed'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _netWeight = json['net_weight'];
    _category = json['category'];
    _name = json['name'];
    _loanBankName = json['loan_bank_name'];
    _caseId = json['case_id'];
    _interestRate = json['interest_rate'];
    _loanPerTotalAmount = json['loan_per_total_amount'];
    _loanPassDays = json['loan_pass_days'];
  }
  dynamic _id;
  dynamic _drfNo;
  dynamic _userId;
  dynamic _bankId;
  dynamic _amountIn;
  dynamic _price;
  dynamic _pan;
  dynamic _balanceSheet;
  dynamic _bankStatement;
  dynamic _commodityId;
  dynamic _quantity;
  dynamic _processingFee;
  dynamic _loanTotalPAmount;
  dynamic _rateOfInterest;
  dynamic _ltv;
  dynamic _valueOfCommodity;
  dynamic _amount;
  dynamic _compoundPIAmount;
  dynamic _remainingAmount;
  dynamic _disbursement;
  dynamic _bankName;
  dynamic _ifsc;
  dynamic _accountNo;
  dynamic _utrNo;
  dynamic _rejectReason;
  dynamic _doneBy;
  dynamic _approvedBy;
  dynamic _approvedDate;
  dynamic _amountAccType;
  dynamic _status;
  dynamic _tallyUpdateBy;
  dynamic _tallyUpdate;
  dynamic _tallyUpdateDate;
  dynamic _paymentUpdateBy;
  dynamic _paymentRef;
  dynamic _paymentDate;
  dynamic _poutId;
  dynamic _fundAccountId;
  dynamic _contactId;
  dynamic _loanIvr;
  dynamic _approveStatus;
  dynamic _closed;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _netWeight;
  dynamic _category;
  dynamic _name;
  dynamic _loanBankName;
  dynamic _caseId;
  dynamic _interestRate;
  dynamic _loanPerTotalAmount;
  dynamic _loanPassDays;
LoanfinaceData copyWith({  dynamic id,
  dynamic drfNo,
  dynamic userId,
  dynamic bankId,
  dynamic amountIn,
  dynamic price,
  dynamic pan,
  dynamic balanceSheet,
  dynamic bankStatement,
  dynamic commodityId,
  dynamic quantity,
  dynamic processingFee,
  dynamic loanTotalPAmount,
  dynamic rateOfInterest,
  dynamic ltv,
  dynamic valueOfCommodity,
  dynamic amount,
  dynamic compoundPIAmount,
  dynamic remainingAmount,
  dynamic disbursement,
  dynamic bankName,
  dynamic ifsc,
  dynamic accountNo,
  dynamic utrNo,
  dynamic rejectReason,
  dynamic doneBy,
  dynamic approvedBy,
  dynamic approvedDate,
  dynamic amountAccType,
  dynamic status,
  dynamic tallyUpdateBy,
  dynamic tallyUpdate,
  dynamic tallyUpdateDate,
  dynamic paymentUpdateBy,
  dynamic paymentRef,
  dynamic paymentDate,
  dynamic poutId,
  dynamic fundAccountId,
  dynamic contactId,
  dynamic loanIvr,
  dynamic approveStatus,
  dynamic closed,
  dynamic createdAt,
  dynamic updatedAt,
  dynamic netWeight,
  dynamic category,
  dynamic name,
  dynamic loanBankName,
  dynamic caseId,
  dynamic interestRate,
  dynamic loanPerTotalAmount,
  dynamic loanPassDays,
}) => LoanfinaceData(  id: id ?? _id,
  drfNo: drfNo ?? _drfNo,
  userId: userId ?? _userId,
  bankId: bankId ?? _bankId,
  amountIn: amountIn ?? _amountIn,
  price: price ?? _price,
  pan: pan ?? _pan,
  balanceSheet: balanceSheet ?? _balanceSheet,
  bankStatement: bankStatement ?? _bankStatement,
  commodityId: commodityId ?? _commodityId,
  quantity: quantity ?? _quantity,
  processingFee: processingFee ?? _processingFee,
  loanTotalPAmount: loanTotalPAmount ?? _loanTotalPAmount,
  rateOfInterest: rateOfInterest ?? _rateOfInterest,
  ltv: ltv ?? _ltv,
  valueOfCommodity: valueOfCommodity ?? _valueOfCommodity,
  amount: amount ?? _amount,
  compoundPIAmount: compoundPIAmount ?? _compoundPIAmount,
  remainingAmount: remainingAmount ?? _remainingAmount,
  disbursement: disbursement ?? _disbursement,
  bankName: bankName ?? _bankName,
  ifsc: ifsc ?? _ifsc,
  accountNo: accountNo ?? _accountNo,
  utrNo: utrNo ?? _utrNo,
  rejectReason: rejectReason ?? _rejectReason,
  doneBy: doneBy ?? _doneBy,
  approvedBy: approvedBy ?? _approvedBy,
  approvedDate: approvedDate ?? _approvedDate,
  amountAccType: amountAccType ?? _amountAccType,
  status: status ?? _status,
  tallyUpdateBy: tallyUpdateBy ?? _tallyUpdateBy,
  tallyUpdate: tallyUpdate ?? _tallyUpdate,
  tallyUpdateDate: tallyUpdateDate ?? _tallyUpdateDate,
  paymentUpdateBy: paymentUpdateBy ?? _paymentUpdateBy,
  paymentRef: paymentRef ?? _paymentRef,
  paymentDate: paymentDate ?? _paymentDate,
  poutId: poutId ?? _poutId,
  fundAccountId: fundAccountId ?? _fundAccountId,
  contactId: contactId ?? _contactId,
  loanIvr: loanIvr ?? _loanIvr,
  approveStatus: approveStatus ?? _approveStatus,
  closed: closed ?? _closed,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  netWeight: netWeight ?? _netWeight,
  category: category ?? _category,
  name: name ?? _name,
  loanBankName: loanBankName ?? _loanBankName,
  caseId: caseId ?? _caseId,
  interestRate: interestRate ?? _interestRate,
  loanPerTotalAmount: loanPerTotalAmount ?? _loanPerTotalAmount,
  loanPassDays: loanPassDays ?? _loanPassDays,
);
  dynamic get id => _id;
  dynamic get drfNo => _drfNo;
  dynamic get userId => _userId;
  dynamic get bankId => _bankId;
  dynamic get amountIn => _amountIn;
  dynamic get price => _price;
  dynamic get pan => _pan;
  dynamic get balanceSheet => _balanceSheet;
  dynamic get bankStatement => _bankStatement;
  dynamic get commodityId => _commodityId;
  dynamic get quantity => _quantity;
  dynamic get processingFee => _processingFee;
  dynamic get loanTotalPAmount => _loanTotalPAmount;
  dynamic get rateOfInterest => _rateOfInterest;
  dynamic get ltv => _ltv;
  dynamic get valueOfCommodity => _valueOfCommodity;
  dynamic get amount => _amount;
  dynamic get compoundPIAmount => _compoundPIAmount;
  dynamic get remainingAmount => _remainingAmount;
  dynamic get disbursement => _disbursement;
  dynamic get bankName => _bankName;
  dynamic get ifsc => _ifsc;
  dynamic get accountNo => _accountNo;
  dynamic get utrNo => _utrNo;
  dynamic get rejectReason => _rejectReason;
  dynamic get doneBy => _doneBy;
  dynamic get approvedBy => _approvedBy;
  dynamic get approvedDate => _approvedDate;
  dynamic get amountAccType => _amountAccType;
  dynamic get status => _status;
  dynamic get tallyUpdateBy => _tallyUpdateBy;
  dynamic get tallyUpdate => _tallyUpdate;
  dynamic get tallyUpdateDate => _tallyUpdateDate;
  dynamic get paymentUpdateBy => _paymentUpdateBy;
  dynamic get paymentRef => _paymentRef;
  dynamic get paymentDate => _paymentDate;
  dynamic get poutId => _poutId;
  dynamic get fundAccountId => _fundAccountId;
  dynamic get contactId => _contactId;
  dynamic get loanIvr => _loanIvr;
  dynamic get approveStatus => _approveStatus;
  dynamic get closed => _closed;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get netWeight => _netWeight;
  dynamic get category => _category;
  dynamic get name => _name;
  dynamic get loanBankName => _loanBankName;
  dynamic get caseId => _caseId;
  dynamic get interestRate => _interestRate;
  dynamic get loanPerTotalAmount => _loanPerTotalAmount;
  dynamic get loanPassDays => _loanPassDays;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['drf_no'] = _drfNo;
    map['user_id'] = _userId;
    map['bank_id'] = _bankId;
    map['amount_in'] = _amountIn;
    map['price'] = _price;
    map['pan'] = _pan;
    map['balance_sheet'] = _balanceSheet;
    map['bank_statement'] = _bankStatement;
    map['commodity_id'] = _commodityId;
    map['quantity'] = _quantity;
    map['processing_fee'] = _processingFee;
    map['loan_total_p_amount'] = _loanTotalPAmount;
    map['rate_of_interest'] = _rateOfInterest;
    map['ltv'] = _ltv;
    map['value_of_commodity'] = _valueOfCommodity;
    map['amount'] = _amount;
    map['compound_p_i_amount'] = _compoundPIAmount;
    map['remaining_amount'] = _remainingAmount;
    map['disbursement'] = _disbursement;
    map['bank_name'] = _bankName;
    map['ifsc'] = _ifsc;
    map['account_no'] = _accountNo;
    map['utr_no'] = _utrNo;
    map['reject_reason'] = _rejectReason;
    map['done_by'] = _doneBy;
    map['approved_by'] = _approvedBy;
    map['approved_date'] = _approvedDate;
    map['amount_acc_type'] = _amountAccType;
    map['status'] = _status;
    map['tally_update_by'] = _tallyUpdateBy;
    map['tally_update'] = _tallyUpdate;
    map['tally_update_date'] = _tallyUpdateDate;
    map['payment_update_by'] = _paymentUpdateBy;
    map['payment_ref'] = _paymentRef;
    map['payment_date'] = _paymentDate;
    map['pout_id'] = _poutId;
    map['fund_account_id'] = _fundAccountId;
    map['contact_id'] = _contactId;
    map['loan_ivr'] = _loanIvr;
    map['approve_status'] = _approveStatus;
    map['closed'] = _closed;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['net_weight'] = _netWeight;
    map['category'] = _category;
    map['name'] = _name;
    map['loan_bank_name'] = _loanBankName;
    map['case_id'] = _caseId;
    map['interest_rate'] = _interestRate;
    map['loan_per_total_amount'] = _loanPerTotalAmount;
    map['loan_pass_days'] = _loanPassDays;
    return map;
  }

}