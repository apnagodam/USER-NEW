// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/login_screen/LoginBottomsheet.dart';
import 'package:apnagodam/presentation/market_screen/service/market_service.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/theme/app_style.dart';
import '../../core/utils/helper.dart';
import '../../widgets/CommonTextField.dart';
import '../../widgets/dailogs/error.dart';
import '../dashboard/model/buyer_seller_list_model.dart';
import '../splash_screen/splash_screen.dart';
import 'model/DistrictWiseSbtModel';
import 'model/DistrictWiseCommodityModel.dart' as comm;
import 'package:apnagodam/l10n/app_localizations.dart';

class Sbtdailog extends ConsumerStatefulWidget {
  var coomodityId;
  final type;
  final tagg;

  Sbtdailog({
    super.key,
    required this.coomodityId,
    required this.type,
    required this.tagg,
  });

  @override
  ConsumerState<Sbtdailog> createState() => _SbtdailogState();
}

class _SbtdailogState extends ConsumerState<Sbtdailog> {
  var commodityid = "";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController yourpricecontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController trucknocontroller = TextEditingController();
  var truckProvider = StateProvider<TruckDatum?>((ref) => null);
  var commodityProvider = StateProvider<comm.Datum?>((ref) => null);
  var terminalDataProvider = StateProvider<Datum?>((ref) => null);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.maingreen,
        title: Text(
          AppLocalizations.of(context)!.msgMybid,
          style: AppStyle.lblAppbar,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ref
            .watch(districtSbtDataProvider)
            .when(
              data:
                  (terminaldata) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(),
                            ),
                            height: 50,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Datum>(
                                isExpanded: true,
                                value: ref.watch(terminalDataProvider),
                                icon: Icon(Icons.keyboard_arrow_down),
                                hint: Center(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.msgTerminalname,
                                  ),
                                ),
                                items: List.generate(
                                  terminaldata.data?.length ?? 0,
                                  (index) => DropdownMenuItem(
                                    alignment: AlignmentDirectional.topStart,
                                    value: terminaldata.data?[index],
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Radio<Datum?>(
                                            value: terminaldata.data?[index],
                                            groupValue: ref.watch(
                                              terminalDataProvider,
                                            ),
                                            onChanged: (value) {
                                              ref
                                                  .watch(
                                                    terminalDataProvider
                                                        .notifier,
                                                  )
                                                  .state = value;
                                              ref.invalidate(commodityProvider);
                                            },
                                            activeColor:
                                                ColorConstant.maingreen,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${terminaldata.data?[index].name}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onChanged: (val) {
                                  ref
                                      .watch(terminalDataProvider.notifier)
                                      .state = val;
                                  ref.invalidate(commodityProvider);
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          ref
                              .watch(
                                commodityByDistictProvider(
                                  districtId:
                                      "${ref.watch(terminalDataProvider)?.id}",
                                ),
                              )
                              .when(
                                data:
                                    (data) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(),
                                      ),
                                      height: 50,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<comm.Datum>(
                                          isExpanded: true,
                                          value: ref.watch(commodityProvider),
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          hint: Center(
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.msgCommodityy,
                                            ),
                                          ),
                                          items: List.generate(
                                            data.data?.length ?? 0,
                                            (index) => DropdownMenuItem(
                                              alignment:
                                                  AlignmentDirectional.topStart,
                                              value: data.data?[index],
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: data.data?[index],
                                                      groupValue: ref.watch(
                                                        commodityProvider,
                                                      ),
                                                      onChanged: (value) {
                                                        ref
                                                            .watch(
                                                              commodityProvider
                                                                  .notifier,
                                                            )
                                                            .state = value;
                                                      },
                                                      activeColor:
                                                          ColorConstant
                                                              .maingreen,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${data.data?[index].commodity}",
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          onChanged: (val) {
                                            setState(() {
                                              ref
                                                  .watch(
                                                    commodityProvider.notifier,
                                                  )
                                                  .state = val;
                                              commodityid =
                                                  val?.commodity ?? "";
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                error: (e, s) => Text(e.toString()),
                                loading: () => defaultLoader(),
                              ),
                          SizedBox(height: 20),
                          CommonTextField(
                            controller: weightcontroller,
                            label: AppLocalizations.of(context)!.msgNetweight,
                            textInputAction: TextInputAction.next,
                            inputType: TextInputType.number,
                            enabled: true,
                            isOnlyDigit: true,
                            isRequired: false,
                          ),
                          SizedBox(height: 20),
                          CommonTextField(
                            controller: yourpricecontroller,
                            label: AppLocalizations.of(context)!.msgYourprice,
                            textInputAction: TextInputAction.next,
                            inputType: TextInputType.number,
                            enabled: true,
                            isOnlyDigit: true,
                            isRequired: false,
                          ),
                          SizedBox(height: 20),
                          // CommonTextField(
                          //   controller: cont.pincodecontroller,
                          //   label: AppLocalizations.of(context)!.msgEnterpincode,
                          //   textInputAction: TextInputAction.next,
                          //   inputType: TextInputType.number,
                          //   maxLength: 6,
                          //   enabled: true,
                          //   isOnlyDigit: true,
                          //   isRequired: false,
                          // ),
                          SizedBox(height: 20),
                          CommonTextField(
                            controller: trucknocontroller,
                            label: AppLocalizations.of(context)!.msgTrucknynu,
                            textInputAction: TextInputAction.next,
                            inputType: TextInputType.text,
                            enabled: true,
                            isOnlyDigit: false,
                            isRequired: false,
                          ),
                          SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                if (widget.tagg != "") {
                                  if (ref.watch(commodityProvider) == null) {
                                    Get.rawSnackbar(
                                      message:
                                          AppLocalizations.of(
                                            context,
                                          )!.selectCom,
                                      duration: Duration(seconds: 10),
                                      backgroundColor: ColorConstant.red500,
                                    );
                                  } else {
                                    checkCondition(context, ref);
                                  }
                                } else {
                                  checkCondition(context, ref);
                                }
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
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              error: (e, s) => Container(),
              loading: () => defaultLoader(),
            ),
      ),
    );
  }

  void checkCondition(BuildContext context, WidgetRef ref) async {
    if (weightcontroller.text.isEmpty) {
      Get.rawSnackbar(
        message: AppLocalizations.of(context)!.massegeWeight,
        duration: Duration(seconds: 10),
        backgroundColor: ColorConstant.red500,
      );
    } else if (yourpricecontroller.text.isEmpty) {
      Get.rawSnackbar(
        message: AppLocalizations.of(context)!.massegePrice,
        duration: Duration(seconds: 10),
        backgroundColor: ColorConstant.red500,
      );
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      ref
          .watch(
            sbtBuyAndSellProvider(
              commodity:
                  (widget.coomodityId == null ||
                          widget.coomodityId.toString() == "")
                      ? ref.watch(commodityProvider)?.id.toString()
                      : widget.coomodityId.toString(),
              qty: weightcontroller.text.toString(),
              type: widget.type.toString(),
              price: yourpricecontroller.text.toString(),
              pinCode: ref.watch(terminalDataProvider)?.id.toString(),
              truckNo: trucknocontroller.text,
            ).future,
          )
          .then((value) async {
            if (value["status"] == "3") {
              showBottomSheet(
                context: context,
                builder:
                    (bottomsheetContext) => ElevarmDraggableBottomSheet(
                      title: "Login to Continue",
                      onPressedClose: () => Get.back(),
                      children: [LoginBottomSheet()],
                    ),
              );
            } else if (value["status"] == 0 || value["status"] == "0") {
              showErrorAlertDialog(
                context,
                value["message"] ?? "Failed",
              );
            } else {
              Get.rawSnackbar(
                message: value["message"],
                duration: Duration(seconds: 10),
                backgroundColor: ColorConstant.maingreen,
              );
              Navigator.of(context).pop(true);
            }
          })
          .onError((e, s) {
            errorBottomSheet(context, "$e");
          });
    }
  }
}
