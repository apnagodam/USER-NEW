// To parse this JSON data, do
//
//     final spotOrdersResponseModel = spotOrdersResponseModelFromMap(jsonString);

import 'dart:convert';

SpotOrdersResponseModel spotOrdersResponseModelFromMap(String str) => SpotOrdersResponseModel.fromMap(json.decode(str));

String spotOrdersResponseModelToMap(SpotOrdersResponseModel data) => json.encode(data.toMap());

class SpotOrdersResponseModel {
  List<Datum>? data;
  dynamic status;
  dynamic message;

  SpotOrdersResponseModel({
    this.data,
    this.status,
    this.message,
  });

  factory SpotOrdersResponseModel.fromMap(Map<String, dynamic> json) => SpotOrdersResponseModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "status": status,
    "message": message,
  };
}

class Datum {
  dynamic id;
  dynamic orderId;
  dynamic lpType;
  dynamic sellerUserId;
  dynamic lpUserId;
  dynamic buyerUserId;
  dynamic buyerUserId2;
  dynamic corporateUserId;
  dynamic terminalId;
  dynamic vehicleId;
  dynamic inventoryId;
  dynamic lpTotalKm;
  dynamic pqpk;
  dynamic requestTime;
  dynamic acceptTime;
  dynamic userAmount;
  dynamic buyerAmount;
  dynamic lpAmount;
  dynamic agCommissionPercent;
  dynamic agCommissionAmount;
  dynamic lpCommissionPercent;
  dynamic lpCommissionAmount;
  dynamic lpCancelReason;
  dynamic userCancelReason;
  dynamic cancelledBy;
  dynamic userPaymentStatus;
  dynamic lpPaymentStatus;
  dynamic lpLong;
  dynamic borkerCharge;
  dynamic arrivalTime;
  dynamic requestStatus;
  dynamic bookingStatus;
  dynamic priceAccept;
  dynamic tripStatus;
  dynamic seen;
  dynamic conectorName;
  dynamic labourContractor;
  dynamic tharesarContractorId;
  dynamic transpoterContractorId;
  dynamic intentionPrice;
  dynamic intentionWeight;
  dynamic intentionOtp;
  dynamic intentionExpiryDate;
  dynamic token;
  dynamic isIntention;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  Warehouse? warehouse;
  List<Qv>? qv;
  Inventory? inventory;
  Orderprice? orderprice;
  Orderlocation? orderlocation;
  Orderweight? orderweight;

