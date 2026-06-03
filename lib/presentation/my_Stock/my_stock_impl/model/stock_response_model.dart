// To parse this JSON data, do
//
//     final stockResponseModel = stockResponseModelFromMap(jsonString);

import 'dart:convert';

StockResponseModel stockResponseModelFromMap(String str) =>
    StockResponseModel.fromMap(json.decode(str));

String stockResponseModelToMap(StockResponseModel data) =>
    json.encode(data.toMap());

class StockResponseModel {
  List<Bank>? banks;
  dynamic userTradeStatus;
  dynamic bnplAmount;
  dynamic bnplInterestAmount;
  List<CommodityDatum>? commodityData;
  List<WarehouseDatum>? warehouseData;
  Inventories? inventories;
  String? status;
  String? message;

  StockResponseModel({
    this.banks,
    this.userTradeStatus,
    this.bnplAmount,
    this.bnplInterestAmount,
    this.commodityData,
    this.warehouseData,
    this.inventories,
    this.status,
    this.message,
  });

  factory StockResponseModel.fromMap(Map<String, dynamic> json) =>
      StockResponseModel(
        banks: json["banks"] == null
            ? []
            : List<Bank>.from(json["banks"]!.map((x) => Bank.fromMap(x))),
        userTradeStatus: json["user_trade_status"],
        bnplAmount: json["bnpl_amount"],
        bnplInterestAmount: json["bnpl_interest_amount"],
        commodityData: json["commodity_data"] == null
            ? []
            : List<CommodityDatum>.from(
                json["commodity_data"]!.map((x) => CommodityDatum.fromMap(x))),
        warehouseData: json["warehouse_data"] == null
            ? []
            : List<WarehouseDatum>.from(
                json["warehouse_data"]!.map((x) => WarehouseDatum.fromMap(x))),
        inventories: json["inventories"] == null
            ? null
            : Inventories.fromMap(json["inventories"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "banks": banks == null
            ? []
            : List<dynamic>.from(banks!.map((x) => x.toMap())),
        "user_trade_status": userTradeStatus,
        "bnpl_amount": bnplAmount,
        "bnpl_interest_amount": bnplInterestAmount,
        "commodity_data": commodityData == null
            ? []
            : List<dynamic>.from(commodityData!.map((x) => x.toMap())),
        "warehouse_data": warehouseData == null
            ? []
            : List<dynamic>.from(warehouseData!.map((x) => x.toMap())),
        "inventories": inventories?.toMap(),
        "status": status,
        "message": message,
      };
}

class Bank {
  dynamic id;
  String? bankName;
  String? url;
  String? address;
  String? interestRate;
  String? loanPassDays;
  String? processingFee;
  String? loanPerTotalAmount;
  String? guarantor;
  dynamic guaranteeFee;
  dynamic tenor;
  dynamic status;
  String? createdAt;
  String? updatedAt;
  String? apr;
  dynamic sanctionLimit;

  Bank({
    this.id,
    this.bankName,
    this.url,
    this.address,
    this.interestRate,
    this.loanPassDays,
    this.processingFee,
    this.loanPerTotalAmount,
    this.guarantor,
    this.guaranteeFee,
    this.tenor,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.apr,
    this.sanctionLimit,
  });

  factory Bank.fromMap(Map<String, dynamic> json) => Bank(
        id: json["id"],
        bankName: json["bank_name"],
        url: json["url"],
        address: json["address"],
        interestRate: json["interest_rate"],
        loanPassDays: json["loan_pass_days"],
        processingFee: json["processing_fee"],
        loanPerTotalAmount: json["loan_per_total_amount"],
        guarantor: json["guarantor"],
        guaranteeFee: json["guarantee_fee"],
        tenor: json["tenor"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        apr: json["apr"],
        sanctionLimit: json["sanction_limit"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bank_name": bankName,
        "url": url,
        "address": address,
        "interest_rate": interestRate,
        "loan_pass_days": loanPassDays,
        "processing_fee": processingFee,
        "loan_per_total_amount": loanPerTotalAmount,
        "guarantor": guarantor,
        "guarantee_fee": guaranteeFee,
        "tenor": tenor,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "apr": apr,
        "sanction_limit": sanctionLimit,
      };
}

class CommodityDatum {
  dynamic id;
  String? category;

  CommodityDatum({
    this.id,
    this.category,
  });

  factory CommodityDatum.fromMap(Map<String, dynamic> json) => CommodityDatum(
        id: json["id"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category": category,
      };
}

class Inventories {
  dynamic currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
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
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
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

class Datum {
  dynamic id;
  dynamic userId;
  dynamic caseId;
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
  String? sellQuantity;
  String? price;
  String? gatePassWr;
  dynamic qualityCategory;
  dynamic origin;
  dynamic image;
  dynamic file;
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
  String? catName;
  dynamic catExpDate;
  dynamic qualityPCondition;
  String? name;
  String? warehouseCode;
  String? location;
  dynamic financesId;
  dynamic financesStatus;
  dynamic commodityPrice;
  dynamic principalAmount;
  dynamic checkLoanCount;
  dynamic interestAmount;
  dynamic rentAmount;
  dynamic invCount;
  String? pdfLink;
  dynamic ownership;
  dynamic vehicleNo;

  List<QualityParameter>? qualityParameter;
  dynamic qvAmount;

  Datum(
      {this.id,
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
      this.catName,
      this.catExpDate,
      this.qualityPCondition,
      this.name,
      this.warehouseCode,
      this.location,
      this.financesId,
      this.financesStatus,
      this.commodityPrice,
      this.principalAmount,
      this.checkLoanCount,
      this.interestAmount,
      this.rentAmount,
      this.invCount,
      this.pdfLink,
      this.qualityParameter,
      this.qvAmount,
      this.ownership,
      this.vehicleNo});

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
      image: json["cat_image"],
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
      catName: json["cat_name"],
      catExpDate: json["cat_exp_date"] == null
          ? null
          : DateTime.parse(json["cat_exp_date"]),
      qualityPCondition: json["quality_p_condition"],
      name: json["name"],
      warehouseCode: json["warehouse_code"],
      location: json["location"],
      financesId: json["finances_id"],
      financesStatus: json["finances_status"],
      commodityPrice: json["commodity_price"],
      principalAmount: json["principal_amount"],
      checkLoanCount: json["check_loan_count"],
      interestAmount: json["interest_amount"],
      rentAmount: json["rent_amount"],
      invCount: json["inv_count"],
      pdfLink: json["pdf_link"],
      qualityParameter: json["quality_parameter"] == null
          ? []
          : List<QualityParameter>.from(json["quality_parameter"]!
              .map((x) => QualityParameter.fromMap(x))),
      qvAmount: json["qv_amount"],
      ownership: json['owernship'],
      vehicleNo: json['vehicle']);

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
        "cat_image": image,
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
        "cat_name": catName,
        "cat_exp_date":
            "${catExpDate!.year.toString().padLeft(4, '0')}-${catExpDate!.month.toString().padLeft(2, '0')}-${catExpDate!.day.toString().padLeft(2, '0')}",
        "quality_p_condition": qualityPCondition,
        "name": name,
        "warehouse_code": warehouseCode,
        "location": location,
        "finances_id": financesId,
        "finances_status": financesStatus,
        "commodity_price": commodityPrice,
        "principal_amount": principalAmount,
        "check_loan_count": checkLoanCount,
        "interest_amount": interestAmount,
        "rent_amount": rentAmount,
        "inv_count": invCount,
        "pdf_link": pdfLink,
        "quality_parameter": qualityParameter == null
            ? []
            : List<dynamic>.from(qualityParameter!.map((x) => x.toMap())),
        "qv_amount": qvAmount,
        "owernship": ownership,
        "vehicle": vehicleNo
      };
}

class QualityParameter {
  dynamic id;
  dynamic commodityId;
  dynamic parameterId;
  dynamic min;
  dynamic max;
  dynamic status;
  String? createdAt;
  String? updatedAt;
  dynamic value;
  String? parameter;
  QualityParameters? qualityParameters;

  QualityParameter({
    this.id,
    this.commodityId,
    this.parameterId,
    this.min,
    this.max,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.value,
    this.parameter,
    this.qualityParameters,
  });

  factory QualityParameter.fromMap(Map<String, dynamic> json) =>
      QualityParameter(
        id: json["id"],
        commodityId: json["commodity_id"],
        parameterId: json["parameter_id"],
        min: json["min"],
        max: json["max"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        value: json["value"],
        parameter: json["parameter"],
        qualityParameters: json["quality_parameters"] == null
            ? null
            : QualityParameters.fromMap(json["quality_parameters"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "commodity_id": commodityId,
        "parameter_id": parameterId,
        "min": min,
        "max": max,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "value": value,
        "parameter": parameter,
        "quality_parameters": qualityParameters?.toMap(),
      };
}

class QualityParameters {
  dynamic id;
  String? parameter;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  QualityParameters({
    this.id,
    this.parameter,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory QualityParameters.fromMap(Map<String, dynamic> json) =>
      QualityParameters(
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

class Link {
  String? url;
  String? label;
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

class WarehouseDatum {
  dynamic id;
  String? warehouseName;

  WarehouseDatum({
    this.id,
    this.warehouseName,
  });

  factory WarehouseDatum.fromMap(Map<String, dynamic> json) => WarehouseDatum(
        id: json["id"],
        warehouseName: json["warehouse_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "warehouse_name": warehouseName,
      };
}
