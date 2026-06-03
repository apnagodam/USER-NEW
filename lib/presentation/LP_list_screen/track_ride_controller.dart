import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/line_graph/graph_model.dart';
import 'package:apnagodam/presentation/splash_screen/splash_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/progress_dialog_utils.dart';
import '../../../data/apiClient/apiClient.dart';
import 'model/All_bookings_model.dart';

class Trackcontroller extends GetxController {
  final String bookingId;
  var viewbook;
  bool loading = true;
  Order? trackdata;
  Trackcontroller(this.bookingId);

  // Your controller logic goes he

  @override
  void onInit() {
    apnauserViewBooking(bookingId);
    super.onInit();
  }

  Future apnauserViewBooking(var bookingId) async {
    loading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    update();
    await ApiClient.apnauserViewBookingService(bookingId).then((value) {
      update();
      loading = false;
      if (value != null) {
        if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
          Get.offAll(() => SplashScreen());
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        } else {
          trackdata = Order.fromMap(value['order']);

          /* update();
          refresh();*/
        }
      }
    });
  }

  LineChartBarData lastYearPrice(List<MonthPriceData> data, Color color) {
    data.sort((a, b) => a.month.compareTo(b.month));
    return LineChartBarData(
      spots: List.generate(
          data.length,
          (index) =>
              FlSpot(double.parse(data[index].month), data[index].price)),
      isCurved: false,
      color: color,
      barWidth: 1,
      dashArray: [2, 2],
      // Set the dash pattern (5 points solid, 5 points empty)

      isStrokeCapRound: false,
      belowBarData: BarAreaData(show: false),
    );
  }

  LineChartBarData currentYearPrices(List<MonthPriceData> data, Color color) {
    data.sort((a, b) => a.month.compareTo(b.month));

    return LineChartBarData(
      spots: List.generate(
          data.length,
          (index) => FlSpot(
              double.parse(data[index].month), data[index].price.toDouble())),
      isCurved: false,
      color: color,
      barWidth: 1,
      dashArray: [2, 2],
      // Set the dash pattern (5 points solid, 5 points empty)
      isStrokeCapRound: false,
      belowBarData: BarAreaData(
        show: true,
        cutOffY: 0,
        applyCutOffY: true,
        color: Colors.transparent,
      ),
    );
  }

  LineChartBarData userTodayPrice(
      UserTodayPrice data, Color color, String tag) {
    return LineChartBarData(
      spots: [FlSpot(double.parse(data.month), double.parse(data.todayPrice))],
      isCurved: false,
      show: tag == "mystock" ? true : false,
      color: color,
      barWidth: 1,
      dashArray: [2, 2],
      // Set the dash pattern (5 points solid, 5 points empty)

      isStrokeCapRound: false,
      belowBarData: BarAreaData(show: false),
    );
  }

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value == meta.max || value == meta.min) {
                return Container();
              }
              int monthValue = value.toInt();
              String monthName = getMonthName(monthValue);

              return Text(monthName, style: AppStyle.lbldateandtime);
            },
            reservedSize: 32,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 500,
            getTitlesWidget: (value, meta) {
              if (value == meta.max || value == meta.min) {
                return Container();
              }
              return Text(value.toStringAsFixed(0),
                  style: AppStyle.lbldateandtime);
            },
            reservedSize: 32,
          ),
        ),
      );

  String getMonthName(int monthValue) {
    switch (monthValue) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 10:
        return 'OCT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
      default:
        return '';
    }
  }
}
