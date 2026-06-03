// To parse this JSON data, do
//
//     final biddingResponseModel = biddingResponseModelFromMap(jsonString);

import 'dart:convert';

BiddingResponseModel biddingResponseModelFromMap(String str) => BiddingResponseModel.fromMap(json.decode(str));

String biddingResponseModelToMap(BiddingResponseModel data) => json.encode(data.toMap());

class BiddingResponseModel {
  dynamic walletStatus;
  List<DealInfo>? dealInfo;
  dynamic selfStatus;
  dynamic bidClosed;
  dynamic netAmount;
  InventoryInfo? inventoryInfo;
  dynamic status;
  dynamic message;

  BiddingResponseModel({
    this.walletStatus,
    this.dealInfo,
    this.selfStatus,
    this.bidClosed,
    this.netAmount,
    this.inventoryInfo,
    this.status,
    this.message,
  });

  factory BiddingResponseModel.fromMap(Map<String, dynamic> json) => BiddingResponseModel(
    walletStatus: json["wallet_status"],
    dealInfo: json["deal_info"] == null ? [] : List<DealInfo>.from(json["deal_info"]!.map((x) => DealInfo.fromMap(x))),
    selfStatus: json["self_status"],
    bidClosed: json["bid_closed"],
    netAmount: json["net_amount"],
    inventoryInfo: json["inventory_info"] == null ? null : InventoryInfo.fromMap(json["inventory_info"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "wallet_status": walletStatus,
    "deal_info": dealInfo == null ? [] : List<dynamic>.from(dealInfo!.map((x) => x.toMap())),
    "self_status": selfStatus,
    "bid_closed": bidClosed,
    "net_amount": netAmount,
    "inventory_info": inventoryInfo?.toMap(),
    "status": status,
    "message": message,
  };
}

class DealInfo {
  dynamic id;
  dynamic buySellId;
  dynamic userId;
  dynamic price;
  dynamic isSecure;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic fname;
  dynamic userWalletAmount;

  DealInfo({
    this.id,
    this.buySellId,
    this.userId,
    this.price,
    this.isSecure,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.fname,
    this.userWalletAmount,
  });

  factory DealInfo.fromMap(Map<String, dynamic> json) => DealInfo(
    id: json["id"],
    buySellId: json["buy_sell_id"],
    userId: json["user_id"],
    price: json["price"],
    isSecure: json["is_secure"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    fname: json["fname"],
    userWalletAmount: json["user_wallet_amount"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "buy_sell_id": buySellId,
    "user_id": userId,
    "price": price,
    "is_secure": isSecure,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "fname": fname,
    "user_wallet_amount": userWalletAmount,
  };
}

class InventoryInfo {
  dynamic category;
  dynamic name;
  dynamic area;
  dynamic id;
  dynamic userId;
  dynamic caseId;
  dynamic warehouseId;
  dynamic commodity;
  dynamic weightBridgeNo;
  dynamic truckNo;
  dynamic stackNo;
  dynamic lotNo;
  dynamic netWeight;
  dynamic type;
  dynamic quantity;
  dynamic bags;
  dynamic sellQuantity;
  dynamic price;
  dynamic gatePassWr;
  dynamic qualityCategory;
  dynamic origin;
  dynamic image;
  dynamic file;
  dynamic rentRowId;
  dynamic interestRowId;
  dynamic mandiAmount;
  dynamic settlmentAmount;
  dynamic remAmount;
  dynamic lessOldNegWalletSattlement;
  dynamic walletSatlementAmount;
  dynamic isLiquidation;
  dynamic rentRate;
  dynamic salesStatus;
  dynamic lienBeg;
  dynamic unlienBeg;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  InvCases? invCases;

  InventoryInfo({
    this.category,
    this.name,
    this.area,
    this.id,
    this.userId,
    this.caseId,
    this.warehouseId,
    this.commodity,
    this.weightBridgeNo,
    this.truckNo,
    this.stackNo,
    this.lotNo,
    this.netWeight,
    this.type,
    this.quantity,
    this.bags,
    this.sellQuantity,
    this.price,
    this.gatePassWr,
    this.qualityCategory,
    this.origin,
    this.image,
    this.file,
    this.rentRowId,
    this.interestRowId,
    this.mandiAmount,
    this.settlmentAmount,
    this.remAmount,
    this.lessOldNegWalletSattlement,
    this.walletSatlementAmount,
    this.isLiquidation,
    this.rentRate,
    this.salesStatus,
    this.lienBeg,
    this.unlienBeg,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.invCases,
  });

  factory InventoryInfo.fromMap(Map<String, dynamic> json) => InventoryInfo(
    category: json["category"],
    name: json["name"],
    area: json["area"],
    id: json["id"],
    userId: json["user_id"],
    caseId: json["case_id"],
    warehouseId: json["warehouse_id"],
    commodity: json["commodity"],
    weightBridgeNo: json["weight_bridge_no"],
    truckNo: json["truck_no"],
    stackNo: json["stack_no"],
    lotNo: json["lot_no"],
    netWeight: json["net_weight"],
    type: json["type"],
    quantity: json["quantity"],
    bags: json["bags"],
    sellQuantity: json["sell_quantity"],
    price: json["price"],
    gatePassWr: json["gate_pass_wr"],
    qualityCategory: json["quality_category"],
    origin: json["origin"],
    image: json["image"],
    file: json["file"],
    rentRowId: json["rent_row_id"],
    interestRowId: json["interest_row_id"],
    mandiAmount: json["mandi_amount"],
    settlmentAmount: json["settlment_amount"],
    remAmount: json["rem_amount"],
    lessOldNegWalletSattlement: json["less_old_neg_wallet_sattlement"],
    walletSatlementAmount: json["walletSatlementAmount"],
    isLiquidation: json["is_liquidation"],
    rentRate: json["rent_rate"],
    salesStatus: json["sales_status"],
    lienBeg: json["lien_beg"],
    unlienBeg: json["unlien_beg"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    invCases: json["inv_cases"] == null ? null : InvCases.fromMap(json["inv_cases"]),
  );

  Map<String, dynamic> toMap() => {
    "category": category,
    "name": name,
    "area": area,
    "id": id,
    "user_id": userId,
    "case_id": caseId,
    "warehouse_id": warehouseId,
    "commodity": commodity,
    "weight_bridge_no": weightBridgeNo,
    "truck_no": truckNo,
    "stack_no": stackNo,
    "lot_no": lotNo,
    "net_weight": netWeight,
    "type": type,
    "quantity": quantity,
    "bags": bags,
    "sell_quantity": sellQuantity,
    "price": price,
    "gate_pass_wr": gatePassWr,
    "quality_category": qualityCategory,
    "origin": origin,
    "image": image,
    "file": file,
    "rent_row_id": rentRowId,
    "interest_row_id": interestRowId,
    "mandi_amount": mandiAmount,
    "settlment_amount": settlmentAmount,
    "rem_amount": remAmount,
    "less_old_neg_wallet_sattlement": lessOldNegWalletSattlement,
    "walletSatlementAmount": walletSatlementAmount,
    "is_liquidation": isLiquidation,
    "rent_rate": rentRate,
    "sales_status": salesStatus,
    "lien_beg": lienBeg,
    "unlien_beg": unlienBeg,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "inv_cases": invCases?.toMap(),
  };
}

class InvCases {
  dynamic id;
  dynamic inventoryId;
  dynamic caseId;
  dynamic weight;
  dynamic invCaseBags;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  List<Qv>? qv;

  InvCases({
    this.id,
    this.inventoryId,
    this.caseId,
    this.weight,
    this.invCaseBags,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.qv,
  });

  factory InvCases.fromMap(Map<String, dynamic> json) => InvCases(
    id: json["id"],
    inventoryId: json["inventory_id"],
    caseId: json["case_id"],
    weight: json["weight"],
    invCaseBags: json["inv_case_bags"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    qv: json["qv"] == null ? [] : List<Qv>.from(json["qv"]!.map((x) => Qv.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "inventory_id": inventoryId,
    "case_id": caseId,
    "weight": weight,
    "inv_case_bags": invCaseBags,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "qv": qv == null ? [] : List<dynamic>.from(qv!.map((x) => x.toMap())),
  };
}

class Qv {
  dynamic id;
  dynamic userId;
  dynamic caseId;
  dynamic parameterId;
  dynamic value;
  dynamic createdAt;
  dynamic updatedAt;
  QualityParameters? qualityParameters;

  Qv({
    this.id,
    this.userId,
    this.caseId,
    this.parameterId,
    this.value,
    this.createdAt,
    this.updatedAt,
    this.qualityParameters,
  });

  factory Qv.fromMap(Map<String, dynamic> json) => Qv(
    id: json["id"],
    userId: json["user_id"],
    caseId: json["case_id"],
    parameterId: json["parameter_id"],
    value: json["value"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    qualityParameters: json["quality_parameters"] == null ? null : QualityParameters.fromMap(json["quality_parameters"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "case_id": caseId,
    "parameter_id": parameterId,
    "value": value,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "quality_parameters": qualityParameters?.toMap(),
  };
}

class QualityParameters {
  dynamic id;
  dynamic parameter;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  QualityParameters({
    this.id,
    this.parameter,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory QualityParameters.fromMap(Map<String, dynamic> json) => QualityParameters(
    id: json["id"],
    parameter: json["parameter"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "parameter": parameter,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
