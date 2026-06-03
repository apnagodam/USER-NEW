class CommonIndexModel {
  CommonIndexModel({
    List<TodaysPrice>? todaysPrice,
    List<Commodites>? commodites,
    List<Testimonials>? testimonials,
    String? status,
    String? message,
  }) {
    _todaysPrice = todaysPrice;
    _commodites = commodites;
    _testimonials = testimonials;
    _status = status;
    _message = message;
  }

  CommonIndexModel.fromJson(dynamic json) {
    if (json['todays_price'] != null) {
      _todaysPrice = [];
      json['todays_price'].forEach((v) {
        _todaysPrice?.add(TodaysPrice.fromJson(v));
      });
    }
    if (json['commodites'] != null) {
      _commodites = [];
      json['commodites'].forEach((v) {
        _commodites?.add(Commodites.fromJson(v));
      });
    }
    if (json['testimonials'] != null) {
      _testimonials = [];
      json['testimonials'].forEach((v) {
        _testimonials?.add(Testimonials.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<TodaysPrice>? _todaysPrice;
  List<Commodites>? _commodites;
  List<Testimonials>? _testimonials;
  String? _status;
  String? _message;
  CommonIndexModel copyWith({
    List<TodaysPrice>? todaysPrice,
    List<Commodites>? commodites,
    List<Testimonials>? testimonials,
    String? status,
    String? message,
  }) =>
      CommonIndexModel(
        todaysPrice: todaysPrice ?? _todaysPrice,
        commodites: commodites ?? _commodites,
        testimonials: testimonials ?? _testimonials,
        status: status ?? _status,
        message: message ?? _message,
      );
  List<TodaysPrice>? get todaysPrice => _todaysPrice;
  List<Commodites>? get commodites => _commodites;
  List<Testimonials>? get testimonials => _testimonials;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_todaysPrice != null) {
      map['todays_price'] = _todaysPrice?.map((v) => v.toJson()).toList();
    }
    if (_commodites != null) {
      map['commodites'] = _commodites?.map((v) => v.toJson()).toList();
    }
    if (_testimonials != null) {
      map['testimonials'] = _testimonials?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}

class Testimonials {
  Testimonials({
    dynamic id,
    String? name,
    String? description,
    String? location,
    String? image,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _location = location;
    _image = image;
  }

  Testimonials.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _location = json['location'];
    _image = json['image'];
  }
  dynamic _id;
  String? _name;
  String? _description;
  String? _location;
  String? _image;
  Testimonials copyWith({
    dynamic id,
    String? name,
    String? description,
    String? location,
    String? image,
  }) =>
      Testimonials(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        location: location ?? _location,
        image: image ?? _image,
      );
  dynamic get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get location => _location;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['location'] = _location;
    map['image'] = _image;
    return map;
  }
}

class Commodites {
  Commodites({
    dynamic id,
    dynamic parentCat,
    String? category,
    String? categorySName,
    dynamic categoryHi,
    dynamic commodityType,
    dynamic hsnCode,
    String? gst,
    dynamic gstOnRent,
    dynamic agSpotCommission,
    dynamic agEmandiCommission,
    dynamic agF2fCommission,
    String? mandiFees,
    String? loading,
    String? bardana,
    String? freight,
    dynamic stackCommQtlVal,
    dynamic firstMileRate,
    String? image,
    String? imagePath,
    dynamic sequenceId,
    dynamic isGrading,
    dynamic forGrading,
    dynamic debitNoteCharges,
    dynamic lowerCircuit,
    dynamic upperCircuit,
    dynamic isFastPath,
    String? month,
    String? expDate,
    dynamic isActive,
    dynamic qualityPCondition,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    String? categoryEn,
  }) {
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
    _categoryEn = categoryEn;
  }

  Commodites.fromJson(dynamic json) {
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
    _categoryEn = json['category_en'];
  }
  dynamic _id;
  dynamic _parentCat;
  String? _category;
  String? _categorySName;
  dynamic _categoryHi;
  dynamic _commodityType;
  dynamic _hsnCode;
  String? _gst;
  dynamic _gstOnRent;
  dynamic _agSpotCommission;
  dynamic _agEmandiCommission;
  dynamic _agF2fCommission;
  String? _mandiFees;
  String? _loading;
  String? _bardana;
  String? _freight;
  dynamic _stackCommQtlVal;
  dynamic _firstMileRate;
  String? _image;
  String? _imagePath;
  dynamic _sequenceId;
  dynamic _isGrading;
  dynamic _forGrading;
  dynamic _debitNoteCharges;
  dynamic _lowerCircuit;
  dynamic _upperCircuit;
  dynamic _isFastPath;
  String? _month;
  String? _expDate;
  dynamic _isActive;
  dynamic _qualityPCondition;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  String? _categoryEn;
  Commodites copyWith({
    dynamic id,
    dynamic parentCat,
    String? category,
    String? categorySName,
    dynamic categoryHi,
    dynamic commodityType,
    dynamic hsnCode,
    String? gst,
    dynamic gstOnRent,
    dynamic agSpotCommission,
    dynamic agEmandiCommission,
    dynamic agF2fCommission,
    String? mandiFees,
    String? loading,
    String? bardana,
    String? freight,
    dynamic stackCommQtlVal,
    dynamic firstMileRate,
    String? image,
    String? imagePath,
    dynamic sequenceId,
    dynamic isGrading,
    dynamic forGrading,
    dynamic debitNoteCharges,
    dynamic lowerCircuit,
    dynamic upperCircuit,
    dynamic isFastPath,
    String? month,
    String? expDate,
    dynamic isActive,
    dynamic qualityPCondition,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    String? categoryEn,
  }) =>
      Commodites(
        id: id ?? _id,
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
        categoryEn: categoryEn ?? _categoryEn,
      );
  dynamic get id => _id;
  dynamic get parentCat => _parentCat;
  String? get category => _category;
  String? get categorySName => _categorySName;
  dynamic get categoryHi => _categoryHi;
  dynamic get commodityType => _commodityType;
  dynamic get hsnCode => _hsnCode;
  String? get gst => _gst;
  dynamic get gstOnRent => _gstOnRent;
  dynamic get agSpotCommission => _agSpotCommission;
  dynamic get agEmandiCommission => _agEmandiCommission;
  dynamic get agF2fCommission => _agF2fCommission;
  String? get mandiFees => _mandiFees;
  String? get loading => _loading;
  String? get bardana => _bardana;
  String? get freight => _freight;
  dynamic get stackCommQtlVal => _stackCommQtlVal;
  dynamic get firstMileRate => _firstMileRate;
  String? get image => _image;
  String? get imagePath => _imagePath;
  dynamic get sequenceId => _sequenceId;
  dynamic get isGrading => _isGrading;
  dynamic get forGrading => _forGrading;
  dynamic get debitNoteCharges => _debitNoteCharges;
  dynamic get lowerCircuit => _lowerCircuit;
  dynamic get upperCircuit => _upperCircuit;
  dynamic get isFastPath => _isFastPath;
  String? get month => _month;
  String? get expDate => _expDate;
  dynamic get isActive => _isActive;
  dynamic get qualityPCondition => _qualityPCondition;
  dynamic get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get categoryEn => _categoryEn;

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
    map['category_en'] = _categoryEn;
    return map;
  }
}

class TodaysPrice {
  TodaysPrice({
    dynamic id,
    dynamic wspId,
    dynamic mandiSamitiId,
    String? warehouseCode,
    dynamic type,
    String? name,
    dynamic nameHi,
    String? facilityIds,
    String? bankIds,
    String? image,
    String? gstImage,
    dynamic gatepassStart,
    dynamic gatepassEnd,
    dynamic noOfStacks,
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
    dynamic rentAmount,
    String? gstArrNumber,
    dynamic agShare,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    List<InnerTodaysPrice>? todaysPrice,
  }) {
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
    _todaysPrice = todaysPrice;
  }

  TodaysPrice.fromJson(dynamic json) {
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
    if (json['todays_price'] != null) {
      _todaysPrice = [];
      json['todays_price'].forEach((v) {
        _todaysPrice?.add(InnerTodaysPrice.fromJson(v));
      });
    }
  }
  dynamic _id;
  dynamic _wspId;
  dynamic _mandiSamitiId;
  String? _warehouseCode;
  dynamic _type;
  String? _name;
  dynamic _nameHi;
  String? _facilityIds;
  String? _bankIds;
  String? _image;
  String? _gstImage;
  dynamic _gatepassStart;
  dynamic _gatepassEnd;
  dynamic _noOfStacks;
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
  dynamic _rentAmount;
  String? _gstArrNumber;
  dynamic _agShare;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  List<InnerTodaysPrice>? _todaysPrice;
  TodaysPrice copyWith({
    dynamic id,
    dynamic wspId,
    dynamic mandiSamitiId,
    String? warehouseCode,
    dynamic type,
    String? name,
    dynamic nameHi,
    String? facilityIds,
    String? bankIds,
    String? image,
    String? gstImage,
    dynamic gatepassStart,
    dynamic gatepassEnd,
    dynamic noOfStacks,
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
    dynamic rentAmount,
    String? gstArrNumber,
    dynamic agShare,
    dynamic status,
    String? createdAt,
    String? updatedAt,
    List<InnerTodaysPrice>? todaysPrice,
  }) =>
      TodaysPrice(
        id: id ?? _id,
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
        todaysPrice: todaysPrice ?? _todaysPrice,
      );
  dynamic get id => _id;
  dynamic get wspId => _wspId;
  dynamic get mandiSamitiId => _mandiSamitiId;
  String? get warehouseCode => _warehouseCode;
  dynamic get type => _type;
  String? get name => _name;
  dynamic get nameHi => _nameHi;
  String? get facilityIds => _facilityIds;
  String? get bankIds => _bankIds;
  String? get image => _image;
  String? get gstImage => _gstImage;
  dynamic get gatepassStart => _gatepassStart;
  dynamic get gatepassEnd => _gatepassEnd;
  dynamic get noOfStacks => _noOfStacks;
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
  dynamic get rentAmount => _rentAmount;
  String? get gstArrNumber => _gstArrNumber;
  dynamic get agShare => _agShare;
  dynamic get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<InnerTodaysPrice>? get todaysPrice => _todaysPrice;

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
    if (_todaysPrice != null) {
      map['todays_price'] = _todaysPrice?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class InnerTodaysPrice {
  TodaysPrice({
    dynamic id,
    String? modal,
    String? max,
    String? min,
    dynamic commodityId,
    dynamic terminalId,
    String? createdAt,
    String? updatedAt,
    dynamic status,
    Commodity? commodity,
  }) {
    _id = id;
    _modal = modal;
    _max = max;
    _min = min;
    _commodityId = commodityId;
    _terminalId = terminalId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _status = status;
    _commodity = commodity;
  }

  InnerTodaysPrice.fromJson(dynamic json) {
    _id = json['id'];
    _modal = json['modal'];
    _max = json['max'];
    _min = json['min'];
    _commodityId = json['commodity_id'];
    _terminalId = json['terminal_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _status = json['status'];
    _commodity = json['commodity'] != null
        ? Commodity.fromJson(json['commodity'])
        : null;
  }
  dynamic _id;
  String? _modal;
  String? _max;
  String? _min;
  dynamic _commodityId;
  dynamic _terminalId;
  String? _createdAt;
  String? _updatedAt;
  dynamic _status;
  Commodity? _commodity;
  InnerTodaysPrice copyWith({
    dynamic id,
    String? modal,
    String? max,
    String? min,
    dynamic commodityId,
    dynamic terminalId,
    String? createdAt,
    String? updatedAt,
    dynamic status,
    Commodity? commodity,
  }) =>
      TodaysPrice(
        id: id ?? _id,
        modal: modal ?? _modal,
        max: max ?? _max,
        min: min ?? _min,
        commodityId: commodityId ?? _commodityId,
        terminalId: terminalId ?? _terminalId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        status: status ?? _status,
        commodity: commodity ?? _commodity,
      );
  dynamic get id => _id;
  String? get modal => _modal;
  String? get max => _max;
  String? get min => _min;
  dynamic get commodityId => _commodityId;
  dynamic get terminalId => _terminalId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get status => _status;
  Commodity? get commodity => _commodity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['modal'] = _modal;
    map['max'] = _max;
    map['min'] = _min;
    map['commodity_id'] = _commodityId;
    map['terminal_id'] = _terminalId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['status'] = _status;
    if (_commodity != null) {
      map['commodity'] = _commodity?.toJson();
    }
    return map;
  }
}

class Commodity {
  Commodity({
    dynamic id,
    dynamic parentCat,
    String? category,
    String? categorySName,
    String? categoryHi,
    String? commodityType,
    dynamic hsnCode,
    String? gst,
    dynamic gstOnRent,
    dynamic agSpotCommission,
    dynamic agEmandiCommission,
    dynamic agF2fCommission,
    String? mandiFees,
    String? loading,
    String? bardana,
    String? freight,
    dynamic stackCommQtlVal,
    dynamic firstMileRate,
    String? image,
    String? imagePath,
    dynamic sequenceId,
    dynamic isGrading,
    dynamic forGrading,
    dynamic debitNoteCharges,
    dynamic lowerCircuit,
    dynamic upperCircuit,
    dynamic isFastPath,
    String? month,
    String? expDate,
    dynamic isActive,
    dynamic qualityPCondition,
    dynamic status,
    String? createdAt,
    String? updatedAt,
  }) {
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

  Commodity.fromJson(dynamic json) {
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
  dynamic _id;
  dynamic _parentCat;
  String? _category;
  String? _categorySName;
  String? _categoryHi;
  String? _commodityType;
  dynamic _hsnCode;
  String? _gst;
  dynamic _gstOnRent;
  dynamic _agSpotCommission;
  dynamic _agEmandiCommission;
  dynamic _agF2fCommission;
  String? _mandiFees;
  String? _loading;
  String? _bardana;
  String? _freight;
  dynamic _stackCommQtlVal;
  dynamic _firstMileRate;
  String? _image;
  String? _imagePath;
  dynamic _sequenceId;
  dynamic _isGrading;
  dynamic _forGrading;
  dynamic _debitNoteCharges;
  dynamic _lowerCircuit;
  dynamic _upperCircuit;
  dynamic _isFastPath;
  String? _month;
  String? _expDate;
  dynamic _isActive;
  dynamic _qualityPCondition;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  Commodity copyWith({
    dynamic id,
    dynamic parentCat,
    String? category,
    String? categorySName,
    String? categoryHi,
    String? commodityType,
    dynamic hsnCode,
    String? gst,
    dynamic gstOnRent,
    dynamic agSpotCommission,
    dynamic agEmandiCommission,
    dynamic agF2fCommission,
    String? mandiFees,
    String? loading,
    String? bardana,
    String? freight,
    dynamic stackCommQtlVal,
    dynamic firstMileRate,
    String? image,
    String? imagePath,
    dynamic sequenceId,
    dynamic isGrading,
    dynamic forGrading,
    dynamic debitNoteCharges,
    dynamic lowerCircuit,
    dynamic upperCircuit,
    dynamic isFastPath,
    String? month,
    String? expDate,
    dynamic isActive,
    dynamic qualityPCondition,
    dynamic status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Commodity(
        id: id ?? _id,
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
  dynamic get id => _id;
  dynamic get parentCat => _parentCat;
  String? get category => _category;
  String? get categorySName => _categorySName;
  String? get categoryHi => _categoryHi;
  String? get commodityType => _commodityType;
  dynamic get hsnCode => _hsnCode;
  String? get gst => _gst;
  dynamic get gstOnRent => _gstOnRent;
  dynamic get agSpotCommission => _agSpotCommission;
  dynamic get agEmandiCommission => _agEmandiCommission;
  dynamic get agF2fCommission => _agF2fCommission;
  String? get mandiFees => _mandiFees;
  String? get loading => _loading;
  String? get bardana => _bardana;
  String? get freight => _freight;
  dynamic get stackCommQtlVal => _stackCommQtlVal;
  dynamic get firstMileRate => _firstMileRate;
  String? get image => _image;
  String? get imagePath => _imagePath;
  dynamic get sequenceId => _sequenceId;
  dynamic get isGrading => _isGrading;
  dynamic get forGrading => _forGrading;
  dynamic get debitNoteCharges => _debitNoteCharges;
  dynamic get lowerCircuit => _lowerCircuit;
  dynamic get upperCircuit => _upperCircuit;
  dynamic get isFastPath => _isFastPath;
  String? get month => _month;
  String? get expDate => _expDate;
  dynamic get isActive => _isActive;
  dynamic get qualityPCondition => _qualityPCondition;
  dynamic get status => _status;
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
