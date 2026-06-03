class BiddingModel {
  BiddingModel({
      num? walletStatus, 
      List<DealInfo>? dealInfo, 
      num? selfStatus, 
      dynamic bidClosed,
      dynamic netAmount,
      InventoryInfo? inventoryInfo, 
      String? status, 
      String? message,}){
    _walletStatus = walletStatus;
    _dealInfo = dealInfo;
    _selfStatus = selfStatus;
    _bidClosed = bidClosed;
    _netAmount = netAmount;
    _inventoryInfo = inventoryInfo;
    _status = status;
    _message = message;
}

  BiddingModel.fromJson(dynamic json) {
    _walletStatus = json['wallet_status'];
    if (json['deal_info'] != null) {
      _dealInfo = [];
      json['deal_info'].forEach((v) {
        _dealInfo?.add(DealInfo.fromJson(v));
      });
    }
    _selfStatus = json['self_status'];
    _bidClosed = json['bid_closed'];
    _netAmount = json['net_amount'];
    _inventoryInfo = json['inventory_info'] != null ? InventoryInfo.fromJson(json['inventory_info']) : null;
    _status = json['status'];
    _message = json['message'];
  }
  num? _walletStatus;
  List<DealInfo>? _dealInfo;
  num? _selfStatus;
  dynamic _bidClosed;
  dynamic _netAmount;
  InventoryInfo? _inventoryInfo;
  String? _status;
  String? _message;
BiddingModel copyWith({  num? walletStatus,
  List<DealInfo>? dealInfo,
  num? selfStatus,
  dynamic bidClosed,
  dynamic netAmount,
  InventoryInfo? inventoryInfo,
  String? status,
  String? message,
}) => BiddingModel(  walletStatus: walletStatus ?? _walletStatus,
  dealInfo: dealInfo ?? _dealInfo,
  selfStatus: selfStatus ?? _selfStatus,
  bidClosed: bidClosed ?? _bidClosed,
  netAmount: netAmount ?? _netAmount,
  inventoryInfo: inventoryInfo ?? _inventoryInfo,
  status: status ?? _status,
  message: message ?? _message,
);
  num? get walletStatus => _walletStatus;
  List<DealInfo>? get dealInfo => _dealInfo;
  num? get selfStatus => _selfStatus;
  dynamic get bidClosed => _bidClosed;
  dynamic get netAmount => _netAmount;
  InventoryInfo? get inventoryInfo => _inventoryInfo;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wallet_status'] = _walletStatus;
    if (_dealInfo != null) {
      map['deal_info'] = _dealInfo?.map((v) => v.toJson()).toList();
    }
    map['self_status'] = _selfStatus;
    map['bid_closed'] = _bidClosed;
    map['net_amount'] = _netAmount;
    if (_inventoryInfo != null) {
      map['inventory_info'] = _inventoryInfo?.toJson();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class InventoryInfo {
  InventoryInfo({
      String? category, 
      String? name, 
      dynamic area, 
      num? id, 
      num? userId, 
      String? caseId, 
      num? warehouseId, 
      num? commodity, 
      dynamic weightBridgeNo, 
      String? truckNo, 
      String? stackNo, 
      dynamic lotNo, 
      dynamic netWeight, 
      dynamic type, 
      String? quantity, 
      num? bags, 
      String? sellQuantity, 
      String? price, 
      String? gatePassWr, 
      dynamic qualityCategory, 
      dynamic origin, 
      dynamic image, 
      dynamic file, 
      num? rentRowId, 
      num? interestRowId, 
      String? mandiAmount, 
      String? settlmentAmount, 
      String? remAmount, 
      num? lessOldNegWalletSattlement, 
      String? walletSatlementAmount, 
      num? isLiquidation, 
      num? rentRate, 
      num? salesStatus, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      InvCases? invCases,}){
    _category = category;
    _name = name;
    _area = area;
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
    _invCases = invCases;
}

  InventoryInfo.fromJson(dynamic json) {
    _category = json['category'];
    _name = json['name'];
    _area = json['area'];
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
    _invCases = json['inv_cases'] != null ? InvCases.fromJson(json['inv_cases']) : null;
  }
  String? _category;
  String? _name;
  dynamic _area;
  num? _id;
  num? _userId;
  String? _caseId;
  num? _warehouseId;
  num? _commodity;
  dynamic _weightBridgeNo;
  String? _truckNo;
  String? _stackNo;
  dynamic _lotNo;
  dynamic _netWeight;
  dynamic _type;
  String? _quantity;
  num? _bags;
  String? _sellQuantity;
  String? _price;
  String? _gatePassWr;
  dynamic _qualityCategory;
  dynamic _origin;
  dynamic _image;
  dynamic _file;
  num? _rentRowId;
  num? _interestRowId;
  String? _mandiAmount;
  String? _settlmentAmount;
  String? _remAmount;
  num? _lessOldNegWalletSattlement;
  String? _walletSatlementAmount;
  num? _isLiquidation;
  num? _rentRate;
  num? _salesStatus;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  InvCases? _invCases;
InventoryInfo copyWith({  String? category,
  String? name,
  dynamic area,
  num? id,
  num? userId,
  String? caseId,
  num? warehouseId,
  num? commodity,
  dynamic weightBridgeNo,
  String? truckNo,
  String? stackNo,
  dynamic lotNo,
  dynamic netWeight,
  dynamic type,
  String? quantity,
  num? bags,
  String? sellQuantity,
  String? price,
  String? gatePassWr,
  dynamic qualityCategory,
  dynamic origin,
  dynamic image,
  dynamic file,
  num? rentRowId,
  num? interestRowId,
  String? mandiAmount,
  String? settlmentAmount,
  String? remAmount,
  num? lessOldNegWalletSattlement,
  String? walletSatlementAmount,
  num? isLiquidation,
  num? rentRate,
  num? salesStatus,
  num? status,
  String? createdAt,
  String? updatedAt,
  InvCases? invCases,
}) => InventoryInfo(  category: category ?? _category,
  name: name ?? _name,
  area: area ?? _area,
  id: id ?? _id,
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
  invCases: invCases ?? _invCases,
);
  String? get category => _category;
  String? get name => _name;
  dynamic get area => _area;
  num? get id => _id;
  num? get userId => _userId;
  String? get caseId => _caseId;
  num? get warehouseId => _warehouseId;
  num? get commodity => _commodity;
  dynamic get weightBridgeNo => _weightBridgeNo;
  String? get truckNo => _truckNo;
  String? get stackNo => _stackNo;
  dynamic get lotNo => _lotNo;
  dynamic get netWeight => _netWeight;
  dynamic get type => _type;
  String? get quantity => _quantity;
  num? get bags => _bags;
  String? get sellQuantity => _sellQuantity;
  String? get price => _price;
  String? get gatePassWr => _gatePassWr;
  dynamic get qualityCategory => _qualityCategory;
  dynamic get origin => _origin;
  dynamic get image => _image;
  dynamic get file => _file;
  num? get rentRowId => _rentRowId;
  num? get interestRowId => _interestRowId;
  String? get mandiAmount => _mandiAmount;
  String? get settlmentAmount => _settlmentAmount;
  String? get remAmount => _remAmount;
  num? get lessOldNegWalletSattlement => _lessOldNegWalletSattlement;
  String? get walletSatlementAmount => _walletSatlementAmount;
  num? get isLiquidation => _isLiquidation;
  num? get rentRate => _rentRate;
  num? get salesStatus => _salesStatus;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  InvCases? get invCases => _invCases;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = _category;
    map['name'] = _name;
    map['area'] = _area;
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
    if (_invCases != null) {
      map['inv_cases'] = _invCases?.toJson();
    }
    return map;
  }

}

class InvCases {
  InvCases({
      num? id, 
      num? inventoryId, 
      String? caseId, 
      String? weight, 
      String? invCaseBags, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      List<Qv>? qv,}){
    _id = id;
    _inventoryId = inventoryId;
    _caseId = caseId;
    _weight = weight;
    _invCaseBags = invCaseBags;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _qv = qv;
}

  InvCases.fromJson(dynamic json) {
    _id = json['id'];
    _inventoryId = json['inventory_id'];
    _caseId = json['case_id'];
    _weight = json['weight'];
    _invCaseBags = json['inv_case_bags'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['qv'] != null) {
      _qv = [];
      json['qv'].forEach((v) {
        _qv?.add(Qv.fromJson(v));
      });
    }
  }
  num? _id;
  num? _inventoryId;
  String? _caseId;
  String? _weight;
  String? _invCaseBags;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  List<Qv>? _qv;
InvCases copyWith({  num? id,
  num? inventoryId,
  String? caseId,
  String? weight,
  String? invCaseBags,
  num? status,
  String? createdAt,
  String? updatedAt,
  List<Qv>? qv,
}) => InvCases(  id: id ?? _id,
  inventoryId: inventoryId ?? _inventoryId,
  caseId: caseId ?? _caseId,
  weight: weight ?? _weight,
  invCaseBags: invCaseBags ?? _invCaseBags,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  qv: qv ?? _qv,
);
  num? get id => _id;
  num? get inventoryId => _inventoryId;
  String? get caseId => _caseId;
  String? get weight => _weight;
  String? get invCaseBags => _invCaseBags;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Qv>? get qv => _qv;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['inventory_id'] = _inventoryId;
    map['case_id'] = _caseId;
    map['weight'] = _weight;
    map['inv_case_bags'] = _invCaseBags;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_qv != null) {
      map['qv'] = _qv?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Qv {
  Qv({
      num? id, 
      num? userId, 
      String? caseId, 
      num? parameterId, 
      String? value, 
      String? createdAt, 
      String? updatedAt, 
      QualityParameters? qualityParameters,}){
    _id = id;
    _userId = userId;
    _caseId = caseId;
    _parameterId = parameterId;
    _value = value;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _qualityParameters = qualityParameters;
}

  Qv.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _caseId = json['case_id'];
    _parameterId = json['parameter_id'];
    _value = json['value'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _qualityParameters = json['quality_parameters'] != null ? QualityParameters.fromJson(json['quality_parameters']) : null;
  }
  num? _id;
  num? _userId;
  String? _caseId;
  num? _parameterId;
  String? _value;
  String? _createdAt;
  String? _updatedAt;
  QualityParameters? _qualityParameters;
Qv copyWith({  num? id,
  num? userId,
  String? caseId,
  num? parameterId,
  String? value,
  String? createdAt,
  String? updatedAt,
  QualityParameters? qualityParameters,
}) => Qv(  id: id ?? _id,
  userId: userId ?? _userId,
  caseId: caseId ?? _caseId,
  parameterId: parameterId ?? _parameterId,
  value: value ?? _value,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  qualityParameters: qualityParameters ?? _qualityParameters,
);
  num? get id => _id;
  num? get userId => _userId;
  String? get caseId => _caseId;
  num? get parameterId => _parameterId;
  String? get value => _value;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  QualityParameters? get qualityParameters => _qualityParameters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['case_id'] = _caseId;
    map['parameter_id'] = _parameterId;
    map['value'] = _value;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_qualityParameters != null) {
      map['quality_parameters'] = _qualityParameters?.toJson();
    }
    return map;
  }

}

