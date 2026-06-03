import 'package:apnagodam/presentation/sbt/service/SbtService.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/no_data_found_widget.dart';
import '../credit/credit_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Sbtorders extends ConsumerStatefulWidget {
  const Sbtorders({super.key});

  @override
  ConsumerState<Sbtorders> createState() => _SbtordersState();
}

class _SbtordersState extends ConsumerState<Sbtorders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.mySbtOrders),
      ),
      body: RefreshIndicator.adaptive(
          child: ListView(
            children: [
              ref.watch(sbtRequestProvider).when(
                  data: (data) => (data.data ?? []).isEmpty
                      ? SizedBox(
                          height: Get.height,
                          child: Center(
                            child: noStockData(context),
                          ),
                        )
                      : ListView.builder(
                          itemCount: data.data?.length ?? 0,
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (contex, index) => Card(
                            color: Colors.white,
                            elevation: 8,
                            margin: Pad(all: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side:
                                    BorderSide(color: ColorConstant.maingreen)),
                            child: Padding(
                              padding: Pad(all: 10),
                              child: ColumnSuper(children: [
                                Center(
                                    child: Text(
                                  "${data.data?[index].uniqueTradeId ?? 0}",
                                  style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      AppLocalizations.of(context)!.typeLabel,
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Text(
                                      "${data.data?[index].type ?? 0}",
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      AppLocalizations.of(context)!.msgDistrict,
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Text(
                                      "${data.data?[index].districtId ?? 0}",
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      AppLocalizations.of(context)!
                                          .msgCommodityy,
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Text(
                                      "${data.data?[index].commodity ?? 0}",
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      AppLocalizations.of(context)!.quantity,
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Text(
                                      "${data.data?[index].qty ?? 0} Qtl.",
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      AppLocalizations.of(context)!.price,
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Text(
                                      "${currencyFormat.format(double.parse("${data.data?[index].price ?? 0}"))} per Qtl.",
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      AppLocalizations.of(context)!.holdAmount,
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Text(
                                      "${currencyFormat.format(double.parse("${data.data?[index].walletHold ?? 0}"))}.",
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: Text(
                                  "${AppLocalizations.of(context)!.msgDate} ${(data.data?[index].createdAt as DateTime).day}/${(data.data?[index].createdAt as DateTime).month}/${(data.data?[index].createdAt as DateTime).year}",
                                  style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold),
                                )),
                                Center(
                                    child: Text(
                                  data.data?[index].status.toString() == "1"
                                      ? AppLocalizations.of(context)!.running
                                      : data.data?[index].status.toString() ==
                                              "2"
                                          ? AppLocalizations.of(context)!
                                              .completed
                                          : data.data?[index].status
                                                      .toString() ==
                                                  "3"
                                              ? AppLocalizations.of(context)!
                                                  .cancelled
                                              : AppLocalizations.of(context)!
                                                  .deliveryMarkingPending,
                                  style: TextStyle(
                                      color:
                                          data.data?[index].status.toString() ==
                                                  "1"
                                              ? Colors.yellow
                                              : data.data?[index].status
                                                          .toString() ==
                                                      "2"
                                                  ? Colors.green
                                                  : data.data?[index].status
                                                              .toString() ==
                                                          "3"
                                                      ? Colors.red
                                                      : Colors.yellow[800],
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold),
                                )),
                              ]),
                            ),
                          ),
                        ),
                  error: (e, s) => Container(),
                  loading: () => SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: defaultLoader(),
                      ))
            ],
          ),
          onRefresh: () {
            return Future.value((_) {
              ref.invalidate(sbtRequestProvider);
            });
          }),
    );
  }
}
