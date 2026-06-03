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
        userId: json["user_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
    };
}
