class GraphDataModel {
  final int status;
  final String message;
  final GraphData? data;

  GraphDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GraphDataModel.fromJson(Map<String, dynamic> json) {
    return GraphDataModel(
      status: json['status'],
      message: json['message'],
      data: GraphData.fromJson(json['data']),
    );
  }
}

class GraphData {
  final String? catName;
  final List<MonthData>? monthData;
  final List<PriceData>? price;
  final List<MonthPriceData>? lastEmandiPrice;
  final List<MonthPriceData>? lastYearPrice;
  final UserTodayPrice? userTodayPrice;

  GraphData({
    required this.catName,
    required this.monthData,
    required this.price,
    required this.lastEmandiPrice,
    required this.lastYearPrice,
    required this.userTodayPrice,
  });

  factory GraphData.fromJson(Map<String, dynamic> json) {
    return GraphData(
        catName: json['cat_name'],
        monthData: List<MonthData>.from(
          json['month_data'].map((data) => MonthData.fromJson(data)),
        ),
        price: List<PriceData>.from(
          json['price'].map((data) => PriceData.fromJson(data)),
        ),
        lastEmandiPrice: List<MonthPriceData>.from(
          json['last_emandi_price']
              .map((data) => MonthPriceData.fromJson(data)),
        ),
        lastYearPrice: List<MonthPriceData>.from(
              json['last_year_price']
                  .map((data) => MonthPriceData.fromJson(data)),
            ) ??
            [],
        userTodayPrice: UserTodayPrice.fromJson(json['user_today_price']));
  }
}

class MonthData {
  final String month;
  final String dMonth;

  MonthData({
    required this.month,
    required this.dMonth,
  });

  factory MonthData.fromJson(Map<String, dynamic> json) {
    return MonthData(
      month: json['month'],
      dMonth: json['d_month'],
    );
  }
}

class PriceData {
  final double price;

  PriceData({
    required this.price,
  });

  factory PriceData.fromJson(Map<String, dynamic> json) {
    return PriceData(
      price: json['price'].toDouble(),
    );
  }
}

class MonthPriceData {
  final String month;
  final double price;

  MonthPriceData({
    required this.month,
    required this.price,
  });

  factory MonthPriceData.fromJson(Map<String, dynamic> json) {
    return MonthPriceData(
      month: json['month'],
      price: json['price'].toDouble(),
    );
  }
}

class UserTodayPrice {
  final String todayPrice;
  final String month;

  UserTodayPrice({
    required this.todayPrice,
    required this.month,
  });

  factory UserTodayPrice.fromJson(Map<String, dynamic> json) {
    return UserTodayPrice(
      todayPrice: json['today_price'],
      month: json['month'],
    );
  }
}
