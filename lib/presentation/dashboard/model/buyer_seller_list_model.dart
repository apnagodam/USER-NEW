// To parse this JSON data, do
//
//     final buyerSelletListModel = buyerSelletListModelFromMap(jsonString);

import 'dart:convert';

BuyerSelletListModel buyerSelletListModelFromMap(String str) => BuyerSelletListModel.fromMap(json.decode(str));

String buyerSelletListModelToMap(BuyerSelletListModel data) => json.encode(data.toMap());

class BuyerSelletListModel {
  dynamic status;
  dynamic message;
  List<ErDatum>? buyerData;
  List<ErDatum>? sellerData;
  List<TruckDatum>? truckData;

  BuyerSelletListModel({
    this.status,
    this.message,
    this.buyerData,
    this.sellerData,
    this.truckData,
  });

  factory BuyerSelletListModel.fromMap(Map<String, dynamic> json) => BuyerSelletListModel(
    status: json["status"],
    message: json["message"],
    buyerData: json["buyer_data"] == null ? [] : List<ErDatum>.from(json["buyer_data"]!.map((x) => ErDatum.fromMap(x))),
    sellerData: json["seller_data"] == null ? [] : List<ErDatum>.from(json["seller_data"]!.map((x) => ErDatum.fromMap(x))),
    truckData: json["truck_data"] == null ? [] : List<TruckDatum>.from(json["truck_data"]!.map((x) => TruckDatum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "buyer_data": buyerData == null ? [] : List<dynamic>.from(buyerData!.map((x) => x.toMap())),
    "seller_data": sellerData == null ? [] : List<dynamic>.from(sellerData!.map((x) => x.toMap())),
    "truck_data": truckData == null ? [] : List<dynamic>.from(truckData!.map((x) => x.toMap())),
  };
}

class ErDatum {
  dynamic state;
  dynamic pinCode;
  dynamic city;
  dynamic commodity;
  dynamic rate;
  dynamic qty;
  dynamic userRating;
  dynamic date;
  dynamic type;
  dynamic tradeId;

  ErDatum({
    this.state,
    this.pinCode,
    this.city,
    this.commodity,
    this.rate,
    this.qty,
    this.userRating,
    this.date,
    this.type,
    this.tradeId
  });

  factory ErDatum.fromMap(Map<String, dynamic> json) => ErDatum(
    state: json["state"],
    pinCode: json["pin_code"],
    city: json["city"],
    commodity: json["commodity"],
    rate: json["rate"],
    qty: json["qty"],
    userRating: json["user_rating"],
    date: json["date"],
    type:json['type'],
      tradeId: json['trade_id']
  );

  Map<String, dynamic> toMap() => {
    "state": state,
    "pin_code": pinCode,
    "city": city,
    "commodity": commodity,
    "rate": rate,
    "qty": qty,
    "user_rating": userRating,
    "date": date,
    "type":type,
    'trade_id':tradeId
  };
}

class TruckDatum {
  dynamic state;
  dynamic city;
  dynamic pinCode;
  dynamic commodity;
  dynamic qty;
  dynamic truckNo;

  TruckDatum({
    this.state,
    this.city,
    this.pinCode,
    this.commodity,
    this.qty,
    this.truckNo,
  });

  factory TruckDatum.fromMap(Map<String, dynamic> json) => TruckDatum(
    state: json["state"],
    city: json["city"],
    pinCode: json["pin_code"],
    commodity: json["commodity"],
    qty: json["qty"],
    truckNo: json["truck_no"],
  );

  Map<String, dynamic> toMap() => {
    "state": state,
    "city": city,
    "pin_code": pinCode,
    "commodity": commodity,
    "qty": qty,
    "truck_no": truckNo,
  };
}
