// To parse this JSON data, do
//
//     final stackSellListModel = stackSellListModelFromMap(jsonString);

import 'dart:convert';

StackSellListModel stackSellListModelFromMap(String str) =>
    StackSellListModel.fromMap(json.decode(str));

String stackSellListModelToMap(StackSellListModel data) =>
    json.encode(data.toMap());

class StackSellListModel {
  dynamic status;
  dynamic message;
  List<StackSellDatum>? data;

  StackSellListModel({
    this.status,
    this.message,
    this.data,
  });

  factory StackSellListModel.fromMap(Map<String, dynamic> json) =>
      StackSellListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<StackSellDatum>.from(
                json["data"]!.map((x) => StackSellDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class StackSellDatum {
  dynamic id;
  dynamic sellerId;
  dynamic buyerId;
  dynamic warehouseName;
  dynamic warehouseAddress;
  dynamic commodityName;
  dynamic sellerPrice;
  dynamic stackNumber;
  dynamic quantity;
  dynamic bestBuyerPrice;
  dynamic buyerPrice;
  List<StackBuySellConver>? stackBuySellConver;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic commodityImage;
  dynamic commodityPath;
  dynamic bidTime;

  StackSellDatum(
      {this.id,
      this.sellerId,
      this.buyerId,
      this.warehouseName,
      this.warehouseAddress,
      this.commodityName,
      this.sellerPrice,
      this.stackNumber,
      this.quantity,
      this.bestBuyerPrice,
      this.buyerPrice,
      this.stackBuySellConver,
      this.minPrice,
      this.maxPrice,
      this.commodityImage,
      this.commodityPath,
      this.bidTime});

  factory StackSellDatum.fromMap(Map<String, dynamic> json) => StackSellDatum(
      id: json["id"],
      sellerId: json["seller_id"],
      buyerId: json["buyer_id"],
      warehouseName: json["warehouse_name"],
      warehouseAddress: json["warehouse_address"],
      commodityName: json["commodity_name"],
      sellerPrice: json["seller_price"],
      stackNumber: json["stack_number"],
      quantity: json["quantity"],
      bestBuyerPrice: json["best_buyer_price"],
      buyerPrice: json["buyer_price"],
      stackBuySellConver: json["stack_buy_sell_conver"] == null
          ? []
          : List<StackBuySellConver>.from(json["stack_buy_sell_conver"]!
              .map((x) => StackBuySellConver.fromMap(x))),
      minPrice: json["min_price"],
      maxPrice: json["max_price"],
      commodityImage: json["commodity_image"],
      commodityPath: json["commodity_path"],
      bidTime: json['bid_time']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "seller_id": sellerId,
        "buyer_id": buyerId,
        "warehouse_name": warehouseName,
        "warehouse_address": warehouseAddress,
        "commodity_name": commodityName,
        "seller_price": sellerPrice,
        "stack_number": stackNumber,
        "quantity": quantity,
        "best_buyer_price": bestBuyerPrice,
        "buyer_price": buyerPrice,
        "stack_buy_sell_conver": stackBuySellConver == null
            ? []
            : List<dynamic>.from(stackBuySellConver!.map((x) => x.toMap())),
        "min_price": minPrice,
        "max_price": maxPrice,
        "commodity_image": commodityImage,
        "commodity_path": commodityPath,
        "bid_time": bidTime
      };
}

class StackBuySellConver {
  dynamic id;
  dynamic buySellId;
  dynamic userId;
  dynamic price;
  dynamic lifitingDays;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  StackBuySellConver({
    this.id,
    this.buySellId,
    this.userId,
    this.price,
    this.lifitingDays,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory StackBuySellConver.fromMap(Map<String, dynamic> json) =>
      StackBuySellConver(
        id: json["id"],
        buySellId: json["buy_sell_id"],
        userId: json["user_id"],
        price: json["price"],
        lifitingDays: json["lifiting_days"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "buy_sell_id": buySellId,
        "user_id": userId,
        "price": price,
        "lifiting_days": lifitingDays,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
