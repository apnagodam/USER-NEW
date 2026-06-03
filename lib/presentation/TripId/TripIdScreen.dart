import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/progress_dialog_utils.dart';
import 'package:apnagodam/presentation/TripId/TripRequests/TripRequestScreen.dart';
import 'package:apnagodam/presentation/TripId/model/PoModel.dart' as poDatum;
import 'package:apnagodam/presentation/TripId/model/TripIdTransporterModel.dart';
import 'package:apnagodam/presentation/TripId/service/TripIdService.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackinward_screen.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import '../../widgets/CommonTextField.dart';
import '../home_screen/models/warehouse_response_model.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Tripidscreen extends ConsumerStatefulWidget {
  const Tripidscreen(
      {super.key,
      required this.terminalFrom,
      required this.terminalTo,
      required this.title});

  final TerminalTypeFrom terminalFrom;
  final TerminalTypeTo terminalTo;
  final String title;

  @override
  ConsumerState<Tripidscreen> createState() => _TripidscreenState();
}

class _TripidscreenState extends ConsumerState<Tripidscreen> {
  var fromProvider =
      StateProvider<TerminalTypeFrom?>((ref) => TerminalTypeFrom.defaultType);
  var toProvider =
      StateProvider<TerminalTypeTo?>((ref) => TerminalTypeTo.defaultType);

  var fromAddressController = TextEditingController();
  var toAddressController = TextEditingController();

  var fromPincodeController = TextEditingController();
  var toPinCodeController = TextEditingController();
  var consigneeController = TextEditingController();

  var fromTerminalProvider = StateProvider<Terminal?>((ref) => null);
  var toTerminalProvider = StateProvider<Terminal?>((ref) => null);

  var commodityProvider = StateProvider<Commodite?>((ref) => null);
  var consigneeNumberController = TextEditingController();
  var landmarkController = TextEditingController();

  var autoInvoicingProvider =
      StateProvider<InvoicingType?>((ref) => InvoicingType.defaultType);

  var paymentTypeProvider =
      StateProvider<PaymentType?>((ref) => PaymentType.defaultType);

  var transporterProvider = StateProvider<Datum?>((ref) => null);
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var poProvider = StateProvider<poDatum.Datum?>((ref) => null);

  var ratePerQtlController = TextEditingController();

