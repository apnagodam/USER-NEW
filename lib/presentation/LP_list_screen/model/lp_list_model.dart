class LpListModel {
  LpListModel({
      List<CorporateBuyer>? corporateBuyer, 
      List<BuyersList>? buyersList, 
      List<LpList>? lpList, 
      String? status, 
      String? message,}){
    _corporateBuyer = corporateBuyer;
    _buyersList = buyersList;
    _lpList = lpList;
    _status = status;
    _message = message;
}

  LpListModel.fromJson(dynamic json) {
    if (json['corporate_buyer'] != null) {
      _corporateBuyer = [];
      json['corporate_buyer'].forEach((v) {
        _corporateBuyer?.add(CorporateBuyer.fromJson(v));
      });
    }
    if (json['buyers_list'] != null) {
      _buyersList = [];
      json['buyers_list'].forEach((v) {
        _buyersList?.add(BuyersList.fromJson(v));
      });
    }
    if (json['lp_list'] != null) {
      _lpList = [];
      json['lp_list'].forEach((v) {
        _lpList?.add(LpList.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<CorporateBuyer>? _corporateBuyer;
  List<BuyersList>? _buyersList;
  List<LpList>? _lpList;
  String? _status;
  String? _message;
LpListModel copyWith({  List<CorporateBuyer>? corporateBuyer,
  List<BuyersList>? buyersList,
  List<LpList>? lpList,
  String? status,
  String? message,
}) => LpListModel(  corporateBuyer: corporateBuyer ?? _corporateBuyer,
  buyersList: buyersList ?? _buyersList,
  lpList: lpList ?? _lpList,
  status: status ?? _status,
  message: message ?? _message,
);
  List<CorporateBuyer>? get corporateBuyer => _corporateBuyer;
  List<BuyersList>? get buyersList => _buyersList;
  List<LpList>? get lpList => _lpList;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_corporateBuyer != null) {
      map['corporate_buyer'] = _corporateBuyer?.map((v) => v.toJson()).toList();
    }
    if (_buyersList != null) {
      map['buyers_list'] = _buyersList?.map((v) => v.toJson()).toList();
    }
    if (_lpList != null) {
      map['lp_list'] = _lpList?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class LpList {
  LpList({
      dynamic lpUserId, 
      String? uniqueId, 
      dynamic autoAccept, 
      String? phone, 
      String? liveLat, 
      String? liveLong, 
      String? name, 
      dynamic vehicleId, 
      String? vehicleType, 
      String? passportImage, 
      String? distance, 
      String? finalPrice, 
      String? commodityId, 
      String? quantity, 
      String? price, 
      String? salesStatus, 
      String? categoryImage, 
      String? commodityImagePath, 
      dynamic terminalId, 
      dynamic agCommission, 
      dynamic lpCommission, 
      String? lpLat, 
      String? lpLong, 
      String? corporateUsersLat, 
      String? corporateUsersLong, 
      dynamic subPrice,
      dynamic transportPrice, 
      String? loadingCharge, 
      dynamic mandiTax, 
      dynamic user, 
      String? warehouseName, 
      String? location,}){
    _lpUserId = lpUserId;
    _uniqueId = uniqueId;
    _autoAccept = autoAccept;
    _phone = phone;
    _liveLat = liveLat;
    _liveLong = liveLong;
    _name = name;
    _vehicleId = vehicleId;
    _vehicleType = vehicleType;
    _passportImage = passportImage;
    _distance = distance;
    _finalPrice = finalPrice;
    _commodityId = commodityId;
    _quantity = quantity;
    _price = price;
    _salesStatus = salesStatus;
    _categoryImage = categoryImage;
    _commodityImagePath = commodityImagePath;
    _terminalId = terminalId;
    _agCommission = agCommission;
    _lpCommission = lpCommission;
    _lpLat = lpLat;
    _lpLong = lpLong;
    _corporateUsersLat = corporateUsersLat;
    _corporateUsersLong = corporateUsersLong;
    _subPrice = subPrice;
    _transportPrice = transportPrice;
    _loadingCharge = loadingCharge;
    _mandiTax = mandiTax;
    _user = user;
    _warehouseName = warehouseName;
    _location = location;
}

  LpList.fromJson(dynamic json) {
    _lpUserId = json['lp_user_id'];
    _uniqueId = json['unique_id'];
    _autoAccept = json['auto_accept'];
    _phone = json['phone'];
    _liveLat = json['live_lat'];
    _liveLong = json['live_long'];
    _name = json['name'];
    _vehicleId = json['vehicle_id'];
    _vehicleType = json['vehicle_type'];
    _passportImage = json['passport_image'];
    _distance = json['distance'];
    _finalPrice = json['final_price'];
    _commodityId = json['commodity_id'];
    _quantity = json['quantity'];
    _price = json['price'];
    _salesStatus = json['sales_status'];
    _categoryImage = json['category_image'];
    _commodityImagePath = json['commodity_image_path'];
    _terminalId = json['terminal_id'];
    _agCommission = json['ag_commission'];
    _lpCommission = json['lp_commission'];
    _lpLat = json['lp_lat'];
    _lpLong = json['lp_long'];
    _corporateUsersLat = json['corporate_users_lat'];
    _corporateUsersLong = json['corporate_users_long'];
    _subPrice = json['sub_price'];
    _transportPrice = json['transport_price'];
    _loadingCharge = json['loading_charge'];
    _mandiTax = json['mandi_tax'];
    _user = json['user'];
    _warehouseName = json['warehouse_name'];
    _location = json['location'];
  }
  dynamic _lpUserId;
  String? _uniqueId;
  dynamic _autoAccept;
  String? _phone;
  String? _liveLat;
  String? _liveLong;
  String? _name;
  dynamic _vehicleId;
  String? _vehicleType;
  String? _passportImage;
  String? _distance;
  String? _finalPrice;
  String? _commodityId;
  String? _quantity;
  String? _price;
  String? _salesStatus;
  String? _categoryImage;
  String? _commodityImagePath;
  dynamic _terminalId;
  dynamic _agCommission;
  dynamic _lpCommission;
  String? _lpLat;
  String? _lpLong;
  String? _corporateUsersLat;
  String? _corporateUsersLong;
  dynamic _subPrice;
  dynamic _transportPrice;
  dynamic _loadingCharge;
  dynamic _mandiTax;
  dynamic _user;
  String? _warehouseName;
  String? _location;
LpList copyWith({  dynamic lpUserId,
  String? uniqueId,
  dynamic autoAccept,
  String? phone,
  String? liveLat,
  String? liveLong,
  String? name,
  dynamic vehicleId,
  String? vehicleType,
  String? passportImage,
  String? distance,
  String? finalPrice,
  String? commodityId,
  String? quantity,
  String? price,
  String? salesStatus,
  String? categoryImage,
  String? commodityImagePath,
  dynamic terminalId,
  dynamic agCommission,
  dynamic lpCommission,
  String? lpLat,
  String? lpLong,
  String? corporateUsersLat,
  String? corporateUsersLong,
  dynamic subPrice,
  dynamic transportPrice,
  dynamic loadingCharge,
  dynamic mandiTax,
  dynamic user,
  String? warehouseName,
  String? location,
}) => LpList(  lpUserId: lpUserId ?? _lpUserId,
  uniqueId: uniqueId ?? _uniqueId,
  autoAccept: autoAccept ?? _autoAccept,
  phone: phone ?? _phone,
  liveLat: liveLat ?? _liveLat,
  liveLong: liveLong ?? _liveLong,
  name: name ?? _name,
  vehicleId: vehicleId ?? _vehicleId,
  vehicleType: vehicleType ?? _vehicleType,
  passportImage: passportImage ?? _passportImage,
  distance: distance ?? _distance,
  finalPrice: finalPrice ?? _finalPrice,
  commodityId: commodityId ?? _commodityId,
  quantity: quantity ?? _quantity,
  price: price ?? _price,
  salesStatus: salesStatus ?? _salesStatus,
  categoryImage: categoryImage ?? _categoryImage,
  commodityImagePath: commodityImagePath ?? _commodityImagePath,
  terminalId: terminalId ?? _terminalId,
  agCommission: agCommission ?? _agCommission,
  lpCommission: lpCommission ?? _lpCommission,
  lpLat: lpLat ?? _lpLat,
  lpLong: lpLong ?? _lpLong,
  corporateUsersLat: corporateUsersLat ?? _corporateUsersLat,
  corporateUsersLong: corporateUsersLong ?? _corporateUsersLong,
  subPrice: subPrice ?? _subPrice,
  transportPrice: transportPrice ?? _transportPrice,
  loadingCharge: loadingCharge ?? _loadingCharge,
  mandiTax: mandiTax ?? _mandiTax,
  user: user ?? _user,
  warehouseName: warehouseName ?? _warehouseName,
  location: location ?? _location,
);
  dynamic get lpUserId => _lpUserId;
  String? get uniqueId => _uniqueId;
  dynamic get autoAccept => _autoAccept;
  String? get phone => _phone;
  String? get liveLat => _liveLat;
  String? get liveLong => _liveLong;
  String? get name => _name;
  dynamic get vehicleId => _vehicleId;
  String? get vehicleType => _vehicleType;
  String? get passportImage => _passportImage;
  String? get distance => _distance;
  String? get finalPrice => _finalPrice;
  String? get commodityId => _commodityId;
  String? get quantity => _quantity;
  String? get price => _price;
  String? get salesStatus => _salesStatus;
  String? get categoryImage => _categoryImage;
  String? get commodityImagePath => _commodityImagePath;
  dynamic get terminalId => _terminalId;
  dynamic get agCommission => _agCommission;
  dynamic get lpCommission => _lpCommission;
  String? get lpLat => _lpLat;
  String? get lpLong => _lpLong;
  String? get corporateUsersLat => _corporateUsersLat;
  String? get corporateUsersLong => _corporateUsersLong;
  dynamic get subPrice => _subPrice;
  dynamic get transportPrice => _transportPrice;
  dynamic get loadingCharge => _loadingCharge;
  dynamic get mandiTax => _mandiTax;
  dynamic get user => _user;
  String? get warehouseName => _warehouseName;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lp_user_id'] = _lpUserId;
    map['unique_id'] = _uniqueId;
    map['auto_accept'] = _autoAccept;
    map['phone'] = _phone;
    map['live_lat'] = _liveLat;
    map['live_long'] = _liveLong;
    map['name'] = _name;
    map['vehicle_id'] = _vehicleId;
    map['vehicle_type'] = _vehicleType;
    map['passport_image'] = _passportImage;
    map['distance'] = _distance;
    map['final_price'] = _finalPrice;
    map['commodity_id'] = _commodityId;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['sales_status'] = _salesStatus;
    map['category_image'] = _categoryImage;
    map['commodity_image_path'] = _commodityImagePath;
    map['terminal_id'] = _terminalId;
    map['ag_commission'] = _agCommission;
    map['lp_commission'] = _lpCommission;
    map['lp_lat'] = _lpLat;
    map['lp_long'] = _lpLong;
    map['corporate_users_lat'] = _corporateUsersLat;
    map['corporate_users_long'] = _corporateUsersLong;
    map['sub_price'] = _subPrice;
    map['transport_price'] = _transportPrice;
    map['loading_charge'] = _loadingCharge;
    map['mandi_tax'] = _mandiTax;
    map['user'] = _user;
    map['warehouse_name'] = _warehouseName;
    map['location'] = _location;
    return map;
  }

}

class BuyersList {
  BuyersList({
      String? name, 
      dynamic price, 
      String? warehouse, 
      String? commodityHi, 
      String? commodity, 
      String? commodityImagePath,}){
    _name = name;
    _price = price;
    _warehouse = warehouse;
    _commodityHi = commodityHi;
    _commodity = commodity;
    _commodityImagePath = commodityImagePath;
}

  BuyersList.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
    _warehouse = json['warehouse'];
    _commodityHi = json['commodity_hi'];
    _commodity = json['commodity'];
    _commodityImagePath = json['commodity_image_path'];
  }
  String? _name;
  dynamic _price;
  String? _warehouse;
  String? _commodityHi;
  String? _commodity;
  String? _commodityImagePath;
BuyersList copyWith({  String? name,
  dynamic price,
  String? warehouse,
  String? commodityHi,
  String? commodity,
  String? commodityImagePath,
}) => BuyersList(  name: name ?? _name,
  price: price ?? _price,
  warehouse: warehouse ?? _warehouse,
  commodityHi: commodityHi ?? _commodityHi,
  commodity: commodity ?? _commodity,
  commodityImagePath: commodityImagePath ?? _commodityImagePath,
);
  String? get name => _name;
  dynamic get price => _price;
  String? get warehouse => _warehouse;
  String? get commodityHi => _commodityHi;
  String? get commodity => _commodity;
  String? get commodityImagePath => _commodityImagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['price'] = _price;
    map['warehouse'] = _warehouse;
    map['commodity_hi'] = _commodityHi;
    map['commodity'] = _commodity;
    map['commodity_image_path'] = _commodityImagePath;
    return map;
  }

}

class CorporateBuyer {
  CorporateBuyer({
      dynamic commodityId, 
      String? category, 
      String? categoryImage, 
      String? categoryHi, 
      String? commodityImagePath, 
      dynamic terminalId, 
      dynamic mandiTax, 
      dynamic user, 
      String? price, 
      String? quantity, 
      String? corporateUsersLat, 
      String? corporateUsersLong, 
      String? pincode, 
      String? location, 
      String? warehouseName, 
      String? distance, 
      String? salesStatus, 
      dynamic transportPrice,
      dynamic loadingCharge,
      dynamic agCommission, 
      dynamic lpCommission,
      dynamic subPrice,
      String? deliveryPrice, 
      String? finalPrice,}){
    _commodityId = commodityId;
    _category = category;
    _categoryImage = categoryImage;
    _categoryHi = categoryHi;
    _commodityImagePath = commodityImagePath;
    _terminalId = terminalId;
    _mandiTax = mandiTax;
    _user = user;
    _price = price;
    _quantity = quantity;
    _corporateUsersLat = corporateUsersLat;
    _corporateUsersLong = corporateUsersLong;
    _pincode = pincode;
    _location = location;
    _warehouseName = warehouseName;
    _distance = distance;
    _salesStatus = salesStatus;
    _transportPrice = transportPrice;
    _loadingCharge = loadingCharge;
    _agCommission = agCommission;
    _lpCommission = lpCommission;
    _subPrice = subPrice;
    _deliveryPrice = deliveryPrice;
    _finalPrice = finalPrice;
}

  CorporateBuyer.fromJson(dynamic json) {
    _commodityId = json['commodity_id'];
    _category = json['category'];
    _categoryImage = json['category_image'];
    _categoryHi = json['category_hi'];
    _commodityImagePath = json['commodity_image_path'];
    _terminalId = json['terminal_id'];
    _mandiTax = json['mandi_tax'];
    _user = json['user'];
    _price = json['price'];
    _quantity = json['quantity'];
    _corporateUsersLat = json['corporate_users_lat'];
    _corporateUsersLong = json['corporate_users_long'];
    _pincode = json['pincode'];
    _location = json['location'];
    _warehouseName = json['warehouse_name'];
    _distance = json['distance'];
    _salesStatus = json['sales_status'];
    _transportPrice = json['transport_price'];
    _loadingCharge = json['loading_charge'];
    _agCommission = json['ag_commission'];
    _lpCommission = json['lp_commission'];
    _subPrice = json['sub_price'];
    _deliveryPrice = json['delivery_price'];
    _finalPrice = json['final_price'];
  }
  dynamic _commodityId;
  String? _category;
  String? _categoryImage;
  String? _categoryHi;
  String? _commodityImagePath;
  dynamic _terminalId;
  dynamic _mandiTax;
  dynamic _user;
  String? _price;
  String? _quantity;
  String? _corporateUsersLat;
  String? _corporateUsersLong;
  String? _pincode;
  String? _location;
  String? _warehouseName;
  String? _distance;
  String? _salesStatus;
  dynamic _transportPrice;
  dynamic _loadingCharge;
  dynamic _agCommission;
  dynamic _lpCommission;
  dynamic _subPrice;
  String? _deliveryPrice;
  String? _finalPrice;
CorporateBuyer copyWith({  dynamic commodityId,
  String? category,
  String? categoryImage,
  String? categoryHi,
  String? commodityImagePath,
  dynamic terminalId,
  dynamic mandiTax,
  dynamic user,
  String? price,
  String? quantity,
  String? corporateUsersLat,
  String? corporateUsersLong,
  String? pincode,
  String? location,
  String? warehouseName,
  String? distance,
  String? salesStatus,
  dynamic transportPrice,
  dynamic loadingCharge,
  dynamic agCommission,
  dynamic lpCommission,
  dynamic subPrice,
  String? deliveryPrice,
  String? finalPrice,
}) => CorporateBuyer(  commodityId: commodityId ?? _commodityId,
  category: category ?? _category,
  categoryImage: categoryImage ?? _categoryImage,
  categoryHi: categoryHi ?? _categoryHi,
  commodityImagePath: commodityImagePath ?? _commodityImagePath,
  terminalId: terminalId ?? _terminalId,
  mandiTax: mandiTax ?? _mandiTax,
  user: user ?? _user,
  price: price ?? _price,
  quantity: quantity ?? _quantity,
  corporateUsersLat: corporateUsersLat ?? _corporateUsersLat,
  corporateUsersLong: corporateUsersLong ?? _corporateUsersLong,
  pincode: pincode ?? _pincode,
  location: location ?? _location,
  warehouseName: warehouseName ?? _warehouseName,
  distance: distance ?? _distance,
  salesStatus: salesStatus ?? _salesStatus,
  transportPrice: transportPrice ?? _transportPrice,
  loadingCharge: loadingCharge ?? _loadingCharge,
  agCommission: agCommission ?? _agCommission,
  lpCommission: lpCommission ?? _lpCommission,
  subPrice: subPrice ?? _subPrice,
  deliveryPrice: deliveryPrice ?? _deliveryPrice,
  finalPrice: finalPrice ?? _finalPrice,
);
  dynamic get commodityId => _commodityId;
  String? get category => _category;
  String? get categoryImage => _categoryImage;
  String? get categoryHi => _categoryHi;
  String? get commodityImagePath => _commodityImagePath;
  dynamic get terminalId => _terminalId;
  dynamic get mandiTax => _mandiTax;
  dynamic get user => _user;
  String? get price => _price;
  String? get quantity => _quantity;
  String? get corporateUsersLat => _corporateUsersLat;
  String? get corporateUsersLong => _corporateUsersLong;
  String? get pincode => _pincode;
  String? get location => _location;
  String? get warehouseName => _warehouseName;
  String? get distance => _distance;
  String? get salesStatus => _salesStatus;
  dynamic get transportPrice => _transportPrice;
  dynamic get loadingCharge => _loadingCharge;
  dynamic get agCommission => _agCommission;
  dynamic get lpCommission => _lpCommission;
  dynamic get subPrice => _subPrice;
  String? get deliveryPrice => _deliveryPrice;
  String? get finalPrice => _finalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commodity_id'] = _commodityId;
    map['category'] = _category;
    map['category_image'] = _categoryImage;
    map['category_hi'] = _categoryHi;
    map['commodity_image_path'] = _commodityImagePath;
    map['terminal_id'] = _terminalId;
    map['mandi_tax'] = _mandiTax;
    map['user'] = _user;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['corporate_users_lat'] = _corporateUsersLat;
    map['corporate_users_long'] = _corporateUsersLong;
    map['pincode'] = _pincode;
    map['location'] = _location;
    map['warehouse_name'] = _warehouseName;
    map['distance'] = _distance;
    map['sales_status'] = _salesStatus;
    map['transport_price'] = _transportPrice;
    map['loading_charge'] = _loadingCharge;
    map['ag_commission'] = _agCommission;
    map['lp_commission'] = _lpCommission;
    map['sub_price'] = _subPrice;
    map['delivery_price'] = _deliveryPrice;
    map['final_price'] = _finalPrice;
    return map;
  }

}