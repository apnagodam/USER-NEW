// To parse this JSON data, do
//
//     final sbtSellerContractModel = sbtSellerContractModelFromMap(jsonString);

import 'dart:convert';

SbtSellerContractModel sbtSellerContractModelFromMap(String str) =>
    SbtSellerContractModel.fromMap(json.decode(str));

String sbtSellerContractModelToMap(SbtSellerContractModel data) =>
    json.encode(data.toMap());

class SbtSellerContractModel {
  dynamic status;
  dynamic message;
  Data? data;

  SbtSellerContractModel({
    this.status,
    this.message,
    this.data,
  });

  factory SbtSellerContractModel.fromMap(Map<String, dynamic> json) =>
      SbtSellerContractModel(
        status: json["status"],
        message: json["Message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "Message": message,
        "data": data?.toMap(),
      };
}

class Data {
  dynamic orderId;
  dynamic buyerName;
  dynamic sellerName;
  dynamic commodity;
  dynamic district;
  dynamic price;
  dynamic quantity;
  dynamic delQuantity;
  dynamic defaultQty;
  dynamic orderMatchDate;
  dynamic deliveryDays;
  dynamic loanType;
  List<BuySellDatum>? buySellData;

  Data({
    this.orderId,
    this.buyerName,
    this.sellerName,
    this.commodity,
    this.district,
    this.price,
    this.quantity,
    this.delQuantity,
    this.defaultQty,
    this.orderMatchDate,
    this.deliveryDays,
    this.loanType,
    this.buySellData,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        orderId: json["order_id"],
        buyerName: json["buyer_name"],
        sellerName: json["seller_name"],
        commodity: json["commodity"],
        district: json["district"],
        price: json["price"],
        quantity: json["quantity"],
        delQuantity: json["del_quantity"],
        defaultQty: json["default_qty"],
        orderMatchDate: json["order_match_date"],
        deliveryDays: json['delivery_days'],
        loanType: json['loan_type'],
        buySellData: json["buy_sell_data"] == null
            ? []
            : List<BuySellDatum>.from(
                json["buy_sell_data"]!.map((x) => BuySellDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "order_id": orderId,
        "buyer_name": buyerName,
        "seller_name": sellerName,
        "commodity": commodity,
        "district": district,
        "price": price,
        "quantity": quantity,
        "del_quantity": delQuantity,
        "default_qty": defaultQty,
        "order_match_date": orderMatchDate,
        'delivery_days': deliveryDays,
        'loan_type': loanType,
        "buy_sell_data": buySellData == null
            ? []
            : List<dynamic>.from(buySellData!.map((x) => x.toMap())),
      };
}

class BuySellDatum {
  dynamic date;
  dynamic gatepass;
  dynamic qty;
  dynamic price;
  dynamic warehouseName;
  dynamic labour;
  dynamic entryload;
  dynamic rent;
  dynamic wsa;
  dynamic mandiTax;
  dynamic perQtlQualityClaim;
  dynamic netAmount;
  dynamic bags;
  dynamic vehicleNo;

  BuySellDatum(
      {this.date,
      this.gatepass,
      this.qty,
      this.price,
      this.warehouseName,
      this.labour,
      this.entryload,
      this.rent,
      this.wsa,
      this.mandiTax,
      this.perQtlQualityClaim,
      this.netAmount,
      this.vehicleNo,
      this.bags});

  factory BuySellDatum.fromMap(Map<String, dynamic> json) => BuySellDatum(
      date: json["date"],
      gatepass: json["gatepass"],
      qty: json["qty"],
      price: json["price"],
      warehouseName: json["warehouse_name"],
      labour: json["labour"],
      entryload: json["entryload"],
      rent: json["rent"],
      wsa: json["wsa"],
      mandiTax: json["mandi_tax"],
      perQtlQualityClaim: json["per_qtl_quality_claim"],
      netAmount: json['net_amount'],
      vehicleNo: json['gadi_number'],
      bags: json['bag']);
  Map<String, dynamic> toMap() => {
        "date": date,
        "gatepass": gatepass,
        "qty": qty,
        "price": price,
        "warehouse_name": warehouseName,
        "labour": labour,
        "entryload": entryload,
        "rent": rent,
        "wsa": wsa,
        "mandi_tax": mandiTax,
        "per_qtl_quality_claim": perQtlQualityClaim,
        "net_amount": netAmount,
        "gadi_number": vehicleNo,
        "bag": bags
      };
}
