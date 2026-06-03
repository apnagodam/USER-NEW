import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

void EycCommanDialogwarehouse(
    String? gatpass,
    String? selller,
    String? terminalName,
    String? loaction,
    String? commodity,
    String? netweight,
    String? mandifee,
    String? priceqtl,
    String? qualitygrade,
    String? createdate,
    BuildContext context,
    String? warehouseTypeTag) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          titlePadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          surfaceTintColor: Colors.white,
          content: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.close_outlined,
                                  color: Colors.white,
                                ),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            AppLocalizations.of(context)!.msgGatepass,
                            style: AppStyle.lbleyepopup,
                          )),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(
                            gatpass!,
                            style: AppStyle.lbleyepopupsecond,
                          )),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  warehouseTypeTag == "buy"
                                      ? AppLocalizations.of(context)!.seller
                                      : AppLocalizations.of(context)!.buyer,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(selller!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgTerminalname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(terminalName!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgLocation,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(loaction!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgCommodity,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(commodity!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgNetweight,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(netweight!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgMandifee,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(mandifee!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgPrice,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(priceqtl!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgQuality,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(qualitygrade!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.createDate,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(createdate!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
  );
}

void EycCommanDialogStack(
    String? gatpass,
    String? selller,
    String? terminalName,
    String? loaction,
    String? commodity,
    String? netweight,
    String? mandifee,
    String? priceqtl,
    String? qualitygrade,
    String? createdate,
    BuildContext context,
    String? warehouseTypeTag) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          titlePadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content: Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.close_outlined,
                                  color: Colors.white,
                                ),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgStackno,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(gatpass!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  warehouseTypeTag == "buy"
                                      ? AppLocalizations.of(context)!.seller
                                      : AppLocalizations.of(context)!.buyer,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(selller!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgTerminalname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(terminalName!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgLocation,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(loaction!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgCommodity,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(commodity!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgNetweight,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(netweight!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgMandifee,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(mandifee!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgPrice,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(priceqtl!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.msgQuality,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(qualitygrade!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  AppLocalizations.of(context)!.createDate,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                          Expanded(
                            child: VerticalDivider(
                              width: 5,
                              thickness: 1,
                              color: ColorConstant.grey,
                            ),
                          ),
                          Expanded(
                              child: Text(createdate!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.sp(15)))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
  );
}
