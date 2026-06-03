// To parse this JSON data, do
//
//     final graphModel = graphModelFromMap(jsonString);

import 'dart:convert';

GraphModel graphModelFromMap(String str) =>
    GraphModel.fromMap(json.decode(str));

String graphModelToMap(GraphModel data) => json.encode(data.toMap());

class GraphModel {
  int? status;
  String? message;
  Data? data;

  GraphModel({
    this.status,
    this.message,
    this.data,
  });

  factory GraphModel.fromMap(Map<String, dynamic> json) => GraphModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  String? catName;
  List<MonthDatum>? monthData;
  List<Price>? price;
  List<LastPrice>? lastEmandiPrice;
  List<LastPrice>? lastYearPrice;
  List<UserTodayPrice>? userTodayPrice;

  Data({
    this.catName,
    this.monthData,
    this.price,
    this.lastEmandiPrice,
    this.lastYearPrice,
    this.userTodayPrice,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        catName: json["cat_name"],
        monthData: json["month_data"] == null
            ? []
            : List<MonthDatum>.from(
                json["month_data"]!.map((x) => MonthDatum.fromMap(x))),
        price: json["price"] == null
            ? []
            : List<Price>.from(json["price"]!.map((x) => Price.fromMap(x))),
        lastEmandiPrice: json["last_emandi_price"] == null
            ? []
            : List<LastPrice>.from(
                json["last_emandi_price"]!.map((x) => LastPrice.fromMap(x))),
        lastYearPrice: json["last_year_price"] == null
            ? []
            : List<LastPrice>.from(
                json["last_year_price"]!.map((x) => LastPrice.fromMap(x))),
        userTodayPrice: json["user_today_price"] == null
            ? null
            : List<UserTodayPrice>.from(
                json["last_year_price"]!.map((x) => UserTodayPrice.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "cat_name": catName,
        "month_data": monthData == null
            ? []
            : List<dynamic>.from(monthData!.map((x) => x.toMap())),
        "price": price == null
            ? []
            : List<dynamic>.from(price!.map((x) => x.toMap())),
        "last_emandi_price": lastEmandiPrice == null
            ? []
            : List<dynamic>.from(lastEmandiPrice!.map((x) => x.toMap())),
        "last_year_price": lastYearPrice == null
            ? []
            : List<dynamic>.from(lastYearPrice!.map((x) => x.toMap())),
        "user_today_price":
            List<UserTodayPrice>.from(userTodayPrice!.map((x) => x.toMap())),
      };
}

class LastPrice {
  int? price;
  String? month;

  LastPrice({
    this.price,
    this.month,
  });

  factory LastPrice.fromMap(Map<String, dynamic> json) => LastPrice(
        price: json["price"],
        month: json["month"],
      );

  Map<String, dynamic> toMap() => {
        "price": price,
        "month": month,
      };
}

class MonthDatum {
  String? month;
  String? dMonth;

  MonthDatum({
    this.month,
    this.dMonth,
  });

  factory MonthDatum.fromMap(Map<String, dynamic> json) => MonthDatum(
        month: json["month"],
        dMonth: json["d_month"],
      );

  Map<String, dynamic> toMap() => {
        "month": month,
        "d_month": dMonth,
      };
}

class Price {
  int? price;

  Price({
    this.price,
  });

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "price": price,
      };
}

class UserTodayPrice {
  String? todayPrice;
  String? month;

  UserTodayPrice({
    this.todayPrice,
    this.month,
  });

  factory UserTodayPrice.fromMap(Map<String, dynamic> json) => UserTodayPrice(
        todayPrice: json["today_price"],
        month: json["month"],
      );

  Map<String, dynamic> toMap() => {
        "today_price": todayPrice,
        "month": month,
      };
}
