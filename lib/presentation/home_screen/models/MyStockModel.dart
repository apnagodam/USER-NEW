class MyStockModel {
  MyStockModel({
    List<Banks>? banks,
    dynamic userTradeStatus,
    dynamic bnplAmount,
    dynamic bnplInterestAmount,
    List<CommodityData>? commodityData,
    List<WarehouseData>? warehouseData,
    Inventories? inventories,
    String? status,
    String? message,
  }) {
    _banks = banks;
    _userTradeStatus = userTradeStatus;
    _bnplAmount = bnplAmount;
    _bnplInterestAmount = bnplInterestAmount;
    _commodityData = commodityData;
    _warehouseData = warehouseData;
    _inventories = inventories;
    _status = status;
    _message = message;
  }

  MyStockModel.fromJson(dynamic json) {
    if (json['banks'] != null) {
      _banks = [];
      json['banks'].forEach((v) {
        _banks?.add(Banks.fromJson(v));
      });
    }
    _userTradeStatus = json['user_trade_status'];
    _bnplAmount = json['bnpl_amount'];
    _bnplInterestAmount = json['bnpl_interest_amount'];
    if (json['commodity_data'] != null) {
      _commodityData = [];
      json['commodity_data'].forEach((v) {
        _commodityData?.add(CommodityData.fromJson(v));
      });
    }
    if (json['warehouse_data'] != null) {
      _warehouseData = [];
      json['warehouse_data'].forEach((v) {
        _warehouseData?.add(WarehouseData.fromJson(v));
      });
    }
    _inventories = json['inventories'] != null
        ? Inventories.fromJson(json['inventories'])
        : null;
    _status = json['status'];
    _message = json['message'];
  }

  List<Banks>? _banks;
  dynamic _userTradeStatus;
  dynamic _bnplAmount;
  dynamic _bnplInterestAmount;
  List<CommodityData>? _commodityData;
  List<WarehouseData>? _warehouseData;
  Inventories? _inventories;
  String? _status;
  String? _message;

  MyStockModel copyWith({
    List<Banks>? banks,
    dynamic userTradeStatus,
    dynamic bnplAmount,
    dynamic bnplInterestAmount,
    List<CommodityData>? commodityData,
    List<WarehouseData>? warehouseData,
    Inventories? inventories,
    String? status,
    String? message,
  }) =>
      MyStockModel(
        banks: banks ?? _banks,
        userTradeStatus: userTradeStatus ?? _userTradeStatus,
        bnplAmount: bnplAmount ?? _bnplAmount,
        bnplInterestAmount: bnplInterestAmount ?? _bnplInterestAmount,
        commodityData: commodityData ?? _commodityData,
        warehouseData: warehouseData ?? _warehouseData,
        inventories: inventories ?? _inventories,
        status: status ?? _status,
        message: message ?? _message,
      );

  List<Banks>? get banks => _banks;

  dynamic get userTradeStatus => _userTradeStatus;

  dynamic get bnplAmount => _bnplAmount;

  dynamic get bnplInterestAmount => _bnplInterestAmount;

  List<CommodityData>? get commodityData => _commodityData;

  List<WarehouseData>? get warehouseData => _warehouseData;

  Inventories? get inventories => _inventories;

  String? get status => _status;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_banks != null) {
      map['banks'] = _banks?.map((v) => v.toJson()).toList();
    }
    map['user_trade_status'] = _userTradeStatus;
    map['bnpl_amount'] = _bnplAmount;
    map['bnpl_interest_amount'] = _bnplInterestAmount;
    if (_commodityData != null) {
      map['commodity_data'] = _commodityData?.map((v) => v.toJson()).toList();
    }
    if (_warehouseData != null) {
      map['warehouse_data'] = _warehouseData?.map((v) => v.toJson()).toList();
    }
    if (_inventories != null) {
      map['inventories'] = _inventories?.toJson();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}

