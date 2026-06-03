import 'dart:io';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/PurchaseOrder/model/BrokerBuyerModel.dart';
import 'package:apnagodam/presentation/PurchaseOrder/service/PurchaseOrderService.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/home_screen/models/warehouse_response_model.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Purchaseorderscreen extends ConsumerStatefulWidget {
  const Purchaseorderscreen({super.key});

  @override
  ConsumerState<Purchaseorderscreen> createState() =>
      _PurchaseorderscreenState();
}

class _PurchaseorderscreenState extends ConsumerState<Purchaseorderscreen> {
  final poKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final rateController = TextEditingController();
  final poNumberController = TextEditingController();
  final brokerNameController = TextEditingController();
  final buyerNameController = TextEditingController();
  final buyerPhoneController = TextEditingController();
  final buyerGstController = TextEditingController();
  final buyerAddressController = TextEditingController();
  final buyerPincodeController = TextEditingController();
  final qualityController = TextEditingController();
  var expiryDateProvider = StateProvider<DateTime?>((ref) => null);
  var issueDateProvider = StateProvider<DateTime?>((ref) => null);
  var terminalDropDownProvider = StateProvider<Terminal?>((ref) => null);
  var commodityDropDownProvider = StateProvider<Commodite?>((ref) => null);
  var brokerProvider = StateProvider<BrokerBuyerDatum?>((ref) => null);
  var buyerProvider = StateProvider<BrokerBuyerDatum?>((ref) => null);
  var imageProvider = StateProvider<File?>((ref) => null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.purchaseOrder2),
        ),
        body: Form(
            key: poKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: Pad(all: 10),
                child: Column(
                  children: [
                    ref.watch(warehouseDataProvider).when(
                        data: (warehouseData) => Column(
                              children: [
                                DropdownSearch<Terminal?>(
                                  compareFn: (a, b) => a?.id == b?.id,
                                  popupProps: PopupProps.menu(
                                      searchFieldProps: TextFieldProps(
                                          autofocus: true,
                                          cursorColor: ColorConstant.maingreen,
                                          padding: Pad(left: 10, right: 10),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                Pad(left: 10, right: 10),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        style:
                                                            BorderStyle.solid,
                                                        color: ColorConstant
                                                            .maingreen)),
                                            disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid,
                                                    color: ColorConstant
                                                        .maingreen)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid,
                                                    color: ColorConstant
                                                        .maingreen)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid,
                                                    color: ColorConstant
                                                        .maingreen)),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid,
                                                    color: ColorConstant
                                                        .maingreen)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid,
                                                    color: ColorConstant
                                                        .maingreen)),
                                          )),
                                      menuProps: MenuProps(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color:
                                                      ColorConstant.maingreen),
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      itemBuilder: (context, terminal,
                                              isVisible, _) =>
                                          ColumnSuper(
                                              alignment: Alignment.centerLeft,
                                              children: [
                                                Padding(
                                                  padding: Pad(all: 10),
                                                  child: Text(
                                                    "${terminal?.name}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize:
                                                            Adaptive.sp(16)),
                                                  ),
                                                ),
                                                Container(
                                                  height: 1,
                                                  color: Colors.grey
                                                      .withValues(alpha: 0.3),
                                                ),
                                              ]),
                                      title: Padding(
                                        padding: Pad(all: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .terminal,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      showSearchBox: true,
                                      searchDelay: Duration(microseconds: 500)),
                                  filterFn: (user, filter) =>
                                      user?.userFilterByCreationDate(filter) ??
                                      false,
                                  // asyncItems: (String filter) => getData(filter),

                                  items: (s, d) =>
                                      warehouseData.terminals ?? [],
                                  itemAsString: (Terminal? u) => u?.name ?? "",
                                  onChanged: (Terminal? data) => ref
                                      .watch(terminalDropDownProvider.notifier)
                                      .state = data,
                                  decoratorProps: DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                        contentPadding:
                                            Pad(left: 10, bottom: 5, top: 5),
                                        hintText: AppLocalizations.of(context)!
                                            .terminal,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color:
                                                    ColorConstant.maingreen))),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible:
                                      ref.watch(terminalDropDownProvider) !=
                                          null,
                                  child: DropdownSearch<Commodite?>(
                                    compareFn: (a, b) => a?.id == b?.id,
                                    popupProps: PopupProps.menu(
                                        searchFieldProps: TextFieldProps(
                                            autofocus: true,
                                            cursorColor:
                                                ColorConstant.maingreen,
                                            padding: Pad(left: 10, right: 10),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  Pad(left: 10, right: 10),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          style:
                                                              BorderStyle.solid,
                                                          color: ColorConstant
                                                              .maingreen)),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          style:
                                                              BorderStyle.solid,
                                                          color: ColorConstant
                                                              .maingreen)),
                                              errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen)),
                                            )),
                                        menuProps: MenuProps(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: ColorConstant
                                                        .maingreen),
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        itemBuilder: (context, terminal,
                                                isVisible, _) =>
                                            ColumnSuper(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  Padding(
                                                    padding: Pad(all: 10),
                                                    child: Text(
                                                      "${terminal?.category}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              Adaptive.sp(16)),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    color: Colors.grey
                                                        .withValues(alpha: 0.3),
                                                  ),
                                                ]),
                                        title: Padding(
                                          padding: Pad(all: 10),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .selectCommodity,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        showSearchBox: true,
                                        searchDelay:
                                            Duration(microseconds: 500)),
                                    filterFn: (user, filter) =>
                                        user?.userFilterByCreationDate(
                                            filter) ??
                                        false,
                                    // asyncItems: (String filter) => getData(filter),

                                    items: (s, d) =>
                                        warehouseData.commodites ?? [],
                                    itemAsString: (Commodite? u) =>
                                        u?.category ?? "",
                                    onChanged: (Commodite? data) => ref
                                        .watch(
                                            commodityDropDownProvider.notifier)
                                        .state = data,
                                    decoratorProps: DropDownDecoratorProps(
                                      decoration: InputDecoration(
                                          contentPadding:
                                              Pad(left: 10, bottom: 5, top: 5),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .selectCommodity,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              borderSide: BorderSide(
                                                  color: ColorConstant
                                                      .maingreen))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                        error: (e, s) => Container(),
                        loading: () => defaultLoader()),
                    CommonTextField(
                      controller: weightController,
                      label: AppLocalizations.of(context)!.msgWeightt,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.numberWithOptions(decimal: true),
                      enabled: true,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonTextField(
                      controller: rateController,
                      label: AppLocalizations.of(context)!.ratePerQtl3,
                      textInputAction: TextInputAction.next,
                      inputType:
                          TextInputType.numberWithOptions(decimal: false),
                      enabled: true,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonTextField(
                      controller: poNumberController,
                      label: AppLocalizations.of(context)!.poNumber2,
                      textInputAction: TextInputAction.next,
                      enabled: true,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ref.watch(getBrokerNamesProvider).when(
                        data: (data) => DropdownSearch<BrokerBuyerDatum>(
                              compareFn: (a, b) => a.userId == b.userId,
                              popupProps: PopupProps.menu(
                                  searchFieldProps: TextFieldProps(
                                      autofocus: true,
                                      cursorColor: ColorConstant.maingreen,
                                      padding: Pad(left: 10, right: 10),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            Pad(left: 10, right: 10),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                      )),
                                  menuProps: MenuProps(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: ColorConstant.maingreen),
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  itemBuilder: (context, terminal, isVisible,
                                          _) =>
                                      ColumnSuper(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Padding(
                                              padding: Pad(all: 10),
                                              child: Text(
                                                "${terminal.name}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: Adaptive.sp(16)),
                                              ),
                                            ),
                                            Container(
                                              height: 1,
                                              color:
                                                  Colors.grey.withValues(alpha: 0.3),
                                            ),
                                          ]),
                                  title: Padding(
                                    padding: Pad(all: 10),
                                    child: Text(
                                      AppLocalizations.of(context)!.selectBroker2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  showSearchBox: true,
                                  searchDelay: Duration(microseconds: 500)),
                              filterFn: (user, filter) => user.name
                                  .toString()
                                  .toLowerCase()
                                  .trim()
                                  .contains(filter),
                              // asyncItems: (String filter) => getData(filter),

                              items: (s, d) => data.data ?? [],
                              itemAsString: (BrokerBuyerDatum? u) =>
                                  u?.name ?? "",
                              onChanged: (BrokerBuyerDatum? data) => ref
                                  .watch(brokerProvider.notifier)
                                  .state = data,
                              validator: (value) {
                                if (value == null) {
                                  return AppLocalizations.of(context)!.pleaseSelectBroker2;
                                }
                                return null;
                              },
                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                    contentPadding:
                                        Pad(left: 10, bottom: 5, top: 5),
                                    hintText: AppLocalizations.of(context)!.selectBroker2,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: ColorConstant.maingreen))),
                              ),
                            ),
                        error: (e, s) => Container(),
                        loading: () => defaultLoader()),
                    SizedBox(
                      height: 10,
                    ),
                    ref.watch(getBrokerNamesProvider).when(
                        data: (data) => DropdownSearch<BrokerBuyerDatum>(
                              compareFn: (a, b) => a.userId == b.userId,
                              popupProps: PopupProps.menu(
                                  searchFieldProps: TextFieldProps(
                                      autofocus: true,
                                      cursorColor: ColorConstant.maingreen,
                                      padding: Pad(left: 10, right: 10),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            Pad(left: 10, right: 10),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color:
                                                    ColorConstant.maingreen)),
                                      )),
                                  menuProps: MenuProps(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: ColorConstant.maingreen),
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  itemBuilder: (context, terminal, isVisible,
                                          _) =>
                                      ColumnSuper(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Padding(
                                              padding: Pad(all: 10),
                                              child: Text(
                                                "${terminal.name}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: Adaptive.sp(16)),
                                              ),
                                            ),
                                            Container(
                                              height: 1,
                                              color:
                                                  Colors.grey.withValues(alpha: 0.3),
                                            ),
                                          ]),
                                  title: Padding(
                                    padding: Pad(all: 10),
                                    child: Text(
                                      AppLocalizations.of(context)!.selectBuyer2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  showSearchBox: true,
                                  searchDelay: Duration(microseconds: 500)),
                              filterFn: (user, filter) => user.name
                                  .toString()
                                  .toLowerCase()
                                  .trim()
                                  .contains(filter),
                              // asyncItems: (String filter) => getData(filter),
                              items: (s, d) => data.data ?? [],
                              itemAsString: (BrokerBuyerDatum? u) =>
                                  u?.name ?? "",
                              onChanged: (BrokerBuyerDatum? data) => ref
                                  .watch(buyerProvider.notifier)
                                  .state = data,
                              validator: (value) {
                                if (value == null) {
                                  return AppLocalizations.of(context)!.pleaseSelectBuyer2;
                                }
                                return null;
                              },
                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                    contentPadding:
                                        Pad(left: 10, bottom: 5, top: 5),
                                    hintText: AppLocalizations.of(context)!.selectBuyer2,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: ColorConstant.maingreen))),
                              ),
                            ),
                        error: (e, s) => Container(),
                        loading: () => defaultLoader()),
                    SizedBox(
                      height: 10,
                    ),
                    CommonTextField(
                      controller: buyerPhoneController,
                      label: AppLocalizations.of(context)!.buyerPhone3,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.number,
                      maxLength: 10,
                      enabled: true,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonTextField(
                      controller: buyerGstController,
                      label: AppLocalizations.of(context)!.buyerGstNumber2,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      enabled: true,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonTextField(
                      controller: buyerAddressController,
                      label: AppLocalizations.of(context)!.buyerAddress,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.streetAddress,
                      enabled: true,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonTextField(
                      controller: buyerPincodeController,
                      label: AppLocalizations.of(context)!.deliveryPincode,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.number,
                      maxLength: 6,
                      enabled: true,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonTextField(
                      controller: qualityController,
                      label: AppLocalizations.of(context)!.qualityCondition,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.text,
                      enabled: true,
                      isRequired: true,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050),
                            ).then((dateValue) => ref
                                .watch(issueDateProvider.notifier)
                                .state = dateValue);
                          },
                          style: AppStyle.buttonStyle,
                          child: Text(
                            ref.watch(issueDateProvider) == null
                                ? AppLocalizations.of(context)!.selectDateOfPurchaseOrder2
                                : DateFormat('dd-MM-yyyy').format(
                                    ref.watch(issueDateProvider) ??
                                        DateTime.now()),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          ).then((dateValue) => ref
                              .watch(expiryDateProvider.notifier)
                              .state = dateValue);
                        },
                        style: AppStyle.buttonStyle,
                        child: Text(
                          ref.watch(expiryDateProvider) == null
                              ? AppLocalizations.of(context)!.selectExpiryDateOfPurchaseOrder2
                              : DateFormat('dd-MM-yyyy').format(
                                  ref.watch(expiryDateProvider) ??
                                      DateTime.now()),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: InkWell(
                        child: DottedBorder(
                          color: ColorConstant.maingreen,
                          borderType: BorderType.RRect,
                          padding: Pad(all: 10),
                          radius: Radius.circular(5),
                          child: Center(
                            child: ref.watch(imageProvider) == null
                                ? ColumnSuper(
                                    children: [
                                      Icon(
                                        Icons.file_upload_rounded,
                                        color: ColorConstant.maingreen,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .capturePoImage,
                                        style: TextStyle(
                                            color: ColorConstant.maingreen,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                : InkWell(
                                    onTap: () async {
                                      try {
                                        ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery,
                                                maxWidth: 600,
                                                maxHeight: 800,
                                                imageQuality: 10)
                                            .then((value) async {
                                          if (value != null) {
                                            var u8int =
                                                await value.readAsBytes();
                                            ref
                                                .watch(imageProvider.notifier)
                                                .state = File(value.path);
                                          }
                                        });
                                      } catch (e, s) {
                                        debugPrintStack(
                                          stackTrace: s,
                                        );
                                      }
                                      // checkLocationPermission(ref);
                                    },
                                    child: Image.file(
                                      ref.watch(imageProvider) ?? File(""),
                                      fit: BoxFit.contain,
                                      height: 250,
                                    ),
                                  ),
                          ),
                        ),
                        onTap: () async {
                          // showLoaderDialog(context);
                          try {
                            ImagePicker()
                                .pickImage(
                                    source: ImageSource.gallery,
                                    maxWidth: 600,
                                    maxHeight: 800,
                                    imageQuality: 10)
                                .then((value) async {
                              if (value != null) {
                                ref.watch(imageProvider.notifier).state =
                                    File(value.path);
                              }
                            });
                          } catch (e, s) {
                            debugPrintStack(
                              stackTrace: s,
                            );
                          }
                          // hideLoaderDialog(context);
                          // checkLocationPermission(ref);
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (poKey.currentState!.validate()) {
                            if (ref.watch(imageProvider) == null) {
                              Fluttertoast.showToast(
                                  msg: AppLocalizations.of(context)!
                                      .pleaseSelectImage);
                            }
                            ref
                                .watch(updatePurchaseOrderProvider(
                                        terminalId:
                                            "${ref.watch(terminalDropDownProvider)?.id}",
                                        commodityId:
                                            "${ref.watch(commodityDropDownProvider)?.id}",
                                        weight: weightController.text,
                                        rate: rateController.text,
                                        date: "${ref.watch(issueDateProvider)}",
                                        expiryDate:
                                            "${ref.watch(expiryDateProvider)}",
                                        poNumber: poNumberController.text,
                                        gstNumber: buyerGstController.text,
                                        broker:
                                            "${ref.watch(brokerProvider)?.userId}",
                                        buyerName:
                                            "${ref.watch(buyerProvider)?.userId}",
                                        phone: buyerPhoneController.text,
                                        address: buyerAddressController.text,
                                        pincode: buyerPincodeController.text,
                                        qualityCondition:
                                            qualityController.text,
                                        poImage: ref.watch(imageProvider) ??
                                            File(""))
                                    .future)
                                .then((value) {
                              if (value['status'].toString() == "1") {
                                Fluttertoast.showToast(msg: AppLocalizations.of(context)!.success4);
                                Get.offAll(DashboardScreen());
                              }
                            }).onError((e, s) {});
                          } else {
                            Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!
                                    .pleaseFillAllTheFieldsProperly);
                          }
                        },
                        style: AppStyle.buttonStyle,
                        child: Text(
                          AppLocalizations.of(context)!.submit,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
