import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/commodity_finance/service/commodity_finance_service.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/theme/app_style.dart';
import '../credit/credit_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class CommodityFinance extends ConsumerWidget {
  const CommodityFinance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.maingreen,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.msgCommodityfinance,
          ),
        ),
        body: ref.watch(getFinanceListProvider).when(
            data: (data) => (data.data ?? []).isEmpty
                ? noStockData()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 3.0, right: 3.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: ColorConstant.maingreen,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.msgRequestlist,
                              style: AppStyle.lblviewbtnwithdraw
                                  .copyWith(fontSize: Adaptive.sp(17)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.data?.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                var reversedList = data.data?.reversed.toList();
                                var status = reversedList?[index].status;
                                String statusvalue = "";

                                if (status == 1) {
                                  statusvalue = AppLocalizations.of(context)!
                                      .msgStatusRunning;
                                }
                                if (status == 0) {
                                  statusvalue = AppLocalizations.of(context)!
                                      .msgStatusRejected;
                                }
                                if (status == 2) {
                                  statusvalue = AppLocalizations.of(context)!
                                      .msgStatusApproved;
                                }
                                if (status == 3) {
                                  statusvalue = AppLocalizations.of(context)!
                                      .msgStatusVerified;
                                }
                                var date = DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(
                                        reversedList?[index].createdAt ?? ""));
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: ColorConstant.maingreen,
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.orangeAccent.shade100
                                              .withOpacity(0.5),
                                          Colors.orangeAccent.shade100
                                              .withOpacity(0.7),
                                          Colors.orangeAccent.shade100
                                        ],
                                      )),
                                  margin: Pad(all: 10),
                                  child: Padding(
                                    padding: Pad(all: 10),
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.center ,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${reversedList?[index].bankName}',
                                                style: AppStyle.lblmystockspot
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: ColorConstant
                                                            .maingreen,
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .msgDate,
                                                          style: AppStyle
                                                              .mystokedetail
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16)),
                                                        ),
                                                        Text(
                                                          date,
                                                          style: AppStyle
                                                              .mystokedetail
                                                              .copyWith(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16)),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              status == 0
                                                                  ? "Rejected"
                                                                  : status == 2
                                                                      ? AppLocalizations.of(context)!.msgStatusApproved3
                                                                      : status ==
                                                                              3
                                                                          ? AppLocalizations.of(context)!.msgStatusVerified3
                                                                          : status == 4
                                                                              ? AppLocalizations.of(context)!.msgStatus + AppLocalizations.of(context)!.msgStatusApproved
                                                                              : status == 1
                                                                                  ? AppLocalizations.of(context)!.msgStatus + AppLocalizations.of(context)!.msgStatusRunning
                                                                                  : "",
                                                              style: TextStyle(
                                                                  fontSize: Adaptive.sp(16),
                                                                  color: status == 0
                                                                      ? Colors.red
                                                                      : status == 4
                                                                          ? Colors.green
                                                                          : status == 1
                                                                              ? Colors.amber
                                                                              : Colors.transparent)),
                                                          //                           if(status == 1){
                                                          //   statusvalue = AppLocalizations.of(context)!.msgStatusRunning;
                                                          //
                                                          //   }if(status == 0){
                                                          // statusvalue = AppLocalizations.of(context)!.msgStatusRejected;
                                                          //
                                                          // }if(status == 2){
                                                          //   statusvalue = AppLocalizations.of(context)!.msgStatusApproved;
                                                          //
                                                          // }if(status == 3){
                                                          //   statusvalue = AppLocalizations.of(context)!.msgStatusVerified;
                                                          //
                                                          // }
                                                          /*Text(
                                                      statusvalue,
                                                      style: TextStyle(
                                                        color: statusvalue == AppLocalizations.of(context)!.msgStatusRunning ? Colors.orange:

                                                        statusvalue == AppLocalizations.of(context)!.msgStatusRejected ? Colors.red:

                                                        statusvalue == AppLocalizations.of(context)!.msgStatusApproved ? Colors.blue:

                                                        statusvalue == AppLocalizations.of(context)!.msgStatusVerified ? Colors.green :Colors.green,
                                                      )
                                                  ),*/
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text.rich(TextSpan(
                                                        text:
                                                            AppLocalizations.of(context)!.msgRequestamount3,
                                                        style: AppStyle
                                                            .mystokedetail
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                        16)),
                                                        children: [
                                                          TextSpan(
                                                              text: currencyFormat.format(
                                                                  reversedList?[
                                                                          index]
                                                                      .requestedAmount),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))
                                                        ])),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text.rich(TextSpan(
                                                        text:
                                                            AppLocalizations.of(context)!.msgApprovedamount3,
                                                        style: AppStyle
                                                            .mystokedetail
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                        16)),
                                                        children: [
                                                          TextSpan(
                                                              text: currencyFormat.format(
                                                                  reversedList?[
                                                                          index]
                                                                      .approvedAmount),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))
                                                        ]))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
            error: (e, s) => noFinancesFound(),
            loading: () => defaultLoader()),
        floatingActionButton: Container(
          // height: 100.0,
          // width: 100.0,
          child: FittedBox(
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              backgroundColor: ColorConstant.maingreen,
              onPressed: () {
                Get.close(1);
              },
              label: Text(
                AppLocalizations.of(context)!.msgApply,
                style: TextStyle(color: Colors.white, fontFamily: 'roboto'),
              ),
            ),
          ),
        ));
  }
}