class Inventories {
  Inventories({
    dynamic currentPage,
    List<InventoriesData>? data,
    String? firstPageUrl,
    dynamic from,
    dynamic lastPage,
    String? lastPageUrl,
    List<Links>? links,
    String? nextPageUrl,
    String? path,
    dynamic perPage,
    dynamic prevPageUrl,
    dynamic to,
    dynamic total,
  }) {
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

  Inventories.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(InventoriesData.fromJson(v));
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
  List<InventoriesData>? _data;
  String? _firstPageUrl;
  dynamic _from;
  dynamic _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  String? _nextPageUrl;
  String? _path;
  dynamic _perPage;
  dynamic _prevPageUrl;
  dynamic _to;
  dynamic _total;

  Inventories copyWith({
    dynamic currentPage,
    List<InventoriesData>? data,
    String? firstPageUrl,
    dynamic from,
    dynamic lastPage,
    String? lastPageUrl,
    List<Links>? links,
    String? nextPageUrl,
    String? path,
    dynamic perPage,
    dynamic prevPageUrl,
    dynamic to,
    dynamic total,
  }) =>
      Inventories(
        currentPage: currentPage ?? _currentPage,
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

  List<InventoriesData>? get data => _data;

  String? get firstPageUrl => _firstPageUrl;

  dynamic get from => _from;

  dynamic get lastPage => _lastPage;

  String? get lastPageUrl => _lastPageUrl;

  List<Links>? get links => _links;

  String? get nextPageUrl => _nextPageUrl;

  String? get path => _path;

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
    String? label,
    bool? active,
  }) {
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
  String? _label;
  bool? _active;

  Links copyWith({
    dynamic url,
    String? label,
    bool? active,
  }) =>
      Links(
        url: url ?? _url,
        label: label ?? _label,
        active: active ?? _active,
      );

  dynamic get url => _url;

  String? get label => _label;

  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}

class InventoriesData {
  InventoriesData({
    dynamic id,
    dynamic userId,
    String? caseId,
    dynamic warehouseId,
    dynamic commodity,
    String? warehouse,
    dynamic weightBridgeNo,
    String? truckNo,
    String? stackNo,
    dynamic lotNo,
    dynamic netWeight,
    dynamic type,
    String? quantity,
    dynamic bags,
    dynamic sellQuantity,
    String? price,
    String? gatePassWr,
    dynamic qualityCategory,
    dynamic origin,
    dynamic image,
    dynamic file,
    dynamic rentRowId,
    dynamic interestRowId,
    dynamic mandiAmount,
    dynamic settlmentAmount,
    dynamic remAmount,
    dynamic lessOldNegWalletSattlement,
    dynamic walletSatlementAmount,
    dynamic isLiquidation,
    dynamic rentRate,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    String? catName,
    String? catExpDate,
    dynamic qualityPCondition,
    String? name,
    String? warehouseCode,
    String? location,
    dynamic financesId,
    dynamic financesStatus,
    dynamic salesStatus,
    dynamic checkLoanCount,
    dynamic commodityPrice,
    dynamic principalAmount,
    dynamic interestAmount,
    dynamic rentAmount,
    dynamic invCount,
    String? pdfLink,
    List<QualityParameter>? qualityParameter,
    dynamic qvAmount,
  }) {
    _id = id;
    _userId = userId;
    _caseId = caseId;
    _warehouseId = warehouseId;
    _commodity = commodity;
    _warehouse = warehouse;
    _weightBridgeNo = weightBridgeNo;
    _truckNo = truckNo;
    _stackNo = stackNo;
    _lotNo = lotNo;
    _netWeight = netWeight;
    _type = type;
    _quantity = quantity;
    _bags = bags;
    _sellQuantity = sellQuantity;
    _price = price;
    _gatePassWr = gatePassWr;
    _qualityCategory = qualityCategory;
    _origin = origin;
    _image = image;
    _file = file;
    _rentRowId = rentRowId;
    _interestRowId = interestRowId;
    _mandiAmount = mandiAmount;
    _settlmentAmount = settlmentAmount;
    _remAmount = remAmount;
    _lessOldNegWalletSattlement = lessOldNegWalletSattlement;
    _walletSatlementAmount = walletSatlementAmount;
    _isLiquidation = isLiquidation;
    _rentRate = rentRate;
    _salesStatus = salesStatus;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _catName = catName;
    _catExpDate = catExpDate;
    _qualityPCondition = qualityPCondition;
    _name = name;
    _warehouseCode = warehouseCode;
    _location = location;
    _financesId = financesId;
    _financesStatus = financesStatus;
    _commodityPrice = commodityPrice;
    _principalAmount = principalAmount;
    _checkLoanCount = checkLoanCount;
    _interestAmount = interestAmount;
    _rentAmount = rentAmount;
    _invCount = invCount;
    _pdfLink = pdfLink;
    _qualityParameter = qualityParameter;
    _qvAmount = qvAmount;
  }

