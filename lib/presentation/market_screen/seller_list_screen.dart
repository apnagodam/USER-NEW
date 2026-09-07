import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/helper.dart';
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

class SellerList extends ConsumerWidget {
  const SellerList({super.key, required this.data, required this.index});

  final SbtDatum? data;
  final int? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellPriceController = TextEditingController();
    final sellWeightController = TextEditingController();
    return ref
        .watch(getBuyerSellerListProvider(cityState: "${data?.productId}"))
        .when(
          data:
              (value) => Padding(
                padding: Pad(all: 10),
                child: Column(
                  children: [
                    // Container(
                    //   height: 30,
                    //   color: ColorConstant.red500,
                    //   child: Center(
                    //       child: Text(
                    //         AppLocalizations.of(context)!.msgSellerbid,
                    //         style: TextStyle(
                    //
                    //             color: Colors.white,
                    //             fontSize: Adaptive.sp(16)),
                    //       )),
                    // ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.seller,
                        textAlign: TextAlign.start,
                        style: ElevarmFontFamilies.inter(
                          fontSize: Adaptive.sp(18),
                          fontWeight: FontWeight.bold,
                          color: ElevarmColors.danger700,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.seller,
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
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.sellerData?.length ?? 0,
                      itemBuilder: (context, index) {
                        Future.delayed(Duration.zero, () {
                          sellPriceController.text =
                              '${value.sellerData?[index].rate ?? "0.0"}';
                          sellWeightController.text =
                              '${value.sellerData?[index].qty ?? "0.0"}';
                        });
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Seller ${index + 1}',
                                style: ElevarmFontFamilies.inter(
                                  fontSize: Adaptive.sp(16),
                                  fontWeight: FontWeight.bold,
                                  color: ElevarmColors.danger700,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${value.sellerData?[index].qty ?? "0.0"}',
                                style: ElevarmFontFamilies.inter(
                                  fontSize: Adaptive.sp(16),
                                  fontWeight: FontWeight.bold,
                                  color: ElevarmColors.danger700,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                sbtCurrencyFormat.format(
                                  double.parse(
                                    value.sellerData?[index].rate ?? "0.0",
                                  ),
                                ),
                                style: ElevarmFontFamilies.inter(
                                  fontSize: Adaptive.sp(16),
                                  fontWeight: FontWeight.bold,
                                  color: ElevarmColors.danger700,
                                ),
                              ),
                            ),
                            Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible:
                                  value.sellerData?[index].type.toString() ==
                                  "1",
                              child: Align(
                                alignment: Alignment.topRight,
                                child: RowSuper(
                                  children: [
                                    PopupMenuButton(
                                      itemBuilder:
                                          (ctx) => [
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
                                                    'Edit',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: Adaptive.sp(16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                sellPriceController.text =
                                                    '${value.sellerData?[index].rate ?? "0.0"}';
                                                sellWeightController.text =
                                                    '${value.sellerData?[index].qty ?? "0.0"}';

                                                showBarModalBottomSheet(
                                                  context: context,
                                                  backgroundColor: Colors.white,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                          top: Radius.circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                  ),
                                                  builder: (context) {
                                                    return Consumer(
                                                      builder:
                                                          (
                                                            consumer,
                                                            ref,
                                                            child,
                                                          ) => SingleChildScrollView(
                                                            child: Padding(
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
                                                                    padding: const EdgeInsets.only(
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
                                                                          fontSize: Adaptive.sp(
                                                                            18,
                                                                          ),
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.only(
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
                                                                          fontSize: Adaptive.sp(
                                                                            16,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeight.bold,
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
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  const SizedBox(
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
                                                                      //               "${widget.data?.commodity}")
                                                                      //     ])),
                                                                      Text.rich(
                                                                        TextSpan(
                                                                          text:
                                                                              '${AppLocalizations.of(context)!.msgDate} ${data?.date}',
                                                                          style: TextStyle(
                                                                            fontSize: Adaptive.sp(
                                                                              16,
                                                                            ),
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const Divider(),
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
                                                                            ColorConstant.maingreen,
                                                                        fontWeight:
                                                                            FontWeight.bold,
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        controller:
                                                                            sellPriceController,
                                                                        label:
                                                                            AppLocalizations.of(
                                                                              context,
                                                                            )!.enterSellPrice,
                                                                        inputType: TextInputType.numberWithOptions(
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
                                                                  const Divider(),
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
                                                                            ColorConstant.maingreen,
                                                                        fontWeight:
                                                                            FontWeight.bold,
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
                                                                          all:
                                                                              10,
                                                                        ),
                                                                        child: SizedBox(
                                                                          width:
                                                                              Get.width,
                                                                          child: CommonTextField(
                                                                            controller:
                                                                                sellWeightController,
                                                                            textInputAction:
                                                                                TextInputAction.next,
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
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                  ref
                                                                      .watch(
                                                                        sbtTermsProvider(
                                                                          userType:
                                                                              "2",
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
                                                                        const EdgeInsets.only(
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
                                                                                fontWeight:
                                                                                    FontWeight.w500,
                                                                                color:
                                                                                    Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Expanded(
                                                                          child: ElevatedButton(
                                                                            style:
                                                                                AppStyle.buttonStyle,
                                                                            onPressed: () async {
                                                                              var sellPrice = num.parse(
                                                                                sellPriceController.text.isEmpty
                                                                                    ? "0.0"
                                                                                    : sellPriceController.text,
                                                                              );
                                                                              var sellWeight = num.parse(
                                                                                sellWeightController.text.isEmpty
                                                                                    ? "0.0"
                                                                                    : sellWeightController.text,
                                                                              );
                                                                              if (sellPrice <
                                                                                      1 ||
                                                                                  sellWeight <
                                                                                      1) {
                                                                                showErrorAlertDialog(
                                                                                  context,
                                                                                  AppLocalizations.of(
                                                                                    context,
                                                                                  )!.pleaseInputValidValue,
                                                                                );
                                                                              } else {
                                                                                context.showLoader();
                                                                                ref
                                                                                    .read(
                                                                                      updateSbtProvider(
                                                                                        productId:
                                                                                            "${data?.productId}",
                                                                                        tradeId:
                                                                                            "${value.sellerData?[index].tradeId}",
                                                                                        commodityId:
                                                                                            "${data?.commodityId}",
                                                                                        district_id:
                                                                                            "${data?.districtId}",
                                                                                        qty:
                                                                                            sellWeightController.text,
                                                                                        price:
                                                                                            sellPriceController.text,
                                                                                        type:
                                                                                            "2",
                                                                                      ).future,
                                                                                    )
                                                                                    .then(
                                                                                      (
                                                                                        res,
                                                                                      ) {
                                                                                        context.hideloader();
                                                                                        if (res['status'].toString() ==
                                                                                            "1") {
                                                                                          ref.invalidate(
                                                                                            getBuyerSellerListProvider,
                                                                                          );

                                                                                          ref.invalidate(
                                                                                            getSbtCommodityProvider,
                                                                                          );

                                                                                          ref.invalidate(
                                                                                            matchedOrdersProvider,
                                                                                          );

                                                                                          Get.back();
                                                                                          Get.rawSnackbar(
                                                                                            message: "${res['message']}",
                                                                                            duration: const Duration(seconds: 2),
                                                                                            backgroundColor: ColorConstant.maingreen,
                                                                                          );
                                                                                        } else {
                                                                                          showErrorAlertDialog(context, res['message']);
                                                                                        }
                                                                                      },
                                                                                    )
                                                                                    .onError(
                                                                                      (
                                                                                        e,
                                                                                        s,
                                                                                      ) {
                                                                                        context.hideloader();
                                                                                        showErrorAlertDialog(context, "An error occurred: $e");
                                                                                      },
                                                                                    );
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: Adaptive.sp(16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                ref
                                                    .watch(
                                                      deleteOrderProvider(
                                                        orderId:
                                                            "${value.sellerData?[index].tradeId}",
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
                                                        showErrorAlertDialog(context, value['message']);
                                                      }
                                                    })
                                                    .onError((e, s) {});
                                              },
                                            ),
                                            // _buildPopupMenuItem('Search', Icons.search),
                                            // _buildPopupMenuItem('Upload', Icons.upload),
                                            // _buildPopupMenuItem('Copy', Icons.copy),
                                            // _buildPopupMenuItem('Exit', Icons.exit_to_app),
                                          ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
          error: (e, s) => Container(child: Text(e.toString())),
          loading: () => _sellerLoader(context),
        );
  }

  _sellerLoader(BuildContext context) => Skeletonizer(
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
        const SizedBox(height: 10),
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
                                      const SizedBox(width: 10),
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
                                      const SizedBox(width: 10),
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
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ],
    ),
  );
}