class QualityParameters {
  QualityParameters({
      num? id, 
      String? parameter, 
      num? status, 
      String? createdAt, 
      String? updatedAt,}){
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
  num? _id;
  String? _parameter;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
QualityParameters copyWith({  num? id,
  String? parameter,
  num? status,
  String? createdAt,
  String? updatedAt,
}) => QualityParameters(  id: id ?? _id,
  parameter: parameter ?? _parameter,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get parameter => _parameter;
  num? get status => _status;
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

class DealInfo {
  DealInfo({
      num? id, 
      num? buySellId, 
      num? userId, 
      num? price, 
      num? isSecure, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      String? fname, 
      dynamic userWalletAmount,}){
    _id = id;
    _buySellId = buySellId;
    _userId = userId;
    _price = price;
    _isSecure = isSecure;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _fname = fname;
    _userWalletAmount = userWalletAmount;
}

  DealInfo.fromJson(dynamic json) {
    _id = json['id'];
    _buySellId = json['buy_sell_id'];
    _userId = json['user_id'];
    _price = json['price'];
    _isSecure = json['is_secure'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _fname = json['fname'];
    _userWalletAmount = json['user_wallet_amount'];
  }
  num? _id;
  num? _buySellId;
  num? _userId;
  num? _price;
  num? _isSecure;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _fname;
  dynamic _userWalletAmount;
DealInfo copyWith({  num? id,
  num? buySellId,
  num? userId,
  num? price,
  num? isSecure,
  num? status,
  String? createdAt,
  String? updatedAt,
  String? fname,
  dynamic userWalletAmount,
}) => DealInfo(  id: id ?? _id,
  buySellId: buySellId ?? _buySellId,
  userId: userId ?? _userId,
  price: price ?? _price,
  isSecure: isSecure ?? _isSecure,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  fname: fname ?? _fname,
  userWalletAmount: userWalletAmount ?? _userWalletAmount,
);
  num? get id => _id;
  num? get buySellId => _buySellId;
  num? get userId => _userId;
  num? get price => _price;
  num? get isSecure => _isSecure;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get fname => _fname;
  dynamic get userWalletAmount => _userWalletAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['buy_sell_id'] = _buySellId;
    map['user_id'] = _userId;
    map['price'] = _price;
    map['is_secure'] = _isSecure;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['fname'] = _fname;
    map['user_wallet_amount'] = _userWalletAmount;
    return map;
  }

}