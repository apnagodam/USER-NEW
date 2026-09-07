import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/helper.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/presentation/credit/credit_screen.dart';
import 'package:apnagodam/presentation/dashboard/model/sbt_commodity_model.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/market_screen/buyer_list_screen.dart';
import 'package:apnagodam/presentation/market_screen/market_screen.dart';
import 'package:apnagodam/presentation/market_screen/seller_list_screen.dart';
import 'package:apnagodam/presentation/market_screen/service/market_service.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/SharedPrefs/SharedUtility.dart';
import '../BusinessProfile/BusinessProfile.dart';
import '../GstProfile/GstProfileScreen.dart';

class BuySellData extends ConsumerStatefulWidget {
  const BuySellData({super.key, this.data, this.index});

  final SbtDatum? data;
  final int? index;

  @override
  ConsumerState<BuySellData> createState() => _BuySellDataState();
}

class _BuySellDataState extends ConsumerState<BuySellData> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.data?.commodity} - ${widget.data?.district}"),
      ),
      body: ref
          .watch(
            getBuyerSellerListProvider(cityState: "${widget.data?.productId}"),
          )
          .when(
            data: (value) {
              setState(() {});
              return ListView(
                children: [
                  Padding(
                    padding: Pad(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green.shade600,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.buyer,
                              style: TextStyle(
                                fontSize: Adaptive.sp(14),
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.red.shade600,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.seller,
                              style: TextStyle(
                                fontSize: Adaptive.sp(14),
                                fontWeight: FontWeight.w600,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: Pad(all: 10),
                    child: SizedBox(
                      height: Get.height / 2,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              tooltipRoundedRadius: 8,
                              fitInsideHorizontally: true,
                              fitInsideVertically: true,
                              getTooltipItems: (
                                List<LineBarSpot> touchedSpots,
                              ) {
                                return touchedSpots.map((
                                  LineBarSpot touchedSpot,
                                ) {
                                  final isBuyer = touchedSpot.barIndex == 0;
                                  return LineTooltipItem(
                                    '${isBuyer ? AppLocalizations.of(context)!.buyer : AppLocalizations.of(context)!.seller}: ${touchedSpot.y.toStringAsFixed(2)}',
                                    TextStyle(
                                      color:
                                          isBuyer ? Colors.green : Colors.red,
                                      fontSize: Adaptive.sp(14),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                            handleBuiltInTouches: true,
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            horizontalInterval: 10,
                            verticalInterval: 1,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                strokeWidth: 0.5,
                                color: Colors.grey.withAlpha(77),
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                strokeWidth: 0.5,
                                color: Colors.grey.withAlpha(77),
                              );
                            },
                          ),
                          minX: 0,
                          maxX:
                              ((value.buyerData?.length ?? 0) >
                                      (value.sellerData?.length ?? 0)
                                  ? value.buyerData?.length ?? 0
                                  : value.sellerData?.length ?? 0) -
                              1.0,
                          minY: _getMinRate(value),
                          maxY: _getMaxRate(value),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Colors.grey.withAlpha(128),
                              width: 1,
                            ),
                          ),
                          lineBarsData: [
                            // Buyer data
                            LineChartBarData(
                              spots: List.generate(
                                value.buyerData?.length ?? 0,
                                (index) => FlSpot(
                                  index.toDouble(),
                                  value.buyerData?[index].rate
                                          .toString()
                                          .convertToDouble(defaultValue: 0.0) ??
                                      0.0,
                                ),
                              ),
                              isCurved: true,
                              curveSmoothness: 0.35,
                              color: Colors.green.shade600,
                              barWidth: 4,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green.shade200.withAlpha(102),
                                    Colors.green.shade100.withAlpha(26),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 6,
                                    color: Colors.green.shade600,
                                    strokeColor: Colors.white,
                                    strokeWidth: 2,
                                  );
                                },
                              ),
                              shadow: Shadow(
                                color: Colors.green.withAlpha(77),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ),
                            // Seller data
                            LineChartBarData(
                              spots: List.generate(
                                value.sellerData?.length ?? 0,
                                (index) => FlSpot(
                                  index.toDouble(),
                                  value.sellerData?[index].rate
                                          .toString()
                                          .convertToDouble(defaultValue: 0.0) ??
                                      0.0,
                                ),
                              ),
                              isCurved: true,
                              curveSmoothness: 0.35,
                              color: Colors.red.shade600,
                              barWidth: 4,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.red.shade200.withAlpha(102),
                                    Colors.red.shade100.withAlpha(26),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 6,
                                    color: Colors.red.shade600,
                                    strokeColor: Colors.white,
                                    strokeWidth: 2,
                                  );
                                },
                              ),
                              shadow: Shadow(
                                color: Colors.red.withAlpha(77),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ),
                          ],
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 50,
                                getTitlesWidget:
                                    (value, meta) => Text(
                                      value.toStringAsFixed(0),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget:
                                    (value, meta) => Text(
                                      (value + 1).toInt().toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding:  EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "${widget.data?.data?[widget.index ?? 0].commodity}",
                  //         style: TextStyle(
                  //             fontSize: Adaptive.sp(17),
                  //
                  //             fontWeight: FontWeight.w700),
                  //       ),
                  //        SizedBox(
                  //         width: 5,
                  //       ),
                  //       Text(
                  //           "- ${widget.data?.data?[widget.index ?? 0].district.toString()}",
                  //           style: TextStyle(
                  //               fontSize: Adaptive.sp(16),
                  //
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.w500)),
                  //     ],
                  //   ),
                  // ),
                  //
                  //  Divider(
                  //   thickness: 1,
                  // ),
                  //  SizedBox(
                  //   height: 15,
                  // ),
                  Center(
                    child: Text(
                      "Bids",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Adaptive.sp(17),
                      ),
                    ),
                  ),
                  ref
                      .watch(getSbtCommodityProvider)
                      .when(
                        data:
                            (data) => Padding(
                              padding: Pad(all: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorConstant.maingreen,
                                      ),
                                    ),
                                    child: BuyerList(
                                      data: data.data![widget.index ?? 0],
                                      index: widget.index,
                                    ),
                                  ),
                                  ElevarmDivider(),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorConstant.red500,
                                      ),
                                    ),
                                    padding: Pad(all: 10),
                                    child: SellerList(
                                      data: data.data![widget.index ?? 0],
                                      index: widget.index,
                                    ),
                                  ),
                                  ElevarmDivider(),
                                ],
                              ),
                            ),
                        error: (e, s) => Container(),
                        loading: () => CircularProgressIndicator(),
                      ),

                  Center(
                    child: Text(
                      "Matching Orders",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Adaptive.sp(17),
                      ),
                    ),
                  ),
                  ref
                      .watch(
                        matchedOrdersProvider(
                          productId: "${widget.data?.productId}",
                        ),
                      )
                      .when(
                        data:
                            (data) =>
                                (data.tradeOrderData ?? []).isEmpty
                                    ? Center(child: Text('No Data Found'))
                                    : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data.tradeOrderData?.length,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        return InkWell(
                                          onTap: () async {
                                            // cont.refresh();
                                          },
                                          child: Card(
                                            elevation: 8,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: ColorConstant.maingreen
                                                    .withAlpha(77),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            margin: EdgeInsets.all(10),
                                            surfaceTintColor: Colors.white,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          TextOneLine(
                                                            "Order ID: ${data.tradeOrderData?[index].orderId}",
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: TextStyle(
                                                              color:
                                                                  ColorConstant
                                                                      .maingreen,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: TextOneLine(
                                                              "Date: ${data.tradeOrderData?[index].date}",
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                color:
                                                                    ColorConstant
                                                                        .maingreen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                      14,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${data.tradeOrderData?[index].commodity}",
                                                            style: TextStyle(
                                                              color:
                                                                  ColorConstant
                                                                      .maingreen,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    15,
                                                                  ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            "- ${data.tradeOrderData?[index].district.toString()}",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    15,
                                                                  ),
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${AppLocalizations.of(context)!.msgRate}:',
                                                                style: AppStyle
                                                                    .mystoke
                                                                    .copyWith(
                                                                      fontSize:
                                                                          Adaptive.sp(
                                                                            15,
                                                                          ),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                currencyFormat.format(
                                                                  double.parse(
                                                                    "${data.tradeOrderData?[index].rate ?? "0.0"}",
                                                                  ),
                                                                ),
                                                                style: AppStyle
                                                                    .mystoke
                                                                    .copyWith(
                                                                      fontSize:
                                                                          Adaptive.sp(
                                                                            15,
                                                                          ),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                '${AppLocalizations.of(context)!.quantityLabel}:',
                                                                style: AppStyle
                                                                    .mystoke
                                                                    .copyWith(
                                                                      fontSize:
                                                                          Adaptive.sp(
                                                                            15,
                                                                          ),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                '${data.tradeOrderData?[index].qty}(Qtl.)',
                                                                style: AppStyle
                                                                    .mystoke
                                                                    .copyWith(
                                                                      fontSize:
                                                                          Adaptive.sp(
                                                                            15,
                                                                          ),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                        error: (e, s) => noStockData(context),
                        loading: () => Container(),
                        skipLoadingOnRefresh: true,
                      ),

                  //truck data end____________
                ],
              );
            },
            error: (e, s) => Center(child: noStockData()),
            loading: () => Container(),
          ),
    );
  }

  double _getMinRate(dynamic value) {
    double minRate = double.infinity;
    for (var buyer in value.buyerData ?? []) {
      double rate =
          buyer.rate.toString().convertToDouble(defaultValue: 0.0) ?? 0.0;
      if (rate < minRate) minRate = rate;
    }
    for (var seller in value.sellerData ?? []) {
      double rate =
          seller.rate.toString().convertToDouble(defaultValue: 0.0) ?? 0.0;
      if (rate < minRate) minRate = rate;
    }
    return minRate == double.infinity
        ? 0.0
        : minRate - 10; // Subtract a bit for padding
  }

  double _getMaxRate(dynamic value) {
    double maxRate = double.negativeInfinity;
    for (var buyer in value.buyerData ?? []) {
      double rate =
          buyer.rate.toString().convertToDouble(defaultValue: 0.0) ?? 0.0;
      if (rate > maxRate) maxRate = rate;
    }
    for (var seller in value.sellerData ?? []) {
      double rate =
          seller.rate.toString().convertToDouble(defaultValue: 0.0) ?? 0.0;
      if (rate > maxRate) maxRate = rate;
    }
    return maxRate == double.negativeInfinity
        ? 100.0
        : maxRate + 10; // Add a bit for padding
  }
}

class BuyerListSBT extends ConsumerStatefulWidget {
  const BuyerListSBT({super.key, required this.data});

  final SbtDatum? data;

  @override
  ConsumerState<BuyerListSBT> createState() => _BuyerListSBTState();
}

class _BuyerListSBTState extends ConsumerState<BuyerListSBT> {
  var updatePriceProvider = StateProvider<double>((ref) => 0.0);
  var updateWeightProvider = StateProvider<double>((ref) => 0.0);

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(
          getBuyerSellerListProvider(cityState: "${widget.data?.productId}"),
        )
        .when(
          data:
              (value) => Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Container(
                    //   height: 30,
                    //   color: ColorConstant.maingreen,
                    //   child: Center(
                    //       child: Text(
                    //         AppLocalizations.of(context)!.msgBuyerbid,
                    //         style: TextStyle(
                    //
                    //             color: Colors.white,
                    //             fontSize: Adaptive.sp(16)),
                    //       )),
                    // ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.buyer,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorConstant.maingreen,
                          fontWeight: FontWeight.bold,
                          fontSize: Adaptive.sp(16),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.qtyQtl,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.rate,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16),
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.edit,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${value.buyerData?[index].qty}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                sbtCurrencyFormat.format(
                                  double.parse(
                                    value.buyerData?[index].rate ?? "0.0",
                                  ),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                            Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible:
                                  value.buyerData?[index].type.toString() ==
                                  "1",
                              child: Align(
                                alignment: Alignment.topRight,
                                child: RowSuper(
                                  children: [
                                    PopupMenuButton(
                                      itemBuilder:
                                          (context) => [
                                            PopupMenuItem(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .pencil_circle_fill,
                                                    color:
                                                        ColorConstant.maingreen,
                                                    size: Adaptive.sp(16),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: Adaptive.sp(16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                ref
                                                    .watch(
                                                      updatePriceProvider
                                                          .notifier,
                                                    )
                                                    .state = double.parse(
                                                  '${value.buyerData?[index].rate}',
                                                );
                                                ref
                                                    .watch(
                                                      updateWeightProvider
                                                          .notifier,
                                                    )
                                                    .state = double.parse(
                                                  '${value.buyerData?[index].qty}',
                                                );
                                                showBarModalBottomSheet(
                                                  context: context,
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                  ),
                                                  builder: (context) {
                                                    return Padding(
                                                      padding: Pad(
                                                        bottom:
                                                            MediaQuery.of(
                                                              context,
                                                            ).viewInsets.bottom,
                                                        top: 10,
                                                        left: 10,
                                                        right: 10,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  top: 12.0,
                                                                  bottom: 7.0,
                                                                ),
                                                            child: Center(
                                                              child: Text(
                                                                "Update Bid",
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                        18,
                                                                      ),
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  bottom: 8.0,
                                                                ),
                                                            child: Text.rich(
                                                              TextSpan(
                                                                text: "Product",
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                        16,
                                                                      ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        " : ${widget.data?.commodity} (${widget.data?.district})",
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          SizedBox(width: 10),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              // Text.rich(TextSpan(
                                                              //     text:
                                                              //         "Commodity: ",
                                                              //     style: TextStyle(fontSize: Adaptive.sp(16),  fontWeight: FontWeight.bold),
                                                              //     children: [
                                                              //       TextSpan(
                                                              //           text:
                                                              //               "${widget.data?.data?[widget.index ?? 0].commodity}")
                                                              //     ])),
                                                              Text.rich(
                                                                TextSpan(
                                                                  text:
                                                                      "Date: ",
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                          16,
                                                                        ),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "${widget.data?.date}",
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(),
                                                          Center(
                                                            child: Text(
                                                              'Rate',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors
                                                                        .black,
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                      17,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: Pad(
                                                              all: 10,
                                                            ),
                                                            child: SizedBox(
                                                              width: Get.width,
                                                              child: InputQty(
                                                                maxVal:
                                                                    widget
                                                                        .data
                                                                        ?.upperCircuit ??
                                                                    0,
                                                                initVal: (double.tryParse("${value.buyerData?[index].rate ?? "0"}")?.round() ?? 0),
                                                                minVal: 0,
                                                                steps: 10,
                                                                qtyFormProps: QtyFormProps(
                                                                  keyboardType:
                                                                      TextInputType.numberWithOptions(
                                                                        decimal:
                                                                            false,
                                                                      ),
                                                                ),
                                                                onQtyChanged: (
                                                                  val,
                                                                ) {
                                                                  ref
                                                                      .watch(
                                                                        updatePriceProvider
                                                                            .notifier,
                                                                      )
                                                                      .state = double.parse(
                                                                    '${val ?? 0.0}',
                                                                  );
                                                                  print(val);
                                                                },
                                                                decoration: QtyDecorationProps(
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          5,
                                                                        ),
                                                                    borderSide:
                                                                        BorderSide(
                                                                          color:
                                                                              ColorConstant.maingreen,
                                                                        ),
                                                                  ),
                                                                  qtyStyle:
                                                                      QtyStyle
                                                                          .classic,
                                                                  minusBtn: Container(
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          ColorConstant
                                                                              .maingreen,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            5,
                                                                          ),
                                                                    ),
                                                                    padding: Pad(
                                                                      all: 10,
                                                                    ),
                                                                    child: Text(
                                                                      '-10',
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color:
                                                                            Colors.white,
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                              17,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  plusBtn: Container(
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          ColorConstant
                                                                              .maingreen,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            5,
                                                                          ),
                                                                    ),
                                                                    padding: Pad(
                                                                      all: 10,
                                                                    ),
                                                                    child: Text(
                                                                      '+10',
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color:
                                                                            Colors.white,
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                              17,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Divider(),
                                                          SizedBox(height: 10),
                                                          Center(
                                                            child: Text(
                                                              'Quantity',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors
                                                                        .black,
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                      17,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: Pad(
                                                              all: 10,
                                                            ),
                                                            child: SizedBox(
                                                              width: Get.width,
                                                              child: InputQty(
                                                                maxVal: (double.tryParse("${widget.data?.quantityLimit ?? "0"}")?.round() ?? 0),
                                                                initVal: (double.tryParse("${value.buyerData?[index].qty ?? "0"}")?.round() ?? 0),
                                                                minVal: 0,
                                                                steps: 10,
                                                                qtyFormProps: QtyFormProps(
                                                                  keyboardType:
                                                                      TextInputType.numberWithOptions(
                                                                        decimal:
                                                                            false,
                                                                      ),
                                                                ),
                                                                onQtyChanged: (
                                                                  val,
                                                                ) {
                                                                  ref
                                                                      .watch(
                                                                        updateWeightProvider
                                                                            .notifier,
                                                                      )
                                                                      .state = double.parse(
                                                                    "${val ?? 0.0}",
                                                                  );
                                                                  print(val);
                                                                },
                                                                decoration: QtyDecorationProps(
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          5,
                                                                        ),
                                                                    borderSide:
                                                                        BorderSide(
                                                                          color:
                                                                              ColorConstant.maingreen,
                                                                        ),
                                                                  ),
                                                                  qtyStyle:
                                                                      QtyStyle
                                                                          .classic,
                                                                  minusBtn: Container(
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          ColorConstant
                                                                              .maingreen,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            5,
                                                                          ),
                                                                    ),
                                                                    padding: Pad(
                                                                      all: 10,
                                                                    ),
                                                                    child: Text(
                                                                      '-10',
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color:
                                                                            Colors.white,
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                              17,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  plusBtn: Container(
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          ColorConstant
                                                                              .maingreen,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            5,
                                                                          ),
                                                                    ),
                                                                    padding: Pad(
                                                                      all: 10,
                                                                    ),
                                                                    child: Text(
                                                                      '+10',
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color:
                                                                            Colors.white,
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                              17,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 15),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  top: 15,
                                                                ),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: ElevatedButton(
                                                                    style: AppStyle
                                                                        .buttonStyle
                                                                        .copyWith(
                                                                          backgroundColor: WidgetStatePropertyAll(
                                                                            Colors.red,
                                                                          ),
                                                                        ),
                                                                    onPressed: () {
                                                                      Get.back();
                                                                    },
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                        context,
                                                                      )!.msgCencel,
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                              16,
                                                                            ),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Expanded(
                                                                  child: ElevatedButton(
                                                                    style:
                                                                        AppStyle
                                                                            .buttonStyle,
                                                                    onPressed: () async {
                                                                      context.showLoader();
                                                                      ref
                                                                          .read(
                                                                            updateSbtProvider(
                                                                              productId:
                                                                                  "${widget.data?.productId}",
                                                                              tradeId:
                                                                                  "${value.buyerData?[index].tradeId}",
                                                                              commodityId:
                                                                                  "${widget.data?.commodityId}",
                                                                              district_id:
                                                                                  "${widget.data?.districtId}",
                                                                              qty: ref
                                                                                  .read(
                                                                                    updateWeightProvider,
                                                                                  )
                                                                                  .toStringAsFixed(
                                                                                    0,
                                                                                  ),
                                                                              price: ref
                                                                                  .read(
                                                                                    updatePriceProvider,
                                                                                  )
                                                                                  .toStringAsFixed(
                                                                                    0,
                                                                                  ),
                                                                              type:
                                                                                  "1",
                                                                            ).future,
                                                                          )
                                                                          .then((
                                                                            res,
                                                                          ) {
                                                                            context.hideloader();
                                                                            ref.invalidate(
                                                                              getBuyerSellerListProvider,
                                                                            );

                                                                            ref.invalidate(
                                                                              getSbtCommodityProvider,
                                                                            );

                                                                            ref.invalidate(
                                                                              matchedOrdersProvider,
                                                                            );

                                                                            Get.back(
                                                                              canPop:
                                                                                  true,
                                                                              closeOverlays:
                                                                                  true,
                                                                            );
                                                                            if (res['status'].toString() ==
                                                                                "1") {
                                                                              Get.rawSnackbar(
                                                                                message:
                                                                                    "${res['message']}",
                                                                                duration: const Duration(
                                                                                  seconds:
                                                                                      2,
                                                                                ),
                                                                                backgroundColor:
                                                                                    ColorConstant.maingreen,
                                                                              );
                                                                            } else {
                                                                              showErrorAlertDialog(context, res['message']);
                                                                            }
                                                                          })
                                                                          .onError(
                                                                            (
                                                                              e,
                                                                              s,
                                                                            ) {
                                                                              context.hideloader();
                                                                              showErrorAlertDialog(context, "An error occurred: $e");
                                                                            },
                                                                          );
                                                                    },
                                                                    child: Text(
                                                                      "Submit",
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                              16,
                                                                            ),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            PopupMenuItem(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.delete,
                                                    color:
                                                        ColorConstant.maingreen,
                                                    size: Adaptive.sp(16),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: Adaptive.sp(16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                ref
                                                    .watch(
                                                      deleteOrderProvider(
                                                        orderId:
                                                            "${value.buyerData?[index].tradeId}",
                                                      ).future,
                                                    )
                                                    .then((value) {
                                                      if (value['status']
                                                              .toString() ==
                                                          "1") {
                                                        ref.invalidate(
                                                          getBuyerSellerListProvider,
                                                        );
                                                        ref.invalidate(
                                                          getSbtCommodityProvider,
                                                        );
                                                      } else {
                                                        showErrorAlertDialog(context, value['message']);
                                                      }
                                                    });
                                              },
                                            ),
                                          ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: value.buyerData?.length ?? 0,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
          error: (e, s) => Container(),
          loading: () => Container(),
        );
  }
}
