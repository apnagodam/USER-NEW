import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/progress_dialog_utils.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/home_screen/lying_at_warehouse.dart';
import 'package:apnagodam/presentation/home_screen/models/TerminalModel.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/home_screen/ui/barcode_scanner_screen.dart';
import 'package:apnagodam/widgets/dailogs/error.dart';
import 'package:elevarm_ui/elevarm_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/comman_dailog.dart';
import '../../core/utils/helper.dart';
import '../../widgets/CommonTextField.dart';
import '../dashboard/dashboard_screen.dart';
import 'controller/home_controller.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Buycommodity extends ConsumerStatefulWidget {
  final commodityid;
  final commodityName;

  const Buycommodity({
    super.key,
    required this.commodityid,
    required this.commodityName,
  });

  @override
  ConsumerState<Buycommodity> createState() => _BuycommodityState();
}

class _BuycommodityState extends ConsumerState<Buycommodity> {
  var result;
  Terminal? dropdownvalue;
  var homeCont = Get.put(HomeController());
  var imageProvider = StateProvider<Uint8List?>((ref) => null);

  Future<void> scanBarcodeNormal(context) async {
    String barcodeScanRes;
    try {
     barcodeScanRes =
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BarcodeScannerScreen(),
      ),
    ) ??
    "";
      var map = jsonDecode(barcodeScanRes);
      if (barcodeScanRes.isNotEmpty) {
        print("rrrrrrrrrrrrrrrrrrrrrrr");
        double lat = double.parse(map["seller_lat"]);
        double long = double.parse(map["seller_long"]);
        ref.invalidate(imageProvider);
        homeCont
            .ftwofDealCalculate(
              map["seller_id"],
              lat.toStringAsFixed(5),
              long.toStringAsFixed(5),
              map["commodity"],
              map["bags"],
              map["sales_status"],
              map["weight"],
              map["price"],
            )
            .then((value) {
              print(homeCont.face2facecal);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (bottomsheetContext) {
                  return Consumer(
                    builder:
                        (context, ref, _) => ElevarmDraggableBottomSheet(
                          title: AppLocalizations.of(context)!.msgOrderdetails,
                          initialChildSize: 1,
                          onPressedClose: () {
                            Navigator.of(
                              bottomsheetContext,
                              rootNavigator: false,
                            ).pop();
                          },
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.msgWalletbalance,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(homeCont.face2facecal['wallet_balance']),
                              ],
                            ),
                            Divider(thickness: 1),
                            Text.rich(
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.msgSellername,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                ),
                                children: [
                                  TextSpan(
                                    text: homeCont.face2facecal['seller'],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.msgCommodityname,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(homeCont.face2facecal['commodity']),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgWeight,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(map["weight"]),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgPrice,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(map["price"]),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgManditax,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  homeCont.face2facecal['mandi_tax_amount']
                                      .toString(),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgAgcommission,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  homeCont.face2facecal['ag_commission_amount'],
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgDealamount,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(homeCont.face2facecal['deal_amount']),
                              ],
                            ),
                            Divider(thickness: 1),
                            SizedBox(height: 5),
                            ref.watch(imageProvider) == null
                                ? SizedBox(
                                  width: Get.width,
                                  child: InkWell(
                                    onTap: () {
                                      Get.defaultDialog(
                                        title: "Pick Image",
                                        middleText: "",
                                        content: Row(
                                          children: [
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () async {
                                                  ImagePicker()
                                                      .pickImage(
                                                        source:
                                                            ImageSource.camera,
                                                      )
                                                      .then((value) {
                                                        if (value != null) {
                                                          ref
                                                              .watch(
                                                                imageProvider
                                                                    .notifier,
                                                              )
                                                              .state = File(
                                                                value.path,
                                                              ).readAsBytesSync();
                                                          if (Get
                                                              .isDialogOpen!) {
                                                            Get.close(1);
                                                          }
                                                        }
                                                      })
                                                      .onError((e, s) {
                                                        errorBottomSheet(
                                                          context,
                                                          e.toString(),
                                                        );
                                                      });
                                                },
                                                icon: Column(
                                                  children: [
                                                    Icon(Icons.camera),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "Take Picture",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () async {
                                                  ImagePicker()
                                                      .pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                      )
                                                      .then((value) {
                                                        if (value != null) {
                                                          ref
                                                              .watch(
                                                                imageProvider
                                                                    .notifier,
                                                              )
                                                              .state = File(
                                                                value.path,
                                                              ).readAsBytesSync();

                                                          if (Get
                                                              .isDialogOpen!) {
                                                            Get.close(1);
                                                          }
                                                        }
                                                      })
                                                      .onError((e, s) {
                                                        errorBottomSheet(
                                                          context,
                                                          e.toString(),
                                                        );
                                                      });
                                                },
                                                icon: Column(
                                                  children: [
                                                    Icon(Icons.wallpaper),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      'Select from Gallery',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: ColorConstant.maingreen,
                                      elevation: 8,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Select Image',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                : InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: "Pick Image",
                                      middleText: "",
                                      content: Row(
                                        children: [
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () async {
                                                ImagePicker()
                                                    .pickImage(
                                                      source:
                                                          ImageSource.camera,
                                                    )
                                                    .then((value) {
                                                      if (value != null) {
                                                        ref
                                                            .watch(
                                                              imageProvider
                                                                  .notifier,
                                                            )
                                                            .state = File(
                                                              value.path,
                                                            ).readAsBytesSync();
                                                        if (Get.isDialogOpen!) {
                                                          Get.close(1);
                                                        }
                                                      }
                                                    })
                                                    .onError((e, s) {
                                                      errorBottomSheet(
                                                        context,
                                                        e.toString(),
                                                      );
                                                    });
                                              },
                                              icon: Column(
                                                children: [
                                                  Icon(Icons.camera),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Take Picture",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () async {
                                                ImagePicker()
                                                    .pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                    )
                                                    .then((value) {
                                                      if (value != null) {
                                                        ref
                                                            .watch(
                                                              imageProvider
                                                                  .notifier,
                                                            )
                                                            .state = File(
                                                              value.path,
                                                            ).readAsBytesSync();

                                                        if (Get.isDialogOpen!) {
                                                          Get.close(1);
                                                        }
                                                      }
                                                    })
                                                    .onError((e, s) {
                                                      errorBottomSheet(
                                                        context,
                                                        e.toString(),
                                                      );
                                                    });
                                              },
                                              icon: Column(
                                                children: [
                                                  Icon(Icons.wallpaper),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Select from Gallery',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Image.memory(
                                    ref.watch(imageProvider) ?? Uint8List(0),
                                    height: Get.height / 4,
                                  ),
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.msgTotaldealamount,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(homeCont.face2facecal['final_amount']),
                              ],
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                var daTa = jsonDecode(barcodeScanRes);
                                if (ref.watch(imageProvider) != null) {
                                  if (barcodeScanRes.isNotEmpty) {
                                    double lat = double.parse(
                                      daTa["seller_lat"],
                                    );
                                    double long = double.parse(
                                      daTa["seller_long"],
                                    );
                                    ProgressDialogUtils.showProgressDialog();
                                    homeCont
                                        .ftwofDeal(
                                          daTa["seller_id"],
                                          lat.toStringAsFixed(5),
                                          long.toStringAsFixed(5),
                                          daTa["commodity"],
                                          daTa["bags"],
                                          daTa["sales_status"],
                                          daTa["weight"],
                                          daTa["price"],
                                          ref.watch(imageProvider) ??
                                              Uint8List(0),
                                        )
                                        .then((value) {
                                          ProgressDialogUtils.showProgressDialog();

                                          if (value["status"] == 1) {
                                            Navigator.of(
                                              bottomsheetContext,
                                              rootNavigator: false,
                                            ).pop();
                                            Get.offAll(() => DashboardScreen());
                                          }
                                        })
                                        .onError((e, s) {
                                          ProgressDialogUtils.hideProgressDialog();
                                        });
                                  }
                                } else {
                                  context.errorToast('Please select image');
                                }
                              },
                              child: Container(
                                height: 46,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorConstant.maingreen,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.msgSubmit,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  );
                },
              );
            });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    var scanBarcode = "";

    scanBarcode = barcodeScanRes;
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var terminalId = "";
  var terminalIdProvider = StateProvider<String?>((ref) {
    return null;
  });
  @override
  void initState() {
    homeCont.salected = "";
    homeCont.salectedSell = "";
    homeCont.salectedSellUnder = "";
    homeCont.salectedSellUndertwo = "";
    homeCont.salectedSellUnderthree = "";

    homeCont.buypriceController.text = "";
    homeCont.buyquantityController.text = "";
    homeCont.buyshipmentController.text = "";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (cont) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: ColorConstant.maingreen,
            title: Center(child: Text(AppLocalizations.of(context)!.msgBuy)),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.notifications,
                  color: ColorConstant.maingreen,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: ref
                .watch(userDetailsProvider)
                .when(
                  data:
                      (userData) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height: 48,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.maingreen,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.msgChooseoption,
                                          style: AppStyle.lblbuydetail,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -40,
                                bottom: 0,
                                top: 0,
                                child: Transform.rotate(
                                  angle: 0.9, // Adjust the angle as needed
                                  child: Container(
                                    width: 120,
                                    height: 190,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // Other widgets can be added here...
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cont.salected =
                                          AppLocalizations.of(
                                            context,
                                          )!.msgDelivery;
                                      cont.update();
                                    },
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color:
                                            cont.salected ==
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.msgDelivery
                                                ? ColorConstant.maingreen
                                                : Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.maingreen,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.msgDelivery,
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                            color:
                                                cont.salected ==
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.msgDelivery
                                                    ? Colors.white
                                                    : ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cont.salected =
                                          AppLocalizations.of(
                                            context,
                                          )!.msgLying;
                                      Get.to(
                                        LyingAtWarehouse(
                                          commodityId: widget.commodityid,
                                          commodityname: widget.commodityName,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color:
                                            cont.salected ==
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.msgLying
                                                ? ColorConstant.maingreen
                                                : Colors.white,
                                        border: Border(
                                          top: BorderSide(
                                            color: ColorConstant.maingreen,
                                            width: 1,
                                          ),
                                          bottom: BorderSide(
                                            color: ColorConstant.maingreen,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.msgLying,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  cont.salected ==
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.msgLying
                                                      ? Colors.white
                                                      : ColorConstant.maingreen,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cont.salected = "face";
                                      cont.update();
                                      scanBarcodeNormal(context);
                                    },
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color:
                                            cont.salected == "face"
                                                ? ColorConstant.maingreen
                                                : Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          color: ColorConstant.maingreen,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.msgFaceto,
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                            color:
                                                cont.salected == "face"
                                                    ? Colors.white
                                                    : ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          cont.salected ==
                                  AppLocalizations.of(context)!.msgDelivery
                              ? Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ref
                                    .watch(terminalListProvider)
                                    .when(
                                      data:
                                          (terminalData) => Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: ColorConstant.maingreen,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Form(
                                                key: _formkey,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.delivaryAt,
                                                        style: TextStyle(
                                                          color:
                                                              ColorConstant
                                                                  .maingreen,
                                                          fontFamily: 'Roboto',
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: ListTile(
                                                            title: FittedBox(
                                                              fit:
                                                                  BoxFit
                                                                      .fitWidth,
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.warehouse,
                                                              ),
                                                            ),
                                                            leading: Radio(
                                                              fillColor: WidgetStateProperty.resolveWith(
                                                                (states) =>
                                                                    ColorConstant
                                                                        .maingreen,
                                                              ),
                                                              value: "ware",
                                                              groupValue:
                                                                  cont.waree,
                                                              onChanged: (
                                                                value,
                                                              ) {
                                                                setState(() {
                                                                  cont.waree =
                                                                      value
                                                                          .toString();
                                                                  cont
                                                                      .buypriceController
                                                                      .text = "";
                                                                  cont
                                                                      .buyquantityController
                                                                      .text = "";
                                                                  cont
                                                                      .buyshipmentController
                                                                      .text = "";
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: ListTile(
                                                            title: FittedBox(
                                                              fit:
                                                                  BoxFit
                                                                      .fitWidth,
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.place,
                                                              ),
                                                            ),
                                                            leading: Radio(
                                                              value: "own",
                                                              fillColor: WidgetStateProperty.resolveWith(
                                                                (states) =>
                                                                    ColorConstant
                                                                        .maingreen,
                                                              ),
                                                              groupValue:
                                                                  cont.waree,
                                                              onChanged: (
                                                                value,
                                                              ) {
                                                                cont.waree =
                                                                    value
                                                                        .toString();
                                                                cont
                                                                    .buypriceController
                                                                    .text = "";
                                                                cont
                                                                    .buyquantityController
                                                                    .text = "";
                                                                cont
                                                                    .buyshipmentController
                                                                    .text = "";
                                                                dropdownvalue =
                                                                    null;
                                                                cont.update();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 15),
                                                    cont.waree == "ware"
                                                        ? Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    8,
                                                                  ),
                                                                ),
                                                            border:
                                                                Border.all(),
                                                          ),
                                                          height: 60,
                                                          child: DropdownButtonHideUnderline(
                                                            child: DropdownButton<
                                                              Terminal
                                                            >(
                                                              isExpanded: true,
                                                              value:
                                                                  dropdownvalue,
                                                              icon: Icon(
                                                                Icons
                                                                    .keyboard_arrow_down,
                                                              ),
                                                              hint: Center(
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.terminal,
                                                                ),
                                                              ),
                                                              items:
                                                                  terminalData.terminals?.map((
                                                                    Terminal
                                                                    items,
                                                                  ) {
                                                                    return DropdownMenuItem(
                                                                      alignment:
                                                                          AlignmentDirectional
                                                                              .center,
                                                                      value:
                                                                          items,
                                                                      child: Text(
                                                                        items
                                                                            .name
                                                                            .toString(),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  dropdownvalue =
                                                                      val;
                                                                });

                                                                ref
                                                                        .watch(
                                                                          terminalIdProvider
                                                                              .notifier,
                                                                        )
                                                                        .state =
                                                                    dropdownvalue!
                                                                        .id
                                                                        .toString();
                                                              },
                                                            ),
                                                          ),
                                                        )
                                                        : SizedBox(),
                                                    SizedBox(height: 15),
                                                    CommonTextField(
                                                      controller:
                                                          cont.buypriceController,
                                                      label:
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.msgPrice,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      inputType:
                                                          TextInputType.number,
                                                      enabled: true,
                                                      isOnlyDigit: true,
                                                      isRequired: true,
                                                    ),
                                                    SizedBox(height: 15),
                                                    CommonTextField(
                                                      controller:
                                                          cont.buyquantityController,
                                                      label:
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.msgQuantity,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      inputType:
                                                          TextInputType.number,
                                                      enabled: true,
                                                      isOnlyDigit: true,
                                                      isRequired: true,
                                                    ),
                                                    SizedBox(height: 15),
                                                    cont.waree == "own"
                                                        ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                bottom: 15.0,
                                                              ),
                                                          child: CommonTextField(
                                                            controller:
                                                                cont.buyshipmentController,
                                                            label:
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.shipmentCode,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            inputType:
                                                                TextInputType
                                                                    .number,
                                                            enabled: true,
                                                            isOnlyDigit: true,
                                                            isRequired: true,
                                                          ),
                                                        )
                                                        : SizedBox(),
                                                    InkWell(
                                                      onTap: () {
                                                        print(cont.waree);
                                                        if (_formkey
                                                            .currentState!
                                                            .validate()) {
                                                          if (cont.waree ==
                                                              "ware") {
                                                            if (ref.watch(
                                                                  terminalIdProvider,
                                                                ) ==
                                                                null) {
                                                              Get.rawSnackbar(
                                                                message:
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.selectTerminal,
                                                                duration:
                                                                    Duration(
                                                                      seconds:
                                                                          10,
                                                                    ),
                                                                backgroundColor:
                                                                    ColorConstant
                                                                        .maingreen,
                                                              );
                                                            } else {
                                                              if (userData
                                                                          .userDetails
                                                                          ?.power
                                                                          .toString() ==
                                                                      '0' &&
                                                                  userData
                                                                          .userDetails
                                                                          ?.bnplPower ==
                                                                      0) {
                                                                CommanDialog(
                                                                  context,
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.msgAlert,
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.youCanApply,
                                                                  (
                                                                    bool
                                                                    userClickedOK,
                                                                  ) {
                                                                    if (userClickedOK) {
                                                                      Get.back();
                                                                      CallLaunch(
                                                                        'tel:7733901154',
                                                                      );
                                                                    } else {
                                                                      Navigator.of(
                                                                        context,
                                                                      ).pop();
                                                                    }
                                                                  },
                                                                );
                                                              } else {
                                                                ref
                                                                    .watch(
                                                                      punchBuySellOrderProvider(
                                                                        deliveryAt:
                                                                            "1",
                                                                        terminalId:
                                                                            ref.watch(
                                                                              terminalIdProvider,
                                                                            ),
                                                                        shipmentCode:
                                                                            cont.buyshipmentController.text,
                                                                        commodityId:
                                                                            widget.commodityid,
                                                                        quantity:
                                                                            cont.buyquantityController.text,
                                                                        price:
                                                                            cont.buypriceController.text,
                                                                      ).future,
                                                                    )
                                                                    .then((
                                                                      value,
                                                                    ) {
                                                                      if (value['status']
                                                                              .toString() ==
                                                                          "1") {
                                                                        context.successToast(
                                                                          value['message']
                                                                              .toString(),
                                                                        );
                                                                      } else {
                                                                        context.errorToast(
                                                                          value['message']
                                                                              .toString(),
                                                                        );
                                                                      }
                                                                    });
                                                              }
                                                            }
                                                          } else {
                                                            if (userData
                                                                        .userDetails
                                                                        ?.power
                                                                        .toString() ==
                                                                    '0' &&
                                                                userData
                                                                        .userDetails
                                                                        ?.bnplPower ==
                                                                    0) {
                                                              CommanDialog(
                                                                context,
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.msgAlert,
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.youCanApply,
                                                                (
                                                                  bool
                                                                  userClickedOK,
                                                                ) {
                                                                  if (userClickedOK) {
                                                                    Get.back();
                                                                    CallLaunch(
                                                                      'tel:7733901154',
                                                                    );
                                                                  } else {
                                                                    Navigator.of(
                                                                      context,
                                                                    ).pop();
                                                                  }
                                                                },
                                                              );
                                                            } else {
                                                              ref
                                                                  .watch(
                                                                    punchBuySellOrderProvider(
                                                                      deliveryAt:
                                                                          "2",
                                                                      terminalId:
                                                                          "",
                                                                      shipmentCode:
                                                                          cont
                                                                              .buyshipmentController
                                                                              .text,
                                                                      commodityId:
                                                                          widget
                                                                              .commodityid,
                                                                      quantity:
                                                                          cont
                                                                              .buyquantityController
                                                                              .text,
                                                                      price:
                                                                          cont
                                                                              .buypriceController
                                                                              .text,
                                                                    ).future,
                                                                  )
                                                                  .then((
                                                                    value,
                                                                  ) {
                                                                    if (value['status']
                                                                            .toString() ==
                                                                        "1") {
                                                                      context.successToast(
                                                                        value['message']
                                                                            .toString(),
                                                                      );
                                                                    } else {
                                                                      context.errorToast(
                                                                        value['message']
                                                                            .toString(),
                                                                      );
                                                                    }
                                                                  });
                                                            }
                                                          }
                                                        } else {
                                                          if (cont.waree ==
                                                              "ware") {
                                                            if (dropdownvalue ==
                                                                null) {
                                                              print("there");
                                                              Get.rawSnackbar(
                                                                message:
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.selectTerminal,
                                                                duration:
                                                                    Duration(
                                                                      seconds:
                                                                          10,
                                                                    ),
                                                                backgroundColor:
                                                                    ColorConstant
                                                                        .maingreen,
                                                              );
                                                            }
                                                          }
                                                        }
                                                      },
                                                      child:
                                                          cont.orderLoader
                                                              ? CircularProgressIndicator()
                                                              : Container(
                                                                height: 46,
                                                                width:
                                                                    double
                                                                        .infinity,
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      ColorConstant
                                                                          .maingreen,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                        Radius.circular(
                                                                          8,
                                                                        ),
                                                                      ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.order,
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      fontFamily:
                                                                          'Roboto',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      error: (e, s) => Container(),
                                      loading: () => Container(),
                                    ),
                              )
                              : SizedBox(),
                        ],
                      ),
                  error: (e, s) => Container(),
                  loading: () => defaultLoader(),
                ),
          ),
        );
      },
    );
  }
}
