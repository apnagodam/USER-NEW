import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/BusinessProfile/BusinessProfile.dart';
import 'package:apnagodam/presentation/BusinessProfile/Model/BusinessListingModel.dart';
import 'package:apnagodam/presentation/BusinessProfile/Service/BusinessProfileService.dart';
import 'package:apnagodam/widgets/enums.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class Businessprofilelisting extends ConsumerStatefulWidget {
  const Businessprofilelisting({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessprofilelistingState();
}

class _BusinessprofilelistingState
    extends ConsumerState<Businessprofilelisting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(Businessprofile());
            },
            icon: const Icon(Icons.edit),
          ),
        ],
        title: Text(AppLocalizations.of(context)!.businessProfile),
      ),
      body: businessProfileLayout(),
    );
  }

  Widget businessProfileLayout() {
    return ListView(
      padding: Pad(all: 10),
      children: [
        ref
            .watch(businessProfilesProvider)
            .when(
              data: (data) {
                if (data.data?.type == BusinessProfileType.farmer.type) {
                  return farmerLayout(data);
                } else if (data.data?.type ==
                    BusinessProfileType.investor.type) {
                  return investorLayout(data);
                } else if (data.data?.type == BusinessProfileType.trader.type) {
                  return traderLayout(data);
                } else if (data.data?.type ==
                    BusinessProfileType.processor.type) {
                  return processorLayout(data);
                }
                return noDataFoundOrders(context);
              },
              error: (e, s) => Container(),
              loading: () => defaultLoader(),
            ),
      ],
    );
  }

  farmerLayout(BusinessLIstingModel data) => Column(
    children: [
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.msgState,
        hintText: AppLocalizations.of(context)!.msgState,
        initialValue: "${data.data?.state ?? ""}",
        isRequired: true,
        enabled: false,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.msgDistrict,
        hintText: AppLocalizations.of(context)!.msgDistrict,
        initialValue: "${data.data?.district ?? ""}",
        isRequired: true,
        enabled: false,
        keyboardType: TextInputType.text,
      ),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.khasraNumber,
        enabled: false,
        hintText: AppLocalizations.of(context)!.khasraNumber,
        initialValue: "${data.data?.khasraNo ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.tehsilName,
        enabled: false,
        hintText: AppLocalizations.of(context)!.tehsilName,
        initialValue: "${data.data?.tehsil ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.areaInAcres,
        enabled: false,
        hintText: AppLocalizations.of(context)!.areaInAcres,
        initialValue: "${data.data?.landMap ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.msgCommodityy,
        hintText: AppLocalizations.of(context)!.msgCommodityy,
        initialValue: "${data.data?.commodity ?? ""}",
        isRequired: true,
        enabled: false,
        keyboardType: TextInputType.text,
      ),
    ],
  );

  investorLayout(BusinessLIstingModel data) => Column(
    children: [
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.msgState,
        hintText: AppLocalizations.of(context)!.msgState,
        enabled: false,
        initialValue: "${data.data?.stateName ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.msgDistrict,
        hintText: AppLocalizations.of(context)!.msgDistrict,
        enabled: false,
        initialValue: "${data.data?.district ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.investmentAmount,
        enabled: false,
        hintText: AppLocalizations.of(context)!.investmentAmount,
        initialValue: "${data.data?.investerAnnualCapicity ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        enabled: false,
        label: AppLocalizations.of(context)!.commodities,
        hintText: AppLocalizations.of(context)!.commodities,
        initialValue: "${data.data?.commodity ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
    ],
  );

  traderLayout(BusinessLIstingModel data) => Column(
    children: [
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.msgState,
        hintText: AppLocalizations.of(context)!.msgState,
        enabled: false,
        initialValue: "${data.data?.state ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.msgDistrict,
        hintText: AppLocalizations.of(context)!.msgDistrict,
        enabled: false,
        initialValue: "${data.data?.district ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.commodities,
        hintText: AppLocalizations.of(context)!.commodities,
        enabled: false,
        initialValue: "${data.data?.commodity ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.turnover,
        enabled: false,
        hintText: AppLocalizations.of(context)!.turnover,
        initialValue: "${data.data?.dailyCapacity ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
    ],
  );

  processorLayout(BusinessLIstingModel data) => Column(
    children: [
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.msgState,
        enabled: false,
        hintText: AppLocalizations.of(context)!.msgState,
        initialValue: "${data.data?.state ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        enabled: false,
        label: AppLocalizations.of(context)!.msgDistrict,
        hintText: AppLocalizations.of(context)!.msgDistrict,
        initialValue: "${data.data?.district ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.commodities,
        hintText: AppLocalizations.of(context)!.commodities,
        initialValue: "${data.data?.commodity ?? ""}",
        enabled: false,
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.facilityType,
        hintText: AppLocalizations.of(context)!.facilityType,
        enabled: false,
        initialValue: "${data.data?.summery ?? ""}",
        isRequired: true,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
      ElevarmTextInputField(
        label: AppLocalizations.of(context)!.millCapacityPerAnnum,
        hintText: AppLocalizations.of(context)!.millCapacityPerAnnum,
        initialValue: "${data.data?.milsType ?? ""}",
        isRequired: true,
        enabled: false,
        keyboardType: TextInputType.text,
      ),
      const SizedBox(height: 10),
    ],
  );
}
