import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/add_money_screen/provider/add_money_repo_impl.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class AddSummaryScreen extends ConsumerWidget {
  AddSummaryScreen({super.key, required this.type});
  String type = "1";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ColorConstant.maingreen,
        title: Text(
          AppLocalizations.of(context)!.addMoneySummury,
          style: AppStyle.lblAppbar,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          child: ref.watch(getSummaryProvider(type: type)).when(
              data: (data) {
                var reversedList = data.data?.reversed.toList();
                return ref.watch(authProvider).value == AuthStatus.loggedOut
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/images/mainlogopng.png',
                                height: 150, width: 150),
                            simpleButton(
                                text: AppLocalizations.of(context)!.loginToGetSummary2,
                                callback: () {
                                  showLoginBottomsheet(context);
                                }),
                          ],
                        ),
                      )
                    : (reversedList ?? []).isEmpty
                        ? noStockData()
                        : ListView(
                            children: [
                              FittedBox(
                                child: DataTable(
                                    headingRowColor:
                                        WidgetStateProperty.resolveWith(
                                            (states) =>
                                                ColorConstant.maingreen),
                                    showBottomBorder: true,
                                    border: TableBorder.all(color: Colors.grey),
                                    columnSpacing: 36,
                                    dataRowMaxHeight: 120,
                                    headingRowHeight: 120,
                                    columns: [
                                      DataColumn(
                                        label: FittedBox(
                                            child: Text(
                                          AppLocalizations.of(context)!.sNo2,
                                          maxLines: 2,
                                          style: AppStyle.wallatmoneylist
                                              .copyWith(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                      DataColumn(
                                        label: FittedBox(
                                            child: Text(
                                          AppLocalizations.of(context)!
                                              .paymentMode,
                                          maxLines: 2,
                                          style: AppStyle.wallatmoneylist
                                              .copyWith(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                      DataColumn(
                                          label: FittedBox(
                                              child: Text(
                                        AppLocalizations.of(context)!.sirealno,
                                        maxLines: 2,
                                        style: AppStyle.wallatmoneylist
                                            .copyWith(
                                                fontSize: 35,
                                                fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.center,
                                      ))),
                                      DataColumn(
                                          label: FittedBox(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .paymentAmount,
                                          maxLines: 2,
                                          style: AppStyle.wallatmoneylist
                                              .copyWith(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      DataColumn(
                                          label: FittedBox(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .requsetDateLoan,
                                          maxLines: 2,
                                          style: AppStyle.wallatmoneylist
                                              .copyWith(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        ),
                                      ))
                                    ],
                                    rows: List.generate(
                                        reversedList?.length ?? 0,
                                        (index) => DataRow(
                                                color: WidgetStateProperty
                                                    .resolveWith((states) {
                                                  if (index % 2 == 0) {
                                                    return Colors.white;
                                                  } else {
                                                    return Colors.grey
                                                        .withOpacity(0.3);
                                                  }
                                                }),
                                                cells: [
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: const TextStyle(
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  )),
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      reversedList?[index]
                                                              .paymentType ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  )),
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        reversedList?[index]
                                                                .receptNo ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 35,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  )),
                                                  DataCell(Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        reversedList?[index]
                                                                .appliedAmount ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 35,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  )),
                                                  DataCell(
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          DateFormat(
                                                                  'dd/MMM/yyyy')
                                                              .format(DateTime.parse(
                                                                  reversedList?[
                                                                              index]
                                                                          .createdAt ??
                                                                      "")),
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          reversedList?[index]
                                                                      .status ==
                                                                  0
                                                              ? AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .rejected
                                                              : reversedList?[index]
                                                                          .status ==
                                                                      2
                                                                  ? AppLocalizations.of(context)!.submitted2
                                                                  : reversedList?[index]
                                                                              .status ==
                                                                          1
                                                                      ? AppLocalizations.of(context)!.msgStatusRunning3
                                                                      : AppLocalizations.of(context)!.request2,
                                                          style: TextStyle(
                                                              color: reversedList?[
                                                                              index]
                                                                          .status ==
                                                                      0
                                                                  ? ColorConstant
                                                                      .red500
                                                                  : reversedList?[index]
                                                                              .status ==
                                                                          2
                                                                      ? ColorConstant
                                                                          .maingreen
                                                                      : reversedList?[index].status ==
                                                                              1
                                                                          ? Colors
                                                                              .amber
                                                                          : ColorConstant
                                                                              .orangeA200,
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ]))),
                              ),
                            ],
                          );
              },
              error: (e, s) =>
                  Container(child: Text(e.toString() + s.toString())),
              loading: () => defaultLoader()),
          onRefresh: () async {
            return Future(() => ref.invalidate(addMoneySummaryProvider));
          }),
    );
  }
}
