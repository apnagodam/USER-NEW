class FacetofaceModel {
  FacetofaceModel({
      Deals? deals, 
      String? status, 
      String? message,}){
    _deals = deals;
    _status = status;
    _message = message;
}

  FacetofaceModel.fromJson(dynamic json) {
    _deals = json['deals'] != null ? Deals.fromJson(json['deals']) : null;
    _status = json['status'];
    _message = json['message'];
  }
  Deals? _deals;
  String? _status;
  String? _message;
FacetofaceModel copyWith({  Deals? deals,
  String? status,
  String? message,
}) => FacetofaceModel(  deals: deals ?? _deals,
  status: status ?? _status,
  message: message ?? _message,
);
  Deals? get deals => _deals;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_deals != null) {
      map['deals'] = _deals?.toJson();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class Deals {
  Deals({
      dynamic currentPage, 
      List<facetoData>? data, 
      String? firstPageUrl, 
      dynamic from, 
      dynamic lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      dynamic nextPageUrl, 
      String? path, 
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

  Deals.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(facetoData.fromJson(v));
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
  List<facetoData>? _data;
  String? _firstPageUrl;
  dynamic _from;
  dynamic _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  dynamic _perPage;
  dynamic _prevPageUrl;
  dynamic _to;
  dynamic _total;
Deals copyWith({  dynamic currentPage,
  List<facetoData>? data,
  String? firstPageUrl,
  dynamic from,
  dynamic lastPage,
  String? lastPageUrl,
  List<Links>? links,
  dynamic nextPageUrl,
  String? path,
  dynamic perPage,
  dynamic prevPageUrl,
  dynamic to,
  dynamic total,
}) => Deals(  currentPage: currentPage ?? _currentPage,
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
  List<facetoData>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  dynamic get from => _from;
  dynamic get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
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
  String? _label;
  bool? _active;
Links copyWith({  dynamic url,
  String? label,
  bool? active,
}) => Links(  url: url ?? _url,
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

class facetoData {
  facetoData({
      dynamic id, 
      dynamic contractId, 
      dynamic buyerId, 
      dynamic sellerId, 
      dynamic sellerCatId, 
      String? caseId, 
      dynamic paymentRefNo, 
      String? quantity, 
      String? price, 
      dynamic finalPrice, 
      dynamic labourRate, 
      dynamic todaysPrice, 
      dynamic bidType, 
      dynamic agCommissionRate, 
      dynamic agCommissionAmount,
      dynamic commodityGstPercent, 
      dynamic mandiTaxPercent,
    dynamic mandiFees,
      dynamic finalPerQtlGst, 
      dynamic gst, 
      dynamic gstAmount, 
      dynamic pdf, 
      dynamic paymentStatus, 
      dynamic invoice, 
      dynamic status, 
      String? createdAt, 
      String? updatedAt, 
      String? category, 
      dynamic qualityCategory, 
      String? fname, 
      String? buyerPanNo, 
      String? buyerPhone, 
      String? sellerName, 
      String? sellerPhone, 
      dynamic salesStatus, 
      dynamic location, 
      dynamic bags, 
      dynamic bankSlip, 
      String? commodityImage, 
      dynamic qualityGrade, 
      dynamic dealAmount, 
      dynamic mandiTaxAmount, 
      dynamic finalDealAmount,}){
    _id = id;
    _contractId = contractId;
    _buyerId = buyerId;
    _sellerId = sellerId;
    _sellerCatId = sellerCatId;
    _caseId = caseId;
    _paymentRefNo = paymentRefNo;
    _quantity = quantity;
    _price = price;
    _finalPrice = finalPrice;
    _labourRate = labourRate;
    _todaysPrice = todaysPrice;
    _bidType = bidType;
    _agCommissionRate = agCommissionRate;
    _agCommissionAmount = agCommissionAmount;
    _commodityGstPercent = commodityGstPercent;
    _mandiTaxPercent = mandiTaxPercent;
    _mandiFees = mandiFees;
    _finalPerQtlGst = finalPerQtlGst;
    _gst = gst;
    _gstAmount = gstAmount;
    _pdf = pdf;
    _paymentStatus = paymentStatus;
    _invoice = invoice;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
    _qualityCategory = qualityCategory;
    _fname = fname;
    _buyerPanNo = buyerPanNo;
    _buyerPhone = buyerPhone;
    _sellerName = sellerName;
    _sellerPhone = sellerPhone;
    _salesStatus = salesStatus;
    _location = location;
    _bags = bags;
    _bankSlip = bankSlip;
    _commodityImage = commodityImage;
    _qualityGrade = qualityGrade;
    _dealAmount = dealAmount;
    _mandiTaxAmount = mandiTaxAmount;
    _finalDealAmount = finalDealAmount;
}

  facetoData.fromJson(dynamic json) {
    _id = json['id'];
    _contractId = json['contract_id'];
    _buyerId = json['buyer_id'];
    _sellerId = json['seller_id'];
    _sellerCatId = json['seller_cat_id'];
    _caseId = json['case_id'];
    _paymentRefNo = json['payment_ref_no'];
    _quantity = json['quantity'];
    _price = json['price'];
    _finalPrice = json['final_price'];
    _labourRate = json['labour_rate'];
    _todaysPrice = json['todays_price'];
    _bidType = json['bid_type'];
    _agCommissionRate = json['ag_commission_rate'];
    _agCommissionAmount = json['ag_commission_amount'];
    _commodityGstPercent = json['commodity_gst_percent'];
    _mandiTaxPercent = json['mandi_tax_percent'];
    _mandiFees = json['mandi_fees'];
    _finalPerQtlGst = json['final_per_qtl_gst'];
    _gst = json['gst'];
    _gstAmount = json['gst_amount'];
    _pdf = json['pdf'];
    _paymentStatus = json['payment_status'];
    _invoice = json['invoice'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _category = json['category'];
    _qualityCategory = json['quality_category'];
    _fname = json['fname'];
    _buyerPanNo = json['buyer_pan_no'];
    _buyerPhone = json['buyer_phone'];
    _sellerName = json['seller_name'];
    _sellerPhone = json['seller_phone'];
    _salesStatus = json['sales_status'];
    _location = json['location'];
    _bags = json['bags'];
    _bankSlip = json['Bank_slip'];
    _commodityImage = json['commodity_image'];
    _qualityGrade = json['quality_grade'];
    _dealAmount = json['deal_amount'];
    _mandiTaxAmount = json['mandi_tax_amount'];
    _finalDealAmount = json['final_deal_amount'];
  }
  dynamic _id;
  dynamic _contractId;
  dynamic _buyerId;
  dynamic _sellerId;
  dynamic _sellerCatId;
  String? _caseId;
  dynamic _paymentRefNo;
  String? _quantity;
  String? _price;
  dynamic _finalPrice;
  dynamic _labourRate;
  dynamic _todaysPrice;
  dynamic _bidType;
  dynamic _agCommissionRate;
  dynamic _agCommissionAmount;
  dynamic _commodityGstPercent;
  dynamic _mandiTaxPercent;
  dynamic _mandiFees;
  dynamic _finalPerQtlGst;
  dynamic _gst;
  dynamic _gstAmount;
  dynamic _pdf;
  dynamic _paymentStatus;
  dynamic _invoice;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  String? _category;
  dynamic _qualityCategory;
  String? _fname;
  String? _buyerPanNo;
  String? _buyerPhone;
  String? _sellerName;
  String? _sellerPhone;
  dynamic _salesStatus;
  dynamic _location;
  dynamic _bags;
  dynamic _bankSlip;
  String? _commodityImage;
  dynamic _qualityGrade;
  dynamic _dealAmount;
  dynamic _mandiTaxAmount;
  dynamic _finalDealAmount;
facetoData copyWith({  dynamic id,
  dynamic contractId,
  dynamic buyerId,
  dynamic sellerId,
  dynamic sellerCatId,
  String? caseId,
  dynamic paymentRefNo,
  String? quantity,
  String? price,
  dynamic finalPrice,
  dynamic labourRate,
  dynamic todaysPrice,
  dynamic bidType,
  dynamic agCommissionRate,
  dynamic agCommissionAmount,
  dynamic commodityGstPercent,
  dynamic mandiTaxPercent,
  dynamic mandiFees,
  dynamic finalPerQtlGst,
  dynamic gst,
  dynamic gstAmount,
  dynamic pdf,
  dynamic paymentStatus,
  dynamic invoice,
  dynamic status,
  String? createdAt,
  String? updatedAt,
  String? category,
  dynamic qualityCategory,
  String? fname,
  String? buyerPanNo,
  String? buyerPhone,
  String? sellerName,
  String? sellerPhone,
  dynamic salesStatus,
  dynamic location,
  dynamic bags,
  dynamic bankSlip,
  String? commodityImage,
  dynamic qualityGrade,
  dynamic dealAmount,
  dynamic mandiTaxAmount,
  dynamic finalDealAmount,
}) => facetoData(  id: id ?? _id,
  contractId: contractId ?? _contractId,
  buyerId: buyerId ?? _buyerId,
  sellerId: sellerId ?? _sellerId,
  sellerCatId: sellerCatId ?? _sellerCatId,
  caseId: caseId ?? _caseId,
  paymentRefNo: paymentRefNo ?? _paymentRefNo,
  quantity: quantity ?? _quantity,
  price: price ?? _price,
  finalPrice: finalPrice ?? _finalPrice,
  labourRate: labourRate ?? _labourRate,
  todaysPrice: todaysPrice ?? _todaysPrice,
  bidType: bidType ?? _bidType,
  agCommissionRate: agCommissionRate ?? _agCommissionRate,
  agCommissionAmount: agCommissionAmount ?? _agCommissionAmount,
  commodityGstPercent: commodityGstPercent ?? _commodityGstPercent,
  mandiTaxPercent: mandiTaxPercent ?? _mandiTaxPercent,
  mandiFees: mandiFees ?? _mandiFees,
  finalPerQtlGst: finalPerQtlGst ?? _finalPerQtlGst,
  gst: gst ?? _gst,
  gstAmount: gstAmount ?? _gstAmount,
  pdf: pdf ?? _pdf,
  paymentStatus: paymentStatus ?? _paymentStatus,
  invoice: invoice ?? _invoice,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  category: category ?? _category,
  qualityCategory: qualityCategory ?? _qualityCategory,
  fname: fname ?? _fname,
  buyerPanNo: buyerPanNo ?? _buyerPanNo,
  buyerPhone: buyerPhone ?? _buyerPhone,
  sellerName: sellerName ?? _sellerName,
  sellerPhone: sellerPhone ?? _sellerPhone,
  salesStatus: salesStatus ?? _salesStatus,
  location: location ?? _location,
  bags: bags ?? _bags,
  bankSlip: bankSlip ?? _bankSlip,
  commodityImage: commodityImage ?? _commodityImage,
  qualityGrade: qualityGrade ?? _qualityGrade,
  dealAmount: dealAmount ?? _dealAmount,
  mandiTaxAmount: mandiTaxAmount ?? _mandiTaxAmount,
  finalDealAmount: finalDealAmount ?? _finalDealAmount,
);
  dynamic get id => _id;
  dynamic get contractId => _contractId;
  dynamic get buyerId => _buyerId;
  dynamic get sellerId => _sellerId;
  dynamic get sellerCatId => _sellerCatId;
  String? get caseId => _caseId;
  dynamic get paymentRefNo => _paymentRefNo;
  String? get quantity => _quantity;
  String? get price => _price;
  dynamic get finalPrice => _finalPrice;
  dynamic get labourRate => _labourRate;
  dynamic get todaysPrice => _todaysPrice;
  dynamic get bidType => _bidType;
  dynamic get agCommissionRate => _agCommissionRate;
  dynamic get agCommissionAmount => _agCommissionAmount;
  dynamic get commodityGstPercent => _commodityGstPercent;
  dynamic get mandiTaxPercent => _mandiTaxPercent;
  dynamic get mandiFees => _mandiFees;
  dynamic get finalPerQtlGst => _finalPerQtlGst;
  dynamic get gst => _gst;
  dynamic get gstAmount => _gstAmount;
  dynamic get pdf => _pdf;
  dynamic get paymentStatus => _paymentStatus;
  dynamic get invoice => _invoice;
  dynamic get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get category => _category;
  dynamic get qualityCategory => _qualityCategory;
  String? get fname => _fname;
  String? get buyerPanNo => _buyerPanNo;
  String? get buyerPhone => _buyerPhone;
  String? get sellerName => _sellerName;
  String? get sellerPhone => _sellerPhone;
  dynamic get salesStatus => _salesStatus;
  dynamic get location => _location;
  dynamic get bags => _bags;
  dynamic get bankSlip => _bankSlip;
  String? get commodityImage => _commodityImage;
  dynamic get qualityGrade => _qualityGrade;
  dynamic get dealAmount => _dealAmount;
  dynamic get mandiTaxAmount => _mandiTaxAmount;
  dynamic get finalDealAmount => _finalDealAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['contract_id'] = _contractId;
    map['buyer_id'] = _buyerId;
    map['seller_id'] = _sellerId;
    map['seller_cat_id'] = _sellerCatId;
    map['case_id'] = _caseId;
    map['payment_ref_no'] = _paymentRefNo;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['final_price'] = _finalPrice;
    map['labour_rate'] = _labourRate;
    map['todays_price'] = _todaysPrice;
    map['bid_type'] = _bidType;
    map['ag_commission_rate'] = _agCommissionRate;
    map['ag_commission_amount'] = _agCommissionAmount;
    map['commodity_gst_percent'] = _commodityGstPercent;
    map['mandi_tax_percent'] = _mandiTaxPercent;
    map['mandi_fees'] = _mandiFees;
    map['final_per_qtl_gst'] = _finalPerQtlGst;
    map['gst'] = _gst;
    map['gst_amount'] = _gstAmount;
    map['pdf'] = _pdf;
    map['payment_status'] = _paymentStatus;
    map['invoice'] = _invoice;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['category'] = _category;
    map['quality_category'] = _qualityCategory;
    map['fname'] = _fname;
    map['buyer_pan_no'] = _buyerPanNo;
    map['buyer_phone'] = _buyerPhone;
    map['seller_name'] = _sellerName;
    map['seller_phone'] = _sellerPhone;
    map['sales_status'] = _salesStatus;
    map['location'] = _location;
    map['bags'] = _bags;
    map['Bank_slip'] = _bankSlip;
    map['commodity_image'] = _commodityImage;
    map['quality_grade'] = _qualityGrade;
    map['deal_amount'] = _dealAmount;
    map['mandi_tax_amount'] = _mandiTaxAmount;
    map['final_deal_amount'] = _finalDealAmount;
    return map;
  }

}