class TerminalModel {
  TerminalModel({
      List<Terminals>? terminals, 
      String? status, 
      String? message,}){
    _terminals = terminals;
    _status = status;
    _message = message;
}

  TerminalModel.fromJson(dynamic json) {
    if (json['terminals'] != null) {
      _terminals = [];
      json['terminals'].forEach((v) {
        _terminals?.add(Terminals.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<Terminals>? _terminals;
  String? _status;
  String? _message;

  List<Terminals>? get terminals => _terminals;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_terminals != null) {
      map['terminals'] = _terminals?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class Terminals {
  Terminals({
      num? id, 
      num? wspId, 
      num? mandiSamitiId, 
      String? warehouseCode, 
      num? type, 
      String? name, 
      dynamic nameHi, 
      String? facilityIds, 
      String? bankIds, 
      String? image, 
      String? gstImage, 
      dynamic gatepassStart, 
      dynamic gatepassEnd, 
      num? noOfStacks, 
      dynamic dharamKanta, 
      dynamic labourContractor, 
      dynamic contractorPhone, 
      dynamic labourRate, 
      String? latitude, 
      String? longitude, 
      String? pincode, 
      String? agrementFromDate, 
      String? agrementToDate, 
      dynamic terminalOpenDate, 
      dynamic terminalCloseDate, 
      num? rentAmount, 
      String? gstArrNumber, 
      num? agShare, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      MandiSamiti? mandiSamiti, 
      TeminalType? teminalType, 
      WarehouseRent? warehouseRent,}){
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
    _mandiSamiti = mandiSamiti;
    _teminalType = teminalType;
    _warehouseRent = warehouseRent;
}

  Terminals.fromJson(dynamic json) {
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
    _mandiSamiti = json['mandi_samiti'] != null ? MandiSamiti.fromJson(json['mandi_samiti']) : null;
    _teminalType = json['teminal_type'] != null ? TeminalType.fromJson(json['teminal_type']) : null;
    _warehouseRent = json['warehouse_rent'] != null ? WarehouseRent.fromJson(json['warehouse_rent']) : null;
  }
  num? _id;
  num? _wspId;
  num? _mandiSamitiId;
  String? _warehouseCode;
  num? _type;
  String? _name;
  dynamic _nameHi;
  String? _facilityIds;
  String? _bankIds;
  String? _image;
  String? _gstImage;
  dynamic _gatepassStart;
  dynamic _gatepassEnd;
  num? _noOfStacks;
  dynamic _dharamKanta;
  dynamic _labourContractor;
  dynamic _contractorPhone;
  dynamic _labourRate;
  String? _latitude;
  String? _longitude;
  String? _pincode;
  String? _agrementFromDate;
  String? _agrementToDate;
  dynamic _terminalOpenDate;
  dynamic _terminalCloseDate;
  num? _rentAmount;
  String? _gstArrNumber;
  num? _agShare;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  MandiSamiti? _mandiSamiti;
  TeminalType? _teminalType;
  WarehouseRent? _warehouseRent;

  num? get id => _id;
  num? get wspId => _wspId;
  num? get mandiSamitiId => _mandiSamitiId;
  String? get warehouseCode => _warehouseCode;
  num? get type => _type;
  String? get name => _name;
  dynamic get nameHi => _nameHi;
  String? get facilityIds => _facilityIds;
  String? get bankIds => _bankIds;
  String? get image => _image;
  String? get gstImage => _gstImage;
  dynamic get gatepassStart => _gatepassStart;
  dynamic get gatepassEnd => _gatepassEnd;
  num? get noOfStacks => _noOfStacks;
  dynamic get dharamKanta => _dharamKanta;
  dynamic get labourContractor => _labourContractor;
  dynamic get contractorPhone => _contractorPhone;
  dynamic get labourRate => _labourRate;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get pincode => _pincode;
  String? get agrementFromDate => _agrementFromDate;
  String? get agrementToDate => _agrementToDate;
  dynamic get terminalOpenDate => _terminalOpenDate;
  dynamic get terminalCloseDate => _terminalCloseDate;
  num? get rentAmount => _rentAmount;
  String? get gstArrNumber => _gstArrNumber;
  num? get agShare => _agShare;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  MandiSamiti? get mandiSamiti => _mandiSamiti;
  TeminalType? get teminalType => _teminalType;
  WarehouseRent? get warehouseRent => _warehouseRent;

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
    if (_mandiSamiti != null) {
      map['mandi_samiti'] = _mandiSamiti?.toJson();
    }
    if (_teminalType != null) {
      map['teminal_type'] = _teminalType?.toJson();
    }
    if (_warehouseRent != null) {
      map['warehouse_rent'] = _warehouseRent?.toJson();
    }
    return map;
  }

}

class WarehouseRent {
  WarehouseRent({
      num? id, 
      num? warehouseId, 
      String? address, 
      String? location, 
      dynamic area, 
      String? district, 
      String? state, 
      String? areaSqrFt, 
      String? rentPerMonth, 
      String? capacityInMt, 
      String? nearbyTransporterInfo, 
      String? nearbyMandiInfo, 
      String? nearbyCropInfo, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      Districts? districts, 
      States? states,}){
    _id = id;
    _warehouseId = warehouseId;
    _address = address;
    _location = location;
    _area = area;
    _district = district;
    _state = state;
    _areaSqrFt = areaSqrFt;
    _rentPerMonth = rentPerMonth;
    _capacityInMt = capacityInMt;
    _nearbyTransporterInfo = nearbyTransporterInfo;
    _nearbyMandiInfo = nearbyMandiInfo;
    _nearbyCropInfo = nearbyCropInfo;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _districts = districts;
    _states = states;
}

  WarehouseRent.fromJson(dynamic json) {
    _id = json['id'];
    _warehouseId = json['warehouse_id'];
    _address = json['address'];
    _location = json['location'];
    _area = json['area'];
    _district = json['district'];
    _state = json['state'];
    _areaSqrFt = json['area_sqr_ft'];
    _rentPerMonth = json['rent_per_month'];
    _capacityInMt = json['capacity_in_mt'];
    _nearbyTransporterInfo = json['nearby_transporter_info'];
    _nearbyMandiInfo = json['nearby_mandi_info'];
    _nearbyCropInfo = json['nearby_crop_info'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _districts = json['districts'] != null ? Districts.fromJson(json['districts']) : null;
    _states = json['states'] != null ? States.fromJson(json['states']) : null;
  }
  num? _id;
  num? _warehouseId;
  String? _address;
  String? _location;
  dynamic _area;
  String? _district;
  String? _state;
  String? _areaSqrFt;
  String? _rentPerMonth;
  String? _capacityInMt;
  String? _nearbyTransporterInfo;
  String? _nearbyMandiInfo;
  String? _nearbyCropInfo;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  Districts? _districts;
  States? _states;

  num? get id => _id;
  num? get warehouseId => _warehouseId;
  String? get address => _address;
  String? get location => _location;
  dynamic get area => _area;
  String? get district => _district;
  String? get state => _state;
  String? get areaSqrFt => _areaSqrFt;
  String? get rentPerMonth => _rentPerMonth;
  String? get capacityInMt => _capacityInMt;
  String? get nearbyTransporterInfo => _nearbyTransporterInfo;
  String? get nearbyMandiInfo => _nearbyMandiInfo;
  String? get nearbyCropInfo => _nearbyCropInfo;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Districts? get districts => _districts;
  States? get states => _states;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['warehouse_id'] = _warehouseId;
    map['address'] = _address;
    map['location'] = _location;
    map['area'] = _area;
    map['district'] = _district;
    map['state'] = _state;
    map['area_sqr_ft'] = _areaSqrFt;
    map['rent_per_month'] = _rentPerMonth;
    map['capacity_in_mt'] = _capacityInMt;
    map['nearby_transporter_info'] = _nearbyTransporterInfo;
    map['nearby_mandi_info'] = _nearbyMandiInfo;
    map['nearby_crop_info'] = _nearbyCropInfo;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_districts != null) {
      map['districts'] = _districts?.toJson();
    }
    if (_states != null) {
      map['states'] = _states?.toJson();
    }
    return map;
  }

}

class States {
  States({
      num? id, 
      String? name, 
      num? code, 
      num? countryId,}){
    _id = id;
    _name = name;
    _code = code;
    _countryId = countryId;
}

  States.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _code = json['code'];
    _countryId = json['country_id'];
  }
  num? _id;
  String? _name;
  num? _code;
  num? _countryId;

  num? get id => _id;
  String? get name => _name;
  num? get code => _code;
  num? get countryId => _countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['code'] = _code;
    map['country_id'] = _countryId;
    return map;
  }

}

class Districts {
  Districts({
      num? id, 
      num? stateCode, 
      num? districtCode, 
      String? name,}){
    _id = id;
    _stateCode = stateCode;
    _districtCode = districtCode;
    _name = name;
}

  Districts.fromJson(dynamic json) {
    _id = json['id'];
    _stateCode = json['state_code'];
    _districtCode = json['district_code'];
    _name = json['name'];
  }
  num? _id;
  num? _stateCode;
  num? _districtCode;
  String? _name;

  num? get id => _id;
  num? get stateCode => _stateCode;
  num? get districtCode => _districtCode;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['state_code'] = _stateCode;
    map['district_code'] = _districtCode;
    map['name'] = _name;
    return map;
  }

}

class TeminalType {
  TeminalType({
      num? id, 
      String? name, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  TeminalType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class MandiSamiti {
  MandiSamiti({
      num? id, 
      String? name, 
      String? MandiSamiticlass,
      String? secretaryName, 
      String? phone, 
      String? stdCode, 
      String? telNo, 
      dynamic fax, 
      String? email, 
      dynamic address, 
      dynamic district, 
      num? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _class = MandiSamiticlass;
    _secretaryName = secretaryName;
    _phone = phone;
    _stdCode = stdCode;
    _telNo = telNo;
    _fax = fax;
    _email = email;
    _address = address;
    _district = district;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  MandiSamiti.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _class = json['class'];
    _secretaryName = json['secretary_name'];
    _phone = json['phone'];
    _stdCode = json['std_code'];
    _telNo = json['tel_no'];
    _fax = json['fax'];
    _email = json['email'];
    _address = json['address'];
    _district = json['district'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _class;
  String? _secretaryName;
  String? _phone;
  String? _stdCode;
  String? _telNo;
  dynamic _fax;
  String? _email;
  dynamic _address;
  dynamic _district;
  num? _status;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;
  String? get name => _name;
  String? get MandiSamiticlass => _class;
  String? get secretaryName => _secretaryName;
  String? get phone => _phone;
  String? get stdCode => _stdCode;
  String? get telNo => _telNo;
  dynamic get fax => _fax;
  String? get email => _email;
  dynamic get address => _address;
  dynamic get district => _district;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['class'] = _class;
    map['secretary_name'] = _secretaryName;
    map['phone'] = _phone;
    map['std_code'] = _stdCode;
    map['tel_no'] = _telNo;
    map['fax'] = _fax;
    map['email'] = _email;
    map['address'] = _address;
    map['district'] = _district;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}