import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';

import 'package:apnagodam/presentation/BusinessProfile/BusinessProfileListing.dart';
import 'package:apnagodam/presentation/BusinessProfile/Service/BusinessProfileService.dart';
import 'package:apnagodam/presentation/GstProfile/Service/GstService.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Model/DistrictsResponseModel.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Model/StatesResponseModel.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Service/MandiTaxProfileService.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/home_screen/models/warehouse_response_model.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/widgets/enums.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Businessprofile extends ConsumerStatefulWidget {
  Businessprofile({super.key, this.isAppbarVisible = true});

  final bool isAppbarVisible;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessprofileState();
}

class _BusinessprofileState extends ConsumerState<Businessprofile> {
  var statesProvider = StateProvider<StatesDatum?>((ref) => null);
  var districtProvider = StateProvider<DistrictDatum?>((ref) => null);
  var typeOfBusinessProvider = StateProvider<BusinessProfileType?>(
    (ref) => null,
  );
  var typeOfAmountProvider = StateProvider<InvestorAmount?>((ref) => null);
  var traderTurnoverProvider = StateProvider<TraderTurnover?>((ref) => null);
  var millCapacityProvider = StateProvider<MillCapacity?>((ref) => null);

  var commodityProvider = StateProvider<List<Commodite?>>((ref) => []);

  var typeOfMillProvider = StateProvider<MillTypes?>((ref) => null);
  final formKey = GlobalKey<FormState>();
  var khasraController = TextEditingController();

