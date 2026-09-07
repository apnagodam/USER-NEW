import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/sbt/HoldSummary/service/HoldSummaryService.dart';
import 'package:apnagodam/presentation/sbt/HoldSummary/service/model/HoldSummaryModel.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Summarydetails extends ConsumerStatefulWidget {
  const Summarydetails({super.key, this.type});

  final String? type;

  @override
  ConsumerState<Summarydetails> createState() => _SummarydetailsState();
}

class _SummarydetailsState extends ConsumerState<Summarydetails> {
  var totalAmountProvider = StateProvider((ref) => 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${AppLocalizations.of(context)!.holdSummary} - ${widget.type.toString().toLowerCase() == "entryload" ? "Entry Load" : widget.type.toString().toLowerCase() == "exitload" ? "Exit Load" : widget.type.toString().toLowerCase() == "sbt" ? "SBT" : widget.type.toString().toLowerCase() == "manditax" ? "Mandi Tax" : widget.type.toString().toLowerCase() == "wsa" ? "WSA" : "${widget.type}"}"),
      ),
      body: ListView(
        padding: const Pad(all: 0),
        children: [
          ref.watch(holdSummaryProvider(type: widget.type)).when(
              data: (data) {
                final typeClean = widget.type?.toLowerCase().replaceAll(' ', '').replaceAll('_', '') ?? '';
                if (typeClean == "sbt") {
                  Future.delayed(Duration(seconds: 1)).then((_) {
                    if (!mounted) return;
                    ref.read(totalAmountProvider.notifier).state = double.parse(
                        "${data.data?.fold<double>(0, (previous, current) => previous + double.parse("${current.amount ?? 0.0}"))}");
                  });

                  return FittedBox(child: sbtLayout(ref, data));
                } else if (typeClean == "manditax") {
                  Future.delayed(Duration(seconds: 1)).then((_) {
                    if (!mounted) return;
                    ref.read(totalAmountProvider.notifier).state = double.parse(
                        "${data.data?.fold<double>(0, (previous, current) => previous + double.parse("${current.amount ?? 0.0}"))}");
                  });

                  return FittedBox(
                    child: mandiTaxLayout(ref, data),
                  );
                } else if (typeClean == "securitymargin") {
                  Future.delayed(Duration(seconds: 1)).then((_) {
                    if (!mounted) return;
                    ref.read(totalAmountProvider.notifier).state = double.parse(
                        "${data.data?.fold<double>(0, (previous, current) => previous + double.parse("${current.amount ?? 0.0}"))}");
                  });

                  return FittedBox(
                    child: securityMarginLayout(ref, data),
                  );
                } else {
                  Future.delayed(Duration(seconds: 1)).then((_) {
                    if (!mounted) return;
                    ref.read(totalAmountProvider.notifier).state = double.parse(
                        "${data.data?.fold<double>(0, (previous, current) => previous + double.parse("${current.amount ?? 0.0}"))}");
                  });

                  return FittedBox(
                    child: chargesLayout(ref, data),
                  );
                }
              },
              error: (e, s) => Container(),
              loading: () => Container(
                    height: Get.height,
                    child: defaultLoader(),
                    alignment: Alignment.center,
                  ))
        ],
      ),
      bottomNavigationBar: Card(
        margin: Pad(all: 0),
        color: ColorConstant.maingreen,
        shape: RoundedRectangleBorder(),
        child: Padding(
          padding: Pad(all: 10),
          child: Text(
              AppLocalizations.of(context)!.totalAmount +
                  "  \u{20B9}${ref.watch(totalAmountProvider).toStringAsFixed(0)}",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: Adaptive.sp(17))),
        ),
      ),
    );
  }

  securityMarginLayout(WidgetRef ref, HoldSummaryModel data) => DataTable(
      headingRowColor:
          WidgetStateProperty.resolveWith((states) => ColorConstant.maingreen),
      showBottomBorder: true,
      border: TableBorder.all(color: Colors.grey),
      columns: [
        DataColumn(
          label: Align(
              alignment: Alignment.center,
              child: Text(
                "Security Type",
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(17.5)),
                textAlign: TextAlign.center,
              )),
        ),
        DataColumn(
            label: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.paymentAmount,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.sp(17.5)),
                  textAlign: TextAlign.center,
                ))),
        DataColumn(
            label: Align(
          alignment: Alignment.center,
          child: Text(
            "Haircut",
            maxLines: 2,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Adaptive.sp(17.5)),
            textAlign: TextAlign.center,
          ),
        )),
        DataColumn(
            label: Align(
          alignment: Alignment.center,
          child: Text(
            "Trade Limit",
            maxLines: 2,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Adaptive.sp(17.5)),
            textAlign: TextAlign.center,
          ),
        )),
      ],
      rows: List.generate(
          data.data?.length ?? 0,
          (index) {
            final item = data.data?[index];
            return DataRow(
                color: WidgetStateProperty.resolveWith((states) {
                  if (index % 2 == 0) {
                    return Colors.white;
                  } else {
                    return Colors.grey.withOpacity(0.3);
                  }
                }),
                cells: [
                  DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${item?.clientSecurityType ?? item?.type ?? "-"}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Adaptive.sp(17.5)),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(
                      "\u{20B9}${item?.amount ?? "0"}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Adaptive.sp(17.5)),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${item?.hairCut ?? "0"}%",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Adaptive.sp(17.5)),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  DataCell(Align(
                    alignment: Alignment.center,
                    child: Text(
                      "\u{20B9}${item?.tradelimit ?? "0"}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Adaptive.sp(17.5)),
                      textAlign: TextAlign.center,
                    ),
                  )),
                ]);
          }));

  chargesLayout(WidgetRef ref, HoldSummaryModel data) => DataTable(
      headingRowColor:
          WidgetStateProperty.resolveWith((states) => ColorConstant.maingreen),
      showBottomBorder: true,
      border: TableBorder.all(color: Colors.grey),
      columns: [
        DataColumn(
          label: Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.msgGatepastwo,
                maxLines: 2,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ),
        DataColumn(
            label: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.msgCommodityy,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        DataColumn(
            label: Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.msgTerminal,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )),
        if (widget.type?.toLowerCase().replaceAll(' ', '') == "entryload" ||
            widget.type?.toLowerCase().replaceAll(' ', '') == "exitload")
          DataColumn(
              label: Align(
            alignment: Alignment.center,
            child: Text(
              widget.type?.toLowerCase().replaceAll(' ', '') == "entryload"
                  ? AppLocalizations.of(context)!.entryLoadCharge
                  : AppLocalizations.of(context)!.exitLoadCharge,
              maxLines: 2,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )),
        DataColumn(
            label: Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.paymentAmount,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ))
      ],
      rows: List.generate(
          data.data?.length ?? 0,
          (index) => DataRow(
                  color: WidgetStateProperty.resolveWith((states) {
                    if (index % 2 == 0) {
                      return Colors.white;
                    } else {
                      return Colors.grey.withOpacity(0.3);
                    }
                  }),
                  cells: [
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${data.data?[index].gatepass ?? "-"}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16)),
                        textAlign: TextAlign.center,
                      ),
                    )),
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                            text: "${data.data?[index].commodityName ?? "-"}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16))),
                        softWrap: true,
                      ),
                    )),
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text(
                          "${(data.data?[index].warehouseName ?? "").length > 12 ? (data.data?[index].warehouseName ?? "").substring(0, 12) : (data.data?[index].warehouseName ?? "-")}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16))),
                    )),
                    if (widget.type?.toLowerCase().replaceAll(' ', '') ==
                            "entryload" ||
                        widget.type?.toLowerCase().replaceAll(' ', '') ==
                            "exitload")
                      DataCell(Align(
                        alignment: Alignment.center,
                        child: Text("${data.data?[index].loadCharge ?? "0"}%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16))),
                      )),
                    DataCell(
                      Text("\u{20B9}${data.data?[index].amount}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16))),
                    )
                  ])));

  sbtLayout(WidgetRef ref, HoldSummaryModel data) => DataTable(
      headingRowColor:
          WidgetStateProperty.resolveWith((states) => ColorConstant.maingreen),
      showBottomBorder: true,
      border: TableBorder.all(color: Colors.grey),
      columns: [
        DataColumn(
          label: Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.uniqueTradeId,
                maxLines: 2,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ),
        DataColumn(
            label: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.product,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        DataColumn(
            label: Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.walletHold,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )),
        DataColumn(
            label: Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.limitHold,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )),
        DataColumn(
            label: Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.quantityType,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ))
      ],
      rows: List.generate(
          data.data?.length ?? 0,
          (index) => DataRow(
                  color: WidgetStateProperty.resolveWith((states) {
                    if (index % 2 == 0) {
                      return Colors.white;
                    } else {
                      return Colors.grey.withOpacity(0.3);
                    }
                  }),
                  cells: [
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${data.data?[index].uniqueTradeId}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16)),
                        textAlign: TextAlign.center,
                      ),
                    )),
                    DataCell(Center(
                      child: ColumnSuper(
                        alignment: Alignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                                text: "${data.data?[index].commodityName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(16))),
                            softWrap: true,
                          ),
                          Text.rich(
                            TextSpan(
                                text: "${data.data?[index].districtId}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(16))),
                            softWrap: true,
                          )
                        ],
                      ),
                    )),
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text("\u{20B9}${data.data?[index].amount}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16))),
                    )),
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text("\u{20B9}${data.data?[index].pfAmount}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16))),
                    )),
                    DataCell(
                      Text(
                          "${data.data?[index].qty} (Qtl. / ${data.data?[index].type})",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16))),
                    )
                  ])));

  mandiTaxLayout(WidgetRef ref, HoldSummaryModel data) => DataTable(
      headingRowColor:
          WidgetStateProperty.resolveWith((states) => ColorConstant.maingreen),
      showBottomBorder: true,
      border: TableBorder.all(color: Colors.grey),
      columns: [
        DataColumn(
          label: Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.msgState,
                maxLines: 2,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ),
        DataColumn(
            label: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.msgCommodityy,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        DataColumn(
            label: Align(
          alignment: Alignment.center,
          child: Text(
            "${AppLocalizations.of(context)!.taxRate} / ${AppLocalizations.of(context)!.paymentAmount}",
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )),
        // DataColumn(
        //     label: Align(
        //   alignment: Alignment.center,
        //   child: Text(
        //     ,
        //     maxLines: 2,
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //     textAlign: TextAlign.center,
        //   ),
        // )),
        DataColumn(
            label: Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.dealTypeId,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ))
      ],
      rows: List.generate(
          data.data?.length ?? 0,
          (index) => DataRow(
                  color: WidgetStateProperty.resolveWith((states) {
                    if (index % 2 == 0) {
                      return Colors.white;
                    } else {
                      return Colors.grey.withOpacity(0.3);
                    }
                  }),
                  cells: [
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${data.data?[index].warehouseName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16)),
                        textAlign: TextAlign.center,
                      ),
                    )),
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                            text: "${data.data?[index].commodityName}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16))),
                        softWrap: true,
                      ),
                    )),
                    DataCell(Align(
                      alignment: Alignment.center,
                      child: Text(
                          "${data.data?[index].taxRate}% \n \u{20B9}${data.data?[index].amount}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16))),
                    )),
                    // DataCell(
                    //   Text("\u{20B9}${data.data?[index].amount}",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: Adaptive.sp(16))),
                    // ),
                    DataCell(
                      Text(
                          "${data.data?[index].dealtype} \n ${data.data?[index].gatepass}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16))),
                    ),
                  ])));
}
