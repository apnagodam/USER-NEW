import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/login_screen/LoginBottomsheet.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/provider/warehouse_facitlity_provider.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/service/warehouse_facility_service.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/helper.dart';
import '../../core/utils/progress_dialog_utils.dart';
import '../../core/utils/theme/app_style.dart';
import '../dashboard/dashboard_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class RateCard extends ConsumerStatefulWidget {
  final String? stackNumber;
  final String? stackRowId;
  final String? wsaCharge;
  final String? entryLoadCharge;
  final String? exitLoadCharge;
  final String? whRentData;
  final String? stacktype;
  final String? lockIn;
  final String? requestedWeight;
  final String? labourCharge;
  final String? stackRequestId;
  final String? lockInDate;
  final String? commodityId;
  final String? warehouesName;
  final String? commodityName;
  final String? terminalId;

  RateCard({
    super.key,
    this.stackNumber,
    this.stackRowId,
    this.wsaCharge,
    this.entryLoadCharge,
    this.exitLoadCharge,
    this.whRentData,
    this.stacktype,
    this.lockIn,
    this.requestedWeight,
    this.labourCharge,
    this.stackRequestId,
    this.lockInDate,
    this.commodityId,
    this.warehouesName,
    this.commodityName,
    this.terminalId,
  });

  @override
  ConsumerState<RateCard> createState() => _RateCardState();
}

class _RateCardState extends ConsumerState<RateCard> {
  // var warehousecont = Get.put(WarehouseController());
  var warehouseRent = false;
  var labour = false;
  var bankWr = false;

  //incase of mix show them

  var wsa = false;
  var entryLoad = false;
  var exitLoad = false;

  var loadn = false;
  var rateOfInterest = false;
  var lockIn = false;

  var termsAndConditions = false;
  var condition1 = false;
  var condition2 = false;
  var condition3 = false;
  var condition4 = false;
  var condition5 = false;
  var condition6 = false;

