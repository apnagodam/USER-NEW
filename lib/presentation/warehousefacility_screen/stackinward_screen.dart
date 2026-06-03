// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';

import 'package:apnagodam/presentation/warehousefacility_screen/repo_impl/warehouse_facility_repo_impl.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/service/warehouse_facility_service.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/CommonTextField.dart';
import '../../widgets/dailogs/error.dart';
import 'inwardList.dart';
import 'model/InwardsTerminalResponse.dart';
import 'model/TripIdModel.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class StackInward extends ConsumerStatefulWidget {
  StackInward({super.key, this.isAppbarVisible});

  bool? isAppbarVisible = false;

  @override
  ConsumerState<StackInward> createState() => _StackInwardState();
}

class _StackInwardState extends ConsumerState<StackInward> {
  var terminalValue = StateProvider<TerminalDatum?>((ref) => null);
  var commodityValue = StateProvider<CommodityDatum?>((ref) => null);
  var stackValue = StateProvider<StackNumber?>((ref) => null);
  var isMandiTax = StateProvider((ref) => false);
  var imageProvider = StateProvider<File?>((ref) => null);
  var commodityProvider = StateProvider((ref) => CommodityType.Default);
  var tripIdProvider = StateProvider<Datum?>((ref) => null);
  var transportTypeProvider =
      StateProvider((ref) => TransporterType.defaultType);

