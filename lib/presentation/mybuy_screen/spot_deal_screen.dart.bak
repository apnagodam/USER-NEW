import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/mybuy_screen/service/contract_note_service.dart';
import 'package:apnagodam/widgets/dailogs/error.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/progress_dialog_utils.dart';
import '../../core/utils/string.dart';
import '../../core/utils/theme/app_style.dart';
import '../../widgets/GlobalBottomSpot.dart';
import '../../widgets/dailogs/eyeCommandailog.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class SpoatDealScreen extends ConsumerWidget {
  const SpoatDealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(spotDealDataProvider(type: wareHouseTypeTag)).when(
          data: (data) => (data.deals?.data ?? []).isEmpty
              ? noStockData(context)
              : ListView(
                  shrinkWrap: true,
                  children: [
                    FittedBox(
                      child: DataTable(
                          headingRowHeight: 0.0,
                          headingRowColor: WidgetStateProperty.resolveWith(
                              (states) => ColorConstant.maingreen),
                          showBottomBorder: true,
                          columnSpacing: 36,
                          border: TableBorder.all(color: Colors.grey),
                          dataRowMaxHeight: 120,
                          columns: [
                            DataColumn(
                              label: FittedBox(
                                  child: Text(
                                AppLocalizations.of(context)!.msgGatepastwo,
                                maxLines: 2,
                                style: AppStyle.wallatmoneylist
                                    .copyWith(fontSize: 24),
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataColumn(
                                label: FittedBox(
                                    child: Text(
                              AppLocalizations.of(context)!.msgCommodityy,
                              maxLines: 2,
                              style: AppStyle.wallatmoneylist
                                  .copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ))),
                            DataColumn(
                                label: FittedBox(
                              child: Text(
                                wareHouseTypeTag == "buy"
                                    ? AppLocalizations.of(context)!.seller
                                    : AppLocalizations.of(context)!.buyer,
                                maxLines: 2,
                                style: AppStyle.wallatmoneylist
                                    .copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            )),
                            DataColumn(
                                label: FittedBox(
                              child: Text(
                                AppLocalizations.of(context)!.msgAction,
                                maxLines: 2,
                                style: AppStyle.wallatmoneylist
                                    .copyWith(fontSize: 20),
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
                                            "${data.deals?.data?[index].category}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                        DataCell(Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "${data.deals?.data?[index].quantity}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400)),
                                        )),
                                        DataCell(
                                          InkWell(
                                            onTap: () {
                                              EycCommanDialog(
                                                  data.deals?.data?[index]
                                                      .commodityImage
                                                      .toString(),
                                                  wareHouseTypeTag,
                                                  data.deals?.data?[index]
                                                      .sellerName
                                                      .toString(),
                                                  data.deals?.data?[index]
                                                      .location
                                                      .toString(),
                                                  data.deals?.data?[index]
                                                      .category
                                                      .toString(),
                                                  data.deals?.data?[index]
                                                          .quantity ??
                                                      '0.0',
                                                  data.deals?.data?[index]
                                                          .bags ??
                                                      "0",
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(DateTime.parse(
                                                          data
                                                                  .deals
                                                                  ?.data?[index]
                                                                  .updatedAt
                                                                  .toString() ??
                                                              "")),
                                                  context);
                                            },
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.remove_red_eye,
                                                color: ColorConstant.maingreen,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          ElevatedButton(
                                            style: AppStyle.buttonStyle
                                                .copyWith(
                                                    padding:
                                                        WidgetStatePropertyAll(
                                                            Pad(all: 10)),
                                                    backgroundColor:
                                                        WidgetStateProperty.all(
                                                            ColorConstant
                                                                .buyerbtn)),
                                            onPressed: () {
                                              ref
                                                  .watch(contractNotesProvider(
                                                          dealId: data.deals
                                                              ?.data?[index].id
                                                              .toString())
                                                      .future)
                                                  .then((value) {
                                                GlobalBottomSpot.show(
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
                                              }).onError((e, s) {
                                                errorBottomSheet(
                                                    context, e.toString());
                                              });

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
                                              //               onTap: () {

                                              //                 log("${cont.spotdealData[index].toJson()}");
                                              //                 //code by aarif ali

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
          loading: () => defaultLoader()),
    );
  }
}

var spotDealSearchProvider = StateProvider((ref) => "");
