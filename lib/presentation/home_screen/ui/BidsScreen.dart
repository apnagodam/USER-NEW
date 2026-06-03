import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/GstProfile/GstProfileScreen.dart';
import 'package:apnagodam/presentation/add_money_screen/add_money_screen.dart';
import 'package:apnagodam/presentation/credit/credit_screen.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/home_screen/kyc.dart';
import 'package:apnagodam/presentation/home_screen/ui/Tradewalletscreen.dart';
import 'package:apnagodam/presentation/market_screen/buy_sell_data_screen.dart';
import 'package:apnagodam/presentation/market_screen/buyer_list_screen.dart';
import 'package:apnagodam/presentation/market_screen/market_screen.dart';
import 'package:apnagodam/presentation/market_screen/seller_list_screen.dart';
import 'package:apnagodam/presentation/market_screen/service/market_service.dart';
import 'package:apnagodam/presentation/sbt/DispatchRequests/DispatchRequestScreen.dart';
import 'package:apnagodam/presentation/sbt/DispatchRequests/DispatchRequestsListing.dart';
import 'package:apnagodam/presentation/sbt/SbtDeals.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackinward_screen.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Bidsscreen extends ConsumerStatefulWidget {
  const Bidsscreen({super.key});

  @override
  ConsumerState<Bidsscreen> createState() => _BidsscreenState();
}

class _BidsscreenState extends ConsumerState<Bidsscreen> {
  var terminalId = "";
  var buyKey = GlobalKey<FormState>();
  var sellKey = GlobalKey<FormState>();

  var indexOfTradingScreens = StateProvider((ref) => 0);

  var chartDataList = StateProvider<List<ChartData>?>((ref) => []);

  var buyPrice = StateProvider<double>((ref) => 0.0);
  var buyWeight = StateProvider<double>((ref) => 0.0);

  var updatePriceProvider = StateProvider<double>((ref) => 0.0);
  var updateWeightProvider = StateProvider<double>((ref) => 0.0);

  var sellPrice = StateProvider<double>((ref) => 0.0);
  var sellWeight = StateProvider<double>((ref) => 0.0);
  var selectedIndex = StateProvider<int?>((ref) => null);

