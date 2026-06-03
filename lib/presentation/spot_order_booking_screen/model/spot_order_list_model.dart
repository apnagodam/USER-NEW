class SpotOrderListModel {
  SpotOrderListModel({
      List<SpotOrderModel>? data, 
      int? status, 
      String? message,}){
    _data = data;
    _status = status;
    _message = message;
}

  SpotOrderListModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SpotOrderModel.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<SpotOrderModel>? _data;
  int? _status;
  String? _message;
SpotOrderListModel copyWith({  List<SpotOrderModel>? data,
  int? status,
  String? message,
}) => SpotOrderListModel(  data: data ?? _data,
  status: status ?? _status,
  message: message ?? _message,
);
  List<SpotOrderModel>? get data => _data;
  int? get status => _status;
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

class SpotOrderModel {
  SpotOrderModel({
      int? id, 
      String? orderId, 
      int? lpType, 
      int? sellerUserId, 
      int? lpUserId, 
      int? buyerUserId, 
      dynamic buyerUserId2, 
      int? corporateUserId, 
      int? terminalId, 
      int? vehicleId, 
      int? inventoryId, 
      dynamic lpTotalKm, 
      dynamic pqpk, 
      String? requestTime, 
      String? acceptTime, 
      String? userAmount, 
      dynamic buyerAmount, 
      dynamic lpAmount, 
      String? agCommissionPercent, 
      String? agCommissionAmount, 
      int? lpCommissionPercent, 
      String? lpCommissionAmount, 
      dynamic lpCancelReason, 
      dynamic userCancelReason, 
      dynamic cancelledBy, 
      int? userPaymentStatus, 
      int? lpPaymentStatus, 
      dynamic lpLong, 
      int? borkerCharge, 
      dynamic arrivalTime, 
      int? requestStatus, 
      int? bookingStatus, 
      int? priceAccept, 
      int? tripStatus, 
      int? seen, 
      dynamic conectorName, 
      dynamic labourContractor, 
      dynamic tharesarContractorId, 
      dynamic transpoterContractorId, 
      dynamic intentionPrice, 
      int? intentionWeight, 
      dynamic intentionOtp, 
      dynamic intentionExpiryDate, 
      dynamic token, 
      int? isIntention, 
      int? status, 
      String? createdAt, 
      String? updatedAt, 
      Warehouse? warehouse, 
      List<Qv>? qv, 
      Inventory? inventory, 
      Orderprice? orderprice, 
      Orderlocation? orderlocation, 
      Orderweight? orderweight,}){
    _id = id;
    _orderId = orderId;
    _lpType = lpType;
    _sellerUserId = sellerUserId;
    _lpUserId = lpUserId;
    _buyerUserId = buyerUserId;
    _buyerUserId2 = buyerUserId2;
    _corporateUserId = corporateUserId;
    _terminalId = terminalId;
    _vehicleId = vehicleId;
    _inventoryId = inventoryId;
    _lpTotalKm = lpTotalKm;
    _pqpk = pqpk;
    _requestTime = requestTime;
    _acceptTime = acceptTime;
    _userAmount = userAmount;
    _buyerAmount = buyerAmount;
    _lpAmount = lpAmount;
    _agCommissionPercent = agCommissionPercent;
    _agCommissionAmount = agCommissionAmount;
    _lpCommissionPercent = lpCommissionPercent;
    _lpCommissionAmount = lpCommissionAmount;
    _lpCancelReason = lpCancelReason;
    _userCancelReason = userCancelReason;
    _cancelledBy = cancelledBy;
    _userPaymentStatus = userPaymentStatus;
    _lpPaymentStatus = lpPaymentStatus;
    _lpLong = lpLong;
    _borkerCharge = borkerCharge;
    _arrivalTime = arrivalTime;
    _requestStatus = requestStatus;
    _bookingStatus = bookingStatus;
    _priceAccept = priceAccept;
    _tripStatus = tripStatus;
    _seen = seen;
    _conectorName = conectorName;
    _labourContractor = labourContractor;
    _tharesarContractorId = tharesarContractorId;
    _transpoterContractorId = transpoterContractorId;
    _intentionPrice = intentionPrice;
    _intentionWeight = intentionWeight;
    _intentionOtp = intentionOtp;
    _intentionExpiryDate = intentionExpiryDate;
    _token = token;
    _isIntention = isIntention;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _warehouse = warehouse;
    _qv = qv;
    _inventory = inventory;
    _orderprice = orderprice;
    _orderlocation = orderlocation;
    _orderweight = orderweight;
}

  SpotOrderModel.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _lpType = json['lp_type'];
    _sellerUserId = json['seller_user_id'];
    _lpUserId = json['lp_user_id'];
    _buyerUserId = json['buyer_user_id'];
    _buyerUserId2 = json['buyer_user_id_2'];
    _corporateUserId = json['corporate_user_id'];
    _terminalId = json['terminal_id'];
    _vehicleId = json['vehicle_id'];
    _inventoryId = json['inventory_id'];
    _lpTotalKm = json['lp_total_km'];
    _pqpk = json['pqpk'];
    _requestTime = json['request_time'];
    _acceptTime = json['accept_time'];
    _userAmount = json['user_amount'];
    _buyerAmount = json['buyer_amount'];
    _lpAmount = json['lp_amount'];
    _agCommissionPercent = json['ag_commission_percent'];
    _agCommissionAmount = json['ag_commission_amount'];
    _lpCommissionPercent = json['lp_commission_percent'];
    _lpCommissionAmount = json['lp_commission_amount'];
    _lpCancelReason = json['lp_cancel_reason'];
    _userCancelReason = json['user_cancel_reason'];
    _cancelledBy = json['cancelled_by'];
    _userPaymentStatus = json['user_payment_status'];
    _lpPaymentStatus = json['lp_payment_status'];
    _lpLong = json['lp_long'];
    _borkerCharge = json['borker_charge'];
    _arrivalTime = json['arrival_time'];
    _requestStatus = json['request_status'];
    _bookingStatus = json['booking_status'];
    _priceAccept = json['price_accept'];
    _tripStatus = json['trip_status'];
    _seen = json['seen'];
    _conectorName = json['conector_name'];
    _labourContractor = json['labour_contractor'];
    _tharesarContractorId = json['tharesar_contractor_id'];
    _transpoterContractorId = json['transpoter_contractor_id'];
    _intentionPrice = json['intention_price'];
    _intentionWeight = json['intention_weight'];
    _intentionOtp = json['intention_otp'];
    _intentionExpiryDate = json['intention_expiry_date'];
    _token = json['token'];
    _isIntention = json['is_intention'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _warehouse = json['warehouse'] != null ? Warehouse.fromJson(json['warehouse']) : null;
    if (json['qv'] != null) {
      _qv = [];
      json['qv'].forEach((v) {
        _qv?.add(Qv.fromJson(v));
      });
    }
    _inventory = json['inventory'] != null ? Inventory.fromJson(json['inventory']) : null;
    _orderprice = json['orderprice'] != null ? Orderprice.fromJson(json['orderprice']) : null;
    _orderlocation = json['orderlocation'] != null ? Orderlocation.fromJson(json['orderlocation']) : null;
    _orderweight = json['orderweight'] != null ? Orderweight.fromJson(json['orderweight']) : null;
  }
  int? _id;
  String? _orderId;
  int? _lpType;
  int? _sellerUserId;
  int? _lpUserId;
  int? _buyerUserId;
  dynamic _buyerUserId2;
  int? _corporateUserId;
  int? _terminalId;
  int? _vehicleId;
  int? _inventoryId;
  dynamic _lpTotalKm;
  dynamic _pqpk;
  String? _requestTime;
  String? _acceptTime;
  String? _userAmount;
  dynamic _buyerAmount;
  dynamic _lpAmount;
  String? _agCommissionPercent;
  String? _agCommissionAmount;
  int? _lpCommissionPercent;
  String? _lpCommissionAmount;
  dynamic _lpCancelReason;
  dynamic _userCancelReason;
  dynamic _cancelledBy;
  int? _userPaymentStatus;
  int? _lpPaymentStatus;
  dynamic _lpLong;
  int? _borkerCharge;
  dynamic _arrivalTime;
  int? _requestStatus;
  int? _bookingStatus;
  int? _priceAccept;
  int? _tripStatus;
  int? _seen;
  dynamic _conectorName;
  dynamic _labourContractor;
  dynamic _tharesarContractorId;
  dynamic _transpoterContractorId;
  dynamic _intentionPrice;
  int? _intentionWeight;
  dynamic _intentionOtp;
  dynamic _intentionExpiryDate;
  dynamic _token;
  int? _isIntention;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  Warehouse? _warehouse;
  List<Qv>? _qv;
  Inventory? _inventory;
  Orderprice? _orderprice;
  Orderlocation? _orderlocation;
  Orderweight? _orderweight;
SpotOrderModel copyWith({  int? id,
  String? orderId,
  int? lpType,
  int? sellerUserId,
  int? lpUserId,
  int? buyerUserId,
  dynamic buyerUserId2,
  int? corporateUserId,
  int? terminalId,
  int? vehicleId,
  int? inventoryId,
  dynamic lpTotalKm,
  dynamic pqpk,
  String? requestTime,
  String? acceptTime,
  String? userAmount,
  dynamic buyerAmount,
  dynamic lpAmount,
  String? agCommissionPercent,
  String? agCommissionAmount,
  int? lpCommissionPercent,
  String? lpCommissionAmount,
  dynamic lpCancelReason,
  dynamic userCancelReason,
  dynamic cancelledBy,
  int? userPaymentStatus,
  int? lpPaymentStatus,
  dynamic lpLong,
  int? borkerCharge,
  dynamic arrivalTime,
  int? requestStatus,
  int? bookingStatus,
  int? priceAccept,
  int? tripStatus,
  int? seen,
  dynamic conectorName,
  dynamic labourContractor,
  dynamic tharesarContractorId,
  dynamic transpoterContractorId,
  dynamic intentionPrice,
  int? intentionWeight,
  dynamic intentionOtp,
  dynamic intentionExpiryDate,
  dynamic token,
  int? isIntention,
  int? status,
  String? createdAt,
  String? updatedAt,
  Warehouse? warehouse,
  List<Qv>? qv,
  Inventory? inventory,
  Orderprice? orderprice,
  Orderlocation? orderlocation,
  Orderweight? orderweight,
}) => SpotOrderModel(  id: id ?? _id,
  orderId: orderId ?? _orderId,
  lpType: lpType ?? _lpType,
  sellerUserId: sellerUserId ?? _sellerUserId,
  lpUserId: lpUserId ?? _lpUserId,
  buyerUserId: buyerUserId ?? _buyerUserId,
  buyerUserId2: buyerUserId2 ?? _buyerUserId2,
  corporateUserId: corporateUserId ?? _corporateUserId,
  terminalId: terminalId ?? _terminalId,
  vehicleId: vehicleId ?? _vehicleId,
  inventoryId: inventoryId ?? _inventoryId,
  lpTotalKm: lpTotalKm ?? _lpTotalKm,
  pqpk: pqpk ?? _pqpk,
  requestTime: requestTime ?? _requestTime,
  acceptTime: acceptTime ?? _acceptTime,
  userAmount: userAmount ?? _userAmount,
  buyerAmount: buyerAmount ?? _buyerAmount,
  lpAmount: lpAmount ?? _lpAmount,
  agCommissionPercent: agCommissionPercent ?? _agCommissionPercent,
  agCommissionAmount: agCommissionAmount ?? _agCommissionAmount,
  lpCommissionPercent: lpCommissionPercent ?? _lpCommissionPercent,
  lpCommissionAmount: lpCommissionAmount ?? _lpCommissionAmount,
  lpCancelReason: lpCancelReason ?? _lpCancelReason,
  userCancelReason: userCancelReason ?? _userCancelReason,
  cancelledBy: cancelledBy ?? _cancelledBy,
  userPaymentStatus: userPaymentStatus ?? _userPaymentStatus,
  lpPaymentStatus: lpPaymentStatus ?? _lpPaymentStatus,
  lpLong: lpLong ?? _lpLong,
  borkerCharge: borkerCharge ?? _borkerCharge,
  arrivalTime: arrivalTime ?? _arrivalTime,
  requestStatus: requestStatus ?? _requestStatus,
  bookingStatus: bookingStatus ?? _bookingStatus,
  priceAccept: priceAccept ?? _priceAccept,
  tripStatus: tripStatus ?? _tripStatus,
  seen: seen ?? _seen,
  conectorName: conectorName ?? _conectorName,
  labourContractor: labourContractor ?? _labourContractor,
  tharesarContractorId: tharesarContractorId ?? _tharesarContractorId,
  transpoterContractorId: transpoterContractorId ?? _transpoterContractorId,
  intentionPrice: intentionPrice ?? _intentionPrice,
  intentionWeight: intentionWeight ?? _intentionWeight,
  intentionOtp: intentionOtp ?? _intentionOtp,
  intentionExpiryDate: intentionExpiryDate ?? _intentionExpiryDate,
  token: token ?? _token,
  isIntention: isIntention ?? _isIntention,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  warehouse: warehouse ?? _warehouse,
  qv: qv ?? _qv,
  inventory: inventory ?? _inventory,
  orderprice: orderprice ?? _orderprice,
  orderlocation: orderlocation ?? _orderlocation,
  orderweight: orderweight ?? _orderweight,
);
  int? get id => _id;
  String? get orderId => _orderId;
  int? get lpType => _lpType;
  int? get sellerUserId => _sellerUserId;
  int? get lpUserId => _lpUserId;
  int? get buyerUserId => _buyerUserId;
  dynamic get buyerUserId2 => _buyerUserId2;
  int? get corporateUserId => _corporateUserId;
  int? get terminalId => _terminalId;
  int? get vehicleId => _vehicleId;
  int? get inventoryId => _inventoryId;
  dynamic get lpTotalKm => _lpTotalKm;
  dynamic get pqpk => _pqpk;
  String? get requestTime => _requestTime;
  String? get acceptTime => _acceptTime;
  String? get userAmount => _userAmount;
  dynamic get buyerAmount => _buyerAmount;
  dynamic get lpAmount => _lpAmount;
  String? get agCommissionPercent => _agCommissionPercent;
  String? get agCommissionAmount => _agCommissionAmount;
  int? get lpCommissionPercent => _lpCommissionPercent;
  String? get lpCommissionAmount => _lpCommissionAmount;
  dynamic get lpCancelReason => _lpCancelReason;
  dynamic get userCancelReason => _userCancelReason;
  dynamic get cancelledBy => _cancelledBy;
  int? get userPaymentStatus => _userPaymentStatus;
  int? get lpPaymentStatus => _lpPaymentStatus;
  dynamic get lpLong => _lpLong;
  int? get borkerCharge => _borkerCharge;
  dynamic get arrivalTime => _arrivalTime;
  int? get requestStatus => _requestStatus;
  int? get bookingStatus => _bookingStatus;
  int? get priceAccept => _priceAccept;
  int? get tripStatus => _tripStatus;
  int? get seen => _seen;
  dynamic get conectorName => _conectorName;
  dynamic get labourContractor => _labourContractor;
  dynamic get tharesarContractorId => _tharesarContractorId;
  dynamic get transpoterContractorId => _transpoterContractorId;
  dynamic get intentionPrice => _intentionPrice;
  int? get intentionWeight => _intentionWeight;
  dynamic get intentionOtp => _intentionOtp;
  dynamic get intentionExpiryDate => _intentionExpiryDate;
  dynamic get token => _token;
  int? get isIntention => _isIntention;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Warehouse? get warehouse => _warehouse;
  List<Qv>? get qv => _qv;
  Inventory? get inventory => _inventory;
  Orderprice? get orderprice => _orderprice;
  Orderlocation? get orderlocation => _orderlocation;
  Orderweight? get orderweight => _orderweight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['lp_type'] = _lpType;
    map['seller_user_id'] = _sellerUserId;
    map['lp_user_id'] = _lpUserId;
    map['buyer_user_id'] = _buyerUserId;
    map['buyer_user_id_2'] = _buyerUserId2;
    map['corporate_user_id'] = _corporateUserId;
    map['terminal_id'] = _terminalId;
    map['vehicle_id'] = _vehicleId;
    map['inventory_id'] = _inventoryId;
    map['lp_total_km'] = _lpTotalKm;
    map['pqpk'] = _pqpk;
    map['request_time'] = _requestTime;
    map['accept_time'] = _acceptTime;
    map['user_amount'] = _userAmount;
    map['buyer_amount'] = _buyerAmount;
    map['lp_amount'] = _lpAmount;
    map['ag_commission_percent'] = _agCommissionPercent;
    map['ag_commission_amount'] = _agCommissionAmount;
    map['lp_commission_percent'] = _lpCommissionPercent;
    map['lp_commission_amount'] = _lpCommissionAmount;
    map['lp_cancel_reason'] = _lpCancelReason;
    map['user_cancel_reason'] = _userCancelReason;
    map['cancelled_by'] = _cancelledBy;
    map['user_payment_status'] = _userPaymentStatus;
    map['lp_payment_status'] = _lpPaymentStatus;
    map['lp_long'] = _lpLong;
    map['borker_charge'] = _borkerCharge;
    map['arrival_time'] = _arrivalTime;
    map['request_status'] = _requestStatus;
    map['booking_status'] = _bookingStatus;
    map['price_accept'] = _priceAccept;
    map['trip_status'] = _tripStatus;
    map['seen'] = _seen;
    map['conector_name'] = _conectorName;
    map['labour_contractor'] = _labourContractor;
    map['tharesar_contractor_id'] = _tharesarContractorId;
    map['transpoter_contractor_id'] = _transpoterContractorId;
    map['intention_price'] = _intentionPrice;
    map['intention_weight'] = _intentionWeight;
    map['intention_otp'] = _intentionOtp;
    map['intention_expiry_date'] = _intentionExpiryDate;
    map['token'] = _token;
    map['is_intention'] = _isIntention;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_warehouse != null) {
      map['warehouse'] = _warehouse?.toJson();
    }
    if (_qv != null) {
      map['qv'] = _qv?.map((v) => v.toJson()).toList();
    }
    if (_inventory != null) {
      map['inventory'] = _inventory?.toJson();
    }
    if (_orderprice != null) {
      map['orderprice'] = _orderprice?.toJson();
    }
    if (_orderlocation != null) {
      map['orderlocation'] = _orderlocation?.toJson();
    }
    if (_orderweight != null) {
      map['orderweight'] = _orderweight?.toJson();
    }
    return map;
  }

}

