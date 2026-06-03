// To parse this JSON data, do
//
//     final allBookingsModel = allBookingsModelFromMap(jsonString);

import 'dart:convert';

AllBookingsModel allBookingsModelFromMap(String str) => AllBookingsModel.fromMap(json.decode(str));

String allBookingsModelToMap(AllBookingsModel data) => json.encode(data.toMap());

class AllBookingsModel {
  List<Order>? orders;
  int? status;
  String? message;

  AllBookingsModel({
    this.orders,
    this.status,
    this.message,
  });

  factory AllBookingsModel.fromMap(Map<String, dynamic> json) => AllBookingsModel(
    orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toMap())),
    "status": status,
    "message": message,
  };
}

class Order {
  int? id;
  String? orderId;
  int? lpType;
  int? sellerUserId;
  int? lpUserId;
  int? buyerUserId;
  dynamic buyerUserId2;
  int? corporateUserId;
  int? terminalId;
  int? vehicleId;
  int? inventoryId;
  dynamic lpTotalKm;
  dynamic pqpk;
  DateTime? requestTime;
  DateTime? acceptTime;
  dynamic userAmount;
  dynamic buyerAmount;
  dynamic lpAmount;
  String? agCommissionPercent;
  String? agCommissionAmount;
  int? lpCommissionPercent;
  String? lpCommissionAmount;
  dynamic lpCancelReason;
  dynamic userCancelReason;
  dynamic cancelledBy;
  int? userPaymentStatus;
  int? lpPaymentStatus;
  String? lpLong;
  int? borkerCharge;
  dynamic arrivalTime;
  int? requestStatus;
  int? bookingStatus;
  int? priceAccept;
  int? tripStatus;
  int? seen;
  dynamic conectorName;
  dynamic labourContractor;
  dynamic tharesarContractorId;
  dynamic transpoterContractorId;
  dynamic intentionPrice;
  int? intentionWeight;
  dynamic intentionOtp;
  dynamic intentionExpiryDate;
  dynamic token;
  int? isIntention;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? lpLat;
  String? userLat;
  String? userLong;
  String? terminalLat;
  String? terminalLong;
  int? lpToUserKm;
  int? userToTerminalKm;
  int? otp;
  int? otpStatus;
  DateTime? otpCreateDate;
  DateTime? otpUpdateDate;
  String? takeHomePrice;
  String? finalPrice;
  String? priceVariation;
  dynamic moisture;
  dynamic broken;
  dynamic tcw;
  dynamic fm;
  dynamic thin;
  dynamic qualityGrade;
  DateTime? pricingCreateDate;
  DateTime? pricingUpdateDate;
  int? pricingStatus;
  String? mandiPrice;
  dynamic weightType;
  dynamic weight;
  dynamic noOfBags;
  dynamic fristKantaParchi;
  dynamic secondKantaParchi;
  dynamic kantaParchiPath;
  dynamic weightCreateDate;
  dynamic weightUpdateDate;
  dynamic weightStatus;
  dynamic customerCopy;
  dynamic lpCopy;
  dynamic terminalCopy;
  dynamic customerCopyTime;
  dynamic lpCopyTime;
  dynamic terminalCopyTime;
  String? terminalName;
  String? vehicleNo;
  String? quantity;
  String? commodityImagePath;
  String? commodityImage;
  String? category;
  String? name;
  String? passportImage;
  String? imagePath;