  InventoriesData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _caseId = json['case_id'];
    _warehouseId = json['warehouse_id'];
    _commodity = json['commodity'];
    _warehouse = json['warehouse'];
    _weightBridgeNo = json['weight_bridge_no'];
    _truckNo = json['truck_no'];
    _stackNo = json['stack_no'];
    _lotNo = json['lot_no'];
    _netWeight = json['net_weight'];
    _type = json['type'];
    _quantity = json['quantity'];
    _bags = json['bags'];
    _sellQuantity = json['sell_quantity'];
    _price = json['price'];
    _gatePassWr = json['gate_pass_wr'];
    _qualityCategory = json['quality_category'];
    _origin = json['origin'];
    _image = json['image'];
    _file = json['file'];
    _rentRowId = json['rent_row_id'];
    _interestRowId = json['interest_row_id'];
    _mandiAmount = json['mandi_amount'];
    _settlmentAmount = json['settlment_amount'];
    _remAmount = json['rem_amount'];
    _lessOldNegWalletSattlement = json['less_old_neg_wallet_sattlement'];
    _walletSatlementAmount = json['walletSatlementAmount'];
    _isLiquidation = json['is_liquidation'];
    _rentRate = json['rent_rate'];
    _salesStatus = json['sales_status'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _catName = json['cat_name'];
    _catExpDate = json['cat_exp_date'];
    _qualityPCondition = json['quality_p_condition'];
    _name = json['name'];
    _warehouseCode = json['warehouse_code'];
    _location = json['location'];
    _financesId = json['finances_id'];
    _financesStatus = json['finances_status'];
    _commodityPrice = json['commodity_price'];
    _principalAmount = json['principal_amount'];
    _checkLoanCount = json['check_loan_count'];
    _interestAmount = json['interest_amount'];
    _rentAmount = json['rent_amount'];
    _invCount = json['inv_count'];
    _pdfLink = json['pdf_link'];
    if (json['quality_parameter'] != null) {
      _qualityParameter = [];
      json['quality_parameter'].forEach((v) {
        _qualityParameter?.add(QualityParameter.fromJson(v));
      });
    }
    _qvAmount = json['qv_amount'];
  }

  dynamic _id;
  dynamic _userId;
  String? _caseId;
  dynamic _warehouseId;
  dynamic _commodity;
  String? _warehouse;
  dynamic _weightBridgeNo;
  String? _truckNo;
  String? _stackNo;
  dynamic _lotNo;
  dynamic _netWeight;
  dynamic _type;
  String? _quantity;
  dynamic _bags;
  dynamic _sellQuantity;
  String? _price;
  String? _gatePassWr;
  dynamic _qualityCategory;
  dynamic _origin;
  dynamic _image;
  dynamic _file;
  dynamic _rentRowId;
  dynamic _interestRowId;
  dynamic _mandiAmount;
  dynamic _settlmentAmount;
  dynamic _remAmount;
  dynamic _lessOldNegWalletSattlement;
  dynamic _walletSatlementAmount;
  dynamic _isLiquidation;
  dynamic _rentRate;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  String? _catName;
  String? _catExpDate;
  dynamic _qualityPCondition;
  String? _name;
  String? _warehouseCode;
  String? _location;
  dynamic _financesId;
  dynamic _financesStatus;
  dynamic _checkLoanCount;
  dynamic _salesStatus;

