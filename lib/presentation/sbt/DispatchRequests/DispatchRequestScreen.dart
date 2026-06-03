import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/sbt/service/SbtService.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/model/TripIdModel.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/inwardList.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackinward_screen.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:apnagodam/widgets/dailogs/customAlertDialog.dart';
import 'package:apnagodam/widgets/dailogs/error.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';

import 'package:apnagodam/presentation/warehousefacility_screen/repo_impl/warehouse_facility_repo_impl.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/service/warehouse_facility_service.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';

import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../warehousefacility_screen/model/InwardsTerminalResponse.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Dispatchrequestscreen extends ConsumerStatefulWidget {
  const Dispatchrequestscreen({super.key, required this.sbtOrder});

  final String sbtOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DispatchrequestscreenState();
}

class _DispatchrequestscreenState extends ConsumerState<Dispatchrequestscreen> {
  var terminalValue = StateProvider<TerminalDatum?>((ref) => null);
  var commodityValue = StateProvider<CommodityDatum?>((ref) => null);
  var stackValue = StateProvider<StackNumber?>((ref) => null);
  var isMandiTax = StateProvider((ref) => false);

  var commodityProvider = StateProvider((ref) => CommodityType.Default);
  var tripIdProvider = StateProvider<Datum?>((ref) => null);
  var transportTypeProvider = StateProvider<TransporterTypeDispatch?>(
    (ref) => null,
  );

