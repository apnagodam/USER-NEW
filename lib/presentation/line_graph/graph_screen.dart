//9414082755
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/line_graph/graph_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class GraphScreen extends ConsumerWidget {
  final String id;
  final String wichtag;

  const GraphScreen({super.key, required this.id, required this.wichtag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GetBuilder<GraphController>(
        init: GraphController(), // Pass id to GraphController
        builder: (c) {
          return Scaffold(
            appBar: ref.watch(getGraphDataProvider(id: id)).when(
                data: (data) => AppBar(
                      backgroundColor: ColorConstant.maingreen,
                      title: data.data == null
                          ? SizedBox.shrink()
                          : Text('${data.data?.catName}'),
                      titleTextStyle: AppStyle.lblAppbar,
                    ),
                error: (e, s) => AppBar(
                      backgroundColor: ColorConstant.maingreen,
                    ),
                loading: () => AppBar(
                      backgroundColor: ColorConstant.maingreen,
                    )),
            backgroundColor: ColorConstant.bgcolor,
            body: ref.watch(getGraphDataProvider(id: id)).when(
                data: (data) {
                  var maxValue = 0;
                  for (int i = 0;
                      i <= (data.data?.lastYearPrice?.length ?? 1) - 1;
                      ++i) {
                    if (i > 0) {
                      if ((data.data?.lastYearPrice?[i].price ?? 0) >
                          (data.data?.lastYearPrice?[i - 1].price ?? 0)) {
                        maxValue =
                            (data.data?.lastYearPrice?[i].price ?? 0) + 1000;
                      }

                      if ((data.data?.price?[i].price ?? 0) >
                          (data.data?.price?[i - 1].price ?? 0)) {
                        maxValue = (data.data?.price?[i].price ?? 0) + 1000;
                      }
                    }
                  }

                  for (int i = 0;
                      i <= (data.data?.price?.length ?? 1) - 1;
                      ++i) {
                    if (i > 0) {
                      if ((data.data?.price?[i].price ?? 0) >
                          (data.data?.price?[i - 1].price ?? 0)) {
                        maxValue = (data.data?.price?[i].price ?? 0) + 1000;
                      }
                    }
                  }
                  return (data.data?.lastYearPrice ?? []).isEmpty
                      ? noStockData(context)
                      : Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 50.0, right: 10.0, left: 2.0),
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: LineChart(
                                LineChartData(
                                  lineTouchData: LineTouchData(
                                    touchTooltipData: LineTouchTooltipData(
                                      tooltipRoundedRadius: 20,
                                      fitInsideHorizontally: true,
                                      fitInsideVertically: true,
                                      getTooltipItems:
                                          (List<LineBarSpot> touchedSpots) {
                                        return touchedSpots
                                            .map((LineBarSpot touchedSpot) {
                                          return LineTooltipItem(
                                            '${touchedSpot.y}',
                                            const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          );
                                        }).toList();
                                      },
                                    ),
                                    handleBuiltInTouches: true,
                                  ),
                                  backgroundColor: Color(0xff09122f),
                                  borderData: FlBorderData(
                                      show: true,
                                      border: Border.all(
                                          color: ColorConstant.maingreen)),
                                  minX: 0,
                                  minY: 0,
                                  maxY: maxValue.toDouble(),
                                  lineBarsData: data.data?.userTodayPrice !=
                                              null ||
                                          (data.data?.userTodayPrice as List)
                                              .isNotEmpty
                                      ? [
                                          c.lastYearPrice(
                                              data.data?.lastYearPrice ?? [],
                                              Colors.yellow),
                                          c.currentYearPrices(
                                              data.data?.lastEmandiPrice ?? [],
                                              Colors.red),
                                          c.userTodayPrice(
                                              c.graphDataModel?.data
                                                  ?.userTodayPrice!.last,
                                              Color(0xff00ff01),
                                              wichtag),
                                        ]
                                      : [
                                          c.lastYearPrice(
                                              data.data?.lastYearPrice ?? [],
                                              Colors.yellow),
                                          c.currentYearPrices(
                                              data.data?.lastEmandiPrice ?? [],
                                              Colors.red),
                                        ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 16,
                                        color: Colors.yellow,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .lastYearPrice,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 16,
                                        color: Colors.red,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .currentYearPrice,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  wichtag == "mystock"
                                      ? Row(
                                          children: [
                                            Container(
                                              height: 16,
                                              width: 16,
                                              color: Color(0xff00ff01),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .myPrice,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            )
                          ],
                        );
                },
                error: (e, s) => Container(),
                loading: () => defaultLoader()),
          );
        });
  }
}