  Order({
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
    this.lpLat,
    this.userLat,
    this.userLong,
    this.terminalLat,
    this.terminalLong,
    this.lpToUserKm,
    this.userToTerminalKm,
    this.otp,
    this.otpStatus,
    this.otpCreateDate,
    this.otpUpdateDate,
    this.takeHomePrice,
    this.finalPrice,
    this.priceVariation,
    this.moisture,
    this.broken,
    this.tcw,
    this.fm,
    this.thin,
    this.qualityGrade,
    this.pricingCreateDate,
    this.pricingUpdateDate,
    this.pricingStatus,
    this.mandiPrice,
    this.weightType,
    this.weight,
    this.noOfBags,
    this.fristKantaParchi,
    this.secondKantaParchi,
    this.kantaParchiPath,
    this.weightCreateDate,
    this.weightUpdateDate,
    this.weightStatus,
    this.customerCopy,
    this.lpCopy,
    this.terminalCopy,
    this.customerCopyTime,
    this.lpCopyTime,
    this.terminalCopyTime,
    this.terminalName,
    this.vehicleNo,
    this.quantity,
    this.commodityImagePath,
    this.commodityImage,
    this.category,
    this.name,
    this.passportImage,
    this.imagePath,
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
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
    requestTime: json["request_time"] == null ? null : DateTime.parse(json["request_time"]),
    acceptTime: json["accept_time"] == null ? null : DateTime.parse(json["accept_time"]),
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    lpLat: json["lp_lat"],
    userLat: json["user_lat"],
    userLong: json["user_long"],
    terminalLat: json["terminal_lat"],
    terminalLong: json["terminal_long"],
    lpToUserKm: json["lp_to_user_km"],
    userToTerminalKm: json["user_to_terminal_km"],
    otp: json["otp"],
    otpStatus: json["otp_status"],
    otpCreateDate: json["otp_create_date"] == null ? null : DateTime.parse(json["otp_create_date"]),
    otpUpdateDate: json["otp_update_date"] == null ? null : DateTime.parse(json["otp_update_date"]),
    takeHomePrice: json["take_home_price"],
    finalPrice: json["final_price"],
    priceVariation: json["price_variation"],
    moisture: json["moisture"],
    broken: json["broken"],
    tcw: json["tcw"],
    fm: json["fm"],
    thin: json["thin"],
    qualityGrade: json["quality_grade"],
    pricingCreateDate: json["pricing_create_date"] == null ? null : DateTime.parse(json["pricing_create_date"]),
    pricingUpdateDate: json["pricing_update_date"] == null ? null : DateTime.parse(json["pricing_update_date"]),
    pricingStatus: json["pricing_status"],
    mandiPrice: json["mandi_price"],
    weightType: json["weight_type"],
    weight: json["weight"],
    noOfBags: json["no_of_bags"],
    fristKantaParchi: json["frist_kanta_parchi"],
    secondKantaParchi: json["second_kanta_parchi"],
    kantaParchiPath: json["kanta_parchi_path"],
    weightCreateDate: json["weight_create_date"],
    weightUpdateDate: json["weight_update_date"],
    weightStatus: json["weight_status"],
    customerCopy: json["customer_copy"],
    lpCopy: json["lp_copy"],
    terminalCopy: json["terminal_copy"],
    customerCopyTime: json["customer_copy_time"],
    lpCopyTime: json["lp_copy_time"],
    terminalCopyTime: json["terminal_copy_time"],
    terminalName: json["terminal_name"],
    vehicleNo: json["vehicle_no"],
    quantity: json["quantity"],
    commodityImagePath: json["commodity_image_path"],
    commodityImage: json["commodity_image"],
    category: json["category"],
    name: json["name"],
    passportImage: json["passport_image"],
    imagePath: json["image_path"],
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
    "request_time": requestTime?.toIso8601String(),
    "accept_time": acceptTime?.toIso8601String(),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "lp_lat": lpLat,
    "user_lat": userLat,
    "user_long": userLong,
    "terminal_lat": terminalLat,
    "terminal_long": terminalLong,
    "lp_to_user_km": lpToUserKm,
    "user_to_terminal_km": userToTerminalKm,
    "otp": otp,
    "otp_status": otpStatus,
    "otp_create_date": otpCreateDate?.toIso8601String(),
    "otp_update_date": otpUpdateDate?.toIso8601String(),
    "take_home_price": takeHomePrice,
    "final_price": finalPrice,
    "price_variation": priceVariation,
    "moisture": moisture,
    "broken": broken,
    "tcw": tcw,
    "fm": fm,
    "thin": thin,
    "quality_grade": qualityGrade,
    "pricing_create_date": pricingCreateDate?.toIso8601String(),
    "pricing_update_date": pricingUpdateDate?.toIso8601String(),
    "pricing_status": pricingStatus,
    "mandi_price": mandiPrice,
    "weight_type": weightType,
    "weight": weight,
    "no_of_bags": noOfBags,
    "frist_kanta_parchi": fristKantaParchi,
    "second_kanta_parchi": secondKantaParchi,
    "kanta_parchi_path": kantaParchiPath,
    "weight_create_date": weightCreateDate,
    "weight_update_date": weightUpdateDate,
    "weight_status": weightStatus,
    "customer_copy": customerCopy,
    "lp_copy": lpCopy,
    "terminal_copy": terminalCopy,
    "customer_copy_time": customerCopyTime,
    "lp_copy_time": lpCopyTime,
    "terminal_copy_time": terminalCopyTime,
    "terminal_name": terminalName,
    "vehicle_no": vehicleNo,
    "quantity": quantity,
    "commodity_image_path": commodityImagePath,
    "commodity_image": commodityImage,
    "category": category,
    "name": name,
    "passport_image": passportImage,
    "image_path": imagePath,
  };
}