class Orderweight {
  Orderweight({
      int? id, 
      int? orderId, 
      dynamic weightType, 
      String? weight, 
      int? noOfBags, 
      String? commodityWeightImg, 
      String? fristKantaParchi, 
      String? secondKantaParchi, 
      String? kantaParchiPath, 
      dynamic connectorPaymentMode, 
      dynamic connectorTotalAmount, 
      dynamic thresherPaymentMode, 
      dynamic thresherTotalPayment, 
      dynamic labourPaymentMode, 
      dynamic labourTotalPayment, 
      dynamic transporterTotalPayment, 
      int? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _orderId = orderId;
    _weightType = weightType;
    _weight = weight;
    _noOfBags = noOfBags;
    _commodityWeightImg = commodityWeightImg;
    _fristKantaParchi = fristKantaParchi;
    _secondKantaParchi = secondKantaParchi;
    _kantaParchiPath = kantaParchiPath;
    _connectorPaymentMode = connectorPaymentMode;
    _connectorTotalAmount = connectorTotalAmount;
    _thresherPaymentMode = thresherPaymentMode;
    _thresherTotalPayment = thresherTotalPayment;
    _labourPaymentMode = labourPaymentMode;
    _labourTotalPayment = labourTotalPayment;
    _transporterTotalPayment = transporterTotalPayment;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Orderweight.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _weightType = json['weight_type'];
    _weight = json['weight'];
    _noOfBags = json['no_of_bags'];
    _commodityWeightImg = json['commodity_weight_img'];
    _fristKantaParchi = json['frist_kanta_parchi'];
    _secondKantaParchi = json['second_kanta_parchi'];
    _kantaParchiPath = json['kanta_parchi_path'];
    _connectorPaymentMode = json['connector_payment_mode'];
    _connectorTotalAmount = json['connector_total_amount'];
    _thresherPaymentMode = json['thresher_payment_mode'];
    _thresherTotalPayment = json['thresher_total_payment'];
    _labourPaymentMode = json['labour_payment_mode'];
    _labourTotalPayment = json['labour_total_payment'];
    _transporterTotalPayment = json['transporter_total_payment'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _orderId;
  dynamic _weightType;
  String? _weight;
  int? _noOfBags;
  String? _commodityWeightImg;
  String? _fristKantaParchi;
  String? _secondKantaParchi;
  String? _kantaParchiPath;
  dynamic _connectorPaymentMode;
  dynamic _connectorTotalAmount;
  dynamic _thresherPaymentMode;
  dynamic _thresherTotalPayment;
  dynamic _labourPaymentMode;
  dynamic _labourTotalPayment;
  dynamic _transporterTotalPayment;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
Orderweight copyWith({  int? id,
  int? orderId,
  dynamic weightType,
  String? weight,
  int? noOfBags,
  String? commodityWeightImg,
  String? fristKantaParchi,
  String? secondKantaParchi,
  String? kantaParchiPath,
  dynamic connectorPaymentMode,
  dynamic connectorTotalAmount,
  dynamic thresherPaymentMode,
  dynamic thresherTotalPayment,
  dynamic labourPaymentMode,
  dynamic labourTotalPayment,
  dynamic transporterTotalPayment,
  int? status,
  String? createdAt,
  String? updatedAt,
}) => Orderweight(  id: id ?? _id,
  orderId: orderId ?? _orderId,
  weightType: weightType ?? _weightType,
  weight: weight ?? _weight,
  noOfBags: noOfBags ?? _noOfBags,
  commodityWeightImg: commodityWeightImg ?? _commodityWeightImg,
  fristKantaParchi: fristKantaParchi ?? _fristKantaParchi,
  secondKantaParchi: secondKantaParchi ?? _secondKantaParchi,
  kantaParchiPath: kantaParchiPath ?? _kantaParchiPath,
  connectorPaymentMode: connectorPaymentMode ?? _connectorPaymentMode,
  connectorTotalAmount: connectorTotalAmount ?? _connectorTotalAmount,
  thresherPaymentMode: thresherPaymentMode ?? _thresherPaymentMode,
  thresherTotalPayment: thresherTotalPayment ?? _thresherTotalPayment,
  labourPaymentMode: labourPaymentMode ?? _labourPaymentMode,
  labourTotalPayment: labourTotalPayment ?? _labourTotalPayment,
  transporterTotalPayment: transporterTotalPayment ?? _transporterTotalPayment,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  int? get orderId => _orderId;
  dynamic get weightType => _weightType;
  String? get weight => _weight;
  int? get noOfBags => _noOfBags;
  String? get commodityWeightImg => _commodityWeightImg;
  String? get fristKantaParchi => _fristKantaParchi;
  String? get secondKantaParchi => _secondKantaParchi;
  String? get kantaParchiPath => _kantaParchiPath;
  dynamic get connectorPaymentMode => _connectorPaymentMode;
  dynamic get connectorTotalAmount => _connectorTotalAmount;
  dynamic get thresherPaymentMode => _thresherPaymentMode;
  dynamic get thresherTotalPayment => _thresherTotalPayment;
  dynamic get labourPaymentMode => _labourPaymentMode;
  dynamic get labourTotalPayment => _labourTotalPayment;
  dynamic get transporterTotalPayment => _transporterTotalPayment;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['weight_type'] = _weightType;
    map['weight'] = _weight;
    map['no_of_bags'] = _noOfBags;
    map['commodity_weight_img'] = _commodityWeightImg;
    map['frist_kanta_parchi'] = _fristKantaParchi;
    map['second_kanta_parchi'] = _secondKantaParchi;
    map['kanta_parchi_path'] = _kantaParchiPath;
    map['connector_payment_mode'] = _connectorPaymentMode;
    map['connector_total_amount'] = _connectorTotalAmount;
    map['thresher_payment_mode'] = _thresherPaymentMode;
    map['thresher_total_payment'] = _thresherTotalPayment;
    map['labour_payment_mode'] = _labourPaymentMode;
    map['labour_total_payment'] = _labourTotalPayment;
    map['transporter_total_payment'] = _transporterTotalPayment;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Orderlocation {
  Orderlocation({
      int? id, 
      int? orderId, 
      dynamic lpLat, 
      dynamic lpLong, 
      String? userLat, 
      String? userLong, 
      String? terminalLat, 
      String? terminalLong, 
      int? lpToUserKm, 
      int? userToTerminalKm, 
      int? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _orderId = orderId;
    _lpLat = lpLat;
    _lpLong = lpLong;
    _userLat = userLat;
    _userLong = userLong;
    _terminalLat = terminalLat;
    _terminalLong = terminalLong;
    _lpToUserKm = lpToUserKm;
    _userToTerminalKm = userToTerminalKm;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Orderlocation.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _lpLat = json['lp_lat'];
    _lpLong = json['lp_long'];
    _userLat = json['user_lat'];
    _userLong = json['user_long'];
    _terminalLat = json['terminal_lat'];
    _terminalLong = json['terminal_long'];
    _lpToUserKm = json['lp_to_user_km'];
    _userToTerminalKm = json['user_to_terminal_km'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _orderId;
  dynamic _lpLat;
  dynamic _lpLong;
  String? _userLat;
  String? _userLong;
  String? _terminalLat;
  String? _terminalLong;
  int? _lpToUserKm;
  int? _userToTerminalKm;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
Orderlocation copyWith({  int? id,
  int? orderId,
  dynamic lpLat,
  dynamic lpLong,
  String? userLat,
  String? userLong,
  String? terminalLat,
  String? terminalLong,
  int? lpToUserKm,
  int? userToTerminalKm,
  int? status,
  String? createdAt,
  String? updatedAt,
}) => Orderlocation(  id: id ?? _id,
  orderId: orderId ?? _orderId,
  lpLat: lpLat ?? _lpLat,
  lpLong: lpLong ?? _lpLong,
  userLat: userLat ?? _userLat,
  userLong: userLong ?? _userLong,
  terminalLat: terminalLat ?? _terminalLat,
  terminalLong: terminalLong ?? _terminalLong,
  lpToUserKm: lpToUserKm ?? _lpToUserKm,
  userToTerminalKm: userToTerminalKm ?? _userToTerminalKm,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  int? get orderId => _orderId;
  dynamic get lpLat => _lpLat;
  dynamic get lpLong => _lpLong;
  String? get userLat => _userLat;
  String? get userLong => _userLong;
  String? get terminalLat => _terminalLat;
  String? get terminalLong => _terminalLong;
  int? get lpToUserKm => _lpToUserKm;
  int? get userToTerminalKm => _userToTerminalKm;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['lp_lat'] = _lpLat;
    map['lp_long'] = _lpLong;
    map['user_lat'] = _userLat;
    map['user_long'] = _userLong;
    map['terminal_lat'] = _terminalLat;
    map['terminal_long'] = _terminalLong;
    map['lp_to_user_km'] = _lpToUserKm;
    map['user_to_terminal_km'] = _userToTerminalKm;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Orderprice {
  Orderprice({
      int? id, 
      int? orderId, 
      int? corporatePrice, 
      String? takeHomePrice, 
      int? subPrice, 
      String? finalPrice, 
      String? priceVariation, 
      dynamic moisture, 
      dynamic broken, 
      dynamic thin, 
      dynamic fm, 
      dynamic tcw, 
      dynamic tikki, 
      dynamic bagsType, 
      dynamic bagsPrice, 
      dynamic qualityGrade, 
      String? labourQtlPrice, 
      String? qtlTransportPrice, 
      String? corporateBuyerPrice, 
      String? mandiTaxRate, 
      String? mandiPrice, 
      int? bardanaPrice, 
      int? gst,
      dynamic gstAmount,
      int? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _orderId = orderId;
    _corporatePrice = corporatePrice;
    _takeHomePrice = takeHomePrice;
    _subPrice = subPrice;
    _finalPrice = finalPrice;
    _priceVariation = priceVariation;
    _moisture = moisture;
    _broken = broken;
    _thin = thin;
    _fm = fm;
    _tcw = tcw;
    _tikki = tikki;
    _bagsType = bagsType;
    _bagsPrice = bagsPrice;
    _qualityGrade = qualityGrade;
    _labourQtlPrice = labourQtlPrice;
    _qtlTransportPrice = qtlTransportPrice;
    _corporateBuyerPrice = corporateBuyerPrice;
    _mandiTaxRate = mandiTaxRate;
    _mandiPrice = mandiPrice;
    _bardanaPrice = bardanaPrice;
    _gst = gst;
    _gstAmount = gstAmount;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Orderprice.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _corporatePrice = json['corporate_price'];
    _takeHomePrice = json['take_home_price'];
    _subPrice = json['sub_price'];
    _finalPrice = json['final_price'];
    _priceVariation = json['price_variation'];
    _moisture = json['moisture'];
    _broken = json['broken'];
    _thin = json['thin'];
    _fm = json['fm'];
    _tcw = json['tcw'];
    _tikki = json['tikki'];
    _bagsType = json['bags_type'];
    _bagsPrice = json['bags_price'];
    _qualityGrade = json['quality_grade'];
    _labourQtlPrice = json['labour_qtl_price'];
    _qtlTransportPrice = json['qtl_transport_price'];
    _corporateBuyerPrice = json['corporate_buyer_price'];
    _mandiTaxRate = json['mandi_tax_rate'];
    _mandiPrice = json['mandi_price'];
    _bardanaPrice = json['bardana_price'];
    _gst = json['gst'];
    _gstAmount = json['gst_amount'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _orderId;
  int? _corporatePrice;
  String? _takeHomePrice;
  int? _subPrice;
  String? _finalPrice;
  String? _priceVariation;
  dynamic _moisture;
  dynamic _broken;
  dynamic _thin;
  dynamic _fm;
  dynamic _tcw;
  dynamic _tikki;
  dynamic _bagsType;
  dynamic _bagsPrice;
  dynamic _qualityGrade;
  String? _labourQtlPrice;
  String? _qtlTransportPrice;
  String? _corporateBuyerPrice;
  String? _mandiTaxRate;
  String? _mandiPrice;
  int? _bardanaPrice;
  int? _gst;
  dynamic _gstAmount;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
Orderprice copyWith({  int? id,
  int? orderId,
  int? corporatePrice,
  String? takeHomePrice,
  int? subPrice,
  String? finalPrice,
  String? priceVariation,
  dynamic moisture,
  dynamic broken,
  dynamic thin,
  dynamic fm,
  dynamic tcw,
  dynamic tikki,
  dynamic bagsType,
  dynamic bagsPrice,
  dynamic qualityGrade,
  String? labourQtlPrice,
  String? qtlTransportPrice,
  String? corporateBuyerPrice,
  String? mandiTaxRate,
  String? mandiPrice,
  int? bardanaPrice,
  int? gst,
  dynamic gstAmount,
  int? status,
  String? createdAt,
  String? updatedAt,
}) => Orderprice(  id: id ?? _id,
  orderId: orderId ?? _orderId,
  corporatePrice: corporatePrice ?? _corporatePrice,
  takeHomePrice: takeHomePrice ?? _takeHomePrice,
  subPrice: subPrice ?? _subPrice,
  finalPrice: finalPrice ?? _finalPrice,
  priceVariation: priceVariation ?? _priceVariation,
  moisture: moisture ?? _moisture,
  broken: broken ?? _broken,
  thin: thin ?? _thin,
  fm: fm ?? _fm,
  tcw: tcw ?? _tcw,
  tikki: tikki ?? _tikki,
  bagsType: bagsType ?? _bagsType,
  bagsPrice: bagsPrice ?? _bagsPrice,
  qualityGrade: qualityGrade ?? _qualityGrade,
  labourQtlPrice: labourQtlPrice ?? _labourQtlPrice,
  qtlTransportPrice: qtlTransportPrice ?? _qtlTransportPrice,
  corporateBuyerPrice: corporateBuyerPrice ?? _corporateBuyerPrice,
  mandiTaxRate: mandiTaxRate ?? _mandiTaxRate,
  mandiPrice: mandiPrice ?? _mandiPrice,
  bardanaPrice: bardanaPrice ?? _bardanaPrice,
  gst: gst ?? _gst,
  gstAmount: gstAmount ?? _gstAmount,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  int? get orderId => _orderId;
  int? get corporatePrice => _corporatePrice;
  String? get takeHomePrice => _takeHomePrice;
  int? get subPrice => _subPrice;
  String? get finalPrice => _finalPrice;
  String? get priceVariation => _priceVariation;
  dynamic get moisture => _moisture;
  dynamic get broken => _broken;
  dynamic get thin => _thin;
  dynamic get fm => _fm;
  dynamic get tcw => _tcw;
  dynamic get tikki => _tikki;
  dynamic get bagsType => _bagsType;
  dynamic get bagsPrice => _bagsPrice;
  dynamic get qualityGrade => _qualityGrade;
  String? get labourQtlPrice => _labourQtlPrice;
  String? get qtlTransportPrice => _qtlTransportPrice;
  String? get corporateBuyerPrice => _corporateBuyerPrice;
  String? get mandiTaxRate => _mandiTaxRate;
  String? get mandiPrice => _mandiPrice;
  int? get bardanaPrice => _bardanaPrice;
  int? get gst => _gst;
  dynamic get gstAmount => _gstAmount;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['corporate_price'] = _corporatePrice;
    map['take_home_price'] = _takeHomePrice;
    map['sub_price'] = _subPrice;
    map['final_price'] = _finalPrice;
    map['price_variation'] = _priceVariation;
    map['moisture'] = _moisture;
    map['broken'] = _broken;
    map['thin'] = _thin;
    map['fm'] = _fm;
    map['tcw'] = _tcw;
    map['tikki'] = _tikki;
    map['bags_type'] = _bagsType;
    map['bags_price'] = _bagsPrice;
    map['quality_grade'] = _qualityGrade;
    map['labour_qtl_price'] = _labourQtlPrice;
    map['qtl_transport_price'] = _qtlTransportPrice;
    map['corporate_buyer_price'] = _corporateBuyerPrice;
    map['mandi_tax_rate'] = _mandiTaxRate;
    map['mandi_price'] = _mandiPrice;
    map['bardana_price'] = _bardanaPrice;
    map['gst'] = _gst;
    map['gst_amount'] = _gstAmount;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Inventory {
  Inventory({
      int? id, 
      dynamic dealUserType, 
      int? userId, 
      dynamic warehouseId, 
      int? commodity, 
      String? location, 
      dynamic state, 
      dynamic type, 
      String? quantity, 
      String? price, 
      dynamic qualityCategory, 
      dynamic sellQuantity, 
      dynamic image, 
      String? commodityImage, 
      dynamic bankSlip, 
      String? commodityImagePath, 
      int? salesStatus, 
      String? liveLatitude, 
      String? liveLongitude, 
      String? dealType, 
      dynamic qualityGrade, 
      dynamic bags, 
      dynamic notes, 
      String? farmerMoisture, 
      String? farmerDana, 
      String? farmerTikki, 
      int? status, 
      String? paymentMode, 
      String? createdAt, 
      String? updatedAt, 
      Category? category,}){
    _id = id;
    _dealUserType = dealUserType;
    _userId = userId;
    _warehouseId = warehouseId;
    _commodity = commodity;
    _location = location;
    _state = state;
    _type = type;
    _quantity = quantity;
    _price = price;
    _qualityCategory = qualityCategory;
    _sellQuantity = sellQuantity;
    _image = image;
    _commodityImage = commodityImage;
    _bankSlip = bankSlip;
    _commodityImagePath = commodityImagePath;
    _salesStatus = salesStatus;
    _liveLatitude = liveLatitude;
    _liveLongitude = liveLongitude;
    _dealType = dealType;
    _qualityGrade = qualityGrade;
    _bags = bags;
    _notes = notes;
    _farmerMoisture = farmerMoisture;
    _farmerDana = farmerDana;
    _farmerTikki = farmerTikki;
    _status = status;
    _paymentMode = paymentMode;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
}

  Inventory.fromJson(dynamic json) {
    _id = json['id'];
    _dealUserType = json['deal_user_type'];
    _userId = json['user_id'];
    _warehouseId = json['warehouse_id'];
    _commodity = json['commodity'];
    _location = json['location'];
    _state = json['state'];
    _type = json['type'];
    _quantity = json['quantity'];
    _price = json['price'];
    _qualityCategory = json['quality_category'];
    _sellQuantity = json['sell_quantity'];
    _image = json['image'];
    _commodityImage = json['commodity_image'];
    _bankSlip = json['Bank_slip'];
    _commodityImagePath = json['commodity_image_path'];
    _salesStatus = json['sales_status'];
    _liveLatitude = json['live_latitude'];
    _liveLongitude = json['live_longitude'];
    _dealType = json['Deal_Type'];
    _qualityGrade = json['quality_grade'];
    _bags = json['bags'];
    _notes = json['notes'];
    _farmerMoisture = json['farmer_moisture'];
    _farmerDana = json['farmer_dana'];
    _farmerTikki = json['farmer_tikki'];
    _status = json['status'];
    _paymentMode = json['Payment_mode'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  int? _id;
  dynamic _dealUserType;
  int? _userId;
  dynamic _warehouseId;
  int? _commodity;
  String? _location;
  dynamic _state;
  dynamic _type;
  String? _quantity;
  String? _price;
  dynamic _qualityCategory;
  dynamic _sellQuantity;
  dynamic _image;
  String? _commodityImage;
  dynamic _bankSlip;
  String? _commodityImagePath;
  int? _salesStatus;
  String? _liveLatitude;
  String? _liveLongitude;
  String? _dealType;
  dynamic _qualityGrade;
  dynamic _bags;
  dynamic _notes;
  String? _farmerMoisture;
  String? _farmerDana;
  String? _farmerTikki;
  int? _status;
  String? _paymentMode;
  String? _createdAt;
  String? _updatedAt;
  Category? _category;
Inventory copyWith({  int? id,
  dynamic dealUserType,
  int? userId,
  dynamic warehouseId,
  int? commodity,
  String? location,
  dynamic state,
  dynamic type,
  String? quantity,
  String? price,
  dynamic qualityCategory,
  dynamic sellQuantity,
  dynamic image,
  String? commodityImage,
  dynamic bankSlip,
  String? commodityImagePath,
  int? salesStatus,
  String? liveLatitude,
  String? liveLongitude,
  String? dealType,
  dynamic qualityGrade,
  dynamic bags,
  dynamic notes,
  String? farmerMoisture,
  String? farmerDana,
  String? farmerTikki,
  int? status,
  String? paymentMode,
  String? createdAt,
  String? updatedAt,
  Category? category,
}) => Inventory(  id: id ?? _id,
  dealUserType: dealUserType ?? _dealUserType,
  userId: userId ?? _userId,
  warehouseId: warehouseId ?? _warehouseId,
  commodity: commodity ?? _commodity,
  location: location ?? _location,
  state: state ?? _state,
  type: type ?? _type,
  quantity: quantity ?? _quantity,
  price: price ?? _price,
  qualityCategory: qualityCategory ?? _qualityCategory,
  sellQuantity: sellQuantity ?? _sellQuantity,
  image: image ?? _image,
  commodityImage: commodityImage ?? _commodityImage,
  bankSlip: bankSlip ?? _bankSlip,
  commodityImagePath: commodityImagePath ?? _commodityImagePath,
  salesStatus: salesStatus ?? _salesStatus,
  liveLatitude: liveLatitude ?? _liveLatitude,
  liveLongitude: liveLongitude ?? _liveLongitude,
  dealType: dealType ?? _dealType,
  qualityGrade: qualityGrade ?? _qualityGrade,
  bags: bags ?? _bags,
  notes: notes ?? _notes,
  farmerMoisture: farmerMoisture ?? _farmerMoisture,
  farmerDana: farmerDana ?? _farmerDana,
  farmerTikki: farmerTikki ?? _farmerTikki,
  status: status ?? _status,
  paymentMode: paymentMode ?? _paymentMode,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  category: category ?? _category,
);
  int? get id => _id;
  dynamic get dealUserType => _dealUserType;
  int? get userId => _userId;
  dynamic get warehouseId => _warehouseId;
  int? get commodity => _commodity;
  String? get location => _location;
  dynamic get state => _state;
  dynamic get type => _type;
  String? get quantity => _quantity;
  String? get price => _price;
  dynamic get qualityCategory => _qualityCategory;
  dynamic get sellQuantity => _sellQuantity;
  dynamic get image => _image;
  String? get commodityImage => _commodityImage;
  dynamic get bankSlip => _bankSlip;
  String? get commodityImagePath => _commodityImagePath;
  int? get salesStatus => _salesStatus;
  String? get liveLatitude => _liveLatitude;
  String? get liveLongitude => _liveLongitude;
  String? get dealType => _dealType;
  dynamic get qualityGrade => _qualityGrade;
  dynamic get bags => _bags;
  dynamic get notes => _notes;
  String? get farmerMoisture => _farmerMoisture;
  String? get farmerDana => _farmerDana;
  String? get farmerTikki => _farmerTikki;
  int? get status => _status;
  String? get paymentMode => _paymentMode;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Category? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['deal_user_type'] = _dealUserType;
    map['user_id'] = _userId;
    map['warehouse_id'] = _warehouseId;
    map['commodity'] = _commodity;
    map['location'] = _location;
    map['state'] = _state;
    map['type'] = _type;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['quality_category'] = _qualityCategory;
    map['sell_quantity'] = _sellQuantity;
    map['image'] = _image;
    map['commodity_image'] = _commodityImage;
    map['Bank_slip'] = _bankSlip;
    map['commodity_image_path'] = _commodityImagePath;
    map['sales_status'] = _salesStatus;
    map['live_latitude'] = _liveLatitude;
    map['live_longitude'] = _liveLongitude;
    map['Deal_Type'] = _dealType;
    map['quality_grade'] = _qualityGrade;
    map['bags'] = _bags;
    map['notes'] = _notes;
    map['farmer_moisture'] = _farmerMoisture;
    map['farmer_dana'] = _farmerDana;
    map['farmer_tikki'] = _farmerTikki;
    map['status'] = _status;
    map['Payment_mode'] = _paymentMode;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }

}

class Category {
  Category({
      int? id, 
      int? parentCat, 
      String? category, 
      String? categorySName, 
      String? categoryHi, 
      String? commodityType, 
      int? hsnCode, 
      String? gst, 
      String? gstOnRent, 
      int? agSpotCommission, 
      int? agEmandiCommission, 
      int? agF2fCommission, 
      String? mandiFees, 
      String? loading, 
      String? bardana, 
      String? freight, 
      dynamic stackCommQtlVal,
      int? firstMileRate, 
      String? image, 
      String? imagePath, 
      int? sequenceId, 
      int? isGrading, 
      int? forGrading, 
      int? debitNoteCharges, 
      int? lowerCircuit, 
      int? upperCircuit, 
      int? isFastPath, 
      String? month, 
      String? expDate, 
      int? isActive, 
      int? qualityPCondition, 
      int? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _parentCat = parentCat;
    _category = category;
    _categorySName = categorySName;
    _categoryHi = categoryHi;
    _commodityType = commodityType;
    _hsnCode = hsnCode;
    _gst = gst;
    _gstOnRent = gstOnRent;
    _agSpotCommission = agSpotCommission;
    _agEmandiCommission = agEmandiCommission;
    _agF2fCommission = agF2fCommission;
    _mandiFees = mandiFees;
    _loading = loading;
    _bardana = bardana;
    _freight = freight;
    _stackCommQtlVal = stackCommQtlVal;
    _firstMileRate = firstMileRate;
    _image = image;
    _imagePath = imagePath;
    _sequenceId = sequenceId;
    _isGrading = isGrading;
    _forGrading = forGrading;
    _debitNoteCharges = debitNoteCharges;
    _lowerCircuit = lowerCircuit;
    _upperCircuit = upperCircuit;
    _isFastPath = isFastPath;
    _month = month;
    _expDate = expDate;
    _isActive = isActive;
    _qualityPCondition = qualityPCondition;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _parentCat = json['parent_cat'];
    _category = json['category'];
    _categorySName = json['category_s_name'];
    _categoryHi = json['category_hi'];
    _commodityType = json['commodity_type'];
    _hsnCode = json['hsn_code'];
    _gst = json['gst'];
    _gstOnRent = json['gst_on_rent'];
    _agSpotCommission = json['ag_spot_commission'];
    _agEmandiCommission = json['ag_emandi_commission'];
    _agF2fCommission = json['ag_f2f_commission'];
    _mandiFees = json['mandi_fees'];
    _loading = json['loading'];
    _bardana = json['bardana'];
    _freight = json['freight'];
    _stackCommQtlVal = json['stack_comm_qtl_val'];
    _firstMileRate = json['first_mile_rate'];
    _image = json['image'];
    _imagePath = json['image_path'];
    _sequenceId = json['sequence_id'];
    _isGrading = json['is_grading'];
    _forGrading = json['for_grading'];
    _debitNoteCharges = json['debit_note_charges'];
    _lowerCircuit = json['lower_circuit'];
    _upperCircuit = json['upper_circuit'];
    _isFastPath = json['is_fast_path'];
    _month = json['month'];
    _expDate = json['exp_date'];
    _isActive = json['is_active'];
    _qualityPCondition = json['quality_p_condition'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _parentCat;
  String? _category;
  String? _categorySName;
  String? _categoryHi;
  String? _commodityType;
  int? _hsnCode;
  String? _gst;
  String? _gstOnRent;
  int? _agSpotCommission;
  int? _agEmandiCommission;
  int? _agF2fCommission;
  String? _mandiFees;
  String? _loading;
  String? _bardana;
  String? _freight;
  dynamic _stackCommQtlVal;
  int? _firstMileRate;
  String? _image;
  String? _imagePath;
  int? _sequenceId;
  int? _isGrading;
  int? _forGrading;
  int? _debitNoteCharges;
  int? _lowerCircuit;
  int? _upperCircuit;
  int? _isFastPath;
  String? _month;
  String? _expDate;
  int? _isActive;
  int? _qualityPCondition;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
Category copyWith({  int? id,
  int? parentCat,
  String? category,
  String? categorySName,
  String? categoryHi,
  String? commodityType,
  int? hsnCode,
  String? gst,
  String? gstOnRent,
  int? agSpotCommission,
  int? agEmandiCommission,
  int? agF2fCommission,
  String? mandiFees,
  String? loading,
  String? bardana,
  String? freight,
  dynamic stackCommQtlVal,
  int? firstMileRate,
  String? image,
  String? imagePath,
  int? sequenceId,
  int? isGrading,
  int? forGrading,
  int? debitNoteCharges,
  int? lowerCircuit,
  int? upperCircuit,
  int? isFastPath,
  String? month,
  String? expDate,
  int? isActive,
  int? qualityPCondition,
  int? status,
  String? createdAt,
  String? updatedAt,
}) => Category(  id: id ?? _id,
  parentCat: parentCat ?? _parentCat,
  category: category ?? _category,
  categorySName: categorySName ?? _categorySName,
  categoryHi: categoryHi ?? _categoryHi,
  commodityType: commodityType ?? _commodityType,
  hsnCode: hsnCode ?? _hsnCode,
  gst: gst ?? _gst,
  gstOnRent: gstOnRent ?? _gstOnRent,
  agSpotCommission: agSpotCommission ?? _agSpotCommission,
  agEmandiCommission: agEmandiCommission ?? _agEmandiCommission,
  agF2fCommission: agF2fCommission ?? _agF2fCommission,
  mandiFees: mandiFees ?? _mandiFees,
  loading: loading ?? _loading,
  bardana: bardana ?? _bardana,
  freight: freight ?? _freight,
  stackCommQtlVal: stackCommQtlVal ?? _stackCommQtlVal,
  firstMileRate: firstMileRate ?? _firstMileRate,
  image: image ?? _image,
  imagePath: imagePath ?? _imagePath,
  sequenceId: sequenceId ?? _sequenceId,
  isGrading: isGrading ?? _isGrading,
  forGrading: forGrading ?? _forGrading,
  debitNoteCharges: debitNoteCharges ?? _debitNoteCharges,
  lowerCircuit: lowerCircuit ?? _lowerCircuit,
  upperCircuit: upperCircuit ?? _upperCircuit,
  isFastPath: isFastPath ?? _isFastPath,
  month: month ?? _month,
  expDate: expDate ?? _expDate,
  isActive: isActive ?? _isActive,
  qualityPCondition: qualityPCondition ?? _qualityPCondition,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  int? get parentCat => _parentCat;
  String? get category => _category;
  String? get categorySName => _categorySName;
  String? get categoryHi => _categoryHi;
  String? get commodityType => _commodityType;
  int? get hsnCode => _hsnCode;
  String? get gst => _gst;
  String? get gstOnRent => _gstOnRent;
  int? get agSpotCommission => _agSpotCommission;
  int? get agEmandiCommission => _agEmandiCommission;
  int? get agF2fCommission => _agF2fCommission;
  String? get mandiFees => _mandiFees;
  String? get loading => _loading;
  String? get bardana => _bardana;
  String? get freight => _freight;
  dynamic get stackCommQtlVal => _stackCommQtlVal;
  int? get firstMileRate => _firstMileRate;
  String? get image => _image;
  String? get imagePath => _imagePath;
  int? get sequenceId => _sequenceId;
  int? get isGrading => _isGrading;
  int? get forGrading => _forGrading;
  int? get debitNoteCharges => _debitNoteCharges;
  int? get lowerCircuit => _lowerCircuit;
  int? get upperCircuit => _upperCircuit;
  int? get isFastPath => _isFastPath;
  String? get month => _month;
  String? get expDate => _expDate;
  int? get isActive => _isActive;
  int? get qualityPCondition => _qualityPCondition;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_cat'] = _parentCat;
    map['category'] = _category;
    map['category_s_name'] = _categorySName;
    map['category_hi'] = _categoryHi;
    map['commodity_type'] = _commodityType;
    map['hsn_code'] = _hsnCode;
    map['gst'] = _gst;
    map['gst_on_rent'] = _gstOnRent;
    map['ag_spot_commission'] = _agSpotCommission;
    map['ag_emandi_commission'] = _agEmandiCommission;
    map['ag_f2f_commission'] = _agF2fCommission;
    map['mandi_fees'] = _mandiFees;
    map['loading'] = _loading;
    map['bardana'] = _bardana;
    map['freight'] = _freight;
    map['stack_comm_qtl_val'] = _stackCommQtlVal;
    map['first_mile_rate'] = _firstMileRate;
    map['image'] = _image;
    map['image_path'] = _imagePath;
    map['sequence_id'] = _sequenceId;
    map['is_grading'] = _isGrading;
    map['for_grading'] = _forGrading;
    map['debit_note_charges'] = _debitNoteCharges;
    map['lower_circuit'] = _lowerCircuit;
    map['upper_circuit'] = _upperCircuit;
    map['is_fast_path'] = _isFastPath;
    map['month'] = _month;
    map['exp_date'] = _expDate;
    map['is_active'] = _isActive;
    map['quality_p_condition'] = _qualityPCondition;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Qv {
  Qv({
      int? id, 
      String? orderId, 
      String? parameter, 
      dynamic normalQuality,
      dynamic extremeQuality,
      dynamic actualQuality,
      dynamic difference,
      String? date,}){
    _id = id;
    _orderId = orderId;
    _parameter = parameter;
    _normalQuality = normalQuality;
    _extremeQuality = extremeQuality;
    _actualQuality = actualQuality;
    _difference = difference;
    _date = date;
}

  Qv.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _parameter = json['parameter'];
    _normalQuality = json['normal_quality'];
    _extremeQuality = json['extreme_quality'];
    _actualQuality = json['actual_quality'];
    _difference = json['difference'];
    _date = json['date'];
  }
  int? _id;
  String? _orderId;
  String? _parameter;
  dynamic _normalQuality;
  dynamic _extremeQuality;
  dynamic _actualQuality;
  dynamic _difference;
  String? _date;
Qv copyWith({  int? id,
  String? orderId,
  String? parameter,
  dynamic normalQuality,
  dynamic extremeQuality,
  dynamic actualQuality,
  dynamic difference,
  String? date,
}) => Qv(  id: id ?? _id,
  orderId: orderId ?? _orderId,
  parameter: parameter ?? _parameter,
  normalQuality: normalQuality ?? _normalQuality,
  extremeQuality: extremeQuality ?? _extremeQuality,
  actualQuality: actualQuality ?? _actualQuality,
  difference: difference ?? _difference,
  date: date ?? _date,
);
  int? get id => _id;
  String? get orderId => _orderId;
  String? get parameter => _parameter;
  dynamic get normalQuality => _normalQuality;
  dynamic get extremeQuality => _extremeQuality;
  dynamic get actualQuality => _actualQuality;
  dynamic get difference => _difference;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['parameter'] = _parameter;
    map['normal_quality'] = _normalQuality;
    map['extreme_quality'] = _extremeQuality;
    map['actual_quality'] = _actualQuality;
    map['difference'] = _difference;
    map['date'] = _date;
    return map;
  }

}

class Warehouse {
  Warehouse({
      int? id, 
      int? wspId, 
      int? mandiSamitiId, 
      String? warehouseCode, 
      int? type, 
      String? name, 
      dynamic nameHi, 
      String? facilityIds, 
      String? bankIds, 
      String? image, 
      String? gstImage, 
      dynamic gatepassStart, 
      dynamic gatepassEnd, 
      int? noOfStacks, 
      dynamic dharamKanta, 
      dynamic labourContractor, 
      dynamic contractorPhone, 
      dynamic labourRate, 
      String? latitude, 
      String? longitude, 
      String? pincode, 
      String? agrementFromDate, 
      String? agrementToDate, 
      String? terminalOpenDate, 
      dynamic terminalCloseDate, 
      dynamic rentAmount, 
      String? gstArrNumber, 
      int? agShare, 
      int? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _wspId = wspId;
    _mandiSamitiId = mandiSamitiId;
    _warehouseCode = warehouseCode;
    _type = type;
    _name = name;
    _nameHi = nameHi;
    _facilityIds = facilityIds;
    _bankIds = bankIds;
    _image = image;
    _gstImage = gstImage;
    _gatepassStart = gatepassStart;
    _gatepassEnd = gatepassEnd;
    _noOfStacks = noOfStacks;
    _dharamKanta = dharamKanta;
    _labourContractor = labourContractor;
    _contractorPhone = contractorPhone;
    _labourRate = labourRate;
    _latitude = latitude;
    _longitude = longitude;
    _pincode = pincode;
    _agrementFromDate = agrementFromDate;
    _agrementToDate = agrementToDate;
    _terminalOpenDate = terminalOpenDate;
    _terminalCloseDate = terminalCloseDate;
    _rentAmount = rentAmount;
    _gstArrNumber = gstArrNumber;
    _agShare = agShare;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Warehouse.fromJson(dynamic json) {
    _id = json['id'];
    _wspId = json['wsp_id'];
    _mandiSamitiId = json['mandi_samiti_id'];
    _warehouseCode = json['warehouse_code'];
    _type = json['type'];
    _name = json['name'];
    _nameHi = json['name_hi'];
    _facilityIds = json['facility_ids'];
    _bankIds = json['bank_ids'];
    _image = json['image'];
    _gstImage = json['gst_image'];
    _gatepassStart = json['gatepass_start'];
    _gatepassEnd = json['gatepass_end'];
    _noOfStacks = json['no_of_stacks'];
    _dharamKanta = json['dharam_kanta'];
    _labourContractor = json['labour_contractor'];
    _contractorPhone = json['contractor_phone'];
    _labourRate = json['labour_rate'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _pincode = json['pincode'];
    _agrementFromDate = json['agrement_from_date'];
    _agrementToDate = json['agrement_to_date'];
    _terminalOpenDate = json['terminal_open_date'];
    _terminalCloseDate = json['terminal_close_date'];
    _rentAmount = json['rent_amount'];
    _gstArrNumber = json['gst_arr_number'];
    _agShare = json['ag_share'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _wspId;
  int? _mandiSamitiId;
  String? _warehouseCode;
  int? _type;
  String? _name;
  dynamic _nameHi;
  String? _facilityIds;
  String? _bankIds;
  String? _image;
  String? _gstImage;
  dynamic _gatepassStart;
  dynamic _gatepassEnd;
  int? _noOfStacks;
  dynamic _dharamKanta;
  dynamic _labourContractor;
  dynamic _contractorPhone;
  dynamic _labourRate;
  String? _latitude;
  String? _longitude;
  String? _pincode;
  String? _agrementFromDate;
  String? _agrementToDate;
  String? _terminalOpenDate;
  dynamic _terminalCloseDate;
  dynamic _rentAmount;
  String? _gstArrNumber;
  int? _agShare;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
Warehouse copyWith({  int? id,
  int? wspId,
  int? mandiSamitiId,
  String? warehouseCode,
  int? type,
  String? name,
  dynamic nameHi,
  String? facilityIds,
  String? bankIds,
  String? image,
  String? gstImage,
  dynamic gatepassStart,
  dynamic gatepassEnd,
  int? noOfStacks,
  dynamic dharamKanta,
  dynamic labourContractor,
  dynamic contractorPhone,
  dynamic labourRate,
  String? latitude,
  String? longitude,
  String? pincode,
  String? agrementFromDate,
  String? agrementToDate,
  String? terminalOpenDate,
  dynamic terminalCloseDate,
  dynamic rentAmount,
  String? gstArrNumber,
  int? agShare,
  int? status,
  String? createdAt,
  String? updatedAt,
}) => Warehouse(  id: id ?? _id,
  wspId: wspId ?? _wspId,
  mandiSamitiId: mandiSamitiId ?? _mandiSamitiId,
  warehouseCode: warehouseCode ?? _warehouseCode,
  type: type ?? _type,
  name: name ?? _name,
  nameHi: nameHi ?? _nameHi,
  facilityIds: facilityIds ?? _facilityIds,
  bankIds: bankIds ?? _bankIds,
  image: image ?? _image,
  gstImage: gstImage ?? _gstImage,
  gatepassStart: gatepassStart ?? _gatepassStart,
  gatepassEnd: gatepassEnd ?? _gatepassEnd,
  noOfStacks: noOfStacks ?? _noOfStacks,
  dharamKanta: dharamKanta ?? _dharamKanta,
  labourContractor: labourContractor ?? _labourContractor,
  contractorPhone: contractorPhone ?? _contractorPhone,
  labourRate: labourRate ?? _labourRate,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  pincode: pincode ?? _pincode,
  agrementFromDate: agrementFromDate ?? _agrementFromDate,
  agrementToDate: agrementToDate ?? _agrementToDate,
  terminalOpenDate: terminalOpenDate ?? _terminalOpenDate,
  terminalCloseDate: terminalCloseDate ?? _terminalCloseDate,
  rentAmount: rentAmount ?? _rentAmount,
  gstArrNumber: gstArrNumber ?? _gstArrNumber,
  agShare: agShare ?? _agShare,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  int? get wspId => _wspId;
  int? get mandiSamitiId => _mandiSamitiId;
  String? get warehouseCode => _warehouseCode;
  int? get type => _type;
  String? get name => _name;
  dynamic get nameHi => _nameHi;
  String? get facilityIds => _facilityIds;
  String? get bankIds => _bankIds;
  String? get image => _image;
  String? get gstImage => _gstImage;
  dynamic get gatepassStart => _gatepassStart;
  dynamic get gatepassEnd => _gatepassEnd;
  int? get noOfStacks => _noOfStacks;
  dynamic get dharamKanta => _dharamKanta;
  dynamic get labourContractor => _labourContractor;
  dynamic get contractorPhone => _contractorPhone;
  dynamic get labourRate => _labourRate;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get pincode => _pincode;
  String? get agrementFromDate => _agrementFromDate;
  String? get agrementToDate => _agrementToDate;
  String? get terminalOpenDate => _terminalOpenDate;
  dynamic get terminalCloseDate => _terminalCloseDate;
  dynamic get rentAmount => _rentAmount;
  String? get gstArrNumber => _gstArrNumber;
  int? get agShare => _agShare;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['wsp_id'] = _wspId;
    map['mandi_samiti_id'] = _mandiSamitiId;
    map['warehouse_code'] = _warehouseCode;
    map['type'] = _type;
    map['name'] = _name;
    map['name_hi'] = _nameHi;
    map['facility_ids'] = _facilityIds;
    map['bank_ids'] = _bankIds;
    map['image'] = _image;
    map['gst_image'] = _gstImage;
    map['gatepass_start'] = _gatepassStart;
    map['gatepass_end'] = _gatepassEnd;
    map['no_of_stacks'] = _noOfStacks;
    map['dharam_kanta'] = _dharamKanta;
    map['labour_contractor'] = _labourContractor;
    map['contractor_phone'] = _contractorPhone;
    map['labour_rate'] = _labourRate;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['pincode'] = _pincode;
    map['agrement_from_date'] = _agrementFromDate;
    map['agrement_to_date'] = _agrementToDate;
    map['terminal_open_date'] = _terminalOpenDate;
    map['terminal_close_date'] = _terminalCloseDate;
    map['rent_amount'] = _rentAmount;
    map['gst_arr_number'] = _gstArrNumber;
    map['ag_share'] = _agShare;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}