  int addId = 1;
  String username = "";

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("firstname") ?? "";
  }

  @override
  void initState() {
    getData();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(dedicatedProvider.notifier).state =
          widget.stacktype == "Dedicated";
      if (widget.lockInDate != null &&
          widget.lockInDate!.isNotEmpty &&
          widget.lockInDate != "null" &&
          widget.lockInDate != AppLocalizations.of(context)!.selectDate2) {
        ref.read(dateProvider.notifier).state = widget.lockInDate!;
      } else {
        ref.read(dateProvider.notifier).state =
            AppLocalizations.of(context)!.selectDate2;
      }
    });
  }

  var dedicatedProvider = StateProvider((ref) => true);
  var lockInDedicated = StateProvider((ref) => false);
  var dateProvider = StateProvider((ref) => '');
  var selectedValueProvider = StateProvider<String?>((ref) => null);
  var lockInMix = StateProvider((ref) => false);
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.maingreen,
          // automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.ratecard,
            style: AppStyle.lblAppbar,
          ),
          actions: [],
        ),
        body: SafeArea(
          child: ref.watch(rateCardProvider).when(
                data: (data) => ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Card(
                        color: ColorConstant.maingreen,
                        elevation: 8,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.ratecard,
                                    style: TextStyle(
                                      color: Colors.yellow.shade300,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      shadows: [
                                        Shadow(
                                          color: Colors.white,
                                          offset: Offset(0.3, 0.3),
                                        ),
                                        Shadow(
                                          color: Colors.white,
                                          offset: Offset(0.3, 0.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      color: ColorConstant.whiteA700,
                                      fontWeight: FontWeight.w700,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.3, 0.3),
                                        ),
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.3, 0.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.srnumber}:',
                                        style: TextStyle(
                                          color: ColorConstant.whiteA700,
                                          fontWeight: FontWeight.w700,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(0.3, 0.3),
                                            ),
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(0.3, 0.3),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        data.data == null
                                            ? ""
                                            : "${int.parse("${data.data?.id}") + 1}",
                                        style: TextStyle(
                                          color: ColorConstant.whiteA700,
                                          fontWeight: FontWeight.w700,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(0.3, 0.3),
                                            ),
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(0.3, 0.3),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(thickness: 1, color: Colors.white),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text: AppLocalizations.of(
                                          context,
                                        )!
                                            .warehousename,
                                        style: TextStyle(
                                          color: ColorConstant.whiteA700,
                                          fontWeight: FontWeight.w500,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(0.3, 0.3),
                                            ),
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(0.3, 0.3),
                                            ),
                                          ],
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " ${widget.warehouesName}",
                                            style: TextStyle(
                                              color: ColorConstant.whiteA700,
                                              fontFamily: 'Roboto',
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0.3, 0.3),
                                                ),
                                                Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0.3, 0.3),
                                                ),
                                              ],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(thickness: 1, color: Colors.white),
                              Text.rich(
                                TextSpan(
                                  text: AppLocalizations.of(
                                    context,
                                  )!
                                      .customer,
                                  children: [TextSpan(text: username.tr)],
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(0.3, 0.3),
                                    ),
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(0.3, 0.3),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(thickness: 1, color: Colors.white),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .msgCommodity,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.3, 0.3),
                                        ),
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.3, 0.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${widget.commodityName}, ${widget.stacktype} Stack'
                                        .tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.3, 0.3),
                                        ),
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0.3, 0.3),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(thickness: 1, color: Colors.white),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!
                                                .agreementdate,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0.3, 0.3),
                                                ),
                                                Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0.3, 0.3),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            formattedDate,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0.3, 0.3),
                                                ),
                                                Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0.3, 0.3),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      width: 20,
                                      color: Colors.white,
                                      indent: 0,
                                      endIndent: 0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!
                                              .requestedweight,
                                          softWrap: true,
                                          // textDirection: TextDirection.ltr,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(0.3, 0.3),
                                              ),
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(0.3, 0.3),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          widget.requestedWeight ?? "0.0",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(0.3, 0.3),
                                              ),
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(0.3, 0.3),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Table(
                        border: TableBorder.all(
                          color: Colors.black45,
                          width: 2,
                          // borderRadius: BorderRadius.circular(08)
                        ),
                        columnWidths: {
                          0: FlexColumnWidth(1.5),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(4),
                          3: FlexColumnWidth(1.2),
                        },
                        children: [
                          TableRow(
                            children: [
                              SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.srnumber,
                                    style: AppStyle.lbltermncon,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.conditions,
                                    style: AppStyle.lbltermncon,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.msgRate,
                                    style: AppStyle.lbltermncon,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: Center(
                                  child: Checkbox(
                                    activeColor: ColorConstant.maingreen,
                                    checkColor: Colors.white,
                                    value: warehouseRent &&
                                        labour &&
                                        lockIn &&
                                        (!ref.watch(dedicatedProvider)
                                            ? (wsa &&
                                                entryLoad &&
                                                exitLoad)
                                            : true),
                                    onChanged: (val) {
                                      final newVal = val ?? false;
                                      setState(() {
                                        warehouseRent = newVal;
                                        labour = newVal;
                                        lockIn = newVal;
                                        if (!ref.read(dedicatedProvider)) {
                                          wsa = newVal;
                                          entryLoad = newVal;
                                          exitLoad = newVal;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .warehouserent,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "₹ ${widget.whRentData} per quintal"
                                          .tr
                                          .tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Checkbox(
                                activeColor: ColorConstant.maingreen,
                                checkColor: Colors.white,
                                value: warehouseRent,
                                onChanged: (value) {
                                  warehouseRent = value ?? true;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.labour,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "₹ ${widget.labourCharge} per Qtl"
                                        .tr
                                        .tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Checkbox(
                                activeColor: ColorConstant.maingreen,
                                checkColor: Colors.white,
                                value: labour,
                                onChanged: (value) {
                                  labour = value ?? true;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          // TableRow(children: [
                          //   Container(
                          //     height: 50,
                          //     child:  Center(
                          //       child: Text('3',
                          //           style: TextStyle(
                          //               fontSize: 12,
                          //               color: Colors.black54,
                          //
                          //               fontWeight: FontWeight.w500)),
                          //     ),
                          //   ),
                          //   Container(
                          //     height: 50,
                          //     child: Center(
                          //       child: Text(AppLocalizations.of(context)!.bankwrcharge,
                          //           style:  TextStyle(
                          //               fontSize: 12,
                          //               color: Colors.black54,
                          //
                          //               fontWeight: FontWeight.w500)),
                          //     ),
                          //   ),
                          //   Container(
                          //     height: 50,
                          //     child: Center(
                          //       child: Text(AppLocalizations.of(context)!.gst,
                          //           style:  TextStyle(
                          //               fontSize: 12,
                          //               color: Colors.black54,
                          //
                          //               fontWeight: FontWeight.w500)),
                          //     ),
                          //   ),
                          //   Checkbox(
                          //       activeColor: ColorConstant.maingreen,
                          //       checkColor: Colors.white,
                          //       value: cont.bankWr,
                          //       onChanged: (value) {
                          //         cont.bankWr = value ?? true;
                          //         cont.update();
                          //         print(cont.bankWr);
                          //       }),
                          // ]),
                          TableRow(
                            children: [
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      '3',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!
                                          .wsacharge,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "${widget.wsaCharge}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: Checkbox(
                                  activeColor: ColorConstant.maingreen,
                                  checkColor: Colors.white,
                                  value: wsa,
                                  onChanged: (value) {
                                    wsa = value ?? true;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      '4',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!
                                          .entryloadcharge2,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "₹ ${widget.entryLoadCharge}".tr,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: Checkbox(
                                  activeColor: ColorConstant.maingreen,
                                  checkColor: Colors.white,
                                  value: entryLoad,
                                  onChanged: (value) {
                                    entryLoad = value ?? true;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      '5',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!
                                          .exitloadcharge2,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "₹ ${widget.exitLoadCharge}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !ref.watch(dedicatedProvider),
                                child: Checkbox(
                                  activeColor: ColorConstant.maingreen,
                                  checkColor: Colors.white,
                                  value: exitLoad,
                                  onChanged: (value) {
                                    exitLoad = value ?? true;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                          // TableRow(children: [
                          //   Container(
                          //     height: 50,
                          //     child: Center(
                          //       child: Text(
                          //         !ref.watch(dedicatedProvider) ? '6' : "3",
                          //         style:  TextStyle(
                          //             fontSize: 12,
                          //             color: Colors.black54,
                          //
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //     ),
                          //   ),
                          //   Container(
                          //     child: Center(
                          //       child: Text(AppLocalizations.of(context)!.banklendingrate,
                          //           textAlign: TextAlign.center,
                          //           style:  TextStyle(
                          //               fontSize: 12,
                          //               color: Colors.black54,
                          //
                          //               fontWeight: FontWeight.w500)),
                          //     ),
                          //   ),
                          //   Container(
                          //     height: 50,
                          //     child: Center(
                          //       child: Padding(
                          //         padding:  EdgeInsets.only(left: 8.0),
                          //         child: Text(AppLocalizations.of(context)!.k802,
                          //             style:  TextStyle(
                          //                 fontSize: 12,
                          //                 color: Colors.black54,
                          //
                          //                 fontWeight: FontWeight.w500)),
                          //       ),
                          //     ),
                          //   ),
                          //   Checkbox(
                          //       activeColor: ColorConstant.maingreen,
                          //       checkColor: Colors.white,
                          //       value: cont.loadn,
                          //       onChanged: (value) {
                          //         cont.loadn = value ?? true;
                          //         cont.update();
                          //         print(cont.loadn);
                          //       }),
                          // ]),
                          // TableRow(children: [
                          //   Container(
                          //     height: 50,
                          //     child:  Center(
                          //       child: Text(
                          //         '8',
                          //         style: TextStyle(
                          //             fontSize: 12,
                          //             color: Colors.black54,
                          //
                          //             fontWeight: FontWeight.w500),
                          //       ),
                          //     ),
                          //   ),
                          //   Container(
                          //     height: 50,
                          //     child: Center(
                          //       child: Text(AppLocalizations.of(context)!.rateofinterest,
                          //           style:  TextStyle(
                          //               fontSize: 12,
                          //               color: Colors.black54,
                          //
                          //               fontWeight: FontWeight.w500)),
                          //     ),
                          //   ),
                          //   Container(
                          //     height: 50,
                          //     child: Center(
                          //       child: Padding(
                          //         padding:  EdgeInsets.only(left: 8.0),
                          //         child: Text(AppLocalizations.of(context)!.k132,
                          //             style:  TextStyle(
                          //                 fontSize: 12,
                          //                 color: Colors.black54,
                          //
                          //                 fontWeight: FontWeight.w500)),
                          //       ),
                          //     ),
                          //   ),
                          //   Checkbox(
                          //       activeColor: ColorConstant.maingreen,
                          //       checkColor: Colors.white,
                          //       value: cont.rateOfInterest,
                          //       onChanged: (value) {
                          //         cont.rateOfInterest = value ?? true;
                          //         cont.update();
                          //         print(cont.rateOfInterest);
                          //       }),
                          // ]),
                          TableRow(
                            children: [
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    !ref.watch(dedicatedProvider) ? '6' : "3",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .lockinmonth,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${widget.lockIn}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Checkbox(
                                activeColor: ColorConstant.maingreen,
                                checkColor: Colors.white,
                                value: lockIn,
                                onChanged: (value) {
                                  lockIn = value ?? true;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          if (!ref.watch(dedicatedProvider))
                            ref.watch(lockInMix)
                                ? TableRow(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            !ref.watch(dedicatedProvider)
                                                ? '7'
                                                : "4",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 60,
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!
                                                  .commodityArrivalDate,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 10.0,
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showDatePicker(
                                              context: context,
                                              firstDate:
                                                  DateTime.now().subtract(
                                                Duration(days: 1),
                                              ),
                                              lastDate: DateTime(2101),
                                            ).then((value) {
                                              if (value != null) {
                                                ref
                                                    .read(
                                                      dateProvider.notifier,
                                                    )
                                                    .state = DateFormat(
                                                  'dd-MM-yyyy',
                                                ).format(value).toString();
                                              }
                                            });
                                          },
                                          style: AppStyle.buttonStyle,
                                          child: FittedBox(
                                            child: Text(
                                              "${ref.watch(dateProvider)}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(),
                                    ],
                                  )
                                : TableRow(
                                    children: [
                                      SizedBox(),
                                      SizedBox(),
                                      SizedBox(),
                                      SizedBox(),
                                    ],
                                  )
                          else
                            TableRow(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      !ref.watch(dedicatedProvider) ? '7' : "4",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .commodityArrivalDate,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10.0,
                                    left: 10,
                                    right: 10,
                                    top: 10,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now().subtract(
                                          Duration(days: 1),
                                        ),
                                        lastDate: DateTime(2101),
                                      ).then((value) {
                                        if (value != null) {
                                          ref.read(dateProvider.notifier).state =
                                              DateFormat(
                                            'dd-MM-yyyy',
                                          ).format(value).toString();
                                        }
                                      });
                                    },
                                    style: AppStyle.buttonStyle,
                                    child: FittedBox(
                                      child: Text(
                                        "${ref.watch(dateProvider)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 17, top: 10),
                      child: Text(
                        AppLocalizations.of(context)!.conditions,
                        style: TextStyle(
                          color: ColorConstant.maingreen,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final isSmallScreen =
                                    constraints.maxWidth < 600;
                                final fontSize = isSmallScreen ? 11.0 : 12.0;
                                final padding = isSmallScreen ? 6.0 : 8.0;

                                // Calculate column widths to fit screen
                                final srNoWidth = isSmallScreen ? 40.0 : 50.0;
                                final checkboxWidth =
                                    isSmallScreen ? 50.0 : 60.0;
                                final textWidth = constraints.maxWidth -
                                    srNoWidth -
                                    checkboxWidth;

                                return Container(
                                  color: Colors.white,
                                  child: Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(srNoWidth),
                                      1: FixedColumnWidth(textWidth),
                                      2: FixedColumnWidth(checkboxWidth),
                                    },
                                    border: TableBorder.all(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TableRow(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                padding,
                                              ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!
                                                    .srnumber,
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                  color:
                                                      ColorConstant.maingreen,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: FittedBox(
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                  padding,
                                                ),
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .conditions,
                                                  style: TextStyle(
                                                    fontSize: fontSize,
                                                    color:
                                                        ColorConstant.maingreen,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                padding,
                                              ),
                                              child: Checkbox(
                                                activeColor:
                                                    ColorConstant.maingreen,
                                                checkColor: Colors.white,
                                                value: condition1 &&
                                                    condition2 &&
                                                    condition3 &&
                                                    condition4 &&
                                                    condition5 &&
                                                    condition6,
                                                onChanged: (val) {
                                                  final newVal = val ?? false;
                                                  setState(() {
                                                    condition1 = newVal;
                                                    condition2 = newVal;
                                                    condition3 = newVal;
                                                    condition4 = newVal;
                                                    condition5 = newVal;
                                                    condition6 = newVal;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Center(
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: padding,
                                              bottom: padding,
                                              left: padding,
                                            ),
                                            child: Text(
                                              'किराये की गणना दैनिक होगी | डेडिकेटेड स्टैक होने पर पुरे स्टैक का किराया पहले दिन से चालू होगा |',
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: ColorConstant.maingreen,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Checkbox(
                                            activeColor:
                                                ColorConstant.maingreen,
                                            checkColor: Colors.white,
                                            value: condition1,
                                            onChanged: (value) {
                                              setState(() {
                                                condition1 = value ?? true;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Center(
                                              child: Text(
                                                "2",
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: padding,
                                              bottom: padding,
                                              left: padding,
                                            ),
                                            child: Text(
                                              'फुमिगशन और इन्शुरन्स किराये में शामिल है, ख़राब माल आने पर 20 ₹ प्रति क्विन्टल फ्यूमिगेशन चार्ज लागु होगा |',
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: ColorConstant.maingreen,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Checkbox(
                                            activeColor:
                                                ColorConstant.maingreen,
                                            checkColor: Colors.white,
                                            value: condition2,
                                            onChanged: (value) {
                                              setState(() {
                                                condition2 = value ?? true;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Center(
                                              child: Text(
                                                "3",
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: padding,
                                              bottom: padding,
                                              left: padding,
                                            ),
                                            child: Text(
                                              '⁠यदि कमोडिटी मूल्य 50 रुपये किलो से ऊपर है तो इन्शुरन्स चार्ज अलग से देना होगा |',
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: ColorConstant.maingreen,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Checkbox(
                                            activeColor:
                                                ColorConstant.maingreen,
                                            checkColor: Colors.white,
                                            value: condition3,
                                            onChanged: (value) {
                                              setState(() {
                                                condition3 = value ?? true;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Center(
                                              child: Text(
                                                "4",
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: padding,
                                              bottom: padding,
                                              left: padding,
                                            ),
                                            child: Text(
                                              'किराया और ब्याज हर महीने की 5 तारीख से पहले देना होगा |',
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: ColorConstant.maingreen,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Checkbox(
                                            activeColor:
                                                ColorConstant.maingreen,
                                            checkColor: Colors.white,
                                            value: condition4,
                                            onChanged: (value) {
                                              setState(() {
                                                condition4 = value ?? true;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Center(
                                              child: Text(
                                                "5",
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: padding,
                                              bottom: padding,
                                              left: padding,
                                            ),
                                            child: Text(
                                              'किसी भी प्रकार की बकाया राशि होने पर माल रिलीज़ नहीं किया जायेगा |',
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: ColorConstant.maingreen,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Checkbox(
                                            activeColor:
                                                ColorConstant.maingreen,
                                            checkColor: Colors.white,
                                            value: condition5,
                                            onChanged: (value) {
                                              setState(() {
                                                condition5 = value ?? true;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Center(
                                              child: Text(
                                                "6",
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: padding,
                                              bottom: padding,
                                              left: padding,
                                            ),
                                            child: Text(
                                              'लेबर की व्यवस्था क्लाइंट के कहने पर की गयी है | लेबर लेट आने और जल्दी जाने एवं लेबर के कारण गाड़ी  वेयरहाउस पर खड़े रहने की कंडीशन में वेयरहाउस की कोई जिम्मेदारी नहीं होगी |',
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: ColorConstant.maingreen,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Checkbox(
                                            activeColor:
                                                ColorConstant.maingreen,
                                            checkColor: Colors.white,
                                            value: condition6,
                                            onChanged: (value) {
                                              setState(() {
                                                condition6 = value ?? true;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: ColorConstant.maingreen,
                                checkColor: Colors.white,
                                value: termsAndConditions,
                                onChanged: (value) {
                                  setState(() {
                                    termsAndConditions = value ?? true;
                                    setState(() {});
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.termCond,
                                  softWrap: true,
                                  maxLines: 2,
                                  style: AppStyle.lblaccontsecond,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            final isDedicated = ref.read(dedicatedProvider);
                            final currentDate = ref.read(dateProvider).trim();
                            final defaultSelectDate =
                                AppLocalizations.of(context)!.selectDate2.trim();

                            if (isDedicated &&
                                (currentDate.isEmpty ||
                                    currentDate == defaultSelectDate ||
                                    currentDate == "Select Date")) {
                              showErrorAlertDialog(
                                context,
                                "Please select commodity arrival date",
                              );
                              return;
                            }

                            final isTable1Valid = isDedicated
                                ? (warehouseRent && labour && lockIn)
                                : (warehouseRent &&
                                    labour &&
                                    wsa &&
                                    entryLoad &&
                                    exitLoad &&
                                    lockIn);

                            final isConditionsValid = condition1 &&
                                condition2 &&
                                condition3 &&
                                condition4 &&
                                condition5 &&
                                condition6;

                            if (!isTable1Valid ||
                                !isConditionsValid ||
                                !termsAndConditions) {
                              showErrorAlertDialog(
                                context,
                                AppLocalizations.of(context)!
                                    .pleaseSelectAllAboveConditions2,
                              );
                              return;
                            }

                            ProgressDialogUtils.showProgressDialog();
                            try {
                              final value = await ref
                                  .read(warehouseFacilityprovider)
                                  .createStackRequest(
                                    stackType: widget.stacktype,
                                    requestWeight: widget.requestedWeight,
                                    inOutStatus: "IN",
                                    stackNum: widget.stackNumber,
                                    stackRowId: widget.stackRowId,
                                    commodityId: widget.commodityId,
                                    lockInMonth: (currentDate == defaultSelectDate ||
                                            currentDate == "Select Date" ||
                                            !isDedicated)
                                        ? ""
                                        : currentDate,
                                    warehouseRent: widget.whRentData,
                                  );

                              if (value.status.toString() == "3") {
                                ProgressDialogUtils.hideProgressDialog();
                                if (context.mounted) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (bottomsheetContext) =>
                                        ElevarmDraggableBottomSheet(
                                      title: AppLocalizations.of(context)!
                                          .loginToContinue3,
                                      onPressedClose: () => Get.back(),
                                      children: const [
                                        LoginBottomSheet(),
                                      ],
                                    ),
                                  );
                                }
                                return;
                              }

                              if (value.status.toString() == "0") {
                                ProgressDialogUtils.hideProgressDialog();
                                if (context.mounted) {
                                  showErrorAlertDialog(
                                    context,
                                    value.message ??
                                        "Failed to book stack. Please try again.",
                                  );
                                }
                                return;
                              }

                              if (value.status.toString() == "1") {
                                final rateCardRes = await ref
                                    .read(warehouseFacilityprovider)
                                    .getRateCard(
                                      widget.stackRowId,
                                      value.data.toString(),
                                      widget.terminalId,
                                      widget.commodityId,
                                      "I) 12% If LTV 60%  II) 15% If LTV 90%",
                                      "1%+GST",
                                      widget.labourCharge,
                                      widget.whRentData,
                                      wsaCharge: widget.wsaCharge ?? "0.0",
                                      entryLoadChard:
                                          widget.entryLoadCharge ?? "0.0",
                                      exitLoadCharge:
                                          widget.exitLoadCharge ?? "0.0",
                                      lockInMonth: widget.lockIn ?? "0.0",
                                    );

                                ProgressDialogUtils.hideProgressDialog();

                                if (rateCardRes != null) {
                                  if (rateCardRes['status'].toString() == "1") {
                                    ref.invalidate(selectedValueProvider);
                                    ref.invalidate(dateProvider);
                                    ref.invalidate(dedicatedProvider);
                                    ref.invalidate(lockInDedicated);
                                    ref.invalidate(lockInMix);
                                    Get.offAll(() => DashboardScreen());
                                    Get.rawSnackbar(
                                      message: rateCardRes['message'] ??
                                          "Stack booked successfully",
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: ColorConstant.maingreen,
                                    );
                                  } else if (rateCardRes['status'].toString() ==
                                      "0") {
                                    if (context.mounted) {
                                      showErrorAlertDialog(
                                        context,
                                        rateCardRes['message'] ??
                                            "Failed to update rate card.",
                                      );
                                    }
                                  } else if (rateCardRes['status'].toString() ==
                                      "3") {
                                    if (context.mounted) {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (bottomsheetContext) =>
                                            ElevarmDraggableBottomSheet(
                                          title: AppLocalizations.of(context)!
                                              .loginToContinue3,
                                          onPressedClose: () => Get.back(),
                                          children: const [
                                            LoginBottomSheet(),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                }
                              } else {
                                ProgressDialogUtils.hideProgressDialog();
                              }
                            } catch (e) {
                              ProgressDialogUtils.hideProgressDialog();
                              debugPrint("Error in ratecard submit: $e");
                              if (context.mounted) {
                                showErrorAlertDialog(
                                  context,
                                  "An error occurred: $e",
                                );
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                right: 25,
                                left: 25,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.msgSubmit,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
                error: (e, s) => Text(e.toString()),
                loading: () => defaultLoader(),
              ),
        ),
      ),
      onWillPop: () => Future(() {
        ref.invalidate(dateProvider);
        return true;
      }),
    );
  }
}