  var vehicleTypeProvider = StateProvider((ref) => VehicleType.Default);
  var isTaxTypeVisible = StateProvider((ref) => false);
  var commodityTypeList = CommodityType.values;
  var commodityType = CommodityType.Default;
  ImagePicker imagepicker = ImagePicker();
  TextEditingController weightController = TextEditingController();
  TextEditingController drivernoContriller = TextEditingController();
  TextEditingController vehiclenoContriller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var selectedTabIndex = StateProvider((ref) => 0);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {
        "label": AppLocalizations.of(context)!.inwardRequest,
        "index": 0,
        "icon": Icons.warehouse
      },
      {
        "label": AppLocalizations.of(context)!.history2,
        "index": 1,
        "icon": Icons.qr_code_2
      },
    ];

    return Scaffold(
        backgroundColor: ColorConstant.bgcolor,
        appBar: widget.isAppbarVisible == true
            ? AppBar(
                title: Text(AppLocalizations.of(context)!.inwards3),
              )
            : null,
        body: SafeArea(
            child: Form(
          key: formKey,
          child: Scaffold(
            floatingActionButton: simpleButton(
                text: AppLocalizations.of(context)!.history2,
                callback: () {
                  Get.to(InwardList());
                }),
            body: ListView(
              children: [
                ref.watch(inwardsTerminalProvider()).when(
                    data: (terminals) => Padding(
                          padding: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all()),
                                  height: 50,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<TerminalDatum>(
                                      onTap: () {},
                                      isExpanded: true,
                                      value: ref.watch(terminalValue),
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      hint: Center(
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .msgTerminalname)),
                                      items: List.generate(
                                          terminals.terminalData?.length ?? 0,
                                          (index) => DropdownMenuItem(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                value: terminals
                                                    .terminalData?[index],
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    children: [
                                                      Radio(
                                                        value: ref.watch(
                                                            terminalValue),
                                                        groupValue: terminals
                                                                .terminalData?[
                                                            index],
                                                        onChanged: (value) {
                                                          ref
                                                              .watch(
                                                                  terminalValue
                                                                      .notifier)
                                                              .state = value;
                                                          ref.invalidate(
                                                              stackValue);
                                                          ref.invalidate(
                                                              commodityValue);
                                                          ref.invalidate(
                                                              isMandiTax);
                                                          ref.invalidate(
                                                              imageProvider);
                                                          weightController
                                                              .text = "";
                                                        },
                                                        activeColor:
                                                            ColorConstant
                                                                .maingreen,
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        '${terminals.terminalData?[index].terminalName}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              )),
                                      onChanged: (val) {
                                        ref
                                            .watch(terminalValue.notifier)
                                            .state = val;
                                        ref.invalidate(stackValue);
                                        ref.invalidate(commodityValue);
                                        ref.invalidate(isMandiTax);
                                        ref.invalidate(imageProvider);
                                        weightController.text = "";
                                        ref
                                            .watch(inwardsTerminalProvider(
                                                    terminalId:
                                                        "${ref.watch(terminalValue)?.terminalId ?? 0}")
                                                .future)
                                            .then((value) {})
                                            .onError((e, s) {
                                          errorBottomSheet(
                                              context, e.toString());
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ref.watch(terminalValue) == null
                                    ? SizedBox()
                                    : ref
                                        .watch(inwardsCommodityProvider(
                                            terminalId: ref
                                                .watch(terminalValue)
                                                ?.terminalId
                                                .toString()))
                                        .when(
                                            data: (commodityData) => Visibility(
                                                    child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      border: Border.all()),
                                                  height: 50,
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton<
                                                        CommodityDatum>(
                                                      isExpanded: true,
                                                      value: ref.watch(
                                                          commodityValue),
                                                      icon: Icon(Icons
                                                          .keyboard_arrow_down),
                                                      hint: Center(
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .msgCommodityy3)),
                                                      items: List.generate(
                                                          commodityData
                                                                  .commodityData
                                                                  ?.length ??
                                                              0,
                                                          (index) =>
                                                              DropdownMenuItem(
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .center,
                                                                value: commodityData
                                                                        .commodityData?[
                                                                    index],
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  child: Row(
                                                                    children: [
                                                                      Radio(
                                                                        value: ref
                                                                            .watch(commodityValue),
                                                                        groupValue:
                                                                            commodityData.commodityData?[index],
                                                                        onChanged:
                                                                            (value) {
                                                                          ref.invalidate(
                                                                              stackValue);
                                                                          ref.invalidate(
                                                                              imageProvider);
                                                                          weightController.text =
                                                                              "";
                                                                          ref.watch(commodityValue.notifier).state =
                                                                              value;
                                                                        },
                                                                        activeColor:
                                                                            ColorConstant.maingreen,
                                                                      ),
                                                                      Expanded(
                                                                          child:
                                                                              Text("${commodityData.commodityData?[index].commodityName}"))
                                                                    ],
                                                                  ),
                                                                ),
                                                              )),
                                                      onChanged: (val) {
                                                        ref.invalidate(
                                                            stackValue);
                                                        ref.invalidate(
                                                            imageProvider);
                                                        ref.invalidate(
                                                            isTaxTypeVisible);
                                                        weightController.text =
                                                            "";
                                                        ref
                                                            .watch(
                                                                isTaxTypeVisible
                                                                    .notifier)
                                                            .state = true;
                                                        ref
                                                            .watch(
                                                                commodityValue
                                                                    .notifier)
                                                            .state = val;
                                                      },
                                                    ),
                                                  ),
                                                )),
                                            error: (e, s) => Container(),
                                            loading: () => Container()),
                                SizedBox(
                                  height: 10,
                                ),
                                ref.watch(commodityValue) == null
                                    ? SizedBox()
                                    : ref
                                        .watch(inwardsStackProvider(
                                            terminalId: ref
                                                .watch(terminalValue)
                                                ?.terminalId
                                                .toString(),
                                            commodityId: ref
                                                .watch(commodityValue)
                                                ?.commodityId
                                                .toString()))
                                        .when(
                                            data: (stackData) => Visibility(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all()),
                                                    height: 50,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          StackNumber>(
                                                        isExpanded: true,
                                                        value: ref
                                                            .watch(stackValue),
                                                        icon: Icon(Icons
                                                            .keyboard_arrow_down),
                                                        hint: Center(
                                                            child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .msgStack3)),
                                                        items: List.generate(
                                                            stackData
                                                                    .stackNumber
                                                                    ?.length ??
                                                                0,
                                                            (index) =>
                                                                DropdownMenuItem(
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .center,
                                                                  value: stackData
                                                                          .stackNumber?[
                                                                      index],
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child: Row(
                                                                      children: [
                                                                        Radio(
                                                                          value:
                                                                              ref.watch(stackValue),
                                                                          groupValue:
                                                                              stackData.stackNumber?[index],
                                                                          onChanged:
                                                                              (value) {
                                                                            ref.watch(stackValue.notifier).state =
                                                                                value;
                                                                          },
                                                                          activeColor:
                                                                              ColorConstant.maingreen,
                                                                        ),
                                                                        Expanded(
                                                                            child:
                                                                                Text('${stackData.stackNumber?[index].stackNumber}'))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                        onChanged: (val) {
                                                          ref.invalidate(
                                                              imageProvider);
                                                          weightController
                                                              .text = "";
                                                          ref
                                                              .watch(stackValue
                                                                  .notifier)
                                                              .state = val;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            error: (e, s) => Container(),
                                            loading: () => Container()),
                                SizedBox(
                                  height: 10,
                                ),
                                ref.watch(stackValue) == null
                                    ? SizedBox()
                                    : Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            border: Border.all()),
                                        height: 50,
                                        child: Center(
                                            child: Text(
                                                '${ref.watch(stackValue)?.stackType}')),
                                      ),
                                SizedBox(
                                  height: 15,
                                ),
                                ref.watch(stackValue) == null
                                    ? SizedBox()
                                    : ref
                                        .watch(inwardsCommodityProvider(
                                            terminalId: ref
                                                .watch(terminalValue)
                                                ?.terminalId
                                                .toString()))
                                        .when(
                                            data: (data) => Visibility(
                                                visible:
                                                    ref.watch(isTaxTypeVisible),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      border: Border.all()),
                                                  height: 50,
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton<
                                                        CommodityType>(
                                                      isExpanded: true,
                                                      value: ref.watch(
                                                          commodityProvider),
                                                      icon: Icon(Icons
                                                          .keyboard_arrow_down),
                                                      hint: Center(
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .msgCommodityy3)),
                                                      items: List.generate(
                                                          commodityTypeList
                                                                  .length ??
                                                              0,
                                                          (index) =>
                                                              DropdownMenuItem(
                                                                alignment:
                                                                    AlignmentDirectional
                                                                        .center,
                                                                value:
                                                                    commodityTypeList[
                                                                        index],
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  child: Row(
                                                                    children: [
                                                                      Visibility(
                                                                          visible: ref.watch(commodityProvider) !=
                                                                              CommodityType
                                                                                  .Default,
                                                                          child:
                                                                              Radio(
                                                                            value:
                                                                                ref.watch(commodityProvider),
                                                                            groupValue:
                                                                                commodityTypeList[index],
                                                                            onChanged:
                                                                                (value) {
                                                                              commodityType = value!;
                                                                            },
                                                                            activeColor:
                                                                                ColorConstant.maingreen,
                                                                          )),
                                                                      Expanded(
                                                                          child:
                                                                              Text(commodityTypeList[index].label))
                                                                    ],
                                                                  ),
                                                                ),
                                                              )),
                                                      onChanged: (val) {
                                                        ref
                                                            .watch(
                                                                commodityProvider
                                                                    .notifier)
                                                            .state = val!;

                                                        if (val !=
                                                            CommodityType
                                                                .MandiTax) {
                                                          ref.invalidate(
                                                              imageProvider);
                                                        }
                                                        // cont.newcommodityvalue!.commodityTax
                                                        //             .toString() ==
                                                        //         "0"
                                                        //     ? ref.watch(isMandiTax.notifier).state =
                                                        //         false
                                                        //     : ref.watch(isMandiTax.notifier).state =
                                                        //         true;
                                                      },
                                                    ),
                                                  ),
                                                )),
                                            error: (e, s) => Container(),
                                            loading: () => Container()),
                                SizedBox(
                                  height: 15,
                                ),
                                Visibility(
                                    visible:
                                        ref.watch(commodityProvider).type ==
                                            CommodityType.MandiTax.type,
                                    child: ref.watch(imageProvider) == null
                                        ? SizedBox(
                                            width: Get.width,
                                            child: InkWell(
                                              onTap: () {
                                                Get.defaultDialog(
                                                    title: AppLocalizations.of(
                                                            context)!
                                                        .pickImage2,
                                                    middleText: "",
                                                    content: Row(
                                                      children: [
                                                        Expanded(
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  await imagepicker
                                                                      .pickImage(
                                                                          source: ImageSource
                                                                              .camera)
                                                                      .then(
                                                                          (value) {
                                                                    if (value !=
                                                                        null) {
                                                                      ref.watch(imageProvider.notifier).state =
                                                                          File(value
                                                                              .path);
                                                                      if (Get
                                                                          .isDialogOpen!) {
                                                                        Get.close(
                                                                            1);
                                                                      }
                                                                    }
                                                                  }).onError((e,
                                                                          s) {
                                                                    errorBottomSheet(
                                                                        context,
                                                                        e.toString());
                                                                  });
                                                                },
                                                                icon: Column(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .camera),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .takePicture2,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                ))),
                                                        Expanded(
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  await imagepicker
                                                                      .pickImage(
                                                                          source: ImageSource
                                                                              .gallery)
                                                                      .then(
                                                                          (value) {
                                                                    if (value !=
                                                                        null) {
                                                                      ref.watch(imageProvider.notifier).state =
                                                                          File(value
                                                                              .path);

                                                                      if (Get
                                                                          .isDialogOpen!) {
                                                                        Get.close(
                                                                            1);
                                                                      }
                                                                    }
                                                                  }).onError((e,
                                                                          s) {
                                                                    errorBottomSheet(
                                                                        context,
                                                                        e.toString());
                                                                  });
                                                                },
                                                                icon: Column(
                                                                  children: [
                                                                    Icon(Icons
                                                                        .wallpaper),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Text(
                                                                        AppLocalizations.of(context)!
                                                                            .selectFromGallery,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold))
                                                                  ],
                                                                )))
                                                      ],
                                                    ));
                                              },
                                              child: Card(
                                                color: ColorConstant.maingreen,
                                                elevation: 8,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .selectImage,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Get.defaultDialog(
                                                  title: AppLocalizations.of(
                                                          context)!
                                                      .pickImage2,
                                                  middleText: "",
                                                  content: Row(
                                                    children: [
                                                      Expanded(
                                                          child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                await imagepicker
                                                                    .pickImage(
                                                                        source: ImageSource
                                                                            .camera)
                                                                    .then(
                                                                        (value) {
                                                                  if (value !=
                                                                      null) {
                                                                    ref.watch(imageProvider.notifier).state =
                                                                        File(value
                                                                            .path);
                                                                    if (Get
                                                                        .isDialogOpen!) {
                                                                      Get.close(
                                                                          1);
                                                                    }
                                                                  }
                                                                }).onError(
                                                                        (e, s) {
                                                                  errorBottomSheet(
                                                                      context,
                                                                      e.toString());
                                                                });
                                                              },
                                                              icon: Column(
                                                                children: [
                                                                  Icon(Icons
                                                                      .camera),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .takePicture2,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ],
                                                              ))),
                                                      Expanded(
                                                          child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                await imagepicker
                                                                    .pickImage(
                                                                        source: ImageSource
                                                                            .gallery)
                                                                    .then(
                                                                        (value) {
                                                                  if (value !=
                                                                      null) {
                                                                    ref.watch(imageProvider.notifier).state =
                                                                        File(value
                                                                            .path);

                                                                    if (Get
                                                                        .isDialogOpen!) {
                                                                      Get.close(
                                                                          1);
                                                                    }
                                                                  }
                                                                }).onError(
                                                                        (e, s) {
                                                                  errorBottomSheet(
                                                                      context,
                                                                      e.toString());
                                                                });
                                                              },
                                                              icon: Column(
                                                                children: [
                                                                  Icon(Icons
                                                                      .wallpaper),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .selectFromGallery,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold))
                                                                ],
                                                              )))
                                                    ],
                                                  ));
                                            },
                                            child: Image.file(
                                              ref.watch(imageProvider) ??
                                                  File(''),
                                              height: Get.height / 4,
                                            ),
                                          )),
                                SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                    visible: ref.watch(stackValue) != null,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 15.0),
                                      child: CommonTextField(
                                        controller: weightController,
                                        label: AppLocalizations.of(context)!
                                            .msgWeightwithqtl,
                                        textInputAction: TextInputAction.next,
                                        inputType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        enabled: true,
                                        isRequired: true,
                                      ),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: ref.watch(stackValue) != null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all()),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<TransporterType>(
                                        isExpanded: true,
                                        value: ref.watch(transportTypeProvider),
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        hint: Center(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .msgCommodityy)),
                                        items: List.generate(
                                            TransporterType.values.length,
                                            (index) => DropdownMenuItem(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  value: TransporterType
                                                      .values[index],
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Row(
                                                      children: [
                                                        Visibility(
                                                            visible: ref.watch(
                                                                    transportTypeProvider) !=
                                                                TransporterType
                                                                    .defaultType,
                                                            child: Radio(
                                                              value: ref.watch(
                                                                  transportTypeProvider),
                                                              groupValue:
                                                                  TransporterType
                                                                          .values[
                                                                      index],
                                                              onChanged:
                                                                  (value) {
                                                                ref
                                                                    .watch(transportTypeProvider
                                                                        .notifier)
                                                                    .state = value!;
                                                              },
                                                              activeColor:
                                                                  ColorConstant
                                                                      .maingreen,
                                                            )),
                                                        Expanded(
                                                            child: Text(
                                                                TransporterType
                                                                    .values[
                                                                        index]
                                                                    .label))
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                        onChanged: (val) {
                                          ref
                                              .watch(transportTypeProvider
                                                  .notifier)
                                              .state = val!;

                                          if (ref.watch(commodityProvider) !=
                                              CommodityType.MandiTax) {
                                            ref.invalidate(imageProvider);
                                          }
                                          // cont.newcommodityvalue!.commodityTax
                                          //             .toString() ==
                                          //         "0"
                                          //     ? ref.watch(isMandiTax.notifier).state =
                                          //         false
                                          //     : ref.watch(isMandiTax.notifier).state =
                                          //         true;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: ref.watch(transportTypeProvider) ==
                                      TransporterType.own,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all()),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<VehicleType>(
                                        isExpanded: true,
                                        value: ref.watch(vehicleTypeProvider),
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        hint: Center(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .msgTransportType)),
                                        items: List.generate(
                                            VehicleType.values.length,
                                            (index) => DropdownMenuItem(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  value:
                                                      VehicleType.values[index],
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Row(
                                                      children: [
                                                        Visibility(
                                                            visible: ref.watch(
                                                                    vehicleTypeProvider) !=
                                                                VehicleType
                                                                    .Default,
                                                            child: Radio(
                                                              value: ref.watch(
                                                                  vehicleTypeProvider),
                                                              groupValue:
                                                                  VehicleType
                                                                          .values[
                                                                      index],
                                                              onChanged:
                                                                  (value) {
                                                                ref
                                                                    .watch(vehicleTypeProvider
                                                                        .notifier)
                                                                    .state = value!;
                                                              },
                                                              activeColor:
                                                                  ColorConstant
                                                                      .maingreen,
                                                            )),
                                                        Expanded(
                                                            child: Text(
                                                                VehicleType
                                                                    .values[
                                                                        index]
                                                                    .label))
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                        onChanged: (val) {
                                          if (val == VehicleType.UnRegistered) {
                                            vehiclenoContriller.text =
                                                val!.label.toString();
                                          } else {
                                            vehiclenoContriller.text = '';
                                          }
                                          ref
                                              .watch(
                                                  vehicleTypeProvider.notifier)
                                              .state = val!;

                                          // cont.newcommodityvalue!.commodityTax
                                          //             .toString() ==
                                          //         "0"
                                          //     ? ref.watch(isMandiTax.notifier).state =
                                          //         false
                                          //     : ref.watch(isMandiTax.notifier).state =
                                          //         true;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: ref.watch(transportTypeProvider) ==
                                      TransporterType.own,
                                  child: ColumnSuper(children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 15.0),
                                      child: CommonTextField(
                                        controller: vehiclenoContriller,
                                        label: AppLocalizations.of(context)!
                                            .vehicleno,
                                        isRequired:
                                            ref.watch(vehicleTypeProvider) ==
                                                VehicleType.Registered,
                                        readOnly:
                                            ref.watch(vehicleTypeProvider) ==
                                                VehicleType.UnRegistered,
                                        enabled:
                                            ref.watch(vehicleTypeProvider) !=
                                                VehicleType.UnRegistered,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 15.0),
                                      child: CommonTextField(
                                        maxLength: 10,
                                        controller: drivernoContriller,
                                        label: AppLocalizations.of(context)!
                                            .driverMobileNo2,
                                        isOnlyDigit: true,
                                        // textInputAction: TextInputAction.next,
                                        // inputType: TextInputType.emailAddress,
                                        enabled: true,
                                        // isOnlyDigit: true,
                                        isRequired: true,
                                      ),
                                    )
                                  ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ref.watch(transportTypeProvider) !=
                                        TransporterType.company
                                    ? SizedBox()
                                    : ref
                                        .watch(inwardTripIdListProvider(
                                            terminal:
                                                "${ref.watch(terminalValue)?.terminalId}",
                                            commodity:
                                                "${ref.watch(commodityValue)?.commodityId}"))
                                        .when(
                                            data: (data) => Visibility(
                                                  visible: ref.watch(
                                                          transportTypeProvider) ==
                                                      TransporterType.company,
                                                  child: DropdownSearch<Datum?>(
                                                    compareFn: (item1, item2) =>
                                                        item1?.tripRequestId ==
                                                        item2?.tripRequestId,
                                                    popupProps: PopupProps.menu(
                                                        searchFieldProps:
                                                            TextFieldProps(
                                                                autofocus: true,
                                                                cursorColor:
                                                                    ColorConstant
                                                                        .maingreen,
                                                                padding: Pad(
                                                                    left: 10,
                                                                    right: 10),
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding:
                                                                      Pad(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          color:
                                                                              ColorConstant.maingreen)),
                                                                  disabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          color:
                                                                              ColorConstant.maingreen)),
                                                                  errorBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          color:
                                                                              ColorConstant.maingreen)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          color:
                                                                              ColorConstant.maingreen)),
                                                                  border: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          color:
                                                                              ColorConstant.maingreen)),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          color:
                                                                              ColorConstant.maingreen)),
                                                                )),
                                                        menuProps: MenuProps(
                                                            shape: RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    color: ColorConstant
                                                                        .maingreen),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        8))),
                                                        itemBuilder:
                                                            (context,
                                                                    terminal,
                                                                    isVisible,
                                                                    _) =>
                                                                ColumnSuper(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            Pad(all: 10),
                                                                        child:
                                                                            Text(
                                                                          "${terminal?.tripRequestId}",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: Adaptive.sp(16)),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            1,
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.3),
                                                                      ),
                                                                    ]),
                                                        title: Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .selectTripId,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                        16),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                        showSearchBox: true,
                                                        searchDelay: Duration(
                                                            microseconds: 500)),
                                                    filterFn: (user, filter) =>
                                                        user?.userFilterByCreationDate(
                                                            filter) ??
                                                        false,
                                                    // asyncItems: (String filter) => getData(filter),

                                                    items: (s, d) =>
                                                        data.data ?? [],
                                                    itemAsString: (Datum? u) =>
                                                        u?.tripRequestId ?? "",
                                                    onChanged: (Datum? data) =>
                                                        ref
                                                            .watch(
                                                                tripIdProvider
                                                                    .notifier)
                                                            .state = data,
                                                    decoratorProps:
                                                        DropDownDecoratorProps(
                                                      decoration: InputDecoration(
                                                          contentPadding: Pad(
                                                              left: 10,
                                                              bottom: 5,
                                                              top: 5),
                                                          hintText:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .selectTripId,
                                                          border: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8)),
                                                              borderSide: BorderSide(
                                                                  color: ColorConstant
                                                                      .maingreen))),
                                                    ),
                                                  ),
                                                ),
                                            error: (e, s) => Container(),
                                            loading: () =>
                                                CupertinoActivityIndicator()),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (ref.watch(terminalValue) == null) {
                                      Get.rawSnackbar(
                                          message: AppLocalizations.of(context)!
                                              .selectYourTerminal,
                                          duration: Duration(seconds: 2),
                                          backgroundColor:
                                              ColorConstant.red500);
                                    } else if (ref.watch(commodityValue) ==
                                        null) {
                                      Get.rawSnackbar(
                                          message: AppLocalizations.of(context)!
                                              .selectYourCommodity,
                                          duration: Duration(seconds: 2),
                                          backgroundColor:
                                              ColorConstant.red500);
                                    } else if (ref.watch(stackValue) == null) {
                                      Get.rawSnackbar(
                                          message: AppLocalizations.of(context)!
                                              .selectYourStack2,
                                          duration: Duration(seconds: 2),
                                          backgroundColor:
                                              ColorConstant.red500);
                                    } else if (weightController.text.isEmpty) {
                                      Get.rawSnackbar(
                                          message: AppLocalizations.of(context)!
                                              .selectYourWeight,
                                          duration: Duration(seconds: 2),
                                          backgroundColor:
                                              ColorConstant.red500);
                                    } else if (ref.watch(commodityProvider) ==
                                        CommodityType.Default) {
                                      Get.rawSnackbar(
                                          message: AppLocalizations.of(context)!
                                              .selectCommodityTaxType3,
                                          duration: Duration(seconds: 2),
                                          backgroundColor:
                                              ColorConstant.red500);
                                    } else if (ref.watch(commodityProvider) ==
                                            CommodityType.MandiTax &&
                                        ref.watch(imageProvider) == null) {
                                      Get.rawSnackbar(
                                          message: AppLocalizations.of(context)!
                                              .selectImageBeforeSubmit3,
                                          duration: Duration(seconds: 2),
                                          backgroundColor:
                                              ColorConstant.red500);
                                    } else {
                                      if (ref.watch(transportTypeProvider) ==
                                          TransporterType.own) {
                                        if (ref.watch(vehicleTypeProvider) ==
                                            VehicleType.Default) {
                                          Get.rawSnackbar(
                                              message:
                                                  AppLocalizations.of(context)!
                                                      .selectYourVehicleType,
                                              duration: Duration(seconds: 10),
                                              backgroundColor:
                                                  ColorConstant.red500);
                                        } else {
                                          if (formKey.currentState!
                                              .validate()) {
                                            String img64 = "";
                                            if (ref.watch(imageProvider) !=
                                                null) {
                                              final bytes = File(ref
                                                          .watch(imageProvider)
                                                          ?.path ??
                                                      "")
                                                  .readAsBytesSync();

                                              img64 = base64Encode(bytes);
                                            }
                                            ref
                                                .watch(inwardStackBookProvider(
                                                        stackId:
                                                            "${ref.watch(stackValue)?.stackRequestId}",
                                                        weight: weightController
                                                            .text
                                                            .toString(),
                                                        vehicleNo:
                                                            vehiclenoContriller
                                                                .text,
                                                        stackrowId:
                                                            "${ref.watch(stackValue)?.stackRequestId}",
                                                        salesStatus:
                                                            ref
                                                                        .watch(commodityProvider
                                                                            .notifier)
                                                                        .state ==
                                                                    CommodityType
                                                                        .Kisani
                                                                ? 1.toString()
                                                                : 2.toString(),
                                                        commodityId:
                                                            "${ref.watch(commodityValue)?.commodityId}",
                                                        terminalId:
                                                            "${ref.watch(terminalValue)?.terminalId}",
                                                        stackNo:
                                                            "${ref.watch(stackValue)?.stackNumber}",
                                                        driverNo:
                                                            drivernoContriller
                                                                .text,
                                                        transporterType: ref.watch(
                                                                    transportTypeProvider) ==
                                                                TransporterType
                                                                    .company
                                                            ? "2"
                                                            : "1",
                                                        tripId:
                                                            "${ref.watch(tripIdProvider)?.id}",
                                                        fileImage: img64)
                                                    .future)
                                                .then((value) {
                                              if (value['status'] == "1") {
                                                ref.invalidate(isMandiTax);
                                                ref.invalidate(terminalValue);
                                                ref.invalidate(stackValue);
                                                ref.invalidate(commodityValue);
                                                ref.invalidate(imageProvider);
                                                ref.invalidate(
                                                    commodityProvider);
                                                ref.invalidate(
                                                    isTaxTypeVisible);
                                                ref
                                                    .watch(selectedTabIndex
                                                        .notifier)
                                                    .state = 1;
                                                Get.to(InwardList());
                                              } else {
                                                Get.rawSnackbar(
                                                  message: value['message'],
                                                  duration:
                                                      Duration(seconds: 2),
                                                  backgroundColor:
                                                      ColorConstant.red500,
                                                );
                                              }
                                            });
                                          }
                                        }
                                        // if (vehiclenoContriller.text.isEmpty) {
                                        //   Get.rawSnackbar(
                                        //       message: AppLocalizations.of(context)!.selectYourVehicle,
                                        //       duration:  Duration(seconds: 2),
                                        //       backgroundColor:
                                        //           ColorConstant.red500);
                                        // }
                                        // else if (ref.watch(vehicleTypeProvider) ==
                                        //     VehicleType.Default) {
                                        //   Get.rawSnackbar(
                                        //       message: AppLocalizations.of(context)!.selectYourVehicleType,
                                        //       duration:  Duration(seconds: 2),
                                        //       backgroundColor: ColorConstant.red500);
                                        // }

                                        // else if (drivernoContriller.text.isEmpty) {
                                        //   Get.rawSnackbar(
                                        //       message: AppLocalizations.of(context)!.selectYourDriver,
                                        //       duration:  Duration(seconds: 2),
                                        //       backgroundColor:
                                        //           ColorConstant.red500);
                                        // }
                                      } else if (ref
                                              .watch(transportTypeProvider) ==
                                          TransporterType.company) {
                                        if (ref.watch(tripIdProvider) == null) {
                                          Get.rawSnackbar(
                                              message:
                                                  AppLocalizations.of(context)!
                                                      .pleaseSelectTripId3,
                                              duration: Duration(seconds: 2),
                                              backgroundColor:
                                                  ColorConstant.red500);
                                        } else {
                                          String img64 = "";
                                          if (ref.watch(imageProvider) !=
                                              null) {
                                            final bytes = File(ref
                                                        .watch(imageProvider)
                                                        ?.path ??
                                                    "")
                                                .readAsBytesSync();

                                            img64 = base64Encode(bytes);
                                          }
                                          ref
                                              .watch(inwardStackBookProvider(
                                                      stackId:
                                                          "${ref.watch(stackValue)?.stackRequestId}",
                                                      weight: weightController.text
                                                          .toString(),
                                                      vehicleNo:
                                                          vehiclenoContriller
                                                              .text,
                                                      stackrowId:
                                                          "${ref.watch(stackValue)?.stackRequestId}",
                                                      salesStatus: ref
                                                                  .watch(commodityProvider
                                                                      .notifier)
                                                                  .state ==
                                                              CommodityType
                                                                  .Kisani
                                                          ? 1.toString()
                                                          : 2.toString(),
                                                      commodityId:
                                                          "${ref.watch(commodityValue)?.commodityId}",
                                                      terminalId:
                                                          "${ref.watch(terminalValue)?.terminalId}",
                                                      stackNo:
                                                          "${ref.watch(stackValue)?.stackNumber}",
                                                      driverNo:
                                                          drivernoContriller
                                                              .text,
                                                      transporterType: ref.watch(
                                                                  transportTypeProvider) ==
                                                              TransporterType
                                                                  .company
                                                          ? "2"
                                                          : "1",
                                                      tripId:
                                                          "${ref.watch(tripIdProvider)?.id}",
                                                      fileImage: img64)
                                                  .future)
                                              .then((value) {
                                            if (value['status'] == "1") {
                                              ref.invalidate(isMandiTax);
                                              ref.invalidate(terminalValue);
                                              ref.invalidate(stackValue);
                                              ref.invalidate(commodityValue);
                                              ref.invalidate(imageProvider);
                                              ref.invalidate(commodityProvider);
                                              ref.invalidate(isTaxTypeVisible);
                                              ref
                                                  .watch(
                                                      selectedTabIndex.notifier)
                                                  .state = 1;
                                              Get.to(InwardList());
                                            } else {
                                              Get.rawSnackbar(
                                                message: value['message'],
                                                duration: Duration(seconds: 2),
                                                backgroundColor:
                                                    ColorConstant.red500,
                                              );
                                            }
                                          });
                                        }
                                      }
                                    }
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
                                      AppLocalizations.of(context)!.msgSubmit,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    error: (e, s) => Container(),
                    loading: () => defaultLoader())
              ],
            ),
          ),
        )));
  }
}

