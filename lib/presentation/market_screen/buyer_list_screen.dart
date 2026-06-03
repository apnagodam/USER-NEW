// ignore_for_file: unnecessary_string_interpolations

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/dashboard/model/sbt_commodity_model.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/market_screen/market_screen.dart';
import 'package:apnagodam/presentation/market_screen/service/market_service.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BuyerList extends ConsumerWidget {
  const BuyerList({super.key, required this.data, required this.index});

  final SbtDatum? data;
  final int? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buyPriceController = TextEditingController(text: '0');
    final buyWeightController = TextEditingController(text: '0');
    return ref
        .watch(getBuyerSellerListProvider(cityState: "${data?.productId}"))
        .when(
          data: (value) {
            Future.delayed(Duration.zero, () {
              buyPriceController.text =
                  value.buyerData != null && value.buyerData!.isNotEmpty
                      ? '${value.buyerData?[0].rate}'
                      : '0';

              buyWeightController.text =
                  value.buyerData != null && value.buyerData!.isNotEmpty
                      ? '${value.buyerData?[0].qty}'
                      : '0';
            });
            return Padding(
              padding: Pad(all: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   height: 30,
                  //   color: ColorConstant.maingreen,
                  //   child: Center(
                  //       child: Text(
                  //         AppLocalizations.of(context)!.msgBuyerbid,
                  //         style: TextStyle(
                  //
                  //             color: Colors.white,
                  //             fontSize: Adaptive.sp(16)),
                  //       )),
                  // ),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.buyer,
                      textAlign: TextAlign.start,
                      style: ElevarmFontFamilies.inter(
                        fontSize: Adaptive.sp(18),
                        fontWeight: FontWeight.bold,
                        color: ElevarmColors.success800,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.buyer,
                          textAlign: TextAlign.start,
                          style: ElevarmFontFamilies.inter(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.qtyQtl,
                          textAlign: TextAlign.start,
                          style: ElevarmFontFamilies.inter(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.rate,
                          textAlign: TextAlign.start,
                          style: ElevarmFontFamilies.inter(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.edit,
                        textAlign: TextAlign.start,
                        style: ElevarmFontFamilies.inter(
                          fontSize: Adaptive.sp(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevarmDivider(height: 10, color: ElevarmColors.neutral300),
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Buyer ${index + 1}',
                              style: ElevarmFontFamilies.inter(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold,
                                color: ElevarmColors.success800,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${value.buyerData?[index].qty}',
                              style: ElevarmFontFamilies.inter(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold,
                                color: ElevarmColors.success800,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${sbtCurrencyFormat.format(double.parse(value.buyerData?[index].rate ?? "0.0"))}',
                              style: ElevarmFontFamilies.inter(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold,
                                color: ElevarmColors.success800,
                              ),
                            ),
                          ),
                          Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible:
                                value.buyerData?[index].type.toString() == "1",
                            child: Align(
                              alignment: Alignment.topRight,
                              child: RowSuper(
                                children: [
                                  PopupMenuButton(
                                    itemBuilder:
                                        (context) => [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons
                                                      .pencil_circle_fill,
                                                  color:
                                                      ColorConstant.maingreen,
                                                  size: Adaptive.sp(16),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.edit,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              buyPriceController.text =
                                                  '${value.buyerData?[index].rate ?? "0.0"}';
                                              buyWeightController.text =
                                                  '${value.buyerData?[index].qty ?? "0.0"}';

                                              showBarModalBottomSheet(
                                                context: context,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                        top: Radius.circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                ),
                                                builder: (context) {
                                                  return SingleChildScrollView(
                                                    child: Consumer(
                                                      builder: (
                                                        consumerContext,
                                                        ref,
                                                        child,
                                                      ) {
                                                        // Add price listener only once

                                                        return Padding(
                                                          padding: Pad(
                                                            bottom:
                                                                MediaQuery.of(
                                                                      context,
                                                                    )
                                                                    .viewInsets
                                                                    .bottom,
                                                            top: 10,
                                                            left: 10,
                                                            right: 10,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                      top: 12.0,
                                                                      bottom:
                                                                          7.0,
                                                                    ),
                                                                child: Center(
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.bidUpdate,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          Adaptive.sp(
                                                                            18,
                                                                          ),
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                      bottom:
                                                                          8.0,
                                                                    ),
                                                                child: Text.rich(
                                                                  TextSpan(
                                                                    text:
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.msgCommodity,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          Adaptive.sp(
                                                                            16,
                                                                          ),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            " : ${data?.commodity} (${data?.district})",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  // Text.rich(TextSpan(
                                                                  //     text:
                                                                  //         "Commodity: ",
                                                                  //     style: TextStyle(fontSize: Adaptive.sp(16),  fontWeight: FontWeight.bold),
                                                                  //     children: [
                                                                  //       TextSpan(
                                                                  //           text:
                                                                  //               "${widget.data?.data?[widget.index ?? 0].commodity}")
                                                                  //     ])),
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      text:
                                                                          '${AppLocalizations.of(context)!.msgDate} ${data?.date}',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                              16,
                                                                            ),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                      bottom:
                                                                          5.0,
                                                                    ),
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.msgYourprice,
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                          16,
                                                                        ),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    color:
                                                                        ColorConstant
                                                                            .maingreen,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: Pad(
                                                                  all: 10,
                                                                ),
                                                                child: SizedBox(
                                                                  width:
                                                                      Get.width,
                                                                  child: CommonTextField(
                                                                    controller:
                                                                        buyPriceController,
                                                                    label:
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.enterBuyPrice,
                                                                    inputType:
                                                                        TextInputType.numberWithOptions(
                                                                          decimal:
                                                                              true,
                                                                        ),
                                                                    hintText:
                                                                        '0',
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Divider(),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                      bottom:
                                                                          5.0,
                                                                    ),
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.msgNetweight,
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                          16,
                                                                        ),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    color:
                                                                        ColorConstant
                                                                            .maingreen,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: Pad(
                                                                  all: 10,
                                                                ),
                                                                child: SizedBox(
                                                                  width:
                                                                      Get.width,
                                                                  child: Padding(
                                                                    padding: Pad(
                                                                      all: 10,
                                                                    ),
                                                                    child: SizedBox(
                                                                      width:
                                                                          Get.width,
                                                                      child: CommonTextField(
                                                                        controller:
                                                                            buyWeightController,
                                                                        label:
                                                                            AppLocalizations.of(
                                                                              context,
                                                                            )!.enterWeight,
                                                                        inputType: TextInputType.numberWithOptions(
                                                                          decimal:
                                                                              true,
                                                                        ),
                                                                        hintText:
                                                                            '0.0',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              ref
                                                                  .watch(
                                                                    sbtTermsProvider(
                                                                      userType:
                                                                          "1",
                                                                      productId:
                                                                          "${data?.productId}",
                                                                    ),
                                                                  )
                                                                  .when(
                                                                    data:
                                                                        (
                                                                          data,
                                                                        ) => HtmlWidget(
                                                                          '${data['data'] ?? ""}',
                                                                        ),
                                                                    error:
                                                                        (
                                                                          e,
                                                                          s,
                                                                        ) =>
                                                                            Container(),
                                                                    loading:
                                                                        () => Center(
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                  ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                      top: 15,
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
                                                                        onPressed:
                                                                            () {
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
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Expanded(
                                                                      child: ElevatedButton(
                                                                        style:
                                                                            AppStyle.buttonStyle,
                                                                       onPressed: () async {
  var price = double.tryParse(buyPriceController.text) ?? 0.0;
  var weight = double.tryParse(buyWeightController.text) ?? 0.0;
  
  if (price < 1 || weight < 1) {
    context.errorToast(
      AppLocalizations.of(context)!.pleaseInputValidValue,
    );
  } else {
    // ✅ Use ref.read instead of ref.watch
    ref
        .read(
          updateSbtProvider(
            productId: "${data?.productId}",
            tradeId: "${value.buyerData?[index].tradeId}",
            commodityId: "${data?.commodityId}",
            district_id: "${data?.districtId}",
            qty: buyWeightController.text,
            price: buyPriceController.text,
            type: "1",
          ).future,
        )
        .then((value) {
          if (value['status'].toString() == "1") {
            ref.invalidate(getBuyerSellerListProvider);
            ref.invalidate(getSbtCommodityProvider);
            ref.invalidate(matchedOrdersProvider);
            Get.back();
            Get.rawSnackbar(
              message: "${value['message']}",
              duration: Duration(seconds: 10),
              backgroundColor: ColorConstant.maingreen,
            );
          } else {
            Get.rawSnackbar(
              message: "${value['message']}",
              duration: Duration(seconds: 10),
              backgroundColor: ColorConstant.red500,
            );
          }
        })
        .onError((e, s) {});
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
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.delete,
                                                  color:
                                                      ColorConstant.maingreen,
                                                  size: Adaptive.sp(16),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.remove,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              ref
                                                  .read(
                                                    deleteOrderProvider(
                                                      orderId:
                                                          "${value.buyerData?[index].tradeId}",
                                                    ).future,
                                                  )
                                                  .then((value) {
                                                    if (value['status']
                                                            .toString() ==
                                                        "1") {
                                                      ref.invalidate(
                                                        getBuyerSellerListProvider,
                                                      );
                                                      ref.invalidate(
                                                        getSbtCommodityProvider,
                                                      );
                                                    } else {
                                                      Get.rawSnackbar(
                                                        message:
                                                            value['message']
                                                                .toString(),
                                                        duration: Duration(
                                                          seconds: 10,
                                                        ),
                                                        backgroundColor:
                                                            ColorConstant
                                                                .red500,
                                                      );
                                                    }
                                                  });
                                            },
                                          ),
                                        ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: value.buyerData?.length ?? 0,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ],
              ),
            );
          },
          error: (e, s) => Container(),
          loading: () => _buyerLoader(context),
        );
  }

  _buyerLoader(BuildContext context) => Skeletonizer(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Container(
        //   height: 30,
        //   color: ColorConstant.maingreen,
        //   child: Center(
        //       child: Text(
        //         AppLocalizations.of(context)!.msgBuyerbid,
        //         style: TextStyle(
        //
        //             color: Colors.white,
        //             fontSize: Adaptive.sp(16)),
        //       )),
        // ),
        Center(
          child: Text(
            AppLocalizations.of(context)!.buyer,
            textAlign: TextAlign.start,
            style: ElevarmFontFamilies.inter(
              fontSize: Adaptive.sp(16),
              fontWeight: FontWeight.bold,
              color: ElevarmColors.success800,
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.qtyQtl,
                textAlign: TextAlign.start,
                style: ElevarmFontFamilies.inter(
                  fontSize: Adaptive.sp(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.rate,
                textAlign: TextAlign.start,
                style: ElevarmFontFamilies.inter(
                  fontSize: Adaptive.sp(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.edit,
              textAlign: TextAlign.start,
              style: ElevarmFontFamilies.inter(
                fontSize: Adaptive.sp(16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    '0',
                    style: ElevarmFontFamilies.inter(
                      fontSize: Adaptive.sp(16),
                      fontWeight: FontWeight.bold,
                      color: ElevarmColors.success800,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Text(
                    '0',
                    style: ElevarmFontFamilies.inter(
                      fontSize: Adaptive.sp(16),
                      fontWeight: FontWeight.bold,
                      color: ElevarmColors.success800,
                    ),
                  ),
                ),
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: true,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: RowSuper(
                      children: [
                        PopupMenuButton(
                          itemBuilder:
                              (context) => [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.pencil_circle_fill,
                                        color: ColorConstant.maingreen,
                                        size: Adaptive.sp(16),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Edit',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.delete,
                                        color: ColorConstant.maingreen,
                                        size: Adaptive.sp(16),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Remove',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {},
                                ),
                              ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: 6,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ],
    ),
  );
}