  var vehicleTypeProvider = StateProvider((ref) => VehicleTypeDispatch.Default);
  var isTaxTypeVisible = StateProvider((ref) => false);
  var commodityTypeList = CommodityType.values;
  var commodityType = CommodityType.Default;
  ImagePicker imagepicker = ImagePicker();
  TextEditingController weightController = TextEditingController();
  TextEditingController drivernoContriller = TextEditingController();
  TextEditingController vehiclenoContriller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var imageProvider = StateProvider<File?>((ref) => null);
  var invoiceCopyImage = StateProvider<File?>((ref) => null);
  var biltyImage = StateProvider<File?>((ref) => null);
  var kantaImage = StateProvider<File?>((ref) => null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.dispatchRequest),
          ),
          body: ref
              .watch(inwardsTerminalProvider())
              .when(
                data:
                    (terminals) => Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),

                            titleWidget(
                              text:
                                  '${AppLocalizations.of(context)!.msgOrderid} - ${widget.sbtOrder}',
                              alignment: MainAxisAlignment.center,
                              fontSize: ElevarmFontSizes.lg,
                            ),
                            SizedBox(height: 20),
                            titleWidget(
                              text: AppLocalizations.of(context)!.mandiTaxType,
                            ),
                            ref
                                .watch(
                                  inwardsCommodityProvider(
                                    terminalId:
                                        ref
                                            .watch(terminalValue)
                                            ?.terminalId
                                            .toString(),
                                  ),
                                )
                                .when(
                                  data:
                                      (data) => Visibility(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            border: Border.all(),
                                          ),
                                          height: 50,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<
                                              CommodityType
                                            >(
                                              isExpanded: true,
                                              value: ref.watch(
                                                commodityProvider,
                                              ),
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                              ),
                                              hint: Center(
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.msgCommodityy,
                                                ),
                                              ),
                                              items: List.generate(
                                                commodityTypeList.length ?? 0,
                                                (index) => DropdownMenuItem(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  value:
                                                      commodityTypeList[index],
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                        ),
                                                    child: Row(
                                                      children: [
                                                        Visibility(
                                                          visible:
                                                              ref.watch(
                                                                commodityProvider,
                                                              ) !=
                                                              CommodityType
                                                                  .Default,
                                                          child: Radio(
                                                            value: ref.watch(
                                                              commodityProvider,
                                                            ),
                                                            groupValue:
                                                                commodityTypeList[index],
                                                            onChanged: (value) {
                                                              commodityType =
                                                                  value!;
                                                            },
                                                            activeColor:
                                                                ColorConstant
                                                                    .maingreen,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            commodityTypeList[index]
                                                                .label,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onChanged: (val) {
                                                ref
                                                    .watch(
                                                      commodityProvider
                                                          .notifier,
                                                    )
                                                    .state = val!;

                                                if (val !=
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
                                  error: (e, s) => Container(),
                                  loading: () => Container(),
                                ),
                            SizedBox(height: 15),
                            if (ref.watch(commodityProvider).type ==
                                CommodityType.MandiTax.type)
                              titleWidget(
                                text:
                                    AppLocalizations.of(context)!.mandiTaxImage,
                              ),
                            Visibility(
                              visible:
                                  ref.watch(commodityProvider).type ==
                                  CommodityType.MandiTax.type,
                              child: ImagePickerWidget(
                                onImageSelection: (selectedImage) {
                                  // Note: The widget now handles setting the provider internally
                                },
                                title: AppLocalizations.of(context)!.mandi,
                                imageProvider: imageProvider,
                              ),
                            ),
                            SizedBox(height: 10),
                            Visibility(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 15.0),
                                child: CommonTextField(
                                  controller: weightController,
                                  hintText:
                                      AppLocalizations.of(
                                        context,
                                      )!.msgWeightwithqtl,
                                  label:
                                      AppLocalizations.of(
                                        context,
                                      )!.msgWeightwithqtl,
                                  textInputAction: TextInputAction.next,
                                  inputType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  enabled: true,
                                  isRequired: true,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            titleWidget(
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )!.msgTransportType,
                            ),
                            Visibility(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  border: Border.all(),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<
                                    TransporterTypeDispatch
                                  >(
                                    isExpanded: true,
                                    value: ref.watch(transportTypeProvider),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    hint: Center(
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.msgTransportType,
                                      ),
                                    ),
                                    items: List.generate(
                                      TransporterTypeDispatch.values.length,
                                      (index) => DropdownMenuItem(
                                        alignment: AlignmentDirectional.center,
                                        value:
                                            TransporterTypeDispatch
                                                .values[index],
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Visibility(
                                                visible:
                                                    ref.watch(
                                                      transportTypeProvider,
                                                    ) !=
                                                    null,
                                                child: Radio(
                                                  value: ref.watch(
                                                    transportTypeProvider,
                                                  ),
                                                  groupValue:
                                                      TransporterTypeDispatch
                                                          .values[index],
                                                  onChanged: (value) {
                                                    ref
                                                        .watch(
                                                          transportTypeProvider
                                                              .notifier,
                                                        )
                                                        .state = value!;
                                                  },
                                                  activeColor:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  TransporterTypeDispatch
                                                      .values[index]
                                                      .label,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      ref
                                          .watch(transportTypeProvider.notifier)
                                          .state = val!;

                                      if (val != CommodityType.MandiTax) {
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
                            SizedBox(height: 10),
                            ref.watch(transportTypeProvider) !=
                                    TransporterTypeDispatch.company
                                ? SizedBox()
                                : ref
                                    .watch(
                                      inwardTripIdListProvider(
                                        terminal:
                                            "${ref.watch(terminalValue)?.terminalId}",
                                        commodity:
                                            "${ref.watch(commodityValue)?.commodityId}",
                                      ),
                                    )
                                    .when(
                                      data:
                                          (data) => Visibility(
                                            visible:
                                                ref.watch(
                                                  transportTypeProvider,
                                                ) ==
                                                TransporterTypeDispatch.company,
                                            child: DropdownSearch<Datum?>(
                                              compareFn:
                                                  (terminal, terminal2) =>
                                                      terminal == terminal2,
                                              popupProps: PopupProps.menu(
                                                searchFieldProps: TextFieldProps(
                                                  autofocus: true,
                                                  cursorColor:
                                                      ColorConstant.maingreen,
                                                  padding: Pad(
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding: Pad(
                                                      left: 10,
                                                      right: 10,
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            style:
                                                                BorderStyle
                                                                    .solid,
                                                            color:
                                                                ColorConstant
                                                                    .maingreen,
                                                          ),
                                                        ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            style:
                                                                BorderStyle
                                                                    .solid,
                                                            color:
                                                                ColorConstant
                                                                    .maingreen,
                                                          ),
                                                        ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            style:
                                                                BorderStyle
                                                                    .solid,
                                                            color:
                                                                ColorConstant
                                                                    .maingreen,
                                                          ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            style:
                                                                BorderStyle
                                                                    .solid,
                                                            color:
                                                                ColorConstant
                                                                    .maingreen,
                                                          ),
                                                        ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        style:
                                                            BorderStyle.solid,
                                                        color:
                                                            ColorConstant
                                                                .maingreen,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            style:
                                                                BorderStyle
                                                                    .solid,
                                                            color:
                                                                ColorConstant
                                                                    .maingreen,
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                                menuProps: MenuProps(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color:
                                                          ColorConstant
                                                              .maingreen,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                ),
                                                itemBuilder:
                                                    (
                                                      context,
                                                      terminal,
                                                      isVisible,
                                                      _,
                                                    ) => ColumnSuper(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      children: [
                                                        Padding(
                                                          padding: Pad(all: 10),
                                                          child: Text(
                                                            "${terminal?.tripRequestId}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    16,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 1,
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                        ),
                                                      ],
                                                    ),
                                                title: Padding(
                                                  padding: Pad(all: 10),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.selectTripId,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: Adaptive.sp(16),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                showSearchBox: true,
                                                searchDelay: Duration(
                                                  microseconds: 500,
                                                ),
                                              ),
                                              filterFn:
                                                  (user, filter) =>
                                                      user?.userFilterByCreationDate(
                                                        filter,
                                                      ) ??
                                                      false,

                                              // asyncItems: (String filter) => getData(filter),
                                              items: (s, d) => data.data ?? [],
                                              itemAsString:
                                                  (Datum? u) =>
                                                      u?.tripRequestId ?? "",
                                              onChanged:
                                                  (Datum? data) =>
                                                      ref
                                                          .watch(
                                                            tripIdProvider
                                                                .notifier,
                                                          )
                                                          .state = data,
                                              decoratorProps:
                                                  DropDownDecoratorProps(
                                                    decoration: InputDecoration(
                                                      contentPadding: Pad(
                                                        left: 10,
                                                        bottom: 5,
                                                        top: 5,
                                                      ),
                                                      hintText:
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.selectTripId,
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(
                                                                8,
                                                              ),
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              ColorConstant
                                                                  .maingreen,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                          ),
                                      error: (e, s) => Container(),
                                      loading:
                                          () => CupertinoActivityIndicator(),
                                    ),
                            SizedBox(height: 10),
                            SizedBox(height: 10),
                            if (ref.watch(transportTypeProvider) ==
                                TransporterTypeDispatch.own)
                              titleWidget(
                                text:
                                    AppLocalizations.of(
                                      context,
                                    )!.msgVehicleType,
                              ),
                            Visibility(
                              visible:
                                  ref.watch(transportTypeProvider) ==
                                  TransporterTypeDispatch.own,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  border: Border.all(),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<VehicleTypeDispatch>(
                                    isExpanded: true,
                                    value: ref.watch(vehicleTypeProvider),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    hint: Center(
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.msgTransportType,
                                      ),
                                    ),
                                    items: List.generate(
                                      VehicleTypeDispatch.values.length,
                                      (index) => DropdownMenuItem(
                                        alignment: AlignmentDirectional.center,
                                        value:
                                            VehicleTypeDispatch.values[index],
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Visibility(
                                                visible:
                                                    ref.watch(
                                                      vehicleTypeProvider,
                                                    ) !=
                                                    VehicleTypeDispatch.Default,
                                                child: Radio(
                                                  value: ref.watch(
                                                    vehicleTypeProvider,
                                                  ),
                                                  groupValue:
                                                      VehicleTypeDispatch
                                                          .values[index],
                                                  onChanged: (value) {
                                                    ref
                                                        .watch(
                                                          vehicleTypeProvider
                                                              .notifier,
                                                        )
                                                        .state = value!;
                                                  },
                                                  activeColor:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  VehicleTypeDispatch
                                                      .values[index]
                                                      .label,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      if (val ==
                                          VehicleTypeDispatch.UnRegistered) {
                                        vehiclenoContriller.text =
                                            val!.label.toString();
                                      } else {
                                        vehiclenoContriller.text = '';
                                      }
                                      ref
                                          .watch(vehicleTypeProvider.notifier)
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
                            SizedBox(height: 10),
                            Visibility(
                              visible:
                                  ref.watch(transportTypeProvider) ==
                                  TransporterTypeDispatch.own,
                              child: ColumnSuper(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15.0),
                                    child: CommonTextField(
                                      controller: vehiclenoContriller,
                                      hintText:
                                          AppLocalizations.of(
                                            context,
                                          )!.vehicleno,
                                      label:
                                          AppLocalizations.of(
                                            context,
                                          )!.vehicleno,
                                      isRequired:
                                          ref.watch(vehicleTypeProvider) ==
                                          VehicleType.Registered,
                                      readOnly:
                                          ref.watch(vehicleTypeProvider) ==
                                          VehicleType.UnRegistered,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15.0),
                                    child: CommonTextField(
                                      maxLength: 10,
                                      controller: drivernoContriller,
                                      hintText:
                                          AppLocalizations.of(
                                            context,
                                          )!.driverno,
                                      label:
                                          AppLocalizations.of(
                                            context,
                                          )!.driverno,
                                      isOnlyDigit: true,
                                      // textInputAction: TextInputAction.next,
                                      // inputType: TextInputType.emailAddress,
                                      enabled: true,
                                      // isOnlyDigit: true,
                                      isRequired: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            titleWidget(
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )!.selectBiltyImage,
                            ),
                            ImagePickerWidget(
                              onImageSelection: (selectedImage) {
                                // Note: The widget now handles setting the provider internally
                              },
                              title:
                                  AppLocalizations.of(
                                    context,
                                  )!.selectBiltyImage,
                              imageProvider: biltyImage,
                            ),
                            titleWidget(
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )!.selectKantaImage,
                            ),
                            ImagePickerWidget(
                              onImageSelection: (selectedImage) {
                                // Note: The widget now handles setting the provider internally
                              },
                              title: AppLocalizations.of(context)!.kantaImage,
                              imageProvider: kantaImage,
                            ),
                            // ElevarmInputFileCard(
                            //   onTap: () {
                            //     showImageSourceDialog(context, (image) {
                            //       ref.watch(invoiceCopyImage.notifier).state =
                            //           File(image.path);
                            //     });
                            //   },
                            //   clickToUploadLabel: 'Invoice Copy',
                            //   orDragAndDropLabel: ', Tap to Upload Invoice Image',
                            //   subtitle: 'PNG, JPG, JPEG (maks. 800x400px)',
                            //   textColor: ColorConstant.maingreen,
                            // ),
                            titleWidget(
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )!.selectInvoiceImage,
                            ),
                            FilePickerWidget(
                              onImageSelection: (selectedImage) {
                                ref
                                    .watch(invoiceCopyImage.notifier)
                                    .state = File(selectedImage.path);
                              },
                              title:
                                  AppLocalizations.of(
                                    context,
                                  )!.selectInvoiceImage,
                            ),
                            SizedBox(
                              width: Get.width,
                              child: simpleButton(
                                text: AppLocalizations.of(context)!.submit,
                                callback: () {
                                  if (weightController.text.isEmpty) {
                                    Get.rawSnackbar(
                                      message:
                                          AppLocalizations.of(
                                            context,
                                          )!.selectYourWeight,
                                      duration: Duration(seconds: 2),
                                      backgroundColor: ColorConstant.red500,
                                    );
                                  } else if (ref.watch(commodityProvider) ==
                                      CommodityType.Default) {
                                    Get.rawSnackbar(
                                      message:
                                          AppLocalizations.of(
                                            context,
                                          )!.selectCommodityTaxType,
                                      duration: Duration(seconds: 2),
                                      backgroundColor: ColorConstant.red500,
                                    );
                                  } else if (ref.watch(commodityProvider) ==
                                          CommodityType.MandiTax &&
                                      ref.watch(imageProvider) == null) {
                                    Get.rawSnackbar(
                                      message:
                                          AppLocalizations.of(
                                            context,
                                          )!.selectImageBeforeSubmit,
                                      duration: Duration(seconds: 2),
                                      backgroundColor: ColorConstant.red500,
                                    );
                                  } else if (ref.watch(biltyImage) == null) {
                                    Get.rawSnackbar(
                                      message:
                                          AppLocalizations.of(
                                            context,
                                          )!.selectBiltyImage,
                                      duration: Duration(seconds: 2),
                                      backgroundColor: ColorConstant.red500,
                                    );
                                  } else if (ref.watch(invoiceCopyImage) ==
                                      null) {
                                    Get.rawSnackbar(
                                      message:
                                          AppLocalizations.of(
                                            context,
                                          )!.selectInvoiceImage,
                                      duration: Duration(seconds: 2),
                                      backgroundColor: ColorConstant.red500,
                                    );
                                  } else if (ref.watch(kantaImage) == null) {
                                    Get.rawSnackbar(
                                      message:
                                          AppLocalizations.of(
                                            context,
                                          )!.selectKantaImage,
                                      duration: Duration(seconds: 2),
                                      backgroundColor: ColorConstant.red500,
                                    );
                                  } else {
                                    if (ref.watch(transportTypeProvider) ==
                                        TransporterTypeDispatch.own) {
                                      if (ref.watch(vehicleTypeProvider) ==
                                          VehicleType.Default) {
                                        Get.rawSnackbar(
                                          message:
                                              AppLocalizations.of(
                                                context,
                                              )!.selectYourVehicleType,
                                          duration: Duration(seconds: 10),
                                          backgroundColor: ColorConstant.red500,
                                        );
                                      } else {
                                        if (formKey.currentState!.validate()) {
                                          String img64 = "";
                                          if (ref.watch(imageProvider) !=
                                              null) {
                                            final bytes =
                                                File(
                                                  ref
                                                          .watch(imageProvider)
                                                          ?.path ??
                                                      "",
                                                ).readAsBytesSync();

                                            img64 = base64Encode(bytes);
                                          }
                                          ref
                                              .watch(
                                                dispatchRequestProvider(
                                                  sbtOrderId: widget.sbtOrder,
                                                  weight:
                                                      weightController.text
                                                          .toString(),
                                                  vehicleNo:
                                                      vehiclenoContriller.text,
                                                  salesStatus:
                                                      ref
                                                                  .watch(
                                                                    commodityProvider
                                                                        .notifier,
                                                                  )
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
                                                      drivernoContriller.text,
                                                  transporterType:
                                                      ref.watch(
                                                                transportTypeProvider,
                                                              ) ==
                                                              TransporterTypeDispatch
                                                                  .company
                                                          ? "2"
                                                          : "1",
                                                  vehicleType:
                                                      ref
                                                          .watch(
                                                            vehicleTypeProvider,
                                                          )
                                                          .type,
                                                  tripId:
                                                      "${ref.watch(tripIdProvider)?.id}",
                                                  kantaParchiImage: ref.watch(
                                                    kantaImage,
                                                  ),
                                                  biltyImage: ref.watch(
                                                    biltyImage,
                                                  ),
                                                  image: ref.watch(
                                                    imageProvider,
                                                  ),
                                                  invoiceImage: ref.watch(
                                                    invoiceCopyImage,
                                                  ),
                                                ).future,
                                              )
                                              .then((value) {
                                                if (value['status'] == "1") {
                                                  ref.invalidate(isMandiTax);
                                                  ref.invalidate(terminalValue);
                                                  ref.invalidate(stackValue);
                                                  ref.invalidate(
                                                    commodityValue,
                                                  );
                                                  ref.invalidate(imageProvider);
                                                  ref.invalidate(
                                                    commodityProvider,
                                                  );
                                                  ref.invalidate(
                                                    isTaxTypeVisible,
                                                  );
                                                  Get.off(DashboardScreen());
                                                } else {
                                                  Get.rawSnackbar(
                                                    message: value['message'],
                                                    duration: Duration(
                                                      seconds: 2,
                                                    ),
                                                    backgroundColor:
                                                        ColorConstant.red500,
                                                  );
                                                }
                                              });
                                        }
                                      }
                                    } else if (ref.watch(
                                          transportTypeProvider,
                                        ) ==
                                        TransporterTypeDispatch.company) {
                                      if (ref.watch(tripIdProvider) == null) {
                                        Get.rawSnackbar(
                                          message:
                                              AppLocalizations.of(
                                                context,
                                              )!.pleaseSelectTripId,
                                          duration: Duration(seconds: 2),
                                          backgroundColor: ColorConstant.red500,
                                        );
                                      } else {
                                        String img64 = "";
                                        if (ref.watch(imageProvider) != null) {
                                          final bytes =
                                              File(
                                                ref
                                                        .watch(imageProvider)
                                                        ?.path ??
                                                    "",
                                              ).readAsBytesSync();

                                          img64 = base64Encode(bytes);
                                        }
                                        ref
                                            .watch(
                                              dispatchRequestProvider(
                                                sbtOrderId: widget.sbtOrder,
                                                weight:
                                                    weightController.text
                                                        .toString(),
                                                vehicleNo:
                                                    vehiclenoContriller.text,
                                                salesStatus:
                                                    ref
                                                                .watch(
                                                                  commodityProvider
                                                                      .notifier,
                                                                )
                                                                .state ==
                                                            CommodityType.Kisani
                                                        ? 1.toString()
                                                        : 2.toString(),
                                                commodityId:
                                                    "${ref.watch(commodityValue)?.commodityId}",
                                                terminalId:
                                                    "${ref.watch(terminalValue)?.terminalId}",
                                                stackNo:
                                                    "${ref.watch(stackValue)?.stackNumber}",
                                                driverNo:
                                                    drivernoContriller.text,
                                                transporterType:
                                                    ref.watch(
                                                              transportTypeProvider,
                                                            ) ==
                                                            TransporterTypeDispatch
                                                                .company
                                                        ? "2"
                                                        : "1",
                                                vehicleType:
                                                    ref
                                                        .watch(
                                                          vehicleTypeProvider,
                                                        )
                                                        .type,
                                                tripId:
                                                    "${ref.watch(tripIdProvider)?.id}",
                                                kantaParchiImage: ref.watch(
                                                  kantaImage,
                                                ),
                                                biltyImage: ref.watch(
                                                  biltyImage,
                                                ),
                                                image: ref.watch(imageProvider),
                                                invoiceImage: ref.watch(
                                                  invoiceCopyImage,
                                                ),
                                              ).future,
                                            )
                                            .then((value) {
                                              if (value['status'] == "1") {
                                                ref.invalidate(isMandiTax);
                                                ref.invalidate(terminalValue);
                                                ref.invalidate(stackValue);
                                                ref.invalidate(commodityValue);
                                                ref.invalidate(imageProvider);
                                                ref.invalidate(
                                                  commodityProvider,
                                                );
                                                ref.invalidate(
                                                  isTaxTypeVisible,
                                                );
                                                Get.off(DashboardScreen());
                                              } else {
                                                Get.rawSnackbar(
                                                  message: value['message'],
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                  backgroundColor:
                                                      ColorConstant.red500,
                                                );
                                              }
                                            });
                                      }
                                    }
                                  }
                                },
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
      ),
    );
  }
}