  dynamic _commodityPrice;
  dynamic _principalAmount;
  dynamic _interestAmount;
  dynamic _rentAmount;
  dynamic _invCount;
  String? _pdfLink;
  List<QualityParameter>? _qualityParameter;
  dynamic _qvAmount;

  InventoriesData copyWith({
    dynamic id,
    dynamic userId,
    String? caseId,
    dynamic warehouseId,
    dynamic commodity,
    String? warehouse,
    dynamic weightBridgeNo,
    String? truckNo,
    String? stackNo,
    dynamic lotNo,
    dynamic netWeight,
    dynamic type,
    String? quantity,
    dynamic bags,
    dynamic sellQuantity,
    String? price,
    String? gatePassWr,
    dynamic qualityCategory,
    dynamic origin,
    dynamic image,
    dynamic file,
    dynamic rentRowId,
    dynamic interestRowId,
    dynamic mandiAmount,
    dynamic settlmentAmount,
    dynamic remAmount,
    dynamic lessOldNegWalletSattlement,
    dynamic walletSatlementAmount,
    dynamic isLiquidation,
    dynamic rentRate,
    dynamic salesStatus,
    dynamic financesId,
    dynamic financesStatus,
    dynamic checkLoanCount,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    String? catName,
    String? catExpDate,
    dynamic qualityPCondition,
    String? name,
    String? warehouseCode,
    String? location,
    dynamic commodityPrice,
    dynamic principalAmount,
    dynamic interestAmount,
    dynamic rentAmount,
    dynamic invCount,
    String? pdfLink,
    List<QualityParameter>? qualityParameter,
    dynamic qvAmount,
  }) =>
      InventoriesData(
        id: id ?? _id,
        userId: userId ?? _userId,
        caseId: caseId ?? _caseId,
        warehouseId: warehouseId ?? _warehouseId,
        commodity: commodity ?? _commodity,
        warehouse: warehouse ?? _warehouse,
        weightBridgeNo: weightBridgeNo ?? _weightBridgeNo,
        truckNo: truckNo ?? _truckNo,
        stackNo: stackNo ?? _stackNo,
        lotNo: lotNo ?? _lotNo,
        netWeight: netWeight ?? _netWeight,
        type: type ?? _type,
        quantity: quantity ?? _quantity,
        bags: bags ?? _bags,
        sellQuantity: sellQuantity ?? _sellQuantity,
        price: price ?? _price,
        gatePassWr: gatePassWr ?? _gatePassWr,
        qualityCategory: qualityCategory ?? _qualityCategory,
        origin: origin ?? _origin,
        image: image ?? _image,
        file: file ?? _file,
        rentRowId: rentRowId ?? _rentRowId,
        interestRowId: interestRowId ?? _interestRowId,
        mandiAmount: mandiAmount ?? _mandiAmount,
        settlmentAmount: settlmentAmount ?? _settlmentAmount,
        remAmount: remAmount ?? _remAmount,
        lessOldNegWalletSattlement:
            lessOldNegWalletSattlement ?? _lessOldNegWalletSattlement,
        walletSatlementAmount: walletSatlementAmount ?? _walletSatlementAmount,
        isLiquidation: isLiquidation ?? _isLiquidation,
        rentRate: rentRate ?? _rentRate,
        salesStatus: salesStatus ?? _salesStatus,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        catName: catName ?? _catName,
        catExpDate: catExpDate ?? _catExpDate,
        qualityPCondition: qualityPCondition ?? _qualityPCondition,
        name: name ?? _name,
        warehouseCode: warehouseCode ?? _warehouseCode,
        location: location ?? _location,
        financesId: financesId ?? _financesId,
        financesStatus: financesStatus ?? _financesStatus,
        commodityPrice: commodityPrice ?? _commodityPrice,
        principalAmount: principalAmount ?? _principalAmount,
        checkLoanCount: checkLoanCount ?? _checkLoanCount,
        interestAmount: interestAmount ?? _interestAmount,
        rentAmount: rentAmount ?? _rentAmount,
        invCount: invCount ?? _invCount,
        pdfLink: pdfLink ?? _pdfLink,
        qualityParameter: qualityParameter ?? _qualityParameter,
        qvAmount: qvAmount ?? _qvAmount,
      );

