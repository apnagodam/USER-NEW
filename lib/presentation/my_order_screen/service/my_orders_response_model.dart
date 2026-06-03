// To parse this JSON data, do
//
//     final myOrdersResponseModel = myOrdersResponseModelFromMap(jsonString);

import 'dart:convert';

MyOrdersResponseModel myOrdersResponseModelFromMap(String str) =>
    MyOrdersResponseModel.fromMap(json.decode(str));

String myOrdersResponseModelToMap(MyOrdersResponseModel data) =>
    json.encode(data.toMap());

class MyOrdersResponseModel {
  OrderList? orderList;
  dynamic status;
  dynamic message;

  MyOrdersResponseModel({
    this.orderList,
    this.status,
    this.message,
  });

  factory MyOrdersResponseModel.fromMap(Map<String, dynamic> json) =>
      MyOrdersResponseModel(
        orderList: json["order_list"] == null
            ? null
            : OrderList.fromMap(json["order_list"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "order_list": orderList?.toMap(),
        "status": status,
        "message": message,
      };
}

class OrderList {
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

  OrderList({
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

  factory OrderList.fromMap(Map<String, dynamic> json) => OrderList(
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
  dynamic terminalId;
  dynamic commodityId;
  dynamic pincode;
  dynamic location;
  dynamic price;
  dynamic quantity;
  dynamic amount;
  dynamic requestedQuantity;
  dynamic deliveryAt;
  dynamic transportCost;
  dynamic corporateUsersLat;
  dynamic corporateUsersLong;
  dynamic empId;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic ordersCount;
  Commodity? commodity;
  Warehouses? warehouses;

  Datum({
    this.id,
    this.userId,
    this.terminalId,
    this.commodityId,
    this.pincode,
    this.location,
    this.price,
    this.quantity,
    this.amount,
    this.requestedQuantity,
    this.deliveryAt,
    this.transportCost,
    this.corporateUsersLat,
    this.corporateUsersLong,
    this.empId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.ordersCount,
    this.commodity,
    this.warehouses,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        terminalId: json["terminal_id"],
        commodityId: json["commodity_id"],
        pincode: json["pincode"],
        location: json["location"],
        price: json["price"],
        quantity: json["quantity"],
        amount: json["amount"],
        requestedQuantity: json["requested_quantity"],
        deliveryAt: json["delivery_at"],
        transportCost: json["transport_cost"],
        corporateUsersLat: json["corporate_users_lat"],
        corporateUsersLong: json["corporate_users_long"],
        empId: json["emp_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        ordersCount: json["orders_count"],
        commodity: json["commodity"] == null
            ? null
            : Commodity.fromMap(json["commodity"]),
        warehouses: json["warehouses"] == null
            ? null
            : Warehouses.fromMap(json["warehouses"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "terminal_id": terminalId,
        "commodity_id": commodityId,
        "pincode": pincode,
        "location": location,
        "price": price,
        "quantity": quantity,
        "amount": amount,
        "requested_quantity": requestedQuantity,
        "delivery_at": deliveryAt,
        "transport_cost": transportCost,
        "corporate_users_lat": corporateUsersLat,
        "corporate_users_long": corporateUsersLong,
        "emp_id": empId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "orders_count": ordersCount,
        "commodity": commodity?.toMap(),
        "warehouses": warehouses?.toMap(),
      };
}

class Commodity {
  dynamic id;
  dynamic category;
  dynamic categoryHi;

  Commodity({
    this.id,
    this.category,
    this.categoryHi,
  });

  factory Commodity.fromMap(Map<String, dynamic> json) => Commodity(
        id: json["id"],
        category: json["category"],
        categoryHi: json["category_hi"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category": category,
        "category_hi": categoryHi,
      };
}

class Warehouses {
  dynamic id;
  dynamic name;

  Warehouses({
    this.id,
    this.name,
  });

  factory Warehouses.fromMap(Map<String, dynamic> json) => Warehouses(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
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
