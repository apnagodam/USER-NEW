// To parse this JSON data, do
//
//     final bookingQualityModel = bookingQualityModelFromJson(jsonString);

import 'dart:convert';

BookingQualityModel bookingQualityModelFromJson(String str) =>
    BookingQualityModel.fromJson(json.decode(str));

String bookingQualityModelToJson(BookingQualityModel data) =>
    json.encode(data.toJson());

class BookingQualityModel {
  dynamic status;
  dynamic message;
  dynamic liveInsects;
  dynamic qvAmount;
  List<BookingDatum>? data;

  BookingQualityModel({
    this.status,
    this.message,
    this.liveInsects,
    this.qvAmount,
    this.data,
  });

  factory BookingQualityModel.fromJson(Map<String, dynamic> json) =>
      BookingQualityModel(
        status: json["status"],
        message: json["message"],
        liveInsects: json['live_insects'],
        qvAmount: json['qv_amount'],
        data: json["data"] == null
            ? []
            : List<BookingDatum>.from(
                json["data"]!.map((x) => BookingDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "live_insects": liveInsects,
        "qv_amount": qvAmount,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BookingDatum {
  dynamic id;
  dynamic userId;
  dynamic caseId;
  dynamic parameterId;
  dynamic value;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic parameter;

  BookingDatum({
    this.id,
    this.userId,
    this.caseId,
    this.parameterId,
    this.value,
    this.createdAt,
    this.updatedAt,
    this.parameter,
  });

  factory BookingDatum.fromJson(Map<String, dynamic> json) => BookingDatum(
        id: json["id"],
        userId: json["user_id"],
        caseId: json["case_id"],
        parameterId: json["parameter_id"],
        value: json["value"]?.toDouble(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        parameter: json["parameter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "case_id": caseId,
        "parameter_id": parameterId,
        "value": value,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "parameter": parameter,
      };
}