  var advanceAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.watch(fromProvider.notifier).state = widget.terminalFrom;
    //         ref.watch(toProvider.notifier).state = widget.terminalTo;

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.tr),
        actions: [
          // InkWell(
          //   child: Text(
          //     'Trip Requests ',
          //     style: TextStyle(fontSize: Adaptive.sp(16), color: Colors.white),
          //   ),
          //   onTap: () {
          //     Get.to(Triprequestscreen());
          //   },
          // )
        ],
      ),
      body: Padding(
          padding: Pad(all: 10),
          child: ref.watch(warehouseDataProvider).when(
              data: (data) => Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: ColumnSuper(children: [
                      fromLayout(ref, context, data),
                      SizedBox(
                        height: 10,
                      ),
                      toLayout(ref, context, data),
                      SizedBox(
                        height: 10,
                      ),
                      homeLayout(ref, context, data)
                    ]),
                  )),
              error: (e, s) => Container(),
              loading: () => Center(
                    child: defaultLoader(),
                  ))),
    );
  }

  fromLayout(WidgetRef ref, BuildContext context, WarehouseReponseModel data) =>
      ColumnSuper(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
              child: Text(
                AppLocalizations.of(context)!
                    .selectpickupTerminalOrLocation,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen),
              ),
              onPressed: () {}),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<TerminalTypeFrom>(
                isExpanded: true,
                value: ref.watch(fromProvider),
                icon: Icon(Icons.keyboard_arrow_down),
                hint: Center(child: Text(AppLocalizations.of(context)!.selectSource2)),
                items: List.generate(
                    TransporterType.values.length,
                    (index) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: TerminalTypeFrom.values[index],
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Visibility(
                                    visible: ref.watch(fromProvider) !=
                                        TerminalTypeFrom.defaultType,
                                    child: Radio(
                                      value: ref.watch(fromProvider),
                                      groupValue:
                                          TerminalTypeFrom.values[index],
                                      onChanged: (value) {
                                        ref.watch(fromProvider.notifier).state =
                                            value!;
                                      },
                                      activeColor: ColorConstant.maingreen,
                                    )),
                                Expanded(
                                    child: Text(
                                        TerminalTypeFrom.values[index].label))
                              ],
                            ),
                          ),
                        )),
                onChanged: (val) {
                  ref.watch(fromProvider.notifier).state = val!;
                }
                // cont.newcommodityvalue!.commodityTax
                //             .toString() ==
                //         "0"
                //     ? ref.watch(isMandiTax.notifier).state =
                //         false
                //     : ref.watch(isMandiTax.notifier).state =
                //         true;

                ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ref.watch(fromProvider) == TerminalTypeFrom.terminal
            ? fromTerminal(ref, context, data)
            : ref.watch(fromProvider) == TerminalTypeFrom.location
                ? fromnAddress(ref, context)
                : SizedBox()
      ]);

  fromTerminal(WidgetRef ref, BuildContext context,
          WarehouseReponseModel warehouseData) =>
      ColumnSuper(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
              child: Text(
                AppLocalizations.of(context)!.terminal,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen),
              ),
              onPressed: () {}),
        ),
        DropdownSearch<Terminal?>(
          compareFn: (Terminal? i, Terminal? s) => i?.id == s?.id,
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
                            color: ColorConstant.maingreen)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                  )),
              menuProps: MenuProps(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorConstant.maingreen),
                      borderRadius: BorderRadius.circular(8))),
              itemBuilder: (context, terminal, isVisible, _) =>
                  ColumnSuper(alignment: Alignment.centerLeft, children: [
                    Padding(
                      padding: Pad(all: 10),
                      child: Text(
                        "${terminal?.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Adaptive.sp(16)),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ]),
              title: Padding(
                padding: Pad(all: 10),
                child: Text(
                  AppLocalizations.of(context)!.terminal,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Adaptive.sp(16), fontWeight: FontWeight.w700),
                ),
              ),
              showSearchBox: true,
              searchDelay: Duration(microseconds: 500)),
          filterFn: (user, filter) =>
              user?.userFilterByCreationDate(filter) ?? false,
          // asyncItems: (String filter) => getData(filter),

          items: (i, d) => warehouseData.terminals ?? [],
          itemAsString: (Terminal? u) => u?.name ?? "",
          onChanged: (Terminal? data) =>
              ref.watch(fromTerminalProvider.notifier).state = data,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
                contentPadding: Pad(left: 10, bottom: 5, top: 5),
                hintText: AppLocalizations.of(context)!.terminal,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: ColorConstant.maingreen))),
          ),
        ),
      ]);

  fromnAddress(WidgetRef ref, BuildContext context) => ColumnSuper(children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: CommonTextField(
            controller: fromAddressController,
            label: AppLocalizations.of(context)!.address,
            // textInputAction: TextInputAction.next,
            // inputType: TextInputType.emailAddress,
            enabled: true,
            // isOnlyDigit: true,
            isRequired: ref.watch(fromProvider) == TerminalTypeFrom.location,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: CommonTextField(
            controller: fromPincodeController,
            label: AppLocalizations.of(context)!.pincode2,
            maxLength: 6,
            // textInputAction: TextInputAction.next,
            inputType: TextInputType.number,
            enabled: true,
            // isOnlyDigit: true,
            isRequired: ref.watch(fromProvider) == TerminalTypeFrom.location,
          ),
        ),
      ]);

  toLayout(WidgetRef ref, BuildContext context,
          WarehouseReponseModel warehouseData) =>
      ColumnSuper(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
              child: Text(
                AppLocalizations.of(context)!
                    .selectDestinationTerminalOrLocation,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen),
              ),
              onPressed: () {}),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<TerminalTypeTo>(
                isExpanded: true,
                value: ref.watch(toProvider),
                icon: Icon(Icons.keyboard_arrow_down),
                hint: Center(child: Text(AppLocalizations.of(context)!.selectTo2)),
                items: List.generate(
                    TransporterType.values.length,
                    (index) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: TerminalTypeTo.values[index],
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Visibility(
                                    visible: ref.watch(toProvider) !=
                                        TerminalTypeTo.defaultType,
                                    child: Radio(
                                      value: ref.watch(toProvider),
                                      groupValue: TerminalTypeTo.values[index],
                                      onChanged: (value) {
                                        ref.watch(toProvider.notifier).state =
                                            value!;
                                      },
                                      activeColor: ColorConstant.maingreen,
                                    )),
                                Expanded(
                                    child: Text(
                                        TerminalTypeTo.values[index].label))
                              ],
                            ),
                          ),
                        )),
                onChanged: (val) {
                  ref.watch(toProvider.notifier).state = val!;
                }
                // cont.newcommodityvalue!.commodityTax
                //             .toString() ==
                //         "0"
                //     ? ref.watch(isMandiTax.notifier).state =
                //         false
                //     : ref.watch(isMandiTax.notifier).state =
                //         true;

                ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ref.watch(toProvider) == TerminalTypeTo.terminal
            ? toTerminal(ref, context, warehouseData)
            : ref.watch(toProvider) == TerminalTypeTo.location
                ? toAddress(ref, context)
                : SizedBox()
      ]);

  toTerminal(WidgetRef ref, BuildContext context,
          WarehouseReponseModel warehouseData) =>
      ColumnSuper(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
              child: Text(
                AppLocalizations.of(context)!.terminal,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen),
              ),
              onPressed: () {}),
        ),
        DropdownSearch<Terminal?>(
          compareFn: (item1, item2) => item1?.id == item2?.id,
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
                            color: ColorConstant.maingreen)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                  )),
              menuProps: MenuProps(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorConstant.maingreen),
                      borderRadius: BorderRadius.circular(8))),
              itemBuilder: (context, terminal, isVisible, _) =>
                  ColumnSuper(alignment: Alignment.centerLeft, children: [
                    Padding(
                      padding: Pad(all: 10),
                      child: Text(
                        "${terminal?.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Adaptive.sp(16)),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ]),
              title: Padding(
                padding: Pad(all: 10),
                child: Text(
                  AppLocalizations.of(context)!.terminal,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Adaptive.sp(16), fontWeight: FontWeight.w700),
                ),
              ),
              showSearchBox: true,
              searchDelay: Duration(microseconds: 500)),
          filterFn: (user, filter) =>
              user?.userFilterByCreationDate(filter) ?? false,
          // asyncItems: (String filter) => getData(filter),

          items: (i, d) => warehouseData.terminals ?? [],
          itemAsString: (Terminal? u) => u?.name ?? "",
          onChanged: (Terminal? data) =>
              ref.watch(toTerminalProvider.notifier).state = data,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
                contentPadding: Pad(left: 10, bottom: 5, top: 5),
                hintText: AppLocalizations.of(context)!.terminal,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: ColorConstant.maingreen))),
          ),
        ),
      ]);

  toAddress(WidgetRef ref, BuildContext context) => ColumnSuper(children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: CommonTextField(
            controller: toAddressController,
            label: AppLocalizations.of(context)!.address,
            // textInputAction: TextInputAction.next,
            // inputType: TextInputType.emailAddress,
            enabled: true,
            // isOnlyDigit: true,
            isRequired: ref.watch(toProvider) == TerminalTypeTo.location,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: CommonTextField(
            controller: toPinCodeController,
            label: AppLocalizations.of(context)!.pincode2,
            maxLength: 6,
            // textInputAction: TextInputAction.next,
            inputType: TextInputType.number,
            enabled: true,
            // isOnlyDigit: true,
            isRequired: ref.watch(toProvider) == TerminalTypeTo.location,
          ),
        ),
      ]);

  homeLayout(WidgetRef ref, BuildContext context,
          WarehouseReponseModel warehouseData) =>
      ColumnSuper(children: [
        DropdownSearch<Commodite?>(
          compareFn: (Commodite? i, Commodite? s) => i?.id == s?.id,
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
                            color: ColorConstant.maingreen)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorConstant.maingreen)),
                  )),
              menuProps: MenuProps(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorConstant.maingreen),
                      borderRadius: BorderRadius.circular(8))),
              itemBuilder: (context, terminal, isVisible, _) =>
                  ColumnSuper(alignment: Alignment.centerLeft, children: [
                    Padding(
                      padding: Pad(all: 10),
                      child: Text(
                        "${terminal?.category}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Adaptive.sp(16)),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ]),
              title: Padding(
                padding: Pad(all: 10),
                child: Text(
                  AppLocalizations.of(context)!.selectCommodity,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Adaptive.sp(16), fontWeight: FontWeight.w700),
                ),
              ),
              showSearchBox: true,
              searchDelay: Duration(microseconds: 500)),
          filterFn: (user, filter) =>
              user?.userFilterByCreationDate(filter) ?? false,
          // asyncItems: (String filter) => getData(filter),

          items: (i, d) => warehouseData.commodites ?? [],
          itemAsString: (Commodite? u) => u?.category ?? "",
          onChanged: (Commodite? data) =>
              ref.watch(commodityProvider.notifier).state = data,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
                contentPadding: Pad(left: 10, bottom: 5, top: 5),
                hintText: AppLocalizations.of(context)!.selectCommodity,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: ColorConstant.maingreen))),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: CommonTextField(
            controller: consigneeController,
            label: AppLocalizations.of(context)!.consigneeName2,
            // textInputAction: TextInputAction.next,
            inputType: TextInputType.text,
            enabled: true,
            // isOnlyDigit: true,
            isRequired: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: CommonTextField(
            controller: consigneeNumberController,
            label: AppLocalizations.of(context)!.consigneePhone2,
            // textInputAction: TextInputAction.next,
            inputType: TextInputType.phone,
            enabled: true,
            maxLength: 10,
            // isOnlyDigit: true,
            isRequired: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: CommonTextField(
            controller: landmarkController,
            label: AppLocalizations.of(context)!.landmark2,
            // textInputAction: TextInputAction.next,
            inputType: TextInputType.text,
            enabled: true,
            // isOnlyDigit: true,
            isRequired: true,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
              child: Text(
                AppLocalizations.of(context)!.selectAutoInvoicing,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen),
              ),
              onPressed: () {}),
        ),

        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<InvoicingType?>(
                isExpanded: true,
                value: ref.watch(autoInvoicingProvider),
                icon: Icon(Icons.keyboard_arrow_down),
                hint: Center(child: Text(AppLocalizations.of(context)!.autoInvoicing2)),
                items: List.generate(
                    TransporterType.values.length,
                    (index) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: InvoicingType.values[index],
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Visibility(
                                    visible: ref.watch(autoInvoicingProvider) !=
                                        InvoicingType.defaultType,
                                    child: Radio(
                                      value: ref.watch(autoInvoicingProvider),
                                      groupValue: InvoicingType.values[index],
                                      onChanged: (value) {
                                        ref
                                            .watch(
                                                autoInvoicingProvider.notifier)
                                            .state = value!;
                                      },
                                      activeColor: ColorConstant.maingreen,
                                    )),
                                Expanded(
                                    child:
                                        Text(InvoicingType.values[index].label))
                              ],
                            ),
                          ),
                        )),
                onChanged: (val) {
                  ref.watch(autoInvoicingProvider.notifier).state = val!;
                }
                // cont.newcommodityvalue!.commodityTax
                //             .toString() ==
                //         "0"
                //     ? ref.watch(isMandiTax.notifier).state =
                //         false
                //     : ref.watch(isMandiTax.notifier).state =
                //         true;

                ),
          ),
        ),
        //transporter
        SizedBox(
          height: 10,
        ),
        ref.watch(autoInvoicingProvider) == InvoicingType.yes
            ? ref
                .watch(poListProvider(
                    terminaId:
                        "${ref.watch(fromProvider) == TerminalTypeFrom.terminal ? ref.watch(fromTerminalProvider)?.id : ref.watch(toTerminalProvider)?.id}",
                    commodityId: "${ref.watch(commodityProvider)?.id}"))
                .when(
                    data: (poData) => DropdownSearch<poDatum.Datum?>(
                          compareFn: (poDatum.Datum? i, poDatum.Datum? s) =>
                              i?.id == s?.id,
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
                                            color: ColorConstant.maingreen)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstant.maingreen)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstant.maingreen)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstant.maingreen)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstant.maingreen)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: ColorConstant.maingreen)),
                                  )),
                              menuProps: MenuProps(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: ColorConstant.maingreen),
                                      borderRadius: BorderRadius.circular(8))),
                              itemBuilder: (context, terminal, isVisible, _) =>
                                  ColumnSuper(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Padding(
                                          padding: Pad(all: 10),
                                          child: Text(
                                            "${terminal?.poIds}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: Adaptive.sp(16)),
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      ]),
                              title: Padding(
                                padding: Pad(all: 10),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .selectPurchaseOrder,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              showSearchBox: true,
                              searchDelay: Duration(microseconds: 500)),
                          filterFn: (user, filter) =>
                              user?.userFilterByCreationDate(filter) ?? false,
                          // asyncItems: (String filter) => getData(filter),

                          items: (d, s) => poData.data ?? [],
                          itemAsString: (poDatum.Datum? u) => u?.poIds ?? "",
                          onChanged: (poDatum.Datum? data) =>
                              ref.watch(poProvider.notifier).state = data,
                          decoratorProps: DropDownDecoratorProps(
                            decoration: InputDecoration(
                                contentPadding:
                                    Pad(left: 10, bottom: 5, top: 5),
                                hintText: AppLocalizations.of(context)!
                                    .selectPurchaseOrder,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: ColorConstant.maingreen))),
                          ),
                        ),
                    error: (e, s) => Container(),
                    loading: () => Center(
                          child: CupertinoActivityIndicator(),
                        ))
            : SizedBox(),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
              child: Text(
                AppLocalizations.of(context)!.selectTransporter,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen),
              ),
              onPressed: () {}),
        ),
        ref.watch(tripTransporterListProvider).when(
            data: (transporterData) => DropdownSearch<Datum?>(
                  compareFn: (Datum? i, Datum? s) => i?.id == s?.id,
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
                                    color: ColorConstant.maingreen)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstant.maingreen)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstant.maingreen)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstant.maingreen)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstant.maingreen)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: ColorConstant.maingreen)),
                          )),
                      menuProps: MenuProps(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(8))),
                      itemBuilder: (context, terminal, isVisible, _) =>
                          ColumnSuper(
                              alignment: Alignment.centerLeft,
                              children: [
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text(
                                    "${terminal?.name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: Adaptive.sp(16)),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              ]),
                      title: Padding(
                        padding: Pad(all: 10),
                        child: Text(
                          AppLocalizations.of(context)!.selectTransporter,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      showSearchBox: true,
                      searchDelay: Duration(microseconds: 500)),
                  filterFn: (user, filter) =>
                      user?.userFilterByCreationDate(filter) ?? false,
                  // asyncItems: (String filter) => getData(filter),

                  items: (i, s) => transporterData.data ?? [],
                  itemAsString: (Datum? u) => u?.name ?? "",
                  onChanged: (Datum? data) =>
                      ref.watch(transporterProvider.notifier).state = data,
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                        contentPadding: Pad(left: 10, bottom: 5, top: 5),
                        hintText:
                            AppLocalizations.of(context)!.selectTransporter,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: ColorConstant.maingreen))),
                  ),
                ),
            error: (e, s) => Container(),
            loading: () => Center(
                  child: CupertinoActivityIndicator(),
                )),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: CommonTextField(
            controller: ratePerQtlController,
            label: AppLocalizations.of(context)!.ratePerQtl4,
            // textInputAction: TextInputAction.next,
            inputType: TextInputType.number,
            enabled: true,
            // isOnlyDigit: true,
            isRequired: true,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: CommonTextField(
            controller: advanceAmountController,
            label: AppLocalizations.of(context)!.advanceAmtInr2,
            // textInputAction: TextInputAction.next,
            inputType: TextInputType.number,
            enabled: true,
            // isOnlyDigit: true,
            isRequired: true,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
              child: Text(
                AppLocalizations.of(context)!.paymentTo,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen),
              ),
              onPressed: () {}),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all()),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<PaymentType?>(
                isExpanded: true,
                value: ref.watch(paymentTypeProvider),
                icon: Icon(Icons.keyboard_arrow_down),
                hint: Center(child: Text(AppLocalizations.of(context)!.autoInvoicing2)),
                items: List.generate(
                    TransporterType.values.length,
                    (index) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: PaymentType.values[index],
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Visibility(
                                    visible: ref.watch(paymentTypeProvider) !=
                                        PaymentType.defaultType,
                                    child: Radio(
                                      value: ref.watch(paymentTypeProvider),
                                      groupValue: PaymentType.values[index],
                                      onChanged: (value) {
                                        ref
                                            .watch(paymentTypeProvider.notifier)
                                            .state = value!;
                                      },
                                      activeColor: ColorConstant.maingreen,
                                    )),
                                Expanded(
                                    child:
                                        Text(PaymentType.values[index].label))
                              ],
                            ),
                          ),
                        )),
                onChanged: (val) {
                  ref.watch(paymentTypeProvider.notifier).state = val!;
                }
                // cont.newcommodityvalue!.commodityTax
                //             .toString() ==
                //         "0"
                //     ? ref.watch(isMandiTax.notifier).state =
                //         false
                //     : ref.watch(isMandiTax.notifier).state =
                //         true;

                ),
          ),
        ),
        SizedBox(
          height: 10,
        ),

        InkWell(
          onTap: () async {
            if (_formkey.currentState!.validate()) {
              if (ref.watch(fromProvider) == null) {
                Get.rawSnackbar(
                    message: AppLocalizations.of(context)!.pleaseSelectFromLocation2,
                    duration: Duration(seconds: 2),
                    backgroundColor: ColorConstant.red500);
              } else if (ref.watch(toProvider) == null) {
                Get.rawSnackbar(
                    message: AppLocalizations.of(context)!.pleaseSelectToLocation2,
                    duration: Duration(seconds: 2),
                    backgroundColor: ColorConstant.red500);
              } else if (ref.watch(commodityProvider) == null) {
                Get.rawSnackbar(
                    message:
                        AppLocalizations.of(context)!.pleaseSelectCommodity,
                    duration: Duration(seconds: 2),
                    backgroundColor: ColorConstant.red500);
              } else if (ref.watch(autoInvoicingProvider) == null) {
                Get.rawSnackbar(
                    message:
                        AppLocalizations.of(context)!.pleaseSelectAutoInvoicing,
                    duration: Duration(seconds: 2),
                    backgroundColor: ColorConstant.red500);
              } else if (ref.watch(transporterProvider) == null) {
                Get.rawSnackbar(
                    message: AppLocalizations.of(context)!.pleaseSelectTransporter2,
                    duration: Duration(seconds: 2),
                    backgroundColor: ColorConstant.red500);
              } else if (ref.watch(paymentTypeProvider) == null) {
                Get.rawSnackbar(
                    message: AppLocalizations.of(context)!.pleaseSelectPaymentType2,
                    duration: Duration(seconds: 2),
                    backgroundColor: ColorConstant.red500);
              } else {
                // 'transport_id': transporterId,
                // // required
                // 'rate': rate,
                // // required
                // 'advance_amt': advanceAmount,
                // // required
                // 'payment_to': paymentTo,
                // // 1 for driver 2 transporter
                // 'consignee_name': consigneeName,
                // //
                // 'consignee_number': consigneeNumber,
                // //
                // 'landmark': landmark,
                tripIdUpdate(ref, context);
                // if (ref.watch(fromProvider) == TerminalTypeFrom.terminal &&
                //     ref.watch(toProvider) == TerminalTypeTo.location) {
                //   if (ref.watch(fromTerminalProvider) == null) {
                //     Get.rawSnackbar(
                //         message: "Please select from terminal",
                //         duration:  Duration(seconds: 2),
                //         backgroundColor: ColorConstant.red500);
                //   } else {
                //
                //   }
                // }
                //
                // if (ref.watch(fromProvider) == TerminalTypeFrom.location &&
                //     ref.watch(toProvider) == TerminalTypeTo.terminal) {
                //   if (ref.watch(toProvider) == null) {
                //     Get.rawSnackbar(
                //         message: "Please select to terminal",
                //         duration:  Duration(seconds: 2),
                //         backgroundColor: ColorConstant.red500);
                //   } else {
                //     tripIdUpdate(ref, context);
                //   }
                // }
              }
            }
          },
          child: Container(
            height: 46,
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorConstant.maingreen,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Center(
                child: Text(
              AppLocalizations.of(context)!.createTripId2,
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ]);

  tripIdUpdate(WidgetRef ref, BuildContext context) {
    return ref
        .watch(createTripidProvider(
                source: ref.watch(fromProvider) == TerminalTypeFrom.location
                    ? "1"
                    : "2",
                fromAddress:
                    ref.watch(fromProvider) == TerminalTypeFrom.location
                        ? fromAddressController.text.toString()
                        : null,
                fromPinCode:
                    ref.watch(fromProvider) == TerminalTypeFrom.location
                        ? fromPincodeController.text.toString()
                        : null,
                fromTerminalId:
                    ref.watch(fromProvider) == TerminalTypeFrom.location
                        ? null
                        : "${ref.watch(fromTerminalProvider)?.id}",
                to: ref.watch(toProvider) == TerminalTypeTo.location
                    ? "1"
                    : "2",
                toAddress: ref.watch(toProvider) == TerminalTypeTo.location
                    ? toAddressController.text.toString()
                    : null,
                toPincode: ref.watch(toProvider) == TerminalTypeTo.location
                    ? toPinCodeController.text.toString()
                    : null,
                toTerminalId: ref.watch(toProvider) == TerminalTypeTo.location
                    ? null
                    : "${ref.watch(toTerminalProvider)?.id}",
                poId: ref.watch(autoInvoicingProvider) == InvoicingType.yes
                    ? "${ref.watch(poProvider)?.id}"
                    : null,
                commodityId: "${ref.watch(commodityProvider)?.id}",
                transporterId: "${ref.watch(transporterProvider)?.id}",
                rate: ratePerQtlController.text.toString(),
                advanceAmount: advanceAmountController.text.toString(),
                paymentTo: ref.watch(paymentTypeProvider) == PaymentType.driver
                    ? '1'
                    : '2',
                consigneeName: consigneeController.text.toString(),
                consigneeNumber: consigneeNumberController.text.toString(),
                landmark: landmarkController.text.toString())
            .future)
        .then((value) {
      if (value['status'].toString() == "1") {
        Get.rawSnackbar(
            message: "${value['message']}",
            duration: Duration(seconds: 2),
            backgroundColor: ColorConstant.maingreen);

        Get.offAll(DashboardScreen());
      } else {
        Get.rawSnackbar(
            message: "${value['message']}",
            duration: Duration(seconds: 2),
            backgroundColor: ColorConstant.red500);
      }
    }).onError((e, s) {});
  }
}

enum TerminalTypeFrom {
  defaultType('Select Source', 'default'),
  terminal('From Terminal', 'terminal'),
  location('From Location', 'location');

  const TerminalTypeFrom(this.label, this.type);

  final String label;
  final String type;
}

enum TerminalTypeTo {
  defaultType('Select Destination', 'default'),
  terminal('To Terminal', 'terminal'),
  location('To Location', 'location');

  const TerminalTypeTo(this.label, this.type);

  final String label;
  final String type;
}

enum InvoicingType {
  defaultType('Auto Invoicing*', 'default'),
  yes('Yes', 'yes'),
  no('No', 'no');

  const InvoicingType(this.label, this.type);

  final String label;
  final String type;
}

enum PaymentType {
  defaultType('Select Payment To', 'default'),
  driver('Driver', 'terminal'),
  transporter('Transporter', 'location');

  const PaymentType(this.label, this.type);

  final String label;
  final String type;
}
