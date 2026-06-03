class WarehouseModel {
  WarehouseModel({
    Inventories? inventories,
    String? status,
    String? message,
  }) {
    _inventories = inventories;
    _status = status;
    _message = message;
  }

  WarehouseModel.fromJson(dynamic json) {
    _inventories = json['inventories'] != null
        ? Inventories.fromJson(json['inventories'])
        : null;
    _status = json['status'];
    _message = json['message'];
  }
  Inventories? _inventories;
  String? _status;
  String? _message;
  WarehouseModel copyWith({
    Inventories? inventories,
    String? status,
    String? message,
  }) =>
      WarehouseModel(
        inventories: inventories ?? _inventories,
        status: status ?? _status,
        message: message ?? _message,
      );
  Inventories? get inventories => _inventories;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    int? currentPage,
    List<WareHouseData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
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
        _data?.add(WareHouseData.fromJson(v));
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
  int? _currentPage;
  List<WareHouseData>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  String? _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;
  Inventories copyWith({
    int? currentPage,
    List<WareHouseData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
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
  int? get currentPage => _currentPage;
  List<WareHouseData>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  String? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

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

class WareHouseData {
  WareHouseData({
    int? id,
    int? uniqueId,
    int? buyerId,
    int? sellerId,
    int? sellerCatId,
    dynamic paymentRefNo,
    String? quantity,
    String? price,
    int? labourRate,
    dynamic todaysPrice,
    int? bidType,
    dynamic mandiFees,
    dynamic rentRowId,
    dynamic interestRowId,
    dynamic financeId,
    String? finalMandiAmount,
    String? finalSettlmentAmount,
    String? finalRemAmount,
    String? finalWalletSatlementAmount,
    String? mandiTaxRate,
    String? mandiTaxAmount,
    int? agCommission,
    int? gst,
    int? gstAmount,
    int? paymentAdvice,
    int? qvAmount,
    int? isInvoice,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? category,
    dynamic qualityCategory,
    String? name,
    String? location,
    String? fname,
    int? salesStatus,
    String? gatePassWr,
  }) {
    _id = id;
    _uniqueId = uniqueId;
    _buyerId = buyerId;
    _sellerId = sellerId;
    _sellerCatId = sellerCatId;
    _paymentRefNo = paymentRefNo;
    _quantity = quantity;
    _price = price;
    _labourRate = labourRate;
    _todaysPrice = todaysPrice;
    _bidType = bidType;
    _mandiFees = mandiFees;
    _rentRowId = rentRowId;
    _interestRowId = interestRowId;
    _financeId = financeId;
    _finalMandiAmount = finalMandiAmount;
    _finalSettlmentAmount = finalSettlmentAmount;
    _finalRemAmount = finalRemAmount;
    _finalWalletSatlementAmount = finalWalletSatlementAmount;
    _mandiTaxRate = mandiTaxRate;
    _mandiTaxAmount = mandiTaxAmount;
    _agCommission = agCommission;
    _gst = gst;
    _gstAmount = gstAmount;
    _paymentAdvice = paymentAdvice;
    _qvAmount = qvAmount;
    _isInvoice = isInvoice;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
    _qualityCategory = qualityCategory;
    _name = name;
    _location = location;
    _fname = fname;
    _salesStatus = salesStatus;
    _gatePassWr = gatePassWr;
  }

  WareHouseData.fromJson(dynamic json) {
    _id = json['id'];
    _uniqueId = json['unique_id'];
    _buyerId = json['buyer_id'];
    _sellerId = json['seller_id'];
    _sellerCatId = json['seller_cat_id'];
    _paymentRefNo = json['payment_ref_no'];
    _quantity = json['quantity'];
    _price = json['price'];
    _labourRate = json['labour_rate'];
    _todaysPrice = json['todays_price'];
    _bidType = json['bid_type'];
    _mandiFees = json['mandi_fees'];
    _rentRowId = json['rent_row_id'];
    _interestRowId = json['interest_row_id'];
    _financeId = json['finance_id'];
    _finalMandiAmount = json['final_mandi_amount'];
    _finalSettlmentAmount = json['final_settlment_amount'];
    _finalRemAmount = json['final_rem_amount'];
    _finalWalletSatlementAmount = json['final_wallet_satlement_amount'];
    _mandiTaxRate = json['mandi_tax_rate'];
    _mandiTaxAmount = json['mandi_tax_amount'];
    _agCommission = json['ag_commission'];
    _gst = json['gst'];
    _gstAmount = json['gst_amount'];
    _paymentAdvice = json['payment_advice'];
    _qvAmount = json['qv_amount'];
    _isInvoice = json['is_invoice'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _category = json['category'];
    _qualityCategory = json['quality_category'];
    _name = json['name'];
    _location = json['location'];
    _fname = json['fname'];
    _salesStatus = json['sales_status'];
    _gatePassWr = json['gate_pass_wr'];
  }
  int? _id;
  int? _uniqueId;
  int? _buyerId;
  int? _sellerId;
  int? _sellerCatId;
  dynamic _paymentRefNo;
  String? _quantity;
  String? _price;
  int? _labourRate;
  dynamic _todaysPrice;
  int? _bidType;
  dynamic _mandiFees;
  dynamic _rentRowId;
  dynamic _interestRowId;
  dynamic _financeId;
  String? _finalMandiAmount;
  String? _finalSettlmentAmount;
  String? _finalRemAmount;
  String? _finalWalletSatlementAmount;
  String? _mandiTaxRate;
  String? _mandiTaxAmount;
  int? _agCommission;
  int? _gst;
  int? _gstAmount;
  int? _paymentAdvice;
  dynamic _qvAmount;
  int? _isInvoice;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _category;
  dynamic _qualityCategory;
  String? _name;
  String? _location;
  String? _fname;
  int? _salesStatus;
  String? _gatePassWr;
  WareHouseData copyWith({
    int? id,
    int? uniqueId,
    int? buyerId,
    int? sellerId,
    int? sellerCatId,
    dynamic paymentRefNo,
    String? quantity,
    String? price,
    int? labourRate,
    dynamic todaysPrice,
    int? bidType,
    dynamic mandiFees,
    dynamic rentRowId,
    dynamic interestRowId,
    dynamic financeId,
    String? finalMandiAmount,
    String? finalSettlmentAmount,
    String? finalRemAmount,
    String? finalWalletSatlementAmount,
    String? mandiTaxRate,
    String? mandiTaxAmount,
    int? agCommission,
    int? gst,
    int? gstAmount,
    int? paymentAdvice,
    int? qvAmount,
    int? isInvoice,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? category,
    dynamic qualityCategory,
    String? name,
    String? location,
    String? fname,
    int? salesStatus,
    String? gatePassWr,
  }) =>
      WareHouseData(
        id: id ?? _id,
        uniqueId: uniqueId ?? _uniqueId,
        buyerId: buyerId ?? _buyerId,
        sellerId: sellerId ?? _sellerId,
        sellerCatId: sellerCatId ?? _sellerCatId,
        paymentRefNo: paymentRefNo ?? _paymentRefNo,
        quantity: quantity ?? _quantity,
        price: price ?? _price,
        labourRate: labourRate ?? _labourRate,
        todaysPrice: todaysPrice ?? _todaysPrice,
        bidType: bidType ?? _bidType,
        mandiFees: mandiFees ?? _mandiFees,
        rentRowId: rentRowId ?? _rentRowId,
        interestRowId: interestRowId ?? _interestRowId,
        financeId: financeId ?? _financeId,
        finalMandiAmount: finalMandiAmount ?? _finalMandiAmount,
        finalSettlmentAmount: finalSettlmentAmount ?? _finalSettlmentAmount,
        finalRemAmount: finalRemAmount ?? _finalRemAmount,
        finalWalletSatlementAmount:
            finalWalletSatlementAmount ?? _finalWalletSatlementAmount,
        mandiTaxRate: mandiTaxRate ?? _mandiTaxRate,
        mandiTaxAmount: mandiTaxAmount ?? _mandiTaxAmount,
        agCommission: agCommission ?? _agCommission,
        gst: gst ?? _gst,
        gstAmount: gstAmount ?? _gstAmount,
        paymentAdvice: paymentAdvice ?? _paymentAdvice,
        qvAmount: qvAmount ?? _qvAmount,
        isInvoice: isInvoice ?? _isInvoice,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        category: category ?? _category,
        qualityCategory: qualityCategory ?? _qualityCategory,
        name: name ?? _name,
        location: location ?? _location,
        fname: fname ?? _fname,
        salesStatus: salesStatus ?? _salesStatus,
        gatePassWr: gatePassWr ?? _gatePassWr,
      );
  int? get id => _id;
  int? get uniqueId => _uniqueId;
  int? get buyerId => _buyerId;
  int? get sellerId => _sellerId;
  int? get sellerCatId => _sellerCatId;
  dynamic get paymentRefNo => _paymentRefNo;
  String? get quantity => _quantity;
  String? get price => _price;
  int? get labourRate => _labourRate;
  dynamic get todaysPrice => _todaysPrice;
  int? get bidType => _bidType;
  dynamic get mandiFees => _mandiFees;
  dynamic get rentRowId => _rentRowId;
  dynamic get interestRowId => _interestRowId;
  dynamic get financeId => _financeId;
  String? get finalMandiAmount => _finalMandiAmount;
  String? get finalSettlmentAmount => _finalSettlmentAmount;
  String? get finalRemAmount => _finalRemAmount;
  String? get finalWalletSatlementAmount => _finalWalletSatlementAmount;
  String? get mandiTaxRate => _mandiTaxRate;
  String? get mandiTaxAmount => _mandiTaxAmount;
  int? get agCommission => _agCommission;
  int? get gst => _gst;
  int? get gstAmount => _gstAmount;
  int? get paymentAdvice => _paymentAdvice;
  dynamic get qvAmount => _qvAmount;
  int? get isInvoice => _isInvoice;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get category => _category;
  dynamic get qualityCategory => _qualityCategory;
  String? get name => _name;
  String? get location => _location;
  String? get fname => _fname;
  int? get salesStatus => _salesStatus;
  String? get gatePassWr => _gatePassWr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['unique_id'] = _uniqueId;
    map['buyer_id'] = _buyerId;
    map['seller_id'] = _sellerId;
    map['seller_cat_id'] = _sellerCatId;
    map['payment_ref_no'] = _paymentRefNo;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['labour_rate'] = _labourRate;
    map['todays_price'] = _todaysPrice;
    map['bid_type'] = _bidType;
    map['mandi_fees'] = _mandiFees;
    map['rent_row_id'] = _rentRowId;
    map['interest_row_id'] = _interestRowId;
    map['finance_id'] = _financeId;
    map['final_mandi_amount'] = _finalMandiAmount;
    map['final_settlment_amount'] = _finalSettlmentAmount;
    map['final_rem_amount'] = _finalRemAmount;
    map['final_wallet_satlement_amount'] = _finalWalletSatlementAmount;
    map['mandi_tax_rate'] = _mandiTaxRate;
    map['mandi_tax_amount'] = _mandiTaxAmount;
    map['ag_commission'] = _agCommission;
    map['gst'] = _gst;
    map['gst_amount'] = _gstAmount;
    map['payment_advice'] = _paymentAdvice;
    map['qv_amount'] = _qvAmount;
    map['is_invoice'] = _isInvoice;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['category'] = _category;
    map['quality_category'] = _qualityCategory;
    map['name'] = _name;
    map['location'] = _location;
    map['fname'] = _fname;
    map['sales_status'] = _salesStatus;
    map['gate_pass_wr'] = _gatePassWr;
    return map;
  }
}
