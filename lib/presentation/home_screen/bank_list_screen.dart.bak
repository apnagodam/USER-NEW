// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/commodity_finance/finance_bank_screen.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/stock_response_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/progress_dialog_utils.dart';
import '../../widgets/dailogs/error.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class LoanApply extends ConsumerStatefulWidget {
  final inventorryID;
  final quantity;
  final loanAmount;
  final String mandibav;
  final List<Bank> bankList;

  const LoanApply(
      {super.key,
      required this.inventorryID,
      required this.quantity,
      required this.loanAmount,
      required this.mandibav,
      required this.bankList});

  @override
  ConsumerState<LoanApply> createState() => _Apply_for_loanState();
}

class _Apply_for_loanState extends ConsumerState<LoanApply> {
  var finalAmount = 0.0;
  var approx_deal_amount = 0.0;
  var approx_loan_amount = 0.0;
  bool show = false;
  String? gender;
  var sanctionamunt;
  var usebankId;
  var loanpertotalAmount;

  @override
  Widget build(BuildContext context) {
    var bankList = widget.bankList.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.maingreen,
        // automaticallyImplyLeading: true,
        title: Text(
          AppLocalizations.of(context)!.msgApplyloan,
          style: AppStyle.lblAppbar,
        ),
        centerTitle: true,
      ),
      body: ref.watch(userDetailsProvider).when(
          data: (userData) => ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 3.0, right: 3.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ColorConstant.maingreen,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.msgChoosebank,
                          style: AppStyle.lblviewbtnwithdraw,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: bankList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 10, bottom: 10.0),
                            child: Container(
                                foregroundDecoration: double.parse(
                                            bankList[index]
                                                .sanctionLimit
                                                .toString()) >
                                        0
                                    ? RotatedCornerDecoration.withColor(
                                        color: ColorConstant.maingreen,
                                        badgePosition: BadgePosition.bottomEnd,
                                        badgeCornerRadius: Radius.circular(8),
                                        spanBaselineShift: 5,
                                        spanHorizontalOffset: 2,
                                        textDirection: TextDirection.ltr,
                                        badgeShadow: BadgeShadow(
                                            color: Colors.black, elevation: 4),
                                        badgeSize: Size(
                                            Adaptive.sp(35), Adaptive.sp(35)),
                                        textSpan: TextSpan(
                                          text: 'Sanctioned',
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16)),
                                        ),
                                      )
                                    : null,
                                padding: EdgeInsets.fromLTRB(5, 8, 8, 5),
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
                                child: Column(
                                  children: [
                                    RowSuper(
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!
                                                .msgBankname,
                                            style: TextStyle(
                                                color: ColorConstant.maingreen,
                                                fontWeight: FontWeight.w700,
                                                fontSize: Adaptive.sp(16))),
                                        Text("${bankList[index].bankName}",
                                            style: TextStyle(
                                                color: ColorConstant.maingreen,
                                                fontWeight: FontWeight.w700,
                                                fontSize: Adaptive.sp(16)))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    IntrinsicHeight(
                                        child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: ColumnSuper(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Text.rich(TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .msgProcessing,
                                                style: AppStyle.bankliststl
                                                    .copyWith(
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                children: [
                                                  TextSpan(
                                                      text: bankList[index]
                                                          .processingFee
                                                          .toString())
                                                ])),
                                            Text.rich(TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .msgLoanpertotal,
                                                style: AppStyle.bankliststl
                                                    .copyWith(
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                children: [
                                                  TextSpan(
                                                      text: bankList[index]
                                                          .loanPerTotalAmount
                                                          .toString())
                                                ])),
                                            Text.rich(TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .msgApr,
                                                style: AppStyle.bankliststl
                                                    .copyWith(
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                children: [
                                                  TextSpan(
                                                      text: bankList[index]
                                                          .apr
                                                          .toString())
                                                ])),
                                            Text.rich(TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .msgTenor,
                                                style: AppStyle.bankliststl
                                                    .copyWith(
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                children: [
                                                  TextSpan(
                                                      text: bankList[index]
                                                          .tenor
                                                          .toString())
                                                ])),
                                          ],
                                        )),
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: VerticalDivider(
                                            color: Colors.blueGrey,
                                            thickness: 1,
                                            width: 1,
                                          ),
                                        ),
                                        Expanded(
                                            child: ColumnSuper(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Text.rich(TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .msgInterestrate,
                                                style: AppStyle.bankliststl
                                                    .copyWith(
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                children: [
                                                  TextSpan(
                                                      text: bankList[index]
                                                          .interestRate
                                                          .toString())
                                                ])),
                                            Text.rich(TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .msgDisbursement,
                                                style: AppStyle.bankliststl
                                                    .copyWith(
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                children: [
                                                  TextSpan(
                                                      text: bankList[index]
                                                          .loanPassDays
                                                          .toString())
                                                ])),
                                            Text.rich(TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .msgSanctioned,
                                                style: AppStyle.bankliststl
                                                    .copyWith(
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                children: [
                                                  TextSpan(
                                                      text: intl.NumberFormat
                                                              .currency(
                                                                  locale: 'HI',
                                                                  symbol:
                                                                      '\u{20B9}',
                                                                  decimalDigits:
                                                                      2)
                                                          .format(num.parse(bankList[
                                                                      index]
                                                                  .sanctionLimit
                                                                  .toString() ??
                                                              "0.0")))
                                                ])),
                                          ],
                                        )),
                                        InkWell(
                                          onTap: () {
                                            ref
                                                .watch(
                                                    bankIndexProvider.notifier)
                                                .state = index;
                                            usebankId =
                                                bankList[index].id.toString();
                                            loanpertotalAmount = bankList[index]
                                                .loanPerTotalAmount
                                                .toString();
                                            ref
                                                .watch(bankIdProvider.notifier)
                                                .state = bankList[
                                                    index]
                                                .id
                                                .toString();

                                            sanctionamunt = bankList[index]
                                                .sanctionLimit
                                                .toString();

                                            approx_deal_amount = double.parse(
                                                    widget.quantity
                                                                .toString() ==
                                                            ""
                                                        ? "0.0"
                                                        : widget.quantity) *
                                                double.parse(
                                                    widget.mandibav.isEmpty
                                                        ? "0.0"
                                                        : widget.mandibav);
                                            approx_loan_amount = (double.parse(
                                                        widget.quantity
                                                                    .toString() ==
                                                                ""
                                                            ? "0.0"
                                                            : widget.quantity) *
                                                    double.parse(widget
                                                            .mandibav.isEmpty
                                                        ? "0.0"
                                                        : widget.mandibav)) *
                                                (double.parse(bankList[index]
                                                                .loanPerTotalAmount
                                                                .toString() ==
                                                            ""
                                                        ? "0.0"
                                                        : bankList[index]
                                                            .loanPerTotalAmount
                                                            .toString()) /
                                                    100);

                                            setState(() {});
                                          },
                                          child: Container(
                                            height: Adaptive.sp(17),
                                            width: Adaptive.sp(17),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  width: 1.5),
                                            ),
                                            child: Center(
                                                child: Icon(
                                              Icons.check,
                                              size: Adaptive.sp(16),
                                              color: ref.watch(
                                                          bankIndexProvider) ==
                                                      index
                                                  ? ColorConstant.maingreen
                                                  : Colors.transparent,
                                            )),
                                          ),
                                        )
                                      ],
                                    )),
                                  ],
                                )));
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  if (ref.watch(bankIdProvider) != null)
                    ref
                        .watch(financeTermDataProvider(
                          bankId: ref.watch(bankIdProvider).toString(),
                          inventoryId: widget.inventorryID.toString(),
                        ))
                        .when(
                            data: (financeData) {
                              return ColumnSuper(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: ColorConstant.maingreen),
                                          color: Colors.orangeAccent.shade100
                                              .withOpacity(0.5),
                                        ),
                                        child: Column(
                                          children: [
                                            IntrinsicHeight(
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: ColumnSuper(
                                                          children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .msgMandiBhav,
                                                          style: AppStyle
                                                              .lblonbordingp
                                                              .copyWith(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        Text(
                                                          widget.mandibav,
                                                          style: AppStyle
                                                              .lblonbordingp
                                                              .copyWith(
                                                            fontSize:
                                                                Adaptive.sp(16),
                                                          ),
                                                        ),
                                                      ])),
                                                  VerticalDivider(
                                                    color: Colors.blueGrey,
                                                    thickness: 2,
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                      child: ColumnSuper(
                                                          children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .msgQuantity,
                                                          style: AppStyle
                                                              .lblonbordingp
                                                              .copyWith(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          '${widget.quantity ?? ""}',
                                                          style: AppStyle
                                                              .lblonbordingp
                                                              .copyWith(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ])),
                                                ],
                                              ),
                                            ),
                                            Divider(color: Colors.grey),
                                            IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: ColumnSuper(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .msgApproxdeal,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .lblonbordingp
                                                            .copyWith(
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                        16),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      Text(
                                                        intl.NumberFormat.currency(
                                                                locale: 'HI',
                                                                symbol:
                                                                    '\u{20B9}',
                                                                decimalDigits:
                                                                    2)
                                                            .format(num.parse(
                                                                approx_deal_amount
                                                                        .toString() ??
                                                                    "0.0")),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .lblonbordingp
                                                            .copyWith(
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                        16)),
                                                      )
                                                    ],
                                                  )),
                                                  VerticalDivider(
                                                    color: Colors.blueGrey,
                                                    thickness: 2,
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                      child: ColumnSuper(
                                                    children: [
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .msgApproxloan,
                                                          style: AppStyle
                                                              .lblonbordingp
                                                              .copyWith(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                      Text(
                                                          intl.NumberFormat.currency(
                                                                  locale: 'HI',
                                                                  symbol:
                                                                      '\u{20B9}',
                                                                  decimalDigits:
                                                                      2)
                                                              .format(num.parse(
                                                                  approx_loan_amount
                                                                          .toString() ??
                                                                      "0.0")),
                                                          style: AppStyle
                                                              .lblonbordingp
                                                              .copyWith(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16))),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ),
                                            if (financeData.data != null) ...[
                                              Column(
                                                children: [
                                                  Divider(color: Colors.grey),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: ColumnSuper(
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .msgProcessing,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                                16),
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                              ),
                                                              Text(
                                                                intl.NumberFormat.currency(
                                                                        locale:
                                                                            'HI',
                                                                        symbol:
                                                                            '\u{20B9}',
                                                                        decimalDigits:
                                                                            2)
                                                                    .format(num.parse(financeData
                                                                            .data
                                                                            ?.processingFess ??
                                                                        "0.0")),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Adaptive.sp(16)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          color:
                                                              Colors.blueGrey,
                                                          thickness: 2,
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child: ColumnSuper(
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .msgNetpayableamount,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                                16),
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                              ),
                                                              Text(
                                                                intl.NumberFormat.currency(
                                                                        locale:
                                                                            'HI',
                                                                        symbol:
                                                                            '\u{20B9}',
                                                                        decimalDigits:
                                                                            2)
                                                                    .format(num.parse(financeData
                                                                            .data
                                                                            ?.netPayment ??
                                                                        "0.0")),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Adaptive.sp(16)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(color: Colors.grey),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: ColumnSuper(
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .cgst,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                                16),
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                              ),
                                                              Text(
                                                                "${financeData.data?.cgst}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Adaptive.sp(16)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          color:
                                                              Colors.blueGrey,
                                                          thickness: 2,
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child: ColumnSuper(
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .sgst,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: AppStyle
                                                                      .lblonbordingp
                                                                      .copyWith(
                                                                          fontSize: Adaptive.sp(
                                                                              16),
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                ),
                                                                Text(
                                                                  "${financeData.data?.sgst}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: AppStyle
                                                                      .lblonbordingp
                                                                      .copyWith(
                                                                          fontSize:
                                                                              Adaptive.sp(16)),
                                                                )
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(color: Colors.grey),
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      // mainAxisAlignment:
                                                      // MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: ColumnSuper(
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .msgNetpayableamount,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                                16),
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                              ),
                                                              Text(
                                                                intl.NumberFormat.currency(
                                                                        locale:
                                                                            'HI',
                                                                        symbol:
                                                                            '\u{20B9}',
                                                                        decimalDigits:
                                                                            2)
                                                                    .format(num.parse(financeData
                                                                            .data
                                                                            ?.netPayment ??
                                                                        "0.0")),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Adaptive.sp(16)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          color:
                                                              Colors.blueGrey,
                                                          thickness: 2,
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                            child: SizedBox()),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio(
                                        fillColor: WidgetStateColor.resolveWith(
                                            (states) =>
                                                ColorConstant.maingreen),
                                        value: "other",
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value.toString();
                                          });
                                        },
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.account,
                                        style: AppStyle.lblonbordingp.copyWith(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text.rich(
                                          TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .msgBankname,
                                              children: [
                                                TextSpan(
                                                    text:
                                                        ' ${userData.userDetails?.bankName}')
                                              ]),
                                          style: AppStyle.lblonbordingp
                                              .copyWith(
                                                  fontSize: Adaptive.sp(16)))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text.rich(
                                          TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .accountnu,
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '  ${userData.userDetails?.bankAccNo} ')
                                              ]),
                                          style: AppStyle.lblonbordingp
                                              .copyWith(
                                                  fontSize: Adaptive.sp(16)))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text.rich(
                                          TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .ifscCode,
                                              children: [
                                                TextSpan(
                                                    text:
                                                        ' ${userData.userDetails?.bankIfscCode}')
                                              ]),
                                          style: AppStyle.lblonbordingp
                                              .copyWith(
                                                  fontSize: Adaptive.sp(16)))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (sanctionamunt == "0") {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  AppLocalizations.of(context)!
                                                      .msgAlert,
                                                  style: TextStyle(
                                                      fontSize: Adaptive.sp(17),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                content: Text(
                                                  AppLocalizations.of(context)!
                                                      .msgNosufficient,
                                                  style: AppStyle.lblonbordingp
                                                      .copyWith(
                                                          fontSize:
                                                              Adaptive.sp(16)),
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .msgCencel,
                                                            style: TextStyle(
                                                                color: ColorConstant
                                                                    .maingreen,
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                        16)),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.to(
                                                                FinanceBank());
                                                          },
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .msgOk,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                        16),
                                                                color: ColorConstant
                                                                    .maingreen),
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      } else {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();

                                        ref
                                            .watch(applyForLoanProvider(
                                                    inventoryId:
                                                        widget.inventorryID,
                                                    bankId: usebankId,
                                                    quantity: widget.quantity,
                                                    loanAmount:
                                                        loanpertotalAmount,
                                                    disbursement: 'Own Account')
                                                .future)
                                            .then((value) {
                                          if (value["status"] == "1") {
                                            ref.invalidate(myStockProvider);

                                            Get.rawSnackbar(
                                                message: value["message"],
                                                duration: Duration(seconds: 10),
                                                backgroundColor:
                                                    ColorConstant.maingreen);
                                            Get.off(DashboardScreen());
                                          } else {
                                            Get.rawSnackbar(
                                                message: value["message"],
                                                duration: Duration(seconds: 10),
                                                backgroundColor:
                                                    ColorConstant.maingreen);
                                          }
                                        }).onError((e, s) {
                                          errorBottomSheet(context, "$e");
                                        });

                                        // Get.to(ApplyLoanHtmlDataViewer(
                                        //   htmlData: financeData.view ?? "",
                                        //   bnakId: usebankId,
                                        //   loanperAmount: loanpertotalAmount,
                                        //   quantity: widget.quantity,
                                        //   inventoryId: widget.inventorryID,
                                        // ));
                                      }
                                    },
                                    child: Container(
                                      // height: 20,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.maingreen,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                            top: 8.0,
                                            bottom: 8.0),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .msgApplyloan,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                            error: (e, s) => Container(),
                            loading: () => defaultLoader()),
                ],
              ),
          error: (e, s) => Container(),
          loading: () => defaultLoader()),
    );
  }

  var bankIdProvider = StateProvider<String?>((ref) => null);

  var bankIndexProvider = StateProvider<int?>((ref) => null);

  var financeHtmlData = StateProvider((ref) => "");
}
