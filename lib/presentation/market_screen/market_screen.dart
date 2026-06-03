import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/presentation/market_screen/SBT/Sbtscreen.dart';
import 'package:apnagodam/presentation/market_screen/WBT/WbtScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

var sbtCurrencyFormat =
    NumberFormat.currency(locale: 'HI', symbol: '\u{20B9}', decimalDigits: 0);
var selectedTabIndex = StateProvider((ref) => 1);

class Market extends ConsumerStatefulWidget {
  const Market({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MarketState();
}

class _MarketState extends ConsumerState<Market> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var terminalId = "";
  var buyKey = GlobalKey<FormState>();
  var sellKey = GlobalKey<FormState>();

  var indexOfTradingScreens = StateProvider((ref) => 0);

  var chartDataList = StateProvider<List<ChartData>?>((ref) => []);

  var buyPrice = StateProvider<double>((ref) => 0.0);
  var buyWeight = StateProvider<double>((ref) => 0.0);

  var updatePriceProvider = StateProvider<double>((ref) => 0.0);
  var updateWeightProvider = StateProvider<double>((ref) => 0.0);

  var sellPrice = StateProvider<double>((ref) => 0.0);
  var sellWeight = StateProvider<double>((ref) => 0.0);
  var selectedIndex = StateProvider<int?>((ref) => null);

  var tabIndexProvider = StateProvider<int>((ref) => 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.maingreen,
        title: Text(
          AppLocalizations.of(context)!.msgMarket,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 1,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(7),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      )),
                  child: TabBar(
                      onTap: (index) {
                        ref.watch(selectedTabIndex.notifier).state = index;
                      },
                      labelColor: Colors.white,
                      labelStyle: TextStyle(
                          fontSize: Adaptive.sp(16),
                          fontWeight: FontWeight.w500),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstant.maingreen,
                      ),
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context)!.wbt,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.sbt,
                        ),
                        // Tab(
                        //   text: AppLocalizations.of(context)!.vdc2,
                        // ),
                      ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                    children: [_wbtLayout(), _sbtLayout()]), //_vdcLayout()
              )
            ],
          ),
        ),
      ),
    );
  }

  _sbtLayout() => Sbtscreen();

  _wbtLayout() => Wbtscreen();
}

class ChartData {
  ChartData(this.x, this.high, this.low);

  final DateTime x;
  final double high;
  final double low;
}

class LineChartSample5 extends StatefulWidget {
  const LineChartSample5({
    super.key,
    Color? gradientColor1,
    Color? gradientColor2,
    Color? gradientColor3,
    Color? indicatorStrokeColor,
  })  : gradientColor1 = gradientColor1 ?? Colors.blue,
        gradientColor2 = gradientColor2 ?? Colors.pink,
        gradientColor3 = gradientColor3 ?? Colors.red,
        indicatorStrokeColor = indicatorStrokeColor ?? Colors.blue;

  final Color gradientColor1;
  final Color gradientColor2;
  final Color gradientColor3;
  final Color indicatorStrokeColor;

  @override
  State<LineChartSample5> createState() => _LineChartSample5State();
}

class _LineChartSample5State extends State<LineChartSample5> {
  List<int> showingTooltipOnSpots = [1, 3, 5];

  List<FlSpot> get allSpots => [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 1.5),
        FlSpot(3, 3),
        FlSpot(4, 3.5),
        FlSpot(5, 5),
        FlSpot(6, 8),
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.pink,
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '00:00';
        break;
      case 1:
        text = '04:00';
        break;
      case 2:
        text = '08:00';
        break;
      case 3:
        text = '12:00';
        break;
      case 4:
        text = '16:00';
        break;
      case 5:
        text = '20:00';
        break;
      case 6:
        text = '23:59';
        break;
      default:
        return Container();
    }

    return Text(text, style: style);
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 4,
        shadow: Shadow(
          blurRadius: 8,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              widget.gradientColor1.withOpacity(0.4),
              widget.gradientColor2.withOpacity(0.4),
              widget.gradientColor3.withOpacity(0.4),
            ],
          ),
        ),
        dotData: FlDotData(show: false),
        gradient: LinearGradient(
          colors: [
            widget.gradientColor1,
            widget.gradientColor2,
            widget.gradientColor3,
          ],
          stops: [0.1, 0.4, 0.9],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ]);
              }).toList(),
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return;
                  }
                  if (event is FlTapUpEvent) {
                    final spotIndex = response.lineBarSpots!.first.spotIndex;
                    setState(() {
                      if (showingTooltipOnSpots.contains(spotIndex)) {
                        showingTooltipOnSpots.remove(spotIndex);
                      } else {
                        showingTooltipOnSpots.add(spotIndex);
                      }
                    });
                  }
                },
                mouseCursorResolver:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return SystemMouseCursors.basic;
                  }
                  return SystemMouseCursors.click;
                },
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      FlLine(
                        color: Colors.pink,
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                          radius: 8,
                          color: lerpGradient(
                            barData.gradient!.colors,
                            barData.gradient!.stops!,
                            percent / 100,
                          ),
                          strokeWidth: 2,
                          strokeColor: widget.indicatorStrokeColor,
                        ),
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  tooltipRoundedRadius: 8,
                  getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                    return lineBarsSpot.map((lineBarSpot) {
                      return LineTooltipItem(
                        lineBarSpot.y.toString(),
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: lineBarsData,
              minY: 0,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  axisNameWidget: Text(AppLocalizations.of(context)!.count),
                  axisNameSize: 24,
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return bottomTitleWidgets(
                        value,
                        meta,
                        constraints.maxWidth,
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                rightTitles: AxisTitles(
                  axisNameWidget: Text(AppLocalizations.of(context)!.count),
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                topTitles: AxisTitles(
                  axisNameWidget: Text(
                    'Wall clock',
                    textAlign: TextAlign.left,
                  ),
                  axisNameSize: 24,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 0,
                  ),
                ),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: ColorConstant.maingreen,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
