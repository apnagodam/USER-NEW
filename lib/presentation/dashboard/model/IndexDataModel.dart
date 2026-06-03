// To parse this JSON data, do
//
//     final indexDataModel = indexDataModelFromMap(jsonString);

import 'dart:convert';

IndexDataModel indexDataModelFromMap(String str) => IndexDataModel.fromMap(json.decode(str));

String indexDataModelToMap(IndexDataModel data) => json.encode(data.toMap());

class IndexDataModel {
  List<IndexDataModelTodaysPrice>? todaysPrice;
  List<Commodit>? commodites;
  List<Testimonial>? testimonials;
  dynamic status;
  dynamic message;

  IndexDataModel({
    this.todaysPrice,
    this.commodites,
    this.testimonials,
    this.status,
    this.message,
  });

  factory IndexDataModel.fromMap(Map<String, dynamic> json) => IndexDataModel(
    todaysPrice: json["todays_price"] == null ? [] : List<IndexDataModelTodaysPrice>.from(json["todays_price"]!.map((x) => IndexDataModelTodaysPrice.fromMap(x))),
    commodites: json["commodites"] == null ? [] : List<Commodit>.from(json["commodites"]!.map((x) => Commodit.fromMap(x))),
    testimonials: json["testimonials"] == null ? [] : List<Testimonial>.from(json["testimonials"]!.map((x) => Testimonial.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "todays_price": todaysPrice == null ? [] : List<dynamic>.from(todaysPrice!.map((x) => x.toMap())),
    "commodites": commodites == null ? [] : List<dynamic>.from(commodites!.map((x) => x.toMap())),
    "testimonials": testimonials == null ? [] : List<dynamic>.from(testimonials!.map((x) => x.toMap())),
    "status": status,
    "message": message,
  };
}

class Commodit {
  dynamic id;
  dynamic parentCat;
  dynamic category;
  dynamic categorySName;
  dynamic categoryHi;
  dynamic commodityType;
  dynamic hsnCode;
  dynamic gst;
  dynamic gstOnRent;
  dynamic agSpotCommission;
  dynamic agEmandiCommission;
  dynamic agF2FCommission;
  dynamic mandiFees;
  dynamic loading;
  dynamic bardana;
  dynamic freight;
  dynamic stackCommQtlVal;
  dynamic firstMileRate;
  dynamic image;
  dynamic imagePath;
  dynamic sequenceId;
  dynamic isGrading;
  dynamic forGrading;
  dynamic debitNoteCharges;
  dynamic lowerCircuit;
  dynamic upperCircuit;
  dynamic isFastPath;
  dynamic month;
  dynamic expDate;
  dynamic isActive;
  dynamic qualityPCondition;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic categoryEn;

  Commodit({
    this.id,
    this.parentCat,
    this.category,
    this.categorySName,
    this.categoryHi,
    this.commodityType,
    this.hsnCode,
    this.gst,
    this.gstOnRent,
    this.agSpotCommission,
    this.agEmandiCommission,
    this.agF2FCommission,
    this.mandiFees,
    this.loading,
    this.bardana,
    this.freight,
    this.stackCommQtlVal,
    this.firstMileRate,
    this.image,
    this.imagePath,
    this.sequenceId,
    this.isGrading,
    this.forGrading,
    this.debitNoteCharges,
    this.lowerCircuit,
    this.upperCircuit,
    this.isFastPath,
    this.month,
    this.expDate,
    this.isActive,
    this.qualityPCondition,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.categoryEn,
  });

  factory Commodit.fromMap(Map<String, dynamic> json) => Commodit(
    id: json["id"],
    parentCat: json["parent_cat"],
    category: json["category"],
    categorySName: json["category_s_name"],
    categoryHi: json["category_hi"],
    commodityType: json["commodity_type"],
    hsnCode: json["hsn_code"],
    gst: json["gst"],
    gstOnRent: json["gst_on_rent"],
    agSpotCommission: json["ag_spot_commission"],
    agEmandiCommission: json["ag_emandi_commission"],
    agF2FCommission: json["ag_f2f_commission"],
    mandiFees: json["mandi_fees"],
    loading: json["loading"],
    bardana: json["bardana"],
    freight: json["freight"],
    stackCommQtlVal: json["stack_comm_qtl_val"],
    firstMileRate: json["first_mile_rate"],
    image: json["image"],
    imagePath: json["image_path"],
    sequenceId: json["sequence_id"],
    isGrading: json["is_grading"],
    forGrading: json["for_grading"],
    debitNoteCharges: json["debit_note_charges"],
    lowerCircuit: json["lower_circuit"],
    upperCircuit: json["upper_circuit"],
    isFastPath: json["is_fast_path"],
    month: json["month"] == null ? null : DateTime.parse(json["month"]),
    expDate: json["exp_date"] == null ? null : DateTime.parse(json["exp_date"]),
    isActive: json["is_active"],
    qualityPCondition: json["quality_p_condition"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    categoryEn: json["category_en"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "parent_cat": parentCat,
    "category": category,
    "category_s_name": categorySName,
    "category_hi": categoryHi,
    "commodity_type": commodityType,
    "hsn_code": hsnCode,
    "gst": gst,
    "gst_on_rent": gstOnRent,
    "ag_spot_commission": agSpotCommission,
    "ag_emandi_commission": agEmandiCommission,
    "ag_f2f_commission": agF2FCommission,
    "mandi_fees": mandiFees,
    "loading": loading,
    "bardana": bardana,
    "freight": freight,
    "stack_comm_qtl_val": stackCommQtlVal,
    "first_mile_rate": firstMileRate,
    "image": image,
    "image_path": imagePath,
    "sequence_id": sequenceId,
    "is_grading": isGrading,
    "for_grading": forGrading,
    "debit_note_charges": debitNoteCharges,
    "lower_circuit": lowerCircuit,
    "upper_circuit": upperCircuit,
    "is_fast_path": isFastPath,
    "month": "${month!.year.toString().padLeft(4, '0')}-${month!.month.toString().padLeft(2, '0')}-${month!.day.toString().padLeft(2, '0')}",
    "exp_date": "${expDate!.year.toString().padLeft(4, '0')}-${expDate!.month.toString().padLeft(2, '0')}-${expDate!.day.toString().padLeft(2, '0')}",
    "is_active": isActive,
    "quality_p_condition": qualityPCondition,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category_en": categoryEn,
  };
}

class Testimonial {
  dynamic id;
  dynamic name;
  dynamic description;
  dynamic location;
  dynamic image;

  Testimonial({
    this.id,
    this.name,
    this.description,
    this.location,
    this.image,
  });

  factory Testimonial.fromMap(Map<String, dynamic> json) => Testimonial(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    location: json["location"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "location": location,
    "image": image,
  };
}

class IndexDataModelTodaysPrice {
  dynamic id;
  dynamic wspId;
  dynamic mandiSamitiId;
  dynamic warehouseCode;
  dynamic type;
  dynamic name;
  dynamic nameHi;
  dynamic facilityIds;
  dynamic bankIds;
  dynamic image;
  dynamic gstImage;
  dynamic gatepassStart;
  dynamic gatepassEnd;
  dynamic noOfStacks;
  dynamic dharamKanta;
  dynamic labourContractor;
  dynamic contractorPhone;
  dynamic labourRate;
  dynamic latitude;
  dynamic longitude;
  dynamic pincode;
  dynamic agrementFromDate;
  dynamic agrementToDate;
  dynamic terminalOpenDate;
  dynamic terminalCloseDate;
  dynamic rentAmount;
  dynamic gstArrNumber;
  dynamic agShare;
  dynamic wdraAgreement;
  dynamic wdraAgreementId;
  dynamic wspRent;
  dynamic fixRentPerMonth;
  dynamic minRent;
  dynamic maxRent;
  dynamic wspSharing;
  dynamic lockIn;
  dynamic mixLockIn;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  List<TodaysPriceTodaysPrice>? todaysPrice;

  IndexDataModelTodaysPrice({
    this.id,
    this.wspId,
    this.mandiSamitiId,
    this.warehouseCode,
    this.type,
    this.name,
    this.nameHi,
    this.facilityIds,
    this.bankIds,
    this.image,
    this.gstImage,
    this.gatepassStart,
    this.gatepassEnd,
    this.noOfStacks,
    this.dharamKanta,
    this.labourContractor,
    this.contractorPhone,
    this.labourRate,
    this.latitude,
    this.longitude,
    this.pincode,
    this.agrementFromDate,
    this.agrementToDate,
    this.terminalOpenDate,
    this.terminalCloseDate,
    this.rentAmount,
    this.gstArrNumber,
    this.agShare,
    this.wdraAgreement,
    this.wdraAgreementId,
    this.wspRent,
    this.fixRentPerMonth,
    this.minRent,
    this.maxRent,
    this.wspSharing,
    this.lockIn,
    this.mixLockIn,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.todaysPrice,
  });

  factory IndexDataModelTodaysPrice.fromMap(Map<String, dynamic> json) => IndexDataModelTodaysPrice(
    id: json["id"],
    wspId: json["wsp_id"],
    mandiSamitiId: json["mandi_samiti_id"],
    warehouseCode: json["warehouse_code"],
    type: json["type"],
    name: json["name"],
    nameHi: json["name_hi"],
    facilityIds: json["facility_ids"],
    bankIds: json["bank_ids"],
    image: json["image"],
    gstImage: json["gst_image"],
    gatepassStart: json["gatepass_start"],
    gatepassEnd: json["gatepass_end"],
    noOfStacks: json["no_of_stacks"],
    dharamKanta: json["dharam_kanta"],
    labourContractor: json["labour_contractor"],
    contractorPhone: json["contractor_phone"],
    labourRate: json["labour_rate"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    pincode: json["pincode"],
    agrementFromDate: json["agrement_from_date"] == null ? null : DateTime.parse(json["agrement_from_date"]),
    agrementToDate: json["agrement_to_date"] == null ? null : DateTime.parse(json["agrement_to_date"]),
    terminalOpenDate: json["terminal_open_date"] == null ? null : DateTime.parse(json["terminal_open_date"]),
    terminalCloseDate: json["terminal_close_date"],
    rentAmount: json["rent_amount"],
    gstArrNumber: json["gst_arr_number"],
    agShare: json["ag_share"],
    wdraAgreement: json["wdra_agreement"],
    wdraAgreementId: json["wdra_agreement_id"],
    wspRent: json["wsp_rent"],
    fixRentPerMonth: json["fix_rent_per_month"],
    minRent: json["min_rent"],
    maxRent: json["max_rent"],
    wspSharing: json["wsp_sharing"],
    lockIn: json["lock_in"],
    mixLockIn: json["mix_lock_in"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    todaysPrice: json["todays_price"] == null ? [] : List<TodaysPriceTodaysPrice>.from(json["todays_price"]!.map((x) => TodaysPriceTodaysPrice.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "wsp_id": wspId,
    "mandi_samiti_id": mandiSamitiId,
    "warehouse_code": warehouseCode,
    "type": type,
    "name": name,
    "name_hi": nameHi,
    "facility_ids": facilityIds,
    "bank_ids": bankIds,
    "image": image,
    "gst_image": gstImage,
    "gatepass_start": gatepassStart,
    "gatepass_end": gatepassEnd,
    "no_of_stacks": noOfStacks,
    "dharam_kanta": dharamKanta,
    "labour_contractor": labourContractor,
    "contractor_phone": contractorPhone,
    "labour_rate": labourRate,
    "latitude": latitude,
    "longitude": longitude,
    "pincode": pincode,
    "agrement_from_date": agrementFromDate?.toIso8601String(),
    "agrement_to_date": agrementToDate?.toIso8601String(),
    "terminal_open_date": terminalOpenDate?.toIso8601String(),
    "terminal_close_date": terminalCloseDate,
    "rent_amount": rentAmount,
    "gst_arr_number": gstArrNumber,
    "ag_share": agShare,
    "wdra_agreement": wdraAgreement,
    "wdra_agreement_id": wdraAgreementId,
    "wsp_rent": wspRent,
    "fix_rent_per_month": fixRentPerMonth,
    "min_rent": minRent,
    "max_rent": maxRent,
    "wsp_sharing": wspSharing,
    "lock_in": lockIn,
    "mix_lock_in": mixLockIn,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "todays_price": todaysPrice == null ? [] : List<dynamic>.from(todaysPrice!.map((x) => x.toMap())),
  };
}

class TodaysPriceTodaysPrice {
  dynamic id;
  dynamic modal;
  dynamic max;
  dynamic min;
  dynamic commodityId;
  dynamic terminalId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic status;
  Commodit? commodity;

  TodaysPriceTodaysPrice({
    this.id,
    this.modal,
    this.max,
    this.min,
    this.commodityId,
    this.terminalId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.commodity,
  });

  factory TodaysPriceTodaysPrice.fromMap(Map<String, dynamic> json) => TodaysPriceTodaysPrice(
    id: json["id"],
    modal: json["modal"],
    max: json["max"],
    min: json["min"],
    commodityId: json["commodity_id"],
    terminalId: json["terminal_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    status: json["status"],
    commodity: json["commodity"] == null ? null : Commodit.fromMap(json["commodity"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "modal": modal,
    "max": max,
    "min": min,
    "commodity_id": commodityId,
    "terminal_id": terminalId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "status": status,
    "commodity": commodity?.toMap(),
  };
}
