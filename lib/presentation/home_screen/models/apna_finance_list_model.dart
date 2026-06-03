// To parse this JSON data, do
//
//     final anpnaFinanceListModel = anpnaFinanceListModelFromMap(jsonString);

import 'dart:convert';

AnpnaFinanceListModel anpnaFinanceListModelFromMap(String str) => AnpnaFinanceListModel.fromMap(json.decode(str));

String anpnaFinanceListModelToMap(AnpnaFinanceListModel data) => json.encode(data.toMap());

class AnpnaFinanceListModel {
  Finances? finances;
  dynamic status;
  dynamic message;

  AnpnaFinanceListModel({
    this.finances,
    this.status,
    this.message,
  });

  factory AnpnaFinanceListModel.fromMap(Map<String, dynamic> json) => AnpnaFinanceListModel(
    finances: json["finances"] == null ? null : Finances.fromMap(json["finances"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "finances": finances?.toMap(),
    "status": status,
    "message": message,
  };
}

class Finances {
  dynamic currentPage;
  List<Datum>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  Finances({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Finances.fromMap(Map<String, dynamic> json) => Finances(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  dynamic id;
  dynamic drfNo;
  dynamic userId;
  dynamic bankId;
  dynamic amountIn;
  dynamic price;
  dynamic pan;
  dynamic balanceSheet;
  dynamic bankStatement;
  dynamic commodityId;
  dynamic quantity;
  dynamic processingFee;
  dynamic loanTotalPAmount;
  dynamic rateOfInterest;
  dynamic ltv;
  dynamic valueOfCommodity;
  dynamic amount;
  dynamic compoundPIAmount;
  dynamic remainingAmount;
  dynamic disbursement;
  dynamic bankName;
  dynamic ifsc;
  dynamic accountNo;
  dynamic utrNo;
  dynamic rejectReason;
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
  dynamic poutId;
  dynamic fundAccountId;
  dynamic contactId;
  dynamic loanIvr;
  dynamic approveStatus;
  dynamic closed;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic netWeight;
  dynamic category;
  dynamic name;
  dynamic loanBankName;
  dynamic caseId;
  dynamic interestRate;
  dynamic loanPerTotalAmount;
  dynamic loanPassDays;

  Datum({
    this.id,
    this.drfNo,
    this.userId,
    this.bankId,
    this.amountIn,
    this.price,
    this.pan,
    this.balanceSheet,
    this.bankStatement,
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
    this.utrNo,
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
    this.loanIvr,
    this.approveStatus,
    this.closed,
    this.createdAt,
    this.updatedAt,
    this.netWeight,
    this.category,
    this.name,
    this.loanBankName,
    this.caseId,
    this.interestRate,
    this.loanPerTotalAmount,
    this.loanPassDays,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    drfNo: json["drf_no"],
    userId: json["user_id"],
    bankId: json["bank_id"],
    amountIn: json["amount_in"],
    price: json["price"],
    pan: json["pan"],
    balanceSheet: json["balance_sheet"],
    bankStatement: json["bank_statement"],
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
    utrNo: json["utr_no"],
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
    loanIvr: json["loan_ivr"],
    approveStatus: json["approve_status"],
    closed: json["closed"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    netWeight: json["net_weight"],
    category: json["category"],
    name: json["name"],
    loanBankName: json["loan_bank_name"],
    caseId: json["case_id"],
    interestRate: json["interest_rate"],
    loanPerTotalAmount: json["loan_per_total_amount"],
    loanPassDays: json["loan_pass_days"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "drf_no": drfNo,
    "user_id": userId,
    "bank_id": bankId,
    "amount_in": amountIn,
    "price": price,
    "pan": pan,
    "balance_sheet": balanceSheet,
    "bank_statement": bankStatement,
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
    "utr_no": utrNo,
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
    "loan_ivr": loanIvr,
    "approve_status": approveStatus,
    "closed": closed,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "net_weight": netWeight,
    "category": category,
    "name": name,
    "loan_bank_name": loanBankName,
    "case_id": caseId,
    "interest_rate": interestRate,
    "loan_per_total_amount": loanPerTotalAmount,
    "loan_pass_days": loanPassDays,
  };
}

class Link {
  dynamic url;
  dynamic label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
