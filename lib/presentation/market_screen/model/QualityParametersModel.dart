// To parse this JSON data, do
//
//     final productQualityModel = productQualityModelFromMap(jsonString);

import 'dart:convert';

ProductQualityModel productQualityModelFromMap(String str) =>
    ProductQualityModel.fromMap(json.decode(str));

String productQualityModelToMap(ProductQualityModel data) =>
    json.encode(data.toMap());

class ProductQualityModel {
  List<Datum>? data;
  Photos? photos;
  dynamic status;
  dynamic message;

  ProductQualityModel({
    this.data,
    this.photos,
    this.status,
    this.message,
  });

  factory ProductQualityModel.fromMap(Map<String, dynamic> json) =>
      ProductQualityModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        photos: json["photos"] == null ? null : Photos.fromMap(json["photos"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "photos": photos?.toMap(),
        "status": status,
        "message": message,
      };
}

class Datum {
  dynamic id;
  dynamic producrId;
  dynamic commodityId;
  dynamic parameterId;
  dynamic min;
  dynamic max;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  Parameters? parameters;

  Datum({
    this.id,
    this.producrId,
    this.commodityId,
    this.parameterId,
    this.min,
    this.max,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.parameters,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        producrId: json["producr_id"],
        commodityId: json["commodity_id"],
        parameterId: json["parameter_id"],
        min: json["min"],
        max: json["max"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        parameters: json["parameters"] == null
            ? null
            : Parameters.fromMap(json["parameters"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "producr_id": producrId,
        "commodity_id": commodityId,
        "parameter_id": parameterId,
        "min": min,
        "max": max,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "parameters": parameters?.toMap(),
      };
}

class Parameters {
  dynamic id;
  dynamic parameter;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Parameters({
    this.id,
    this.parameter,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Parameters.fromMap(Map<String, dynamic> json) => Parameters(
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

class Photos {
  dynamic image;
  dynamic videos;
  dynamic url;

  Photos({
    this.image,
    this.videos,
    this.url,
  });

  factory Photos.fromMap(Map<String, dynamic> json) => Photos(
        image: json["image"],
        videos: json["videos"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "image": image,
        "videos": videos,
        "url": url,
      };
}
