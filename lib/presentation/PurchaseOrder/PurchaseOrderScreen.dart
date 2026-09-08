import 'dart:io';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/PurchaseOrder/model/BrokerBuyerModel.dart';
import 'package:apnagodam/presentation/PurchaseOrder/service/PurchaseOrderService.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/widgets/dailogs/customAlertDialog.dart';
import 'package:apnagodam/widgets/dailogs/error.dart';
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

import '../../core/utils/helper.dart';
import '../../extensions/extensions.dart';

class Purchaseorderscreen extends ConsumerStatefulWidget {
  const Purchaseorderscreen({super.key});

  @override
  ConsumerState<Purchaseorderscreen> createState() =>
      _PurchaseorderscreenState();
}

class _PurchaseorderscreenState extends ConsumerState<Purchaseorderscreen> {
  final poKey = GlobalKey<FormState>();

  // Text Controllers
  final weightController = TextEditingController();
  final rateController = TextEditingController();
  final poNumberController = TextEditingController();
  final factoryAddressController = TextEditingController();
  final paymentDaysController = TextEditingController();
  final qualityController = TextEditingController();
  final tdsController = TextEditingController();

  // State Providers
  final selectedWarehouseProvider = StateProvider<PoWarehouseItem?>((ref) => null);
  final selectedCommodityProvider = StateProvider<PoCommodityItem?>((ref) => null);
  final selectedBrokerProvider = StateProvider<PoUserItem?>((ref) => null);
  final selectedBuyerProvider = StateProvider<PoUserItem?>((ref) => null);
  final selectedShipToProvider = StateProvider<PoUserItem?>((ref) => null);
  final selectedFactoryProvider = StateProvider<PoFactoryItem?>((ref) => null);
  final selectedPaymentProvider = StateProvider<Map<String, String>?>((ref) => null);
  final imageProvider = StateProvider<File?>((ref) => null);
  final issueDateProvider = StateProvider<DateTime?>((ref) => null);
  final expiryDateProvider = StateProvider<DateTime?>((ref) => null);

  final List<Map<String, String>> paymentOptions = const [
    {"id": "1", "name": "Truck Load"},
    {"id": "2", "name": "Delivery"},

  ];

  @override
  void dispose() {
    weightController.dispose();
    rateController.dispose();
    poNumberController.dispose();
    factoryAddressController.dispose();
    paymentDaysController.dispose();
    qualityController.dispose();
    tdsController.dispose();
    super.dispose();
  }