  Datum({
    this.id,
    this.orderId,
    this.lpType,
    this.sellerUserId,
    this.lpUserId,
    this.buyerUserId,
    this.buyerUserId2,
    this.corporateUserId,
    this.terminalId,
    this.vehicleId,
    this.inventoryId,
    this.lpTotalKm,
    this.pqpk,
    this.requestTime,
    this.acceptTime,
    this.userAmount,
    this.buyerAmount,
    this.lpAmount,
    this.agCommissionPercent,
    this.agCommissionAmount,
    this.lpCommissionPercent,
    this.lpCommissionAmount,
    this.lpCancelReason,
    this.userCancelReason,
    this.cancelledBy,
    this.userPaymentStatus,
    this.lpPaymentStatus,
    this.lpLong,
    this.borkerCharge,
    this.arrivalTime,
    this.requestStatus,
    this.bookingStatus,
    this.priceAccept,
    this.tripStatus,
    this.seen,
    this.conectorName,
    this.labourContractor,
    this.tharesarContractorId,
    this.transpoterContractorId,
    this.intentionPrice,
    this.intentionWeight,
    this.intentionOtp,
    this.intentionExpiryDate,
    this.token,
    this.isIntention,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.warehouse,
    this.qv,
    this.inventory,
    this.orderprice,
    this.orderlocation,
    this.orderweight,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderId: json["order_id"],
    lpType: json["lp_type"],
    sellerUserId: json["seller_user_id"],
    lpUserId: json["lp_user_id"],
    buyerUserId: json["buyer_user_id"],
    buyerUserId2: json["buyer_user_id_2"],
    corporateUserId: json["corporate_user_id"],
    terminalId: json["terminal_id"],
    vehicleId: json["vehicle_id"],
    inventoryId: json["inventory_id"],
    lpTotalKm: json["lp_total_km"],
    pqpk: json["pqpk"],
    requestTime: json["request_time"],
    acceptTime: json["accept_time"],
    userAmount: json["user_amount"],
    buyerAmount: json["buyer_amount"],
    lpAmount: json["lp_amount"],
    agCommissionPercent: json["ag_commission_percent"],
    agCommissionAmount: json["ag_commission_amount"],
    lpCommissionPercent: json["lp_commission_percent"],
    lpCommissionAmount: json["lp_commission_amount"],
    lpCancelReason: json["lp_cancel_reason"],
    userCancelReason: json["user_cancel_reason"],
    cancelledBy: json["cancelled_by"],
    userPaymentStatus: json["user_payment_status"],
    lpPaymentStatus: json["lp_payment_status"],
    lpLong: json["lp_long"],
    borkerCharge: json["borker_charge"],
    arrivalTime: json["arrival_time"],
    requestStatus: json["request_status"],
    bookingStatus: json["booking_status"],
    priceAccept: json["price_accept"],
    tripStatus: json["trip_status"],
    seen: json["seen"],
    conectorName: json["conector_name"],
    labourContractor: json["labour_contractor"],
    tharesarContractorId: json["tharesar_contractor_id"],
    transpoterContractorId: json["transpoter_contractor_id"],
    intentionPrice: json["intention_price"],
    intentionWeight: json["intention_weight"],
    intentionOtp: json["intention_otp"],
    intentionExpiryDate: json["intention_expiry_date"],
    token: json["token"],
    isIntention: json["is_intention"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    warehouse: json["warehouse"] == null ? null : Warehouse.fromMap(json["warehouse"]),
    qv: json["qv"] == null ? [] : List<Qv>.from(json["qv"]!.map((x) => Qv.fromMap(x))),
    inventory: json["inventory"] == null ? null : Inventory.fromMap(json["inventory"]),
    orderprice: json["orderprice"] == null ? null : Orderprice.fromMap(json["orderprice"]),
    orderlocation: json["orderlocation"] == null ? null : Orderlocation.fromMap(json["orderlocation"]),
    orderweight: json["orderweight"] == null ? null : Orderweight.fromMap(json["orderweight"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "lp_type": lpType,
    "seller_user_id": sellerUserId,
    "lp_user_id": lpUserId,
    "buyer_user_id": buyerUserId,
    "buyer_user_id_2": buyerUserId2,
    "corporate_user_id": corporateUserId,
    "terminal_id": terminalId,
    "vehicle_id": vehicleId,
    "inventory_id": inventoryId,
    "lp_total_km": lpTotalKm,
    "pqpk": pqpk,
    "request_time": requestTime,
    "accept_time": acceptTime,
    "user_amount": userAmount,
    "buyer_amount": buyerAmount,
    "lp_amount": lpAmount,
    "ag_commission_percent": agCommissionPercent,
    "ag_commission_amount": agCommissionAmount,
    "lp_commission_percent": lpCommissionPercent,
    "lp_commission_amount": lpCommissionAmount,
    "lp_cancel_reason": lpCancelReason,
    "user_cancel_reason": userCancelReason,
    "cancelled_by": cancelledBy,
    "user_payment_status": userPaymentStatus,
    "lp_payment_status": lpPaymentStatus,
    "lp_long": lpLong,
    "borker_charge": borkerCharge,
    "arrival_time": arrivalTime,
    "request_status": requestStatus,
    "booking_status": bookingStatus,
    "price_accept": priceAccept,
    "trip_status": tripStatus,
    "seen": seen,
    "conector_name": conectorName,
    "labour_contractor": labourContractor,
    "tharesar_contractor_id": tharesarContractorId,
    "transpoter_contractor_id": transpoterContractorId,
    "intention_price": intentionPrice,
    "intention_weight": intentionWeight,
    "intention_otp": intentionOtp,
    "intention_expiry_date": intentionExpiryDate,
    "token": token,
    "is_intention": isIntention,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "warehouse": warehouse?.toMap(),
    "qv": qv == null ? [] : List<dynamic>.from(qv!.map((x) => x.toMap())),
    "inventory": inventory?.toMap(),
    "orderprice": orderprice?.toMap(),
    "orderlocation": orderlocation?.toMap(),
    "orderweight": orderweight?.toMap(),
  };
}

class Inventory {
  dynamic id;
  dynamic dealUserType;
  dynamic userId;
  dynamic warehouseId;
  dynamic commodity;
  dynamic location;
  dynamic state;
  dynamic type;
  dynamic quantity;
  dynamic price;
  dynamic qualityCategory;
  dynamic sellQuantity;
  dynamic image;
  dynamic commodityImage;
  dynamic bankSlip;
  dynamic commodityImagePath;
  dynamic salesStatus;
  dynamic liveLatitude;
  dynamic liveLongitude;
  dynamic dealType;
  dynamic qualityGrade;
  dynamic bags;
  dynamic notes;
  dynamic farmerMoisture;
  dynamic farmerDana;
  dynamic farmerTikki;
  dynamic status;
  dynamic paymentMode;
  dynamic createdAt;
  dynamic updatedAt;
  Category? category;

  Inventory({
    this.id,
    this.dealUserType,
    this.userId,
    this.warehouseId,
    this.commodity,
    this.location,
    this.state,
    this.type,
    this.quantity,
    this.price,
    this.qualityCategory,
    this.sellQuantity,
    this.image,
    this.commodityImage,
    this.bankSlip,
    this.commodityImagePath,
    this.salesStatus,
    this.liveLatitude,
    this.liveLongitude,
    this.dealType,
    this.qualityGrade,
    this.bags,
    this.notes,
    this.farmerMoisture,
    this.farmerDana,
    this.farmerTikki,
    this.status,
    this.paymentMode,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Inventory.fromMap(Map<String, dynamic> json) => Inventory(
    id: json["id"],
    dealUserType: json["deal_user_type"],
    userId: json["user_id"],
    warehouseId: json["warehouse_id"],
    commodity: json["commodity"],
    location: json["location"],
    state: json["state"],
    type: json["type"],
    quantity: json["quantity"],
    price: json["price"],
    qualityCategory: json["quality_category"],
    sellQuantity: json["sell_quantity"],
    image: json["image"],
    commodityImage: json["commodity_image"],
    bankSlip: json["Bank_slip"],
    commodityImagePath: json["commodity_image_path"],
    salesStatus: json["sales_status"],
    liveLatitude: json["live_latitude"],
    liveLongitude: json["live_longitude"],
    dealType: json["Deal_Type"],
    qualityGrade: json["quality_grade"],
    bags: json["bags"],
    notes: json["notes"],
    farmerMoisture: json["farmer_moisture"],
    farmerDana: json["farmer_dana"],
    farmerTikki: json["farmer_tikki"],
    status: json["status"],
    paymentMode: json["Payment_mode"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    category: json["category"] == null ? null : Category.fromMap(json["category"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "deal_user_type": dealUserType,
    "user_id": userId,
    "warehouse_id": warehouseId,
    "commodity": commodity,
    "location": location,
    "state": state,
    "type": type,
    "quantity": quantity,
    "price": price,
    "quality_category": qualityCategory,
    "sell_quantity": sellQuantity,
    "image": image,
    "commodity_image": commodityImage,
    "Bank_slip": bankSlip,
    "commodity_image_path": commodityImagePath,
    "sales_status": salesStatus,
    "live_latitude": liveLatitude,
    "live_longitude": liveLongitude,
    "Deal_Type": dealType,
    "quality_grade": qualityGrade,
    "bags": bags,
    "notes": notes,
    "farmer_moisture": farmerMoisture,
    "farmer_dana": farmerDana,
    "farmer_tikki": farmerTikki,
    "status": status,
    "Payment_mode": paymentMode,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "category": category?.toMap(),
  };
}

class Category {
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
  DateTime? month;
  DateTime? expDate;
  dynamic isActive;
  dynamic qualityPCondition;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Category({
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
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Orderlocation {
  dynamic id;
  dynamic orderId;
  dynamic lpLat;
  dynamic lpLong;
  dynamic userLat;
  dynamic userLong;
  dynamic terminalLat;
  dynamic terminalLong;
  dynamic lpToUserKm;
  dynamic userToTerminalKm;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Orderlocation({
    this.id,
    this.orderId,
    this.lpLat,
    this.lpLong,
    this.userLat,
    this.userLong,
    this.terminalLat,
    this.terminalLong,
    this.lpToUserKm,
    this.userToTerminalKm,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Orderlocation.fromMap(Map<String, dynamic> json) => Orderlocation(
    id: json["id"],
    orderId: json["order_id"],
    lpLat: json["lp_lat"],
    lpLong: json["lp_long"],
    userLat: json["user_lat"],
    userLong: json["user_long"],
    terminalLat: json["terminal_lat"],
    terminalLong: json["terminal_long"],
    lpToUserKm: json["lp_to_user_km"],
    userToTerminalKm: json["user_to_terminal_km"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "lp_lat": lpLat,
    "lp_long": lpLong,
    "user_lat": userLat,
    "user_long": userLong,
    "terminal_lat": terminalLat,
    "terminal_long": terminalLong,
    "lp_to_user_km": lpToUserKm,
    "user_to_terminal_km": userToTerminalKm,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Orderprice {
  dynamic id;
  dynamic orderId;
  dynamic corporatePrice;
  dynamic takeHomePrice;
  dynamic subPrice;
  dynamic finalPrice;
  dynamic priceVariation;
  dynamic moisture;
  dynamic broken;
  dynamic thin;
  dynamic fm;
  dynamic tcw;
  dynamic tikki;
  dynamic bagsType;
  dynamic bagsPrice;
  dynamic qualityGrade;
  dynamic labourQtlPrice;
  dynamic qtlTransportPrice;
  dynamic corporateBuyerPrice;
  dynamic mandiTaxRate;
  dynamic mandiPrice;
  dynamic bardanaPrice;
  dynamic gst;
  dynamic gstAmount;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Orderprice({
    this.id,
    this.orderId,
    this.corporatePrice,
    this.takeHomePrice,
    this.subPrice,
    this.finalPrice,
    this.priceVariation,
    this.moisture,
    this.broken,
    this.thin,
    this.fm,
    this.tcw,
    this.tikki,
    this.bagsType,
    this.bagsPrice,
    this.qualityGrade,
    this.labourQtlPrice,
    this.qtlTransportPrice,
    this.corporateBuyerPrice,
    this.mandiTaxRate,
    this.mandiPrice,
    this.bardanaPrice,
    this.gst,
    this.gstAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Orderprice.fromMap(Map<String, dynamic> json) => Orderprice(
    id: json["id"],
    orderId: json["order_id"],
    corporatePrice: json["corporate_price"],
    takeHomePrice: json["take_home_price"],
    subPrice: json["sub_price"],
    finalPrice: json["final_price"],
    priceVariation: json["price_variation"],
    moisture: json["moisture"],
    broken: json["broken"],
    thin: json["thin"],
    fm: json["fm"],
    tcw: json["tcw"],
    tikki: json["tikki"],
    bagsType: json["bags_type"],
    bagsPrice: json["bags_price"],
    qualityGrade: json["quality_grade"],
    labourQtlPrice: json["labour_qtl_price"],
    qtlTransportPrice: json["qtl_transport_price"],
    corporateBuyerPrice: json["corporate_buyer_price"],
    mandiTaxRate: json["mandi_tax_rate"],
    mandiPrice: json["mandi_price"],
    bardanaPrice: json["bardana_price"],
    gst: json["gst"],
    gstAmount: json["gst_amount"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "corporate_price": corporatePrice,
    "take_home_price": takeHomePrice,
    "sub_price": subPrice,
    "final_price": finalPrice,
    "price_variation": priceVariation,
    "moisture": moisture,
    "broken": broken,
    "thin": thin,
    "fm": fm,
    "tcw": tcw,
    "tikki": tikki,
    "bags_type": bagsType,
    "bags_price": bagsPrice,
    "quality_grade": qualityGrade,
    "labour_qtl_price": labourQtlPrice,
    "qtl_transport_price": qtlTransportPrice,
    "corporate_buyer_price": corporateBuyerPrice,
    "mandi_tax_rate": mandiTaxRate,
    "mandi_price": mandiPrice,
    "bardana_price": bardanaPrice,
    "gst": gst,
    "gst_amount": gstAmount,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Orderweight {
  dynamic id;
  dynamic orderId;
  dynamic weightType;
  dynamic weight;
  dynamic noOfBags;
  dynamic commodityWeightImg;
  dynamic fristKantaParchi;
  dynamic secondKantaParchi;
  dynamic kantaParchiPath;
  dynamic connectorPaymentMode;
  dynamic connectorTotalAmount;
  dynamic thresherPaymentMode;
  dynamic thresherTotalPayment;
  dynamic labourPaymentMode;
  dynamic labourTotalPayment;
  dynamic transporterTotalPayment;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Orderweight({
    this.id,
    this.orderId,
    this.weightType,
    this.weight,
    this.noOfBags,
    this.commodityWeightImg,
    this.fristKantaParchi,
    this.secondKantaParchi,
    this.kantaParchiPath,
    this.connectorPaymentMode,
    this.connectorTotalAmount,
    this.thresherPaymentMode,
    this.thresherTotalPayment,
    this.labourPaymentMode,
    this.labourTotalPayment,
    this.transporterTotalPayment,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Orderweight.fromMap(Map<String, dynamic> json) => Orderweight(
    id: json["id"],
    orderId: json["order_id"],
    weightType: json["weight_type"],
    weight: json["weight"],
    noOfBags: json["no_of_bags"],
    commodityWeightImg: json["commodity_weight_img"],
    fristKantaParchi: json["frist_kanta_parchi"],
    secondKantaParchi: json["second_kanta_parchi"],
    kantaParchiPath: json["kanta_parchi_path"],
    connectorPaymentMode: json["connector_payment_mode"],
    connectorTotalAmount: json["connector_total_amount"],
    thresherPaymentMode: json["thresher_payment_mode"],
    thresherTotalPayment: json["thresher_total_payment"],
    labourPaymentMode: json["labour_payment_mode"],
    labourTotalPayment: json["labour_total_payment"],
    transporterTotalPayment: json["transporter_total_payment"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "weight_type": weightType,
    "weight": weight,
    "no_of_bags": noOfBags,
    "commodity_weight_img": commodityWeightImg,
    "frist_kanta_parchi": fristKantaParchi,
    "second_kanta_parchi": secondKantaParchi,
    "kanta_parchi_path": kantaParchiPath,
    "connector_payment_mode": connectorPaymentMode,
    "connector_total_amount": connectorTotalAmount,
    "thresher_payment_mode": thresherPaymentMode,
    "thresher_total_payment": thresherTotalPayment,
    "labour_payment_mode": labourPaymentMode,
    "labour_total_payment": labourTotalPayment,
    "transporter_total_payment": transporterTotalPayment,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Qv {
  dynamic id;
  dynamic orderId;
  dynamic parameter;
  dynamic normalQuality;
  dynamic extremeQuality;
  dynamic actualQuality;
  dynamic difference;
  dynamic date;

  Qv({
    this.id,
    this.orderId,
    this.parameter,
    this.normalQuality,
    this.extremeQuality,
    this.actualQuality,
    this.difference,
    this.date,
  });

  factory Qv.fromMap(Map<String, dynamic> json) => Qv(
    id: json["id"],
    orderId: json["order_id"],
    parameter: json["parameter"],
    normalQuality: json["normal_quality"],
    extremeQuality: json["extreme_quality"],
    actualQuality: json["actual_quality"],
    difference: json["difference"],
    date: json["date"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "parameter": parameter,
    "normal_quality": normalQuality,
    "extreme_quality": extremeQuality,
    "actual_quality": actualQuality,
    "difference": difference,
    "date": date,
  };
}

class Warehouse {
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

  Warehouse({
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
  });

  factory Warehouse.fromMap(Map<String, dynamic> json) => Warehouse(
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
    agrementFromDate: json["agrement_from_date"],
    agrementToDate: json["agrement_to_date"],
    terminalOpenDate: json["terminal_open_date"],
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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    "agrement_from_date": agrementFromDate,
    "agrement_to_date": agrementToDate,
    "terminal_open_date": terminalOpenDate,
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
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
