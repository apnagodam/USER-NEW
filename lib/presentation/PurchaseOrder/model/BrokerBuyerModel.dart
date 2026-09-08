// To parse this JSON data, do
//
//     final brokerBuyerModel = brokerBuyerModelFromJson(jsonString);

import 'dart:convert';

BrokerBuyerModel brokerBuyerModelFromJson(String str) => BrokerBuyerModel.fromJson(json.decode(str));

String brokerBuyerModelToJson(BrokerBuyerModel data) => json.encode(data.toJson());

class BrokerBuyerModel {
    String? status;
    List<BrokerBuyerDatum>? data;

    BrokerBuyerModel({
        this.status,
        this.data,
    });

    factory BrokerBuyerModel.fromJson(Map<String, dynamic> json) => BrokerBuyerModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<BrokerBuyerDatum>.from(json["data"]!.map((x) => BrokerBuyerDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class BrokerBuyerDatum {
    int? userId;
    String? name;

    BrokerBuyerDatum({
        this.userId,
        this.name,
    });

    factory BrokerBuyerDatum.fromJson(Map<String, dynamic> json) => BrokerBuyerDatum(
        userId: json["user_id"] is int ? json["user_id"] : (json["id"] is int ? json["id"] : int.tryParse((json["user_id"] ?? json["id"])?.toString() ?? '')),
        name: (json["name"] ?? json["username"])?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
    };

    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
        other is BrokerBuyerDatum &&
            runtimeType == other.runtimeType &&
            userId == other.userId;

    @override
    int get hashCode => userId.hashCode;
}

// 1. Warehouse, Broker, and Buyer Data Model (user_api/getWarehouseData)
PoWarehouseBrokerBuyerModel poWarehouseBrokerBuyerModelFromJson(String str) =>
    PoWarehouseBrokerBuyerModel.fromJson(json.decode(str));

class PoWarehouseBrokerBuyerModel {
  dynamic status;
  List<PoWarehouseItem>? warehouseData;
  List<PoUserItem>? brokerData;
  List<PoUserItem>? buyerData;

  PoWarehouseBrokerBuyerModel({
    this.status,
    this.warehouseData,
    this.brokerData,
    this.buyerData,
  });

  factory PoWarehouseBrokerBuyerModel.fromJson(Map<String, dynamic> json) {
    final rawWarehouse = json["warehouseData"] ??
        json["WarehouseData"] ??
        json["warehouse_data"] ??
        json["warehouses"] ??
        json["data"];
    final rawBroker = json["brokerData"] ??
        json["BrokerData"] ??
        json["broker_data"] ??
        json["brokers"] ??
        json["broker"];
    final rawBuyer = json["buyerData"] ??
        json["BuyerData"] ??
        json["buyer_data"] ??
        json["buyers"] ??
        json["buyer"];

    return PoWarehouseBrokerBuyerModel(
      status: json["status"],
      warehouseData: rawWarehouse is List
          ? List<PoWarehouseItem>.from(rawWarehouse.map((x) =>
              PoWarehouseItem.fromJson(
                  x is Map<String, dynamic> ? x : Map<String, dynamic>.from(x))))
          : [],
      brokerData: rawBroker is List
          ? List<PoUserItem>.from(rawBroker.map((x) => PoUserItem.fromJson(
              x is Map<String, dynamic> ? x : Map<String, dynamic>.from(x))))
          : [],
      buyerData: rawBuyer is List
          ? List<PoUserItem>.from(rawBuyer.map((x) => PoUserItem.fromJson(
              x is Map<String, dynamic> ? x : Map<String, dynamic>.from(x))))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "warehouseData": warehouseData == null
            ? []
            : List<dynamic>.from(warehouseData!.map((x) => x.toJson())),
        "brokerData": brokerData == null
            ? []
            : List<dynamic>.from(brokerData!.map((x) => x.toJson())),
        "buyerData": buyerData == null
            ? []
            : List<dynamic>.from(buyerData!.map((x) => x.toJson())),
      };
}

class PoWarehouseItem {
  int? id;
  String? name;

  PoWarehouseItem({
    this.id,
    this.name,
  });

  factory PoWarehouseItem.fromJson(Map<String, dynamic> json) =>
      PoWarehouseItem(
        id: json["id"] is int
            ? json["id"]
            : (json["terminal_id"] is int
                ? json["terminal_id"]
                : int.tryParse((json["id"] ??
                        json["terminal_id"] ??
                        json["warehouse_id"])
                    ?.toString() ??
                    '')),
        name: (json["name"] ??
                json["lpName"] ??
                json["lp_name"] ??
                json["warehouse_name"] ??
                json["terminal_name"])
            ?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoWarehouseItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class PoUserItem {
  int? id;
  String? name;

  PoUserItem({
    this.id,
    this.name,
  });

  factory PoUserItem.fromJson(Map<String, dynamic> json) => PoUserItem(
        id: json["id"] is int
            ? json["id"]
            : (json["user_id"] is int
                ? json["user_id"]
                : (json["userId"] is int
                    ? json["userId"]
                    : int.tryParse((json["id"] ??
                            json["user_id"] ??
                            json["userId"])
                        ?.toString() ??
                        ''))),
        name: (json["lpName"] ??
                json["lp_name"] ??
                json["name"] ??
                json["username"] ??
                json["buyer_name"] ??
                json["broker_name"])
            ?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoUserItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// 2. Commodity Data Model (user_api/getCommodityData)
PoCommodityListModel poCommodityListModelFromJson(String str) =>
    PoCommodityListModel.fromJson(json.decode(str));

class PoCommodityListModel {
  dynamic status;
  List<PoCommodityItem>? commodityData;

  PoCommodityListModel({
    this.status,
    this.commodityData,
  });

  factory PoCommodityListModel.fromJson(Map<String, dynamic> json) {
    final rawCommodity = json["warehouseData"] ??
        json["WarehouseData"] ??
        json["commodityData"] ??
        json["CommodityData"] ??
        json["commodity_data"] ??
        json["commodities"] ??
        json["data"];
    return PoCommodityListModel(
      status: json["status"],
      commodityData: rawCommodity is List
          ? List<PoCommodityItem>.from(rawCommodity.map((x) =>
              PoCommodityItem.fromJson(
                  x is Map<String, dynamic> ? x : Map<String, dynamic>.from(x))))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "commodityData": commodityData == null
            ? []
            : List<dynamic>.from(commodityData!.map((x) => x.toJson())),
      };
}

class PoCommodityItem {
  int? id;
  String? category;

  PoCommodityItem({
    this.id,
    this.category,
  });

  factory PoCommodityItem.fromJson(Map<String, dynamic> json) =>
      PoCommodityItem(
        id: json["id"] is int
            ? json["id"]
            : (json["commodity_id"] is int
                ? json["commodity_id"]
                : int.tryParse((json["id"] ?? json["commodity_id"])
                        ?.toString() ??
                    '')),
        category: (json["category"] ??
                json["commodity_name"] ??
                json["name"] ??
                json["category_name"])
            ?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoCommodityItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// 3. Ship To Data Model (user_api/getShipToUserData)
PoShipToBuyerModel poShipToBuyerModelFromJson(String str) =>
    PoShipToBuyerModel.fromJson(json.decode(str));

class PoShipToBuyerModel {
  dynamic status;
  List<PoUserItem>? buyers;

  PoShipToBuyerModel({
    this.status,
    this.buyers,
  });

  factory PoShipToBuyerModel.fromJson(Map<String, dynamic> json) {
    final rawBuyers = json["buyer"] ??
        json["Buyer"] ??
        json["buyerData"] ??
        json["BuyerData"] ??
        json["buyer_data"] ??
        json["buyers"] ??
        json["data"];
    return PoShipToBuyerModel(
      status: json["status"],
      buyers: rawBuyers is List
          ? List<PoUserItem>.from(rawBuyers.map((x) => PoUserItem.fromJson(
              x is Map<String, dynamic> ? x : Map<String, dynamic>.from(x))))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "buyer": buyers == null
            ? []
            : List<dynamic>.from(buyers!.map((x) => x.toJson())),
      };
}

// 4. Factory List Data Model (user_api/getFactoryList)
PoFactoryListModel poFactoryListModelFromJson(String str) =>
    PoFactoryListModel.fromJson(json.decode(str));

class PoFactoryListModel {
  dynamic status;
  List<PoFactoryItem>? factoryList;

  PoFactoryListModel({
    this.status,
    this.factoryList,
  });

  factory PoFactoryListModel.fromJson(Map<String, dynamic> json) {
    final rawFactories = json["factoryList"] ??
        json["FactoryList"] ??
        json["factory_list"] ??
        json["factories"] ??
        json["data"];
    return PoFactoryListModel(
      status: json["status"],
      factoryList: rawFactories is List
          ? List<PoFactoryItem>.from(rawFactories.map((x) =>
              PoFactoryItem.fromJson(
                  x is Map<String, dynamic> ? x : Map<String, dynamic>.from(x))))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "factoryList": factoryList == null
            ? []
            : List<dynamic>.from(factoryList!.map((x) => x.toJson())),
      };
}

class PoFactoryItem {
  int? id;
  String? factoryName;
  String? factoryAddress;

  PoFactoryItem({
    this.id,
    this.factoryName,
    this.factoryAddress,
  });

  factory PoFactoryItem.fromJson(Map<String, dynamic> json) => PoFactoryItem(
        id: json["id"] is int
            ? json["id"]
            : (json["factory_id"] is int
                ? json["factory_id"]
                : int.tryParse((json["id"] ?? json["factory_id"])
                        ?.toString() ??
                    '')),
        factoryName: (json["factory_name"] ??
                json["factoryName"] ??
                json["name"] ??
                json["lpName"])
            ?.toString(),
        factoryAddress: (json["factory_address"] ??
                json["factoryAddress"] ??
                json["address"] ??
                json["buyer_address"])
            ?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "factory_name": factoryName,
        "factory_address": factoryAddress,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoFactoryItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
