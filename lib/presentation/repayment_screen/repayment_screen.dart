import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/string.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/repayment_screen/service/repayment_service.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:diagonal_decoration/diagonal_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/helper.dart';
import '../../core/utils/progress_dialog_utils.dart';
import '../../core/utils/theme/app_style.dart';
import '../../widgets/dailogs/error.dart';
import 'model/repayment_model.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class RepaymentScreen extends ConsumerStatefulWidget {
  const RepaymentScreen({super.key});

  @override
  ConsumerState<RepaymentScreen> createState() => _RepaymentScreenState();
}

class _RepaymentScreenState extends ConsumerState<RepaymentScreen> {
  var panelController = StateProvider((ref) => PanelController());
  var commodityList = StateProvider<List<Datum?>>((ref) => []);
  var stackWiseList = StateProvider((ref) => []);
  var stackList = StateProvider<List<Datum>?>((ref) => []);
  var totalPayableAmountProvider = StateProvider((ref) => 0.00);
  var warehouseIdProvider = StateProvider<String?>((ref) => '0');
  var commodityIdProvider = StateProvider<String?>((ref) => '0');
  var currencyFormat = NumberFormat.currency(
    locale: 'HI',
    symbol: '\u{20B9}',
    decimalDigits: 2,
  );

  var warehouseProvider = StateProvider<Datum?>((ref) => null);
  var stackProvider = StateProvider<Datum?>((ref) => null);
  var commodityProvider = StateProvider<Datum?>((ref) => null);

