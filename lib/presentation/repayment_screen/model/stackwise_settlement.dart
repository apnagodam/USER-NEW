class StackwiseSettlement {
  StackwiseSettlement({
      List<StackwiseData>? data, 
      String? status, 
      String? message,}){
    _data = data;
    _status = status;
    _message = message;
}

  StackwiseSettlement.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(StackwiseData.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<StackwiseData>? _data;
  dynamic _status;
  String? _message;
StackwiseSettlement copyWith({  List<StackwiseData>? data,
  String? status,
  String? message,
}) => StackwiseSettlement(  data: data ?? _data,
  status: status ?? _status,
  message: message ?? _message,
);
  List<StackwiseData>? get data => _data;
  dynamic get status => _status;
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

class StackwiseData {
  StackwiseData({
      dynamic id, 
      dynamic userId, 
      dynamic caseId, 
      dynamic warehouseId, 
      dynamic commodity, 
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
      String? mandiAmount, 
      String? settlmentAmount, 
      String? remAmount, 
      dynamic lessOldNegWalletSattlement, 
      String? walletSatlementAmount, 
      dynamic isLiquidation, 
      dynamic rentRate, 
      dynamic salesStatus, 
      dynamic status, 
      String? createdAt, 
      String? updatedAt,
      dynamic stackRentCount,
      dynamic financeCount, 
      String? outstanding, 
      String? rentAmount, 
      String? loanAmount, 
      String? interestAmount,}){
    _id = id;
    _userId = userId;
    _caseId = caseId;
    _warehouseId = warehouseId;
    _commodity = commodity;
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
    _stackRentCount = stackRentCount;
    _financeCount = financeCount;
    _outstanding = outstanding;
    _rentAmount = rentAmount;
    _loanAmount = loanAmount;
    _interestAmount = interestAmount;
}

  StackwiseData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _caseId = json['case_id'];
    _warehouseId = json['warehouse_id'];
    _commodity = json['commodity'];
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
    _stackRentCount = json['stack_rent_count'];
    _financeCount = json['finance_count'];
    _outstanding = json['outstanding'];
    _rentAmount = json['rent_amount'];
    _loanAmount = json['loan_amount'];
    _interestAmount = json['interest_amount'];
  }
  dynamic _id;
  dynamic _userId;
  dynamic _caseId;
  dynamic _warehouseId;
  dynamic _commodity;
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
  String? _mandiAmount;
  String? _settlmentAmount;
  String? _remAmount;
  dynamic _lessOldNegWalletSattlement;
  String? _walletSatlementAmount;
  dynamic _isLiquidation;
  dynamic _rentRate;
  dynamic _salesStatus;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _stackRentCount;
  dynamic _financeCount;
  String? _outstanding;
  String? _rentAmount;
  String? _loanAmount;
  String? _interestAmount;
StackwiseData copyWith({  dynamic id,
  dynamic userId,
  dynamic caseId,
  dynamic warehouseId,
  dynamic commodity,
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
  String? mandiAmount,
  String? settlmentAmount,
  String? remAmount,
  dynamic lessOldNegWalletSattlement,
  String? walletSatlementAmount,
  dynamic isLiquidation,
  dynamic rentRate,
  dynamic salesStatus,
  dynamic status,
  String? createdAt,
  String? updatedAt,
  dynamic stackRentCount,
  dynamic financeCount,
  String? outstanding,
  String? rentAmount,
  String? loanAmount,
  String? interestAmount,
}) => StackwiseData(  id: id ?? _id,
  userId: userId ?? _userId,
  caseId: caseId ?? _caseId,
  warehouseId: warehouseId ?? _warehouseId,
  commodity: commodity ?? _commodity,
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
  lessOldNegWalletSattlement: lessOldNegWalletSattlement ?? _lessOldNegWalletSattlement,
  walletSatlementAmount: walletSatlementAmount ?? _walletSatlementAmount,
  isLiquidation: isLiquidation ?? _isLiquidation,
  rentRate: rentRate ?? _rentRate,
  salesStatus: salesStatus ?? _salesStatus,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  stackRentCount: stackRentCount ?? _stackRentCount,
  financeCount: financeCount ?? _financeCount,
  outstanding: outstanding ?? _outstanding,
  rentAmount: rentAmount ?? _rentAmount,
  loanAmount: loanAmount ?? _loanAmount,
  interestAmount: interestAmount ?? _interestAmount,
);
  dynamic get id => _id;
  dynamic get userId => _userId;
  dynamic get caseId => _caseId;
  dynamic get warehouseId => _warehouseId;
  dynamic get commodity => _commodity;
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
  String? get mandiAmount => _mandiAmount;
  String? get settlmentAmount => _settlmentAmount;
  String? get remAmount => _remAmount;
  dynamic get lessOldNegWalletSattlement => _lessOldNegWalletSattlement;
  String? get walletSatlementAmount => _walletSatlementAmount;
  dynamic get isLiquidation => _isLiquidation;
  dynamic get rentRate => _rentRate;
  dynamic get salesStatus => _salesStatus;
  dynamic get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get stackRentCount => _stackRentCount;
  dynamic get financeCount => _financeCount;
  String? get outstanding => _outstanding;
  String? get rentAmount => _rentAmount;
  String? get loanAmount => _loanAmount;
  String? get interestAmount => _interestAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['case_id'] = _caseId;
    map['warehouse_id'] = _warehouseId;
    map['commodity'] = _commodity;
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
    map['stack_rent_count'] = _stackRentCount;
    map['finance_count'] = _financeCount;
    map['outstanding'] = _outstanding;
    map['rent_amount'] = _rentAmount;
    map['loan_amount'] = _loanAmount;
    map['interest_amount'] = _interestAmount;
    return map;
  }

}