  dynamic get id => _id;

  dynamic get userId => _userId;

  String? get caseId => _caseId;

  dynamic get warehouseId => _warehouseId;

  dynamic get commodity => _commodity;

  String? get warehouse => _warehouse;

  dynamic get weightBridgeNo => _weightBridgeNo;

  String? get truckNo => _truckNo;

  String? get stackNo => _stackNo;

  dynamic get lotNo => _lotNo;

  dynamic get netWeight => _netWeight;

  dynamic get type => _type;

  String? get quantity => _quantity;

  dynamic get bags => _bags;

  dynamic get sellQuantity => _sellQuantity;

  String? get price => _price;

  String? get gatePassWr => _gatePassWr;

  dynamic get qualityCategory => _qualityCategory;

  dynamic get origin => _origin;

  dynamic get image => _image;

  dynamic get file => _file;

  dynamic get rentRowId => _rentRowId;

  dynamic get interestRowId => _interestRowId;

  dynamic get mandiAmount => _mandiAmount;

  dynamic get settlmentAmount => _settlmentAmount;

  dynamic get remAmount => _remAmount;

  dynamic get lessOldNegWalletSattlement => _lessOldNegWalletSattlement;

  dynamic get walletSatlementAmount => _walletSatlementAmount;

  dynamic get isLiquidation => _isLiquidation;

  dynamic get rentRate => _rentRate;

  dynamic get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get catName => _catName;

  String? get catExpDate => _catExpDate;

  dynamic get qualityPCondition => _qualityPCondition;

  String? get name => _name;

  String? get warehouseCode => _warehouseCode;

  String? get location => _location;

  dynamic get financesId => _financesId;

  dynamic get financesStatus => _financesStatus;

  dynamic get checkLoanCount => _checkLoanCount;

  dynamic get salesStatus => _salesStatus;

  dynamic get commodityPrice => _commodityPrice;

  dynamic get principalAmount => _principalAmount;

  dynamic get interestAmount => _interestAmount;

  dynamic get rentAmount => _rentAmount;

  dynamic get invCount => _invCount;

  String? get pdfLink => _pdfLink;

  List<QualityParameter>? get qualityParameter => _qualityParameter;

