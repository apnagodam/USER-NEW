// To parse this JSON data, do
//
//     final sbtBuyerContractModel = sbtBuyerContractModelFromMap(jsonString);

import 'dart:convert';

SbtBuyerContractModel sbtBuyerContractModelFromMap(String str) =>
    SbtBuyerContractModel.fromMap(json.decode(str));

String sbtBuyerContractModelToMap(SbtBuyerContractModel data) =>
    json.encode(data.toMap());

class SbtBuyerContractModel {
  dynamic status;
  dynamic message;
  Data? data;

  SbtBuyerContractModel({
    this.status,
    this.message,
    this.data,
  });

  factory SbtBuyerContractModel.fromMap(Map<String, dynamic> json) =>
      SbtBuyerContractModel(
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
  dynamic expiryDate;
  dynamic loanType;
  dynamic vehicleNo;
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
    this.expiryDate,
    this.loanType,
    this.vehicleNo,
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
        expiryDate: json['expiry_date'],
        loanType: json['loan_type'],
        vehicleNo: json['gadi_number'],
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
        "expiry_date": expiryDate,
        'loan_type': loanType,
        "gadi_number":vehicleNo,
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
  dynamic agCommisison;
  dynamic netAmount;
  dynamic bags;

  BuySellDatum(
      {this.date,
      this.gatepass,
      this.qty,
      this.price,
      this.warehouseName,
      this.agCommisison,
      this.netAmount,
      this.bags});

  factory BuySellDatum.fromMap(Map<String, dynamic> json) => BuySellDatum(
      date: json["date"],
      gatepass: json["gatepass"],
      qty: json["qty"],
      price: json["price"],
      warehouseName: json["warehouse_name"],
      agCommisison: json['ag_commission'],
      netAmount: json['net_amt'],
      bags: json['bags']);

  Map<String, dynamic> toMap() => {
        "date": date,
        "gatepass": gatepass,
        "qty": qty,
        "price": price,
        "warehouse_name": warehouseName,
        "ag_commission": agCommisison,
        "net_amt": netAmount,
        "bags": bags
      };
}
