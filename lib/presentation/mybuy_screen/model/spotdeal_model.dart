class SpotdealModel {
  SpotdealModel({
      Deals? deals,}){
    _deals = deals;
}

  SpotdealModel.fromJson(dynamic json) {
    _deals = json['deals'] != null ? Deals.fromJson(json['deals']) : null;
  }
  Deals? _deals;
SpotdealModel copyWith({  Deals? deals,
}) => SpotdealModel(  deals: deals ?? _deals,
);
  Deals? get deals => _deals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_deals != null) {
      map['deals'] = _deals?.toJson();
    }
    return map;
  }

}

class Deals {
  Deals({
      int? currentPage, 
      List<SpotData>? data,}){
    _currentPage = currentPage;
    _data = data;
}

  Deals.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SpotData.fromJson(v));
      });
    }
  }
  int? _currentPage;
  List<SpotData>? _data;
Deals copyWith({  int? currentPage,
  List<SpotData>? data,
}) => Deals(  currentPage: currentPage ?? _currentPage,
  data: data ?? _data,
);
  int? get currentPage => _currentPage;
  List<SpotData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SpotData {
  SpotData({
      int? id, 
      int? contractId, 
      int? buyerId, 
      int? sellerId, 
      int? sellerCatId, 
      String? caseId, 
      dynamic paymentRefNo, 
      String? quantity, 
      String? price, 
      int? finalPrice, 
      dynamic labourRate, 
      dynamic todaysPrice, 
      int? bidType, 
      int? agCommissionRate, 
      String? agCommissionAmount, 
      int? commodityGstPercent, 
      int? mandiTaxPercent, 
      int? mandiFees, 
      dynamic finalPerQtlGst, 
      int? gst, 
      int? gstAmount, 
      dynamic pdf, 
      int? paymentStatus, 
      int? invoice, 
      int? status, 
      String? createdAt, 
      String? updatedAt, 
      String? userAmount, 
      String? agCommissionPercent, 
      String? mandiPrice, 
      String? mandiTaxRate, 
      String? dealFinalPrice, 
      int? totalGstAmount, 
      int? gstRate, 
      int? noOfBags, 
      String? category, 
      dynamic qualityCategory, 
      String? fname, 
      String? buyerPanNo, 
      String? buyerPhone, 
      String? sellerName, 
      String? sellerPhone, 
      int? salesStatus, 
      String? location, 
      dynamic bags, 
      dynamic bankSlip, 
      String? commodityImage, 
      dynamic qualityGrade,}){
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
    _userAmount = userAmount;
    _agCommissionPercent = agCommissionPercent;
    _mandiPrice = mandiPrice;
    _mandiTaxRate = mandiTaxRate;
    _dealFinalPrice = dealFinalPrice;
    _totalGstAmount = totalGstAmount;
    _gstRate = gstRate;
    _noOfBags = noOfBags;
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
}

  SpotData.fromJson(dynamic json) {
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
    _userAmount = json['user_amount'];
    _agCommissionPercent = json['ag_commission_percent'];
    _mandiPrice = json['mandi_price'];
    _mandiTaxRate = json['mandi_tax_rate'];
    _dealFinalPrice = json['deal_final_price'];
    _totalGstAmount = json['total_gst_amount'];
    _gstRate = json['gst_rate'];
    _noOfBags = json['no_of_bags'];
    _category = json['category'];
    _qualityCategory = json['quality_category'];
    _fname = json['fname'];
    _buyerPanNo = json['buyer_pan_no'];
    _buyerPhone = json['buyer_phone'];
    _sellerName = json['seller_name'];
    _sellerPhone = json['seller_phone'];
    _salesStatus = json['sales_status'];
    _location = json['location'];
    _bags = json['bags'] ?? "";
    _bankSlip = json['Bank_slip'];
    _commodityImage = json['commodity_image'];
    _qualityGrade = json['quality_grade'];
  }
  int? _id;
  int? _contractId;
  int? _buyerId;
  int? _sellerId;
  int? _sellerCatId;
  String? _caseId;
  dynamic _paymentRefNo;
  String? _quantity;
  String? _price;
  int? _finalPrice;
  dynamic _labourRate;
  dynamic _todaysPrice;
  int? _bidType;
  int? _agCommissionRate;
  String? _agCommissionAmount;
  int? _commodityGstPercent;
  int? _mandiTaxPercent;
  int? _mandiFees;
  dynamic _finalPerQtlGst;
  int? _gst;
  int? _gstAmount;
  dynamic _pdf;
  int? _paymentStatus;
  int? _invoice;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _userAmount;
  String? _agCommissionPercent;
  String? _mandiPrice;
  String? _mandiTaxRate;
  String? _dealFinalPrice;
  dynamic _totalGstAmount;
  int? _gstRate;
  int? _noOfBags;
  String? _category;
  dynamic _qualityCategory;
  String? _fname;
  String? _buyerPanNo;
  String? _buyerPhone;
  String? _sellerName;
  String? _sellerPhone;
  int? _salesStatus;
  String? _location;
  dynamic _bags;
  dynamic _bankSlip;
  String? _commodityImage;
  dynamic _qualityGrade;
SpotData copyWith({  int? id,
  int? contractId,
  int? buyerId,
  int? sellerId,
  int? sellerCatId,
  String? caseId,
  dynamic paymentRefNo,
  String? quantity,
  String? price,
  int? finalPrice,
  dynamic labourRate,
  dynamic todaysPrice,
  int? bidType,
  int? agCommissionRate,
  String? agCommissionAmount,
  int? commodityGstPercent,
  int? mandiTaxPercent,
  int? mandiFees,
  dynamic finalPerQtlGst,
  int? gst,
  int? gstAmount,
  dynamic pdf,
  int? paymentStatus,
  int? invoice,
  int? status,
  String? createdAt,
  String? updatedAt,
  String? userAmount,
  String? agCommissionPercent,
  String? mandiPrice,
  String? mandiTaxRate,
  String? dealFinalPrice,
  int? totalGstAmount,
  int? gstRate,
  int? noOfBags,
  String? category,
  dynamic qualityCategory,
  String? fname,
  String? buyerPanNo,
  String? buyerPhone,
  String? sellerName,
  String? sellerPhone,
  int? salesStatus,
  String? location,
  dynamic bags,
  dynamic bankSlip,
  String? commodityImage,
  dynamic qualityGrade,
}) => SpotData(  id: id ?? _id,
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
  userAmount: userAmount ?? _userAmount,
  agCommissionPercent: agCommissionPercent ?? _agCommissionPercent,
  mandiPrice: mandiPrice ?? _mandiPrice,
  mandiTaxRate: mandiTaxRate ?? _mandiTaxRate,
  dealFinalPrice: dealFinalPrice ?? _dealFinalPrice,
  totalGstAmount: totalGstAmount ?? _totalGstAmount,
  gstRate: gstRate ?? _gstRate,
  noOfBags: noOfBags ?? _noOfBags,
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
);
  int? get id => _id;
  int? get contractId => _contractId;
  int? get buyerId => _buyerId;
  int? get sellerId => _sellerId;
  int? get sellerCatId => _sellerCatId;
  String? get caseId => _caseId;
  dynamic get paymentRefNo => _paymentRefNo;
  String? get quantity => _quantity;
  String? get price => _price;
  int? get finalPrice => _finalPrice;
  dynamic get labourRate => _labourRate;
  dynamic get todaysPrice => _todaysPrice;
  int? get bidType => _bidType;
  int? get agCommissionRate => _agCommissionRate;
  String? get agCommissionAmount => _agCommissionAmount;
  int? get commodityGstPercent => _commodityGstPercent;
  int? get mandiTaxPercent => _mandiTaxPercent;
  int? get mandiFees => _mandiFees;
  dynamic get finalPerQtlGst => _finalPerQtlGst;
  int? get gst => _gst;
  int? get gstAmount => _gstAmount;
  dynamic get pdf => _pdf;
  int? get paymentStatus => _paymentStatus;
  int? get invoice => _invoice;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get userAmount => _userAmount;
  String? get agCommissionPercent => _agCommissionPercent;
  String? get mandiPrice => _mandiPrice;
  String? get mandiTaxRate => _mandiTaxRate;
  String? get dealFinalPrice => _dealFinalPrice;
  dynamic get totalGstAmount => _totalGstAmount;
  int? get gstRate => _gstRate;
  int? get noOfBags => _noOfBags;
  String? get category => _category;
  dynamic get qualityCategory => _qualityCategory;
  String? get fname => _fname;
  String? get buyerPanNo => _buyerPanNo;
  String? get buyerPhone => _buyerPhone;
  String? get sellerName => _sellerName;
  String? get sellerPhone => _sellerPhone;
  int? get salesStatus => _salesStatus;
  String? get location => _location;
  dynamic get bags => _bags;
  dynamic get bankSlip => _bankSlip;
  String? get commodityImage => _commodityImage;
  dynamic get qualityGrade => _qualityGrade;

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
    map['user_amount'] = _userAmount;
    map['ag_commission_percent'] = _agCommissionPercent;
    map['mandi_price'] = _mandiPrice;
    map['mandi_tax_rate'] = _mandiTaxRate;
    map['deal_final_price'] = _dealFinalPrice;
    map['total_gst_amount'] = _totalGstAmount;
    map['gst_rate'] = _gstRate;
    map['no_of_bags'] = _noOfBags;
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
    return map;
  }

}