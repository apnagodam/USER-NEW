import 'dart:math' as math;

import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen/models/graph_model.dart';

class GraphController extends GetxController {
  GraphModel? graphDataModel;

  double maxPrice = 15000;
  double minPrice = 0;
  bool loading = true;

  // Your controller logic goes he

  double roundToNearest(double value, int interval) {
    return (value / interval).roundToDouble() * interval;
  }

  LineChartBarData lastYearPrice(List<LastPrice> data, Color color) {
    data.sort((a, b) => (a.month ?? "").compareTo((b.month ?? "")));
    return LineChartBarData(
      spots: List.generate(
          data.length,
          (index) => FlSpot(double.parse(data[index].month ?? "0.00"),
              data[index].price.toString().convertToDouble())),
      isCurved: true,
      color: color,

      barWidth: 1,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 5,
            color: Color.lerp(
              Colors.yellow,
              Colors.yellow,
              percent / 100,
            )!,
            strokeColor: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      // Set the dash pattern (5 points solid, 5 points empty)

      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
    );
  }

  LineChartBarData currentYearPrices(List<LastPrice> data, Color color) {
    data.sort((a, b) => (a.month ?? "").compareTo((b.month ?? "")));

    return LineChartBarData(
      spots: List.generate(
          data.length,
          (index) => FlSpot(double.parse(data[index].month ?? "0.0"),
              (data[index].price ?? "0.0").toString().convertToDouble())),
      isCurved: true,
      color: color,
      barWidth: 1,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 5,
            color: Color.lerp(
              Colors.red,
              Colors.red,
              percent / 100,
            )!,
            strokeColor: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      // Set the dash pattern (5 points solid, 5 points empty)
      isStrokeCapRound: true,
      belowBarData: BarAreaData(
        show: true,
        cutOffY: 0,
        applyCutOffY: true,
        color: Colors.transparent,
      ),
    );
  }

  LineChartBarData userTodayPrice(
      UserTodayPrice? data, Color color, String tag) {
    return LineChartBarData(
      spots: [
        FlSpot(double.parse(data?.month ?? '0.0'),
            double.parse(data?.todayPrice ?? "0.0"))
      ],
      isCurved: true,
      show: tag == "mystock" ? true : false,
      color: color,
      barWidth: 1,
      dashArray: [8, 8],
      // Set the dash pattern (5 points solid, 5 points empty)

      isStrokeCapRound: true,
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

              return Transform.rotate(
                angle: -math.pi / 4,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(monthName, style: AppStyle.lbldateandtime),
                ),
              );
            },
            reservedSize: 32,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
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
              return Padding(
                padding: EdgeInsets.only(left: 6.0),
                child: Text(value.toStringAsFixed(0),
                    style: AppStyle.lbldateandtime),
              );
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
