// import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart'
    hide matchedOrdersProvider;
import 'package:apnagodam/presentation/sbt/SbtDeals.dart';
import 'package:apnagodam/presentation/sbt/service/SbtService.dart';

import 'package:apnagodam/presentation/sbt/service/model/MarkDeliveryRequestModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/SbtStacksListModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/SbtTerminalsListModel.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/progress_dialog_utils.dart';
import '../../core/utils/theme/app_style.dart';
import '../my_Stock/my_stock_impl/service/my_stock_service.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Markdeliveryscreen extends ConsumerStatefulWidget {
  const Markdeliveryscreen(
      {super.key,
      required this.id,
      required this.price,
      required this.districtId,
      required this.commodityId,
      required this.isScreen});

  final String id;
  final String price;
  final String districtId;
  final String commodityId;
  final bool isScreen;

  @override
  ConsumerState<Markdeliveryscreen> createState() => _MarkdeliveryscreenState();
}

class _MarkdeliveryscreenState extends ConsumerState<Markdeliveryscreen> {
  var stackWiseList = StateProvider((ref) => []);
  var panelController = StateProvider((ref) => PanelController());
  var terminalValue = StateProvider<SbtTerminalDatum?>((ref) => null);
  var stacksValue = StateProvider<StacksListDatum?>((ref) => null);
  bool _isSubmitting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.orderInventories),
        ),
        body:
            ref
                .watch(sbtTerminalsListProvider(districtId: widget.districtId))
                .when(
                    data: (terminalsData) => SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: const Pad(all: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    border: Border.all()),
                                height: 50,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<SbtTerminalDatum>(
                                    onTap: () {},
                                    isExpanded: true,
                                    value: ref.watch(terminalValue),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    hint: Center(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .msgTerminalname)),
                                    items: List.generate(
                                        terminalsData.data?.length ?? 0,
                                        (index) => DropdownMenuItem(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              value: terminalsData.data?[index],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    Radio<SbtTerminalDatum>(
                                                      value: terminalsData
                                                          .data![index],
                                                      groupValue: ref
                                                          .watch(terminalValue),
                                                      onChanged: (value) {
                                                        ref
                                                            .read(terminalValue
                                                                .notifier)
                                                            .state = value;

                                                        ref.invalidate(
                                                            stacksValue);
                                                      },
                                                      activeColor: ColorConstant
                                                          .maingreen,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                      '${terminalsData.data?[index].warehouseName}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            )),
                                    onChanged: (val) {
                                      ref.read(terminalValue.notifier).state =
                                          val;
                                      ref.invalidate(stacksValue);
                                    },
                                  ),
                                ),
                              ),
                              if (ref.watch(terminalValue) != null)
                                ref
                                    .watch(sbtStackListProvider(
                                        warehouseId:
                                            "${ref.watch(terminalValue)?.id}",
                                        commodityId: widget.commodityId))
                                    .when(
                                        data: (stacksData) => (stacksData
                                                        .data ??
                                                    [])
                                                .isNotEmpty
                                            ? Container(
                                                margin: const Pad(all: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(8)),
                                                    border: Border.all()),
                                                height: 50,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<
                                                      StacksListDatum>(
                                                    onTap: () {},
                                                    isExpanded: true,
                                                    value:
                                                        ref.watch(stacksValue),
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
                                                    hint: Center(
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .msgStack)),
                                                    items: List.generate(
                                                        stacksData
                                                                .data?.length ??
                                                            0,
                                                        (index) =>
                                                            DropdownMenuItem(
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .center,
                                                              value: stacksData
                                                                  .data?[index],
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Row(
                                                                  children: [
                                                                    Radio<StacksListDatum>(
                                                                      value:
                                                                          stacksData
                                                                              .data![index],
                                                                      groupValue: ref
                                                                          .watch(
                                                                              stacksValue),
                                                                      onChanged:
                                                                          (value) {
                                                                        ref.read(stacksValue.notifier).state =
                                                                            value;
                                                                      },
                                                                      activeColor:
                                                                          ColorConstant
                                                                              .maingreen,
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      '${stacksData.data?[index].stackNo}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                    ))
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                    onChanged: (val) {
                                                      ref
                                                          .read(stacksValue
                                                              .notifier)
                                                          .state = val;
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        error: (e, s) => Container(),
                                        loading: () => Container()),
                              if (ref.watch(stacksValue) != null)
                                ref
                                    .watch(orderInventoriesProvider(
                                        id: widget.id,
                                        warehouseId:
                                            "${ref.watch(terminalValue)?.id}",
                                        stackNo:
                                            "${ref.watch(stacksValue)?.stackNo}"))
                                    .when(
                                        data: (data) => ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data.data?.length ?? 0,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder:
                                                (context, index) => InkWell(
                                                      onTap: () {
                                                        ref
                                                            .watch(getWantToSellResponseProvider(
                                                                    inventoryId:
                                                                        "${data.data?[index].id}",
                                                                    price: widget
                                                                        .price)
                                                                .future)
                                                            .then((value) {
                                                          var note =
                                                              "ऐप द्वारा दिया गया भाव ₹ ${widget.price} गुणवत्ता के मानको अधीन है, इसमें से क्वालिटी क्लेम राशि ${value.data} रूपए (Qtl.) वॉलेट से काट लिया जायेगा ।";
                                                          if (ref
                                                              .watch(
                                                                  stackWiseList)
                                                              .contains(data
                                                                  .data?[index]
                                                                  .id)) {
                                                            ref
                                                                .watch(
                                                                    stackWiseList)
                                                                .remove(data
                                                                    .data?[
                                                                        index]
                                                                    .id);

                                                            if (ref
                                                                    .watch(
                                                                        panelController)
                                                                    .isPanelOpen &&
                                                                ref
                                                                    .watch(
                                                                        stackWiseList)
                                                                    .isEmpty) {
                                                              ref
                                                                  .watch(
                                                                      panelController)
                                                                  .close();
                                                            }
                                                            setState(() {});
                                                          } else {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .msgAlert,
                                                                    ),
                                                                    content: Text(
                                                                        note),
                                                                    surfaceTintColor:
                                                                        Colors
                                                                            .white,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context, rootNavigator: true).pop();
                                                                            // var inventoriesId,
                                                                            // var price,
                                                                            // var weight,
                                                                            // double resultDealPayment,
                                                                            // double effectivePending,
                                                                            // balanceAmount,
                                                                            // double walletSettlementAmount
                                                                            ref.watch(stackWiseList).clear();
                                                                            ref.watch(stackWiseList.notifier).state =
                                                                                [
                                                                              ...ref.watch(stackWiseList),
                                                                              int.parse("${data.data?[index].id ?? ""}")
                                                                            ];

                                                                            // if (!ref
                                                                            //         .watch(
                                                                            //             panelController)
                                                                            //         .isPanelOpen &&
                                                                            //     ref
                                                                            //         .watch(
                                                                            //             stackWiseList)
                                                                            //         .isNotEmpty) {
                                                                            //   ref
                                                                            //       .watch(
                                                                            //           panelController)
                                                                            //       .open();
                                                                            // }
                                                                            setState(() {});
                                                                            // ref.watch(stackWiseList).add(data.data?[index].id.toString().toInt());
                                                                            // ref.watch(totalPayableAmountProvider.notifier).state +=
                                                                            //     double.parse(data.data?[index].outstanding ?? "0.0");
                                                                            // ref.watch(panelController).open();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.msgOk,
                                                                            style:
                                                                                AppStyle.lbltermncon,
                                                                          ))
                                                                    ],
                                                                  );
                                                                });
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: const Pad(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                        padding: const Pad(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                        decoration: BoxDecoration(
                                                            color: (index % 2 == 0)
                                                                ? const Color(
                                                                    0xffebebeb)
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                width: 1.5,
                                                                color: ref
                                                                        .watch(
                                                                            stackWiseList)
                                                                        .contains(data
                                                                            .data?[
                                                                                index]
                                                                            .id)
                                                                    ? ColorConstant
                                                                        .maingreen
                                                                    : Colors
                                                                        .transparent)),
                                                        child: Column(
                                                          children: [
                                                            Center(
                                                                child: Text(
                                                              "${data.data?[index].warehouseName ?? 0}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .msgGatepass,
                                                                      style: AppStyle
                                                                          .mystokedetail,
                                                                    )),
                                                                    Text(
                                                                      '${data.data?[index].gatePass}',
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .msgStackno,
                                                                      style: AppStyle
                                                                          .mystokedetail,
                                                                    )),
                                                                    Text(
                                                                      "${data.data?[index].stackNo}",
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      "${AppLocalizations.of(context)!.msgQuantity} : ",
                                                                      style: AppStyle
                                                                          .mystokedetail,
                                                                    )),
                                                                    Text(
                                                                      "${data.data?[index].quantity}",
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .msgBags,
                                                                      style: AppStyle
                                                                          .mystokedetail,
                                                                    )),
                                                                    Text(
                                                                      "${data.data?[index].bag}",
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Expanded(
                                                                    child: Text(
                                                                        'Warehouse: ')),
                                                                Text(
                                                                  "${data.data?[index].warehouseName}",
                                                                  maxLines: 2,
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .msgCommodity,
                                                                  style: AppStyle
                                                                      .mystokedetail,
                                                                )),
                                                                Text(
                                                                  '${data.data?[index].commodityName}',
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            double.parse(
                                                                        "${data.data?[index].quantity ?? "0.0"}") ==
                                                                    0.0
                                                                ? Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .done,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  )
                                                                : const SizedBox(),
                                                            ref
                                                                    .watch(
                                                                        stackWiseList)
                                                                    .contains(data
                                                                        .data?[
                                                                            index]
                                                                        .id)
                                                                ? SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: AppStyle
                                                                          .buttonStyle,
                                                                      onPressed: _isSubmitting
                                                                          ? null // ✅ disables button while loading
                                                                          : () async {
                                                                              if (ref.watch(stackWiseList).isEmpty) {
                                                                                Get.rawSnackbar(
                                                                                  message: AppLocalizations.of(context)!.pleaseSelectAtleastOneOrderToMarkDelivery,
                                                                                  duration: const Duration(seconds: 10),
                                                                                  backgroundColor: ColorConstant.red500,
                                                                                );
                                                                                return;
                                                                              }

                                                                              // ✅ Show loader ONLY on button, not whole screen
                                                                              setState(() => _isSubmitting = true);

                                                                              List<int> inventoryIdList = [];
                                                                              ref.watch(stackWiseList).forEach((element) {
                                                                                inventoryIdList.add(element);
                                                                              });

                                                                              var markDeliveryRequestModel = MarkDeliveryRequestModel(inventoryIdList, widget.id);

                                                                              try {
                                                                                final value = await ref.read(
                                                                                  markDeliveryProvider(
                                                                                    model: markDeliveryRequestModel,
                                                                                  ).future,
                                                                                );

                                                                                if (!mounted) return;
                                                                                if (value['status'].toString() == "1") {
                                                                                  print("SUCCESS API");

                                                                                  // ProgressDialogUtils.hideProgressDialog();

                                                                                  ref.invalidate(matchedOrdersProvider);

                                                                                  Get.rawSnackbar(
                                                                                    message: value['message'].toString(),
                                                                                    duration: const Duration(seconds: 3),
                                                                                    backgroundColor: ColorConstant.maingreen,
                                                                                  );

                                                                                  Navigator.of(context).pop();
                                                                                } else {
                                                                                  Get.rawSnackbar(
                                                                                    message: value['message'].toString(),
                                                                                    duration: const Duration(seconds: 10),
                                                                                    backgroundColor: ColorConstant.red500, // ✅ red for error, not green
                                                                                  );
                                                                                }
                                                                              } catch (e, s) {
                                                                                debugPrint('Mark delivery error: $e\n$s');
                                                                                Get.rawSnackbar(
                                                                                  message: 'Something went wrong. Please try again.',
                                                                                  duration: const Duration(seconds: 5),
                                                                                  backgroundColor: ColorConstant.red500,
                                                                                );
                                                                              } finally {
                                                                                // ✅ Always reset loader, even on error
                                                                                if (mounted) setState(() => _isSubmitting = false);
                                                                              }
                                                                            },

// ✅ Show spinner inside button while submitting
                                                                      child: _isSubmitting
                                                                          ? const SizedBox(
                                                                              height: 20,
                                                                              width: 20,
                                                                              child: CircularProgressIndicator(
                                                                                color: Colors.white,
                                                                                strokeWidth: 2,
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              AppLocalizations.of(context)!.msgSubmit,
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: Adaptive.sp(16),
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  )
                                                                : const SizedBox()
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                        // ✅ CHANGE TO
                                        error: (e, s) => Container(),
                                        loading: () =>
                                            Container()) // ← Container() not defaultLoader()
                            ],
                          ),
                        ),
                    // ✅ REPLACE WITH
                    error: (e, s) => Container(),
                    loading: () =>
                        Container(), // ← change defaultLoader() to Container()
                    skipLoadingOnRefresh: true));
  }
}
