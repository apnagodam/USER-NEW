// To parse this JSON data, do
//
//     final settlementListModel = settlementListModelFromMap(jsonString);

import 'dart:convert';

SettlementListModel settlementListModelFromMap(String str) => SettlementListModel.fromMap(json.decode(str));

String settlementListModelToMap(SettlementListModel data) => json.encode(data.toMap());

class SettlementListModel {
  List<Datum>? data;
  dynamic idleRentAmount;
  String? status;
  String? message;

  SettlementListModel({
    this.data,
    this.idleRentAmount,
    this.status,
    this.message,
  });

  factory SettlementListModel.fromMap(Map<String, dynamic> json) => SettlementListModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    idleRentAmount: json["idle_rent_amount"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "idle_rent_amount": idleRentAmount,
    "status": status,
    "message": message,
  };
}

class Datum {
  dynamic id;
  dynamic userId;
  String? caseId;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? outstanding;
  String? rentAmount;
  String? loanAmount;
  String? interestAmount;
  Finance? finance;
  StackRentData? stackRentData;

  Datum({
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
    this.outstanding,
    this.rentAmount,
    this.loanAmount,
    this.interestAmount,
    this.finance,
    this.stackRentData,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    outstanding: json["outstanding"],
    rentAmount: json["rent_amount"],
    loanAmount: json["loan_amount"],
    interestAmount: json["interest_amount"],
    finance: json["finance"] == null ? null : Finance.fromMap(json["finance"]),
    stackRentData: json["stack_rent_data"] == null ? null : StackRentData.fromMap(json["stack_rent_data"]),
  );

  Map<String, dynamic> toMap() => {
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "outstanding": outstanding,
    "rent_amount": rentAmount,
    "loan_amount": loanAmount,
    "interest_amount": interestAmount,
    "finance": finance?.toMap(),
    "stack_rent_data": stackRentData?.toMap(),
  };
}

class Finance {
  dynamic id;
  dynamic drfNo;
  dynamic userId;
  dynamic bankId;
  dynamic amountIn;
  dynamic price;
  dynamic commodityId;
  String? quantity;
  dynamic processingFee;
  dynamic loanTotalPAmount;
  dynamic rateOfInterest;
  dynamic ltv;
  dynamic valueOfCommodity;
  dynamic amount;
  dynamic compoundPIAmount;
  dynamic remainingAmount;
  String? disbursement;
  String? bankName;
  String? ifsc;
  String? accountNo;
  String? rejectReason;
  dynamic doneBy;
  dynamic approvedBy;
  dynamic approvedDate;
  dynamic amountAccType;
  dynamic status;
  dynamic tallyUpdateBy;
  dynamic tallyUpdate;
  dynamic tallyUpdateDate;
  dynamic paymentUpdateBy;
  dynamic paymentRef;
  dynamic paymentDate;
  String? poutId;
  String? fundAccountId;
  String? contactId;
  dynamic approveStatus;
  dynamic closed;
  DateTime? createdAt;
  DateTime? updatedAt;

  Finance({
    this.id,
    this.drfNo,
    this.userId,
    this.bankId,
    this.amountIn,
    this.price,
    this.commodityId,
    this.quantity,
    this.processingFee,
    this.loanTotalPAmount,
    this.rateOfInterest,
    this.ltv,
    this.valueOfCommodity,
    this.amount,
    this.compoundPIAmount,
    this.remainingAmount,
    this.disbursement,
    this.bankName,
    this.ifsc,
    this.accountNo,
    this.rejectReason,
    this.doneBy,
    this.approvedBy,
    this.approvedDate,
    this.amountAccType,
    this.status,
    this.tallyUpdateBy,
    this.tallyUpdate,
    this.tallyUpdateDate,
    this.paymentUpdateBy,
    this.paymentRef,
    this.paymentDate,
    this.poutId,
    this.fundAccountId,
    this.contactId,
    this.approveStatus,
    this.closed,
    this.createdAt,
    this.updatedAt,
  });