  dynamic get qvAmount => _qvAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['case_id'] = _caseId;
    map['warehouse_id'] = _warehouseId;
    map['commodity'] = _commodity;
    map['warehouse'] = _warehouse;
    map['weight_bridge_no'] = _weightBridgeNo;
    map['truck_no'] = _truckNo;
    map['stack_no'] = _stackNo;
    map['lot_no'] = _lotNo;
    map['net_weight'] = _netWeight;
    map['type'] = _type;
    map['quantity'] = _quantity;
    map['bags'] = _bags;
    map['sell_quantity'] = _sellQuantity;
    map['price'] = _price;
    map['gate_pass_wr'] = _gatePassWr;
    map['quality_category'] = _qualityCategory;
    map['origin'] = _origin;
    map['image'] = _image;
    map['file'] = _file;
    map['rent_row_id'] = _rentRowId;
    map['interest_row_id'] = _interestRowId;
    map['mandi_amount'] = _mandiAmount;
    map['settlment_amount'] = _settlmentAmount;
    map['rem_amount'] = _remAmount;
    map['less_old_neg_wallet_sattlement'] = _lessOldNegWalletSattlement;
    map['walletSatlementAmount'] = _walletSatlementAmount;
    map['is_liquidation'] = _isLiquidation;
    map['rent_rate'] = _rentRate;
    map['sales_status'] = _salesStatus;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['cat_name'] = _catName;
    map['cat_exp_date'] = _catExpDate;
    map['quality_p_condition'] = _qualityPCondition;
    map['name'] = _name;
    map['warehouse_code'] = _warehouseCode;
    map['location'] = _location;
    map['finances_id'] = _financesId;
    map['finances_status'] = _financesStatus;
    map['commodity_price'] = _commodityPrice;
    map['principal_amount'] = _principalAmount;
    map['check_loan_count'] = _checkLoanCount;
    map['interest_amount'] = _interestAmount;
    map['rent_amount'] = _rentAmount;
    map['inv_count'] = _invCount;
    map['pdf_link'] = _pdfLink;
    if (_qualityParameter != null) {
      map['quality_parameter'] =
          _qualityParameter?.map((v) => v.toJson()).toList();
    }
    map['qv_amount'] = _qvAmount;
    return map;
  }
}

class WarehouseData {
  WarehouseData({
    dynamic id,
    String? warehouseName,
  }) {
    _id = id;
    _warehouseName = warehouseName;
  }

  WarehouseData.fromJson(dynamic json) {
    _id = json['id'];
    _warehouseName = json['warehouse_name'];
  }

  dynamic _id;
  String? _warehouseName;

  WarehouseData copyWith({
    dynamic id,
    String? warehouseName,
  }) =>
      WarehouseData(
        id: id ?? _id,
        warehouseName: warehouseName ?? _warehouseName,
      );

  dynamic get id => _id;

  String? get warehouseName => _warehouseName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['warehouse_name'] = _warehouseName;
    return map;
  }
}

class CommodityData {
  CommodityData({
    dynamic id,
    String? category,
  }) {
    _id = id;
    _category = category;
  }

  CommodityData.fromJson(dynamic json) {
    _id = json['id'];
    _category = json['category'];
  }

  dynamic _id;
  String? _category;

  CommodityData copyWith({
    dynamic id,
    String? category,
  }) =>
      CommodityData(
        id: id ?? _id,
        category: category ?? _category,
      );

  dynamic get id => _id;

  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category'] = _category;
    return map;
  }
}

