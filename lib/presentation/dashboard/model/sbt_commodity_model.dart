// To parse this JSON data, do
//
//     final sbtCommodityModel = sbtCommodityModelFromMap(jsonString);

import 'dart:convert';

SbtCommodityModel sbtCommodityModelFromMap(String str) =>
    SbtCommodityModel.fromMap(json.decode(str));

String sbtCommodityModelToMap(SbtCommodityModel data) =>
    json.encode(data.toMap());

class SbtCommodityModel {
  dynamic status;
  dynamic message;
  List<SbtDatum>? data;

  SbtCommodityModel({
    this.status,
    this.message,
    this.data,
  });

  factory SbtCommodityModel.fromMap(Map<String, dynamic> json) {
    dynamic rawData = json["data"] ??
        json["Data"] ??
        json["product_list"] ??
        json["products"] ??
        json["result"] ??
        json["items"] ??
        json["commodity_list"] ??
        json["todays_price"];

    List<SbtDatum> items = [];
    if (rawData is List) {
      for (var item in rawData) {
        if (item is Map) {
          try {
            items.add(SbtDatum.fromMap(Map<String, dynamic>.from(item)));
          } catch (_) {}
        }
      }
    } else if (rawData is Map) {
      for (var item in rawData.values) {
        if (item is Map) {
          try {
            items.add(SbtDatum.fromMap(Map<String, dynamic>.from(item)));
          } catch (_) {}
        }
      }
    }

    return SbtCommodityModel(
      status: json["status"] ?? 1,
      message: json["message"] ?? json["Message"],
      data: items,
    );
  }

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class SbtDatum {
  dynamic productId;
  dynamic districtId;
  dynamic district;
  dynamic commodityId;
  dynamic commodity;
  int? upperCircuit;
  int? lowerCircuit;
  int? quantityLimit;
  dynamic bestBuyer;
  dynamic bestSeller;
  dynamic date;
  dynamic ltp;
  dynamic sbtType;

  SbtDatum(
      {this.productId,
      this.districtId,
      this.district,
      this.commodityId,
      this.commodity,
      this.upperCircuit,
      this.lowerCircuit,
      this.quantityLimit,
      this.bestBuyer,
      this.bestSeller,
      this.date,
      this.ltp,
      this.sbtType});

  static int safeParseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.round();
    final str = value.toString().trim();
    if (str.isEmpty) return 0;
    final parsedInt = int.tryParse(str);
    if (parsedInt != null) return parsedInt;
    final parsedDouble = double.tryParse(str);
    if (parsedDouble != null) return parsedDouble.round();
    return 0;
  }

  factory SbtDatum.fromMap(Map<String, dynamic> json) => SbtDatum(
      productId: json['product_id'] ?? json['productId'] ?? json['id'] ?? '1',
      districtId: json["district_id"] ?? json["districtId"] ?? '1',
      district: json["district"] ?? json["district_name"] ?? json["districtName"] ?? '',
      commodityId: json["commodity_id"] ?? json["commodityId"] ?? json["id"] ?? '1',
      commodity: json["commodity"] ?? json["commodity_name"] ?? json["commodityName"] ?? json["crop_name"] ?? '',
      upperCircuit: safeParseInt(json["upper_circuit"] ?? json["upperCircuit"] ?? json["max_price"]),
      lowerCircuit: safeParseInt(json["lower_circuit"] ?? json["lowerCircuit"] ?? json["min_price"]),
      quantityLimit: safeParseInt(json["quantity_limit"] ?? json["quantityLimit"] ?? 1000),
      bestBuyer: json['best_buyer'] ?? json['bestBuyer'] ?? json['buyer_price'] ?? json['buyerPrice'] ?? json['modal_price'] ?? 0,
      bestSeller: json['best_seller'] ?? json['bestSeller'] ?? json['seller_price'] ?? json['sellerPrice'] ?? json['modal_price'] ?? 0,
      date: json["date"] ?? json["bid_date"] ?? json["bid_time"] ?? json["bidTime"] ?? json["date_time"] ?? '',
      ltp: (json['ltp'] ?? json['last_trade_price'] ?? json['lastTradePrice'] ?? json['price'] ?? json['modal_price'] ?? '0').toString(),
      sbtType: (json['sbt_type'] ?? json['sbtType'] ?? '1').toString());

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "district_id": districtId,
        "district": district,
        "commodity_id": commodityId,
        "commodity": commodity,
        "upper_circuit": upperCircuit,
        "lower_circuit": lowerCircuit,
        "quantity_limit": quantityLimit,
        "best_buyer": bestBuyer,
        "best_seller": bestSeller,
        "date": date,
        "ltp": ltp,
        "sbt_type": sbtType
      };
}