  var tehsilController = TextEditingController();
  var areaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          widget.isAppbarVisible
              ? AppBar(
                title: Text(AppLocalizations.of(context)!.businessProfile),
                actions: [
                  InkWell(
                    child: Text(
                      AppLocalizations.of(context)!.myBusinessProfile,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(Businessprofilelisting());
                    },
                  ),
                ],
              )
              : null,
      body: Form(
        key: formKey,
        child: ListView(
          padding: Pad(all: 10),
          children: [
            ElevarmDropdownInputField<BusinessProfileType>(
              label: AppLocalizations.of(context)!.typeOfBusiness,
              hintText: AppLocalizations.of(context)!.selectBusinessType,
              onChanged: (value) {
                ref.watch(typeOfBusinessProvider.notifier).state = value;
                ref.invalidate(warehouseDataProvider);
              },
              options: List.generate(
                BusinessProfileType.values.length,
                (index) => ElevarmDropdownInputFieldOption(
                  title: BusinessProfileType.values[index].label,
                  subtitle: '',
                  value: BusinessProfileType.values[index],
                ),
              ),
            ),
            SizedBox(height: 10),
            if (ref.watch(typeOfBusinessProvider) == BusinessProfileType.farmer)
              farmerLayout(),
            if (ref.watch(typeOfBusinessProvider) ==
                BusinessProfileType.investor)
              investorLayout(),
            if (ref.watch(typeOfBusinessProvider) == BusinessProfileType.trader)
              traderLayout(),
            if (ref.watch(typeOfBusinessProvider) ==
                BusinessProfileType.processor)
              processorLayout(),
            SizedBox(height: 10),
            ElevarmPrimaryButton.text(
              text: AppLocalizations.of(context)!.submit,
              onPressed: () {
                String commodityId = '';
                for (var i = 0; i < ref.watch(commodityProvider).length; i++) {
                  if (i == 0) {
                    commodityId = "${ref.watch(commodityProvider)[i]?.id}";
                  } else {
                    commodityId =
                        "$commodityId,${ref.watch(commodityProvider)[i]?.id}";
                  }
                }
                if (formKey.currentState!.validate()) {
                  ref
                      .watch(
                        addBusinessProfileProvider(
                          data: {
                            'type':
                                '${ref.watch(typeOfBusinessProvider)?.type}',
                            'commodity_id': commodityId,
                            'states': "${ref.watch(statesProvider)?.code}",
                            'district': "${ref.watch(districtProvider)?.id}",
                            'tehsil_name': tehsilController.text,
                            'khasra_name': khasraController.text,
                            'land_map': areaController.text,
                            'annual_capicity':
                                "${ref.watch(traderTurnoverProvider)?.type}",
                            'mils_type':
                                "${ref.watch(typeOfMillProvider)?.type ?? ""}",
                            'daily_capacity':
                                "${ref.watch(millCapacityProvider)?.type}",
                            'invester_annual_capicity':
                                "${ref.watch(typeOfAmountProvider)?.type}",
                          },
                        ).future,
                      )
                      .then((value) async {
                        if (value['status'].toString() == "1") {
                          var businessProfiles = await ref.watch(
                            businessProfilesProvider.future,
                          );
                          var manditaxProfiles = await ref.watch(
                            mandiTaxProfilesProvider.future,
                          );
                          var gstProfile = await ref.watch(
                            gstListProvider.future,
                          );

                          ref
                              .watch(sharedUtilityProvider)
                              .setBusinessProfileStatus(
                                businessProfiles.data != null,
                              );
                          ref
                              .watch(sharedUtilityProvider)
                              .setMandiTaxProfileStatus(
                                (manditaxProfiles.data ?? []).isNotEmpty,
                              );
                          ref
                              .watch(sharedUtilityProvider)
                              .setGstProfileStatus(
                                (gstProfile.data ?? []).isNotEmpty,
                              );
                          Get.off(DashboardScreen());
                          Fluttertoast.showToast(
                            msg: value['message'].toString(),
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: ColorConstant.maingreen,
                          );
                        }
                        
                        //  else {
                        //   Fluttertoast.showToast(
                        //     msg: value['message'].toString(),
                        //     toastLength: Toast.LENGTH_LONG,
                        //     backgroundColor: Colors.red,
                        //   );
                        // }
                      })
                      .onError((e, s) {});
                }
              },
              buttonThemeData: ElevarmPrimaryButtonThemeData(
                primaryColor: ColorConstant.maingreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  farmerLayout() => Column(
    children: [
      Row(
        children: [
          Text(
            AppLocalizations.of(context)!.selectState,
            textAlign: TextAlign.left,
            style: ElevarmFontFamilies.inter(
              color: Colors.black,
              fontSize: ElevarmFontSizes.md,
              fontWeight: ElevarmFontWeights.regular,
            ),
          ),
        ],
      ),
      ref
          .watch(statesListProvider)
          .when(
            data: (data) {
              return DropdownSearch<StatesDatum>(
                compareFn: (item1, item2) => item1.code == item2.code,
                popupProps: PopupPropsMultiSelection<StatesDatum>.menu(
                  constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                  searchFieldProps: TextFieldProps(
                    autofocus: false,
                    cursorColor: ColorConstant.maingreen,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstant.maingreen),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstant.maingreen),
                      ),
                    ),
                  ),
                  menuProps: MenuProps(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorConstant.maingreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  containerBuilder:
                      (ctx, popup) => ElevarmNeutralCard(child: popup),
                  itemBuilder:
                      (ctx, item, isSelected, isNotSelectted) => ColumnSuper(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          ),
                          ElevarmDivider(),
                        ],
                      ),
                  checkBoxBuilder:
                      (ctx, item, isSelected, isNotSelected) => ElevarmCheckbox(
                        checked: isSelected,
                        onPressed: () {},
                      ),
                  disableFilter: false,
                  showSearchBox: true,
                  searchDelay: Duration(milliseconds: 300),
                  title: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      AppLocalizations.of(context)!.selectState,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Adaptive.sp(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                items: (something, somthing2) => data.data!,
                itemAsString: (u) => u.name,
                validator:
                    (val) =>
                        (val == null)
                            ? AppLocalizations.of(context)!.pleaseSelectState
                            : null,
                onChanged: (selection) {
                  ref.read(statesProvider.notifier).state = selection;
                },
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    hintText: AppLocalizations.of(context)!.selectState,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorConstant.maingreen),
                    ),
                  ),
                ),
              );
            },
            error: (e, s) => Container(),
            loading:
                () => ElevarmDropdownInputField<String>(
                  label: '',
                  hintText: AppLocalizations.of(context)!.selectState,
                  enabled: false,
                  onChanged: (value) {},
                  options: List.generate(
                    BusinessProfileType.values.length,
                    (index) => ElevarmDropdownInputFieldOption(
                      title: BusinessProfileType.values[index].label,
                      subtitle: '',
                      value: '',
                    ),
                  ),
                ),
          ),
      SizedBox(height: 5),
      Row(
        children: [
          Text(
            AppLocalizations.of(context)!.selectDistrict,
            textAlign: TextAlign.left,
            style: ElevarmFontFamilies.inter(
              color: Colors.black,
              fontSize: ElevarmFontSizes.md,
              fontWeight: ElevarmFontWeights.regular,
            ),
          ),
        ],
      ),
      ref
          .watch(
            districtListProvider(code: "${ref.watch(statesProvider)?.code}"),
          )
          .when(
            data: (data) {
              return DropdownSearch<DistrictDatum?>(
                compareFn:
                    (item1, item2) =>
                        item1?.districtCode == item2?.districtCode,
                popupProps: PopupPropsMultiSelection.menu(
                  constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                  searchFieldProps: TextFieldProps(
                    autofocus: false,
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
                  containerBuilder:
                      (context, popupWidget) =>
                          ElevarmNeutralCard(child: popupWidget),
                  itemBuilder:
                      (context, terminal, isVisible, isNotVisible) =>
                          ColumnSuper(
                            alignment: Alignment.centerLeft,
                            children: [
                              Padding(
                                padding: Pad(all: 10),
                                child: Text(
                                  "${terminal?.name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: Adaptive.sp(16),
                                  ),
                                ),
                              ),
                              ElevarmDivider(),
                            ],
                          ),
                  title: Padding(
                    padding: Pad(all: 10),
                    child: Text(
                      AppLocalizations.of(context)!.selectDistrict,
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
                        user?.districtFilterByName(filter) ?? false,

                // asyncItems: (String filter) => getData(filter),
                items: (d, d2) => data.data!,
                itemAsString: (DistrictDatum? u) => u?.name ?? "",
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!.pleaseSelectDistrict;
                  }
                  return null;
                },
                onChanged:
                    (data) => ref.watch(districtProvider.notifier).state = data,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    contentPadding: Pad(left: 10, bottom: 5, top: 5),
                    hintText: AppLocalizations.of(context)!.selectDistrict,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: ColorConstant.maingreen),
                    ),
                  ),
                ),
              );
            },
            error: (e, s) => Container(),
            loading:
                () => ElevarmDropdownInputField<String>(
                  label: '',
                  hintText: AppLocalizations.of(context)!.selectDistrict,
                  enabled: false,
                  onChanged: (value) {},
                  options: List.generate(
                    BusinessProfileType.values.length,
                    (index) => ElevarmDropdownInputFieldOption(
                      title: BusinessProfileType.values[index].label,
                      subtitle: '',
                      value: '',
                    ),
                  ),
                ),
          ),
      SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.khasraNumber,
        hintText: AppLocalizations.of(context)!.khasraNumber,
        isRequired: false,
        controller: khasraController,
        keyboardType: TextInputType.text,
      ),
      SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.tehsilName,
        hintText: AppLocalizations.of(context)!.tehsilName,
        isRequired: true,
        controller: tehsilController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.pleaseInputValidValue;
          } else {
            return null;
          }
        },
      ),
      SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.areaInAcres,
        hintText: AppLocalizations.of(context)!.landAreaInAcres,
        helperText: AppLocalizations.of(context)!.inputLandAreaInAcres,
        isRequired: true,
        controller: areaController,
        suffixAddOnText: AppLocalizations.of(context)!.inAcres,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.pleaseInputValidValue;
          } else {
            return null;
          }
        },
      ),
      SizedBox(height: 10),
      SizedBox(height: 5),
      ref
          .watch(warehouseDataProvider)
          .when(
            data:
                (data) => DropdownSearch<Commodite?>.multiSelection(
                  compareFn: (item1, item2) => item1?.id == item2?.id,
                  popupProps: PopupPropsMultiSelection.menu(
                    constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                    searchFieldProps: TextFieldProps(
                      autofocus: false,
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
                    containerBuilder:
                        (context, popupWidget) =>
                            ElevarmNeutralCard(child: popupWidget),
                    itemBuilder:
                        (context, terminal, isVisible, isNotVisible) =>
                            ColumnSuper(
                              alignment: Alignment.centerLeft,
                              children: [
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text(
                                    "${terminal?.category}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Adaptive.sp(16),
                                    ),
                                  ),
                                ),
                                ElevarmDivider(),
                              ],
                            ),
                    title: Padding(
                      padding: Pad(all: 10),
                      child: Text(
                        AppLocalizations.of(context)!.selectCommodity,
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
                  items: (item1, item2) => data.commodites!,
                  itemAsString: (Commodite? u) => u?.category ?? "",
                  validator: (value) {
                    if (value == null) {
                      return AppLocalizations.of(
                        context,
                      )!.pleaseSelectCommodity;
                    }
                    return null;
                  },
                  onChanged:
                      (data) =>
                          ref.watch(commodityProvider.notifier).state = data,
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      contentPadding: Pad(left: 10, bottom: 5, top: 5),
                      hintText: AppLocalizations.of(context)!.selectCommodity,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: ColorConstant.maingreen),
                      ),
                    ),
                  ),
                ),
            error: (e, s) => Container(),
            loading:
                () => ElevarmTextInputField(
                  label: '',
                  hintText: 'Loading',
                  helperText: '',
                  isRequired: true,
                  suffixAddOnText: "",
                  keyboardType: TextInputType.number,
                ),
          ),
    ],
  );

  investorLayout() => Column(
    children: [
      Row(
        children: [
          Text(
            AppLocalizations.of(context)!.selectState,
            textAlign: TextAlign.left,
            style: ElevarmFontFamilies.inter(
              color: Colors.black,
              fontSize: ElevarmFontSizes.md,
              fontWeight: ElevarmFontWeights.regular,
            ),
          ),
        ],
      ),
      ref
          .watch(statesListProvider)
          .when(
            data: (data) {
              return DropdownSearch<StatesDatum?>(
                compareFn: (item1, item2) => item1?.code == item2?.code,
                popupProps: PopupPropsMultiSelection.menu(
                  constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                  searchFieldProps: TextFieldProps(
                    autofocus: false,
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
                  containerBuilder:
                      (context, popupWidget) =>
                          ElevarmNeutralCard(child: popupWidget),
                  itemBuilder:
                      (context, terminal, isVisible, _) => ColumnSuper(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: Pad(all: 10),
                            child: Text(
                              "${terminal?.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          ),
                          ElevarmDivider(),
                        ],
                      ),
                  title: Padding(
                    padding: Pad(all: 10),
                    child: Text(
                      AppLocalizations.of(context)!.selectState,
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
                    (user, filter) => user?.stateFilterByName(filter) ?? false,

                // asyncItems: (String filter) => getData(filter),
                items: (c, s) => data.data!,
                itemAsString: (StatesDatum? u) => u?.name ?? "",
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!.pleaseSelectState;
                  }
                  return null;
                },
                onChanged:
                    (data) => ref.watch(statesProvider.notifier).state = data,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    contentPadding: Pad(left: 10, bottom: 5, top: 5),
                    hintText: AppLocalizations.of(context)!.selectState,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: ColorConstant.maingreen),
                    ),
                  ),
                ),
              );
            },
            error: (e, s) => Container(),
            loading:
                () => ElevarmDropdownInputField<String>(
                  label: '',
                  hintText: AppLocalizations.of(context)!.selectState,
                  enabled: false,
                  onChanged: (value) {},
                  options: List.generate(
                    BusinessProfileType.values.length,
                    (index) => ElevarmDropdownInputFieldOption(
                      title: BusinessProfileType.values[index].label,
                      subtitle: '',
                      value: '',
                    ),
                  ),
                ),
          ),
      SizedBox(height: 5),
      Row(
        children: [
          Text(
            AppLocalizations.of(context)!.selectDistrict,
            textAlign: TextAlign.left,
            style: ElevarmFontFamilies.inter(
              color: Colors.black,
              fontSize: ElevarmFontSizes.md,
              fontWeight: ElevarmFontWeights.regular,
            ),
          ),
        ],
      ),
      ref
          .watch(
            districtListProvider(code: "${ref.watch(statesProvider)?.code}"),
          )
          .when(
            data: (data) {
              return DropdownSearch<DistrictDatum?>(
                compareFn:
                    (item1, item2) =>
                        item1?.districtCode == item2?.districtCode,
                popupProps: PopupPropsMultiSelection.menu(
                  constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                  searchFieldProps: TextFieldProps(
                    autofocus: false,
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
                  containerBuilder:
                      (context, popupWidget) =>
                          ElevarmNeutralCard(child: popupWidget),
                  itemBuilder:
                      (context, terminal, isVisible, _) => ColumnSuper(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: Pad(all: 10),
                            child: Text(
                              "${terminal?.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          ),
                          ElevarmDivider(),
                        ],
                      ),
                  title: Padding(
                    padding: Pad(all: 10),
                    child: Text(
                      AppLocalizations.of(context)!.selectDistrict,
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
                        user?.districtFilterByName(filter) ?? false,

                // asyncItems: (String filter) => getData(filter),
                items: (s, d) => data.data!,
                itemAsString: (DistrictDatum? u) => u?.name ?? "",
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!.pleaseSelectDistrict;
                  }
                  return null;
                },
                onChanged:
                    (data) => ref.watch(districtProvider.notifier).state = data,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    contentPadding: Pad(left: 10, bottom: 5, top: 5),
                    hintText: AppLocalizations.of(context)!.selectDistrict,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: ColorConstant.maingreen),
                    ),
                  ),
                ),
              );
            },
            error: (e, s) => Container(),
            loading:
                () => ElevarmDropdownInputField<String>(
                  label: '',
                  hintText: AppLocalizations.of(context)!.selectDistrict,
                  enabled: false,
                  onChanged: (value) {},
                  options: List.generate(
                    BusinessProfileType.values.length,
                    (index) => ElevarmDropdownInputFieldOption(
                      title: BusinessProfileType.values[index].label,
                      subtitle: '',
                      value: '',
                    ),
                  ),
                ),
          ),
      SizedBox(height: 10),
      ElevarmDropdownInputField<InvestorAmount>(
        label: AppLocalizations.of(context)!.selectAmount,
        hintText: AppLocalizations.of(context)!.selectAmount,
        onChanged: (value) {
          ref.watch(typeOfAmountProvider.notifier).state = value;
        },
        options: List.generate(
          InvestorAmount.values.length,
          (index) => ElevarmDropdownInputFieldOption(
            title: InvestorAmount.values[index].label,
            subtitle: '',
            value: InvestorAmount.values[index],
          ),
        ),
      ),
      SizedBox(height: 10),
      SizedBox(
        width: Get.width,
        child: Text(
          AppLocalizations.of(context)!.selectCommodities,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Adaptive.sp(16),
            color: ColorConstant.maingreen,
          ),
        ),
      ),
      ref
          .watch(warehouseDataProvider)
          .when(
            data:
                (data) => DropdownSearch<Commodite?>.multiSelection(
                  compareFn: (item1, item2) => item1?.id == item2?.id,
                  popupProps: PopupPropsMultiSelection.menu(
                    constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                    searchFieldProps: TextFieldProps(
                      autofocus: false,
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
                    containerBuilder:
                        (context, popupWidget) =>
                            ElevarmNeutralCard(child: popupWidget),
                    itemBuilder:
                        (context, terminal, isVisible, _) => ColumnSuper(
                          alignment: Alignment.centerLeft,
                          children: [
                            Padding(
                              padding: Pad(all: 10),
                              child: Text(
                                "${terminal?.category}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ),
                            ElevarmDivider(),
                          ],
                        ),
                    title: Padding(
                      padding: Pad(all: 10),
                      child: Text(
                        AppLocalizations.of(context)!.selectCommodity,
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
                  items: (s, d) => data.commodites!,
                  itemAsString: (Commodite? u) => u?.category ?? "",
                  validator: (value) {
                    if (value == null) {
                      return AppLocalizations.of(
                        context,
                      )!.pleaseSelectCommodity;
                    }
                    return null;
                  },
                  onChanged:
                      (data) =>
                          ref.watch(commodityProvider.notifier).state = data,
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      contentPadding: Pad(left: 10, bottom: 5, top: 5),
                      hintText: AppLocalizations.of(context)!.selectCommodity,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: ColorConstant.maingreen),
                      ),
                    ),
                  ),
                ),
            error: (e, s) => Container(),
            loading:
                () => ElevarmTextInputField(
                  label: '',
                  hintText: 'Loading',
                  helperText: '',
                  isRequired: true,
                  suffixAddOnText: "",
                  keyboardType: TextInputType.number,
                ),
          ),
    ],
  );

  traderLayout() => Column(
    children: [
      Row(
        children: [
          Text(
            AppLocalizations.of(context)!.selectState,
            textAlign: TextAlign.left,
            style: ElevarmFontFamilies.inter(
              color: Colors.black,
              fontSize: ElevarmFontSizes.md,
              fontWeight: ElevarmFontWeights.regular,
            ),
          ),
        ],
      ),
      ref
          .watch(statesListProvider)
          .when(
            data: (data) {
              return DropdownSearch<StatesDatum?>(
                compareFn: (item1, item2) => item1?.code == item2?.code,
                popupProps: PopupPropsMultiSelection.menu(
                  constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                  searchFieldProps: TextFieldProps(
                    autofocus: false,
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
                  containerBuilder:
                      (context, popupWidget) =>
                          ElevarmNeutralCard(child: popupWidget),
                  itemBuilder:
                      (context, terminal, isVisible, _) => ColumnSuper(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: Pad(all: 10),
                            child: Text(
                              "${terminal?.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          ),
                          ElevarmDivider(),
                        ],
                      ),
                  title: Padding(
                    padding: Pad(all: 10),
                    child: Text(
                      AppLocalizations.of(context)!.selectState,
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
                    (user, filter) => user?.stateFilterByName(filter) ?? false,

                // asyncItems: (String filter) => getData(filter),
                items: (s, d) => data.data!,
                itemAsString: (StatesDatum? u) => u?.name ?? "",
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!.pleaseSelectState;
                  }
                  return null;
                },
                onChanged:
                    (data) => ref.watch(statesProvider.notifier).state = data,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    contentPadding: Pad(left: 10, bottom: 5, top: 5),
                    hintText: AppLocalizations.of(context)!.selectState,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: ColorConstant.maingreen),
                    ),
                  ),
                ),
              );
            },
            error: (e, s) => Container(),
            loading:
                () => ElevarmDropdownInputField<String>(
                  label: '',
                  hintText: AppLocalizations.of(context)!.selectState,
                  enabled: false,
                  onChanged: (value) {},
                  options: List.generate(
                    BusinessProfileType.values.length,
                    (index) => ElevarmDropdownInputFieldOption(
                      title: BusinessProfileType.values[index].label,
                      subtitle: '',
                      value: '',
                    ),
                  ),
                ),
          ),
      SizedBox(height: 5),
      Row(
        children: [
          Text(
            AppLocalizations.of(context)!.selectDistrict,
            textAlign: TextAlign.left,
            style: ElevarmFontFamilies.inter(
              color: Colors.black,
              fontSize: ElevarmFontSizes.md,
              fontWeight: ElevarmFontWeights.regular,
            ),
          ),
        ],
      ),
      ref
          .watch(
            districtListProvider(code: "${ref.watch(statesProvider)?.code}"),
          )
          .when(
            data: (data) {
              return DropdownSearch<DistrictDatum?>(
                compareFn:
                    (item1, item2) =>
                        item1?.districtCode == item2?.districtCode,
                popupProps: PopupPropsMultiSelection.menu(
                  constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                  searchFieldProps: TextFieldProps(
                    autofocus: false,
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
                  containerBuilder:
                      (context, popupWidget) =>
                          ElevarmNeutralCard(child: popupWidget),
                  itemBuilder:
                      (context, terminal, isVisible, _) => ColumnSuper(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: Pad(all: 10),
                            child: Text(
                              "${terminal?.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          ),
                          ElevarmDivider(),
                        ],
                      ),
                  title: Padding(
                    padding: Pad(all: 10),
                    child: Text(
                      AppLocalizations.of(context)!.selectDistrict,
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
                        user?.districtFilterByName(filter) ?? false,

                // asyncItems: (String filter) => getData(filter),
                items: (s, d) => data.data!,
                itemAsString: (DistrictDatum? u) => u?.name ?? "",
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!.pleaseSelectDistrict;
                  }
                  return null;
                },
                onChanged:
                    (data) => ref.watch(districtProvider.notifier).state = data,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    contentPadding: Pad(left: 10, bottom: 5, top: 5),
                    hintText: AppLocalizations.of(context)!.selectDistrict,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: ColorConstant.maingreen),
                    ),
                  ),
                ),
              );
            },
            error: (e, s) => Container(),
            loading:
                () => ElevarmDropdownInputField<String>(
                  label: '',
                  hintText: AppLocalizations.of(context)!.selectDistrict,
                  enabled: false,
                  onChanged: (value) {},
                  options: List.generate(
                    BusinessProfileType.values.length,
                    (index) => ElevarmDropdownInputFieldOption(
                      title: BusinessProfileType.values[index].label,
                      subtitle: '',
                      value: '',
                    ),
                  ),
                ),
          ),
      SizedBox(height: 10),
      SizedBox(
        width: Get.width,
        child: Text(
          AppLocalizations.of(context)!.selectCommodities,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Adaptive.sp(16),
            color: ColorConstant.maingreen,
          ),
        ),
      ),
      ref
          .watch(warehouseDataProvider)
          .when(
            data:
                (data) => DropdownSearch<Commodite?>.multiSelection(
                  compareFn: (a, b) => a?.id == b?.id,
                  popupProps: PopupPropsMultiSelection.menu(
                    constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                    searchFieldProps: TextFieldProps(
                      autofocus: false,
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
                    containerBuilder:
                        (context, popupWidget) =>
                            ElevarmNeutralCard(child: popupWidget),
                    itemBuilder:
                        (context, terminal, isVisible, _) => ColumnSuper(
                          alignment: Alignment.centerLeft,
                          children: [
                            Padding(
                              padding: Pad(all: 10),
                              child: Text(
                                "${terminal?.category}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ),
                            ElevarmDivider(),
                          ],
                        ),
                    title: Padding(
                      padding: Pad(all: 10),
                      child: Text(
                        AppLocalizations.of(context)!.selectCommodity,
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
                  items: (s, d) => data.commodites!,
                  itemAsString: (Commodite? u) => u?.category ?? "",
                  validator: (value) {
                    if (value == null) {
                      return AppLocalizations.of(
                        context,
                      )!.pleaseSelectCommodity;
                    }
                    return null;
                  },
                  onChanged:
                      (data) =>
                          ref.watch(commodityProvider.notifier).state = data,
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      contentPadding: Pad(left: 10, bottom: 5, top: 5),
                      hintText: AppLocalizations.of(context)!.selectCommodity,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: ColorConstant.maingreen),
                      ),
                    ),
                  ),
                ),
            error: (e, s) => Container(),
            loading:
                () => ElevarmTextInputField(
                  label: '',
                  hintText: 'Loading',
                  helperText: '',
                  isRequired: true,
                  suffixAddOnText: "",
                  keyboardType: TextInputType.number,
                ),
          ),
      SizedBox(height: 10),
      ElevarmDropdownInputField<TraderTurnover>(
        label: AppLocalizations.of(context)!.selectAnnualTurnover,
        hintText: AppLocalizations.of(context)!.selectTurnover,
        onChanged: (value) {
          ref.watch(traderTurnoverProvider.notifier).state = value;
        },
        options: List.generate(
          InvestorAmount.values.length,
          (index) => ElevarmDropdownInputFieldOption(
            title: TraderTurnover.values[index].label,
            subtitle: '',
            value: TraderTurnover.values[index],
          ),
        ),
      ),
      SizedBox(height: 10),
    ],
  );

  processorLayout() => Column(
    children: [
      Row(
        children: [
          Text(
            AppLocalizations.of(context)!.selectState,
            textAlign: TextAlign.left,
            style: ElevarmFontFamilies.inter(
              color: Colors.black,
              fontSize: ElevarmFontSizes.md,
              fontWeight: ElevarmFontWeights.regular,
            ),
          ),
        ],
      ),
      ref
          .watch(statesListProvider)
          .when(
            data: (data) {
              return DropdownSearch<StatesDatum?>(
                compareFn: (a, b) => a?.id == b?.id,
                popupProps: PopupPropsMultiSelection.menu(
                  constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                  searchFieldProps: TextFieldProps(
                    autofocus: false,
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
                  containerBuilder:
                      (context, popupWidget) =>
                          ElevarmNeutralCard(child: popupWidget),
                  itemBuilder:
                      (context, terminal, isVisible, _) => ColumnSuper(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: Pad(all: 10),
                            child: Text(
                              "${terminal?.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          ),
                          ElevarmDivider(),
                        ],
                      ),
                  title: Padding(
                    padding: Pad(all: 10),
                    child: Text(
                      AppLocalizations.of(context)!.selectState,
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
                    (user, filter) => user?.stateFilterByName(filter) ?? false,

                // asyncItems: (String filter) => getData(filter),
                items: (s, d) => data.data!,
                itemAsString: (StatesDatum? u) => u?.name ?? "",
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!.pleaseSelectState;
                  }
                  return null;
                },
                onChanged:
                    (data) => ref.watch(statesProvider.notifier).state = data,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    contentPadding: Pad(left: 10, bottom: 5, top: 5),
                    hintText: AppLocalizations.of(context)!.selectState,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: ColorConstant.maingreen),
                    ),
                  ),
                ),
              );
            },
            error: (e, s) => Container(),
            loading:
                () => ElevarmDropdownInputField<String>(
                  label: '',
                  hintText: AppLocalizations.of(context)!.selectState,
                  enabled: false,
                  onChanged: (value) {},
                  options: List.generate(
                    BusinessProfileType.values.length,
                    (index) => ElevarmDropdownInputFieldOption(
                      title: BusinessProfileType.values[index].label,
                      subtitle: '',
                      value: '',
                    ),
                  ),
                ),
          ),
      SizedBox(height: 5),
      Row(
        children: [
          Text(
            AppLocalizations.of(context)!.selectDistrict,
            textAlign: TextAlign.left,
            style: ElevarmFontFamilies.inter(
              color: Colors.black,
              fontSize: ElevarmFontSizes.md,
              fontWeight: ElevarmFontWeights.regular,
            ),
          ),
        ],
      ),
      ref
          .watch(
            districtListProvider(code: "${ref.watch(statesProvider)?.code}"),
          )
          .when(
            data: (data) {
              return DropdownSearch<DistrictDatum?>(
                compareFn: (a, b) => a?.id == b?.id,
                popupProps: PopupPropsMultiSelection.menu(
                  constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                  searchFieldProps: TextFieldProps(
                    autofocus: false,
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
                  containerBuilder:
                      (context, popupWidget) =>
                          ElevarmNeutralCard(child: popupWidget),
                  itemBuilder:
                      (context, terminal, isVisible, _) => ColumnSuper(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                            padding: Pad(all: 10),
                            child: Text(
                              "${terminal?.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          ),
                          ElevarmDivider(),
                        ],
                      ),
                  title: Padding(
                    padding: Pad(all: 10),
                    child: Text(
                      AppLocalizations.of(context)!.selectDistrict,
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
                        user?.districtFilterByName(filter) ?? false,

                // asyncItems: (String filter) => getData(filter),
                items: (s, d) => data.data!,
                itemAsString: (DistrictDatum? u) => u?.name ?? "",
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)!.pleaseSelectDistrict;
                  }
                  return null;
                },
                onChanged:
                    (data) => ref.watch(districtProvider.notifier).state = data,
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    contentPadding: Pad(left: 10, bottom: 5, top: 5),
                    hintText: AppLocalizations.of(context)!.selectDistrict,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: ColorConstant.maingreen),
                    ),
                  ),
                ),
              );
            },
            error: (e, s) => Container(),
            loading:
                () => ElevarmDropdownInputField<String>(
                  label: '',
                  hintText: AppLocalizations.of(context)!.selectDistrict,
                  enabled: false,
                  onChanged: (value) {},
                  options: List.generate(
                    BusinessProfileType.values.length,
                    (index) => ElevarmDropdownInputFieldOption(
                      title: BusinessProfileType.values[index].label,
                      subtitle: '',
                      value: '',
                    ),
                  ),
                ),
          ),
      SizedBox(height: 10),
      SizedBox(
        width: Get.width,
        child: Text(
          AppLocalizations.of(context)!.selectCommodities,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Adaptive.sp(16),
            color: ColorConstant.maingreen,
          ),
        ),
      ),
      ref
          .watch(warehouseDataProvider)
          .when(
            data:
                (data) => DropdownSearch<Commodite?>.multiSelection(
                  compareFn: (a, b) => a?.id == b?.id,
                  popupProps: PopupPropsMultiSelection.menu(
                    constraints: BoxConstraints(maxHeight: Get.height / 1.5),
                    searchFieldProps: TextFieldProps(
                      autofocus: false,
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
                    containerBuilder:
                        (context, popupWidget) =>
                            ElevarmNeutralCard(child: popupWidget),
                    itemBuilder:
                        (context, terminal, isVisible, _) => ColumnSuper(
                          alignment: Alignment.centerLeft,
                          children: [
                            Padding(
                              padding: Pad(all: 10),
                              child: Text(
                                "${terminal?.category}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ),
                            ElevarmDivider(),
                          ],
                        ),
                    title: Padding(
                      padding: Pad(all: 10),
                      child: Text(
                        AppLocalizations.of(context)!.selectCommodity,
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
                  items: (s, d) => data.commodites!,
                  itemAsString: (Commodite? u) => u?.category ?? "",
                  validator: (value) {
                    if (value == null) {
                      return AppLocalizations.of(
                        context,
                      )!.pleaseSelectCommodity;
                    }
                    return null;
                  },
                  onChanged:
                      (data) =>
                          ref.watch(commodityProvider.notifier).state = data,
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      contentPadding: Pad(left: 10, bottom: 5, top: 5),
                      hintText: AppLocalizations.of(context)!.selectCommodity,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: ColorConstant.maingreen),
                      ),
                    ),
                  ),
                ),
            error: (e, s) => Container(),
            loading:
                () => ElevarmTextInputField(
                  label: '',
                  hintText: 'Loading',
                  helperText: '',
                  isRequired: true,
                  suffixAddOnText: "",
                  keyboardType: TextInputType.number,
                ),
          ),
      SizedBox(height: 10),
      ElevarmDropdownInputField<MillTypes>(
        label: AppLocalizations.of(context)!.typeOfProcessingFacility,
        hintText: AppLocalizations.of(context)!.selectFacility,
        onChanged: (value) {
          ref.watch(typeOfMillProvider.notifier).state = value;
        },
        options: List.generate(
          MillTypes.values.length,
          (index) => ElevarmDropdownInputFieldOption(
            title: MillTypes.values[index].label,
            subtitle: '',
            value: MillTypes.values[index],
          ),
        ),
      ),
      SizedBox(height: 10),
      ElevarmDropdownInputField<MillCapacity>(
        label: AppLocalizations.of(context)!.millCapacityPerAnnum,
        hintText: AppLocalizations.of(context)!.selectCapacityPerAnnum,
        onChanged: (value) {
          ref.watch(millCapacityProvider.notifier).state = value;
          // ref.watch(traderTurnoverProvider.notifier).state = value;
        },
        options: List.generate(
          MillCapacity.values.length,
          (index) => ElevarmDropdownInputFieldOption(
            title: MillCapacity.values[index].label,
            subtitle: '',
            value: MillCapacity.values[index],
          ),
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
