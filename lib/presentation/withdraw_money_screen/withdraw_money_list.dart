import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/withdraw_money_screen/wallet_impl/wallet_imple_repo.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class WithdrawlListScreen extends ConsumerWidget {
  WithdrawlListScreen({super.key, required this.type});
  String? type = "1";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: ColorConstant.maingreen,
          title: Text(
            AppLocalizations.of(context)!.withdrawalStatement,
            style: AppStyle.lblAppbar,
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
            child: ref.watch(getWalletListProvider(walletType: type)).when(
                data: (data) {
                  var walletList = data.data?.reversed.toList();
                  return ref.watch(authProvider).value == AuthStatus.loggedOut
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/images/mainlogopng.png',
                                  height: 150, width: 150),
                              simpleButton(
                                  text: AppLocalizations.of(context)!.loginToGetSummary2,
                                  callback: () {
                                    showLoginBottomsheet(context);
                                  }),
                            ],
                          ),
                        )
                      : (data.data ?? []).isEmpty
                          ? noStockData(context)
                          : ListView(
                              children: [
                                FittedBox(
                                  child: DataTable(
                                      headingRowColor:
                                          WidgetStateProperty.resolveWith(
                                              (states) =>
                                                  ColorConstant.maingreen),
                                      showBottomBorder: true,
                                      columnSpacing: 10,
                                      dataRowMaxHeight: 80,
                                      border:
                                          TableBorder.all(color: Colors.grey),
                                      columns: [
                                        DataColumn(
                                          label: FittedBox(
                                              child: Text(
                                            AppLocalizations.of(context)!.sNo2,
                                            maxLines: 2,
                                            style: AppStyle.wallatmoneylist
                                                .copyWith(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                        DataColumn(
                                          label: FittedBox(
                                              child: Text(
                                            AppLocalizations.of(context)!
                                                .requestAmountty,
                                            maxLines: 2,
                                            style: AppStyle.wallatmoneylist
                                                .copyWith(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                        DataColumn(
                                            label: FittedBox(
                                                child: Text(
                                          AppLocalizations.of(context)!
                                              .approvedAmountty,
                                          maxLines: 2,
                                          style: AppStyle.wallatmoneylist
                                              .copyWith(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ))),
                                        DataColumn(
                                            label: FittedBox(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .requsetDateLoan,
                                            maxLines: 2,
                                            style: AppStyle.wallatmoneylist
                                                .copyWith(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                        DataColumn(
                                            label: FittedBox(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .status,
                                            maxLines: 2,
                                            style: AppStyle.wallatmoneylist
                                                .copyWith(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                                      ],
                                      rows: List.generate(
                                          walletList?.length ?? 0,
                                          (index) => DataRow(
                                                  color: WidgetStateProperty
                                                      .resolveWith((states) {
                                                    if (index % 2 == 0) {
                                                      return Colors.white;
                                                    } else {
                                                      return Colors.grey
                                                          .withOpacity(0.3);
                                                    }
                                                  }),
                                                  cells: [
                                                    DataCell(Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "${index + 1}",
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    )),
                                                    DataCell(Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "${walletList?[index].requestedAmount ?? "0"} ₹",
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    )),
                                                    DataCell(Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          "${walletList?[index].approvedAmount ?? "0"} ₹",
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    )),
                                                    DataCell(Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          DateFormat(
                                                                  'dd/MMM/yyyy')
                                                              .format(DateTime.parse(
                                                                  walletList?[index]
                                                                          .createdAt ??
                                                                      "")),
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    )),
                                                    DataCell(Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          walletList?[index]
                                                                      .status ==
                                                                  0
                                                              ? AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .rejected
                                                              : walletList?[index]
                                                                          .status ==
                                                                      2
                                                                  ? AppLocalizations.of(context)!.msgStatusApproved3
                                                                  : walletList?[index]
                                                                              .status ==
                                                                          3
                                                                      ? AppLocalizations.of(context)!.msgStatusVerified3
                                                                      : AppLocalizations.of(context)!.request2,
                                                          style: TextStyle(
                                                              color: walletList?[
                                                                              index]
                                                                          .status ==
                                                                      0
                                                                  ? ColorConstant
                                                                      .red500
                                                                  : walletList?[index]
                                                                              .status ==
                                                                          3
                                                                      ? ColorConstant
                                                                          .maingreen
                                                                      : walletList?[index].status ==
                                                                              2
                                                                          ? ColorConstant
                                                                              .blue
                                                                          : ColorConstant
                                                                              .orangeA200,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ))
                                                  ]))),
                                ),
                                // Container(
                                //     height: 50,
                                //     // alignment: Alignment.topCenter,
                                //     padding: const EdgeInsets.only(left: 10, right: 10),
                                //     decoration: const BoxDecoration(
                                //       color: ColorConstant.maingreen,
                                //     ),
                                //     child: IntrinsicHeight(
                                //       child: Row(
                                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //         crossAxisAlignment: CrossAxisAlignment.center,
                                //         children: [
                                //           Expanded(
                                //             child: Text(
                                //               AppLocalizations.of(context)!.requestAmountty,
                                //               maxLines: 2,
                                //               style: AppStyle.wallatmoneylist,
                                //               textAlign: TextAlign.center,
                                //             ),
                                //           ),
                                //           VerticalDivider(
                                //             color: Colors.white,
                                //             width: 5,
                                //             thickness: 2,
                                //           ),
                                //           Expanded(
                                //             child: Text(
                                //               AppLocalizations.of(context)!.approvedAmountty,
                                //               maxLines: 2,
                                //               style: AppStyle.wallatmoneylist,
                                //               textAlign: TextAlign.center,
                                //             ),
                                //           ),
                                //           VerticalDivider(
                                //             color: Colors.white,
                                //             width: 5,
                                //             thickness: 2,
                                //           ),
                                //           Expanded(
                                //             child: Text(
                                //               AppLocalizations.of(context)!.requsetDateLoan,
                                //               maxLines: 2,
                                //               style: AppStyle.wallatmoneylist,
                                //               textAlign: TextAlign.center,
                                //             ),
                                //           ),
                                //           VerticalDivider(
                                //             color: Colors.white,
                                //             width: 5,
                                //             thickness: 2,
                                //           ),
                                //           Expanded(
                                //             child: Text(
                                //               AppLocalizations.of(context)!.status,
                                //               maxLines: 2,
                                //               style: AppStyle.wallatmoneylist,
                                //               textAlign: TextAlign.center,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     )),
                                // cont.withdrawllist.isEmpty
                                //     ? Expanded(
                                //         child: Padding(
                                //         padding: const EdgeInsets.all(20.0),
                                //         child: Center(
                                //           child: Text(
                                //             AppLocalizations.of(context)!.nodataFound,
                                //             style: TextStyle(
                                //                 fontSize: 18,
                                //                 fontWeight: FontWeight.w500,
                                //
                                //                 color: Colors.black),
                                //           ),
                                //         ),
                                //       ))
                                //     : Expanded(
                                //         child: ListView.builder(
                                //             itemCount: cont.withdrawllist.length,
                                //             itemBuilder: (BuildContext context, int index) {
                                //               var date = DateFormat('dd/MMM/yyyy').format(
                                //                   DateTime.parse(cont
                                //                       .withdrawllist[index].createdAt
                                //                       .toString()));
                                //               return Container(
                                //                   height: 50,
                                //                   margin: const EdgeInsets.only(bottom: 3.0),
                                //                   decoration: BoxDecoration(
                                //                     // color: ColorConstant.mainlistgrayclr,
                                //                     color: (index % 2 == 0)
                                //                         ? ColorConstant.mainlistgrayclr
                                //                         : Colors.white,
                                //                   ),
                                //                   child: Column(
                                //                     mainAxisAlignment: MainAxisAlignment.center,
                                //                     crossAxisAlignment:
                                //                         CrossAxisAlignment.center,
                                //                     children: [
                                //                       IntrinsicHeight(
                                //                         child: Padding(
                                //                           padding: const EdgeInsets.only(
                                //                             left: 8.0,
                                //                             right: 8.0,
                                //                           ),
                                //                           child: Row(
                                //                             children: [
                                //                               Expanded(
                                //                                 child: Center(
                                //                                   child: Text(
                                //                                       "${cont.withdrawllist[index].requestedAmount.toString()} ₹",
                                //                                       style: AppStyle
                                //                                           .aplayforloan
                                //                                           .copyWith(
                                //                                               fontSize: 12,
                                //                                               fontWeight:
                                //                                                   FontWeight
                                //                                                       .w500)),
                                //                                 ),
                                //                               ),
                                //                               const VerticalDivider(
                                //                                 color: ColorConstant
                                //                                     .listdivaderclr,
                                //                                 width: 10,
                                //                                 thickness: 2,
                                //                               ),
                                //                               Expanded(
                                //                                 child: Center(
                                //                                   child: Text(
                                //                                     cont.withdrawllist[index]
                                //                                                 .approvedAmount ==
                                //                                             null
                                //                                         ? "0.0"
                                //                                         : cont
                                //                                             .withdrawllist[
                                //                                                 index]
                                //                                             .approvedAmount
                                //                                             .toString(),
                                //                                     style: AppStyle
                                //                                         .lblwarehousename
                                //                                         .copyWith(
                                //                                             color: Colors.black,
                                //                                             fontSize: 12,
                                //                                             fontWeight:
                                //                                                 FontWeight
                                //                                                     .w500),
                                //                                     textAlign: TextAlign.center,
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                               const VerticalDivider(
                                //                                 color: ColorConstant
                                //                                     .listdivaderclr,
                                //                                 width: 10,
                                //                                 thickness: 2,
                                //                               ),
                                //                               Expanded(
                                //                                 child: Center(
                                //                                   child: Text(
                                //                                     date,
                                //                                     style: AppStyle
                                //                                         .lblwarehousename
                                //                                         .copyWith(
                                //                                             color: ColorConstant
                                //                                                 .maingreen,
                                //                                             fontSize: 12,
                                //                                             fontWeight:
                                //                                                 FontWeight
                                //                                                     .w500),
                                //                                     textAlign: TextAlign.center,
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                               const VerticalDivider(
                                //                                 color: ColorConstant
                                //                                     .listdivaderclr,
                                //                                 width: 10,
                                //                                 thickness: 2,
                                //                               ),
                                //                               Expanded(
                                //                                 child: Center(
                                //                                     child: Text(
                                //                                   cont.withdrawllist[index]
                                //                                               .status ==
                                //                                           0
                                //                                       ? AppLocalizations.of(context)!.rejected
                                //                                       : cont
                                //                                                   .withdrawllist[
                                //                                                       index]
                                //                                                   .status ==
                                //                                               2
                                //                                           ? "msg_status_approved"
                                //                                               .tr
                                //                                           : cont
                                //                                                       .withdrawllist[
                                //                                                           index]
                                //                                                       .status ==
                                //                                                   3
                                //                                               ? "msg_status_verified"
                                //                                                   .tr
                                //                                               : AppLocalizations.of(context)!.request,
                                //                                   style: TextStyle(
                                //                                       color: cont
                                //                                                   .withdrawllist[
                                //                                                       index]
                                //                                                   .status ==
                                //                                               0
                                //                                           ? ColorConstant.grey
                                //                                           : cont
                                //                                                       .withdrawllist[
                                //                                                           index]
                                //                                                       .status ==
                                //                                                   3
                                //                                               ? ColorConstant
                                //                                                   .maingreen
                                //                                               : cont
                                //                                                           .withdrawllist[
                                //                                                               index]
                                //                                                           .status ==
                                //                                                       2
                                //                                                   ? ColorConstant
                                //                                                       .blue
                                //                                                   : ColorConstant
                                //                                                       .orangeA200,
                                //                                       fontSize: 12,
                                //                                       fontWeight:
                                //                                           FontWeight.w500),
                                //                                 )),
                                //                               )
                                //                             ],
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   ));
                                //             }),
                                //       ),
                              ],
                            );
                },
                error: (e, s) => Container(),
                loading: () => defaultLoader()),
            onRefresh: () {
              return Future(() => ref.invalidate(walletFutureProvider));
            }));
  }
}
