// To parse this JSON data, do
//
//     final inwardsSummaryModel = inwardsSummaryModelFromMap(jsonString);

import 'dart:convert';

InwardsSummaryModel inwardsSummaryModelFromMap(String str) =>
    InwardsSummaryModel.fromMap(json.decode(str));

String inwardsSummaryModelToMap(InwardsSummaryModel data) =>
    json.encode(data.toMap());

class InwardsSummaryModel {
  Data? data;
  String? status;
  String? message;

  InwardsSummaryModel({
    this.data,
    this.status,
    this.message,
  });

  factory InwardsSummaryModel.fromMap(Map<String, dynamic> json) =>
      InwardsSummaryModel(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status,
        "message": message,
      };
}

class Data {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data({
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

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
  int? id;
  int? stackId;
  int? stackRequestRowid;
  int? userId;
  int? terminalId;
  int? commodityId;
  String? vehicleNo;
  dynamic driverNumber;
  dynamic otp;
  String? stackNumber;
  String? requestWeight;
  int? salesStatus;
  dynamic file;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? warehouseCode;
  String? category;

  Datum({
    this.id,
    this.stackId,
    this.stackRequestRowid,
    this.userId,
    this.terminalId,
    this.commodityId,
    this.vehicleNo,
    this.driverNumber,
    this.otp,
    this.stackNumber,
    this.requestWeight,
    this.salesStatus,
    this.file,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.warehouseCode,
    this.category,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        stackId: json["stack_id"],
        stackRequestRowid: json["stack_request_rowid"],
        userId: json["user_id"],
        terminalId: json["terminal_id"],
        commodityId: json["commodity_id"],
        vehicleNo: json["vehicle_no"],
        driverNumber: json["driver_number"],
        otp: json["otp"],
        stackNumber: json["stack_number"],
        requestWeight: json["request_weight"],
        salesStatus: json["sales_status"],
        file: json["file"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        name: json["name"],
        warehouseCode: json["warehouse_code"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "stack_id": stackId,
        "stack_request_rowid": stackRequestRowid,
        "user_id": userId,
        "terminal_id": terminalId,
        "commodity_id": commodityId,
        "vehicle_no": vehicleNo,
        "driver_number": driverNumber,
        "otp": otp,
        "stack_number": stackNumber,
        "request_weight": requestWeight,
        "sales_status": salesStatus,
        "file": file,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name": name,
        "warehouse_code": warehouseCode,
        "category": category,
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
