// To parse this JSON data, do
//
//     final repaymentModel = repaymentModelFromMap(jsonString);

import 'dart:convert';

RepaymentModel repaymentModelFromMap(String str) => RepaymentModel.fromMap(json.decode(str));

String repaymentModelToMap(RepaymentModel data) => json.encode(data.toMap());

class RepaymentModel {
  List<Datum>? data;
  Settlement? settlement;
  dynamic status;
  String? message;

  RepaymentModel({
    this.data,
    this.settlement,
    this.status,
    this.message,
  });

  factory RepaymentModel.fromMap(Map<String, dynamic> json) => RepaymentModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    settlement: json["settlement"] == null ? null : Settlement.fromMap(json["settlement"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "settlement": settlement?.toMap(),
    "status": status,
    "message": message,
  };
}

class Datum {
  dynamic id;
  dynamic userId;
  String? caseId;
  String? category;
  String? category_hi;
  dynamic warehouseId;
  dynamic commodity;
  dynamic weightBridgeNo;
  String? truckNo;
  String? stackNo;
  dynamic lotNo;
  dynamic netWeight;
  dynamic type;
  String? quantity;
  dynamic bags;
  dynamic sellQuantity;
  String? price;
  String? gatePassWr;
  dynamic qualityCategory;
  dynamic origin;
  dynamic image;
  String? file;
  dynamic rentRowId;
  dynamic interestRowId;
  String? mandiAmount;
  String? settlmentAmount;
  String? remAmount;
  dynamic lessOldNegWalletSattlement;
  String? walletSatlementAmount;
  dynamic isLiquidation;
  dynamic rentRate;
  dynamic salesStatus;
  dynamic lienBeg;
  dynamic unlienBeg;
  dynamic status;
  String? createdAt;
  String? updatedAt;
  String? warehouseCode;
  String? warehouseName;
  dynamic warehouseNameHi;

  Datum({
    this.id,
    this.userId,
    this.caseId,
    this.category,
    this.category_hi,
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
    this.warehouseCode,
    this.warehouseName,
    this.warehouseNameHi,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    caseId: json["case_id"],
    category: json['category'],
    category_hi: json['category_hi'],
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
    warehouseCode: json["warehouse_code"],
    warehouseName: json["warehouse_name"],
    warehouseNameHi: json["warehouse_name_hi"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "case_id": caseId,
    "category":category,
    "category_hi":category_hi,
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
    "warehouse_code": warehouseCode,
    "warehouse_name": warehouseName,
    "warehouse_name_hi": warehouseNameHi,
  };
}

class Settlement {
  String? outstanding;
  String? rentAmount;
  String? loanAmount;
  String? interestAmount;

  Settlement({
    this.outstanding,
    this.rentAmount,
    this.loanAmount,
    this.interestAmount,
  });

  factory Settlement.fromMap(Map<String, dynamic> json) => Settlement(
    outstanding: json["outstanding"],
    rentAmount: json["rent_amount"],
    loanAmount: json["loan_amount"],
    interestAmount: json["interest_amount"],
  );

  Map<String, dynamic> toMap() => {
    "outstanding": outstanding,
    "rent_amount": rentAmount,
    "loan_amount": loanAmount,
    "interest_amount": interestAmount,
  };
}
