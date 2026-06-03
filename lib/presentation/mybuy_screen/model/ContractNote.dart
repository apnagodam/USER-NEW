
class ContractNote {
  ContractNote({
      Data? data, 
      String? status, 
      String? message,}){
    _data = data;
    _status = status;
    _message = message;
}

  ContractNote.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _status = json['status'];
    _message = json['message'];
  }
  Data? _data;
  String? _status;
  String? _message;
ContractNote copyWith({  Data? data,
  String? status,
  String? message,
}) => ContractNote(  data: data ?? _data,
  status: status ?? _status,
  message: message ?? _message,
);
  Data? get data => _data;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

/// id : 2944
/// unique_id : 2652
/// buyer_id : 50
/// seller_id : 8148
/// seller_cat_id : 9733
/// payment_ref_no : null
/// quantity : "33.75"
/// price : "6080.0"
/// labour_rate : 0
/// todays_price : null
/// bid_type : 1
/// mandi_fees : null
/// rent_row_id : null
/// interest_row_id : null
/// finance_id : null
/// final_mandi_amount : "205200.00"
/// final_settlment_amount : "1208.27"
/// final_rem_amount : "203991.73"
/// final_wallet_satlement_amount : "1208.27"
/// mandi_tax_rate : "0"
/// mandi_tax_amount : "0"
/// ag_commission : 0
/// gst : 0
/// gst_amount : 0
/// payment_advice : 0
/// qv_amount : 0
/// is_invoice : 0
/// status : 3
/// created_at : "2023-10-18 11:29:55"
/// updated_at : "2023-10-18 11:29:55"
/// buyer_name : "Shri Bhagwati Udyog"
/// buyer_phone : "9414082755"
/// pancard_no : "ADBFS3438E"
/// mandi_license : "0"
/// seller_name : "Chiraag Logistics Private Limited"
/// seller_phone : "5020001138"
/// category : "Desi Gram"
/// warehouse : "Anita Gupta Warehouse , Bikaner (Bigga)"
/// warehouse_id : 45
/// warehouse_code : "080703"
/// location : "BIGGA"
/// total_bags : 65
/// quality_category : null
/// sales_status : 2
/// gate_pass_wr : "12688"
/// truck_no : "Rj 07gc 1552"
/// case_id : "IN-080703-DESI GRAM-29042023-8155-12688"
/// mandi_samiti_name : "SRI DUNGARGARH"

class Data {
  Data({
      num? id, 
      num? uniqueId, 
      num? buyerId, 
      num? sellerId, 
      num? sellerCatId, 
      dynamic paymentRefNo, 
      String? quantity, 
      String? price, 
      num? labourRate, 
      dynamic todaysPrice, 
      num? bidType, 
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
      num? agCommission, 
      num? gst, 
      num? gstAmount, 
      num? paymentAdvice, 
      num? qvAmount, 
      num? isInvoice, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      String? buyerName, 
      String? buyerPhone, 
      String? pancardNo, 
      String? mandiLicense, 
      String? sellerName, 
      String? sellerPhone, 
      String? category, 
      String? warehouse, 
      num? warehouseId, 
      String? warehouseCode, 
      String? location, 
      num? totalBags, 
      dynamic qualityCategory, 
      num? salesStatus, 
      String? gatePassWr, 
      String? truckNo, 
      String? caseId, 
      String? mandiSamitiName,}){
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
    _buyerName = buyerName;
    _buyerPhone = buyerPhone;
    _pancardNo = pancardNo;
    _mandiLicense = mandiLicense;
    _sellerName = sellerName;
    _sellerPhone = sellerPhone;
    _category = category;
    _warehouse = warehouse;
    _warehouseId = warehouseId;
    _warehouseCode = warehouseCode;
    _location = location;
    _totalBags = totalBags;
    _qualityCategory = qualityCategory;
    _salesStatus = salesStatus;
    _gatePassWr = gatePassWr;
    _truckNo = truckNo;
    _caseId = caseId;
    _mandiSamitiName = mandiSamitiName;
}

