import 'package:apnagodam/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/color_constant.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/localization/app_localizations_extras.dart';

Stackbook() {
  showDialog(
    barrierDismissible: false,
    context: mainNavKey.currentContext!,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: AlertDialog(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            titlePadding: EdgeInsets.all(10),
            insetPadding: EdgeInsets.zero,
            title: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.msgConditions,
                        style: TextStyle(fontSize: 17, fontFamily: 'Roboto'),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.close,
                            size: 18,
                            color: ColorConstant.maingreen,
                          ))
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Table(
                            columnWidths: {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(4),
                            },
                            border: TableBorder.all(color: Colors.black),
                            children: [
                              TableRow(children: [
                                Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.srnumber,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )),
                                Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.msgItems,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Center(
                                      child: Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  )),
                                ),
                                Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0, bottom: 8.0, left: 8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.rentanintrest,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Center(
                                      child: Text(
                                    "2",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  )),
                                ),
                                Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0, bottom: 8.0, left: 8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.removingGoods,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Center(
                                      child: Text(
                                    "3",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  )),
                                ),
                                Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0, bottom: 8.0, left: 8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .fuminationsand,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Center(
                                      child: Text(
                                    "4",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  )),
                                ),
                                Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0, bottom: 8.0, left: 8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.theFacility,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.maingreen,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                )),
                              ]),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                              // Get.to(() => WarehouseTab());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, right: 20, left: 20),
                                child: Text(
                                  AppLocalizations.of(context)!.msgOk,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      );
    },
  );
}