  factory Finance.fromMap(Map<String, dynamic> json) => Finance(
    id: json["id"],
    drfNo: json["drf_no"],
    userId: json["user_id"],
    bankId: json["bank_id"],
    amountIn: json["amount_in"],
    price: json["price"],
    commodityId: json["commodity_id"],
    quantity: json["quantity"],
    processingFee: json["processing_fee"],
    loanTotalPAmount: json["loan_total_p_amount"],
    rateOfInterest: json["rate_of_interest"],
    ltv: json["ltv"],
    valueOfCommodity: json["value_of_commodity"],
    amount: json["amount"],
    compoundPIAmount: json["compound_p_i_amount"],
    remainingAmount: json["remaining_amount"],
    disbursement: json["disbursement"],
    bankName: json["bank_name"],
    ifsc: json["ifsc"],
    accountNo: json["account_no"],
    rejectReason: json["reject_reason"],
    doneBy: json["done_by"],
    approvedBy: json["approved_by"],
    approvedDate: json["approved_date"],
    amountAccType: json["amount_acc_type"],
    status: json["status"],
    tallyUpdateBy: json["tally_update_by"],
    tallyUpdate: json["tally_update"],
    tallyUpdateDate: json["tally_update_date"],
    paymentUpdateBy: json["payment_update_by"],
    paymentRef: json["payment_ref"],
    paymentDate: json["payment_date"],
    poutId: json["pout_id"],
    fundAccountId: json["fund_account_id"],
    contactId: json["contact_id"],
    approveStatus: json["approve_status"],
    closed: json["closed"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "drf_no": drfNo,
    "user_id": userId,
    "bank_id": bankId,
    "amount_in": amountIn,
    "price": price,
    "commodity_id": commodityId,
    "quantity": quantity,
    "processing_fee": processingFee,
    "loan_total_p_amount": loanTotalPAmount,
    "rate_of_interest": rateOfInterest,
    "ltv": ltv,
    "value_of_commodity": valueOfCommodity,
    "amount": amount,
    "compound_p_i_amount": compoundPIAmount,
    "remaining_amount": remainingAmount,
    "disbursement": disbursement,
    "bank_name": bankName,
    "ifsc": ifsc,
    "account_no": accountNo,
    "reject_reason": rejectReason,
    "done_by": doneBy,
    "approved_by": approvedBy,
    "approved_date": approvedDate,
    "amount_acc_type": amountAccType,
    "status": status,
    "tally_update_by": tallyUpdateBy,
    "tally_update": tallyUpdate,
    "tally_update_date": tallyUpdateDate,
    "payment_update_by": paymentUpdateBy,
    "payment_ref": paymentRef,
    "payment_date": paymentDate,
    "pout_id": poutId,
    "fund_account_id": fundAccountId,
    "contact_id": contactId,
    "approve_status": approveStatus,
    "closed": closed,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class StackRentData {
  dynamic id;
  dynamic invId;
  dynamic userId;
  dynamic terminalId;
  dynamic stackNo;
  dynamic stackType;
  dynamic commodityId;
  String? gatepassNo;
  String? quantity;
  String? commodityRate;
  dynamic rentAmount;
  dynamic distributedAmount;
  dynamic paymentStatus;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  StackRentData({
    this.id,
    this.invId,
    this.userId,
    this.terminalId,
    this.stackNo,
    this.stackType,
    this.commodityId,
    this.gatepassNo,
    this.quantity,
    this.commodityRate,
    this.rentAmount,
    this.distributedAmount,
    this.paymentStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory StackRentData.fromMap(Map<String, dynamic> json) => StackRentData(
    id: json["id"],
    invId: json["inv_id"],
    userId: json["user_id"],
    terminalId: json["terminal_id"],
    stackNo: json["stack_no"],
    stackType: json["stack_type"],
    commodityId: json["commodity_id"],
    gatepassNo: json["gatepass_no"],
    quantity: json["quantity"],
    commodityRate: json["commodity_rate"],
    rentAmount: json["rent_amount"],
    distributedAmount: json["distributed_amount"],
    paymentStatus: json["payment_status"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "inv_id": invId,
    "user_id": userId,
    "terminal_id": terminalId,
    "stack_no": stackNo,
    "stack_type": stackType,
    "commodity_id": commodityId,
    "gatepass_no": gatepassNo,
    "quantity": quantity,
    "commodity_rate": commodityRate,
    "rent_amount": rentAmount,
    "distributed_amount": distributedAmount,
    "payment_status": paymentStatus,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
