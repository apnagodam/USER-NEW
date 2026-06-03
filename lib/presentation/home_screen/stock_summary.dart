import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/home_screen/models/summary_commodity_model.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/home_screen/summary_controller/summary_controller.dart';
import 'package:apnagodam/widgets/custom_stacked_horizontal_bar_chart.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';

class StockSummary extends ConsumerStatefulWidget {
  const StockSummary({super.key});

  @override
  ConsumerState<StockSummary> createState() => _StockSummaryState();
}

class _StockSummaryState extends ConsumerState<StockSummary> {
  var comId;
  var wareId;
  double maxValue = 0.0;
  double currentValue = 0.0;
  double progressValue = 0.0;
  List<ChartData> chartData = [];
  var commodityFilterList = StateProvider<List<Datum?>>((ref) => []);
  var terminalFilterList = StateProvider<List<WareHousedatum?>>((ref) => []);
  var terminalRequestList = StateProvider<List<WareHousedatum>>((ref) => []);
  var commodityRequestList = StateProvider<List<Datum>>((ref) => []);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SummaryController>(
      init: SummaryController(),
      builder: (cont) {
        if (cont.isLoad == false) {
          cont.update();
        }
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstant.bgcolor,
            // appBar: AppBar(
            //   backgroundColor: ColorConstant.maingreen,
            //   automaticallyImplyLeading: true,
            //   title: Text(
            //     AppLocalizations.of(context)!.msgSummary,
            //     style: AppStyle.lblAppbar,
            //   ),
            //   centerTitle: true,
            // ),
            body: ref
                .watch(userSummaryDataProvider)
                .when(
                  data: (summaryData) {
                    maxValue = double.parse(
                      summaryData.data?.totalWgt ?? "0.0",
                    );
                    currentValue = double.parse(
                      summaryData.data?.loanTotalWgt ?? "0.0",
                    );
                    progressValue = currentValue / maxValue;

                    chartData = [
                      ChartData(
                        '${AppLocalizations.of(context)!.releasedWeightInQtl} : ${double.parse("${summaryData.data?.wiLoanWgt}")}',
                        cont.isLoad == false
                            ? double.parse("${summaryData.data?.wiLoanWgt}")
                            : 100,
                      ),
                      ChartData(
                        '${AppLocalizations.of(context)!.fundedWeightInQtl} : ${double.parse("${summaryData.data?.loanTotalWgt}")}',
                        cont.isLoad == false
                            ? double.parse("${summaryData.data?.loanTotalWgt}")
                            : 100,
                      ),
                    ];
                    return ref
                        .watch(summaryDataProvider)
                        .when(
                          data:
                              (data) => Padding(
                                padding: EdgeInsets.all(10),
                                child:
                                    (data.data ?? []).isEmpty &&
                                            (data.wareHousedata ?? []).isEmpty
                                        ? noStockData(context)
                                        : ListView(
                                          children: [
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.filterCommodity,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: Adaptive.sp(16),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  width: 1.5,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 14,
                                                  horizontal: 16,
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                              icon: Icon(
                                                Icons.filter_alt_rounded,
                                                color: ColorConstant.maingreen,
                                              ),
                                              label: Text(
                                                '${AppLocalizations.of(context)!.selectCommodity} ${ref.watch(commodityRequestList).isEmpty ? "" : "(${ref.watch(commodityRequestList).length} filter applied)"}',
                                                style: TextStyle(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Adaptive.sp(15),
                                                ),
                                              ),
                                              onPressed: () async {
                                                await FilterListDialog.display<
                                                  Datum
                                                >(
                                                  context,
                                                  listData: (data.data ?? []),
                                                  useRootNavigator: false,
                                                  themeData: FilterListThemeData(
                                                    context,
                                                  ).copyWith(
                                                    controlBarButtonTheme:
                                                        ControlButtonBarThemeData(
                                                          context,
                                                        ).copyWith(
                                                          controlButtonTheme:
                                                              ControlButtonThemeData(
                                                                textStyle: TextStyle(
                                                                  color:
                                                                      ColorConstant
                                                                          .maingreen,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                        ),
                                                    choiceChipTheme:
                                                        ChoiceChipThemeData(
                                                          selectedBackgroundColor:
                                                              ColorConstant
                                                                  .maingreen,
                                                          selectedTextStyle:
                                                              TextStyle(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                        ),
                                                  ),
                                                  selectedListData: ref.watch(
                                                    commodityRequestList,
                                                  ),
                                                  choiceChipLabel:
                                                      (user) =>
                                                          user!.commodityName,
                                                  validateSelectedItem:
                                                      (list, val) =>
                                                          list!.contains(val),
                                                  onItemSearch: (user, query) {
                                                    return user.commodityName!
                                                        .toLowerCase()
                                                        .contains(
                                                          query.toLowerCase(),
                                                        );
                                                  },
                                                  onApplyButtonClick: (data) {
                                                    ref
                                                        .watch(
                                                          commodityRequestList
                                                              .notifier,
                                                        )
                                                        .state = data!;
                                                    ref
                                                        .watch(
                                                          commodityNameProvider,
                                                        )
                                                        .clear();
                                                    data.forEach((element) {
                                                      ref
                                                          .watch(
                                                            commodityNameProvider,
                                                          )
                                                          .add(
                                                            element.id
                                                                .toString(),
                                                          );
                                                    });
                                                    ref.invalidate(
                                                      userSummaryDataProvider,
                                                    );
                                                    Get.back();
                                                  },
                                                );
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.filterTerminals,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: Adaptive.sp(16),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            OutlinedButton.icon(
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  width: 1.5,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 14,
                                                  horizontal: 16,
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                              icon: Icon(
                                                Icons.store_rounded,
                                                color: ColorConstant.maingreen,
                                              ),
                                              label: Text(
                                                '${AppLocalizations.of(context)!.terminal} ${ref.watch(terminalRequestList).isEmpty ? "" : "(${ref.watch(terminalRequestList).length} filter applied)"}',
                                                style: TextStyle(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Adaptive.sp(15),
                                                ),
                                              ),
                                              onPressed: () async {
                                                await FilterListDialog.display<
                                                  WareHousedatum
                                                >(
                                                  context,
                                                  useRootNavigator: false,
                                                  themeData: FilterListThemeData(
                                                    context,
                                                  ).copyWith(
                                                    controlBarButtonTheme:
                                                        ControlButtonBarThemeData(
                                                          context,
                                                        ).copyWith(
                                                          controlButtonTheme:
                                                              ControlButtonThemeData(
                                                                textStyle: TextStyle(
                                                                  color:
                                                                      ColorConstant
                                                                          .maingreen,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                        ),
                                                    choiceChipTheme:
                                                        ChoiceChipThemeData(
                                                          selectedBackgroundColor:
                                                              ColorConstant
                                                                  .maingreen,
                                                          selectedTextStyle:
                                                              TextStyle(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                        ),
                                                  ),
                                                  listData:
                                                      (data.wareHousedata ??
                                                          []),
                                                  selectedListData: ref.watch(
                                                    terminalRequestList,
                                                  ),
                                                  choiceChipLabel:
                                                      (user) =>
                                                          user!.warehouseName,
                                                  validateSelectedItem:
                                                      (list, val) =>
                                                          list!.contains(val),
                                                  onItemSearch: (user, query) {
                                                    return user.warehouseName!
                                                        .toLowerCase()
                                                        .contains(
                                                          query.toLowerCase(),
                                                        );
                                                  },
                                                  onApplyButtonClick: (data) {
                                                    ref
                                                        .watch(
                                                          terminalRequestList
                                                              .notifier,
                                                        )
                                                        .state = data!;
                                                    ref
                                                        .watch(
                                                          warehouseNameProvider,
                                                        )
                                                        .clear();
                                                    for (var element in data) {
                                                      ref
                                                          .watch(
                                                            warehouseNameProvider,
                                                          )
                                                          .add(
                                                            element.id
                                                                .toString(),
                                                          );
                                                    }
                                                    ref.invalidate(
                                                      userSummaryDataProvider,
                                                    );
                                                    Get.back();
                                                  },
                                                );
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            SizedBox(height: 10),
                                            ElevarmOutlinedCard(
                                              child: Column(
                                                children: [
                                                  CustomStackedHorizontalBarChart(
                                                    tooltipTitle:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.msgCommodityy,
                                                    legendValueBuilder:
                                                        (data) =>
                                                            '${data.value}',
                                                    dataSource: [
                                                      CustomStackedHorizontalBarChartData(
                                                        label:
                                                            '${AppLocalizations.of(context)!.releasedBags}: ${summaryData.data?.wiLoanBeg}  \n${AppLocalizations.of(context)!.releasedWeightInQtl}: ${summaryData.data?.wiLoanWgt}',
                                                        value: double.parse(
                                                          '${summaryData.data?.wiLoanWgt}',
                                                        ),
                                                        color:
                                                            ElevarmColors
                                                                .success,
                                                        customData: '',
                                                      ),
                                                      CustomStackedHorizontalBarChartData(
                                                        label:
                                                            '${AppLocalizations.of(context)!.fundedBags}: ${summaryData.data?.loanTotalBeg} \n${AppLocalizations.of(context)!.fundedWeightInQtl}: ${summaryData.data?.loanTotalWgt}',
                                                        value: double.parse(
                                                          '${summaryData.data?.loanTotalWgt}',
                                                        ),
                                                        color:
                                                            ElevarmColors
                                                                .danger,
                                                        customData: 'hello',
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: Pad(all: 5),
                                              child: ElevarmDonutChartCard(
                                                title:
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.releasedAndFunded,
                                                subtitle:
                                                    '${AppLocalizations.of(context)!.totalWeight}: ${cont.commodityData?['total_wgt'] ?? ""}\t${AppLocalizations.of(context)!.totalBags}: ${cont.commodityData?['total_beg'] ?? ""}',
                                                dataSource: [
                                                  ElevarmDonutChartData(
                                                    label:
                                                        '${AppLocalizations.of(context)!.releasedBags}: ${summaryData.data?.wiLoanBeg}  \n${AppLocalizations.of(context)!.releasedWeightInQtl}: ${summaryData.data?.wiLoanWgt}',
                                                    value:
                                                        num.parse(
                                                          '${summaryData.data?.wiLoanWgt}',
                                                        ).toInt(),
                                                    color:
                                                        ColorConstant.maingreen,
                                                  ),
                                                  ElevarmDonutChartData(
                                                    label:
                                                        '${AppLocalizations.of(context)!.fundedBags}: ${summaryData.data?.loanTotalBeg}  \n${AppLocalizations.of(context)!.fundedWeightInQtl}: ${summaryData.data?.loanTotalWgt}',
                                                    value:
                                                        num.parse(
                                                          '${summaryData.data?.loanTotalWgt}',
                                                        ).toInt(),
                                                    color: ElevarmColors.danger,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
                          error:
                              (e, s) => ColumnSuper(
                                children: [Text(e.toString() + s.toString())],
                              ),
                          loading: () => Container(),
                        );
                  },
                  error: (e, s) => Text(e.toString() + s.toString()),
                  loading: () => _summaryLoader(),
                ),
          ),
        );
      },
    );
  }

  _summaryLoader() => Skeletonizer(
    child: ListView(
      children: [
        ColumnSuper(
          children: [
            SizedBox(height: 10),
            ElevarmOutlinedCard(
              child: CustomStackedHorizontalBarChart(
                tooltipTitle: AppLocalizations.of(context)!.msgCommodityy,
                legendValueBuilder: (data) => '1',
                dataSource: [
                  CustomStackedHorizontalBarChartData(
                    label: 'Released Weight(in Qtl.)',
                    value: 0.0,
                    color: ElevarmColors.success,
                    customData: '',
                  ),
                  CustomStackedHorizontalBarChartData(
                    label: AppLocalizations.of(context)!.fundedWeightInQtl,
                    value: 0.0,
                    color: ElevarmColors.danger,
                    customData: 'hello',
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: Pad(all: 5),
              child: ElevarmDonutChartCard(
                title: AppLocalizations.of(context)!.releasedAndFunded,
                subtitle:
                    '${AppLocalizations.of(context)!.totalWeight}: ${AppLocalizations.of(context)!.totalBags}',
                dataSource: [
                  ElevarmDonutChartData(
                    label: AppLocalizations.of(context)!.releasedWeightInQtl,
                    value: num.parse('0').toInt(),
                    color: ColorConstant.maingreen,
                  ),
                  ElevarmDonutChartData(
                    label: AppLocalizations.of(context)!.fundedWeightInQtl,
                    value: num.parse('0').toInt(),
                    color: ElevarmColors.danger,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.filterCommodity,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: Adaptive.sp(16),
          ),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () async {},
          child: Text(
            'Select Commodity+ ${ref.watch(commodityRequestList).isEmpty ? "" : "(${ref.watch(commodityRequestList).length} filter applied) "}',
            style: TextStyle(
              color: ColorConstant.maingreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Filter Terminals ',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: Adaptive.sp(16),
          ),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () async {},
          child: Text(
            'Select Terminal+ ${ref.watch(terminalRequestList).isEmpty ? "" : "(${ref.watch(terminalRequestList).length} filter applied) "}',
            style: TextStyle(
              color: ColorConstant.maingreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}

var commodityNameProvider = StateProvider<List<String?>>((ref) => []);
var warehouseNameProvider = StateProvider<List<String?>>((ref) => []);

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}
