// To parse this JSON data, do
//
//     final qualityParamsModel = qualityParamsModelFromJson(jsondynamic);

import 'dart:convert';

QualityParamsModel qualityParamsModelFromJson(dynamic str) =>
    QualityParamsModel.fromJson(json.decode(str));

dynamic qualityParamsModelToJson(QualityParamsModel data) =>
    json.encode(data.toJson());

class QualityParamsModel {
  dynamic status;
  dynamic message;
  List<QualityParamDatum>? data;

  QualityParamsModel({
    this.status,
    this.message,
    this.data,
  });

  factory QualityParamsModel.fromJson(Map<dynamic, dynamic> json) =>
      QualityParamsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<QualityParamDatum>.from(
                json["data"]!.map((x) => QualityParamDatum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class QualityParamDatum {
  dynamic id;
  dynamic name;
  dynamic min;
  dynamic max;
  dynamic value;

  QualityParamDatum({this.id, this.name, this.min, this.max, this.value});

  factory QualityParamDatum.fromJson(Map<dynamic, dynamic> json) =>
      QualityParamDatum(
        id: json["id"],
        name: json["name"],
        min: json["min"],
        max: json["max"],
        value: json['value'],
      );

  Map<dynamic, dynamic> toJson() =>
      {"id": id, "name": name, "min": min, "max": max, "value": value};
}
