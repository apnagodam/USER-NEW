import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/credit/apply_for_bnpl.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/widgets/dailogs/error.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen/kyc.dart';
import '../splash_screen/splash_screen.dart';
import 'bnpl_summary.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

var currencyFormat =
    NumberFormat.currency(locale: 'HI', symbol: '\u{20B9}', decimalDigits: 2);

class Credit extends ConsumerWidget {
  Credit({super.key});

  final TextEditingController bnplrequestAmountController =
      TextEditingController();
  final selectedTabIndex = StateProvider((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.maingreen,
        title: Text(
          AppLocalizations.of(context)!.bnpl,
          style: AppStyle.lblAppbar,
        ),
        centerTitle: true,
        actions: [],
      ),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                        6.0,
                      )),
                  child: TabBar(
                      onTap: (index) {
                        ref.watch(selectedTabIndex.notifier).state = index;
                      },
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorConstant.maingreen,
                      ),
                      tabs: [
                        Tab(
                          child: FittedBox(
                            child: Text(
                              AppLocalizations.of(context)!.msgBnpl,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Tab(
                          child: FittedBox(
                            child: Text(
                              AppLocalizations.of(context)!.msgSummary,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              ref.watch(authProvider).when(
                  data: (data) => Expanded(
                          child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                            data == AuthStatus.loggedOut
                                ? Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                            'assets/images/mainlogopng.png',
                                            height: 150,
                                            width: 150),
                                        simpleButton(
                                            text: 'Login to apply for bnpl',
                                            callback: () {
                                              showLoginBottomsheet(context);
                                            }),
                                      ],
                                    ),
                                  )
                                : ref.watch(userDetailsProvider).when(
                                    data: (userData) =>
                                        RefreshIndicator.adaptive(
                                            child: ListView(
                                              children: [
                                                Container(
                                                    alignment: Alignment.center,
                                                    padding: Pad(all: 10),
                                                    width: Get.width,
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 4,
                                                                right: 4),
                                                        child: ColumnSuper(
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .balance,
                                                                style: AppStyle
                                                                    .lblsummary
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                                18),
                                                                        color: Colors
                                                                            .black),
                                                              ),
                                                              Text(
                                                                currencyFormat
                                                                    .format(userData
                                                                            .userDetails
                                                                            ?.bnplPower ??
                                                                        0.0),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Adaptive.h(
                                                                            5),
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text.rich(
                                                                TextSpan(
                                                                    text:
                                                                        AppLocalizations.of(context)!.limit2,
                                                                    children: [
                                                                      TextSpan(
                                                                        text: currencyFormat.format(userData
                                                                            .userDetails
                                                                            ?.bnplPowerLimit
                                                                            .toString()
                                                                            .convertToDouble()),
                                                                      )
                                                                    ]),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                            16)),
                                                                softWrap: true,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              ElevatedButton(
                                                                  style: AppStyle
                                                                      .buttonStyle,
                                                                  onPressed:
                                                                      () async {
                                                                    bnplrequestAmountController
                                                                        .clear();

                                                                    if (!ref
                                                                        .watch(
                                                                            sharedUtilityProvider)
                                                                        .isKycComplete()) {
                                                                      Get.to(
                                                                          KYC(
                                                                        kyctag:
                                                                            "bnpl",
                                                                      ));
                                                                    } else {
                                                                      Get.to(
                                                                          ApplyforBNPL());
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .apply,
                                                                    style: AppStyle
                                                                        .lblsellnbuy,
                                                                  )),
                                                            ]))),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Divider(
                                                  color: Colors.grey,
                                                  indent: 7,
                                                  endIndent: 6,
                                                ),
                                                Padding(
                                                  padding: Pad(all: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Recent Transactions",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize:
                                                              Adaptive.sp(16)),
                                                    ),
                                                  ),
                                                ),
                                                ref.watch(bnplListProvider).when(
                                                    data: (data) => data.data!.isEmpty
                                                        ? noStockData()
                                                        : RefreshIndicator.adaptive(
                                                            child: ListView.builder(
                                                                physics: NeverScrollableScrollPhysics(),
                                                                shrinkWrap: true,
                                                                itemCount: data.data?.length,
                                                                itemBuilder: (BuildContext context, int index) {
                                                                  // var date = DateFormat('dd-MM-yyyy').format(DateTime.parse(cont.bnplrequestList[index].approvedDate.toString()));
                                                                  return Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 6,
                                                                        right:
                                                                            6,
                                                                        bottom:
                                                                            6),
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      children: [
                                                                        Card(
                                                                          surfaceTintColor:
                                                                              Colors.white,
                                                                          color:
                                                                              Colors.white,
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              side: BorderSide(color: ColorConstant.maingreen)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                Pad(all: 10),
                                                                            child:
                                                                                ColumnSuper(
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    data.data?[index].approvedDate == null
                                                                                        ? SizedBox()
                                                                                        : Text(
                                                                                            DateFormat('dd-MM-yyyy').format(DateTime.parse(data.data?[index].approvedDate ?? "")),
                                                                                            style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                  ],
                                                                                ),
                                                                                RowSuper(
                                                                                  fill: true,
                                                                                  children: [
                                                                                    ColumnSuper(
                                                                                      alignment: Alignment.centerLeft,
                                                                                      children: [
                                                                                        Text(
                                                                                          AppLocalizations.of(context)!.msgRequestamount,
                                                                                          style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                        Text(
                                                                                          AppLocalizations.of(context)!.msgApprovedamount,
                                                                                          style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    ColumnSuper(
                                                                                      alignment: Alignment.centerRight,
                                                                                      children: [
                                                                                        Text(
                                                                                          currencyFormat.format(double.parse("${data.data?[index].requestedAmount ?? "0.0"}")),
                                                                                          style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                        Text(
                                                                                          currencyFormat.format(double.parse("${data.data?[index].approvedAmount ?? "0.0"}")),
                                                                                          style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                ColumnSuper(
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          AppLocalizations.of(context)!.msgInterestrate,
                                                                                          style: TextStyle(fontFamily: 'Roboto', fontSize: Adaptive.sp(16)),
                                                                                        ),
                                                                                        Text("${data.data?[index].interestRate}", style: TextStyle(fontFamily: 'Roboto', fontSize: Adaptive.sp(16))),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Text(AppLocalizations.of(context)!.usedamount, style: TextStyle(fontFamily: 'Roboto', fontSize: Adaptive.sp(16))),
                                                                                        Text(': ${currencyFormat.format(double.parse("${data.data?[index].usedAmount ?? "0.0"}"))}', style: TextStyle(fontFamily: 'Roboto', fontSize: Adaptive.sp(16))),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      data.data?[index].status == 0
                                                                                          ? AppLocalizations.of(context)!.msgStatusRejected
                                                                                          : data.data?[index].status == 1
                                                                                              ? AppLocalizations.of(context)!.progress
                                                                                              : data.data?[index].status == 2
                                                                                                  ? AppLocalizations.of(context)!.msgStatusApproved
                                                                                                  : data.data?[index].status == 3
                                                                                                      ? AppLocalizations.of(context)!.msgStatusApproved
                                                                                                      : data.data?[index].status == 4
                                                                                                          ? AppLocalizations.of(context)!.msgStatusApproved
                                                                                                          : "",
                                                                                      style: TextStyle(
                                                                                          color: data.data?[index].status == 0
                                                                                              ? Colors.red
                                                                                              : data.data?[index].status == 1
                                                                                                  ? Colors.yellow
                                                                                                  : data.data?[index].status == 2
                                                                                                      ? Colors.blue
                                                                                                      : data.data?[index].status == 3
                                                                                                          ? ColorConstant.maingreen
                                                                                                          : data.data?[index].status == 4
                                                                                                              ? ColorConstant.maingreen
                                                                                                              : ColorConstant.maingreen,
                                                                                          fontSize: Adaptive.sp(16),
                                                                                          fontWeight: FontWeight.w700),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        data.data?[index].status ==
                                                                                1
                                                                            ? InkWell(
                                                                                onTap: () async {
                                                                                  await ref.watch(bnplDeleteRequestProvider(id: data.data?[index].id.toString()).future).then((value) async {
                                                                                    if (value['status'] == 1) {
                                                                                      Get.rawSnackbar(message: value["message"].toString(), duration: Duration(seconds: 10), backgroundColor: ColorConstant.maingreen);
                                                                                      ref.invalidate(bnplListProvider);
                                                                                    } else if (value['status'] == 0) {
                                                                                      Get.rawSnackbar(message: value["message"].toString(), duration: Duration(seconds: 10), backgroundColor: ColorConstant.red500);
                                                                                    } else {
                                                                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                      prefs.setBool("isLogin", false);
                                                                                      Get.offAll(() => SplashScreen());
                                                                                      Get.rawSnackbar(message: value["message"], duration: Duration(seconds: 10), backgroundColor: ColorConstant.red500);
                                                                                    }
                                                                                  }).onError((e, s) {
                                                                                    errorBottomSheet(context, "$e");
                                                                                  });
                                                                                },
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(),
                                                                                  child: Container(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                      color: Colors.red.shade900,
                                                                                    ),
                                                                                    child: Icon(
                                                                                      Icons.close,
                                                                                      color: Colors.white,
                                                                                      size: 13,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : SizedBox(),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                            onRefresh: () {
                                                              return Future.value(
                                                                  (_) => ref
                                                                      .invalidate(
                                                                          bnplListProvider));
                                                            }),
                                                    error: (e, s) => noStockData(),
                                                    loading: () => defaultLoader()),
                                              ],
                                            ),
                                            onRefresh: () {
                                              return Future.value((_) => ref
                                                  .watch(userDetailsProvider));
                                            }),
                                    error: (e, s) => noStockData(),
                                    loading: () => defaultLoader()),
                            data == AuthStatus.loggedOut
                                ? Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                            'assets/images/mainlogopng.png',
                                            height: 150,
                                            width: 150),
                                        simpleButton(
                                            text: 'Login to see transactions',
                                            callback: () {
                                              showLoginBottomsheet(context);
                                            }),
                                      ],
                                    ),
                                  )
                                : BnplSummaryScreen()
                          ])),
                  error: (e, s) => Container(),
                  loading: () => Container()),
            ],
          )),
    );
  }
}