class Banks {
  Banks({
    dynamic id,
    String? bankName,
    String? url,
    String? address,
    String? interestRate,
    String? loanPassDays,
    String? processingFee,
    String? loanPerTotalAmount,
    dynamic guarantor,
    dynamic guaranteeFee,
    dynamic tenor,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    String? apr,
    dynamic sanctionLimit,
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
    _apr = apr;
    _sanctionLimit = sanctionLimit;
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
    _apr = json['apr'];
    _sanctionLimit = json['sanction_limit'];
  }

  dynamic _id;
  String? _bankName;
  String? _url;
  String? _address;
  String? _interestRate;
  String? _loanPassDays;
  String? _processingFee;
  String? _loanPerTotalAmount;
  dynamic _guarantor;
  dynamic _guaranteeFee;
  dynamic _tenor;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  String? _apr;
  dynamic _sanctionLimit;

  Banks copyWith({
    dynamic id,
    String? bankName,
    String? url,
    String? address,
    String? interestRate,
    String? loanPassDays,
    String? processingFee,
    String? loanPerTotalAmount,
    dynamic guarantor,
    dynamic guaranteeFee,
    dynamic tenor,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    String? apr,
    dynamic sanctionLimit,
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
        apr: apr ?? _apr,
        sanctionLimit: sanctionLimit ?? _sanctionLimit,
      );

  dynamic get id => _id;

  String? get bankName => _bankName;

  String? get url => _url;

  String? get address => _address;

  String? get interestRate => _interestRate;

  String? get loanPassDays => _loanPassDays;

  String? get processingFee => _processingFee;

  String? get loanPerTotalAmount => _loanPerTotalAmount;

  dynamic get guarantor => _guarantor;

  dynamic get guaranteeFee => _guaranteeFee;

  dynamic get tenor => _tenor;

  dynamic get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get apr => _apr;

  dynamic get sanctionLimit => _sanctionLimit;

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
    map['apr'] = _apr;
    map['sanction_limit'] = _sanctionLimit;
    return map;
  }
}

class QualityParameter {
  QualityParameter({
    dynamic id,
    dynamic commodityId,
    dynamic parameterId,
    dynamic min,
    dynamic max,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    dynamic value,
    String? parameter,
    QualityParameters? qualityParameters,
  }) {
    _id = id;
    _commodityId = commodityId;
    _parameterId = parameterId;
    _min = min;
    _max = max;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _value = value;
    _parameter = parameter;
    _qualityParameters = qualityParameters;
  }

  QualityParameter.fromJson(dynamic json) {
    _id = json['id'];
    _commodityId = json['commodity_id'];
    _parameterId = json['parameter_id'];
    _min = json['min'];
    _max = json['max'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _value = json['value'];
    _parameter = json['parameter'];
    _qualityParameters = json['quality_parameters'] != null
        ? QualityParameters.fromJson(json['quality_parameters'])
        : null;
  }

  dynamic _id;
  dynamic _commodityId;
  dynamic _parameterId;
  dynamic _min;
  dynamic _max;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _value;
  String? _parameter;
  QualityParameters? _qualityParameters;

  QualityParameter copyWith({
    dynamic id,
    dynamic commodityId,
    dynamic parameterId,
    dynamic min,
    dynamic max,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    dynamic value,
    String? parameter,
    QualityParameters? qualityParameters,
  }) =>
      QualityParameter(
        id: id ?? _id,
        commodityId: commodityId ?? _commodityId,
        parameterId: parameterId ?? _parameterId,
        min: min ?? _min,
        max: max ?? _max,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        value: value ?? _value,
        parameter: parameter ?? _parameter,
        qualityParameters: qualityParameters ?? _qualityParameters,
      );

  dynamic get id => _id;

  dynamic get commodityId => _commodityId;

  dynamic get parameterId => _parameterId;

  dynamic get min => _min;

  dynamic get max => _max;

  dynamic get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  dynamic get value => _value;

  String? get parameter => _parameter;

  QualityParameters? get qualityParameters => _qualityParameters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['commodity_id'] = _commodityId;
    map['parameter_id'] = _parameterId;
    map['min'] = _min;
    map['max'] = _max;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['value'] = _value;
    map['parameter'] = _parameter;
    if (_qualityParameters != null) {
      map['quality_parameters'] = _qualityParameters?.toJson();
    }
    return map;
  }
}

class QualityParameters {
  QualityParameters({
    dynamic id,
    String? parameter,
    dynamic status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _parameter = parameter;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  QualityParameters.fromJson(dynamic json) {
    _id = json['id'];
    _parameter = json['parameter'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  dynamic _id;
  String? _parameter;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;

  QualityParameters copyWith({
    dynamic id,
    String? parameter,
    dynamic status,
    String? createdAt,
    String? updatedAt,
  }) =>
      QualityParameters(
        id: id ?? _id,
        parameter: parameter ?? _parameter,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  dynamic get id => _id;

  String? get parameter => _parameter;

  dynamic get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parameter'] = _parameter;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