final List<SbtDatum> defaultSbtCommodityList = [
  SbtDatum(
    productId: 219,
    districtId: 455,
    district: "Jaipur Delivery Days :- 7",
    commodityId: 8,
    commodity: "Barley",
    upperCircuit: 2500,
    lowerCircuit: 2100,
    quantityLimit: 500,
    bestSeller: 2490,
    bestBuyer: 0,
    ltp: "2250",
    date: "07:00 AM To 10:00 PM",
    sbtType: "1",
  ),
  SbtDatum(
    productId: 218,
    districtId: 464,
    district: "Manda KhatuShyam Ji, Sikar , Manda Delivery Days :- 3",
    commodityId: 27,
    commodity: "Groundnut Mill",
    upperCircuit: 7500,
    lowerCircuit: 6000,
    quantityLimit: 500,
    bestSeller: 0,
    bestBuyer: 0,
    ltp: "0",
    date: "03:00 PM To 04:00 PM",
    sbtType: "2",
  ),
  SbtDatum(
    productId: 217,
    districtId: 464,
    district: "Manda KhatuShyam Ji, Sikar , Sikar Delivery Days :- 3",
    commodityId: 46,
    commodity: "Groundnut Chugga",
    upperCircuit: 7500,
    lowerCircuit: 6000,
    quantityLimit: 500,
    bestSeller: 0,
    bestBuyer: 0,
    ltp: "0",
    date: "02:00 PM To 03:00 PM",
    sbtType: "2",
  ),
  SbtDatum(
    productId: 216,
    districtId: 464,
    district: "Shri Navdurga Udyog Warehouse, Reengus ( Stack No.5 ) , Reengus Delivery Days :- 5",
    commodityId: 88,
    commodity: "Barley 2026",
    upperCircuit: 2800,
    lowerCircuit: 2580,
    quantityLimit: 280,
    bestSeller: 0,
    bestBuyer: 0,
    ltp: "2625",
    date: "03:00 PM To 04:00 PM",
    sbtType: "2",
  ),
  SbtDatum(
    productId: 215,
    districtId: 438,
    district: "Anita Gupta Warehouse , Bikaner (Bigga) ( Stack No.22 ) , BIGGA Delivery Days :- 5",
    commodityId: 88,
    commodity: "Barley 2026",
    upperCircuit: 2800,
    lowerCircuit: 2400,
    quantityLimit: 550,
    bestSeller: 0,
    bestBuyer: 0,
    ltp: "0",
    date: "12:00 PM To 01:00 PM",
    sbtType: "2",
  ),
  SbtDatum(
    productId: 213,
    districtId: 455,
    district: "Agarwal Industries Govindgarh ( Stack No.9 ) , Govindgarh Delivery Days :- 5",
    commodityId: 15,
    commodity: "Wheat",
    upperCircuit: 2800,
    lowerCircuit: 2500,
    quantityLimit: 178,
    bestSeller: 0,
    bestBuyer: 0,
    ltp: "2625",
    date: "10:00 AM To 11:00 AM",
    sbtType: "2",
  ),
  SbtDatum(
    productId: 212,
    districtId: 455,
    district: "Sharda Devi Warehouse, Morija (Chomu) ( Stack No.2.1 ) , Morija Delivery Days :- 7",
    commodityId: 88,
    commodity: "Barley 2026",
    upperCircuit: 2900,
    lowerCircuit: 2600,
    quantityLimit: 1101,
    bestSeller: 0,
    bestBuyer: 0,
    ltp: "2625",
    date: "11:30 AM To 12:00 PM",
    sbtType: "2",
  ),
  SbtDatum(
    productId: 209,
    districtId: 455,
    district: "Agarwal Industries Govindgarh ( Stack No.7.1 ) , Govindgarh Delivery Days :- 3",
    commodityId: 88,
    commodity: "Barley 2026",
    upperCircuit: 2800,
    lowerCircuit: 2100,
    quantityLimit: 250,
    bestSeller: 0,
    bestBuyer: 0,
    ltp: "0",
    date: "11:00 AM To 11:30 AM",
    sbtType: "2",
  ),
  SbtDatum(
    productId: 207,
    districtId: 464,
    district: "Chiraag Logistics Warehouse, Manda (Khatushyamji) ( Stack No.6 ) , Manda Delivery Days :- 5",
    commodityId: 8,
    commodity: "Barley",
    upperCircuit: 2550,
    lowerCircuit: 2480,
    quantityLimit: 2453,
    bestSeller: 0,
    bestBuyer: 0,
    ltp: "2500",
    date: "10:00 AM To 10:00 PM",
    sbtType: "2",
  ),
  SbtDatum(
    productId: 206,
    districtId: 99,
    district: "Mohan Cold Storage Pvt. Ltd. ( Stack No.2 ) , Samastipur , Samastipur , Bihar Delivery Days :- 5",
    commodityId: 9,
    commodity: "Maize",
    upperCircuit: 2500,
    lowerCircuit: 2250,
    quantityLimit: 7701,
    bestSeller: 0,
    bestBuyer: 0,
    ltp: "0",
    date: "02:00 PM To 03:00 PM",
    sbtType: "2",
  ),
];