  InputDecoration _dropdownDecoration(String hintText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: Adaptive.sp(15),
        color: Colors.grey.shade600,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: ColorConstant.maingreen),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: ColorConstant.maingreen, width: 1.5),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }

  Widget _fieldLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: Adaptive.sp(15),
          ),
          children: [
            if (isRequired)
              const TextSpan(
                text: " *",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedWarehouse = ref.watch(selectedWarehouseProvider);
    final selectedCommodity = ref.watch(selectedCommodityProvider);
    final selectedShipTo = ref.watch(selectedShipToProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.purchaseOrder2),
      ),
      body: Form(
        key: poKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Warehouse Name* (Dropdown from getWarehouseData -> WarehouseData)
              _fieldLabel("Warehouse Name", isRequired: true),
              ref.watch(getPoWarehouseDataProvider).when(
                    data: (warehouseData) => DropdownSearch<PoWarehouseItem>(
                      compareFn: (a, b) => a.id == b.id,
                      popupProps: PopupProps.menu(
                        searchFieldProps: TextFieldProps(
                          autofocus: true,
                          cursorColor: ColorConstant.maingreen,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Search Warehouse",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorConstant.maingreen),
                            ),
                          ),
                        ),
                        menuProps: MenuProps(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: ColorConstant.maingreen),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        itemBuilder: (context, item, isVisible, _) => Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${item.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Adaptive.sp(15),
                            ),
                          ),
                        ),
                        showSearchBox: true,
                      ),
                      filterFn: (item, filter) => (item.name ?? '')
                          .toLowerCase()
                          .contains(filter.toLowerCase().trim()),
                      items: (s, d) => warehouseData.warehouseData ?? [],
                      itemAsString: (PoWarehouseItem? u) => u?.name ?? "",
                      selectedItem: selectedWarehouse,
                      onChanged: (PoWarehouseItem? data) {
                        ref.read(selectedWarehouseProvider.notifier).state =
                            data;
                        ref.read(selectedCommodityProvider.notifier).state =
                            null;
                        ref.read(selectedShipToProvider.notifier).state = null;
                        ref.read(selectedFactoryProvider.notifier).state = null;
                        factoryAddressController.clear();
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select Warehouse";
                        }
                        return null;
                      },
                      decoratorProps: DropDownDecoratorProps(
                        decoration: _dropdownDecoration("Select Warehouse"),
                      ),
                    ),
                    error: (e, s) => Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Text(
                        "Failed to load warehouses. Please retry.",
                        style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: Adaptive.sp(14)),
                      ),
                    ),
                    loading: () => defaultLoader(),
                  ),
              const SizedBox(height: 14),

              // 2. Commodity* (Dropdown from getCommodityData by terminal_id)
              _fieldLabel("Commodity", isRequired: true),
              if (selectedWarehouse == null)
                DropdownSearch<PoCommodityItem>(
                  enabled: false,
                  compareFn: (a, b) => a.id == b.id,
                  items: (s, d) => [],
                  decoratorProps: DropDownDecoratorProps(
                    decoration:
                        _dropdownDecoration("Select Warehouse first"),
                  ),
                )
              else
                ref
                    .watch(
                        getPoCommodityDataProvider("${selectedWarehouse.id}"))
                    .when(
                      data: (commodityData) =>
                          DropdownSearch<PoCommodityItem>(
                        compareFn: (a, b) => a.id == b.id,
                        popupProps: PopupProps.menu(
                          searchFieldProps: TextFieldProps(
                            autofocus: true,
                            cursorColor: ColorConstant.maingreen,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              hintText: "Search Commodity",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstant.maingreen),
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          itemBuilder: (context, item, isVisible, _) => Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "${item.category}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(15),
                              ),
                            ),
                          ),
                          showSearchBox: true,
                        ),
                        filterFn: (item, filter) => (item.category ?? '')
                            .toLowerCase()
                            .contains(filter.toLowerCase().trim()),
                        items: (s, d) => commodityData.commodityData ?? [],
                        itemAsString: (PoCommodityItem? u) =>
                            u?.category ?? "",
                        selectedItem: selectedCommodity,
                        onChanged: (PoCommodityItem? data) {
                          ref.read(selectedCommodityProvider.notifier).state =
                              data;
                          ref.read(selectedShipToProvider.notifier).state =
                              null;
                          ref.read(selectedFactoryProvider.notifier).state =
                              null;
                          factoryAddressController.clear();
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please select Commodity";
                          }
                          return null;
                        },
                        decoratorProps: DropDownDecoratorProps(
                          decoration: _dropdownDecoration("Select Commodity"),
                        ),
                      ),
                      error: (e, s) => Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Text(
                          "Failed to load commodities. Please retry.",
                          style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: Adaptive.sp(14)),
                        ),
                      ),
                      loading: () => defaultLoader(),
                    ),
              const SizedBox(height: 14),

              // 3. Weight(Qtl)* (Text Input)
              _fieldLabel("Weight(Qtl)", isRequired: true),
              TextFormField(
                controller: weightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                decoration: _dropdownDecoration("Enter Weight"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter Weight";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 4. Rate(Qtl)* (Text Input)
              _fieldLabel("Rate(Qtl)", isRequired: true),
              TextFormField(
                controller: rateController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                decoration: _dropdownDecoration("Enter Rate"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter Rate";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 5. PO Number* (Text Input)
              _fieldLabel("PO Number", isRequired: true),
              TextFormField(
                controller: poNumberController,
                textInputAction: TextInputAction.next,
                decoration: _dropdownDecoration("Enter PO Number"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter PO Number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 6. Broker Name (Dropdown from getWarehouseData -> BrokerData, Optional)
              _fieldLabel("Broker Name", isRequired: false),
              ref.watch(getPoWarehouseDataProvider).when(
                    data: (warehouseData) => DropdownSearch<PoUserItem>(
                      compareFn: (a, b) => a.id == b.id,
                      popupProps: PopupProps.menu(
                        searchFieldProps: TextFieldProps(
                          autofocus: true,
                          cursorColor: ColorConstant.maingreen,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Search Broker",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorConstant.maingreen),
                            ),
                          ),
                        ),
                        menuProps: MenuProps(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: ColorConstant.maingreen),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        itemBuilder: (context, item, isVisible, _) => Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${item.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Adaptive.sp(15),
                            ),
                          ),
                        ),
                        showSearchBox: true,
                      ),
                      filterFn: (item, filter) => (item.name ?? '')
                          .toLowerCase()
                          .contains(filter.toLowerCase().trim()),
                      items: (s, d) => warehouseData.brokerData ?? [],
                      itemAsString: (PoUserItem? u) => u?.name ?? "",
                      selectedItem: ref.watch(selectedBrokerProvider),
                      onChanged: (PoUserItem? data) => ref
                          .read(selectedBrokerProvider.notifier)
                          .state = data,
                      decoratorProps: DropDownDecoratorProps(
                        decoration: _dropdownDecoration("Select Broker"),
                      ),
                    ),
                    error: (e, s) => const SizedBox(),
                    loading: () => defaultLoader(),
                  ),
              const SizedBox(height: 14),

              // 7. Buyer Name* (Dropdown from getWarehouseData -> BuyerData)
              _fieldLabel("Buyer Name", isRequired: true),
              ref.watch(getPoWarehouseDataProvider).when(
                    data: (warehouseData) => DropdownSearch<PoUserItem>(
                      compareFn: (a, b) => a.id == b.id,
                      popupProps: PopupProps.menu(
                        searchFieldProps: TextFieldProps(
                          autofocus: true,
                          cursorColor: ColorConstant.maingreen,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Search Buyer",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorConstant.maingreen),
                            ),
                          ),
                        ),
                        menuProps: MenuProps(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: ColorConstant.maingreen),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        itemBuilder: (context, item, isVisible, _) => Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${item.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Adaptive.sp(15),
                            ),
                          ),
                        ),
                        showSearchBox: true,
                      ),
                      filterFn: (item, filter) => (item.name ?? '')
                          .toLowerCase()
                          .contains(filter.toLowerCase().trim()),
                      items: (s, d) => warehouseData.buyerData ?? [],
                      itemAsString: (PoUserItem? u) => u?.name ?? "",
                      selectedItem: ref.watch(selectedBuyerProvider),
                      onChanged: (PoUserItem? data) => ref
                          .read(selectedBuyerProvider.notifier)
                          .state = data,
                      validator: (value) {
                        if (value == null) {
                          return "Please select Buyer Name";
                        }
                        return null;
                      },
                      decoratorProps: DropDownDecoratorProps(
                        decoration: _dropdownDecoration("Select Buyer"),
                      ),
                    ),
                    error: (e, s) => const SizedBox(),
                    loading: () => defaultLoader(),
                  ),
              const SizedBox(height: 14),

              // 8. Ship To* (Dropdown from getShipToUserData by commodity_id)
              _fieldLabel("Ship To", isRequired: true),
              if (selectedCommodity == null)
                DropdownSearch<PoUserItem>(
                  enabled: false,
                  compareFn: (a, b) => a.id == b.id,
                  items: (s, d) => [],
                  decoratorProps: DropDownDecoratorProps(
                    decoration:
                        _dropdownDecoration("Select Commodity first"),
                  ),
                )
              else
                ref
                    .watch(
                        getPoShipToUserDataProvider("${selectedCommodity.id}"))
                    .when(
                      data: (shipToData) => DropdownSearch<PoUserItem>(
                        compareFn: (a, b) => a.id == b.id,
                        popupProps: PopupProps.menu(
                          searchFieldProps: TextFieldProps(
                            autofocus: true,
                            cursorColor: ColorConstant.maingreen,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              hintText: "Search Ship To",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstant.maingreen),
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          itemBuilder: (context, item, isVisible, _) => Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "${item.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(15),
                              ),
                            ),
                          ),
                          showSearchBox: true,
                        ),
                        filterFn: (item, filter) => (item.name ?? '')
                            .toLowerCase()
                            .contains(filter.toLowerCase().trim()),
                        items: (s, d) => shipToData.buyers ?? [],
                        itemAsString: (PoUserItem? u) => u?.name ?? "",
                        selectedItem: selectedShipTo,
                        onChanged: (PoUserItem? data) {
                          ref.read(selectedShipToProvider.notifier).state =
                              data;
                          ref.read(selectedFactoryProvider.notifier).state =
                              null;
                          factoryAddressController.clear();
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please select Ship To";
                          }
                          return null;
                        },
                        decoratorProps: DropDownDecoratorProps(
                          decoration: _dropdownDecoration("Select Ship To"),
                        ),
                      ),
                      error: (e, s) => Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Text(
                          "Failed to load Ship To users. Please retry.",
                          style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: Adaptive.sp(14)),
                        ),
                      ),
                      loading: () => defaultLoader(),
                    ),
              const SizedBox(height: 14),

              // 9. Factory Name* (Dropdown from getFactoryList by shipToUserId)
              _fieldLabel("Factory Name", isRequired: true),
              if (selectedShipTo == null)
                DropdownSearch<PoFactoryItem>(
                  enabled: false,
                  compareFn: (a, b) => a.id == b.id,
                  items: (s, d) => [],
                  decoratorProps: DropDownDecoratorProps(
                    decoration:
                        _dropdownDecoration("Select Ship To first"),
                  ),
                )
              else
                ref
                    .watch(getPoFactoryListProvider("${selectedShipTo.id}"))
                    .when(
                      data: (factoryData) => DropdownSearch<PoFactoryItem>(
                        compareFn: (a, b) => a.id == b.id,
                        popupProps: PopupProps.menu(
                          searchFieldProps: TextFieldProps(
                            autofocus: true,
                            cursorColor: ColorConstant.maingreen,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              hintText: "Search Factory Name",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstant.maingreen),
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          itemBuilder: (context, item, isVisible, _) => Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "${item.factoryName}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(15),
                              ),
                            ),
                          ),
                          showSearchBox: true,
                        ),
                        filterFn: (item, filter) => (item.factoryName ?? '')
                            .toLowerCase()
                            .contains(filter.toLowerCase().trim()),
                        items: (s, d) => factoryData.factoryList ?? [],
                        itemAsString: (PoFactoryItem? u) =>
                            u?.factoryName ?? "",
                        selectedItem: ref.watch(selectedFactoryProvider),
                        onChanged: (PoFactoryItem? data) {
                          ref.read(selectedFactoryProvider.notifier).state =
                              data;
                          if (data != null &&
                              data.factoryAddress != null &&
                              data.factoryAddress!.isNotEmpty) {
                            factoryAddressController.text =
                                data.factoryAddress!;
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please select Factory Name";
                          }
                          return null;
                        },
                        decoratorProps: DropDownDecoratorProps(
                          decoration:
                              _dropdownDecoration("Select Factory Name"),
                        ),
                      ),
                      error: (e, s) => Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Text(
                          "Failed to load factories. Please retry.",
                          style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: Adaptive.sp(14)),
                        ),
                      ),
                      loading: () => defaultLoader(),
                    ),
              const SizedBox(height: 14),

              // 10. Factory Address* (Text Input, Auto-filled from factory selection)
              _fieldLabel("Factory Address", isRequired: true),
              TextFormField(
                controller: factoryAddressController,
                keyboardType: TextInputType.streetAddress,
                maxLines: 2,
                textInputAction: TextInputAction.next,
                decoration: _dropdownDecoration("Enter Factory Address"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter Factory Address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 11. Payment* (Dropdown)
              _fieldLabel("Payment", isRequired: true),
              DropdownSearch<Map<String, String>>(
                compareFn: (a, b) => a["id"] == b["id"],
                popupProps: PopupProps.menu(
                  menuProps: MenuProps(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorConstant.maingreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  itemBuilder: (context, item, isVisible, _) => Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      item["name"] ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Adaptive.sp(15),
                      ),
                    ),
                  ),
                ),
                items: (s, d) => paymentOptions,
                itemAsString: (item) => item["name"] ?? "",
                selectedItem: ref.watch(selectedPaymentProvider),
                onChanged: (data) =>
                    ref.read(selectedPaymentProvider.notifier).state = data,
                validator: (value) {
                  if (value == null) {
                    return "Please select Payment Type";
                  }
                  return null;
                },
                decoratorProps: DropDownDecoratorProps(
                  decoration: _dropdownDecoration("Select Type"),
                ),
              ),
              const SizedBox(height: 14),

              // 12. Payment Days* (Text Input)
              _fieldLabel("Payment Days", isRequired: true),
              TextFormField(
                controller: paymentDaysController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: _dropdownDecoration("Enter Payment Days"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter Payment Days";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 13. Quality Condition* (Text Input)
              _fieldLabel("Quality Condition", isRequired: true),
              TextFormField(
                controller: qualityController,
                textInputAction: TextInputAction.next,
                decoration: _dropdownDecoration("Enter Quality Condition"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter Quality Condition";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 14. TDS(%) (Text Input - Optional)
              _fieldLabel("TDS(%)", isRequired: false),
              TextFormField(
                controller: tdsController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                decoration: _dropdownDecoration("Enter TDS"),
              ),
              const SizedBox(height: 14),

              // 15. PO Image* (File / Image Picker)
              _fieldLabel("PO Image", isRequired: true),
              SizedBox(
                height: 220,
                width: double.infinity,
                child: InkWell(
                  onTap: () async {
                    try {
                      showImageSourceFilePickerDialog(
                        context,
                        (image) {
                          ref.read(imageProvider.notifier).state =
                              File(image.path);
                        },
                        maxWidth: 1024,
                        maxHeight: 1024,
                        imageQuality: 70,
                      );
                    } catch (e, s) {
                      debugPrintStack(stackTrace: s);
                    }
                  },
                  child: DottedBorder(
                    color: ColorConstant.maingreen,
                    borderType: BorderType.RRect,
                    padding: const EdgeInsets.all(10),
                    radius: const Radius.circular(8),
                    child: Center(
                      child: ref.watch(imageProvider) == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_upload_outlined,
                                  size: 42,
                                  color: ColorConstant.maingreen,
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                  ),
                                  child: const Text(
                                    "Choose File",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "No file chosen",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: Adaptive.sp(14),
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.file(
                                  ref.watch(imageProvider)!,
                                  fit: BoxFit.contain,
                                  height: 200,
                                  width: double.infinity,
                                ),
                                IconButton(
                                  icon: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 14,
                                    child: Icon(Icons.close,
                                        size: 16, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    ref.read(imageProvider.notifier).state =
                                        null;
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 16. Date* (Date Picker)
              _fieldLabel("Date", isRequired: true),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: ref.watch(issueDateProvider) ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                  );
                  if (picked != null) {
                    ref.read(issueDateProvider.notifier).state = picked;
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ref.watch(issueDateProvider) == null
                            ? "dd-mm-yyyy"
                            : DateFormat('dd-MM-yyyy')
                                .format(ref.watch(issueDateProvider)!),
                        style: TextStyle(
                          fontSize: Adaptive.sp(15),
                          color: ref.watch(issueDateProvider) == null
                              ? Colors.grey.shade600
                              : Colors.black87,
                          fontWeight: ref.watch(issueDateProvider) == null
                              ? FontWeight.normal
                              : FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.calendar_today_outlined,
                          size: 20, color: ColorConstant.maingreen),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 17. Expiry Date* (Date Picker)
              _fieldLabel("Expiry Date", isRequired: true),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: ref.watch(expiryDateProvider) ??
                        (ref.watch(issueDateProvider) ?? DateTime.now())
                            .add(const Duration(days: 30)),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                  );
                  if (picked != null) {
                    ref.read(expiryDateProvider.notifier).state = picked;
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ref.watch(expiryDateProvider) == null
                            ? "dd-mm-yyyy"
                            : DateFormat('dd-MM-yyyy')
                                .format(ref.watch(expiryDateProvider)!),
                        style: TextStyle(
                          fontSize: Adaptive.sp(15),
                          color: ref.watch(expiryDateProvider) == null
                              ? Colors.grey.shade600
                              : Colors.black87,
                          fontWeight: ref.watch(expiryDateProvider) == null
                              ? FontWeight.normal
                              : FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.calendar_today_outlined,
                          size: 20, color: ColorConstant.maingreen),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    if (poKey.currentState!.validate()) {
                      if (ref.read(selectedWarehouseProvider) == null) {
                        showErrorAlertDialog(
                            context, "Please select Warehouse");
                        return;
                      }
                      if (ref.read(selectedCommodityProvider) == null) {
                        showErrorAlertDialog(
                            context, "Please select Commodity");
                        return;
                      }
                      if (ref.read(selectedBuyerProvider) == null) {
                        showErrorAlertDialog(
                            context, "Please select Buyer Name");
                        return;
                      }
                      if (ref.read(selectedShipToProvider) == null) {
                        showErrorAlertDialog(context, "Please select Ship To");
                        return;
                      }
                      if (ref.read(selectedFactoryProvider) == null) {
                        showErrorAlertDialog(
                            context, "Please select Factory Name");
                        return;
                      }
                      if (ref.read(selectedPaymentProvider) == null) {
                        showErrorAlertDialog(
                            context, "Please select Payment Type");
                        return;
                      }
                      if (ref.read(imageProvider) == null) {
                        showErrorAlertDialog(context, "Please choose PO Image");
                        return;
                      }
                      if (ref.read(issueDateProvider) == null) {
                        showErrorAlertDialog(
                            context, "Please select Date of Purchase Order");
                        return;
                      }
                      if (ref.read(expiryDateProvider) == null) {
                        showErrorAlertDialog(
                            context, "Please select Expiry Date");
                        return;
                      }

                      context.showLoader();
                      try {
                        final formattedDate = DateFormat('yyyy-MM-dd')
                            .format(ref.read(issueDateProvider)!);
                        final formattedExpiryDate = DateFormat('yyyy-MM-dd')
                            .format(ref.read(expiryDateProvider)!);

                        final Map<String, dynamic> response = await ref
                            .read(purchaseOrderServiceProvider)
                            .createPurchaseOrder(
                              terminalId:
                                  "${ref.read(selectedWarehouseProvider)!.id}",
                              commodityId:
                                  "${ref.read(selectedCommodityProvider)!.id}",
                              weight: weightController.text.trim(),
                              rate: rateController.text.trim(),
                              date: formattedDate,
                              expiryDate: formattedExpiryDate,
                              poNumber: poNumberController.text.trim(),
                              brokerUser: ref
                                          .read(selectedBrokerProvider)
                                          ?.id !=
                                      null
                                  ? "${ref.read(selectedBrokerProvider)!.id}"
                                  : "",
                              walletUser:
                                  "${ref.read(selectedBuyerProvider)!.id}",
                              shipToBuyer:
                                  "${ref.read(selectedShipToProvider)!.id}",
                              factoryId:
                                  "${ref.read(selectedFactoryProvider)!.id}",
                              factoryAddress:
                                  factoryAddressController.text.trim(),
                              paymentType: ref
                                      .read(selectedPaymentProvider)?["id"] ??
                                  "1",
                              paymentDays: paymentDaysController.text.trim(),
                              qualityCondition:
                                  qualityController.text.trim(),
                              tdsRate: tdsController.text.trim().isNotEmpty
                                  ? tdsController.text.trim()
                                  : "0",
                              poImage: ref.read(imageProvider)!,
                            );

                        context.hideloader();

                        if (response['status'].toString() == "1" ||
                            response['status'].toString().toLowerCase() ==
                                "true") {
                          Fluttertoast.showToast(
                            msg: response['message']?.toString() ??
                                AppLocalizations.of(context)!.success4,
                          );
                          Get.offAll(DashboardScreen());
                        } else {
                          showErrorAlertDialog(
                            context,
                            response['message']?.toString() ??
                                "Failed to create purchase order",
                          );
                        }
                      } catch (e) {
                        context.hideloader();
                        showErrorAlertDialog(
                          context,
                          "An error occurred while creating purchase order: ${e.toString()}",
                        );
                      }
                    } else {
                      showErrorAlertDialog(
                        context,
                        "Please fill all required fields properly.",
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.maingreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.submit,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.sp(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

