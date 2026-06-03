// To parse this JSON data, do
//
//     final tripRequestsModel = tripRequestsModelFromMap(jsonString);

import 'dart:convert';

TripRequestsModel tripRequestsModelFromMap(String str) => TripRequestsModel.fromMap(json.decode(str));

String tripRequestsModelToMap(TripRequestsModel data) => json.encode(data.toMap());

class TripRequestsModel {
  List<Datum>? data;
  String? status;
  String? message;

  TripRequestsModel({
    this.data,
    this.status,
    this.message,
  });

  factory TripRequestsModel.fromMap(Map<String, dynamic> json) => TripRequestsModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "status": status,
    "message": message,
  };
}

class Datum {
  int? id;
  String? requestDate;
  String? tripDate;
  String? tripId;
  String? transporterName;
  String? transporterPhone;
  String? fromAddress;
  String? toAddress;
  int? rate;
  String? commodity;
  String? weight;
  int? noOfBags;
  String? recevingWeight;
  int? recevingBags;
  String? biltyImage;
  String? kantaImage;
  String? goodsInvoiceImage;
  String? recevingKantaImage;
  dynamic frightInvoiceImage;
  String? inOutTypes;
  int? status;
  String? tripStart;
  String? tripEnd;
  String? driverName;
  String? driverPhone;
  String? truckNumber;
  String? kantaImageUrl;
  dynamic poId;

  Datum({
    this.id,
    this.requestDate,
    this.tripDate,
    this.tripId,
    this.transporterName,
    this.transporterPhone,
    this.fromAddress,
    this.toAddress,
    this.rate,
    this.commodity,
    this.weight,
    this.noOfBags,
    this.recevingWeight,
    this.recevingBags,
    this.biltyImage,
    this.kantaImage,
    this.goodsInvoiceImage,
    this.recevingKantaImage,
    this.frightInvoiceImage,
    this.inOutTypes,
    this.status,
    this.tripStart,
    this.tripEnd,
    this.driverName,
    this.driverPhone,
    this.truckNumber,
    this.kantaImageUrl,
    this.poId,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    requestDate: json["request_date"],
    tripDate: json["trip_date"],
    tripId: json["trip_id"],
    transporterName: json["transporter_name"],
    transporterPhone: json["transporter_phone"],
    fromAddress: json["from_address"],
    toAddress: json["to_address"],
    rate: json["rate"],
    commodity: json["commodity"],
    weight: json["weight"],
    noOfBags: json["no_of_bags"],
    recevingWeight: json["receving_weight"],
    recevingBags: json["receving_bags"],
    biltyImage: json["bilty_image"],
    kantaImage: json["kanta_image"],
    goodsInvoiceImage: json["goods_invoice_image"],
    recevingKantaImage: json["receving_kanta_image"],
    frightInvoiceImage: json["fright_invoice_image"],
    inOutTypes: json["in_out_types"],
    status: json["status"],
    tripStart: json["trip_start"],
    tripEnd: json["trip_end"],
    driverName: json["driver_name"],
    driverPhone: json["driver_phone"],
    truckNumber: json["truck_number"],
    kantaImageUrl: json["kanta_image_url"],
    poId: json["po_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "request_date": requestDate,
    "trip_date": tripDate,
    "trip_id": tripId,
    "transporter_name": transporterName,
    "transporter_phone": transporterPhone,
    "from_address": fromAddress,
    "to_address": toAddress,
    "rate": rate,
    "commodity": commodity,
    "weight": weight,
    "no_of_bags": noOfBags,
    "receving_weight": recevingWeight,
    "receving_bags": recevingBags,
    "bilty_image": biltyImage,
    "kanta_image": kantaImage,
    "goods_invoice_image": goodsInvoiceImage,
    "receving_kanta_image": recevingKantaImage,
    "fright_invoice_image": frightInvoiceImage,
    "in_out_types": inOutTypes,
    "status": status,
    "trip_start": tripStart,
    "trip_end": tripEnd,
    "driver_name": driverName,
    "driver_phone": driverPhone,
    "truck_number": truckNumber,
    "kanta_image_url": kantaImageUrl,
    "po_id": poId,
  };
}
