import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/sbt/DispatchRequests/FactoryDispatchListingScreen.dart';
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

class FactoryDispatchRequestsScreen extends ConsumerStatefulWidget {
  const FactoryDispatchRequestsScreen({super.key, required this.sbtOrder});

  final String sbtOrder;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FactoryDispatchRequestsScreenState();
}

class _FactoryDispatchRequestsScreenState
    extends ConsumerState<FactoryDispatchRequestsScreen> {
  var terminalValue = StateProvider<TerminalDatum?>((ref) => null);
  var commodityValue = StateProvider<CommodityDatum?>((ref) => null);
  var stackValue = StateProvider<StackNumber?>((ref) => null);
  var isMandiTax = StateProvider((ref) => false);

  var commodityProvider = StateProvider((ref) => CommodityType.Default);
  var deliveryCommodityProvider = StateProvider((ref) => CommodityType.Default);

  var tripIdProvider = StateProvider<Datum?>((ref) => null);
  var transportTypeProvider = StateProvider<TransporterTypeDispatch?>(
    (ref) => null,
  );

  var vehicleTypeProvider = StateProvider((ref) => VehicleTypeDispatch.Default);
  var isTaxTypeVisible = StateProvider((ref) => false);
  var commodityTypeList = CommodityType.values;
  var commodityType = CommodityType.Default;
  ImagePicker imagepicker = ImagePicker();
  // TextEditingController weightController = TextEditingController();
  TextEditingController drivernoContriller = TextEditingController();
  TextEditingController biltyController = TextEditingController();
  TextEditingController vehiclenoContriller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var imageProvider = StateProvider<File?>((ref) => null);
  var deliveryImageprovider = StateProvider<File?>((ref) => null);
  var invoiceCopyImage = StateProvider<File?>((ref) => null);
  var biltyImage = StateProvider<File?>((ref) => null);
  var kantaImage = StateProvider<File?>((ref) => null);
  TextEditingController locationController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  Map<String, dynamic> addressData = {};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.dispatchRequest),
            actions: [
              TextButton(
                onPressed: () {
                  Get.to(
                    Factorydispatchlistingscreen(sbtOrderId: widget.sbtOrder),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.dispatchRequests,
                  style: TextStyle(
                    color: ColorConstant.whiteA700,
                    fontSize: ElevarmFontSizes.md,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
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
                                  '${AppLocalizations.of(context)!.msgOrderId}: ${widget.sbtOrder}',
                              alignment: MainAxisAlignment.center,
                              fontSize: ElevarmFontSizes.lg,
                            ),
                            SizedBox(height: 20),
                            titleWidget(
                              text: AppLocalizations.of(context)!.address,
                              alignment: MainAxisAlignment.center,
                              fontSize: ElevarmFontSizes.lg,
                            ),
                            addressLayout(),
                            SizedBox(height: 15),
                            titleWidget(
                              text:
                                  AppLocalizations.of(
                                    context,
                                  )!.msgMandiCompliance,
                              alignment: MainAxisAlignment.center,
                              fontSize: ElevarmFontSizes.lg,
                            ),
                            dispatchLocation(),
                            SizedBox(height: 15),
                            deliveryLocation(),
                            SizedBox(height: 10),
                            transportLayout(),
                            SizedBox(height: 15),
                            SizedBox(
                              width: Get.width,
                              child: simpleButton(
                                text: AppLocalizations.of(context)!.submit,
                                callback: () {
                                  if (ref.watch(commodityProvider) ==
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
                                                dispatchRequestNewProvider(
                                                  states: stateController.text,
                                                  district:
                                                      districtController.text,
                                                  location:
                                                      locationController.text,
                                                  pinCode:
                                                      pincodeController.text,
                                                  address:
                                                      addressData['data']['address']
                                                          .toString(),
                                                  biltyNumber:
                                                      biltyController.text,
                                                  sbtOrderId: widget.sbtOrder,
                                                  mandiComplience:
                                                      ref.watch(
                                                                deliveryCommodityProvider,
                                                              ) !=
                                                              CommodityType
                                                                  .Default
                                                          ? "1"
                                                          : "2",
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
                                                  image: ref.watch(
                                                    imageProvider,
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
                                                  Get.off(
                                                    Factorydispatchlistingscreen(
                                                      sbtOrderId:
                                                          widget.sbtOrder,
                                                    ),
                                                  );
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
                                              dispatchRequestNewProvider(
                                                states: stateController.text,
                                                district:
                                                    districtController.text,
                                                location:
                                                    locationController.text,
                                                pinCode: pincodeController.text,
                                                address:
                                                    addressData['data']['address']
                                                        .toString(),
                                                biltyNumber:
                                                    biltyController.text,
                                                sbtOrderId: widget.sbtOrder,
                                                mandiComplience:
                                                    ref.watch(
                                                              commodityProvider,
                                                            ) ==
                                                            CommodityType
                                                                .MandiTax
                                                        ? "1"
                                                        : "0",
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
                                                image: ref.watch(imageProvider),
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

  Widget addressLayout() => Column(
    children: [
      CommonTextField(
        controller: pincodeController,
        hintText: AppLocalizations.of(context)!.msgEnterpincode,
        label: AppLocalizations.of(context)!.msgPinCode,
        textInputAction: TextInputAction.next,
        enabled: true,
        isRequired: true,
        onEditComplete: (value) {
          if (value.length == 6) {
            ref.watch(getAddressProvider(pinCode: value).future).then((value) {
              addressData = value;
              stateController.text = value['data']['state_name'];
              districtController.text = value['data']['district_name'];
              locationController.text = "${value['data']['address']}";
              setState(() {});
            });
          }
        },
      ),
      CommonTextField(
        controller: locationController,
        hintText: AppLocalizations.of(context)!.msgLocation,
        label: AppLocalizations.of(context)!.msgLocation,
        textInputAction: TextInputAction.next,
        enabled: true,
        isRequired: true,
      ),
      CommonTextField(
        controller: stateController,
        hintText: AppLocalizations.of(context)!.msgState,
        label: AppLocalizations.of(context)!.msgState,
        textInputAction: TextInputAction.next,
        enabled: true,
        isRequired: true,
      ),
      CommonTextField(
        controller: districtController,
        hintText: AppLocalizations.of(context)!.msgDistrict,
        label: AppLocalizations.of(context)!.msgDistrict,
        textInputAction: TextInputAction.next,
        enabled: true,
        isRequired: true,
      ),
    ],
  );
  Widget dispatchLocation() => Column(
    children: [
      titleWidget(text: AppLocalizations.of(context)!.dispatchLocation),
      ref
          .watch(
            inwardsCommodityProvider(
              terminalId: ref.watch(terminalValue)?.terminalId.toString(),
            ),
          )
          .when(
            data:
                (data) => Visibility(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(),
                    ),
                    height: 50,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<CommodityType>(
                        isExpanded: true,
                        value: ref.watch(commodityProvider),
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Center(
                          child: Text(
                            AppLocalizations.of(context)!.msgCommodityy,
                          ),
                        ),
                        items: List.generate(
                          commodityTypeList.length ?? 0,
                          (index) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: commodityTypeList[index],
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Visibility(
                                    visible:
                                        ref.watch(commodityProvider) !=
                                        CommodityType.Default,
                                    child: Radio(
                                      value: ref.watch(commodityProvider),
                                      groupValue: commodityTypeList[index],
                                      onChanged: (value) {
                                        commodityType = value!;
                                      },
                                      activeColor: ColorConstant.maingreen,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(commodityTypeList[index].label),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          ref.watch(commodityProvider.notifier).state = val!;
                        },
                      ),
                    ),
                  ),
                ),
            error: (e, s) => Container(),
            loading: () => Container(),
          ),
      SizedBox(height: 15),
      if (ref.watch(commodityProvider).type == CommodityType.MandiTax.type)
        titleWidget(text: AppLocalizations.of(context)!.mandiTaxImage),
      Visibility(
        visible:
            ref.watch(commodityProvider).type == CommodityType.MandiTax.type,
        child: Consumer(
          builder: (context, ref, _) {
            return ImagePickerWidget(
              onImageSelection: (selectedImage) {
                // Note: The widget now handles setting the provider internally
              },
              title: AppLocalizations.of(context)!.mandi,
              imageProvider: imageProvider,
            );
          },
        ),
      ),
      SizedBox(height: 10),
    ],
  );

  Widget deliveryLocation() => Column(
    children: [
      titleWidget(text: AppLocalizations.of(context)!.deliveryLocation),
      ref
          .watch(
            inwardsCommodityProvider(
              terminalId: ref.watch(terminalValue)?.terminalId.toString(),
            ),
          )
          .when(
            data:
                (data) => Visibility(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(),
                    ),
                    height: 50,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<CommodityType>(
                        isExpanded: true,
                        value: ref.watch(deliveryCommodityProvider),
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Center(
                          child: Text(
                            AppLocalizations.of(context)!.msgCommodityy,
                          ),
                        ),
                        items: List.generate(
                          commodityTypeList.length ?? 0,
                          (index) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: commodityTypeList[index],
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Visibility(
                                    visible:
                                        ref.watch(deliveryCommodityProvider) !=
                                        CommodityType.Default,
                                    child: Radio(
                                      value: ref.watch(
                                        deliveryCommodityProvider,
                                      ),
                                      groupValue: commodityTypeList[index],
                                      onChanged: (value) {
                                        commodityType = value!;
                                      },
                                      activeColor: ColorConstant.maingreen,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(commodityTypeList[index].label),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          ref.watch(deliveryCommodityProvider.notifier).state =
                              val!;
                        },
                      ),
                    ),
                  ),
                ),
            error: (e, s) => Container(),
            loading: () => Container(),
          ),
      SizedBox(height: 15),
      if (ref.watch(deliveryCommodityProvider).type ==
          CommodityType.MandiTax.type)
        titleWidget(text: AppLocalizations.of(context)!.mandiTaxImage),
      Visibility(
        visible:
            ref.watch(deliveryCommodityProvider).type ==
            CommodityType.MandiTax.type,
        child: ImagePickerWidget(
          onImageSelection: (selectedImage) {
            // Note: The widget now handles setting the provider internally
          },
          title: AppLocalizations.of(context)!.mandi,
          imageProvider: deliveryImageprovider,
        ),
      ),
      SizedBox(height: 10),
    ],
  );

  Widget transportLayout() => Column(
    children: [
      titleWidget(text: AppLocalizations.of(context)!.msgTransportType),
      Visibility(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<TransporterTypeDispatch>(
              isExpanded: true,
              value: ref.watch(transportTypeProvider),
              icon: Icon(Icons.keyboard_arrow_down),
              hint: Center(
                child: Text(AppLocalizations.of(context)!.msgTransportType),
              ),
              items: List.generate(
                TransporterTypeDispatch.values.length,
                (index) => DropdownMenuItem(
                  alignment: AlignmentDirectional.center,
                  value: TransporterTypeDispatch.values[index],
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Visibility(
                          visible: ref.watch(transportTypeProvider) != null,
                          child: Radio(
                            value: ref.watch(transportTypeProvider),
                            groupValue: TransporterTypeDispatch.values[index],
                            onChanged: (value) {
                              ref.watch(transportTypeProvider.notifier).state =
                                  value!;
                            },
                            activeColor: ColorConstant.maingreen,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            TransporterTypeDispatch.values[index].label,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onChanged: (val) {
                ref.watch(transportTypeProvider.notifier).state = val!;
              },
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
      ref.watch(transportTypeProvider) != TransporterTypeDispatch.company
          ? SizedBox()
          : ref
              .watch(
                inwardTripIdListProvider(
                  terminal: "${ref.watch(terminalValue)?.terminalId}",
                  commodity: "${ref.watch(commodityValue)?.commodityId}",
                ),
              )
              .when(
                data:
                    (data) => Visibility(
                      visible:
                          ref.watch(transportTypeProvider) ==
                          TransporterTypeDispatch.company,
                      child: DropdownSearch<Datum?>(
                        compareFn:
                            (terminal, terminal2) => terminal == terminal2,
                        popupProps: PopupProps.menu(
                          searchFieldProps: TextFieldProps(
                            autofocus: true,
                            cursorColor: ColorConstant.maingreen,
                            padding: Pad(left: 10, right: 10),
                            decoration: InputDecoration(
                              contentPadding: Pad(left: 10, right: 10),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          itemBuilder:
                              (context, terminal, isVisible, _) => ColumnSuper(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Padding(
                                    padding: Pad(all: 10),
                                    child: Text(
                                      "${terminal?.tripRequestId}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: Adaptive.sp(16),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ],
                              ),
                          title: Padding(
                            padding: Pad(all: 10),
                            child: Text(
                              AppLocalizations.of(context)!.selectTripId,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          showSearchBox: true,
                          searchDelay: Duration(microseconds: 500),
                        ),
                        filterFn:
                            (user, filter) =>
                                user?.userFilterByCreationDate(filter) ?? false,

                        // asyncItems: (String filter) => getData(filter),
                        items: (s, d) => data.data ?? [],
                        itemAsString: (Datum? u) => u?.tripRequestId ?? "",
                        onChanged:
                            (Datum? data) =>
                                ref.watch(tripIdProvider.notifier).state = data,
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            contentPadding: Pad(left: 10, bottom: 5, top: 5),
                            hintText:
                                AppLocalizations.of(context)!.selectTripId,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                error: (e, s) => Container(),
                loading: () => CupertinoActivityIndicator(),
              ),
      SizedBox(height: 10),
      if (ref.watch(transportTypeProvider) == TransporterTypeDispatch.own)
        titleWidget(text: AppLocalizations.of(context)!.msgVehicleType),
      Visibility(
        visible:
            ref.watch(transportTypeProvider) == TransporterTypeDispatch.own,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<VehicleTypeDispatch>(
              isExpanded: true,
              value: ref.watch(vehicleTypeProvider),
              icon: Icon(Icons.keyboard_arrow_down),
              hint: Center(
                child: Text(AppLocalizations.of(context)!.msgTransportType),
              ),
              items: List.generate(
                VehicleTypeDispatch.values.length,
                (index) => DropdownMenuItem(
                  alignment: AlignmentDirectional.center,
                  value: VehicleTypeDispatch.values[index],
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Visibility(
                          visible:
                              ref.watch(vehicleTypeProvider) !=
                              VehicleTypeDispatch.Default,
                          child: Radio(
                            value: ref.watch(vehicleTypeProvider),
                            groupValue: VehicleTypeDispatch.values[index],
                            onChanged: (value) {
                              ref.watch(vehicleTypeProvider.notifier).state =
                                  value!;
                            },
                            activeColor: ColorConstant.maingreen,
                          ),
                        ),
                        Expanded(
                          child: Text(VehicleTypeDispatch.values[index].label),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onChanged: (val) {
                if (val == VehicleTypeDispatch.UnRegistered) {
                  vehiclenoContriller.text = val!.label.toString();
                } else {
                  vehiclenoContriller.text = '';
                }
                ref.watch(vehicleTypeProvider.notifier).state = val!;

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
            ref.watch(transportTypeProvider) == TransporterTypeDispatch.own,
        child: ColumnSuper(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: CommonTextField(
                controller: vehiclenoContriller,
                hintText: AppLocalizations.of(context)!.vehicleno,
                label: AppLocalizations.of(context)!.vehicleno,
                isRequired:
                    ref.watch(vehicleTypeProvider) == VehicleType.Registered,
                readOnly:
                    ref.watch(vehicleTypeProvider) == VehicleType.UnRegistered,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: CommonTextField(
                maxLength: 10,
                controller: drivernoContriller,
                hintText: AppLocalizations.of(context)!.driverno,
                label: AppLocalizations.of(context)!.driverno,
                isOnlyDigit: true,
                // textInputAction: TextInputAction.next,
                // inputType: TextInputType.emailAddress,
                enabled: true,
                // isOnlyDigit: true,
                isRequired: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: CommonTextField(
                controller: biltyController,
                hintText: AppLocalizations.of(context)!.msgBiltyNumber,
                label: AppLocalizations.of(context)!.msgBiltyNumber,
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
    ],
  );
}
