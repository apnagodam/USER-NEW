import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/fillter_commandialog.dart';
import '../../core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class LoanFinance extends ConsumerStatefulWidget {
  const LoanFinance({super.key});

  @override
  ConsumerState<LoanFinance> createState() => _LoanFinanceState();
}

class _LoanFinanceState extends ConsumerState<LoanFinance> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //loanController!.removeListener(_scrollListener);
    super.dispose();
  }

  TextEditingController loanfillertcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: ColorConstant.maingreen,
          title: Text(
            AppLocalizations.of(context)!.loan,
            style: AppStyle.lblAppbar,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  showAlertDialog(context, AppLocalizations.of(context)!.search,
                      "", loanfillertcontroller, "LoanFinance", ref);
                },
                child: Icon(
                  Icons.filter_alt_rounded,
                  color: CupertinoColors.white,
                ),
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            ref.watch(apnaFinanceListProvider()).when(
                data: (data) => (data.finances?.data ?? []).isEmpty
                    ? noStockData(context)
                    : ListView.builder(
                        itemCount: data.finances?.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(bottom: 3.0),
                              decoration: BoxDecoration(
                                color: (index % 2 == 0)
                                    ? ColorConstant.mainlistgrayclr
                                    : Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IntrinsicHeight(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  data.finances?.data?[index]
                                                          .caseId ??
                                                      '',
                                                  // cont.wareHouseData[index].id.toString(),
                                                  style: AppStyle.aplayforloan
                                                      .copyWith(fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: ColorConstant.listdivaderclr,
                                            width: 10,
                                            thickness: 2,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                data.finances?.data?[index]
                                                        .category ??
                                                    '',
                                                // cont.wareHouseData[index].category.toString(),
                                                style: AppStyle
                                                    .lblontestimonalname,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: ColorConstant.listdivaderclr,
                                            width: 10,
                                            thickness: 2,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                data.finances?.data?[index]
                                                        .name ??
                                                    '',
                                                // cont.wareHouseData[index].fname.toString(),
                                                style: AppStyle
                                                    .lblontestimonalname,
                                                textAlign: TextAlign.center,
                                                maxLines: 3,
                                              ),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: ColorConstant.listdivaderclr,
                                            width: 10,
                                            thickness: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (BuildContext
                                                                    context) =>
                                                                Center(
                                                                  child: Wrap(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            AlertDialog(
                                                                          surfaceTintColor:
                                                                              Colors.white,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                          titlePadding:
                                                                              EdgeInsets.zero,
                                                                          insetPadding:
                                                                              EdgeInsets.zero,
                                                                          contentPadding:
                                                                              EdgeInsets.zero,
                                                                          content:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(5.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(6))),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        InkWell(
                                                                                          onTap: () {
                                                                                            Get.back();
                                                                                          },
                                                                                          child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                shape: BoxShape.circle,
                                                                                                color: Colors.red,
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsets.all(4.0),
                                                                                                child: Icon(
                                                                                                  Icons.close_outlined,
                                                                                                  color: Colors.white,
                                                                                                ),
                                                                                              )),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.caseid,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            data.finances?.data?[index].caseId ?? "",
                                                                                            // cont.wareHouseData[index].id.toString(),
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.msgTerminalname,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            data.finances?.data?[index].name ?? '',
                                                                                            // cont.wareHouseData[index].fname.toString(),
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.loanFrom,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            data.finances?.data?[index].loanBankName ?? "",
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.msgCommodity,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            data.finances?.data?[index].category.toString() ?? "",
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.requestQuantityLoan,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            "${data.finances?.data?[index].quantity ?? 0.0}",
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.msgRequestamount,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            "${data.finances?.data?[index].valueOfCommodity ?? 0.0}",
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.processingFeeLoan,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            "${data.finances?.data?[index].processingFee ?? 0.0}",
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.interestRateLoan,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            "${data.finances?.data?[index].interestRate ?? 0.0}",
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.laonPerTotalLoan,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            "${data.finances?.data?[index].loanPerTotalAmount ?? 0.0}",
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.laonPassDaysLoan,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            "${data.finances?.data?[index].loanPassDays ?? 0.0}",
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                    IntrinsicHeight(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            AppLocalizations.of(context)!.requsetDateLoan,
                                                                                            style: AppStyle.lbleyepopup,
                                                                                          )),
                                                                                          Expanded(
                                                                                            child: VerticalDivider(
                                                                                              width: 5,
                                                                                              thickness: 1,
                                                                                              color: ColorConstant.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                              child: Text(
                                                                                            "${data.finances?.data?[index].createdAt}",
                                                                                            style: AppStyle.lbleyepopupsecond,
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Divider(color: Colors.grey),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ));
                                                  },
                                                  child: Icon(
                                                    Icons.remove_red_eye,
                                                    color:
                                                        ColorConstant.maingreen,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        }),
                error: (e, s) => Text(e.toString() + s.toString()),
                loading: () => defaultLoader()),
            Visibility(
                visible: ref.watch(loanPageProvider) > 1,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                      onPressed: () {
                        if (ref.watch(loanLastPageProvider) >= 1) {
                          ref.watch(loanPageProvider.notifier).state =
                              ref.watch(loanPageProvider.notifier).state - 1;
                        }
                      },
                      icon: Icon(
                        Icons.arrow_circle_left,
                        size: Adaptive.sp(25),
                        color: ColorConstant.maingreen,
                      )),
                )),
            Visibility(
                visible: ref.watch(loanPageProvider) <=
                        ref.watch(loanLastPageProvider) &&
                    ref.watch(loanLastPageProvider) > 1,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {
                        if (ref.watch(loanLastPageProvider) > 1) {
                          ref.watch(loanPageProvider.notifier).state =
                              ref.watch(loanPageProvider.notifier).state + 1;
                        }
                      },
                      icon: Icon(
                        Icons.arrow_circle_right_sharp,
                        size: Adaptive.sp(25),
                        color: ColorConstant.maingreen,
                      )),
                ))
          ],
        ));
  }
}

var loanSearchProvider = StateProvider((ref) => '');
var loanPageProvider = StateProvider((ref) => 1);
var loanCurrentPageProvider = StateProvider((ref) => 1);
var loanLastPageProvider = StateProvider((ref) => 1);