  var outStandingId = StateProvider<String?>((ref) => '0');
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(userDetailsProvider);
      ref.invalidate(repaymentTerminalsProvider());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ColorConstant.maingreen,
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.msgRepayment,
            style: AppStyle.lblAppbar,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop();
              CallLaunch('tel:7733901154');
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(Icons.call, color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: ColorConstant.bgcolor,
      body: ref.watch(userDetailsProvider).when(
            data: (userData) => ref.watch(repaymentTerminalsProvider()).when(
                  data: (data) {
                    return SlidingUpPanel(
                      controller: ref.watch(panelController),
                      minHeight: 0.0,
                      maxHeight: 170,
                      parallaxEnabled: true,
                      panelBuilder: () => ref.watch(stackWiseList).isEmpty
                          ? SizedBox()
                          : Card(
                              margin: Pad.zero,
                              elevation: 5,
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: ColorConstant.maingreen,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                    ),
                                    child: RowSuper(
                                      fill: true,
                                      fitHorizontally: true,
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!
                                              .msgPayableammount,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Adaptive.sp(16),
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          currencyFormat.format(
                                            ref.watch(
                                              totalPayableAmountProvider,
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Adaptive.sp(16),
                                            color: ColorConstant.maingreen,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  RowSuper(
                                    fill: true,
                                    fitHorizontally: true,
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      // Text(
                                      //   AppLocalizations.of(
                                      //     context,
                                      //   )!
                                      //       .msgWalletBalance,
                                      //   style: TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize: Adaptive.sp(16),
                                      //     color: Colors.black,
                                      //   ),
                                      //   textAlign: TextAlign.center,
                                      // ),
                                      // Text(
                                      //   currencyFormat.format(
                                      //     userData.userDetails?.power
                                      //         .toString()
                                      //         .convertToDouble(
                                      //           defaultValue: 0.00,
                                      //         ),
                                      //   ),
                                      //   style: TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize: Adaptive.sp(16),
                                      //     color: ColorConstant.maingreen,
                                      //   ),
                                      //   textAlign: TextAlign.center,
                                      // ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () async {
                                      // print(cont.stackWiseListId.length);
                                      for (int i = 0;
                                          i < ref.watch(stackWiseList).length;
                                          i++) {
                                        if (i == 0) {
                                          ref
                                              .watch(
                                                outStandingId.notifier,
                                              )
                                              .state = ref
                                              .watch(
                                                stackWiseList,
                                              )[i]
                                              .toString();
                                        } else {
                                          ref
                                                  .watch(
                                                    outStandingId.notifier,
                                                  )
                                                  .state =
                                              "${ref.watch(outStandingId)},${ref.watch(stackWiseList)[i].toString()}";
                                        }
                                      }

                                      // =  ref.watch(stackWiseList).single;
                                      await ref
                                          .watch(
                                        repaymentSettlementProvider(
                                          totalSettlementAmount: ref
                                              .watch(
                                                totalPayableAmountProvider,
                                              )
                                              .toString(),
                                          settlementId: ref.watch(
                                            outStandingId,
                                          ),
                                        ).future,
                                      )
                                          .then((value) async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();

                                        if (value.status == "1") {
                                          if (ref
                                              .watch(
                                                panelController,
                                              )
                                              .isPanelOpen) {
                                            ref
                                                .watch(
                                                  panelController,
                                                )
                                                .close();
                                          }
                                          ref.invalidate(
                                            userDetailsProvider,
                                          );
                                          ref.invalidate(
                                            settlementListProvider,
                                          );
                                          ref.invalidate(
                                            stackWiseList,
                                          );
                                          ref.invalidate(
                                            totalPayableAmountProvider,
                                          );

                                          Get.rawSnackbar(
                                            message: value.message,
                                            duration: Duration(
                                              seconds: 2,
                                            ),
                                            backgroundColor:
                                                ColorConstant.maingreen,
                                          );
                                          // Get.offAll(() => DashboardScreen());
                                          ref.invalidate(
                                            stackWiseList,
                                          );
                                        } else {
                                          ref.invalidate(
                                            totalPayableAmountProvider,
                                          );
                                          Get.rawSnackbar(
                                            message: value.message,
                                            duration: Duration(
                                              seconds: 2,
                                            ),
                                            backgroundColor:
                                                ColorConstant.red500,
                                          );
                                        }
                                      }).onError((e, s) {
                                        Get.rawSnackbar(
                                          message: "Server Error",
                                          duration: Duration(
                                            seconds: 2,
                                          ),
                                          backgroundColor: ColorConstant.red500,
                                        );
                                      });
                                    },
                                    child: Container(
                                      height: 46,
                                      margin: Pad(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.maingreen,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!
                                              .msgPaynow,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      body: Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 8.0,
                        ),
                        child: Stack(
                          children: [
                            ListView(
                              padding: Pad(bottom: 250),
                              primary: true,
                              children: [
                                Container(
                                  decoration: MatrixDecoration(
                                    lineColor: ColorConstant.maingreen,
                                    backgroundColor: Colors.white,
                                    radius: Radius.circular(20),
                                    lineCount: 50,
                                    lineWidth: 1,
                                  ),
                                  child: ColumnSuper(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: RowSuper(
                                          fill: true,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Text(
                                                //   AppLocalizations.of(
                                                //     context,
                                                //   )!
                                                //       .msgWalletbalance,
                                                //   textAlign: TextAlign.center,
                                                //   softWrap: true,
                                                //   style: TextStyle(
                                                //     fontWeight:
                                                //         FontWeight.bold,
                                                //     fontSize: Adaptive.sp(
                                                //       16,
                                                //     ),
                                                //     color: Colors.black,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .mstOutstandingamount3,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Adaptive.sp(16),
                                                      color: Colors.black,
                                                    ),
                                                    textAlign:
                                                        TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .msgPendingamount,
                                                  // softWrap: true,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      RowSuper(
                                        fill: true,
                                        children: [
                                          // Text(
                                          //   currencyFormat.format(
                                          //     userData.userDetails?.power
                                          //         .toString()
                                          //         .convertToDouble(
                                          //           defaultValue: 0.00,
                                          //         ),
                                          //   ),
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //     fontWeight: FontWeight.bold,
                                          //     fontSize: Adaptive.sp(16),
                                          //     color: Colors.black,
                                          //   ),
                                          // ),
                                          Text(
                                            currencyFormat.format(
                                              data.settlement?.outstanding
                                                  .toString()
                                                  .convertToDouble(),
                                            ),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Adaptive.sp(16),
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            currencyFormat.format(
                                              double.parse(
                                                        (userData.userDetails
                                                                    ?.power ??
                                                                0.00)
                                                            .toString(),
                                                      ) -
                                                      double.parse(
                                                        data.settlement
                                                                ?.outstanding ??
                                                            "0.0",
                                                      ) ??
                                                  0,
                                            ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Adaptive.sp(16),
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: RowSuper(
                                          fill: true,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .msgRealamount,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  currencyFormat.format(
                                                    data.settlement
                                                        ?.rentAmount
                                                        .toString()
                                                        .convertToDouble(),
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                    fontWeight:
                                                        FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .msgLoanamount,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  currencyFormat.format(
                                                    data.settlement
                                                        ?.loanAmount
                                                        .toString()
                                                        .convertToDouble(),
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                    fontWeight:
                                                        FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .msgInterestamount,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  currencyFormat.format(
                                                    data.settlement
                                                        ?.interestAmount
                                                        .toString()
                                                        .convertToDouble(),
                                                  ),
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Adaptive.w(100),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          border: Border.all(),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<Datum>(
                                            isExpanded: true,
                                            value: ref.watch(
                                              warehouseProvider,
                                            ),
                                            icon: Padding(
                                              padding: EdgeInsets.only(
                                                right: 5,
                                              ),
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                              ),
                                            ),
                                            hint: Center(
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!
                                                    .msgTerminalname,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Adaptive.sp(16),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            items: List.generate(
                                              data.data?.length ?? 0,
                                              (index) => DropdownMenuItem(
                                                alignment: AlignmentDirectional
                                                    .topStart,
                                                value: data.data?[index],
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Radio(
                                                        value:
                                                            data.data?[index],
                                                        groupValue: ref.watch(
                                                          warehouseProvider,
                                                        ),
                                                        onChanged: (value) {
                                                          ref
                                                              .read(
                                                                warehouseProvider
                                                                    .notifier,
                                                              )
                                                              .state = value;
                                                        },
                                                        activeColor:
                                                            ColorConstant
                                                                .maingreen,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${data.data?[index].warehouseName}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Adaptive.sp(
                                                              16,
                                                            ),
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onChanged: (val) async {
                                              if (ref
                                                      .watch(
                                                        panelController,
                                                      )
                                                      .isPanelOpen &&
                                                  ref
                                                      .watch(stackWiseList)
                                                      .isEmpty) {
                                                ref
                                                    .watch(panelController)
                                                    .close();
                                              }
                                              ref.invalidate(stackWiseList);
                                              ref.invalidate(stackList);
                                              ref.invalidate(commodityList);
                                              ref.invalidate(
                                                commodityProvider,
                                              );
                                              ref.invalidate(stackProvider);
                                              ref.invalidate(
                                                totalPayableAmountProvider,
                                              );
                                              ref
                                                  .watch(
                                                    warehouseProvider.notifier,
                                                  )
                                                  .state = val;

                                              await ref
                                                  .watch(
                                                repaymentTerminalsProvider(
                                                  terminalId: ref
                                                      .watch(
                                                        warehouseProvider,
                                                      )
                                                      ?.warehouseId
                                                      .toString(),
                                                  commodityId:
                                                      "${ref.watch(commodityProvider)?.commodity}",
                                                  type: "commodity",
                                                ).future,
                                              )
                                                  .then((value) {
                                                if (value.data != null) {
                                                  ref
                                                      .watch(
                                                        commodityList.notifier,
                                                      )
                                                      .state = value.data!;
                                                }
                                                ref
                                                    .watch(
                                                      stackProvider.notifier,
                                                    )
                                                    .state = null;
                                              }).onError((e, s) {
                                                errorBottomSheet(
                                                  context,
                                                  e.toString(),
                                                );
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      ref.watch(warehouseProvider) != null
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ref
                                                      .watch(
                                                        repaymentCommodityProvider(
                                                          terminalId: ref
                                                                  .watch(
                                                                    warehouseProvider,
                                                                  )
                                                                  ?.warehouseId
                                                                  .toString() ??
                                                              "",
                                                          type: "commodity",
                                                        ),
                                                      )
                                                      .when(
                                                        data: (
                                                          commodities,
                                                        ) =>
                                                            Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                  8,
                                                                ),
                                                              ),
                                                              border:
                                                                  Border.all(),
                                                            ),
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton<
                                                                      Datum>(
                                                                isExpanded:
                                                                    true,
                                                                value:
                                                                    ref.watch(
                                                                  commodityProvider,
                                                                ),
                                                                icon: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    right: 5,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                  ),
                                                                ),
                                                                hint: Center(
                                                                  child: Text(
                                                                    AppLocalizations
                                                                            .of(
                                                                      context,
                                                                    )!
                                                                        .msgCommodityy3,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          Adaptive
                                                                              .sp(
                                                                        16,
                                                                      ),
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                items: List
                                                                    .generate(
                                                                  commodities
                                                                          .data
                                                                          ?.length ??
                                                                      0,
                                                                  (
                                                                    index,
                                                                  ) =>
                                                                      DropdownMenuItem(
                                                                    alignment:
                                                                        AlignmentDirectional
                                                                            .topStart,
                                                                    value: commodities
                                                                            .data?[
                                                                        index],
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Radio(
                                                                            value:
                                                                                commodities.data?[index],
                                                                            groupValue:
                                                                                ref.watch(
                                                                              commodityProvider,
                                                                            ),
                                                                            onChanged:
                                                                                (
                                                                              value,
                                                                            ) {
                                                                              ref
                                                                                  .watch(
                                                                                    commodityProvider.notifier,
                                                                                  )
                                                                                  .state = value;
                                                                            },
                                                                            activeColor:
                                                                                ColorConstant.maingreen,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              "${commodities.data?[index].category}",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: Adaptive.sp(
                                                                                  16,
                                                                                ),
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onChanged: (
                                                                  val,
                                                                ) {
                                                                  if (ref
                                                                          .watch(
                                                                            panelController,
                                                                          )
                                                                          .isPanelOpen &&
                                                                      ref
                                                                          .watch(
                                                                            stackWiseList,
                                                                          )
                                                                          .isEmpty) {
                                                                    ref
                                                                        .watch(
                                                                          panelController,
                                                                        )
                                                                        .close();
                                                                  }
                                                                  ref.invalidate(
                                                                    stackWiseList,
                                                                  );
                                                                  ref.invalidate(
                                                                    stackList,
                                                                  );
                                                                  ref.invalidate(
                                                                    stackProvider,
                                                                  );
                                                                  ref.invalidate(
                                                                    totalPayableAmountProvider,
                                                                  );

                                                                  ref
                                                                          .watch(
                                                                            commodityProvider.notifier,
                                                                          )
                                                                          .state =
                                                                      val;

                                                                  ref
                                                                          .watch(
                                                                            warehouseIdProvider.notifier,
                                                                          )
                                                                          .state =
                                                                      val?.warehouseId
                                                                          .toString();
                                                                  ref
                                                                          .watch(
                                                                            commodityIdProvider.notifier,
                                                                          )
                                                                          .state =
                                                                      val?.commodity
                                                                          .toString();
                                                                  ref
                                                                      .watch(
                                                                    repaymentTerminalsProvider(
                                                                      terminalId: ref
                                                                          .watch(
                                                                            warehouseIdProvider,
                                                                          )
                                                                          ?.toString(),
                                                                      commodityId: ref
                                                                          .watch(
                                                                            commodityIdProvider,
                                                                          )
                                                                          ?.toString(),
                                                                      type:
                                                                          "stacks",
                                                                    ).future,
                                                                  )
                                                                      .then((
                                                                    value,
                                                                  ) {
                                                                    if (value
                                                                            .data !=
                                                                        null) {
                                                                      ref
                                                                          .watch(
                                                                            stackList.notifier,
                                                                          )
                                                                          .state = value.data;
                                                                    }
                                                                  }).onError((
                                                                    e,
                                                                    s,
                                                                  ) {
                                                                    errorBottomSheet(
                                                                      context,
                                                                      e.toString(),
                                                                    );
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        error: (e, s) =>
                                                            Container(),
                                                        loading: () =>
                                                            _dropDownloadLoader(),
                                                      ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      ref.watch(commodityProvider) != null
                                          ? ref
                                              .watch(
                                                repaymentStacksProvider(
                                                  type: 'stacks',
                                                  terminalId: ref
                                                          .watch(
                                                            warehouseProvider,
                                                          )
                                                          ?.warehouseId
                                                          .toString() ??
                                                      "",
                                                  commodityId: ref
                                                          .watch(
                                                            commodityProvider,
                                                          )
                                                          ?.commodity
                                                          .toString() ??
                                                      "",
                                                ),
                                              )
                                              .when(
                                                data: (stacks) => Container(
                                                  width: Adaptive.w(
                                                    100,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    border: Border.all(),
                                                  ),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton<Datum>(
                                                      isExpanded: true,
                                                      value: ref.watch(
                                                        stackProvider,
                                                      ),
                                                      icon: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          right: 5,
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                        ),
                                                      ),
                                                      hint: Center(
                                                        child: Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!
                                                              .msgStackno,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Adaptive.sp(
                                                              16,
                                                            ),
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      items: List.generate(
                                                        stacks.data?.length ??
                                                            0,
                                                        (
                                                          index,
                                                        ) =>
                                                            DropdownMenuItem(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .topStart,
                                                          value: stacks
                                                              .data?[index],
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 10,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Radio(
                                                                  value: stacks
                                                                          .data?[
                                                                      index],
                                                                  groupValue:
                                                                      ref.watch(
                                                                    stackProvider,
                                                                  ),
                                                                  onChanged: (
                                                                    value,
                                                                  ) {
                                                                    ref
                                                                            .watch(
                                                                              stackProvider.notifier,
                                                                            )
                                                                            .state =
                                                                        value;
                                                                  },
                                                                  activeColor:
                                                                      ColorConstant
                                                                          .maingreen,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "${stacks.data?[index].stackNo}",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          Adaptive
                                                                              .sp(
                                                                        16,
                                                                      ),
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onChanged: (val) {
                                                        if (ref
                                                                .watch(
                                                                  panelController,
                                                                )
                                                                .isPanelOpen &&
                                                            ref
                                                                .watch(
                                                                  stackWiseList,
                                                                )
                                                                .isEmpty) {
                                                          ref
                                                              .watch(
                                                                panelController,
                                                              )
                                                              .close();
                                                        }
                                                        ref.invalidate(
                                                          totalPayableAmountProvider,
                                                        );
                                                        ref
                                                            .watch(
                                                              stackProvider
                                                                  .notifier,
                                                            )
                                                            .state = val;

                                                        ref.invalidate(
                                                          settlementListProvider(),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                error: (e, s) => Container(),
                                                loading: () =>
                                                    _dropDownloadLoader(),
                                              )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                ref.watch(stackProvider) == null
                                    ? Container()
                                    : ref
                                        .watch(
                                          settlementListProvider(
                                            terminalId: ref
                                                .watch(
                                                  warehouseProvider,
                                                )
                                                ?.warehouseId
                                                .toString(),
                                            stackNumber: ref
                                                .watch(stackProvider)
                                                ?.stackNo
                                                .toString(),
                                            commodityId: ref
                                                .watch(
                                                  commodityProvider,
                                                )
                                                ?.commodity
                                                .toString(),
                                          ),
                                        )
                                        .when(
                                          data: (data) => ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: Pad(
                                              bottom: MediaQuery.of(
                                                context,
                                              ).padding.bottom,
                                            ),
                                            shrinkWrap: true,
                                            itemCount: data.data?.length,
                                            itemBuilder: (
                                              context,
                                              index,
                                            ) =>
                                                InkWell(
                                              onTap: () {
                                                if (ref
                                                    .watch(
                                                      stackWiseList,
                                                    )
                                                    .contains(
                                                      data.data?[index].id,
                                                    )) {
                                                  ref
                                                      .watch(
                                                        stackWiseList,
                                                      )
                                                      .remove(
                                                        data.data?[index].id,
                                                      );

                                                  if (ref
                                                      .watch(
                                                        stackWiseList,
                                                      )
                                                      .isEmpty) {
                                                    ref
                                                        .watch(
                                                          totalPayableAmountProvider
                                                              .notifier,
                                                        )
                                                        .state = 0.00;
                                                  } else {
                                                    ref
                                                        .watch(
                                                          totalPayableAmountProvider
                                                              .notifier,
                                                        )
                                                        .state -= double.parse(
                                                      data.data?[index]
                                                              .outstanding ??
                                                          "0.0",
                                                    );
                                                  }
                                                  if (ref
                                                          .watch(
                                                            panelController,
                                                          )
                                                          .isPanelOpen &&
                                                      ref
                                                          .watch(
                                                            stackWiseList,
                                                          )
                                                          .isEmpty) {
                                                    ref
                                                        .watch(
                                                          panelController,
                                                        )
                                                        .close();
                                                  }
                                                } else {
                                                  if ((double.parse(
                                                        '${data.data?[index].outstanding}',
                                                      ) ==
                                                      0.0)) {
                                                    context.errorToast(
                                                      'Repayment already completed',
                                                    );
                                                    return;
                                                  }
                                                  // if ((double.parse(
                                                  //           '${userData.userDetails?.power ?? 0}',
                                                  //         ) <
                                                  //         double.parse(
                                                  //           '${data.data?[index].outstanding}',
                                                  //         ) ||
                                                  //     (double.parse(
                                                  //           '${ref.watch(totalPayableAmountProvider)}',
                                                  //         ) >
                                                  //         double.parse(
                                                  //           '${userData.userDetails?.power ?? 0}',
                                                  //         )))) {
                                                  //   context.errorToast(
                                                  //     'Repayment Amount cant be greater than wallet amount',
                                                  //   );

                                                  //   return;
                                                  // }

                                                  else {
                                                    ref
                                                        .watch(
                                                          stackWiseList
                                                              .notifier,
                                                        )
                                                        .state = [
                                                      ...ref.watch(
                                                        stackWiseList,
                                                      ),
                                                      int.parse(
                                                        "${data.data?[index].id ?? ""}",
                                                      ),
                                                    ];
                                                    // ref.watch(stackWiseList).add(data.data?[index].id.toString().toInt());
                                                    ref
                                                        .watch(
                                                          totalPayableAmountProvider
                                                              .notifier,
                                                        )
                                                        .state += double.parse(
                                                      data.data?[index]
                                                              .outstanding ??
                                                          "0.0",
                                                    );
                                                  }

                                                  ref
                                                      .watch(
                                                        panelController,
                                                      )
                                                      .open();
                                                }
                                              },
                                              child: Container(
                                                margin: Pad(
                                                  horizontal: 10,
                                                  vertical: 10,
                                                ),
                                                padding: Pad(
                                                  horizontal: 10,
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: (index % 2 == 0)
                                                      ? Color(
                                                          0xffebebeb,
                                                        )
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8,
                                                  ),
                                                  border: Border.all(
                                                    width: 1.5,
                                                    color: ref
                                                            .watch(
                                                              stackWiseList,
                                                            )
                                                            .contains(
                                                              data.data?[index]
                                                                  .id,
                                                            )
                                                        ? ColorConstant
                                                            .maingreen
                                                        : Colors.transparent,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    IntrinsicHeight(
                                                      child: RowSuper(
                                                        fill: true,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RowSuper(
                                                                fitHorizontally:
                                                                    true,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations
                                                                            .of(
                                                                      context,
                                                                    )!
                                                                        .msgGatepass,
                                                                    style: AppStyle
                                                                        .mystokedetail,
                                                                  ),
                                                                  Text(
                                                                    '${data.data?[index].gatePassWr}',
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              RowSuper(
                                                                fitHorizontally:
                                                                    true,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations
                                                                            .of(
                                                                      context,
                                                                    )!
                                                                        .msgStackno,
                                                                    style: AppStyle
                                                                        .mystokedetail,
                                                                  ),
                                                                  Text(
                                                                    "${data.data?[index].stackNo}",
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              RowSuper(
                                                                fitHorizontally:
                                                                    true,
                                                                children: [
                                                                  Text(
                                                                    "${AppLocalizations.of(context)!.msgQuantity} : ",
                                                                    style: AppStyle
                                                                        .mystokedetail,
                                                                  ),
                                                                  Text(
                                                                    "${data.data?[index].quantity}",
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              RowSuper(
                                                                fitHorizontally:
                                                                    true,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations
                                                                            .of(
                                                                      context,
                                                                    )!
                                                                        .msgBags,
                                                                    style: AppStyle
                                                                        .mystokedetail,
                                                                  ),
                                                                  Text(
                                                                    "${data.data?[index].bags}",
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          VerticalDivider(
                                                            color:
                                                                Colors.blueGrey,
                                                            thickness: 1,

                                                            // width: 5,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RowSuper(
                                                                fitHorizontally:
                                                                    true,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations
                                                                            .of(
                                                                      context,
                                                                    )!
                                                                        .msgOutstandingt,
                                                                    style: AppStyle
                                                                        .mystokedetail,
                                                                  ),
                                                                  Text(
                                                                    "${data.data?[index].outstanding}",
                                                                    // cont.repaymentModel!.settlement!.outstanding.toString(),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              RowSuper(
                                                                fitHorizontally:
                                                                    true,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations
                                                                            .of(
                                                                      context,
                                                                    )!
                                                                        .msgRent,
                                                                    style: AppStyle
                                                                        .mystokedetail,
                                                                  ),
                                                                  Text(
                                                                    "${data.data?[index].rentAmount}",
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              RowSuper(
                                                                fitHorizontally:
                                                                    true,
                                                                children: [
                                                                  Text(
                                                                    "${AppLocalizations.of(context)!.msgLoan} : ",
                                                                    style: AppStyle
                                                                        .mystokedetail,
                                                                  ),
                                                                  Text(
                                                                    "${data.data?[index].loanAmount}",
                                                                    // cont.repaymentModel!.settlement!.loanAmount.toString(),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              RowSuper(
                                                                fitHorizontally:
                                                                    true,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations
                                                                            .of(
                                                                      context,
                                                                    )!
                                                                        .msgInterst,
                                                                    style: AppStyle
                                                                        .mystokedetail,
                                                                  ),
                                                                  Text(
                                                                    '${data.data?[index].interestAmount}',
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          VerticalDivider(
                                                            color:
                                                                Colors.blueGrey,
                                                            thickness: 1,
                                                            // width: 5,
                                                          ),
                                                          double.parse(
                                                                    data.data?[index]
                                                                            .settlmentAmount ??
                                                                        "0.0",
                                                                  ) ==
                                                                  0.0
                                                              ? Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .done,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    color: Colors
                                                                        .green,
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {
                                                                    // cont.bankChangeIndex(
                                                                    //      index);

                                                                    if (ref
                                                                        .watch(
                                                                          stackWiseList,
                                                                        )
                                                                        .contains(
                                                                          data.data?[index]
                                                                              .id,
                                                                        )) {
                                                                      ref
                                                                          .watch(
                                                                            stackWiseList,
                                                                          )
                                                                          .remove(
                                                                            data.data?[index].id,
                                                                          );

                                                                      if (ref
                                                                          .watch(
                                                                            stackWiseList,
                                                                          )
                                                                          .isEmpty) {
                                                                        ref
                                                                            .watch(
                                                                              totalPayableAmountProvider.notifier,
                                                                            )
                                                                            .state = 0.00;
                                                                      } else {
                                                                        ref
                                                                            .watch(
                                                                              totalPayableAmountProvider.notifier,
                                                                            )
                                                                            .state -= double.parse(
                                                                          data.data?[index].outstanding ??
                                                                              "0.0",
                                                                        );
                                                                      }
                                                                      if (ref
                                                                              .watch(
                                                                                panelController,
                                                                              )
                                                                              .isPanelOpen &&
                                                                          ref
                                                                              .watch(
                                                                                stackWiseList,
                                                                              )
                                                                              .isEmpty) {
                                                                        ref
                                                                            .watch(
                                                                              panelController,
                                                                            )
                                                                            .close();
                                                                      }
                                                                    } else {
                                                                      if ((double
                                                                              .parse(
                                                                            '${data.data?[index].outstanding}',
                                                                          ) ==
                                                                          0.0)) {
                                                                        context
                                                                            .errorToast(
                                                                          'Repayment already completed',
                                                                        );
                                                                        return;
                                                                      }
                                                                      // if ((double.parse(
                                                                      //           '${userData.userDetails?.power ?? 0}',
                                                                      //         ) <
                                                                      //         double.parse(
                                                                      //           '${data.data?[index].outstanding}',
                                                                      //         ) ||
                                                                      //     (double.parse(
                                                                      //           '${ref.watch(totalPayableAmountProvider)}',
                                                                      //         ) >
                                                                      //         double.parse(
                                                                      //           '${userData.userDetails?.power ?? 0}',
                                                                      //         )))) {
                                                                      //   context
                                                                      //       .errorToast(
                                                                      //     'Repayment Amount cant be greater than wallet amount',
                                                                      //   );

                                                                      //   return;
                                                                      // }

                                                                      else {
                                                                        ref
                                                                            .watch(
                                                                              stackWiseList.notifier,
                                                                            )
                                                                            .state = [
                                                                          ...ref
                                                                              .watch(
                                                                            stackWiseList,
                                                                          ),
                                                                          int.parse(
                                                                            "${data.data?[index].id ?? ""}",
                                                                          ),
                                                                        ];
                                                                        // ref.watch(stackWiseList).add(data.data?[index].id.toString().toInt());
                                                                        ref
                                                                            .watch(
                                                                              totalPayableAmountProvider.notifier,
                                                                            )
                                                                            .state += double.parse(
                                                                          data.data?[index].outstanding ??
                                                                              "0.0",
                                                                        );
                                                                      }

                                                                      ref
                                                                          .watch(
                                                                            panelController,
                                                                          )
                                                                          .open();
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 18,
                                                                    width: 18,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: ColorConstant
                                                                            .maingreen,
                                                                        width:
                                                                            1.5,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            14,
                                                                        color: ref
                                                                                .watch(
                                                                                  stackWiseList,
                                                                                )
                                                                                .contains(
                                                                                  data.data?[index].id,
                                                                                )
                                                                            ? ColorConstant.maingreen
                                                                            : Colors.transparent,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          error: (e, s) => Container(),
                                          loading: () => _stacksLoader(),
                                        ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  error: (e, s) => noStockData(context),
                  loading: () => _repaymentLoader(),
                ),
            error: (e, s) => Container(),
            loading: () => _repaymentLoader(),
          ),
    );
  }

  _repaymentLoader() => Skeletonizer(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Stack(
            children: [
              ListView(
                padding: Pad(bottom: 250),
                primary: true,
                children: [
                  Container(
                    child: Container(
                      decoration: MatrixDecoration(
                        lineColor: ColorConstant.maingreen,
                        backgroundColor: Colors.white,
                        radius: Radius.circular(20),
                        lineCount: 50,
                        lineWidth: 1,
                      ),
                      child: ColumnSuper(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: RowSuper(
                              fill: true,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Text(
                                    //   AppLocalizations.of(
                                    //     context,
                                    //   )!
                                    //       .msgWalletbalance,
                                    //   textAlign: TextAlign.center,
                                    //   softWrap: true,
                                    //   style: TextStyle(
                                    //     fontWeight: FontWeight.bold,
                                    //     fontSize: Adaptive.sp(16),
                                    //     color: Colors.black,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .mstOutstandingamount3,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(16),
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!
                                          .msgPendingamount,
                                      // softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(16),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          RowSuper(
                            fill: true,
                            children: [
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: RowSuper(
                              fill: true,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .msgRealamount,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(16),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .msgLoanamount,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(16),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!
                                          .msgInterestamount,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(16),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(16),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: Column(
                      children: [
                        _dropDownloadLoader(),
                        _dropDownloadLoader(),
                        _dropDownloadLoader(),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  _stacksLoader(),
                ],
              ),
            ],
          ),
        ),
      );

  _stacksLoader() => Skeletonizer(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: Pad(bottom: MediaQuery.of(context).padding.bottom),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) => InkWell(
            onTap: () {},
            child: Container(
              margin: Pad(horizontal: 10, vertical: 10),
              padding: Pad(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: (index % 2 == 0) ? Color(0xffebebeb) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1.5, color: Colors.transparent),
              ),
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: RowSuper(
                      fill: true,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowSuper(
                              fitHorizontally: true,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgGatepass,
                                  style: AppStyle.mystokedetail,
                                ),
                                Text('Loading'),
                              ],
                            ),
                            SizedBox(height: 4),
                            RowSuper(
                              fitHorizontally: true,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgStackno,
                                  style: AppStyle.mystokedetail,
                                ),
                                Text("Loading"),
                              ],
                            ),
                            SizedBox(height: 4),
                            RowSuper(
                              fitHorizontally: true,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.msgQuantity} : ",
                                  style: AppStyle.mystokedetail,
                                ),
                                Text("Loading"),
                              ],
                            ),
                            SizedBox(height: 4),
                            RowSuper(
                              fitHorizontally: true,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgBags,
                                  style: AppStyle.mystokedetail,
                                ),
                                Text("Loading"),
                              ],
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.blueGrey,
                          thickness: 1,

                          // width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowSuper(
                              fitHorizontally: true,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .mstOutstandingamount3,
                                  style: AppStyle.mystokedetail,
                                ),
                                Text(
                                  "Loading",
                                  // cont.repaymentModel!.settlement!.outstanding.toString(),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            RowSuper(
                              fitHorizontally: true,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgRent,
                                  style: AppStyle.mystokedetail,
                                ),
                                Text("Loading"),
                              ],
                            ),
                            SizedBox(height: 4),
                            RowSuper(
                              fitHorizontally: true,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.msgLoan} : ",
                                  style: AppStyle.mystokedetail,
                                ),
                                Text(
                                  "Loading",
                                  // cont.repaymentModel!.settlement!.loanAmount.toString(),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            RowSuper(
                              fitHorizontally: true,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgInterst,
                                  style: AppStyle.mystokedetail,
                                ),
                                Text('Loading'),
                              ],
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.blueGrey,
                          thickness: 1,
                          // width: 5,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstant.maingreen,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  _dropDownloadLoader() => Skeletonizer(
        child: CommonTextField(hintText: "Loading...", label: "Loading..."),
      );
}
