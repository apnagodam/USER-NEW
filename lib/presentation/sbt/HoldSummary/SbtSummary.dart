import 'package:apnagodam/presentation/sbt/HoldSummary/SummaryDetails.dart';
import 'package:apnagodam/presentation/sbt/HoldSummary/service/HoldSummaryService.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/no_data_found_widget.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class SbtHoldSummary extends ConsumerStatefulWidget {
  const SbtHoldSummary({super.key, required this.walletType});
  final String walletType;
  @override
  ConsumerState<SbtHoldSummary> createState() => _SbtHoldSummaryState();
}

class _SbtHoldSummaryState extends ConsumerState<SbtHoldSummary> {
  var totalAmountProvider = StateProvider((ref) => 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.holdSummary),
      ),
      bottomNavigationBar: Container(
        padding: Pad(top: 10, bottom: 10, right: 20, left: 20),
        decoration: BoxDecoration(color: ColorConstant.maingreen),
        width: Get.width,
        child: Row(
          children: [
            Expanded(
                child: Text(AppLocalizations.of(context)!.total,
                    style: TextStyle(
                        color: ColorConstant.whiteA700,
                        fontWeight: FontWeight.w700,
                        fontSize: Adaptive.sp(16)))),
            Text("${ref.watch(totalAmountProvider)}",
                style: TextStyle(
                    color: ColorConstant.whiteA700,
                    fontWeight: FontWeight.w700,
                    fontSize: Adaptive.sp(16)))
          ],
        ),
      ),
      body: ListView(
        children: [
          ref
              .watch(sbtHoldStatementProvider(walletType: widget.walletType))
              .when(
                  data: (data) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        final total = data.data?.fold(
                                0,
                                (previous, current) =>
                                    previous +
                                    int.parse("${current.amount ?? 0}")) ??
                            0;
                        if (ref.read(totalAmountProvider) != total) {
                          ref.read(totalAmountProvider.notifier).state = total;
                        }
                      }
                    });
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        DataTable(
                          headingRowColor:
                              WidgetStatePropertyAll(ColorConstant.maingreen),
                          headingTextStyle: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          border: TableBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              left: BorderSide(color: ColorConstant.maingreen),
                              right: BorderSide(color: ColorConstant.maingreen),
                              top: BorderSide(color: ColorConstant.maingreen),
                              bottom:
                                  BorderSide(color: ColorConstant.maingreen)),
                          columns: [
                            DataColumn(
                                label:
                                    Text(AppLocalizations.of(context)!.reason)),
                            DataColumn(
                                label: TextOneLine(AppLocalizations.of(context)!
                                    .paymentAmount)),
                            DataColumn(
                                label:
                                    Text(AppLocalizations.of(context)!.action)),
                          ],
                          rows: data.data!
                              .map(
                                ((element) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(
                                            element.type
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "entryload"
                                                ? "Entry Load"
                                                : element.type
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "exitload"
                                                    ? "Exit Load"
                                                    : element.type
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "sbt"
                                                        ? "SBT"
                                                        : element.type
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                "manditax"
                                                            ? "Mandi Tax"
                                                            : element.type
                                                                        .toString()
                                                                        .toLowerCase() ==
                                                                    "wsa"
                                                                ? "WSA"
                                                                : "${element.type}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16)))),
                                        //Extracting from Map element the value
                                        DataCell(Text(
                                          "\u{20B9} ${element.amount}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Adaptive.sp(15)),
                                        )),
                                        DataCell(InkWell(
                                          child: Text(
                                              AppLocalizations.of(
                                                      context)!
                                                  .summary,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  decorationColor:
                                                      ColorConstant.maingreen,
                                                  fontWeight: FontWeight.w700,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: Adaptive.sp(16))),
                                          onTap: () {
                                            Get.to(Summarydetails(
                                              type: "${element.type}",
                                            ));
                                          },
                                        )),
                                      ],
                                    )),
                              )
                              .toList(),
                        ),
                      ],
                    );
                  },
                  error: (e, s) => Container(),
                  loading: () => Container(
                        height: Get.height,
                        child: defaultLoader(),
                        alignment: Alignment.center,
                      )),
        ],
      ),
    );
  }
}