  var tabIndexProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(getSbtCommodityProvider)
        .when(
          data: (data) {
            var dataList = (data.data ?? []).reversed.toList().take(3).toList();
            return (dataList).isEmpty
                ? SizedBox(child: noStockData(context), height: Get.height / 2)
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int mainIndex) {
                    return (dataList).isEmpty
                        ? noStockData(context)
                        : InkWell(
                          onTap: () async {
                            // Get.to();
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder:
                                  (sheetContext) => Consumer(
                                    builder:
                                        (
                                          context,
                                          ref,
                                          child,
                                        ) => ElevarmDraggableBottomSheet(
                                          initialChildSize: 1,
                                          title:
                                              '${dataList[mainIndex].commodity} - ${dataList[mainIndex].district.toString()} ',
                                          subtitle:
                                              '${AppLocalizations.of(context)!.msgBuyerBest}  ${currencyFormat.format(dataList[mainIndex].bestBuyer.toString().convertToDouble(defaultValue: 0.00))}   ${AppLocalizations.of(context)!.msgSellerBest} ${currencyFormat.format(dataList[mainIndex].bestSeller.toString().convertToDouble(defaultValue: 0.00))}',
                                          onPressedClose: () {
                                            Navigator.of(sheetContext).pop();
                                          },
                                          children: [
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 10,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        if (ref
                                                                .watch(
                                                                  authProvider,
                                                                )
                                                                .value ==
                                                            AuthStatus
                                                                .loggedIn) {
                                                          ref
                                                              .watch(
                                                                buyPrice
                                                                    .notifier,
                                                              )
                                                              .state = double.parse(
                                                            '${dataList[mainIndex ?? 0].lowerCircuit}',
                                                          );

                                                          ref
                                                              .watch(
                                                                buyWeight
                                                                    .notifier,
                                                              )
                                                              .state = 0.0;

                                                          showBarModalBottomSheet(
                                                            context: context,
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                    top:
                                                                        Radius.circular(
                                                                          10.0,
                                                                        ),
                                                                  ),
                                                            ),
                                                            builder: (
                                                              bottomsheetContext,
                                                            ) {
                                                              return Form(
                                                                key: buyKey,
                                                                child: Padding(
                                                                  padding: Pad(
                                                                    bottom:
                                                                        MediaQuery.of(
                                                                          context,
                                                                        ).viewInsets.bottom,
                                                                  ),
                                                                  child: Padding(
                                                                    padding: Pad(
                                                                      all: 10,
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                            top:
                                                                                12.0,
                                                                            bottom:
                                                                                7.0,
                                                                          ),
                                                                          child: Center(
                                                                            child: Text(
                                                                              "Buy",
                                                                              style: TextStyle(
                                                                                fontSize: Adaptive.sp(
                                                                                  17,
                                                                                ),
                                                                                fontWeight:
                                                                                    FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                          thickness:
                                                                              1,
                                                                        ),
                                                                        Center(
                                                                          child: Padding(
                                                                            padding: EdgeInsets.only(
                                                                              bottom:
                                                                                  8.0,
                                                                            ),
                                                                            child: Text.rich(
                                                                              TextSpan(
                                                                                text:
                                                                                    "Product",
                                                                                style: TextStyle(
                                                                                  fontSize: Adaptive.sp(
                                                                                    16,
                                                                                  ),
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                ),
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text:
                                                                                        " : ${data.data?[mainIndex ?? 0].commodity} (${data.data?[mainIndex ?? 0].district})",
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        RowSuper(
                                                                          fill:
                                                                              true,
                                                                          children: [
                                                                            // Text.rich(TextSpan(
                                                                            //     text: "Commodity: ",
                                                                            //     style: TextStyle(
                                                                            //         fontSize:
                                                                            //             Adaptive.sp(
                                                                            //                 16),
                                                                            //         fontWeight:
                                                                            //             FontWeight
                                                                            //                 .bold),
                                                                            //     children: [
                                                                            //       TextSpan(
                                                                            //           text:
                                                                            //               "${widget.dataList?[widget.index ?? 0].commodity}",
                                                                            //           style: TextStyle(
                                                                            //               fontSize:
                                                                            //                   Adaptive.sp(
                                                                            //                       16),
                                                                            //               fontFamily:
                                                                            //                   'Roboto',
                                                                            //               color: ColorConstant
                                                                            //                   .maingreen,
                                                                            //               fontWeight:
                                                                            //                   FontWeight
                                                                            //                       .bold))
                                                                            //     ])),
                                                                            Text.rich(
                                                                              TextSpan(
                                                                                text:
                                                                                    "Date: ",
                                                                                style: TextStyle(
                                                                                  fontSize: Adaptive.sp(
                                                                                    16,
                                                                                  ),
                                                                                  fontFamily:
                                                                                      'Roboto',
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                ),
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text:
                                                                                        "${dataList[mainIndex ?? 0].date}",
                                                                                    style: TextStyle(
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      fontFamily:
                                                                                          'Roboto',
                                                                                      color:
                                                                                          ColorConstant.maingreen,
                                                                                      fontWeight:
                                                                                          FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Divider(),
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(
                                                                                bottom:
                                                                                    5.0,
                                                                              ),
                                                                              child: Text(
                                                                                AppLocalizations.of(
                                                                                  context,
                                                                                )!.msgYourprice,
                                                                                style: TextStyle(
                                                                                  fontSize: Adaptive.sp(
                                                                                    16,
                                                                                  ),
                                                                                  fontFamily:
                                                                                      'Roboto',
                                                                                  color:
                                                                                      ColorConstant.maingreen,
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: Pad(
                                                                                all:
                                                                                    10,
                                                                              ),
                                                                              child: SizedBox(
                                                                                width:
                                                                                    Get.width,
                                                                                child: InputQty(
                                                                                  initVal:
                                                                                      dataList[mainIndex ??
                                                                                              0]
                                                                                          .lowerCircuit ??
                                                                                      0,
                                                                                  steps:
                                                                                      10,
                                                                                  onQtyChanged: (
                                                                                    val,
                                                                                  ) {
                                                                                    var number = num.parse(
                                                                                      "${val ?? 0.0}",
                                                                                    );
                                                                                    ref
                                                                                        .watch(
                                                                                          buyPrice.notifier,
                                                                                        )
                                                                                        .state = number.toDouble();
                                                                                  },
                                                                                  decoration: QtyDecorationProps(
                                                                                    border: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(
                                                                                        5,
                                                                                      ),
                                                                                      borderSide: BorderSide(
                                                                                        color:
                                                                                            ColorConstant.maingreen,
                                                                                      ),
                                                                                    ),
                                                                                    qtyStyle:
                                                                                        QtyStyle.classic,
                                                                                    minusBtn: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color:
                                                                                            ColorConstant.maingreen,
                                                                                        borderRadius: BorderRadius.circular(
                                                                                          5,
                                                                                        ),
                                                                                      ),
                                                                                      padding: Pad(
                                                                                        all:
                                                                                            10,
                                                                                      ),
                                                                                      child: Text(
                                                                                        '-10',
                                                                                        style: TextStyle(
                                                                                          fontWeight:
                                                                                              FontWeight.bold,
                                                                                          color:
                                                                                              Colors.white,
                                                                                          fontSize: Adaptive.sp(
                                                                                            17,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    plusBtn: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        color:
                                                                                            ColorConstant.maingreen,
                                                                                        borderRadius: BorderRadius.circular(
                                                                                          5,
                                                                                        ),
                                                                                      ),
                                                                                      padding: Pad(
                                                                                        all:
                                                                                            10,
                                                                                      ),
                                                                                      child: Text(
                                                                                        '+10',
                                                                                        style: TextStyle(
                                                                                          fontWeight:
                                                                                              FontWeight.bold,
                                                                                          color:
                                                                                              Colors.white,
                                                                                          fontSize: Adaptive.sp(
                                                                                            17,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                                  10,
                                                                            ),
                                                                            Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    bottom:
                                                                                        5.0,
                                                                                  ),
                                                                                  child: Text(
                                                                                    AppLocalizations.of(
                                                                                      context,
                                                                                    )!.msgNetweight,
                                                                                    style: TextStyle(
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      fontFamily:
                                                                                          'Roboto',
                                                                                      color:
                                                                                          ColorConstant.maingreen,
                                                                                      fontWeight:
                                                                                          FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: Pad(
                                                                                    all:
                                                                                        10,
                                                                                  ),
                                                                                  child: SizedBox(
                                                                                    width:
                                                                                        Get.width,
                                                                                    child: InputQty(
                                                                                      qtyFormProps: QtyFormProps(
                                                                                        keyboardType: TextInputType.numberWithOptions(
                                                                                          decimal:
                                                                                              false,
                                                                                        ),
                                                                                      ),
                                                                                      initVal:
                                                                                          0,
                                                                                      minVal:
                                                                                          1,
                                                                                      steps:
                                                                                          10,
                                                                                      onQtyChanged: (
                                                                                        val,
                                                                                      ) {
                                                                                        ref
                                                                                            .watch(
                                                                                              buyWeight.notifier,
                                                                                            )
                                                                                            .state = double.parse(
                                                                                          "${val ?? 0.0}",
                                                                                        );

                                                                                        print(
                                                                                          val,
                                                                                        );
                                                                                      },
                                                                                      decoration: QtyDecorationProps(
                                                                                        border: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.circular(
                                                                                            5,
                                                                                          ),
                                                                                          borderSide: BorderSide(
                                                                                            color:
                                                                                                ColorConstant.maingreen,
                                                                                          ),
                                                                                        ),
                                                                                        qtyStyle:
                                                                                            QtyStyle.classic,
                                                                                        minusBtn: Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color:
                                                                                                ColorConstant.maingreen,
                                                                                            borderRadius: BorderRadius.circular(
                                                                                              5,
                                                                                            ),
                                                                                          ),
                                                                                          padding: Pad(
                                                                                            all:
                                                                                                10,
                                                                                          ),
                                                                                          child: Text(
                                                                                            '-10',
                                                                                            style: TextStyle(
                                                                                              fontWeight:
                                                                                                  FontWeight.bold,
                                                                                              color:
                                                                                                  Colors.white,
                                                                                              fontSize: Adaptive.sp(
                                                                                                17,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        plusBtn: Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color:
                                                                                                ColorConstant.maingreen,
                                                                                            borderRadius: BorderRadius.circular(
                                                                                              5,
                                                                                            ),
                                                                                          ),
                                                                                          padding: Pad(
                                                                                            all:
                                                                                                10,
                                                                                          ),
                                                                                          child: Text(
                                                                                            '+10',
                                                                                            style: TextStyle(
                                                                                              fontWeight:
                                                                                                  FontWeight.bold,
                                                                                              color:
                                                                                                  Colors.white,
                                                                                              fontSize: Adaptive.sp(
                                                                                                17,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                            top:
                                                                                15,
                                                                          ),
                                                                          child: Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: ElevatedButton(
                                                                                  style: AppStyle.buttonStyle.copyWith(
                                                                                    backgroundColor: WidgetStatePropertyAll(
                                                                                      Colors.red,
                                                                                    ),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Get.back();
                                                                                  },
                                                                                  child: Text(
                                                                                    AppLocalizations.of(
                                                                                      context,
                                                                                    )!.msgCencel,
                                                                                    style: TextStyle(
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      fontFamily:
                                                                                          'Roboto',
                                                                                      fontWeight:
                                                                                          FontWeight.w500,
                                                                                      color:
                                                                                          Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width:
                                                                                    20,
                                                                              ),
                                                                              Expanded(
                                                                                child: ElevatedButton(
                                                                                  style:
                                                                                      AppStyle.buttonStyle,
                                                                                  onPressed: () async {
                                                                                    if (ref.watch(
                                                                                          buyPrice,
                                                                                        ) <
                                                                                        1) {
                                                                                      context.errorToast(
                                                                                        'Please input valid buying price',
                                                                                      );
                                                                                    } else {
                                                                                      if (ref.watch(
                                                                                            buyWeight,
                                                                                          ) >
                                                                                          0.0) {
                                                                                        if (buyKey.currentState!.validate()) {
                                                                                          _handleBuyOption(
                                                                                            dataList,
                                                                                            mainIndex,
                                                                                            bottomsheetContext,
                                                                                            ref.watch(
                                                                                              buyWeight,
                                                                                            ),
                                                                                            ref.watch(
                                                                                              buyPrice,
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                      } else {
                                                                                        Fluttertoast.showToast(
                                                                                          msg:
                                                                                              'Quantity should be greater than 0!',
                                                                                          toastLength:
                                                                                              Toast.LENGTH_LONG,
                                                                                          backgroundColor:
                                                                                              Colors.red,
                                                                                        );
                                                                                      }
                                                                                    }
                                                                                  },
                                                                                  child: Text(
                                                                                    AppLocalizations.of(
                                                                                      context,
                                                                                    )!.submit,
                                                                                    style: TextStyle(
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      fontFamily:
                                                                                          'Roboto',
                                                                                      fontWeight:
                                                                                          FontWeight.w500,
                                                                                      color:
                                                                                          Colors.white,
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
                                                              );
                                                            },
                                                          ).onError((e, s) {});
                                                        } else {
                                                          showLoginBottomsheet(
                                                            context,
                                                          );
                                                        }
                                                        // final result =
                                                        //     await Get.to(
                                                        //         Sbtdailog(
                                                        //   coomodityId:
                                                        //       "${data.data![index].commodity}",
                                                        //   type: type,
                                                        //   tagg: "",
                                                        // ));
                                                        // if (result !=
                                                        //     null) {
                                                        //   if (result) {
                                                        //     Navigator.pop(
                                                        //         context);
                                                        //     ref.invalidate(
                                                        //         getSbtCommodityProvider);
                                                        //     ref.invalidate(
                                                        //         getBuyerSellerListProvider);
                                                        //   }
                                                        // }
                                                      },
                                                      style: AppStyle.buttonStyle.copyWith(
                                                        backgroundColor:
                                                            WidgetStateProperty.resolveWith(
                                                              (states) =>
                                                                  ColorConstant
                                                                      .maingreen,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.msgBuy,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        if (ref
                                                                .watch(
                                                                  authProvider,
                                                                )
                                                                .value ==
                                                            AuthStatus
                                                                .loggedIn) {
                                                          if (ref
                                                                  .watch(
                                                                    sharedUtilityProvider,
                                                                  )
                                                                  .isKycComplete() ==
                                                              false) {
                                                            ElevarmConfirmAlertDialog(
                                                              title:
                                                                  'Profile Pending!',
                                                              subtitle:
                                                                  'Your Profile is currently pending, please complete it to start trading',
                                                              onPositiveButton:
                                                                  () {
                                                                    Get.to(
                                                                      KYC(
                                                                        kyctag:
                                                                            '',
                                                                      ),
                                                                    );
                                                                  },
                                                              onNegativeButton:
                                                                  () {
                                                                    Get.back();
                                                                  },
                                                              positiveText:
                                                                  'Complete Profile',
                                                              negativeText:
                                                                  'Not now',
                                                              variant:
                                                                  ElevarmDialogVariant
                                                                      .danger,
                                                            ).show(context);
                                                            Get.to(
                                                              Gstprofilescreen(),
                                                            );
                                                          } else {
                                                            ref
                                                                .watch(
                                                                  sellPrice
                                                                      .notifier,
                                                                )
                                                                .state = double.parse(
                                                              '${dataList[mainIndex ?? 0].lowerCircuit}',
                                                            );

                                                            ref
                                                                .watch(
                                                                  sellWeight
                                                                      .notifier,
                                                                )
                                                                .state = 0.0;

                                                            showBarModalBottomSheet(
                                                              context: context,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.vertical(
                                                                      top: Radius.circular(
                                                                        10.0,
                                                                      ),
                                                                    ),
                                                              ),
                                                              builder: (
                                                                context,
                                                              ) {
                                                                return Form(
                                                                  key: sellKey,
                                                                  child: Padding(
                                                                    padding: Pad(
                                                                      bottom:
                                                                          MediaQuery.of(
                                                                            context,
                                                                          ).viewInsets.bottom,
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      padding: EdgeInsetsDirectional.only(
                                                                        start:
                                                                            20,
                                                                        end: 20,
                                                                        bottom:
                                                                            30,
                                                                        top: 8,
                                                                      ),
                                                                      child: Wrap(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.only(
                                                                              top:
                                                                                  12.0,
                                                                              bottom:
                                                                                  7.0,
                                                                            ),
                                                                            child: Center(
                                                                              child: Text(
                                                                                "Sell",
                                                                                style: TextStyle(
                                                                                  fontSize: Adaptive.sp(
                                                                                    17,
                                                                                  ),
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                1,
                                                                          ),
                                                                          Center(
                                                                            child: Padding(
                                                                              padding: EdgeInsets.only(
                                                                                bottom:
                                                                                    8.0,
                                                                              ),
                                                                              child: Text.rich(
                                                                                TextSpan(
                                                                                  text:
                                                                                      "Product",
                                                                                  style: TextStyle(
                                                                                    fontSize: Adaptive.sp(
                                                                                      16,
                                                                                    ),
                                                                                    fontWeight:
                                                                                        FontWeight.bold,
                                                                                  ),
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text:
                                                                                          " : ${dataList[mainIndex ?? 0].commodity} (${dataList[mainIndex ?? 0].district})",
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          RowSuper(
                                                                            fill:
                                                                                true,
                                                                            children: [
                                                                              // Text.rich(TextSpan(
                                                                              //     text: "Commodity: ",
                                                                              //     style: TextStyle(
                                                                              //         fontSize:
                                                                              //             Adaptive.sp(16),
                                                                              //
                                                                              //         fontWeight:
                                                                              //             FontWeight.bold),
                                                                              //     children: [
                                                                              //       TextSpan(
                                                                              //           text:
                                                                              //               "${widget.dataList?[widget.index ?? 0].commodity}",
                                                                              //           style: TextStyle(
                                                                              //               fontSize:
                                                                              //                   Adaptive.sp(
                                                                              //                       16),
                                                                              //               fontFamily:
                                                                              //                   'Roboto',
                                                                              //               color: ColorConstant
                                                                              //                   .maingreen,
                                                                              //               fontWeight:
                                                                              //                   FontWeight
                                                                              //                       .bold))
                                                                              //     ])),
                                                                              Text.rich(
                                                                                TextSpan(
                                                                                  text:
                                                                                      "Date: ",
                                                                                  style: TextStyle(
                                                                                    fontSize: Adaptive.sp(
                                                                                      16,
                                                                                    ),
                                                                                    fontWeight:
                                                                                        FontWeight.bold,
                                                                                  ),
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text:
                                                                                          "${dataList[mainIndex ?? 0].date}",
                                                                                      style: TextStyle(
                                                                                        fontSize: Adaptive.sp(
                                                                                          16,
                                                                                        ),
                                                                                        fontFamily:
                                                                                            'Roboto',
                                                                                        color:
                                                                                            ColorConstant.maingreen,
                                                                                        fontWeight:
                                                                                            FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Divider(),
                                                                          Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsets.only(
                                                                                  bottom:
                                                                                      5.0,
                                                                                ),
                                                                                child: Text(
                                                                                  AppLocalizations.of(
                                                                                    context,
                                                                                  )!.msgYourprice,
                                                                                  style: TextStyle(
                                                                                    fontSize: Adaptive.sp(
                                                                                      16,
                                                                                    ),
                                                                                    fontFamily:
                                                                                        'Roboto',
                                                                                    color:
                                                                                        ColorConstant.maingreen,
                                                                                    fontWeight:
                                                                                        FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    10,
                                                                              ),
                                                                              Padding(
                                                                                padding: Pad(
                                                                                  all:
                                                                                      10,
                                                                                ),
                                                                                child: SizedBox(
                                                                                  width:
                                                                                      Get.width,
                                                                                  child: InputQty(
                                                                                    qtyFormProps: QtyFormProps(
                                                                                      keyboardType: TextInputType.numberWithOptions(
                                                                                        decimal:
                                                                                            false,
                                                                                      ),
                                                                                    ),
                                                                                    initVal:
                                                                                        dataList[mainIndex ??
                                                                                                0]
                                                                                            .lowerCircuit ??
                                                                                        0,
                                                                                    steps:
                                                                                        10,
                                                                                    onQtyChanged: (
                                                                                      val,
                                                                                    ) {
                                                                                      ref
                                                                                          .watch(
                                                                                            sellPrice.notifier,
                                                                                          )
                                                                                          .state = double.parse(
                                                                                        '${val ?? 0.0}',
                                                                                      );
                                                                                    },
                                                                                    decoration: QtyDecorationProps(
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(
                                                                                          5,
                                                                                        ),
                                                                                        borderSide: BorderSide(
                                                                                          color:
                                                                                              ColorConstant.maingreen,
                                                                                        ),
                                                                                      ),
                                                                                      qtyStyle:
                                                                                          QtyStyle.classic,
                                                                                      minusBtn: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          color:
                                                                                              ColorConstant.maingreen,
                                                                                          borderRadius: BorderRadius.circular(
                                                                                            5,
                                                                                          ),
                                                                                        ),
                                                                                        padding: Pad(
                                                                                          all:
                                                                                              10,
                                                                                        ),
                                                                                        child: Text(
                                                                                          '-10',
                                                                                          style: TextStyle(
                                                                                            fontWeight:
                                                                                                FontWeight.bold,
                                                                                            color:
                                                                                                Colors.white,
                                                                                            fontSize: Adaptive.sp(
                                                                                              17,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      plusBtn: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          color:
                                                                                              ColorConstant.maingreen,
                                                                                          borderRadius: BorderRadius.circular(
                                                                                            5,
                                                                                          ),
                                                                                        ),
                                                                                        padding: Pad(
                                                                                          all:
                                                                                              10,
                                                                                        ),
                                                                                        child: Text(
                                                                                          '+10',
                                                                                          style: TextStyle(
                                                                                            fontWeight:
                                                                                                FontWeight.bold,
                                                                                            color:
                                                                                                Colors.white,
                                                                                            fontSize: Adaptive.sp(
                                                                                              17,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width:
                                                                                    10,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(
                                                                                  bottom:
                                                                                      5.0,
                                                                                ),
                                                                                child: Text(
                                                                                  AppLocalizations.of(
                                                                                    context,
                                                                                  )!.msgNetweight,
                                                                                  style: TextStyle(
                                                                                    fontSize: Adaptive.sp(
                                                                                      16,
                                                                                    ),
                                                                                    fontFamily:
                                                                                        'Roboto',
                                                                                    color:
                                                                                        ColorConstant.maingreen,
                                                                                    fontWeight:
                                                                                        FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: Pad(
                                                                                  all:
                                                                                      10,
                                                                                ),
                                                                                child: SizedBox(
                                                                                  width:
                                                                                      Get.width,
                                                                                  child: InputQty(
                                                                                    qtyFormProps: QtyFormProps(
                                                                                      keyboardType: TextInputType.numberWithOptions(
                                                                                        decimal:
                                                                                            false,
                                                                                      ),
                                                                                    ),
                                                                                    initVal:
                                                                                        0,
                                                                                    minVal:
                                                                                        0,
                                                                                    steps:
                                                                                        10,
                                                                                    onQtyChanged: (
                                                                                      val,
                                                                                    ) {
                                                                                      ref
                                                                                          .watch(
                                                                                            sellWeight.notifier,
                                                                                          )
                                                                                          .state = double.parse(
                                                                                        "${val ?? 0.0}",
                                                                                      );
                                                                                    },
                                                                                    decoration: QtyDecorationProps(
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(
                                                                                          5,
                                                                                        ),
                                                                                        borderSide: BorderSide(
                                                                                          color:
                                                                                              ColorConstant.maingreen,
                                                                                        ),
                                                                                      ),
                                                                                      qtyStyle:
                                                                                          QtyStyle.classic,
                                                                                      minusBtn: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          color:
                                                                                              ColorConstant.maingreen,
                                                                                          borderRadius: BorderRadius.circular(
                                                                                            5,
                                                                                          ),
                                                                                        ),
                                                                                        padding: Pad(
                                                                                          all:
                                                                                              10,
                                                                                        ),
                                                                                        child: Text(
                                                                                          '-10',
                                                                                          style: TextStyle(
                                                                                            fontWeight:
                                                                                                FontWeight.bold,
                                                                                            color:
                                                                                                Colors.white,
                                                                                            fontSize: Adaptive.sp(
                                                                                              17,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      plusBtn: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          color:
                                                                                              ColorConstant.maingreen,
                                                                                          borderRadius: BorderRadius.circular(
                                                                                            5,
                                                                                          ),
                                                                                        ),
                                                                                        padding: Pad(
                                                                                          all:
                                                                                              10,
                                                                                        ),
                                                                                        child: Text(
                                                                                          '+10',
                                                                                          style: TextStyle(
                                                                                            fontWeight:
                                                                                                FontWeight.bold,
                                                                                            color:
                                                                                                Colors.white,
                                                                                            fontSize: Adaptive.sp(
                                                                                              17,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                15,
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.only(
                                                                              top:
                                                                                  15,
                                                                            ),
                                                                            child: Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: ElevatedButton(
                                                                                    style:
                                                                                        AppStyle.buttonStyle,
                                                                                    onPressed: () {
                                                                                      Navigator.of(
                                                                                        sheetContext,
                                                                                      ).pop();
                                                                                    },
                                                                                    child: Text(
                                                                                      AppLocalizations.of(
                                                                                        context,
                                                                                      )!.msgCencel,
                                                                                      style: TextStyle(
                                                                                        fontSize: Adaptive.sp(
                                                                                          16,
                                                                                        ),
                                                                                        fontFamily:
                                                                                            'Roboto',
                                                                                        fontWeight:
                                                                                            FontWeight.w500,
                                                                                        color:
                                                                                            Colors.white,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width:
                                                                                      20,
                                                                                ),
                                                                                Expanded(
                                                                                  child: ElevatedButton(
                                                                                    style: AppStyle.buttonStyle.copyWith(
                                                                                      backgroundColor: WidgetStatePropertyAll(
                                                                                        ColorConstant.red500,
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () async {
                                                                                      if (ref.watch(
                                                                                            sellPrice,
                                                                                          ) <
                                                                                          1) {
                                                                                        context.errorToast(
                                                                                          'Please input proper selling price',
                                                                                        );
                                                                                      } else {
                                                                                        if (ref.watch(
                                                                                              sellWeight,
                                                                                            ) >
                                                                                            0.0) {
                                                                                          if (sellKey.currentState!.validate()) {
                                                                                            ElevarmConfirmAlertDialog(
                                                                                              title:
                                                                                                  'Are you sure?',
                                                                                              subtitle:
                                                                                                  'Commodity Price: ${ref.watch(sellPrice)}\nCommodity Weight: ${ref.watch(sellWeight)} in Quintal',
                                                                                              onPositiveButton: () {
                                                                                                context.showLoader();
                                                                                                ref
                                                                                                    .watch(
                                                                                                      postSbtProvider(
                                                                                                        productId:
                                                                                                            "${dataList[mainIndex ?? 0].productId}",
                                                                                                        commodityId:
                                                                                                            "${dataList[mainIndex ?? 0].commodityId}",
                                                                                                        district_id:
                                                                                                            "${dataList[mainIndex ?? 0].districtId}",
                                                                                                        qty:
                                                                                                            "${ref.watch(sellWeight)}",
                                                                                                        price:
                                                                                                            "${ref.watch(sellPrice)}",
                                                                                                        type:
                                                                                                            "2",
                                                                                                      ).future,
                                                                                                    )
                                                                                                    .then(
                                                                                                      (
                                                                                                        value,
                                                                                                      ) async {
                                                                                                        context.hideloader();
                                                                                                        Navigator.of(
                                                                                                          sheetContext,
                                                                                                        ).pop();
                                                                                                        ref.invalidate(
                                                                                                          getBuyerSellerListProvider,
                                                                                                        );

                                                                                                        ref.invalidate(
                                                                                                          getSbtCommodityProvider,
                                                                                                        );

                                                                                                        ref.invalidate(
                                                                                                          matchedOrdersProvider,
                                                                                                        );
                                                                                                        if (value['status'].toString() ==
                                                                                                            "1") {
                                                                                                          Get.back();

                                                                                                          Fluttertoast.showToast(
                                                                                                            msg:
                                                                                                                value['message'],
                                                                                                            toastLength:
                                                                                                                Toast.LENGTH_LONG,
                                                                                                            backgroundColor:
                                                                                                                Colors.green,
                                                                                                          );
                                                                                                        } else {
                                                                                                          if (value['message'].toString().contains(
                                                                                                            'User don\'t have suffcient balance.',
                                                                                                          )) {
                                                                                                            Fluttertoast.showToast(
                                                                                                              msg:
                                                                                                                  value['message'],
                                                                                                              toastLength:
                                                                                                                  Toast.LENGTH_LONG,
                                                                                                              backgroundColor:
                                                                                                                  Colors.red,
                                                                                                            );
                                                                                                          }
                                                                                                        }

                                                                                                        ref.invalidate(
                                                                                                          matchedOrdersProvider,
                                                                                                        );
                                                                                                      },
                                                                                                    )
                                                                                                    .onError(
                                                                                                      (
                                                                                                        e,
                                                                                                        s,
                                                                                                      ) {
                                                                                                        context.hideloader();
                                                                                                      },
                                                                                                    );
                                                                                              },
                                                                                              onNegativeButton: () {
                                                                                                Get.back();
                                                                                              },
                                                                                              positiveText:
                                                                                                  'Submit',
                                                                                              negativeText:
                                                                                                  'No',
                                                                                              variant:
                                                                                                  ElevarmDialogVariant.danger,
                                                                                            ).show(
                                                                                              context,
                                                                                            );
                                                                                          }
                                                                                        } else {
                                                                                          Fluttertoast.showToast(
                                                                                            msg:
                                                                                                'Quantity should be greater than 0!',
                                                                                            toastLength:
                                                                                                Toast.LENGTH_LONG,
                                                                                            backgroundColor:
                                                                                                Colors.red,
                                                                                          );
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                    child: Text(
                                                                                      AppLocalizations.of(
                                                                                        context,
                                                                                      )!.submit,
                                                                                      style: TextStyle(
                                                                                        fontSize: Adaptive.sp(
                                                                                          16,
                                                                                        ),
                                                                                        fontFamily:
                                                                                            'Roboto',
                                                                                        fontWeight:
                                                                                            FontWeight.w500,
                                                                                        color:
                                                                                            Colors.white,
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
                                                                );
                                                              },
                                                            );
                                                          }
                                                        } else {
                                                          showLoginBottomsheet(
                                                            context,
                                                          );
                                                        }
                                                      },
                                                      style: AppStyle
                                                          .buttonStyle
                                                          .copyWith(
                                                            backgroundColor:
                                                                WidgetStateProperty.resolveWith(
                                                                  (states) =>
                                                                      Colors
                                                                          .red,
                                                                ),
                                                          ),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.msgSell,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevarmLinkPrimaryButton.icon(
                                              buttonThemeData:
                                                  ElevarmLinkButtonThemeData(
                                                    onPrimaryColor:
                                                        ColorConstant.maingreen,
                                                  ),
                                              text: 'View Chart',
                                              onPressed: () {
                                                Get.to(
                                                  BuySellData(
                                                    data: dataList[mainIndex],
                                                    index: data.data?.indexOf(
                                                      dataList[mainIndex],
                                                    ),
                                                  ),
                                                );
                                              },
                                              leadingIconAssetName:
                                                  CupertinoIcons.chart_bar,
                                              trailingIconAssetName:
                                                  CupertinoIcons.forward,
                                            ),
                                            ElevarmDivider(),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: BuyerList(
                                                    data: dataList[mainIndex],
                                                    index: mainIndex,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: SellerList(
                                                    data: dataList[mainIndex],
                                                    index: mainIndex,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(width: 20),
                                            Center(
                                              child: Text(
                                                "Matching Deals",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Adaptive.sp(16),
                                                ),
                                              ),
                                            ),
                                            ref
                                                .watch(
                                                  matchedOrdersProvider(
                                                    productId:
                                                        "${dataList[mainIndex].productId}",
                                                  ),
                                                )
                                                .when(
                                                  data:
                                                      (data) =>
                                                          (data.tradeOrderData ??
                                                                      [])
                                                                  .isEmpty
                                                              ? Center(
                                                                child: Text(
                                                                  'No Data Found',
                                                                ),
                                                              )
                                                              : ListView.builder(
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    data
                                                                        .tradeOrderData
                                                                        ?.length,
                                                                itemBuilder: (
                                                                  BuildContext
                                                                  context,
                                                                  int index,
                                                                ) {
                                                                  return Card(
                                                                    elevation:
                                                                        5,
                                                                    color:
                                                                        Colors
                                                                            .white,
                                                                    shape: RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                        color: ColorConstant
                                                                            .maingreen
                                                                            .withOpacity(
                                                                              0.3,
                                                                            ),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10,
                                                                          ),
                                                                    ),
                                                                    margin: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          10,
                                                                    ),
                                                                    surfaceTintColor:
                                                                        Colors
                                                                            .white,
                                                                    child: Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                            10,
                                                                          ),
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Center(
                                                                            child: Text.rich(
                                                                              TextSpan(
                                                                                text:
                                                                                    ref
                                                                                                .watch(
                                                                                                  sharedUtilityProvider,
                                                                                                )
                                                                                                .getUser()
                                                                                                ?.firmName
                                                                                                .toString()
                                                                                                .toLowerCase() ==
                                                                                            data.tradeOrderData?[index].buyer.toString().toLowerCase()
                                                                                        ? "Buying Deal"
                                                                                        : ref
                                                                                                .watch(
                                                                                                  sharedUtilityProvider,
                                                                                                )
                                                                                                .getUser()
                                                                                                ?.firmName
                                                                                                .toString()
                                                                                                .toLowerCase() ==
                                                                                            data.tradeOrderData?[index].seller.toString().toLowerCase()
                                                                                        ? "Selling Deal"
                                                                                        : "",
                                                                                style: TextStyle(
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  color:
                                                                                      ref
                                                                                                  .watch(
                                                                                                    sharedUtilityProvider,
                                                                                                  )
                                                                                                  .getUser()
                                                                                                  ?.firmName
                                                                                                  .toString()
                                                                                                  .toLowerCase() ==
                                                                                              data.tradeOrderData?[index].buyer.toString().toLowerCase()
                                                                                          ? ColorConstant.maingreen
                                                                                          : ref
                                                                                                  .watch(
                                                                                                    sharedUtilityProvider,
                                                                                                  )
                                                                                                  .getUser()
                                                                                                  ?.firmName
                                                                                                  .toString()
                                                                                                  .toLowerCase() ==
                                                                                              data.tradeOrderData?[index].seller.toString().toLowerCase()
                                                                                          ? Colors.red
                                                                                          : ColorConstant.maingreen,
                                                                                  fontSize: Adaptive.sp(
                                                                                    17,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              TextOneLine(
                                                                                "Order ID: ${data.tradeOrderData?[index].orderId}",
                                                                                textAlign:
                                                                                    TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color:
                                                                                      ColorConstant.maingreen,
                                                                                  fontWeight:
                                                                                      FontWeight.w700,
                                                                                  fontSize: Adaptive.sp(
                                                                                    16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          ElevarmDivider(),

                                                                          // SizedBox(
                                                                          //   height: 10,
                                                                          // ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                "Date: ${data.tradeOrderData?[index].date}",
                                                                                textAlign:
                                                                                    TextAlign.end,
                                                                                style: TextStyle(
                                                                                  color:
                                                                                      ColorConstant.maingreen,
                                                                                  fontWeight:
                                                                                      FontWeight.w700,
                                                                                  fontSize: Adaptive.sp(
                                                                                    16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "Expiry Date: ${data.tradeOrderData?[index].expiryDate}",
                                                                                textAlign:
                                                                                    TextAlign.end,
                                                                                style: TextStyle(
                                                                                  color:
                                                                                      ColorConstant.maingreen,
                                                                                  fontWeight:
                                                                                      FontWeight.w700,
                                                                                  fontSize: Adaptive.sp(
                                                                                    16,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          ElevarmDivider(),

                                                                          Text.rich(
                                                                            TextSpan(
                                                                              text:
                                                                                  "${data.tradeOrderData?[index].commodity}",
                                                                              style: TextStyle(
                                                                                color:
                                                                                    ColorConstant.maingreen,
                                                                                fontWeight:
                                                                                    FontWeight.w700,
                                                                                fontSize: Adaptive.sp(
                                                                                  16,
                                                                                ),
                                                                              ),
                                                                              children: [
                                                                                TextSpan(
                                                                                  text:
                                                                                      "- ${data.tradeOrderData?[index].district.toString()}",
                                                                                  style: TextStyle(
                                                                                    fontSize: Adaptive.sp(
                                                                                      16,
                                                                                    ),
                                                                                    color:
                                                                                        Colors.black,
                                                                                    fontWeight:
                                                                                        FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          ElevarmDivider(),

                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    AppLocalizations.of(
                                                                                      context,
                                                                                    )!.msgRate,
                                                                                    style: AppStyle.mystoke.copyWith(
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      fontWeight:
                                                                                          FontWeight.w700,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width:
                                                                                        10,
                                                                                  ),
                                                                                  Text(
                                                                                    currencyFormat.format(
                                                                                      double.parse(
                                                                                        "${data.tradeOrderData?[index].rate ?? "0.0"}",
                                                                                      ),
                                                                                    ),
                                                                                    style: AppStyle.mystoke.copyWith(
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      fontWeight:
                                                                                          FontWeight.w700,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width:
                                                                                    10,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment:
                                                                                    MainAxisAlignment.end,
                                                                                children: [
                                                                                  Text(
                                                                                    AppLocalizations.of(
                                                                                      context,
                                                                                    )!.msgQuantity,
                                                                                    style: AppStyle.mystoke.copyWith(
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      fontWeight:
                                                                                          FontWeight.w700,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width:
                                                                                        10,
                                                                                  ),
                                                                                  Text(
                                                                                    '${data.tradeOrderData?[index].qty}(Qtl.)',
                                                                                    style: AppStyle.mystoke.copyWith(
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      fontWeight:
                                                                                          FontWeight.w700,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width:
                                                                                    10,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          ElevarmDivider(),

                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),

                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                AppLocalizations.of(
                                                                                  context,
                                                                                )!.pendingQuantity,
                                                                                style: AppStyle.mystoke.copyWith(
                                                                                  fontSize: Adaptive.sp(
                                                                                    16,
                                                                                  ),
                                                                                  fontWeight:
                                                                                      FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width:
                                                                                    10,
                                                                              ),
                                                                              Text(
                                                                                '${(num.parse("${data.tradeOrderData?[index].qty}") - num.parse(data.tradeOrderData?[index].deliverQty)).toStringAsFixed(0)}(Qtl.)',
                                                                                style: AppStyle.mystoke.copyWith(
                                                                                  fontSize: Adaptive.sp(
                                                                                    16,
                                                                                  ),
                                                                                  fontWeight:
                                                                                      FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          ElevarmDivider(),

                                                                          if (ref
                                                                                  .watch(
                                                                                    sharedUtilityProvider,
                                                                                  )
                                                                                  .getUser()
                                                                                  ?.firmName
                                                                                  .toString()
                                                                                  .toLowerCase() ==
                                                                              data.tradeOrderData?[index].buyer.toString().toLowerCase())
                                                                            Center(
                                                                              child: ElevarmPrimaryButton.text(
                                                                                onPressed: () {
                                                                                  showModalBottomSheet(
                                                                                    context:
                                                                                        context,
                                                                                    builder:
                                                                                        (
                                                                                          bottomsheetContext,
                                                                                        ) => ElevarmDraggableBottomSheet(
                                                                                          maxChildSize:
                                                                                              1,
                                                                                          initialChildSize:
                                                                                              1,
                                                                                          title:
                                                                                              'Running Deals',
                                                                                          onPressedClose:
                                                                                              () =>
                                                                                                  Get.back(),
                                                                                          children: [
                                                                                            DeliveryMarking(
                                                                                              isScreen:
                                                                                                  false,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                    isScrollControlled:
                                                                                        true,
                                                                                  );
                                                                                },
                                                                                buttonThemeData: ElevarmPrimaryButtonThemeData(
                                                                                  primaryColor:
                                                                                      ColorConstant.maingreen,
                                                                                ),
                                                                                text:
                                                                                    'Check Deal Status',
                                                                              ),
                                                                            ),

                                                                          if (ref
                                                                                      .watch(
                                                                                        sharedUtilityProvider,
                                                                                      )
                                                                                      .getUser()
                                                                                      ?.firmName
                                                                                      .toString()
                                                                                      .toLowerCase() ==
                                                                                  data.tradeOrderData?[index].seller.toString().toLowerCase() &&
                                                                              dataList[mainIndex].sbtType.toString() ==
                                                                                  "1")
                                                                            RowSuper(
                                                                              fitHorizontally:
                                                                                  true,
                                                                              children: [
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Get.back();
                                                                                    if (dataList[mainIndex].sbtType.toString() ==
                                                                                        "1") {
                                                                                      Get.to(
                                                                                        StackInward(
                                                                                          isAppbarVisible:
                                                                                              true,
                                                                                        ),
                                                                                      );
                                                                                    } else {
                                                                                      Get.to(
                                                                                        Dispatchrequestscreen(
                                                                                          sbtOrder:
                                                                                              data.tradeOrderData?[index].orderId,
                                                                                        ),
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                  child: Text(
                                                                                    AppLocalizations.of(
                                                                                      context,
                                                                                    )!.msgStackinward,
                                                                                    style: TextStyle(
                                                                                      fontWeight:
                                                                                          FontWeight.bold,
                                                                                      color:
                                                                                          ColorConstant.maingreen,
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      decoration:
                                                                                          TextDecoration.underline,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Get.back();
                                                                                    if (dataList[mainIndex].sbtType.toString() ==
                                                                                        "1") {
                                                                                      showModalBottomSheet(
                                                                                        context:
                                                                                            context,
                                                                                        builder:
                                                                                            (
                                                                                              bottomsheetContext,
                                                                                            ) => ElevarmDraggableBottomSheet(
                                                                                              title:
                                                                                                  'Mark Delivery',
                                                                                              onPressedClose:
                                                                                                  () =>
                                                                                                      Get.back(),
                                                                                              initialChildSize:
                                                                                                  1,
                                                                                              children: [
                                                                                                DeliveryMarking(
                                                                                                  isScreen:
                                                                                                      false,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                        isScrollControlled:
                                                                                            true,
                                                                                      );
                                                                                    } else {
                                                                                      showModalBottomSheet(
                                                                                        context:
                                                                                            context,
                                                                                        builder:
                                                                                            (
                                                                                              bottomsheetContext,
                                                                                            ) => ElevarmDraggableBottomSheet(
                                                                                              title:
                                                                                                  '',
                                                                                              onPressedClose:
                                                                                                  () =>
                                                                                                      Get.back(),
                                                                                              children: [
                                                                                                Dispatchrequestslisting(
                                                                                                  orderId:
                                                                                                      data.tradeOrderData?[index].orderId ??
                                                                                                      "",
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                        isScrollControlled:
                                                                                            true,
                                                                                      );
                                                                                    }
                                                                                  },
                                                                                  child: Text(
                                                                                    'Mark Delivery',
                                                                                    style: TextStyle(
                                                                                      fontWeight:
                                                                                          FontWeight.bold,
                                                                                      color:
                                                                                          ColorConstant.maingreen,
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      decoration:
                                                                                          TextDecoration.underline,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Get.back();
                                                                                    Get.to(
                                                                                      Tradewalletscreen(),
                                                                                    );
                                                                                  },
                                                                                  child: Text(
                                                                                    'Wallet Refund',
                                                                                    style: TextStyle(
                                                                                      fontWeight:
                                                                                          FontWeight.bold,
                                                                                      color:
                                                                                          ColorConstant.maingreen,
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                      decoration:
                                                                                          TextDecoration.underline,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),

                                                                          if (ref
                                                                                      .watch(
                                                                                        sharedUtilityProvider,
                                                                                      )
                                                                                      .getUser()
                                                                                      ?.firmName
                                                                                      .toString()
                                                                                      .toLowerCase() ==
                                                                                  data.tradeOrderData?[index].seller.toString().toLowerCase() &&
                                                                              dataList[mainIndex].sbtType.toString() ==
                                                                                  "2")
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: simpleButton(
                                                                                    text:
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!.dispatch,
                                                                                    callback: () {
                                                                                      Get.back();
                                                                                      if (dataList[mainIndex].sbtType.toString() ==
                                                                                          "1") {
                                                                                        Get.to(
                                                                                          StackInward(
                                                                                            isAppbarVisible:
                                                                                                true,
                                                                                          ),
                                                                                        );
                                                                                      } else {
                                                                                        Get.to(
                                                                                          Dispatchrequestscreen(
                                                                                            sbtOrder:
                                                                                                data.tradeOrderData?[index].orderId,
                                                                                          ),
                                                                                        );
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width:
                                                                                      10,
                                                                                ),
                                                                                Expanded(
                                                                                  child: simpleButton(
                                                                                    text:
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!.msgGrn,
                                                                                    callback: () {
                                                                                      Get.back();
                                                                                      if (dataList[mainIndex].sbtType.toString() ==
                                                                                          "1") {
                                                                                        Get.to(
                                                                                          Sbtdeals(
                                                                                            selectedIndex:
                                                                                                ref
                                                                                                            .watch(
                                                                                                              sharedUtilityProvider,
                                                                                                            )
                                                                                                            .getUser()
                                                                                                            ?.firmName
                                                                                                            .toString()
                                                                                                            .toLowerCase() ==
                                                                                                        data.tradeOrderData?[index].buyer.toString().toLowerCase()
                                                                                                    ? 1
                                                                                                    : ref
                                                                                                            .watch(
                                                                                                              sharedUtilityProvider,
                                                                                                            )
                                                                                                            .getUser()
                                                                                                            ?.firmName
                                                                                                            .toString()
                                                                                                            .toLowerCase() ==
                                                                                                        data.tradeOrderData?[index].seller.toString().toLowerCase()
                                                                                                    ? 0
                                                                                                    : 0,
                                                                                            sbtOrderId:
                                                                                                data.tradeOrderData?[index].orderId ??
                                                                                                "",
                                                                                          ),
                                                                                        );
                                                                                      } else {
                                                                                        Get.to(
                                                                                          Dispatchrequestslisting(
                                                                                            orderId:
                                                                                                data.tradeOrderData?[index].orderId ??
                                                                                                "",
                                                                                          ),
                                                                                        );
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width:
                                                                                      10,
                                                                                ),
                                                                                Expanded(
                                                                                  child: simpleButton(
                                                                                    text:
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!.payment,
                                                                                    callback: () {
                                                                                      Get.back();
                                                                                      Get.to(
                                                                                        Tradewalletscreen(),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                  error:
                                                      (e, s) =>
                                                          noStockData(context),
                                                  loading:
                                                      () =>
                                                          _matchedOrdersLoader(),
                                                ),

                                            ElevarmDivider(),
                                            // Text(
                                            //   'Apps',
                                            //   style: ElevarmFontFamilies.inter(
                                            //       fontSize: Adaptive.sp(
                                            //           13),
                                            //       fontWeight: FontWeight
                                            //           .bold,
                                            //       color:
                                            //           ElevarmColors.neutral),
                                            // ),
                                            //  SizedBox(
                                            //   width: 10,
                                            // ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _commodityParamsLayout(
                                                  "${dataList[mainIndex].productId}",
                                                  "${dataList[mainIndex].commodity}",
                                                ),
                                                ElevarmDivider(),
                                                Center(
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.deliveryCenters,
                                                    style: TextStyle(
                                                      fontSize: Adaptive.sp(17),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                _deliveryCenters(
                                                  "${dataList[mainIndex].productId}",
                                                  "${dataList[mainIndex].sbtType}",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                  ),
                            );

                            // showBarModalBottomSheet(
                            //     context: context,
                            //     builder: (context) => BuySellData(
                            //           data: data,
                            //           index: index,
                            //         ));

                            // cont.refresh();
                          },
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color:
                                    data.data?[mainIndex].sbtType.toString() ==
                                            "2"
                                        ? Colors.amber.shade900
                                        : data.data?[mainIndex].sbtType
                                                .toString() ==
                                            "1"
                                        ? ColorConstant.maingreen
                                        : ColorConstant.red500,
                                width: 2,
                              ),
                            ),
                            margin: EdgeInsets.all(10),
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title with district
                                  Text.rich(
                                    TextSpan(
                                      text: "${dataList[mainIndex].commodity} ",
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(17),
                                        fontWeight: FontWeight.w700,
                                        color:
                                            data.data?[mainIndex].sbtType
                                                        .toString() ==
                                                    "2"
                                                ? Colors.amber.shade900
                                                : data.data?[mainIndex].sbtType
                                                        .toString() ==
                                                    "1"
                                                ? ColorConstant.maingreen
                                                : ColorConstant.red500,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "- ${dataList[mainIndex].district}",
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 12),

                                  // Buyer/Seller best prices
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildPriceRow(
                                        label:
                                            AppLocalizations.of(
                                              context,
                                            )!.msgBuyerBest,
                                        value: currencyFormat.format(
                                          dataList[mainIndex].bestBuyer
                                              .toString()
                                              .convertToDouble(
                                                defaultValue: 0.00,
                                              ),
                                        ),
                                      ),
                                      _buildPriceRow(
                                        label:
                                            AppLocalizations.of(
                                              context,
                                            )!.msgSellerBest,
                                        value: currencyFormat.format(
                                          dataList[mainIndex].bestSeller
                                              .toString()
                                              .convertToDouble(
                                                defaultValue: 0.00,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10),

                                  // Tap for details + Icon and Label
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.tapForDetails,
                                        style: AppStyle.mystoke.copyWith(
                                          fontSize: Adaptive.sp(15),
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        data.data?[mainIndex].sbtType
                                                    .toString() ==
                                                "2"
                                            ? Icons.factory
                                            : data.data?[mainIndex].sbtType
                                                    .toString() ==
                                                "1"
                                            ? Icons.warehouse
                                            : Icons.store,
                                        size: 30,
                                        color:
                                            data.data?[mainIndex].sbtType
                                                        .toString() ==
                                                    "2"
                                                ? Colors.amber.shade900
                                                : data.data?[mainIndex].sbtType
                                                        .toString() ==
                                                    "1"
                                                ? ColorConstant.maingreen
                                                : ColorConstant.red500,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        data.data?[mainIndex].sbtType
                                                    .toString() ==
                                                "2"
                                            ? AppLocalizations.of(
                                              context,
                                            )!.outsideWarehouse
                                            : data.data?[mainIndex].sbtType
                                                    .toString() ==
                                                "1"
                                            ? AppLocalizations.of(
                                              context,
                                            )!.warehouse
                                            : AppLocalizations.of(
                                              context,
                                            )!.outsideWarehouse,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                  },
                );
          },
          error: (e, s) => noStockData(),
          loading: () => _sbttLoader(),
        );
  }

  _sbttLoader() => Skeletonizer(
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int mainIndex) {
        return InkWell(
          onTap: () async {
            // Get.to();
          },
          child: Card(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: ColorConstant.maingreen, width: 2),
            ),
            margin: EdgeInsets.all(10),
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with district
                  Text.rich(
                    TextSpan(
                      text: "Barley ",
                      style: TextStyle(
                        fontSize: Adaptive.sp(17),
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.maingreen,
                      ),
                      children: [
                        TextSpan(
                          text: "- Loading....",
                          style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12),

                  // Buyer/Seller best prices
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPriceRow(
                        label: AppLocalizations.of(context)!.msgBuyerBest,
                        value: currencyFormat.format(0.00),
                      ),
                      _buildPriceRow(
                        label: AppLocalizations.of(context)!.msgSellerBest,
                        value: currencyFormat.format(0.00),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Tap for details + Icon and Label
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.tapForDetails,
                        style: AppStyle.mystoke.copyWith(
                          fontSize: Adaptive.sp(15),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.warehouse,
                        size: 30,
                        color: ColorConstant.maingreen,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Warehouse',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Adaptive.sp(15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );

  _matchedOrdersLoader() => Skeletonizer(
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorConstant.maingreen.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Selling Deal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.maingreen,
                        fontSize: Adaptive.sp(17),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    TextOneLine(
                      "Order ID:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorConstant.maingreen,
                        fontWeight: FontWeight.w700,
                        fontSize: Adaptive.sp(16),
                      ),
                    ),
                  ],
                ),
                ElevarmDivider(),

                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date:",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: ColorConstant.maingreen,
                        fontWeight: FontWeight.w700,
                        fontSize: Adaptive.sp(16),
                      ),
                    ),
                    Text(
                      "Expiry Date: ",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: ColorConstant.maingreen,
                        fontWeight: FontWeight.w700,
                        fontSize: Adaptive.sp(16),
                      ),
                    ),
                  ],
                ),
                ElevarmDivider(),

                Text.rich(
                  TextSpan(
                    text: "Loading...",
                    style: TextStyle(
                      color: ColorConstant.maingreen,
                      fontWeight: FontWeight.w700,
                      fontSize: Adaptive.sp(16),
                    ),
                    children: [
                      TextSpan(
                        text: "- Loading...",
                        style: TextStyle(
                          fontSize: Adaptive.sp(16),
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevarmDivider(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.msgRate + ':',
                          style: AppStyle.mystoke.copyWith(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '0',
                          style: AppStyle.mystoke.copyWith(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.msgQuantity + ':',
                          style: AppStyle.mystoke.copyWith(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '0(Qtl.)',
                          style: AppStyle.mystoke.copyWith(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                ElevarmDivider(),

                SizedBox(width: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pendingQuantity + ':',
                      style: AppStyle.mystoke.copyWith(
                        fontSize: Adaptive.sp(16),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '0(Qtl.)',
                      style: AppStyle.mystoke.copyWith(
                        fontSize: Adaptive.sp(16),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                ElevarmDivider(),

                // Center(
                //   child: ElevarmPrimaryButton.text(
                //       onPressed: () {},
                //       buttonThemeData: ElevarmPrimaryButtonThemeData(
                //           primaryColor: ColorConstant.maingreen),
                //       text: 'Check Deal Status'),
                // ),
                RowSuper(
                  fitHorizontally: true,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.msgStackinward,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.maingreen,
                          fontSize: Adaptive.sp(16),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Mark Delivery',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.maingreen,
                          fontSize: Adaptive.sp(16),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        Get.to(Tradewalletscreen());
                      },
                      child: Text(
                        'Wallet Refund',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.maingreen,
                          fontSize: Adaptive.sp(16),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: simpleButton(
                        text: AppLocalizations.of(context)!.dispatch,
                        callback: () {},
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: simpleButton(
                        text: AppLocalizations.of(context)!.msgGrn,
                        callback: () {},
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: simpleButton(
                        text: AppLocalizations.of(context)!.payment,
                        callback: () {
                          Get.back();
                          Get.to(Tradewalletscreen());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  Widget _buildPriceRow({required String label, required String value}) {
    return Row(
      children: [
        Text(
          label,
          style: AppStyle.mystoke.copyWith(
            fontSize: Adaptive.sp(16),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 6),
        Text(
          value,
          style: AppStyle.mystoke.copyWith(
            fontSize: Adaptive.sp(16),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  _handleBuyOption(
    dynamic dataList,
    dynamic mainIndex,
    BuildContext bottomsheetContext,
    double quantity,
    double price,
  ) {
    ElevarmConfirmAlertDialog(
      title: 'Are you sure?',
      subtitle:
          'Commodity Price: ${ref.watch(buyPrice)}\nCommodity Weight: ${ref.watch(buyWeight)} in Quintal',
      onPositiveButton: () {
        Get.back();
        context.showLoader();

        ref
            .watch(
              checkForUserWalletProvider(
                districtId: dataList[mainIndex ?? 0].districtId.toString(),
                commodity: dataList[mainIndex ?? 0].commodityId.toString(),
                productId: dataList[mainIndex ?? 0].productId.toString(),
                qty: ref.watch(buyWeight).toString(),
                type: "1",
                //bnpl or finance type
                price: ref.watch(buyPrice).toString(),
                loanType: null, // 0
              ).future,
            )
            .then((value) async {
              context.hideloader();
              if (value["error"].toString().toLowerCase() == "no") {
                context.showLoader();
                ref
                    .watch(
                      postSbtProvider(
                        productId: "${dataList[mainIndex ?? 0].productId}",
                        commodityId: "${dataList[mainIndex ?? 0].commodityId}",
                        district_id: "${dataList[mainIndex ?? 0].districtId}",
                        qty: "$quantity",
                        price: "$price",
                        type: "1",
                        loanType: null,
                      ).future,
                    )
                    .then((value) {
                      context.hideloader();
                      if (value['status'].toString() == "1") {
                        Navigator.of(bottomsheetContext).pop();

                        Fluttertoast.showToast(
                          msg: value['message'],
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.green,
                        );
                      }
                    })
                    .onError((e, s) {
                      context.hideloader();
                    });
              } else {
                if (value['error_type'].toString().toLowerCase() == "wallet" ||
                    value['error_type'].toString().toLowerCase() == "finance") {
                  if (value['error_type'].toString().toLowerCase() ==
                          'wallet' &&
                      value['wallet_type'].toString().toLowerCase() ==
                          "finance") {
                    showModalBottomSheet(
                      context: context,
                      builder:
                          (bottomsheetContext) => ElevarmDraggableBottomSheet(
                            title: 'You don\'t have sufficient balance',
                            onPressedClose: () => Get.back(),
                            footerWidget: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      context.showLoader();
                                      ref
                                          .watch(
                                            checkForUserWalletProvider(
                                              districtId:
                                                  dataList[mainIndex ?? 0]
                                                      .districtId
                                                      .toString(),
                                              commodity:
                                                  dataList[mainIndex ?? 0]
                                                      .commodityId
                                                      .toString(),
                                              productId:
                                                  dataList[mainIndex ?? 0]
                                                      .productId
                                                      .toString(),
                                              qty:
                                                  ref
                                                      .watch(buyWeight)
                                                      .toString(),
                                              type: "1",
                                              //bnpl or finance type
                                              price:
                                                  ref
                                                      .watch(buyPrice)
                                                      .toString(),
                                              loanType: "1", // 0
                                            ).future,
                                          )
                                          .then((value) {
                                            context.hideloader();
                                            if (value['wallet_type'] != null) {
                                              if (value['error']
                                                          .toString()
                                                          .toLowerCase() ==
                                                      "yes" &&
                                                  value['wallet_type']
                                                          .toString()
                                                          .toLowerCase() ==
                                                      "bnpl") {
                                                Get.back(
                                                  canPop: true,
                                                  closeOverlays: true,
                                                );
                                                Get.to(
                                                  AddMoney(
                                                    isAppBarVisible: true,
                                                  ),
                                                );
                                              } else {
                                                context.hideloader();
                                                ref
                                                    .watch(
                                                      postSbtProvider(
                                                        productId:
                                                            "${dataList[mainIndex ?? 0].productId}",
                                                        commodityId:
                                                            "${dataList[mainIndex ?? 0].commodityId}",
                                                        district_id:
                                                            "${dataList[mainIndex ?? 0].districtId}",
                                                        qty:
                                                            "${ref.watch(buyWeight)}",
                                                        price:
                                                            "${ref.watch(buyPrice)}",
                                                        type: "1",
                                                        loanType: "1",
                                                        schemeId: null,
                                                      ).future,
                                                    )
                                                    .then((value) {
                                                      context.hideloader();
                                                      Get.back(
                                                        canPop: true,
                                                        closeOverlays: true,
                                                      );

                                                      if (value['status']
                                                              .toString() ==
                                                          "1") {
                                                        Fluttertoast.showToast(
                                                          msg: value['message'],
                                                          toastLength:
                                                              Toast.LENGTH_LONG,
                                                          backgroundColor:
                                                              Colors.green,
                                                        );
                                                      }
                                                    })
                                                    .onError((e, s) {
                                                      context.hideloader();
                                                      Get.back(
                                                        canPop: true,
                                                        closeOverlays: true,
                                                      );
                                                    });
                                              }
                                            }
                                          })
                                          .onError((e, s) {
                                            context.hideloader();

                                            Get.back(
                                              canPop: true,
                                              closeOverlays: true,
                                            );
                                          });
                                    },
                                    style: AppStyle.buttonStyle,
                                    child: Text(
                                      'Wallet',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(16),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      context.hideloader();
                                      ref
                                          .watch(
                                            checkForUserWalletProvider(
                                              districtId:
                                                  dataList[mainIndex ?? 0]
                                                      .districtId
                                                      .toString(),
                                              commodity:
                                                  dataList[mainIndex ?? 0]
                                                      .commodityId
                                                      .toString(),
                                              productId:
                                                  dataList[mainIndex ?? 0]
                                                      .productId
                                                      .toString(),
                                              qty:
                                                  ref
                                                      .watch(buyWeight)
                                                      .toString(),
                                              type: "1",
                                              //bnpl or finance type
                                              price:
                                                  ref
                                                      .watch(buyPrice)
                                                      .toString(),
                                              loanType: "2", // 0
                                            ).future,
                                          )
                                          .then((value) async {
                                            context.hideloader();
                                            if (value['wallet_type'] != null) {
                                              if (value['error']
                                                          .toString()
                                                          .toLowerCase() ==
                                                      "yes" &&
                                                  value['error_type']
                                                          .toString()
                                                          .toLowerCase() ==
                                                      "finance") {
                                                await LaunchApp.openApp(
                                                  androidPackageName:
                                                      'com.swfl.swfl',
                                                );

                                                Get.back(
                                                  canPop: true,
                                                  closeOverlays: true,
                                                );
                                              } else {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (
                                                        bottomsheetContext,
                                                      ) => ElevarmDraggableBottomSheet(
                                                        title:
                                                            'Please select a plan',
                                                        onPressedClose:
                                                            () => Get.back(),
                                                        children: [
                                                          Consumer(
                                                            builder:
                                                                (
                                                                  context,
                                                                  ref,
                                                                  child,
                                                                ) => SizedBox(
                                                                  height:
                                                                      Get.height /
                                                                      2,
                                                                  width:
                                                                      Get.width,
                                                                  child:
                                                                      value['data'] ==
                                                                              null
                                                                          ? Text(
                                                                            "No Data",
                                                                          )
                                                                          : ColumnSuper(
                                                                            children: [
                                                                              Container(
                                                                                padding: Pad(
                                                                                  all:
                                                                                      10,
                                                                                ),
                                                                                color:
                                                                                    ColorConstant.maingreen,
                                                                                child: Row(
                                                                                  mainAxisAlignment:
                                                                                      MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        "Action",
                                                                                        textAlign:
                                                                                            TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: Adaptive.sp(
                                                                                            15,
                                                                                          ),
                                                                                          shadows: [
                                                                                            Shadow(
                                                                                              color:
                                                                                                  Colors.white,
                                                                                              blurRadius:
                                                                                                  1,
                                                                                              offset: Offset(
                                                                                                0.2,
                                                                                                0.2,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                          color:
                                                                                              Colors.white,
                                                                                          fontWeight:
                                                                                              FontWeight.w800,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        "Scheme Name",
                                                                                        textAlign:
                                                                                            TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: Adaptive.sp(
                                                                                            15,
                                                                                          ),
                                                                                          shadows: [
                                                                                            Shadow(
                                                                                              color:
                                                                                                  Colors.white,
                                                                                              blurRadius:
                                                                                                  1,
                                                                                              offset: Offset(
                                                                                                0.2,
                                                                                                0.2,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                          color:
                                                                                              Colors.white,
                                                                                          fontWeight:
                                                                                              FontWeight.w800,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!.pf1,
                                                                                        textAlign:
                                                                                            TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          shadows: [
                                                                                            Shadow(
                                                                                              color:
                                                                                                  Colors.white,
                                                                                              blurRadius:
                                                                                                  1,
                                                                                              offset: Offset(
                                                                                                0.2,
                                                                                                0.2,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                          color:
                                                                                              Colors.white,
                                                                                          fontWeight:
                                                                                              FontWeight.w800,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!.interestRate1,
                                                                                        textAlign:
                                                                                            TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          shadows: [
                                                                                            Shadow(
                                                                                              color:
                                                                                                  Colors.white,
                                                                                              blurRadius:
                                                                                                  1,
                                                                                              offset: Offset(
                                                                                                0.2,
                                                                                                0.2,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                          color:
                                                                                              Colors.white,
                                                                                          fontWeight:
                                                                                              FontWeight.w800,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!.ltv1,
                                                                                        textAlign:
                                                                                            TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          shadows: [
                                                                                            Shadow(
                                                                                              color:
                                                                                                  Colors.white,
                                                                                              blurRadius:
                                                                                                  1,
                                                                                              offset: Offset(
                                                                                                0.2,
                                                                                                0.2,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                          color:
                                                                                              Colors.white,
                                                                                          fontWeight:
                                                                                              FontWeight.w800,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!.tenor,
                                                                                        textAlign:
                                                                                            TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          shadows: [
                                                                                            Shadow(
                                                                                              color:
                                                                                                  Colors.white,
                                                                                              blurRadius:
                                                                                                  1,
                                                                                              offset: Offset(
                                                                                                0.2,
                                                                                                0.2,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                          color:
                                                                                              Colors.white,
                                                                                          fontWeight:
                                                                                              FontWeight.w800,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    // Expanded(
                                                                                    //     child: Text("Days",
                                                                                    //         textAlign: TextAlign.center,
                                                                                    //         style: TextStyle(
                                                                                    //             fontSize: Adaptive.sp(16),
                                                                                    //             shadows:  [
                                                                                    //               Shadow(
                                                                                    //                   color: Colors.white,
                                                                                    //                   blurRadius: 1,
                                                                                    //                   offset: Offset(0.2, 0.2))
                                                                                    //             ],
                                                                                    //             color: Colors.white,
                                                                                    //             fontWeight: FontWeight.w800)))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              ListView.builder(
                                                                                itemCount:
                                                                                    value['data']['schemes']?.length ??
                                                                                    0,
                                                                                shrinkWrap:
                                                                                    true,
                                                                                itemBuilder:
                                                                                    (
                                                                                      context,
                                                                                      index,
                                                                                    ) =>
                                                                                        value['data']['schemes'][index]['scheme_name'].toString().toLowerCase().trim() ==
                                                                                                "bnpl takeover"
                                                                                            ? SizedBox()
                                                                                            : Container(
                                                                                              color:
                                                                                                  index %
                                                                                                              2 ==
                                                                                                          0
                                                                                                      ? Colors.grey.withOpacity(
                                                                                                        0.1,
                                                                                                      )
                                                                                                      : Colors.white,
                                                                                              child: Padding(
                                                                                                padding: Pad(
                                                                                                  all:
                                                                                                      10,
                                                                                                ),
                                                                                                child: Row(
                                                                                                  mainAxisAlignment:
                                                                                                      MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      child: Checkbox(
                                                                                                        activeColor:
                                                                                                            ColorConstant.maingreen,
                                                                                                        value:
                                                                                                            ref.watch(
                                                                                                              selectedIndex,
                                                                                                            ) ==
                                                                                                            index,
                                                                                                        onChanged: (
                                                                                                          isSelected,
                                                                                                        ) {
                                                                                                          if (isSelected ??
                                                                                                              false) {
                                                                                                            ref
                                                                                                                .watch(
                                                                                                                  selectedIndex.notifier,
                                                                                                                )
                                                                                                                .state = index;
                                                                                                          } else {
                                                                                                            ref.invalidate(
                                                                                                              selectedIndex,
                                                                                                            );
                                                                                                          }
                                                                                                          setState(
                                                                                                            () {},
                                                                                                          );
                                                                                                        },
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      child: Text(
                                                                                                        "${value['data']['schemes'][index]['scheme_name'] ?? ""}",
                                                                                                        textAlign:
                                                                                                            TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          fontSize: Adaptive.sp(
                                                                                                            16,
                                                                                                          ),
                                                                                                          shadows: [
                                                                                                            Shadow(
                                                                                                              color:
                                                                                                                  Colors.white,
                                                                                                              blurRadius:
                                                                                                                  1,
                                                                                                              offset: Offset(
                                                                                                                0.2,
                                                                                                                0.2,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                          color:
                                                                                                              Colors.black,
                                                                                                          fontWeight:
                                                                                                              FontWeight.w800,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      child: Text(
                                                                                                        "${value['data']['schemes'][index]['processing_fee'] ?? ""}",
                                                                                                        textAlign:
                                                                                                            TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          fontSize: Adaptive.sp(
                                                                                                            16,
                                                                                                          ),
                                                                                                          shadows: [
                                                                                                            Shadow(
                                                                                                              color:
                                                                                                                  Colors.white,
                                                                                                              blurRadius:
                                                                                                                  1,
                                                                                                              offset: Offset(
                                                                                                                0.2,
                                                                                                                0.2,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                          color:
                                                                                                              Colors.black,
                                                                                                          fontWeight:
                                                                                                              FontWeight.w800,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      child: Text(
                                                                                                        "${value['data']['schemes'][index]['interest_rate'] ?? ""}",
                                                                                                        textAlign:
                                                                                                            TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          fontSize: Adaptive.sp(
                                                                                                            16,
                                                                                                          ),
                                                                                                          shadows: [
                                                                                                            Shadow(
                                                                                                              color:
                                                                                                                  Colors.white,
                                                                                                              blurRadius:
                                                                                                                  1,
                                                                                                              offset: Offset(
                                                                                                                0.2,
                                                                                                                0.2,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                          color:
                                                                                                              Colors.black,
                                                                                                          fontWeight:
                                                                                                              FontWeight.w800,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      child: Text(
                                                                                                        "${value['data']['schemes'][index]['ltv'] ?? ""}",
                                                                                                        textAlign:
                                                                                                            TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          fontSize: Adaptive.sp(
                                                                                                            16,
                                                                                                          ),
                                                                                                          shadows: [
                                                                                                            Shadow(
                                                                                                              color:
                                                                                                                  Colors.white,
                                                                                                              blurRadius:
                                                                                                                  1,
                                                                                                              offset: Offset(
                                                                                                                0.2,
                                                                                                                0.2,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                          color:
                                                                                                              Colors.black,
                                                                                                          fontWeight:
                                                                                                              FontWeight.w800,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      child: Text(
                                                                                                        "${value['data']['schemes'][index]['tenor']} ${value['data']['schemes'][index]['tenor_type']}",
                                                                                                        textAlign:
                                                                                                            TextAlign.center,
                                                                                                        style: TextStyle(
                                                                                                          fontSize: Adaptive.sp(
                                                                                                            16,
                                                                                                          ),
                                                                                                          shadows: [
                                                                                                            Shadow(
                                                                                                              color:
                                                                                                                  Colors.white,
                                                                                                              blurRadius:
                                                                                                                  1,
                                                                                                              offset: Offset(
                                                                                                                0.2,
                                                                                                                0.2,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                          color:
                                                                                                              Colors.black,
                                                                                                          fontWeight:
                                                                                                              FontWeight.w800,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    // Expanded(
                                                                                                    //     child: Text(
                                                                                                    //         data.data?[index]
                                                                                                    //                 .loanPassDays ??
                                                                                                    //             "",,
                                                                                                    //         textAlign: TextAlign.center,
                                                                                                    //         style: TextStyle(
                                                                                                    //             fontSize: Adaptive.sp(16),
                                                                                                    //             shadows:  [
                                                                                                    //               Shadow(
                                                                                                    //                   color: Colors.white,
                                                                                                    //                   blurRadius: 1,
                                                                                                    //                   offset: Offset(
                                                                                                    //                       0.2, 0.2))
                                                                                                    //             ],
                                                                                                    //             color: Colors.black,
                                                                                                    //             fontWeight:
                                                                                                    //                 FontWeight.w800)))
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                              ),
                                                                              SizedBox(
                                                                                height:
                                                                                    10,
                                                                              ),
                                                                              SizedBox(
                                                                                width:
                                                                                    Get.width,
                                                                                child: ElevatedButton(
                                                                                  onPressed: () {
                                                                                    if (ref.watch(
                                                                                          selectedIndex,
                                                                                        ) ==
                                                                                        null) {
                                                                                      Fluttertoast.showToast(
                                                                                        msg:
                                                                                            "Please select a Scheme!",
                                                                                      );
                                                                                    } else {
                                                                                      context.showLoader();
                                                                                      ref
                                                                                          .watch(
                                                                                            postSbtProvider(
                                                                                              productId:
                                                                                                  "${dataList[mainIndex ?? 0].productId}",
                                                                                              commodityId:
                                                                                                  "${dataList[mainIndex ?? 0].commodityId}",
                                                                                              district_id:
                                                                                                  "${dataList[mainIndex ?? 0].districtId}",
                                                                                              qty:
                                                                                                  "${ref.watch(buyWeight)}",
                                                                                              price:
                                                                                                  "${ref.watch(buyPrice)}",
                                                                                              type:
                                                                                                  "1",
                                                                                              loanType:
                                                                                                  "2",
                                                                                              schemeId:
                                                                                                  "${value['data']['schemes'][ref.watch(selectedIndex)]['id']}",
                                                                                            ).future,
                                                                                          )
                                                                                          .then(
                                                                                            (
                                                                                              value,
                                                                                            ) {
                                                                                              context.hideloader();
                                                                                              if (value['status'].toString() ==
                                                                                                  "0") {
                                                                                              } else {
                                                                                                Get.back(
                                                                                                  closeOverlays:
                                                                                                      true,
                                                                                                  canPop:
                                                                                                      true,
                                                                                                );
                                                                                              }
                                                                                            },
                                                                                          )
                                                                                          .onError(
                                                                                            (
                                                                                              e,
                                                                                              s,
                                                                                            ) {
                                                                                              context.hideloader();
                                                                                            },
                                                                                          );
                                                                                    }
                                                                                  },
                                                                                  style:
                                                                                      AppStyle.buttonStyle,
                                                                                  child: Text(
                                                                                    "Apply",
                                                                                    style: TextStyle(
                                                                                      color:
                                                                                          Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                );
                                              }
                                            }
                                          })
                                          .onError((e, s) {
                                            context.hideloader();
                                          });
                                    },
                                    style: AppStyle.buttonStyle.copyWith(
                                      backgroundColor: WidgetStateProperty.all(
                                        Colors.amber,
                                      ),
                                    ),
                                    child: Text(
                                      'Purchase Finance',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            children: [
                              Padding(
                                padding: Pad(all: 10),
                                child: Column(
                                  children: [
                                    // Image.asset('assets/images/swfl.png'),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Text(
                                      "You dont have sufficient balance for this transaction you can opt for ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(16),
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    SizedBox(height: 10, child: Divider()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    );
                  }
                } else {}
              }
            })
            .onError((e, s) {});
      },
      onNegativeButton: () {
        Get.back();
      },
      positiveText: 'Submit',
      negativeText: 'No',
      variant: ElevarmDialogVariant.success,
    ).show(context);
  }

  _deliverCentersLoader() => Skeletonizer(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      padding: Pad(all: 0),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, whIndex) {
        return InkWell(
          onTap: () async {},
          child: Card(
            elevation: 1,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorConstant.maingreen),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            surfaceTintColor: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "",
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  MapsLauncher.launchQuery("");
                                },
                                child: Text(
                                  'Locate',
                                  style: TextStyle(
                                    color: ColorConstant.maingreen,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    decorationColor: ColorConstant.maingreen,
                                    fontSize: Adaptive.sp(16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: Adaptive.sp(16),
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: Pad(all: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorConstant.maingreen,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Charges',
                          style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Table(
                          border: TableBorder.all(
                            color: ColorConstant.maingreen,
                          ),
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text(
                                    'Labour Rate - ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Entry Load -  ',
                                      children: [
                                        TextSpan(
                                          text: '\nSeller',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text.rich(
                                    TextSpan(
                                      text:
                                          'Exit Load - rent lock-in applicable  ',
                                      children: [
                                        TextSpan(
                                          text: 'Outwards',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Weight Shortage Allowance -   ',
                                      children: [
                                        TextSpan(
                                          text: '\nStockist',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text.rich(
                                    TextSpan(
                                      text:
                                          'Rent - \u{20B9} / per Qtl. / per month ',
                                      children: [
                                        TextSpan(
                                          text: '\nStockist',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text(
                                    'Balance space in mixed Stacks -  (in Qtl.)',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // TableRow(children: [
                            //   Padding(padding:  Pad(all: 10), child: Text('Balance space in mixed Stacks - ${item?.emptySpace ?? 0} (in Qtl.)', style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold))),
                            //   Padding(padding:  Pad(all: 10), child: Text('', style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold))),
                            // ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: Get.width,
                //   padding: Pad(all: 10),
                //   decoration: BoxDecoration(
                //       color: ColorConstant.maingreen,
                //       borderRadius:  BorderRadius.only(
                //         bottomRight: Radius.circular(8),
                //         bottomLeft: Radius.circular(8),
                //       )),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text.rich(TextSpan(text: 'Labour Rate - ${item?.labourRate ?? 0}r s / per Qtl.', style: TextStyle(fontSize: Adaptive.sp(16), color: Colors.white, fontWeight: FontWeight.bold), recognizer: TapGestureRecognizer()..onTap = () async {}, children: [])),
                //       // Text.rich(TextSpan(
                //       //     text: 'Delivery Centres',
                //       //     style: TextStyle(fontSize: Adaptive.sp(16), color: Colors.white, fontWeight: FontWeight.bold),
                //       //     recognizer: TapGestureRecognizer()
                //       //       ..onTap = () async {
                //       //
                //       //         ref.watch(warehouseListProvider(id: "${data.data?[index].productId}").future).then((value) {
                //       //
                //       //         });
                //       //       },
                //       //     children: [])),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    ),
  );
  _commodityParamsLoader() => Skeletonizer(
    child: ColumnSuper(
      children: [
        SizedBox(height: 10),
        Center(
          child: Text(
            "${AppLocalizations.of(context)!.qualityParameters}  - ",
            style: TextStyle(
              fontSize: Adaptive.sp(17),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: Pad(bottom: 10),
          child: RowSuper(
            fill: true,
            children: [
              DataTable(
                headingRowColor: WidgetStateProperty.all(
                  ColorConstant.maingreen,
                ),
                showBottomBorder: true,
                columnSpacing: 36,
                headingTextStyle: TextStyle(color: Colors.white),
                border: TableBorder(borderRadius: BorderRadius.circular(10)),
                columns: [
                  DataColumn(
                    label: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.name,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.normal,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.extreme,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                rows: List.generate(
                  4,
                  (qualityIndex) => DataRow(
                    color: WidgetStateProperty.all(
                      qualityIndex % 2 == 0
                          ? Colors.white
                          : Colors.grey.withOpacity(0.1),
                    ),
                    cells: [
                      DataCell(
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '0',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: Adaptive.sp(16),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '0',
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '0',
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    ),
  );

  Widget _deliveryCenters(dynamic productId, dynamic sbtType) => Consumer(
    builder:
        (context, ref, child) => FutureBuilder<Position>(
          future: Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return _deliverCentersLoader();
            }
            final userPosition = snapshot.data!;

            return ref
                .watch(warehouseListProvider(id: productId))
                .when(
                  data: (value) {
                    var deliveryCenterList =
                        value.data
                            ?.where(
                              (e) =>
                                  num.parse(
                                    e.emptySpace.toString(),
                                  ).toStringAsFixed(0) !=
                                  "0",
                            )
                            .toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: deliveryCenterList?.length,
                      padding: Pad(all: 0),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, whIndex) {
                        var item = deliveryCenterList?[whIndex];

                        // Calculate distance
                        double? distanceKm;
                        if (item?.lat != null && item?.long != null) {
                          distanceKm =
                              Geolocator.distanceBetween(
                                userPosition.latitude,
                                userPosition.longitude,
                                double.tryParse(item!.lat.toString()) ?? 0.0,
                                double.tryParse(item.long.toString()) ?? 0.0,
                              ) /
                              1000; // Convert meters to kilometers
                        }

                        return InkWell(
                          onTap: () async {},
                          child: Card(
                            elevation: 1,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            surfaceTintColor: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      text:
                                                          "${item?.warehouseName}",
                                                      style: TextStyle(
                                                        color:
                                                            ColorConstant
                                                                .maingreen,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: Adaptive.sp(
                                                          16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (distanceKm != null)
                                                    Text(
                                                      "Distance: ${distanceKm.toStringAsFixed(1)} km",
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: Adaptive.sp(
                                                          14,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                MapsLauncher.launchQuery(
                                                  "${item?.warehouseAddress ?? ""}",
                                                );
                                              },
                                              child: Text(
                                                'Locate',
                                                style: TextStyle(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontWeight: FontWeight.bold,
                                                  decorationColor:
                                                      ColorConstant.maingreen,
                                                  fontSize: Adaptive.sp(16),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        "- ${item?.warehouseAddress}",
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: Pad(all: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.maingreen,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          'Charges',
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        child:
                                            sbtType.toString() == "1"
                                                ? Table(
                                                  border: TableBorder.all(
                                                    color:
                                                        ColorConstant.maingreen,
                                                  ),
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text(
                                                            'Labour Rate - ${item?.labourRate ?? 0}\u{20B9} / per Qtl.',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  'Entry Load - ${item?.entryLoad ?? 0}% ',
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      '\nSeller',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  'Exit Load - rent lock-in applicable  ',
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Outwards',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  'Weight Shortage Allowance - ${item?.wsa ?? 0}%  ',
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      '\nStockist',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  'Rent - ${item?.rent ?? 0}\u{20B9} / per Qtl. / per month ',
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      '\nStockist',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text(
                                                            'Balance space in mixed Stacks - ${item?.emptySpace ?? 0} (in Qtl.)',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // TableRow(children: [
                                                    //   Padding(padding:  Pad(all: 10), child: Text('Balance space in mixed Stacks - ${item?.emptySpace ?? 0} (in Qtl.)', style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold))),
                                                    //   Padding(padding:  Pad(all: 10), child: Text('', style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold))),
                                                    // ]),
                                                  ],
                                                )
                                                : Table(
                                                  border: TableBorder.all(
                                                    color:
                                                        ColorConstant.maingreen,
                                                  ),
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text(
                                                            'Labour Rate - ${item?.labourRate ?? 0}\u{20B9} / per Qtl.',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  'Entry Load - ${item?.entryLoad ?? 0}% ',
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      '\nSeller',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // TableRow(children: [
                                                    //   Padding(padding:  Pad(all: 10), child: Text.rich(TextSpan(text: 'Exit Load - rent lock-in applicable  ', children: [TextSpan(text: '\Outwards', style: TextStyle(color: Colors.red))]), style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold))),
                                                    //   Padding(padding:  Pad(all: 10), child: Text.rich(TextSpan(text: 'Weight Shortage Allowance - ${item?.wsa ?? 0}%  ', children: [TextSpan(text: '\nStockist', style: TextStyle(color: Colors.red))]), style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold))),
                                                    // ]),
                                                    TableRow(
                                                      children: [
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text(
                                                            'Balance space in mixed Stacks - ${item?.emptySpace ?? 0} (in Qtl.)',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text.rich(
                                                            TextSpan(
                                                              text: '',
                                                              children: [
                                                                TextSpan(
                                                                  text: '',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // TableRow(children: [
                                                    //   Padding(padding:  Pad(all: 10), child: Text('Balance space in mixed Stacks - ${item?.emptySpace ?? 0} (in Qtl.)', style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold))),
                                                    //   Padding(padding:  Pad(all: 10), child: Text('', style: TextStyle(fontSize: Adaptive.sp(16), fontWeight: FontWeight.bold))),
                                                    // ]),
                                                  ],
                                                ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   width: Get.width,
                                //   padding: Pad(all: 10),
                                //   decoration: BoxDecoration(
                                //       color: ColorConstant.maingreen,
                                //       borderRadius:  BorderRadius.only(
                                //         bottomRight: Radius.circular(8),
                                //         bottomLeft: Radius.circular(8),
                                //       )),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text.rich(TextSpan(text: 'Labour Rate - ${item?.labourRate ?? 0}r s / per Qtl.', style: TextStyle(fontSize: Adaptive.sp(16), color: Colors.white, fontWeight: FontWeight.bold), recognizer: TapGestureRecognizer()..onTap = () async {}, children: [])),
                                //       // Text.rich(TextSpan(
                                //       //     text: 'Delivery Centres',
                                //       //     style: TextStyle(fontSize: Adaptive.sp(16), color: Colors.white, fontWeight: FontWeight.bold),
                                //       //     recognizer: TapGestureRecognizer()
                                //       //       ..onTap = () async {
                                //       //
                                //       //         ref.watch(warehouseListProvider(id: "${data.data?[index].productId}").future).then((value) {
                                //       //
                                //       //         });
                                //       //       },
                                //       //     children: [])),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  error:
                      (error, stackTrace) => Container(
                        child: Center(
                          child: Text('Error loading delivery centers'),
                        ),
                      ),
                  loading: () => _deliverCentersLoader(),
                );
          },
        ),
  );
  Widget _commodityParamsLayout(
    dynamic productId,
    dynamic commodity,
  ) => Consumer(
    builder:
        (context, ref, child) => ref
            .watch(productQualityProvider(id: "$productId"))
            .when(
              data:
                  (value) => Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: ColumnSuper(
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "${AppLocalizations.of(context)!.qualityParameters}  - $commodity",
                            style: TextStyle(
                              fontSize: Adaptive.sp(17),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: Pad(bottom: 10),
                          child: RowSuper(
                            fill: true,
                            children: [
                              DataTable(
                                headingRowColor: WidgetStateProperty.all(
                                  ColorConstant.maingreen,
                                ),
                                showBottomBorder: true,
                                columnSpacing: 36,
                                headingTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: TableBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                columns: [
                                  DataColumn(
                                    label: Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.name,
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.normal,
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.extreme,
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                  value.data?.length ?? 0,
                                  (qualityIndex) => DataRow(
                                    color: WidgetStateProperty.all(
                                      qualityIndex % 2 == 0
                                          ? Colors.white
                                          : Colors.grey.withOpacity(0.1),
                                    ),
                                    cells: [
                                      DataCell(
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${value.data?[qualityIndex].parameters?.parameter ?? ""}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Adaptive.sp(16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${value.data?[qualityIndex].min ?? ""}',
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${value.data?[qualityIndex].max ?? ""}',
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
              error: (e, s) => Container(),
              loading: () => _commodityParamsLoader(),
            ),
  );
}