  Data.fromJson(dynamic json) {
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
    _buyerName = json['buyer_name'];
    _buyerPhone = json['buyer_phone'];
    _pancardNo = json['pancard_no'];
    _mandiLicense = json['mandi_license'];
    _sellerName = json['seller_name'];
    _sellerPhone = json['seller_phone'];
    _category = json['category'];
    _warehouse = json['warehouse'];
    _warehouseId = json['warehouse_id'];
    _warehouseCode = json['warehouse_code'];
    _location = json['location'];
    _totalBags = json['total_bags'];
    _qualityCategory = json['quality_category'];
    _salesStatus = json['sales_status'];
    _gatePassWr = json['gate_pass_wr'];
    _truckNo = json['truck_no'];
    _caseId = json['case_id'];
    _mandiSamitiName = json['mandi_samiti_name'];
  }
  num? _id;
  num? _uniqueId;
  num? _buyerId;
  num? _sellerId;
  num? _sellerCatId;
  dynamic _paymentRefNo;
  String? _quantity;
  String? _price;
  num? _labourRate;
  dynamic _todaysPrice;
  num? _bidType;
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
  num? _agCommission;
  num? _gst;
  num? _gstAmount;
  num? _paymentAdvice;
  num? _qvAmount;
  num? _isInvoice;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _buyerName;
  String? _buyerPhone;
  String? _pancardNo;
  String? _mandiLicense;
  String? _sellerName;
  String? _sellerPhone;
  String? _category;
  String? _warehouse;
  num? _warehouseId;
  String? _warehouseCode;
  String? _location;
  num? _totalBags;
  dynamic _qualityCategory;
  num? _salesStatus;
  String? _gatePassWr;
  String? _truckNo;
  String? _caseId;
  String? _mandiSamitiName;
Data copyWith({  num? id,
  num? uniqueId,
  num? buyerId,
  num? sellerId,
  num? sellerCatId,
  dynamic paymentRefNo,
  String? quantity,
  String? price,
  num? labourRate,
  dynamic todaysPrice,
  num? bidType,
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
  num? agCommission,
  num? gst,
  num? gstAmount,
  num? paymentAdvice,
  num? qvAmount,
  num? isInvoice,
  num? status,
  String? createdAt,
  String? updatedAt,
  String? buyerName,
  String? buyerPhone,
  String? pancardNo,
  String? mandiLicense,
  String? sellerName,
  String? sellerPhone,
  String? category,
  String? warehouse,
  num? warehouseId,
  String? warehouseCode,
  String? location,
  num? totalBags,
  dynamic qualityCategory,
  num? salesStatus,
  String? gatePassWr,
  String? truckNo,
  String? caseId,
  String? mandiSamitiName,
}) => Data(  id: id ?? _id,
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
  finalWalletSatlementAmount: finalWalletSatlementAmount ?? _finalWalletSatlementAmount,
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
  buyerName: buyerName ?? _buyerName,
  buyerPhone: buyerPhone ?? _buyerPhone,
  pancardNo: pancardNo ?? _pancardNo,
  mandiLicense: mandiLicense ?? _mandiLicense,
  sellerName: sellerName ?? _sellerName,
  sellerPhone: sellerPhone ?? _sellerPhone,
  category: category ?? _category,
  warehouse: warehouse ?? _warehouse,
  warehouseId: warehouseId ?? _warehouseId,
  warehouseCode: warehouseCode ?? _warehouseCode,
  location: location ?? _location,
  totalBags: totalBags ?? _totalBags,
  qualityCategory: qualityCategory ?? _qualityCategory,
  salesStatus: salesStatus ?? _salesStatus,
  gatePassWr: gatePassWr ?? _gatePassWr,
  truckNo: truckNo ?? _truckNo,
  caseId: caseId ?? _caseId,
  mandiSamitiName: mandiSamitiName ?? _mandiSamitiName,
);
  num? get id => _id;
  num? get uniqueId => _uniqueId;
  num? get buyerId => _buyerId;
  num? get sellerId => _sellerId;
  num? get sellerCatId => _sellerCatId;
  dynamic get paymentRefNo => _paymentRefNo;
  String? get quantity => _quantity;
  String? get price => _price;
  num? get labourRate => _labourRate;
  dynamic get todaysPrice => _todaysPrice;
  num? get bidType => _bidType;
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
  num? get agCommission => _agCommission;
  num? get gst => _gst;
  num? get gstAmount => _gstAmount;
  num? get paymentAdvice => _paymentAdvice;
  num? get qvAmount => _qvAmount;
  num? get isInvoice => _isInvoice;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get buyerName => _buyerName;
  String? get buyerPhone => _buyerPhone;
  String? get pancardNo => _pancardNo;
  String? get mandiLicense => _mandiLicense;
  String? get sellerName => _sellerName;
  String? get sellerPhone => _sellerPhone;
  String? get category => _category;
  String? get warehouse => _warehouse;
  num? get warehouseId => _warehouseId;
  String? get warehouseCode => _warehouseCode;
  String? get location => _location;
  num? get totalBags => _totalBags;
  dynamic get qualityCategory => _qualityCategory;
  num? get salesStatus => _salesStatus;
  String? get gatePassWr => _gatePassWr;
  String? get truckNo => _truckNo;
  String? get caseId => _caseId;
  String? get mandiSamitiName => _mandiSamitiName;

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
    map['buyer_name'] = _buyerName;
    map['buyer_phone'] = _buyerPhone;
    map['pancard_no'] = _pancardNo;
    map['mandi_license'] = _mandiLicense;
    map['seller_name'] = _sellerName;
    map['seller_phone'] = _sellerPhone;
    map['category'] = _category;
    map['warehouse'] = _warehouse;
    map['warehouse_id'] = _warehouseId;
    map['warehouse_code'] = _warehouseCode;
    map['location'] = _location;
    map['total_bags'] = _totalBags;
    map['quality_category'] = _qualityCategory;
    map['sales_status'] = _salesStatus;
    map['gate_pass_wr'] = _gatePassWr;
    map['truck_no'] = _truckNo;
    map['case_id'] = _caseId;
    map['mandi_samiti_name'] = _mandiSamitiName;
    return map;
  }

}