import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/progress_dialog_utils.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/presentation/credit/credit_screen.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/market_screen/service/market_service.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../core/utils/helper.dart';
import '../../core/utils/image_constant.dart';
import '../../widgets/CommonTextField.dart';
import '../../widgets/dailogs/error.dart';

class Bidding extends ConsumerStatefulWidget {
  Bidding({super.key, this.id, this.status, this.sellerID});

  final id;
  final sellerID;
  String? status = "0";

  @override
  ConsumerState<Bidding> createState() => _BiddingState();
}

class _BiddingState extends ConsumerState<Bidding> {
  TextEditingController yourpricecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgcolor,
      appBar: AppBar(
        backgroundColor: ColorConstant.maingreen,
        automaticallyImplyLeading: true,
        title: Text(
          AppLocalizations.of(context)!.bidding,
        ),
        leadingWidth: 40,
      ),
      body: RefreshIndicator(
        color: ColorConstant.maingreen,
        onRefresh: () {
          return Future(() => ref.invalidate(getBiddingDataProvider));
        },
        child: ref
            .watch(getBiddingDataProvider(
                inventoryId: widget.sellerID, status: widget.status))
            .when(
                data: (data) => ListView(
                      primary: true,
                      padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(08),
                          decoration: BoxDecoration(
                            color: ColorConstant.maingreen,
                            borderRadius: BorderRadius.circular(06.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Gatepass No - ${data.inventoryInfo?.gatePassWr}"
                                    .tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(17)),
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              Text.rich(TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .msgTerminalname,
                                  style: AppStyle.lblbuydetail
                                      .copyWith(fontSize: Adaptive.sp(16)),
                                  children: [
                                    TextSpan(
                                        text: " :  ${data.inventoryInfo?.name}")
                                  ])),
                              const Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              IntrinsicHeight(
                                child: RowSuper(
                                  children: [
                                    RowSuper(
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!
                                                .msgQuantity,
                                            style: AppStyle.lblsellnbuy
                                                .copyWith(
                                                    fontSize: Adaptive.sp(16))),
                                        Text(
                                          " : ${data.inventoryInfo?.quantity}",
                                          style: AppStyle.lblsellnbuy.copyWith(
                                              fontSize: Adaptive.sp(16)),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 4),
                                      child: VerticalDivider(
                                        thickness: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    RowSuper(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .sellerPrice,
                                          style: AppStyle.lblsellnbuy.copyWith(
                                              fontSize: Adaptive.sp(16)),
                                        ),
                                        // Text(cont.yourpricecontroller.text,
                                        //   style: AppStyle.lblsellnbuy,
                                        // ),
                                        Text(
                                          '${data.inventoryInfo?.price}',
                                          style: AppStyle.lblsellnbuy.copyWith(
                                              fontSize: Adaptive.sp(16)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.quality,
                                      style: AppStyle.lblmoneybtn
                                          .copyWith(fontSize: Adaptive.sp(17)),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 6,
                              ),
                              (data.inventoryInfo?.invCases?.qv ?? []).isEmpty
                                  ? Center(
                                      child: Text(
                                      AppLocalizations.of(context)!.notFound,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Adaptive.sp(17)),
                                    ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      // scrollDirection: Axis.horizontal,
                                      primary: true,
                                      itemCount: data.inventoryInfo?.invCases
                                              ?.qv?.length ??
                                          0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            RowSuper(fill: true, children: [
                                              Text(
                                                "${data.inventoryInfo!.invCases!.qv![index].qualityParameters!.parameter}",
                                                style: AppStyle.lblsellnbuy
                                                    .copyWith(
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                              ),
                                              ColumnSuper(
                                                alignment:
                                                    Alignment.centerRight,
                                                children: [
                                                  Text(
                                                    '${data.inventoryInfo!.invCases!.qv![index].value}',
                                                    style: AppStyle.lblsellnbuy
                                                        .copyWith(
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    15)),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "",
                                                style: AppStyle.lbltermncon,
                                              )
                                            ]),
                                            const Divider(
                                              color: Colors.white,
                                              thickness: 2,
                                            ),
                                          ],
                                        );
                                      }),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.origin,
                                      style: AppStyle.lblmoneybtn
                                          .copyWith(fontSize: Adaptive.sp(17)),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.defined,
                                      style: AppStyle.lblmoneybtn
                                          .copyWith(fontSize: Adaptive.sp(17)),
                                    ),
                                    Text(
                                      "found",
                                      style: AppStyle.lbltermncon
                                          .copyWith(fontSize: Adaptive.sp(17)),
                                    )
                                  ]),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: ElevatedButton(
                          style: AppStyle.buttonStyle,
                          onPressed: () {
                            yourpricecontroller.clear();
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (bottomsheetContext) => Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom:
                                            MediaQuery.of(bottomsheetContext)
                                                    .viewInsets
                                                    .bottom +
                                                10,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .msgMybid,
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(17),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: Pad(all: 10),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      final current = double
                                                              .tryParse(
                                                                  yourpricecontroller
                                                                      .text) ??
                                                          0.0;
                                                      yourpricecontroller.text =
                                                          (current - 10)
                                                              .clamp(0.0, 25000.0)
                                                              .toString();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: ColorConstant
                                                              .maingreen,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      padding: Pad(all: 10),
                                                      child: Text('-10',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      18))),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          yourpricecontroller,
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: false),
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: '0.0',
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5),
                                                            borderSide: BorderSide(
                                                                color: ColorConstant
                                                                    .maingreen)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  GestureDetector(
                                                    onTap: () {
                                                      final current = double
                                                              .tryParse(
                                                                  yourpricecontroller
                                                                      .text) ??
                                                          0.0;
                                                      yourpricecontroller.text =
                                                          (current + 10)
                                                              .clamp(0.0, 25000.0)
                                                              .toString();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: ColorConstant
                                                              .maingreen,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      padding: Pad(all: 10),
                                                      child: Text('+10',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      18))),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // CommonTextField(
                                            //   controller: yourpricecontroller,
                                            //   textInputAction:
                                            //       TextInputAction.next,
                                            //   inputType: TextInputType.number,
                                            //   enabled: true,
                                            //   label: AppLocalizations.of(context)!.bidPrice,
                                            //   isOnlyDigit: true,
                                            //   isRequired: true,
                                            // ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Consumer(
                                                builder: (context, ref,
                                                        child) =>
                                                    ref
                                                        .watch(wbtTermsProvider(
                                                            invId: widget.id
                                                                .toString()))
                                                        .when(data: (data) {
                                                      return HtmlWidget(
                                                        data['data'] ?? "",
                                                      );
                                                    }, error: (e, s) {
                                                      return SizedBox();
                                                    }, loading: () {
                                                      return SizedBox();
                                                    })),

                                            SizedBox(
                                              height: 15,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                if (yourpricecontroller
                                                        .text.isNotEmpty &&
                                                    yourpricecontroller.text !=
                                                        "0.0") {
                                                  if (ref
                                                          .watch(
                                                              sharedUtilityProvider)
                                                          .getUser()
                                                          ?.userId
                                                          .toString() ==
                                                      widget.sellerID
                                                          .toString()) {
                                                    await ref
                                                        .watch(
                                                            updateBidProvider(
                                                      inventoryId: data
                                                          .inventoryInfo?.id
                                                          .toString(),
                                                      price: yourpricecontroller
                                                          .text,
                                                    ).future)
                                                        .then((value) {
                                                      if (value.status == "1") {
                                                        ref.invalidate(
                                                            getBiddingDataProvider(
                                                                inventoryId:
                                                                    widget.id,
                                                                status: widget
                                                                    .status));
                                                        ref.invalidate(
                                                            getMandiBhavProvider);
                                                        Get.back();
                                                        Get.rawSnackbar(
                                                          message:
                                                              value.message,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 2),
                                                          backgroundColor:
                                                              ColorConstant
                                                                  .maingreen,
                                                        );
                                                      } else if (value.status ==
                                                          "0") {
                                                        Get.back();
                                                        Get.rawSnackbar(
                                                          message:
                                                              value.message,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 2),
                                                          backgroundColor:
                                                              ColorConstant
                                                                  .red500,
                                                        );
                                                      } else {
                                                        Get.rawSnackbar(
                                                          message:
                                                              value.message,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 2),
                                                          backgroundColor:
                                                              ColorConstant
                                                                  .red500,
                                                        );
                                                      }
                                                    }).onError((e, s) {
                                                      errorBottomSheet(
                                                          context, "$e");
                                                    });

                                                    Get.back();

                                                    // .whenComplete(() =>  Get.back());
                                                  } else {
                                                    await ref
                                                        .watch(addBidProvider(
                                                      inventoryId: data
                                                          .inventoryInfo?.id
                                                          .toString(),
                                                      price: yourpricecontroller
                                                          .text,
                                                    ).future)
                                                        .then((value) {
                                                      if (value['status'] ==
                                                          "1") {
                                                        ref.invalidate(
                                                            getBiddingDataProvider);
                                                        ref.invalidate(
                                                            getMandiBhavProvider);
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                value['message']
                                                                    .toString(),
                                                            toastLength: Toast
                                                                .LENGTH_LONG,
                                                            backgroundColor:
                                                                ColorConstant
                                                                    .maingreen);
                                                      } else if (value[
                                                              'status'] ==
                                                          "0") {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                value['message']
                                                                    .toString(),
                                                            toastLength: Toast
                                                                .LENGTH_LONG,
                                                            backgroundColor:
                                                                ColorConstant
                                                                    .red500);
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                value['message']
                                                                    .toString(),
                                                            toastLength: Toast
                                                                .LENGTH_LONG,
                                                            backgroundColor:
                                                                ColorConstant
                                                                    .red500);
                                                      }
                                                    }).onError((e, s) {
                                                      errorBottomSheet(
                                                          context, "$e");
                                                    });

                                                    Get.back(
                                                        closeOverlays: true);

                                                    // .whenComplete(() =>  Get.back());
                                                  }
                                                } else {
                                                  Get.rawSnackbar(
                                                      message:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .bidError,
                                                      duration: const Duration(
                                                          seconds: 2),
                                                      backgroundColor:
                                                          ColorConstant.red500);
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  borderRadius:
                                                      BorderRadius.circular(08),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .submitBid,
                                                    style: AppStyle.lblmoneybtn
                                                        .copyWith(
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            // data.walletStatus == 1
                                            //     ? SizedBox()
                                            //     : Column(
                                            //         children: [
                                            //           Text(
                                            //             AppLocalizations.of(context)!.enoughtAmount,
                                            //             style: AppStyle
                                            //                 .lblonlinemandibiglistdetail
                                            //                 .copyWith(
                                            //                     fontSize:
                                            //                         Adaptive.sp(
                                            //                             15)),
                                            //           ),
                                            //           SizedBox(
                                            //             height: 20,
                                            //           ),
                                            //           // RowSuper(
                                            //           //   fill: true,
                                            //           //   children: [
                                            //           //     InkWell(
                                            //           //       onTap: () {
                                            //           //         showDialog(
                                            //           //           context:
                                            //           //               context,
                                            //           //           builder:
                                            //           //               (BuildContext
                                            //           //                   context) {
                                            //           //             return AlertDialog(
                                            //           //               surfaceTintColor:
                                            //           //                   Colors
                                            //           //                       .white,
                                            //           //               shape:
                                            //           //                   const RoundedRectangleBorder(
                                            //           //                 borderRadius:
                                            //           //                     BorderRadius.all(Radius.circular(8)),
                                            //           //               ),
                                            //           //               titlePadding:
                                            //           //                   EdgeInsets
                                            //           //                       .zero,
                                            //           //               actionsPadding:
                                            //           //                   EdgeInsets
                                            //           //                       .zero,
                                            //           //               buttonPadding:
                                            //           //                   EdgeInsets
                                            //           //                       .zero,
                                            //           //               contentPadding:
                                            //           //                   EdgeInsets
                                            //           //                       .zero,
                                            //           //               iconPadding:
                                            //           //                   EdgeInsets
                                            //           //                       .zero,
                                            //           //               insetPadding:
                                            //           //                   EdgeInsets
                                            //           //                       .zero,
                                            //           //               title:
                                            //           //                   Column(
                                            //           //                 children: [
                                            //           //                   Container(
                                            //           //                     decoration:
                                            //           //                         const BoxDecoration(color: ColorConstant.maingreen, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                                            //           //                     child:
                                            //           //                         Padding(
                                            //           //                       padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 10),
                                            //           //                       child: Row(
                                            //           //                         children: [
                                            //           //                           const Icon(
                                            //           //                             Icons.support_agent,
                                            //           //                             color: Colors.amber,
                                            //           //                           ),
                                            //           //                           const SizedBox(
                                            //           //                             width: 10,
                                            //           //                           ),
                                            //           //                           Text(AppLocalizations.of(context)!.msgHelp, style: AppStyle.lblbuydetail.copyWith(fontSize: Adaptive.sp(17))),
                                            //           //                         ],
                                            //           //                       ),
                                            //           //                     ),
                                            //           //                   ),
                                            //           //                   const SizedBox(
                                            //           //                     height:
                                            //           //                         8,
                                            //           //                   ),
                                            //           //                   ListTile(
                                            //           //                     onTap:
                                            //           //                         () async {
                                            //           //                       Get.back();
                                            //           //                       CallLaunch('whatsapp://send?text=sample text&phone=917733901154');
                                            //           //                     },
                                            //           //                     leading:
                                            //           //                         Container(
                                            //           //                       decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xfffcf2f0)),
                                            //           //                       child: Padding(
                                            //           //                         padding: const EdgeInsets.all(8.0),
                                            //           //                         child: Image.asset(
                                            //           //                           ImageConstant.imgwhatsapp,
                                            //           //                           width: 28,
                                            //           //                         ),
                                            //           //                       ),
                                            //           //                     ),
                                            //           //                     title:
                                            //           //                         Text(AppLocalizations.of(context)!.msgWhatsapp, style: AppStyle.lblalerttext.copyWith(fontSize: Adaptive.sp(17))),
                                            //           //                     trailing:
                                            //           //                         const Icon(
                                            //           //                       Icons.chevron_right_outlined,
                                            //           //                       color: Colors.black,
                                            //           //                     ),
                                            //           //                   ),
                                            //           //                   const Divider(
                                            //           //                     color:
                                            //           //                         ColorConstant.grey,
                                            //           //                   ),
                                            //           //                   ListTile(
                                            //           //                     onTap:
                                            //           //                         () {
                                            //           //                       Get.back();
                                            //           //                       CallLaunch('tel:7733901154');
                                            //           //                     },
                                            //           //                     leading:
                                            //           //                         Container(
                                            //           //                       decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xfffcf2f0)),
                                            //           //                       child: const Padding(
                                            //           //                         padding: EdgeInsets.all(8.0),
                                            //           //                         child: Icon(
                                            //           //                           Icons.phone,
                                            //           //                           color: Colors.black,
                                            //           //                         ),
                                            //           //                       ),
                                            //           //                     ),
                                            //           //                     title:
                                            //           //                         Text(AppLocalizations.of(context)!.msgCallforHelp, style: AppStyle.lblalerttext.copyWith(fontSize: Adaptive.sp(17))),
                                            //           //                     trailing:
                                            //           //                         const Icon(
                                            //           //                       Icons.chevron_right_outlined,
                                            //           //                       color: Colors.black,
                                            //           //                     ),
                                            //           //                   ),
                                            //           //                   const SizedBox(
                                            //           //                     height:
                                            //           //                         8,
                                            //           //                   ),
                                            //           //                 ],
                                            //           //               ),
                                            //           //             );
                                            //           //           },
                                            //           //         );
                                            //           //       },
                                            //           //       child: Container(
                                            //           //         padding:
                                            //           //             EdgeInsets
                                            //           //                 .all(
                                            //           //                     10),
                                            //           //         decoration:
                                            //           //             BoxDecoration(
                                            //           //           borderRadius:
                                            //           //               BorderRadius
                                            //           //                   .circular(
                                            //           //                       08),
                                            //           //           color: ColorConstant
                                            //           //               .maingreen,
                                            //           //         ),
                                            //           //         child: Text(
                                            //           //           AppLocalizations.of(context)!.ivr,
                                            //           //           textAlign:
                                            //           //               TextAlign
                                            //           //                   .center,
                                            //           //           style: AppStyle
                                            //           //               .lbldrawerbtn
                                            //           //               .copyWith(
                                            //           //                   fontSize:
                                            //           //                       Adaptive.sp(16)),
                                            //           //         ),
                                            //           //       ),
                                            //           //     ),
                                            //           //     SizedBox(
                                            //           //       width: 10,
                                            //           //     ),
                                            //           //     InkWell(
                                            //           //       onTap: () {
                                            //           //         Get.close(1);
                                            //           //         Get.to(
                                            //           //             Credit());
                                            //           //       },
                                            //           //       child: Container(
                                            //           //         padding:
                                            //           //             EdgeInsets
                                            //           //                 .all(
                                            //           //                     10),
                                            //           //         decoration:
                                            //           //             BoxDecoration(
                                            //           //           borderRadius:
                                            //           //               BorderRadius
                                            //           //                   .circular(
                                            //           //                       08),
                                            //           //           color: ColorConstant
                                            //           //               .maingreen,
                                            //           //         ),
                                            //           //         child: Text(
                                            //           //           'take_bnpl'
                                            //           //               .tr,
                                            //           //           textAlign:
                                            //           //               TextAlign
                                            //           //                   .center,
                                            //           //           style: AppStyle
                                            //           //               .lbldrawerbtn
                                            //           //               .copyWith(
                                            //           //                   fontSize:
                                            //           //                       Adaptive.sp(16)),
                                            //           //         ),
                                            //           //       ),
                                            //           //     ),
                                            //           //   ],
                                            //           // ),
                                            //         ],
                                            //       )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ref
                                            .watch(sharedUtilityProvider)
                                            .getUser()
                                            ?.userId
                                            .toString() ==
                                        widget.sellerID.toString()
                                    ? AppLocalizations.of(context)!.bidUpdate
                                    : AppLocalizations.of(context)!.addUpdate,
                                style: AppStyle.lbldrawerbtn
                                    .copyWith(fontSize: Adaptive.sp(16)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.highlight_sharp,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        // cont.apnaBiddingListModel == null ? SizedBox():

                        ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            // scrollDirection: Axis.horizontal,
                            primary: true,
                            itemCount: data.dealInfo?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return IntrinsicHeight(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 4)
                                      ],
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .trader,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: Adaptive.sp(16)),
                                            ),
                                            Text("${index + 1}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: Adaptive.sp(16))),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0, right: 18.0),
                                          child: VerticalDivider(
                                            thickness: 2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .bidPrice,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: Adaptive.sp(16))),
                                            Text(
                                                "₹${data.dealInfo?[index].price.toString()}",
                                                style: TextStyle(
                                                    color:
                                                        ColorConstant.maingreen,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: Adaptive.sp(16))),
                                          ],
                                        ),
                                        ref
                                                    .watch(
                                                        sharedUtilityProvider)
                                                    .getUser()
                                                    ?.userId
                                                    .toString() ==
                                                data.dealInfo?[index].userId
                                                    .toString()
                                            ? VerticalDivider(
                                                thickness: 2,
                                                color: Colors.white,
                                              )
                                            : SizedBox.shrink(),
                                        ref
                                                    .watch(
                                                        sharedUtilityProvider)
                                                    .getUser()
                                                    ?.userId
                                                    .toString() ==
                                                data.dealInfo?[index].userId
                                                    .toString()
                                            ? ElevatedButton(
                                                style: AppStyle.buttonStyle,
                                                onPressed: () async {
                                                  yourpricecontroller.clear();
                                                  showBarModalBottomSheet(
                                                      context: context,
                                                      builder:
                                                          (bottomsheetContext) =>
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 10,
                                                                  bottom: MediaQuery.of(
                                                                              bottomsheetContext)
                                                                          .viewInsets
                                                                          .bottom +
                                                                      10,
                                                                ),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Text(
                                                                        AppLocalizations.of(context)!
                                                                            .msgMybid3,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                Adaptive.sp(18),
                                                                            fontWeight: FontWeight.bold),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            Pad(all: 10),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              Get.width,
                                                                          child: Row(
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  final current = double.tryParse(yourpricecontroller.text) ?? 0.0;
                                                                                  yourpricecontroller.text = (current - 10).clamp(0.0, 25000.0).toString();
                                                                                },
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(color: ColorConstant.maingreen, borderRadius: BorderRadius.circular(5)),
                                                                                  padding: Pad(all: 10),
                                                                                  child: Text('-10', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: Adaptive.sp(17))),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 8),
                                                                              Expanded(
                                                                                child: TextFormField(
                                                                                  controller: yourpricecontroller,
                                                                                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                                                                                  textAlign: TextAlign.center,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: '0.0',
                                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: ColorConstant.maingreen)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 8),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  final current = double.tryParse(yourpricecontroller.text) ?? 0.0;
                                                                                  yourpricecontroller.text = (current + 10).clamp(0.0, 25000.0).toString();
                                                                                },
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(color: ColorConstant.maingreen, borderRadius: BorderRadius.circular(5)),
                                                                                  padding: Pad(all: 10),
                                                                                  child: Text('+10', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: Adaptive.sp(17))),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // CommonTextField(
                                                                      //   controller: yourpricecontroller,
                                                                      //   textInputAction:
                                                                      //       TextInputAction.next,
                                                                      //   inputType: TextInputType.number,
                                                                      //   enabled: true,
                                                                      //   label: AppLocalizations.of(context)!.bidPrice,
                                                                      //   isOnlyDigit: true,
                                                                      //   isRequired: true,
                                                                      // ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),

                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            AppLocalizations.of(context)!.msgTermAnd,
                                                                            style:
                                                                                AppStyle.lblonlinemandibiglistdetail.copyWith(fontSize: Adaptive.sp(16)),
                                                                          ),
                                                                          Text(
                                                                            AppLocalizations.of(context)!.tCOne,
                                                                            style:
                                                                                AppStyle.lblonlinemandibiglistdetail.copyWith(fontSize: Adaptive.sp(16)),
                                                                          ),
                                                                          Text(
                                                                            AppLocalizations.of(context)!.tCTwo,
                                                                            style:
                                                                                AppStyle.lblonlinemandibiglistdetail.copyWith(fontSize: Adaptive.sp(16)),
                                                                          ),
                                                                          Text(
                                                                            AppLocalizations.of(context)!.tCThree,
                                                                            style:
                                                                                AppStyle.lblonlinemandibiglistdetail.copyWith(fontSize: Adaptive.sp(16)),
                                                                          ),
                                                                          Text(
                                                                            AppLocalizations.of(context)!.tCFour,
                                                                            style:
                                                                                AppStyle.lblonlinemandibiglistdetail.copyWith(fontSize: Adaptive.sp(16)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          if (yourpricecontroller.text.isNotEmpty &&
                                                                              yourpricecontroller.text != "0.0") {
                                                                            await ref
                                                                                .watch(addBidProvider(
                                                                              inventoryId: data.inventoryInfo?.id.toString(),
                                                                              price: yourpricecontroller.text,
                                                                            ).future)
                                                                                .then((value) {
                                                                              if (value['status'] == "1") {
                                                                                ref.invalidate(getBiddingDataProvider);
                                                                                ref.invalidate(getMandiBhavProvider);
                                                                                Fluttertoast.showToast(msg: value['message'].toString(), toastLength: Toast.LENGTH_LONG, backgroundColor: ColorConstant.maingreen);
                                                                              } else if (value['status'] == "0") {
                                                                                Fluttertoast.showToast(msg: value['message'].toString(), toastLength: Toast.LENGTH_LONG, backgroundColor: ColorConstant.red500);
                                                                              } else {
                                                                                Fluttertoast.showToast(msg: value['message'].toString(), toastLength: Toast.LENGTH_LONG, backgroundColor: ColorConstant.red500);
                                                                              }
                                                                            }).onError((e, s) {
                                                                              errorBottomSheet(context, "$e");
                                                                            });

                                                                            Get.back(closeOverlays: true);
                                                                          } else {
                                                                            Get.rawSnackbar(
                                                                                message: AppLocalizations.of(context)!.bidError,
                                                                                duration: const Duration(seconds: 2),
                                                                                backgroundColor: ColorConstant.red500);
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              10),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                ColorConstant.maingreen,
                                                                            borderRadius:
                                                                                BorderRadius.circular(08),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              AppLocalizations.of(context)!.submitBid,
                                                                              style: AppStyle.lblmoneybtn.copyWith(fontSize: Adaptive.sp(16)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      // data.walletStatus == 1
                                                                      //     ? SizedBox()
                                                                      //     : Column(
                                                                      //         children: [
                                                                      //           Text(
                                                                      //             AppLocalizations.of(context)!.enoughtAmount,
                                                                      //             style: AppStyle
                                                                      //                 .lblonlinemandibiglistdetail
                                                                      //                 .copyWith(
                                                                      //                     fontSize:
                                                                      //                         Adaptive.sp(
                                                                      //                             15)),
                                                                      //           ),
                                                                      //           SizedBox(
                                                                      //             height: 20,
                                                                      //           ),
                                                                      //           // RowSuper(
                                                                      //           //   fill: true,
                                                                      //           //   children: [
                                                                      //           //     InkWell(
                                                                      //           //       onTap: () {
                                                                      //           //         showDialog(
                                                                      //           //           context:
                                                                      //           //               context,
                                                                      //           //           builder:
                                                                      //           //               (BuildContext
                                                                      //           //                   context) {
                                                                      //           //             return AlertDialog(
                                                                      //           //               surfaceTintColor:
                                                                      //           //                   Colors
                                                                      //           //                       .white,
                                                                      //           //               shape:
                                                                      //           //                   const RoundedRectangleBorder(
                                                                      //           //                 borderRadius:
                                                                      //           //                     BorderRadius.all(Radius.circular(8)),
                                                                      //           //               ),
                                                                      //           //               titlePadding:
                                                                      //           //                   EdgeInsets
                                                                      //           //                       .zero,
                                                                      //           //               actionsPadding:
                                                                      //           //                   EdgeInsets
                                                                      //           //                       .zero,
                                                                      //           //               buttonPadding:
                                                                      //           //                   EdgeInsets
                                                                      //           //                       .zero,
                                                                      //           //               contentPadding:
                                                                      //           //                   EdgeInsets
                                                                      //           //                       .zero,
                                                                      //           //               iconPadding:
                                                                      //           //                   EdgeInsets
                                                                      //           //                       .zero,
                                                                      //           //               insetPadding:
                                                                      //           //                   EdgeInsets
                                                                      //           //                       .zero,
                                                                      //           //               title:
                                                                      //           //                   Column(
                                                                      //           //                 children: [
                                                                      //           //                   Container(
                                                                      //           //                     decoration:
                                                                      //           //                         const BoxDecoration(color: ColorConstant.maingreen, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                                                                      //           //                     child:
                                                                      //           //                         Padding(
                                                                      //           //                       padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 10),
                                                                      //           //                       child: Row(
                                                                      //           //                         children: [
                                                                      //           //                           const Icon(
                                                                      //           //                             Icons.support_agent,
                                                                      //           //                             color: Colors.amber,
                                                                      //           //                           ),
                                                                      //           //                           const SizedBox(
                                                                      //           //                             width: 10,
                                                                      //           //                           ),
                                                                      //           //                           Text(AppLocalizations.of(context)!.msgHelp, style: AppStyle.lblbuydetail.copyWith(fontSize: Adaptive.sp(17))),
                                                                      //           //                         ],
                                                                      //           //                       ),
                                                                      //           //                     ),
                                                                      //           //                   ),
                                                                      //           //                   const SizedBox(
                                                                      //           //                     height:
                                                                      //           //                         8,
                                                                      //           //                   ),
                                                                      //           //                   ListTile(
                                                                      //           //                     onTap:
                                                                      //           //                         () async {
                                                                      //           //                       Get.back();
                                                                      //           //                       CallLaunch('whatsapp://send?text=sample text&phone=917733901154');
                                                                      //           //                     },
                                                                      //           //                     leading:
                                                                      //           //                         Container(
                                                                      //           //                       decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xfffcf2f0)),
                                                                      //           //                       child: Padding(
                                                                      //           //                         padding: const EdgeInsets.all(8.0),
                                                                      //           //                         child: Image.asset(
                                                                      //           //                           ImageConstant.imgwhatsapp,
                                                                      //           //                           width: 28,
                                                                      //           //                         ),
                                                                      //           //                       ),
                                                                      //           //                     ),
                                                                      //           //                     title:
                                                                      //           //                         Text(AppLocalizations.of(context)!.msgWhatsapp, style: AppStyle.lblalerttext.copyWith(fontSize: Adaptive.sp(17))),
                                                                      //           //                     trailing:
                                                                      //           //                         const Icon(
                                                                      //           //                       Icons.chevron_right_outlined,
                                                                      //           //                       color: Colors.black,
                                                                      //           //                     ),
                                                                      //           //                   ),
                                                                      //           //                   const Divider(
                                                                      //           //                     color:
                                                                      //           //                         ColorConstant.grey,
                                                                      //           //                   ),
                                                                      //           //                   ListTile(
                                                                      //           //                     onTap:
                                                                      //           //                         () {
                                                                      //           //                       Get.back();
                                                                      //           //                       CallLaunch('tel:7733901154');
                                                                      //           //                     },
                                                                      //           //                     leading:
                                                                      //           //                         Container(
                                                                      //           //                       decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xfffcf2f0)),
                                                                      //           //                       child: const Padding(
                                                                      //           //                         padding: EdgeInsets.all(8.0),
                                                                      //           //                         child: Icon(
                                                                      //           //                           Icons.phone,
                                                                      //           //                           color: Colors.black,
                                                                      //           //                         ),
                                                                      //           //                       ),
                                                                      //           //                     ),
                                                                      //           //                     title:
                                                                      //           //                         Text(AppLocalizations.of(context)!.msgCallforHelp, style: AppStyle.lblalerttext.copyWith(fontSize: Adaptive.sp(17))),
                                                                      //           //                     trailing:
                                                                      //           //                         const Icon(
                                                                      //           //                       Icons.chevron_right_outlined,
                                                                      //           //                       color: Colors.black,
                                                                      //           //                     ),
                                                                      //           //                   ),
                                                                      //           //                   const SizedBox(
                                                                      //           //                     height:
                                                                      //           //                         8,
                                                                      //           //                   ),
                                                                      //           //                 ],
                                                                      //           //               ),
                                                                      //           //             );
                                                                      //           //           },
                                                                      //           //         );
                                                                      //           //       },
                                                                      //           //       child: Container(
                                                                      //           //         padding:
                                                                      //           //             EdgeInsets
                                                                      //           //                 .all(
                                                                      //           //                     10),
                                                                      //           //         decoration:
                                                                      //           //             BoxDecoration(
                                                                      //           //           borderRadius:
                                                                      //           //               BorderRadius
                                                                      //           //                   .circular(
                                                                      //           //                       08),
                                                                      //           //           color: ColorConstant
                                                                      //           //               .maingreen,
                                                                      //           //         ),
                                                                      //           //         child: Text(
                                                                      //           //           AppLocalizations.of(context)!.ivr,
                                                                      //           //           textAlign:
                                                                      //           //               TextAlign
                                                                      //           //                   .center,
                                                                      //           //           style: AppStyle
                                                                      //           //               .lbldrawerbtn
                                                                      //           //               .copyWith(
                                                                      //           //                   fontSize:
                                                                      //           //                       Adaptive.sp(16)),
                                                                      //           //         ),
                                                                      //           //       ),
                                                                      //           //     ),
                                                                      //           //     SizedBox(
                                                                      //           //       width: 10,
                                                                      //           //     ),
                                                                      //           //     InkWell(
                                                                      //           //       onTap: () {
                                                                      //           //         Get.close(1);
                                                                      //           //         Get.to(
                                                                      //           //             Credit());
                                                                      //           //       },
                                                                      //           //       child: Container(
                                                                      //           //         padding:
                                                                      //           //             EdgeInsets
                                                                      //           //                 .all(
                                                                      //           //                     10),
                                                                      //           //         decoration:
                                                                      //           //             BoxDecoration(
                                                                      //           //           borderRadius:
                                                                      //           //               BorderRadius
                                                                      //           //                   .circular(
                                                                      //           //                       08),
                                                                      //           //           color: ColorConstant
                                                                      //           //               .maingreen,
                                                                      //           //         ),
                                                                      //           //         child: Text(
                                                                      //           //           'take_bnpl'
                                                                      //           //               .tr,
                                                                      //           //           textAlign:
                                                                      //           //               TextAlign
                                                                      //           //                   .center,
                                                                      //           //           style: AppStyle
                                                                      //           //               .lbldrawerbtn
                                                                      //           //               .copyWith(
                                                                      //           //                   fontSize:
                                                                      //           //                       Adaptive.sp(16)),
                                                                      //           //         ),
                                                                      //           //       ),
                                                                      //           //     ),
                                                                      //           //   ],
                                                                      //           // ),
                                                                      //         ],
                                                                      //       )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .bidUpdate,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          Adaptive.sp(16)),
                                                ),
                                              )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                error: (e, s) => Container(
                      child: noStockData(),
                    ),
                loading: () => defaultLoader()),
      ),
    );
  }
}
