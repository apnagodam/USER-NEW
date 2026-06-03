import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/home_screen/controller/home_controller.dart';
import 'package:apnagodam/presentation/market_screen/bindding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/theme/app_style.dart';
import '../../widgets/CommonTextField.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class LyingAtWarehouse extends ConsumerStatefulWidget {
  final commodityId;
  final commodityname;

  const LyingAtWarehouse(
      {super.key, required this.commodityId, this.commodityname});

  @override
  ConsumerState<LyingAtWarehouse> createState() => LyingAtWarehouseState();
}

class LyingAtWarehouseState extends ConsumerState<LyingAtWarehouse> {
  ScrollController? inwardController;
  int page = 1;
  var warehousecont = Get.put(HomeController());

  @override
  void initState() {
    inwardController = ScrollController()..addListener(_scrollListener);
    getData();
    // warehousecont.searchcontroller.text == "";
    super.initState();
  }

  getData() async {
    print("dfdd");
    // warehouseCont.f2fdeal(page , "",wareHouseTypeTag);
    warehousecont.layingAtWarehouseList(page, widget.commodityId, "");
  }

  _scrollListener() async {
    if (inwardController!.position.extentAfter <= 0) {
      page++;

      if (warehousecont.lyingnextUrl != null) {
        warehousecont.layingAtWarehouseList(
          page,
          warehousecont.lyingnextUrl.toString(),
          widget.commodityId,
        );
      } else {}
    }
  }

  @override
  void dispose() {
    inwardController!.removeListener(_scrollListener);
    warehousecont.searchcontroller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (cont) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorConstant.maingreen,
                title: Text(
                  "${widget.commodityname}",
                  style: AppStyle.lblAppbar,
                ),
                centerTitle: true,
                actions: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          titlePadding: EdgeInsets.zero,
                          insetPadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                          // content: ,
                          title: Container(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.search,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Get.back();
                                          cont.searchcontroller.clear();
                                          cont.update();
                                        },
                                        child: Icon(
                                          Icons.close_rounded,
                                        ))
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CommonTextField(
                                  controller: cont.searchcontroller,
                                  hintText: AppLocalizations.of(context)!
                                      .enterTextAsPer,
                                  // textInputAction: TextInputAction.next,
                                  inputType: TextInputType.emailAddress,
                                  enabled: true,
                                  // isOnlyDigit: true,
                                  isRequired: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                    cont.layingAtWarehouseList(
                                        page,
                                        widget.commodityId,
                                        cont.searchcontroller.text);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        color: ColorConstant.maingreen),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.msgSubmit,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Icon(
                        Icons.search,
                        color: CupertinoColors.white,
                      ),
                    ),
                  )
                ],
              ),
              body: Stack(
                children: [
                  cont.lyinDatalist.isEmpty
                      ? noStockData(context)
                      : Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    controller: inwardController,
                                    itemCount: cont.lyinDatalist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                          margin: EdgeInsets.only(bottom: 3.0),
                                          decoration: BoxDecoration(
                                            color: (index % 2 == 0)
                                                ? ColorConstant.mainlistgrayclr
                                                : Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              IntrinsicHeight(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0, right: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Center(
                                                                child: Text(
                                                                    '\${AppLocalizations.of(context)!.msgPrice} ₹\${cont.lyinDatalist[index].price.toString()}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: AppStyle
                                                                        .aplayforloan),
                                                              ),
                                                              // Divider(),
                                                              InkWell(
                                                                  onTap: () {
                                                                    if (cont.lyinDatalist[index].file !=
                                                                            null ||
                                                                        cont.lyinDatalist[index]
                                                                            .file
                                                                            .toString()
                                                                            .isEmpty) {
                                                                      // Get.to(Videoplay(
                                                                      //     fileName: cont
                                                                      //         .lyinDatalist[index]
                                                                      //         .file));
                                                                    } else {}
                                                                  },
                                                                  child: Icon(
                                                                    Icons.tv,
                                                                    color: cont.lyinDatalist[index].file !=
                                                                            null
                                                                        ? ColorConstant
                                                                            .maingreen
                                                                        : Colors
                                                                            .grey,
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      VerticalDivider(
                                                        color: ColorConstant
                                                            .listdivaderclr,
                                                        width: 10,
                                                        thickness: 2,
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .msgTerminalname,
                                                                  style: AppStyle
                                                                      .lblontestimonalname
                                                                      .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                Text(
                                                                  cont
                                                                      .lyinDatalist[
                                                                          index]
                                                                      .warehouse
                                                                      .toString(),
                                                                  style: AppStyle
                                                                      .lblontestimonalname
                                                                      .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: ColorConstant
                                                                        .maingreen,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      VerticalDivider(
                                                        color: ColorConstant
                                                            .listdivaderclr,
                                                        width: 10,
                                                        thickness: 2,
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .msgWeight,
                                                                style: AppStyle
                                                                    .lblontestimonalname
                                                                    .copyWith(
                                                                  fontSize: 16,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 3,
                                                              ),
                                                              Text(
                                                                "${cont.lyinDatalist[index].quantity.toString()} Qtl.",
                                                                style: AppStyle
                                                                    .lblontestimonalname
                                                                    .copyWith(
                                                                  fontSize: 16,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 3,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      VerticalDivider(
                                                        color: ColorConstant
                                                            .listdivaderclr,
                                                        width: 10,
                                                        thickness: 2,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .qlt,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Divider(),
                                                            InkWell(
                                                              onTap: () {
                                                                Get.to(
                                                                    () =>
                                                                        Bidding(
                                                                          id: cont
                                                                              .lyinDatalist[index]
                                                                              .id
                                                                              .toString(),
                                                                          sellerID: cont
                                                                              .lyinDatalist[index]
                                                                              .userId
                                                                              .toString(),
                                                                        ));
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                  color: ColorConstant
                                                                      .maingreen,
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .bids,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    }),
                              ),
                            ],
                          ),
                        ),
                  cont.lyinDatalist.length == cont.totalDatalyin
                      ? Positioned(
                          bottom: 95,
                          left: 0.0,
                          right: 0.0,
                          child: cont.lyinLoad
                              ? Center(
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .msgNotfound,
                                            style: AppStyle.lbldata)),
                                  ),
                                )
                              : SizedBox())
                      : Positioned(
                          bottom: 75,
                          left: 0.0,
                          right: 0.0,
                          child: cont.lyinLoad
                              ? Center(child: CircularProgressIndicator())
                              : SizedBox()),
                ],
              ));
        });
  }

  alertDialog(var id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          print("alertbox");
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Center(
                  child: Text(AppLocalizations.of(context)!.msgDeletetitale)),
              content: Text(
                AppLocalizations.of(context)!.msgDeleteMassage,
                style: AppStyle.lblonbordingp,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                          /*cont.deleteorder(id).whenComplete(() {

                              });*/
                        },
                        child: Text(
                          AppLocalizations.of(context)!.msgCencel,
                          style: TextStyle(
                            color: ColorConstant.maingreen,
                          ),
                        )),

                    // TextButton(
                    //     onPressed: () {
                    //       Get.back();
                    //       cont.rejectinword(id).whenComplete(() => warehousecont.stackinwardlist(1, "", ""),);
                    //       // cont.deleteorder(id).whenComplete(() {
                    //       //   orderCont.myorder(1, "");
                    //       // });
                    //     },
                    //     child: Text(
                    //       AppLocalizations.of(context)!.msgOk,
                    //       style: TextStyle(color: ColorConstant.maingreen),
                    //     )),
                  ],
                )
              ],
            );
          });
        });
  }
}
