import 'package:apnagodam/presentation/spot_order_booking_screen/service/spot_orders_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class OrderSummary extends ConsumerWidget {
  OrderSummary({super.key, required this.indexData});
  Datum? indexData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstant.maingreen,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_outlined)),
              title: Text(
                AppLocalizations.of(context)!.orderSummary,
                style: AppStyle.lblAppbar,
              ),
              centerTitle: true,
            ),
            body: ListView(children: [
              SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.pricing,
                style: AppStyle.lblaccontdetail,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 8, right: 8, bottom: 6, top: 8.0),
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(6),
                  child: Table(
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        SizedBox(
                            height: 30.0,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.corporPrice,
                                style: AppStyle.lblontestimonalname,
                              ),
                            )),
                        SizedBox(
                            height: 30.0,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.varition,
                                style: AppStyle.lblontestimonalname,
                              ),
                            )),
                        SizedBox(
                            height: 30.0,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.finalPrice,
                                style: AppStyle.lblontestimonalname,
                              ),
                            )),
                      ]),
                      TableRow(children: [
                        SizedBox(
                            height: 30.0,
                            child: Center(
                              child: Text(
                                "${indexData?.inventory?.price ?? "NA"}",
                                style: AppStyle.lblontestimonalname,
                              ),
                            )),
                        SizedBox(
                            height: 30.0,
                            child: Center(
                              child: Text(
                                "${indexData?.orderprice?.priceVariation ?? "NA"}",
                                style: AppStyle.lblontestimonalname,
                              ),
                            )),
                        SizedBox(
                            height: 30.0,
                            child: Center(
                              child: Text(
                                "${indexData?.orderprice?.finalPrice ?? "NA"}",
                                style: AppStyle.lblontestimonalname,
                              ),
                            )),
                      ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.varition,
                  style: AppStyle.lblonlinemandibig,
                  textAlign: TextAlign.center,
                ),
              ),
              (indexData?.qv ?? []).isEmpty
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        AppLocalizations.of(context)!.nodataFound,
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ))
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: indexData?.qv?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      bottom: 8.0,
                                      top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${indexData?.qv?[index].parameter}",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${indexData?.qv?[index].actualQuality}",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                )
                              ],
                            );
                          }),
                    ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    AppLocalizations.of(context)!.weighment,
                    style: AppStyle.lblsummary,
                    textAlign: TextAlign.center,
                  )),
              Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(children: [
                            SizedBox(
                                height: 30.0,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.msgWeight,
                                    style: AppStyle.lblontestimonalname,
                                  ),
                                )),
                            SizedBox(
                                height: 30.0,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.msgBags,
                                    style: AppStyle.lblontestimonalname,
                                  ),
                                )),
                          ]),
                          TableRow(children: [
                            SizedBox(
                                height: 30.0,
                                child: Center(
                                  child: indexData?.orderweight != null
                                      ? Text(
                                          indexData?.orderweight?.weight
                                                  .toString() ??
                                              "",
                                          style: AppStyle.lblontestimonalname,
                                        )
                                      : Text(
                                          "NA",
                                          style: AppStyle.lblontestimonalname,
                                        ),
                                )),
                            SizedBox(
                                height: 30.0,
                                child: Center(
                                  child: indexData?.orderweight != null
                                      ? Text(
                                          indexData?.orderweight?.noOfBags
                                                  .toString() ??
                                              "",
                                          style: AppStyle.lblontestimonalname,
                                        )
                                      : Text(
                                          "NA",
                                          style: AppStyle.lblontestimonalname,
                                        ),
                                )),
                          ]),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(children: [
                            SizedBox(
                                height: 30.0,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.finalamount,
                                    style: AppStyle.lblontestimonalname,
                                  ),
                                )),
                            SizedBox(
                                height: 30.0,
                                child: Center(
                                  child: Text(
                                    "${indexData?.userAmount ?? "NA"}",
                                    style: AppStyle.lblontestimonalname,
                                  ),
                                )),
                          ]),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          AppLocalizations.of(context)!.dealStatus,
                          style: AppStyle.lblsummary,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(3.5),
                    1: FlexColumnWidth(3.5),
                    2: FlexColumnWidth(3),
                  },
                  border: TableBorder.all(color: Colors.transparent),
                  children: [
                    TableRow(children: [
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.discover,
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstant.maingreen,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ))),
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              "",
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                    ]),
                    TableRow(children: [
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.assaying,
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: indexData?.orderprice != null
                            ? Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: indexData?.orderprice?.status == 2
                                      ? ColorConstant.maingreen
                                      : Colors.grey,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ))
                            : SizedBox(),
                      ),
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              "",
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                    ]),
                    TableRow(children: [
                      /*widget.indexData.orderweight != null?*/
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.weighting,
                              style: AppStyle.lblontestimonalname,
                            ),
                          )) /*:SizedBox()*/,
                      Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: indexData?.orderweight != null
                              ? Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: indexData?.orderweight?.status == 2
                                        ? ColorConstant.maingreen
                                        : Colors.grey,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ))
                              : SizedBox()),
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              "",
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                    ]),
                    TableRow(children: [
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.dealComplete,
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: indexData?.status != null
                            ? Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: indexData?.status == 2
                                      ? ColorConstant.maingreen
                                      : Colors.grey,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ))
                            : SizedBox(),
                      ),
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              "",
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                    ]),
                    TableRow(children: [
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.trip,
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: indexData?.tripStatus != null
                              ? Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: indexData?.tripStatus != 0
                                        ? ColorConstant.maingreen
                                        : Colors.grey,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ))
                              : SizedBox()),
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              "",
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                    ]),
                    TableRow(children: [
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.goodsDelivery,
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ))),
                      SizedBox(
                          height: 30.0,
                          child: Center(
                            child: Text(
                              "",
                              style: AppStyle.lblontestimonalname,
                            ),
                          )),
                    ]),
                  ],
                ),
              )
            ])));
  }
}
