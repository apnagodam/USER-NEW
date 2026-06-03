// To parse this JSON data, do
//
//     final warehouseDealModel = warehouseDealModelFromMap(jsonString);

import 'dart:convert';

WarehouseDealModel warehouseDealModelFromMap(String str) =>
    WarehouseDealModel.fromMap(json.decode(str));

String warehouseDealModelToMap(WarehouseDealModel data) =>
    json.encode(data.toMap());

class WarehouseDealModel {
  Inventories? inventories;
  dynamic status;
  dynamic message;

  WarehouseDealModel({
    this.inventories,
    this.status,
    this.message,
  });

  factory WarehouseDealModel.fromMap(Map<String, dynamic> json) =>
      WarehouseDealModel(
        inventories: json["inventories"] == null
            ? null
            : Inventories.fromMap(json["inventories"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "inventories": inventories?.toMap(),
        "status": status,
        "message": message,
      };
}

class Inventories {
  dynamic currentPage;
  List<InventoryDatum>? data;
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

  Inventories({
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

  factory Inventories.fromMap(Map<String, dynamic> json) => Inventories(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<InventoryDatum>.from(
                json["data"]!.map((x) => InventoryDatum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class InventoryDatum {
  dynamic id;
  dynamic uniqueId;
  dynamic buyerId;
  dynamic sellerId;
  dynamic sellerCatId;
  dynamic paymentRefNo;
  dynamic quantity;
  dynamic price;
  dynamic labourRate;
  dynamic todaysPrice;
  dynamic bidType;
  dynamic mandiFees;
  dynamic rentRowId;
  dynamic interestRowId;
  dynamic financeId;
  dynamic finalMandiAmount;
  dynamic finalSettlmentAmount;
  dynamic finalRemAmount;
  dynamic finalWalletSatlementAmount;
  dynamic mandiTaxRate;
  dynamic mandiTaxAmount;
  dynamic agCommission;
  dynamic gst;
  dynamic gstAmount;
  dynamic paymentAdvice;
  dynamic qvAmount;
  dynamic isInvoice;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic category;
  dynamic qualityCategory;
  dynamic name;
  dynamic location;
  dynamic fname;
  dynamic salesStatus;
  dynamic gatePassWr;

  InventoryDatum({
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
    this.category,
    this.qualityCategory,
    this.name,
    this.location,
    this.fname,
    this.salesStatus,
    this.gatePassWr,
  });

  factory InventoryDatum.fromMap(Map<String, dynamic> json) => InventoryDatum(
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        category: json["category"],
        qualityCategory: json["quality_category"],
        name: json["name"],
        location: json["location"],
        fname: json["fname"],
        salesStatus: json["sales_status"],
        gatePassWr: json["gate_pass_wr"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category": category,
        "quality_category": qualityCategory,
        "name": name,
        "location": location,
        "fname": fname,
        "sales_status": salesStatus,
        "gate_pass_wr": gatePassWr,
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
