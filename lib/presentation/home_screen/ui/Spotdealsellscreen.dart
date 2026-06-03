import 'dart:convert';
import 'dart:typed_data';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/comman_dailog.dart';
import 'package:apnagodam/core/utils/helper.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/LP_list_screen/google_map_screen.dart';
import 'package:apnagodam/presentation/LP_list_screen/lp_list_screen.dart';
import 'package:apnagodam/presentation/home_screen/controller/home_controller.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_screen.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apnagodam/presentation/home_screen/models/TerminalModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Spotdealsellscreen extends ConsumerStatefulWidget {
  final commodityid;
  final commodityName;

  const Spotdealsellscreen(
      {super.key, required this.commodityid, required this.commodityName});

  @override
  ConsumerState<Spotdealsellscreen> createState() => _SpotdealsellscreenState();
}

class _SpotdealsellscreenState extends ConsumerState<Spotdealsellscreen> {
  var result;
  Terminal? dropdownvalue;
  var imageProvider = StateProvider<Uint8List?>((ref) => null);
  var cont = Get.put(HomeController());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var terminalId = "";
  var terminalIdProvider = StateProvider<String?>((ref) {
    return null;
  });
  var bage = "0";
  var salesStutas = "0";

  @override
  void initState() {
    cont.salectedSell = "";
    cont.salectedSellUnder = "";
    cont.salectedSellUndertwo = "";
    cont.salectedSellUnderthree = "";
    cont.pricecontroller.clear();
    cont.quantitycontroller.clear();
    cont.commoditycontroller.clear();
    cont.ownquantitycontroller.clear();
    cont.commoditycontroller.text = widget.commodityName;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spot Deals'),
      ),
      body: SingleChildScrollView(
        child: ref.watch(userDetailsProvider).when(
            data: (userData) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 48,
                            width: 250,
                            decoration:
                                BoxDecoration(color: ColorConstant.maingreen),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .msgChooseoption,
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
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                salesStutas = "1";

                                cont.salectedSell = "kisasni";
                                cont.salectedSellUnder = "";
                                cont.update();
                                setState(() {});
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: cont.salectedSell == "kisasni"
                                        ? ColorConstant.maingreen
                                        : Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    border: Border.all(
                                        color: ColorConstant.maingreen)),
                                child: Center(
                                    child: Text(
                                  AppLocalizations.of(context)!.msgKisasni,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: cont.salectedSell == "kisasni"
                                        ? Colors.white
                                        : ColorConstant.maingreen,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                salesStutas = "2";
                                cont.salectedSell = "manditaxpaid";
                                cont.salectedSellUnder = "";
                                cont.update();
                                setState(() {});
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: cont.salectedSell == "manditaxpaid"
                                        ? ColorConstant.maingreen
                                        : Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    border: Border.all(
                                        color: ColorConstant.maingreen)),
                                child: Center(
                                    child: Text(
                                  AppLocalizations.of(context)!.msgManditaxpaid,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: cont.salectedSell == "manditaxpaid"
                                        ? Colors.white
                                        : ColorConstant.maingreen,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                cont.salectedSellUndertwo = "ownvehicle";
                                cont.ownquantitycontroller.text = "";
                                cont.update();
                                setState(() {});
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: cont.salectedSellUndertwo ==
                                            "ownvehicle"
                                        ? ColorConstant.maingreen
                                        : Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    border: Border.all(
                                        color: ColorConstant.maingreen)),
                                child: Center(
                                    child: Text(
                                  AppLocalizations.of(context)!.ownVehicle,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: cont.salectedSellUndertwo ==
                                            "ownvehicle"
                                        ? Colors.white
                                        : ColorConstant.maingreen,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                cont.salectedSellUndertwo =
                                    "apana_godam_vehicle";
                                cont.ownquantitycontroller.text = "";

                                cont.update();
                                setState(() {});
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: cont.salectedSellUndertwo ==
                                            "apana_godam_vehicle"
                                        ? ColorConstant.maingreen
                                        : Colors.white,
                                    border: Border.all(
                                        color: ColorConstant.maingreen)),
                                child: Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.godamVehicle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                      color: cont.salectedSellUndertwo ==
                                              "apana_godam_vehicle"
                                          ? Colors.white
                                          : ColorConstant.maingreen,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    cont.salectedSellUndertwo == "ownvehicle" ||
                            cont.salectedSellUndertwo == "apana_godam_vehicle"
                        ? Form(
                            key: _formkey,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstant.maingreen),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .msgYourcommodity),
                                      )),
                                      CommonTextField(
                                        controller: cont.commoditycontroller,
                                        label: AppLocalizations.of(context)!
                                            .msgCommodity,
                                        textInputAction: TextInputAction.next,
                                        inputType: TextInputType.number,
                                        readOnly: true,
                                        enabled: true,
                                        isOnlyDigit: true,
                                        isRequired: true,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CommonTextField(
                                        controller: cont.ownquantitycontroller,
                                        label: AppLocalizations.of(context)!
                                            .msgQuantity,
                                        textInputAction: TextInputAction.next,
                                        inputType: TextInputType.number,
                                        enabled: true,
                                        isOnlyDigit: true,
                                        isRequired: true,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            if (cont.salectedSellUndertwo ==
                                                "apana_godam_vehicle") {
                                              Get.to(() => Lplistscreen(
                                                    lat:
                                                        "${ref.watch(locationProvider)?.latitude}"
                                                            .toString(),
                                                    long:
                                                        "${ref.watch(locationProvider)?.longitude}",
                                                    commoditId: widget
                                                        .commodityid
                                                        .toString(),
                                                    quantity: cont
                                                        .ownquantitycontroller
                                                        .text
                                                        .toString(),
                                                    dealType: "SPOT",
                                                    salesStatus: salesStutas,
                                                  ));
                                            } else {
                                              Get.to(() => Lplistscreen(
                                                    lat:
                                                        "${ref.watch(locationProvider)?.latitude}"
                                                            .toString(),
                                                    long:
                                                        "${ref.watch(locationProvider)?.longitude}",
                                                    commoditId: widget
                                                        .commodityid
                                                        .toString(),
                                                    quantity: cont
                                                        .ownquantitycontroller
                                                        .text
                                                        .toString(),
                                                    dealType: "MGP",
                                                    salesStatus: salesStutas,
                                                  ));
                                            }
                                          } else {}
                                        },
                                        child: Container(
                                          height: 46,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: ColorConstant.maingreen,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          child: Center(
                                              child: Text(
                                            AppLocalizations.of(context)!
                                                .msgSubmit,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Roboto'),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
            error: (e, s) => Container(),
            loading: () => defaultLoader()),
      ),
    );
  }
}
