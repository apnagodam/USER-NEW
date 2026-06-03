// To parse this JSON data, do
//
//     final gstListingModel = gstListingModelFromJson(jsonString);

import 'dart:convert';

GstListingModel gstListingModelFromJson(String str) =>
    GstListingModel.fromJson(json.decode(str));

String gstListingModelToJson(GstListingModel data) =>
    json.encode(data.toJson());

class GstListingModel {
  dynamic status;
  dynamic message;
  List<Datum>? data;

  GstListingModel({
    this.status,
    this.message,
    this.data,
  });

  factory GstListingModel.fromJson(Map<String, dynamic> json) =>
      GstListingModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic id;
  dynamic stateName;
  dynamic gstNumber;
  dynamic imageUrl;
  dynamic image;

  Datum({
    this.id,
    this.stateName,
    this.gstNumber,
    this.imageUrl,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        stateName: json["state_name"],
        gstNumber: json["gst_number"],
        imageUrl: json["image_url"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_name": stateName,
        "gst_number": gstNumber,
        "image_url": imageUrl,
        "image": image,
      };
}
