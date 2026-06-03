// To parse this JSON data, do
//
//     final contractNoteModel = contractNoteModelFromMap(jsonString);

import 'dart:convert';

ContractNoteModel contractNoteModelFromMap(String str) => ContractNoteModel.fromMap(json.decode(str));

String contractNoteModelToMap(ContractNoteModel data) => json.encode(data.toMap());

class ContractNoteModel {
  Data? data;
  String? status;
  String? message;

  ContractNoteModel({
    this.data,
    this.status,
    this.message,
  });

  factory ContractNoteModel.fromMap(Map<String, dynamic> json) => ContractNoteModel(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
    "status": status,
    "message": message,
  };
}

class Data {
  dynamic id;
  dynamic uniqueId;
  dynamic buyerId;
  dynamic sellerId;
  dynamic sellerCatId;
  dynamic paymentRefNo;
  String? quantity;
  String? price;
  dynamic labourRate;
  dynamic todaysPrice;
  dynamic bidType;
  dynamic mandiFees;
  dynamic rentRowId;
  dynamic interestRowId;
  dynamic financeId;
  String? finalMandiAmount;
  String? finalSettlmentAmount;
  String? finalRemAmount;
  String? finalWalletSatlementAmount;
  String? mandiTaxRate;
  String? mandiTaxAmount;
  dynamic agCommission;
  dynamic gst;
  dynamic gstAmount;
  dynamic paymentAdvice;
  dynamic qvAmount;
  dynamic isInvoice;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? buyerName;
  String? buyerPhone;
  String? pancardNo;
  String? mandiLicense;
  String? sellerName;
  String? sellerPhone;
  String? category;
  String? warehouse;
  dynamic warehouseId;
  String? warehouseCode;
  dynamic location;
  dynamic totalBags;
  dynamic qualityCategory;
  dynamic salesStatus;
  String? gatePassWr;
  String? truckNo;
  String? caseId;
  String? mandiSamitiName;

  Data({
    this.id,
    this.uniqueId,
    this.buyerId,
    this.sellerId,
    this.sellerCatId,
    this.paymentRefNo,
    this.quantity,
    this.price,
    this.labourRate,
    this.todaysPrice,
    this.bidType,
    this.mandiFees,
    this.rentRowId,
    this.interestRowId,
    this.financeId,
    this.finalMandiAmount,
    this.finalSettlmentAmount,
    this.finalRemAmount,
    this.finalWalletSatlementAmount,
    this.mandiTaxRate,
    this.mandiTaxAmount,
    this.agCommission,
    this.gst,
    this.gstAmount,
    this.paymentAdvice,
    this.qvAmount,
    this.isInvoice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.buyerName,
    this.buyerPhone,
    this.pancardNo,
    this.mandiLicense,
    this.sellerName,
    this.sellerPhone,
    this.category,
    this.warehouse,
    this.warehouseId,
    this.warehouseCode,
    this.location,
    this.totalBags,
    this.qualityCategory,
    this.salesStatus,
    this.gatePassWr,
    this.truckNo,
    this.caseId,
    this.mandiSamitiName,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    uniqueId: json["unique_id"],
    buyerId: json["buyer_id"],
    sellerId: json["seller_id"],
    sellerCatId: json["seller_cat_id"],
    paymentRefNo: json["payment_ref_no"],
    quantity: json["quantity"],
    price: json["price"],
    labourRate: json["labour_rate"],
    todaysPrice: json["todays_price"],
    bidType: json["bid_type"],
    mandiFees: json["mandi_fees"],
    rentRowId: json["rent_row_id"],
    interestRowId: json["interest_row_id"],
    financeId: json["finance_id"],
    finalMandiAmount: json["final_mandi_amount"],
    finalSettlmentAmount: json["final_settlment_amount"],
    finalRemAmount: json["final_rem_amount"],
    finalWalletSatlementAmount: json["final_wallet_satlement_amount"],
    mandiTaxRate: json["mandi_tax_rate"],
    mandiTaxAmount: json["mandi_tax_amount"],
    agCommission: json["ag_commission"],
    gst: json["gst"],
    gstAmount: json["gst_amount"],
    paymentAdvice: json["payment_advice"],
    qvAmount: json["qv_amount"],
    isInvoice: json["is_invoice"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    buyerName: json["buyer_name"],
    buyerPhone: json["buyer_phone"],
    pancardNo: json["pancard_no"],
    mandiLicense: json["mandi_license"],
    sellerName: json["seller_name"],
    sellerPhone: json["seller_phone"],
    category: json["category"],
    warehouse: json["warehouse"],
    warehouseId: json["warehouse_id"],
    warehouseCode: json["warehouse_code"],
    location: json["location"],
    totalBags: json["total_bags"],
    qualityCategory: json["quality_category"],
    salesStatus: json["sales_status"],
    gatePassWr: json["gate_pass_wr"],
    truckNo: json["truck_no"],
    caseId: json["case_id"],
    mandiSamitiName: json["mandi_samiti_name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "unique_id": uniqueId,
    "buyer_id": buyerId,
    "seller_id": sellerId,
    "seller_cat_id": sellerCatId,
    "payment_ref_no": paymentRefNo,
    "quantity": quantity,
    "price": price,
    "labour_rate": labourRate,
    "todays_price": todaysPrice,
    "bid_type": bidType,
    "mandi_fees": mandiFees,
    "rent_row_id": rentRowId,
    "interest_row_id": interestRowId,
    "finance_id": financeId,
    "final_mandi_amount": finalMandiAmount,
    "final_settlment_amount": finalSettlmentAmount,
    "final_rem_amount": finalRemAmount,
    "final_wallet_satlement_amount": finalWalletSatlementAmount,
    "mandi_tax_rate": mandiTaxRate,
    "mandi_tax_amount": mandiTaxAmount,
    "ag_commission": agCommission,
    "gst": gst,
    "gst_amount": gstAmount,
    "payment_advice": paymentAdvice,
    "qv_amount": qvAmount,
    "is_invoice": isInvoice,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "buyer_name": buyerName,
    "buyer_phone": buyerPhone,
    "pancard_no": pancardNo,
    "mandi_license": mandiLicense,
    "seller_name": sellerName,
    "seller_phone": sellerPhone,
    "category": category,
    "warehouse": warehouse,
    "warehouse_id": warehouseId,
    "warehouse_code": warehouseCode,
    "location": location,
    "total_bags": totalBags,
    "quality_category": qualityCategory,
    "sales_status": salesStatus,
    "gate_pass_wr": gatePassWr,
    "truck_no": truckNo,
    "case_id": caseId,
    "mandi_samiti_name": mandiSamitiName,
  };
}