enum AutoInvoiceType {
  yes('Yes', 1),
  no('No', 2);

  const AutoInvoiceType(this.label, this.type);

  final String label;
  final int type;
}

enum TransporterType {
  defaultType('Select TransportType', 'default'),
  own('Own', 'own'),
  company('Company', 'company');

  const TransporterType(this.label, this.type);

  final String label;
  final String type;
}

enum TransporterTypeDispatch {
  own('Own', 1),
  company('Company', 2);

  const TransporterTypeDispatch(this.label, this.type);

  final String label;
  final int type;
}

enum CommodityType {
  Default('Select Tax Type', 'Default'),
  MandiTax('Mandi Tax Paid', 'Mandi Tax'),
  Kisani('Kisani', 'Kisani');

  const CommodityType(this.label, this.type);

  final String label;
  final String type;
}

enum VehicleType {
  Default('Select Vehicle Type', 'default'),
  Registered('Registered Vehicle', 'registered'),
  UnRegistered('Un-Registered Vehicle', 'unregistered');

  const VehicleType(this.label, this.type);

  final String label;
  final String type;
}

enum VehicleTypeDispatch {
  Default('Select Vehicle Type', 'default'),
  Registered('Registered Vehicle', '1'),
  UnRegistered('Un-Registered Vehicle', '2');

  const VehicleTypeDispatch(this.label, this.type);

  final String label;
  final String type;
}
