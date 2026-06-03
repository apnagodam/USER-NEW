// To parse this JSON data, do
//
//     final spotDealModel = spotDealModelFromMap(jsonString);

import 'dart:convert';

SpotDealModel spotDealModelFromMap(String str) => SpotDealModel.fromMap(json.decode(str));

String spotDealModelToMap(SpotDealModel data) => json.encode(data.toMap());

class SpotDealModel {
  Deals? deals;
  dynamic status;
  dynamic message;

  SpotDealModel({
    this.deals,
    this.status,
    this.message,
  });

  factory SpotDealModel.fromMap(Map<String, dynamic> json) => SpotDealModel(
    deals: json["deals"] == null ? null : Deals.fromMap(json["deals"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "deals": deals?.toMap(),
    "status": status,
    "message": message,
  };
}

class Deals {
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

  Deals({
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

  factory Deals.fromMap(Map<String, dynamic> json) => Deals(
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
  dynamic contractId;
  dynamic buyerId;
  dynamic sellerId;
  dynamic sellerCatId;
  dynamic caseId;
  dynamic paymentRefNo;
  dynamic quantity;
  dynamic price;
  dynamic finalPrice;
  dynamic labourRate;
  dynamic todaysPrice;
  dynamic bidType;
  dynamic agCommissionRate;
  dynamic agCommissionAmount;
  dynamic commodityGstPercent;
  dynamic mandiTaxPercent;
  dynamic mandiFees;
  dynamic finalPerQtlGst;
  dynamic gst;
  dynamic gstAmount;
  dynamic pdf;
  dynamic paymentStatus;
  dynamic invoice;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic userAmount;
  dynamic agCommissionPercent;
  dynamic mandiPrice;
  dynamic mandiTaxRate;
  dynamic dealFinalPrice;
  dynamic totalGstAmount;
  dynamic gstRate;
  dynamic noOfBags;
  dynamic category;
  dynamic qualityCategory;
  dynamic fname;
  dynamic buyerPanNo;
  dynamic buyerPhone;
  dynamic sellerName;
  dynamic sellerPhone;
  dynamic salesStatus;
  dynamic location;
  dynamic bags;
  dynamic bankSlip;
  dynamic commodityImage;
  dynamic qualityGrade;

  Datum({
    this.id,
    this.contractId,
    this.buyerId,
    this.sellerId,
    this.sellerCatId,
    this.caseId,
    this.paymentRefNo,
    this.quantity,
    this.price,
    this.finalPrice,
    this.labourRate,
    this.todaysPrice,
    this.bidType,
    this.agCommissionRate,
    this.agCommissionAmount,
    this.commodityGstPercent,
    this.mandiTaxPercent,
    this.mandiFees,
    this.finalPerQtlGst,
    this.gst,
    this.gstAmount,
    this.pdf,
    this.paymentStatus,
    this.invoice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userAmount,
    this.agCommissionPercent,
    this.mandiPrice,
    this.mandiTaxRate,
    this.dealFinalPrice,
    this.totalGstAmount,
    this.gstRate,
    this.noOfBags,
    this.category,
    this.qualityCategory,
    this.fname,
    this.buyerPanNo,
    this.buyerPhone,
    this.sellerName,
    this.sellerPhone,
    this.salesStatus,
    this.location,
    this.bags,
    this.bankSlip,
    this.commodityImage,
    this.qualityGrade,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    contractId: json["contract_id"],
    buyerId: json["buyer_id"],
    sellerId: json["seller_id"],
    sellerCatId: json["seller_cat_id"],
    caseId: json["case_id"],
    paymentRefNo: json["payment_ref_no"],
    quantity: json["quantity"],
    price: json["price"],
    finalPrice: json["final_price"],
    labourRate: json["labour_rate"],
    todaysPrice: json["todays_price"],
    bidType: json["bid_type"],
    agCommissionRate: json["ag_commission_rate"],
    agCommissionAmount: json["ag_commission_amount"],
    commodityGstPercent: json["commodity_gst_percent"],
    mandiTaxPercent: json["mandi_tax_percent"],
    mandiFees: json["mandi_fees"],
    finalPerQtlGst: json["final_per_qtl_gst"],
    gst: json["gst"],
    gstAmount: json["gst_amount"],
    pdf: json["pdf"],
    paymentStatus: json["payment_status"],
    invoice: json["invoice"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    userAmount: json["user_amount"],
    agCommissionPercent: json["ag_commission_percent"],
    mandiPrice: json["mandi_price"],
    mandiTaxRate: json["mandi_tax_rate"],
    dealFinalPrice: json["deal_final_price"],
    totalGstAmount: json["total_gst_amount"],
    gstRate: json["gst_rate"],
    noOfBags: json["no_of_bags"],
    category: json["category"],
    qualityCategory: json["quality_category"],
    fname: json["fname"],
    buyerPanNo: json["buyer_pan_no"],
    buyerPhone: json["buyer_phone"],
    sellerName: json["seller_name"],
    sellerPhone: json["seller_phone"],
    salesStatus: json["sales_status"],
    location: json["location"],
    bags: json["bags"],
    bankSlip: json["Bank_slip"],
    commodityImage: json["commodity_image"],
    qualityGrade: json["quality_grade"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "contract_id": contractId,
    "buyer_id": buyerId,
    "seller_id": sellerId,
    "seller_cat_id": sellerCatId,
    "case_id": caseId,
    "payment_ref_no": paymentRefNo,
    "quantity": quantity,
    "price": price,
    "final_price": finalPrice,
    "labour_rate": labourRate,
    "todays_price": todaysPrice,
    "bid_type": bidType,
    "ag_commission_rate": agCommissionRate,
    "ag_commission_amount": agCommissionAmount,
    "commodity_gst_percent": commodityGstPercent,
    "mandi_tax_percent": mandiTaxPercent,
    "mandi_fees": mandiFees,
    "final_per_qtl_gst": finalPerQtlGst,
    "gst": gst,
    "gst_amount": gstAmount,
    "pdf": pdf,
    "payment_status": paymentStatus,
    "invoice": invoice,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user_amount": userAmount,
    "ag_commission_percent": agCommissionPercent,
    "mandi_price": mandiPrice,
    "mandi_tax_rate": mandiTaxRate,
    "deal_final_price": dealFinalPrice,
    "total_gst_amount": totalGstAmount,
    "gst_rate": gstRate,
    "no_of_bags": noOfBags,
    "category": category,
    "quality_category": qualityCategory,
    "fname": fname,
    "buyer_pan_no": buyerPanNo,
    "buyer_phone": buyerPhone,
    "seller_name": sellerName,
    "seller_phone": sellerPhone,
    "sales_status": salesStatus,
    "location": location,
    "bags": bags,
    "Bank_slip": bankSlip,
    "cat_image": commodityImage,
    "quality_grade": qualityGrade,
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
