import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/home_screen/models/warehouse_response_model.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/my_Stock/StacksSettlement/StacksSettlementScreen.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/StacksCommodityListModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/StacksTerminalListModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_screen.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/provider/warehouse_facitlity_provider.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:apnagodam/widgets/StacksCard.dart';
import 'package:apnagodam/widgets/dailogs/error.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/model/available_warehouse_stacks_model.dart'
    as warehouseDatum;
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/helper.dart';

class Stackslisting extends ConsumerStatefulWidget {
  const Stackslisting({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StackslistingState();
}

class _StackslistingState extends ConsumerState<Stackslisting> {
  var dedicatedProvider = StateProvider((ref) => true);

  var selectedValueProvider = StateProvider<String?>((ref) => '');

  var dateProvider = StateProvider((ref) => '');

  var lockInDedicated = StateProvider((ref) => false);

  var lockInMix = StateProvider((ref) => false);

  var terminalDropDownProvider = StateProvider<StacksTerminalDatum?>(
    (ref) => null,
  );
  var commodityDropDownProvider = StateProvider<StacksCommodityDatum?>(
    (ref) => null,
  );
  List<String> get stackList => [
    AppLocalizations.of(context)!.slectstackType,
    "Mix",
    "Dedicated",
  ];
  var avaiableStacksList =
      StateProvider<List<warehouseDatum.AvailableStackDatum>>((ref) => []);
  var terminalNameProvider = StateProvider((ref) => '');
  var terminalIdProvider = StateProvider((ref) => '');
  var terminalFromDateProvider = StateProvider((ref) => '');
  var terminalToDateProvider = StateProvider((ref) => '');
  var warehouseCommodityNameProvider = StateProvider((ref) => '');
  var warehouseCommodityIdProvider = StateProvider((ref) => '');
  TextEditingController weightController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final _priceProvder = StateProvider<String>((ref) => '0');
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: Pad(all: 10),
        child: Column(
          children: [
            titleWidget(text: AppLocalizations.of(context)!.terminal),
            ref
                .watch(stacksTerminalListProvider)
                .when(
                  data:
                      (data) => DropdownSearch<StacksTerminalDatum?>(
                        compareFn: (a, b) => a?.id == b?.id,
                        items: (i, d) => data.data ?? [],
                        itemAsString: (StacksTerminalDatum? u) => u?.name ?? "",
                        onChanged: (StacksTerminalDatum? data) {
                          ref.read(terminalDropDownProvider.notifier).state =
                              data;
                        },
                        filterFn:
                            (user, filter) =>
                                user?.userFilterByCreationDate(filter) ?? false,
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: AppLocalizations.of(context)!.terminal,
                            hintStyle: TextStyle(
                              fontSize: Adaptive.sp(15),
                              color: Colors.grey.shade600,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstant.maingreen,
                                width: 1.3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstant.maingreen,
                                width: 1.8,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            autofocus: true,
                            cursorColor: ColorConstant.maingreen,
                            style: TextStyle(fontSize: Adaptive.sp(14)),
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.searchTerminal2,
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorConstant.maingreen,
                                  width: 1.8,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              AppLocalizations.of(context)!.terminal,
                              style: TextStyle(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          itemBuilder:
                              (context, terminal, isSelected, _) => Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? ColorConstant.maingreen.withOpacity(
                                            0.1,
                                          )
                                          : null,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "${terminal?.name}",
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(15),
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isSelected
                                            ? ColorConstant.maingreen
                                            : Colors.black,
                                  ),
                                ),
                              ),
                        ),
                      ),
                  error: (e, s) => Text("Error loading terminals"),
                  loading: () => _terminalsLoader(),
                ),
            SizedBox(height: 10),
            titleWidget(text: 'Select Commodity'),
            ref
                .watch(
                  stacksCommodityListProvider(
                    terminalId: "${ref.watch(terminalDropDownProvider)?.id}",
                  ),
                )
                .when(
                  data:
                      (data) => DropdownSearch<StacksCommodityDatum?>(
                        compareFn: (a, b) => a?.id == b?.id,
                        items: (d, s) => data.data ?? [],
                        itemAsString:
                            (StacksCommodityDatum? u) => u?.name ?? "",
                        onChanged: (StacksCommodityDatum? data) {
                          ref.read(commodityDropDownProvider.notifier).state =
                              data;
                        },
                        filterFn:
                            (user, filter) =>
                                user?.userFilterByCreationDate(filter) ?? false,
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText:
                                AppLocalizations.of(context)!.selectCommodity,
                            hintStyle: TextStyle(
                              fontSize: Adaptive.sp(15),
                              color: Colors.grey.shade600,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstant.maingreen,
                                width: 1.3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorConstant.maingreen,
                                width: 1.8,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            cursorColor: ColorConstant.maingreen,
                            style: TextStyle(fontSize: Adaptive.sp(14)),
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(
                                    context,
                                  )!.searchCommodity2,
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorConstant.maingreen,
                                  width: 1.8,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              AppLocalizations.of(context)!.selectCommodity,
                              style: TextStyle(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          itemBuilder:
                              (context, terminal, isSelected, i) => Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? ColorConstant.maingreen.withOpacity(
                                            0.1,
                                          )
                                          : null,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "${terminal?.name}",
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(15),
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isSelected
                                            ? ColorConstant.maingreen
                                            : Colors.black,
                                  ),
                                ),
                              ),
                        ),
                      ),
                  error: (e, _) => Text("Error: $e"),
                  loading: () => _terminalsLoader(),
                ),
            SizedBox(height: 10),
            if (ref.watch(commodityDropDownProvider) != null)
              ref
                  .watch(
                    stacksListProvider(
                      commodityId:
                          "${ref.watch(commodityDropDownProvider)?.id}",
                      terminalId: "${ref.watch(terminalDropDownProvider)?.id}",
                    ),
                  )
                  .when(
                    data:
                        (data) =>
                            (data.data ?? []).isEmpty
                                ? noStockData(context)
                                : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 3 / 4,
                                        crossAxisSpacing: 10,
                                      ),
                                  itemCount: data.data?.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (context, index) => InkWell(
                                        child: Column(
                                          children: [
                                            StackCard(stack: data.data![index]),
                                          ],
                                        ),
                                        onTap: () {
                                          priceController.clear();
                                          ref.invalidate(_priceProvder);
                                          showModalBottomSheet(
                                            context: context,
                                            builder:
                                                (
                                                  bottomsheetContext,
                                                ) => Consumer(
                                                  builder:
                                                      (
                                                        context,
                                                        ref,
                                                        _,
                                                      ) => ElevarmDraggableBottomSheet(
                                                        initialChildSize: 1,
                                                        title:
                                                            '${AppLocalizations.of(context)!.wantToSell2} - ${ref.watch(commodityDropDownProvider)?.name}',
                                                        onPressedClose: () {
                                                          priceController.clear();
                                                          ref.invalidate(
                                                            _priceProvder,
                                                          );

                                                          Get.back(
                                                            canPop: false,
                                                          );
                                                        },
                                                        footerWidget: simpleButton(
                                                          text:
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.msgSell,
                                                          callback: () async {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              final enteredPrice = priceController.text.trim();
                                                              final priceVal = double.tryParse(enteredPrice) ?? 0.0;
                                                              if (priceVal <= 0) {
                                                                showErrorAlertDialog(
                                                                  context,
                                                                  'Value can\'t be zero!'.tr,
                                                                );
                                                                return;
                                                              }
                                                              ref.read(_priceProvder.notifier).state = enteredPrice;

                                                              var terms = await ref.read(
                                                                stackSellTermsProvider(
                                                                  stackId:
                                                                      '${data.data![index].stackId}',
                                                                ).future,
                                                              );
                                                              if (!context.mounted) return;
                                                              showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (
                                                                      termsSheetContext,
                                                                    ) => ElevarmDraggableBottomSheet(
                                                                      title:
                                                                          AppLocalizations.of(
                                                                            context,
                                                                          )!.termsConditions2,
                                                                      initialChildSize:
                                                                          1,
                                                                      onPressedClose:
                                                                          () =>
                                                                              Navigator.of(
                                                                                termsSheetContext,
                                                                                rootNavigator:
                                                                                    false,
                                                                              ).pop(),
                                                                      children: [
                                                                        HtmlWidget(
                                                                          terms['data'].toString(),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor:
                                                                                      ColorConstant.red500,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      8,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.of(
                                                                                    termsSheetContext,
                                                                                    rootNavigator:
                                                                                        false,
                                                                                  ).pop();
                                                                                },
                                                                                child: Text(
                                                                                  AppLocalizations.of(
                                                                                    context,
                                                                                  )!.cancel,
                                                                                  style: const TextStyle(
                                                                                    color:
                                                                                        Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width:
                                                                                  10,
                                                                            ),
                                                                            Expanded(
                                                                              child: ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor:
                                                                                      ColorConstant.maingreen,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      8,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                onPressed: () async {
                                                                                  try {
                                                                                    context.showLoader();
                                                                                    final value = await ref.read(
                                                                                      stackWantToSellProvider(
                                                                                        commodityId:
                                                                                            '${ref.read(commodityDropDownProvider)?.id}',
                                                                                        price: ref.read(
                                                                                          _priceProvder,
                                                                                        ),
                                                                                        stackId:
                                                                                            '${data.data![index].stackId}',
                                                                                        terminalId:
                                                                                            '${ref.read(terminalDropDownProvider)?.id}',
                                                                                      ).future,
                                                                                    );
                                                                                    if (!context.mounted) return;
                                                                                    context.hideloader();

                                                                                    if (value['status'].toString() == "1") {
                                                                                      Navigator.of(
                                                                                        termsSheetContext,
                                                                                        rootNavigator:
                                                                                            false,
                                                                                      ).pop();
                                                                                      Get.back();
                                                                                      ref.invalidate(myStockProvider);
                                                                                      ref.invalidate(stackSellListProvider);
                                                                                      context.successToast(
                                                                                        value['message'].toString(),
                                                                                      );
                                                                                      ref
                                                                                          .read(
                                                                                            selectedIndex.notifier,
                                                                                          )
                                                                                          .state = 0;
                                                                                    } else {
                                                                                      showErrorAlertDialog(
                                                                                        termsSheetContext,
                                                                                        value['message']?.toString() ?? 'Something went wrong',
                                                                                      );
                                                                                    }
                                                                                  } catch (e) {
                                                                                    if (context.mounted) {
                                                                                      context.hideloader();
                                                                                      showErrorAlertDialog(
                                                                                        termsSheetContext,
                                                                                        'Error: $e',
                                                                                      );
                                                                                    }
                                                                                  }
                                                                                },
                                                                                child: Text(
                                                                                  AppLocalizations.of(
                                                                                    context,
                                                                                  )!.agreeContinue2,
                                                                                  style: const TextStyle(
                                                                                    color:
                                                                                        Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                isScrollControlled:
                                                                    true,
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        children: [
                                                          ElevarmDivider(),
                                                          Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  'Terminal - ${ref.watch(terminalDropDownProvider)?.name}',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                      16,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          ElevarmDivider(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text.rich(
                                                                TextSpan(
                                                                  text:
                                                                      '${AppLocalizations.of(context)!.stackNo3} - ${data.data![index].stackNumber}',
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                          16,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text.rich(
                                                                TextSpan(
                                                                  text:
                                                                      '${AppLocalizations.of(context)!.commodity2} - ${ref.watch(commodityDropDownProvider)?.name}',
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        Adaptive.sp(
                                                                          16,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          ElevarmDivider(),
                                                          Form(
                                                            key: formKey,
                                                            child: CommonTextField(
                                                              controller: priceController,
                                                              inputType:
                                                                  TextInputType
                                                                      .number,
                                                              hintText:
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.enterPriceToFetchStackData2,
                                                              label:
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.enterPrice2,
                                                              isRequired: true,
                                                              onEditComplete: (
                                                                value,
                                                              ) {
                                                                ref
                                                                    .read(
                                                                      _priceProvder.notifier,
                                                                    )
                                                                    .state = value;
                                                              },
                                                            ),
                                                          ),
                                                          if (ref.watch(
                                                                    _priceProvder,
                                                                  ) !=
                                                                  "0" &&
                                                              ref
                                                                  .watch(
                                                                    _priceProvder,
                                                                  )
                                                                  .isNotEmpty)
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                  .68,
                                                              child: Stackssettlementscreen(
                                                                commodityId:
                                                                    '${ref.watch(commodityDropDownProvider)?.id}',
                                                                price: ref.watch(
                                                                  _priceProvder,
                                                                ),
                                                                stackId:
                                                                    '${data.data![index].stackId}',
                                                                terminalId:
                                                                    '${ref.watch(terminalDropDownProvider)?.id}',
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                ),
                                            isScrollControlled: true,
                                          );
                                        },
                                      ),
                                ),
                    error: (e, s) => Container(),
                    loading: () => Skeletonizer(child: _stacksLoader()),
                  ),
            Visibility(
              visible: !ref.watch(dedicatedProvider),
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: CommonTextField(
                  controller: weightController,
                  label: AppLocalizations.of(context)!.msgWeightwithqtl,
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  isRequired: true,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _stacksLoader() => GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      childAspectRatio: 3 / 4,
      crossAxisSpacing: 10,
    ),
    itemCount: 9,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder:
        (context, index) => DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          dashPattern: [8, 4],
          strokeWidth: 1.2,
          color: ColorConstant.maingreen,
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                shadowColor: Colors.grey.shade300,
                margin: EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorConstant.maingreen,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.stackNo3,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(15),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: Pad(all: 10),
                        child: Column(
                          children: [
                            Text(
                              "",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Adaptive.sp(14),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                              height: 5,
                            ),
                            Text(
                              AppLocalizations.of(context)!.msgQuantity,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(13),
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.msgBags,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorConstant.maingreen,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.msgSell,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(15),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
  );
  _terminalsLoader() => Skeletonizer(
    child: DropdownSearch<StacksTerminalDatum?>(
      compareFn: (a, b) => a?.id == b?.id,
      items: (s, t) => [],
      itemAsString: (StacksTerminalDatum? u) => u?.name ?? "",
      onChanged: (StacksTerminalDatum? data) {
        ref.read(terminalDropDownProvider.notifier).state = data;
      },
      filterFn:
          (user, filter) => user?.userFilterByCreationDate(filter) ?? false,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: AppLocalizations.of(context)!.terminal,
          hintStyle: TextStyle(
            fontSize: Adaptive.sp(15),
            color: Colors.grey.shade600,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.maingreen, width: 1.3),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.maingreen, width: 1.8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          autofocus: true,
          cursorColor: ColorConstant.maingreen,
          style: TextStyle(fontSize: Adaptive.sp(14)),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchTerminal2,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: ColorConstant.maingreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorConstant.maingreen,
                width: 1.8,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            AppLocalizations.of(context)!.terminal,
            style: TextStyle(
              fontSize: Adaptive.sp(17),
              fontWeight: FontWeight.bold,
              color: ColorConstant.maingreen,
            ),
          ),
        ),
        menuProps: MenuProps(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorConstant.maingreen),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        itemBuilder:
            (context, terminal, isSelected, _) => Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? ColorConstant.maingreen.withOpacity(0.1)
                        : null,
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Text(
                "${terminal?.name}",
                style: TextStyle(
                  fontSize: Adaptive.sp(15),
                  fontWeight: FontWeight.w500,
                  color: isSelected ? ColorConstant.maingreen : Colors.black,
                ),
              ),
            ),
      ),
    ),
  );

  @override
  void dispose() {
    weightController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
