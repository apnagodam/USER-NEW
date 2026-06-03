import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/widgets/GlobalBottomFtwoF.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/string.dart';
import '../../core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class FaceTofaceDeal extends ConsumerWidget {
  const FaceTofaceDeal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Stack(
      children: [
        ref.watch(f2fDealDataProvider(type: wareHouseTypeTag)).when(
            data: (data) => (data.deals?.data ?? []).isEmpty
                ? noStockData(context)
                : ListView(
                    children: [
                      // Container(
                      //     alignment: Alignment.topCenter,
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //       color: ColorConstant.maingreen,
                      //     ),
                      //     child: IntrinsicHeight(
                      //       child: Row(
                      //         mainAxisAlignment:
                      //             MainAxisAlignment.spaceBetween,
                      //         crossAxisAlignment:
                      //             CrossAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             AppLocalizations.of(context)!.msgCommodityy,
                      //             style: AppStyle.lblviewbtnwithdraw,
                      //           ),
                      //           VerticalDivider(
                      //             color: Colors.white,
                      //             width: 10,
                      //             thickness: 2,
                      //           ),
                      //           Text(
                      //             AppLocalizations.of(context)!.msgNetweight,
                      //             textAlign: TextAlign.center,
                      //             style: AppStyle.lblviewbtnwithdraw,
                      //           ),
                      //           VerticalDivider(
                      //             color: Colors.white,
                      //             width: 10,
                      //             thickness: 2,
                      //           ),
                      //           Text(
                      //             AppLocalizations.of(context)!.msgPrice,
                      //             style: AppStyle.lblviewbtnwithdraw,
                      //           ),
                      //           VerticalDivider(
                      //             color: Colors.white,
                      //             width: 10,
                      //             thickness: 2,
                      //           ),
                      //           Text(
                      //             AppLocalizations.of(context)!.detail,
                      //             style: AppStyle.lblviewbtnwithdraw,
                      //           )
                      //         ],
                      //       ),
                      //     )),
                      FittedBox(
                        child: DataTable(
                            headingRowColor: WidgetStateProperty.resolveWith(
                                (states) => ColorConstant.maingreen),
                            showBottomBorder: true,
                            columnSpacing: 20,
                            border: TableBorder.all(color: Colors.grey),
                            dataRowMaxHeight: 120,
                            columns: [
                              DataColumn(
                                label: FittedBox(
                                    child: Text(
                                  AppLocalizations.of(context)!.msgCommodityy,
                                  maxLines: 2,
                                  style: AppStyle.wallatmoneylist
                                      .copyWith(fontSize: 24),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              DataColumn(
                                  label: FittedBox(
                                      child: Text(
                                AppLocalizations.of(context)!.msgNetweight,
                                maxLines: 2,
                                style: AppStyle.wallatmoneylist
                                    .copyWith(fontSize: 24),
                                textAlign: TextAlign.center,
                              ))),
                              DataColumn(
                                  label: FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)!.msgPrice,
                                  maxLines: 2,
                                  style: AppStyle.wallatmoneylist
                                      .copyWith(fontSize: 24),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              DataColumn(
                                  label: FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)!.detail,
                                  maxLines: 2,
                                  style: AppStyle.wallatmoneylist
                                      .copyWith(fontSize: 24),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                            ],
                            rows: List.generate(
                                data.deals?.data?.length ?? 0,
                                (index) => DataRow(
                                        color: WidgetStateProperty.resolveWith(
                                            (states) {
                                          if (index % 2 == 0) {
                                            return Colors.white;
                                          } else {
                                            return Colors.grey.withOpacity(0.3);
                                          }
                                        }),
                                        cells: [
                                          DataCell(Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${data.deals?.data?[index].category}',
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )),
                                          DataCell(Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                                "${data.deals?.data?[index].quantity}",
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          )),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${data.deals?.data?[index].price}",
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            ElevatedButton(
                                              onPressed: () async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                // TODO: implement initState

                                                GlobalBottomFTF.show(
                                                  context,
                                                  content: Text(
                                                      "Your Bottom Sheet Content"),
                                                  contractNote:
                                                      data.deals!.data![index],
                                                  callback: (dynamic data) {
                                                    print(data);
                                                    if (data) {
                                                      Get.back();
                                                    }
                                                  },
                                                );
                                                // showModalBottomSheet(
                                                //   context: context,
                                                //   builder: (context) {
                                                //     return SizedBox(
                                                //       height: MediaQuery.of(context)
                                                //           .size
                                                //           .height *
                                                //           0.2,
                                                //       child: Padding(
                                                //         padding:
                                                //         const EdgeInsets.only(
                                                //             top: 10.0),
                                                //         child: Column(
                                                //           mainAxisAlignment:
                                                //           MainAxisAlignment
                                                //               .center,
                                                //           crossAxisAlignment:
                                                //           CrossAxisAlignment
                                                //               .center,
                                                //           children: [
                                                //             InkWell(
                                                //               onTap: () {
                                                //                 // Get.back();
                                                //                 // Get.to(
                                                //                 //     Buycommodity());
                                                //               },
                                                //               child: Container(
                                                //                   width: MediaQuery
                                                //                       .of(
                                                //                       context)
                                                //                       .size
                                                //                       .width *
                                                //                       0.7,
                                                //                   height: 44,
                                                //                   decoration: BoxDecoration(
                                                //                       color: ColorConstant
                                                //                           .maingreen,
                                                //                       borderRadius:
                                                //                       BorderRadius
                                                //                           .circular(
                                                //                           6)),
                                                //                   child: Padding(
                                                //                     padding:
                                                //                     const EdgeInsets
                                                //                         .only(
                                                //                         top: 8,
                                                //                         bottom:
                                                //                         8.0),
                                                //                     child: Center(
                                                //                         child: Text(
                                                //                           "msg_bluetooth"
                                                //                               .tr,
                                                //                           style: AppStyle
                                                //                               .lblhomebtns,
                                                //                         )),
                                                //                   )),
                                                //             ),
                                                //             Divider(),
                                                //             InkWell(
                                                //               onTap: () async {

                                                //               },
                                                //               child: Container(
                                                //                   width: MediaQuery
                                                //                       .of(
                                                //                       context)
                                                //                       .size
                                                //                       .width *
                                                //                       0.7,
                                                //                   height: 44,
                                                //                   decoration: BoxDecoration(
                                                //                       color: ColorConstant
                                                //                           .maingreen,
                                                //                       borderRadius:
                                                //                       BorderRadius
                                                //                           .circular(
                                                //                           6)),
                                                //                   child: Padding(
                                                //                     padding:
                                                //                     const EdgeInsets
                                                //                         .only(
                                                //                         top: 8,
                                                //                         bottom:
                                                //                         8.0),
                                                //                     child: Center(
                                                //                         child: Text(
                                                //                           "msg_otherprint"
                                                //                               .tr,
                                                //                           style: AppStyle
                                                //                               .lblhomebtns,
                                                //                         )),
                                                //                   )),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //       ),
                                                //     );
                                                //   },
                                                // );
                                              },
                                              style: AppStyle.buttonStyle
                                                  .copyWith(
                                                      padding:
                                                          WidgetStatePropertyAll(
                                                              Pad(all: 10)),
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all(ColorConstant
                                                                  .buyerbtn)),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .msgNote,
                                                textAlign: TextAlign.center,
                                                style: AppStyle.lblnote
                                                    .copyWith(fontSize: 18),
                                              ),
                                            ),
                                          )
                                        ]))),
                      )
                    ],
                  ),
            error: (e, s) => Text(e.toString() + s.toString()),
            loading: () => defaultLoader())
      ],
    ));
  }
}

var f2fDealSearchProvider = StateProvider((ref) => '');
