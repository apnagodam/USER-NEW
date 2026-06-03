import 'package:apnagodam/core/utils/no_data_found_widget.dart';

import 'package:apnagodam/presentation/my_order_screen/service/my_orders_service.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';

import '../../core/utils/theme/app_style.dart';
import '../../widgets/CommonTextField.dart';
import '../../widgets/dailogs/error.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class OrderList extends ConsumerWidget {
  OrderList({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController remainingqtlcontroller = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.maingreen,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.msgOrder,
            style: AppStyle.lblAppbar,
          ),
          actions: [],
        ),
        body: ListView(
          children: [
            ref.watch(getWantToSellResponseProvider).when(
                data: (myOrders) => (myOrders.orderList?.data ?? []).isEmpty
                    ? SizedBox(
                        height: Adaptive.h(100),
                        child: noDataFoundOrders(context),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: myOrders.orderList?.data?.length,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemBuilder: (BuildContext context, int index) {
                          var date = DateFormat('dd/MM/yyyy').format(
                              DateTime.parse(
                                  myOrders.orderList?.data?[index].createdAt ??
                                      ""));
                          return Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ColumnSuper(
                                // crossAxisAlignment: CrossAxisAlignment.center ,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RowSuper(
                                    fitHorizontally: true,
                                    children: [
                                      TextOneLine(
                                          "${myOrders.orderList?.data?[index].warehouses?.name}",
                                          style: TextStyle(
                                              color: ColorConstant.maingreen,
                                              fontSize: Adaptive.sp(17),
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RowSuper(
                                    fitHorizontally: true,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.msgDate,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Adaptive.sp(16)),
                                      ),
                                      Text(
                                        date,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: Adaptive.sp(16)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  IntrinsicHeight(
                                    child: ColumnSuper(
                                      children: [
                                        ColumnSuper(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5.0, bottom: 5.0),
                                              child: RowSuper(
                                                fill: true,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .msgCommodity,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                  ),
                                                  Text(
                                                    "${myOrders.orderList?.data?[index].commodity?.category}",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RowSuper(
                                              fill: true,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .msgPriceorder,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Adaptive.sp(16)),
                                                ),
                                                Text(
                                                    myOrders
                                                            .orderList
                                                            ?.data?[index]
                                                            .price ??
                                                        "",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize:
                                                            Adaptive.sp(16)))
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ColumnSuper(
                                          children: [
                                            RowSuper(
                                              fill: true,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .msgTotalquantity,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Adaptive.sp(16)),
                                                ),
                                                Text(
                                                    "${myOrders.orderList?.data?[index].quantity}",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize:
                                                            Adaptive.sp(16))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RowSuper(
                                              fill: true,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .msgRemainingquantity,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Adaptive.sp(16)),
                                                ),
                                                Text(
                                                  "${myOrders.orderList?.data?[index].requestedQuantity}",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          Adaptive.sp(16)),
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SideBySide(
                                    startChild: InkWell(
                                      onTap: () {
                                        showBarModalBottomSheet(
                                          context: context,
                                          builder: (sheetContext) => Consumer(
                                              builder: (context, ref, child) =>
                                                  SafeArea(
                                                      child: Padding(
                                                    padding: Pad(
                                                        top: 10,
                                                        left: 10,
                                                        right: 10,
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: Form(
                                                      key: _formkey,
                                                      child: ColumnSuper(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              AppLocalizations.of(context)!.msgUpdateprice2,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          18)),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5.0,
                                                                    right: 5.0),
                                                            child:
                                                                CommonTextField(
                                                              controller:
                                                                  priceController,
                                                              // label: "Enter Withdraw Amount",
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              enabled: true,
                                                              label: "Price",
                                                              isOnlyDigit: true,
                                                              isRequired: true,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5.0,
                                                                    right: 5.0),
                                                            child:
                                                                CommonTextField(
                                                              controller:
                                                                  remainingqtlcontroller,
                                                              // label: "Enter Withdraw Amount",
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              enabled: true,
                                                              label:
                                                                  "Net Weight(Qtl.)",
                                                              isOnlyDigit: true,
                                                              isRequired: true,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: RowSuper(
                                                              fill: true,
                                                              children: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            sheetContext,
                                                                            rootNavigator:
                                                                                true)
                                                                        .pop();
                                                                  },
                                                                  style: AppStyle
                                                                      .buttonStyle,
                                                                  child: Text(
                                                                    AppLocalizations.of(context)!.msgCencel3,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    ref
                                                                        .watch(updateMyOrderProvider(id: myOrders.orderList?.data?[index].id.toString(), quantity: remainingqtlcontroller.text.toString(), price: priceController.text)
                                                                            .future)
                                                                        .then(
                                                                            (value) {
                                                                      if (value
                                                                              .status
                                                                              .toString() ==
                                                                          "1") {
                                                                        ref.invalidate(
                                                                            getWantToSellResponseProvider);
                                                                        Get.back();
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                value.message.toString(),
                                                                            toastLength: Toast.LENGTH_LONG,
                                                                            backgroundColor: ColorConstant.maingreen);
                                                                      } else {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                value.message.toString(),
                                                                            toastLength: Toast.LENGTH_LONG,
                                                                            backgroundColor: ColorConstant.red500);
                                                                      }
                                                                    }).onError((e,
                                                                            s) {
                                                                      errorBottomSheet(
                                                                          context,
                                                                          e.toString());
                                                                    });

                                                                    if (Get.isDialogOpen ??
                                                                        false) {
                                                                      Get.back(
                                                                          closeOverlays:
                                                                              true);
                                                                    }
                                                                  },
                                                                  style: AppStyle
                                                                      .buttonStyle,
                                                                  child: Text(
                                                                    AppLocalizations.of(context)!.msgUpdate2,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ))),
                                        );
                                      },
                                      child: Container(
                                        width: Get.width / 2.5,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.maingreen,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .msgEdit,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(16),
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    endChild: InkWell(
                                      onTap: () {
                                        alertDialog(
                                            myOrders.orderList?.data?[index].id
                                                .toString(),
                                            ref,
                                            context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorConstant.red500,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .msgDelete,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Adaptive.sp(16),
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    innerDistance: 8,
                                    minEndChildWidth: 20,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                error: (e, s) => Text(e.toString() + s.toString()),
                loading: () => SizedBox(
                      height: Get.height,
                      child: Center(
                        child: defaultLoader(),
                      ),
                    ))
          ],
        ));
  }

  alertDialog(var id, WidgetRef ref, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Center(
                child: Text(
                  AppLocalizations.of(context)!.msgDeletetitale,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.sp(17),
                      color: Colors.black),
                ),
              ),
              content: Text(
                AppLocalizations.of(context)!.msgAreYousure,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(16),
                    color: Colors.black),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.msgCencel,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16),
                              color: Colors.black),
                        )),
                    TextButton(
                        onPressed: () async {
                          ref
                              .watch(cancelOrdersProvider(id: id).future)
                              .then((value) {
                            if (value.status.toString() == "1") {
                              ref.invalidate(getWantToSellResponseProvider);
                              Fluttertoast.showToast(
                                  msg: value.message.toString(),
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: ColorConstant.maingreen);
                            } else {
                              Fluttertoast.showToast(
                                  msg: value.message.toString(),
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: ColorConstant.red500);
                            }
                            if (Get.isDialogOpen!) {
                              Get.close(1);
                            }
                          }).onError((e, s) {
                            errorBottomSheet(context, e.toString());
                          });
                        },
                        child: Text(
                          AppLocalizations.of(context)!.msgOk,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16),
                              color: Colors.black),
                        )),
                  ],
                )
              ],
            );
          });
        });
  }
}
