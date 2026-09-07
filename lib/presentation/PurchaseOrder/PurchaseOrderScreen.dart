import 'dart:io';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/PurchaseOrder/model/BrokerBuyerModel.dart';
import 'package:apnagodam/presentation/PurchaseOrder/service/PurchaseOrderService.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/home_screen/models/warehouse_response_model.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:apnagodam/widgets/dailogs/error.dart';
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

import '../../core/utils/helper.dart';

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
  final commodityDropDownProvider = StateProvider<Commodite?>((ref) => null);
  final brokerProvider = StateProvider<BrokerBuyerDatum?>((ref) => null);
  final terminalDropDownProvider = StateProvider<Terminal?>((ref) => null);
  final buyerProvider = StateProvider<BrokerBuyerDatum?>((ref) => null);
  final shipToProvider = StateProvider<BrokerBuyerDatum?>((ref) => null);
  final factoryNameProvider = StateProvider<String?>((ref) => null);
  final paymentTypeProvider = StateProvider<String?>((ref) => null);
  final imageProvider = StateProvider<File?>((ref) => null);
  final issueDateProvider = StateProvider<DateTime?>((ref) => null);
  final expiryDateProvider = StateProvider<DateTime?>((ref) => null);

  final List<String> paymentOptions = const [
    "Advance",
    "CAD",
    "Credit",
    "Against Delivery",
    "RTGS / NEFT",
    "PDC",
    "LC",
    "Immediate",
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
              // 1. Commodity* (Dropdown)
              _fieldLabel("Commodity", isRequired: true),
              ref.watch(warehouseDataProvider).when(
                    data: (warehouseData) => DropdownSearch<Commodite?>(
                      compareFn: (a, b) => a?.id == b?.id,
                      popupProps: PopupProps.menu(
                        searchFieldProps: TextFieldProps(
                          autofocus: true,
                          cursorColor: ColorConstant.maingreen,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Search Commodity",
                            border: OutlineInputBorder(
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
                        itemBuilder: (context, commodity, isVisible, _) =>
                            Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${commodity?.category}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Adaptive.sp(15),
                            ),
                          ),
                        ),
                        showSearchBox: true,
                      ),
                      filterFn: (user, filter) =>
                          user?.userFilterByCreationDate(filter) ?? false,
                      items: (s, d) => warehouseData.commodites ?? [],
                      itemAsString: (Commodite? u) => u?.category ?? "",
                      selectedItem: ref.watch(commodityDropDownProvider),
                      onChanged: (Commodite? data) => ref
                          .read(commodityDropDownProvider.notifier)
                          .state = data,
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
                    error: (e, s) => const SizedBox(),
                    loading: () => defaultLoader(),
                  ),
              const SizedBox(height: 14),

              // 2. Weight(Qtl)* (Text Input)
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

              // 3. Rate(Qtl)* (Text Input)
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

              // 4. PO Number* (Text Input)
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

              // 5. Broker Name (Dropdown - Optional)
              _fieldLabel("Broker Name", isRequired: false),
              ref.watch(getBrokerNamesProvider).when(
                    data: (data) => DropdownSearch<BrokerBuyerDatum>(
                      compareFn: (a, b) => a.userId == b.userId,
                      popupProps: PopupProps.menu(
                        searchFieldProps: TextFieldProps(
                          autofocus: true,
                          cursorColor: ColorConstant.maingreen,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Search Broker",
                            border: OutlineInputBorder(
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
                        itemBuilder: (context, broker, isVisible, _) =>
                            Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${broker.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Adaptive.sp(15),
                            ),
                          ),
                        ),
                        showSearchBox: true,
                      ),
                      filterFn: (user, filter) => user.name
                          .toString()
                          .toLowerCase()
                          .trim()
                          .contains(filter.toLowerCase()),
                      items: (s, d) => data.data ?? [],
                      itemAsString: (BrokerBuyerDatum? u) => u?.name ?? "",
                      selectedItem: ref.watch(brokerProvider),
                      onChanged: (BrokerBuyerDatum? data) =>
                          ref.read(brokerProvider.notifier).state = data,
                      decoratorProps: DropDownDecoratorProps(
                        decoration: _dropdownDecoration("Select User"),
                      ),
                    ),
                    error: (e, s) => const SizedBox(),
                    loading: () => defaultLoader(),
                  ),
              const SizedBox(height: 14),

              // 6. Warehouse Name* (Dropdown)
              _fieldLabel("Warehouse Name", isRequired: true),
              ref.watch(warehouseDataProvider).when(
                    data: (warehouseData) => DropdownSearch<Terminal?>(
                      compareFn: (a, b) => a?.id == b?.id,
                      popupProps: PopupProps.menu(
                        searchFieldProps: TextFieldProps(
                          autofocus: true,
                          cursorColor: ColorConstant.maingreen,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Search Warehouse",
                            border: OutlineInputBorder(
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
                        itemBuilder: (context, terminal, isVisible, _) =>
                            Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${terminal?.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Adaptive.sp(15),
                            ),
                          ),
                        ),
                        showSearchBox: true,
                      ),
                      filterFn: (user, filter) =>
                          user?.userFilterByCreationDate(filter) ?? false,
                      items: (s, d) => warehouseData.terminals ?? [],
                      itemAsString: (Terminal? u) => u?.name ?? "",
                      selectedItem: ref.watch(terminalDropDownProvider),
                      onChanged: (Terminal? data) => ref
                          .read(terminalDropDownProvider.notifier)
                          .state = data,
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
                    error: (e, s) => const SizedBox(),
                    loading: () => defaultLoader(),
                  ),
              const SizedBox(height: 14),

              // 7. Buyer Name* (Dropdown)
              _fieldLabel("Buyer Name", isRequired: true),
              ref.watch(getBrokerNamesProvider).when(
                    data: (data) => DropdownSearch<BrokerBuyerDatum>(
                      compareFn: (a, b) => a.userId == b.userId,
                      popupProps: PopupProps.menu(
                        searchFieldProps: TextFieldProps(
                          autofocus: true,
                          cursorColor: ColorConstant.maingreen,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Search Buyer",
                            border: OutlineInputBorder(
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
                        itemBuilder: (context, buyer, isVisible, _) =>
                            Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${buyer.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Adaptive.sp(15),
                            ),
                          ),
                        ),
                        showSearchBox: true,
                      ),
                      filterFn: (user, filter) => user.name
                          .toString()
                          .toLowerCase()
                          .trim()
                          .contains(filter.toLowerCase()),
                      items: (s, d) => data.data ?? [],
                      itemAsString: (BrokerBuyerDatum? u) => u?.name ?? "",
                      selectedItem: ref.watch(buyerProvider),
                      onChanged: (BrokerBuyerDatum? data) =>
                          ref.read(buyerProvider.notifier).state = data,
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

              // 8. Ship To* (Dropdown)
              _fieldLabel("Ship To", isRequired: true),
              ref.watch(getBrokerNamesProvider).when(
                    data: (data) => DropdownSearch<BrokerBuyerDatum>(
                      compareFn: (a, b) => a.userId == b.userId,
                      popupProps: PopupProps.menu(
                        searchFieldProps: TextFieldProps(
                          autofocus: true,
                          cursorColor: ColorConstant.maingreen,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            hintText: "Search Ship To",
                            border: OutlineInputBorder(
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
                        itemBuilder: (context, shipToItem, isVisible, _) =>
                            Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "${shipToItem.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Adaptive.sp(15),
                            ),
                          ),
                        ),
                        showSearchBox: true,
                      ),
                      filterFn: (user, filter) => user.name
                          .toString()
                          .toLowerCase()
                          .trim()
                          .contains(filter.toLowerCase()),
                      items: (s, d) => data.data ?? [],
                      itemAsString: (BrokerBuyerDatum? u) => u?.name ?? "",
                      selectedItem: ref.watch(shipToProvider),
                      onChanged: (BrokerBuyerDatum? data) =>
                          ref.read(shipToProvider.notifier).state = data,
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
                    error: (e, s) => const SizedBox(),
                    loading: () => defaultLoader(),
                  ),
              const SizedBox(height: 14),

              // 9. Factory Name* (Dropdown)
              _fieldLabel("Factory Name", isRequired: true),
              ref.watch(getBrokerNamesProvider).when(
                    data: (data) {
                      final names = (data.data ?? [])
                          .map((e) => e.name ?? "")
                          .where((e) => e.isNotEmpty)
                          .toList();
                      return DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          searchFieldProps: TextFieldProps(
                            autofocus: true,
                            cursorColor: ColorConstant.maingreen,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Search / Enter Factory Name",
                              border: OutlineInputBorder(
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
                          itemBuilder: (context, item, isVisible, _) =>
                              Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              item,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Adaptive.sp(15),
                              ),
                            ),
                          ),
                          showSearchBox: true,
                        ),
                        items: (s, d) => names,
                        selectedItem: ref.watch(factoryNameProvider),
                        onChanged: (String? data) =>
                            ref.read(factoryNameProvider.notifier).state = data,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please select Factory Name";
                          }
                          return null;
                        },
                        decoratorProps: DropDownDecoratorProps(
                          decoration: _dropdownDecoration("Select Factory Name"),
                        ),
                      );
                    },
                    error: (e, s) => const SizedBox(),
                    loading: () => defaultLoader(),
                  ),
              const SizedBox(height: 14),

              // 10. Factory Address* (Text Input)
              _fieldLabel("Factory Address", isRequired: true),
              TextFormField(
                controller: factoryAddressController,
                keyboardType: TextInputType.streetAddress,
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
              DropdownSearch<String>(
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
                      item,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Adaptive.sp(15),
                      ),
                    ),
                  ),
                ),
                items: (s, d) => paymentOptions,
                selectedItem: ref.watch(paymentTypeProvider),
                onChanged: (String? data) =>
                    ref.read(paymentTypeProvider.notifier).state = data,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
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
                      final picker = ImagePicker();
                      final value = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1200,
                        maxHeight: 1600,
                        imageQuality: 80,
                      );
                      if (value != null) {
                        ref.read(imageProvider.notifier).state = File(value.path);
                      }
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
                                    border: Border.all(color: Colors.grey.shade400),
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
                                    ref.read(imageProvider.notifier).state = null;
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                            : DateFormat('dd-MM-yyyy').format(ref.watch(issueDateProvider)!),
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
                      Icon(Icons.calendar_today_outlined, size: 20, color: ColorConstant.maingreen),
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
                        (ref.watch(issueDateProvider) ?? DateTime.now()).add(const Duration(days: 30)),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                  );
                  if (picked != null) {
                    ref.read(expiryDateProvider.notifier).state = picked;
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                            : DateFormat('dd-MM-yyyy').format(ref.watch(expiryDateProvider)!),
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
                      Icon(Icons.calendar_today_outlined, size: 20, color: ColorConstant.maingreen),
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
                      if (ref.read(commodityDropDownProvider) == null) {
                        showErrorAlertDialog(context, "Please select Commodity");
                        return;
                      }
                      if (ref.read(terminalDropDownProvider) == null) {
                        showErrorAlertDialog(context, "Please select Warehouse");
                        return;
                      }
                      if (ref.read(buyerProvider) == null) {
                        showErrorAlertDialog(context, "Please select Buyer Name");
                        return;
                      }
                      if (ref.read(shipToProvider) == null) {
                        showErrorAlertDialog(context, "Please select Ship To");
                        return;
                      }
                      if (ref.read(factoryNameProvider) == null ||
                          ref.read(factoryNameProvider)!.trim().isEmpty) {
                        showErrorAlertDialog(context, "Please select Factory Name");
                        return;
                      }
                      if (ref.read(paymentTypeProvider) == null ||
                          ref.read(paymentTypeProvider)!.trim().isEmpty) {
                        showErrorAlertDialog(context, "Please select Payment Type");
                        return;
                      }
                      if (ref.read(imageProvider) == null) {
                        showErrorAlertDialog(context, "Please choose PO Image");
                        return;
                      }
                      if (ref.read(issueDateProvider) == null) {
                        showErrorAlertDialog(context, "Please select Date of Purchase Order");
                        return;
                      }
                      if (ref.read(expiryDateProvider) == null) {
                        showErrorAlertDialog(context, "Please select Expiry Date");
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
                                  "${ref.read(terminalDropDownProvider)?.id}",
                              commodityId:
                                  "${ref.read(commodityDropDownProvider)?.id}",
                              weight: weightController.text.trim(),
                              rate: rateController.text.trim(),
                              date: formattedDate,
                              expiryDate: formattedExpiryDate,
                              poNumber: poNumberController.text.trim(),
                              broker: ref.read(brokerProvider)?.userId != null
                                  ? "${ref.read(brokerProvider)?.userId}"
                                  : "",
                              buyerName:
                                  "${ref.read(buyerProvider)?.userId ?? ref.read(buyerProvider)?.name}",
                              shipTo:
                                  "${ref.read(shipToProvider)?.userId ?? ref.read(shipToProvider)?.name}",
                              factoryName:
                                  ref.read(factoryNameProvider) ?? "",
                              factoryAddress:
                                  factoryAddressController.text.trim(),
                              payment: ref.read(paymentTypeProvider) ?? "",
                              paymentDays:
                                  paymentDaysController.text.trim(),
                              qualityCondition:
                                  qualityController.text.trim(),
                              tds: tdsController.text.trim(),
                              poImage: ref.read(imageProvider)!,
                            );

                        context.hideloader();

                        if (response['status'].toString() == "1" ||
                            response['status'].toString().toLowerCase() == "true") {
                          Fluttertoast.showToast(
                            msg: response['message']?.toString() ??
                                AppLocalizations.of(context)!.success4,
                          );
                          Get.offAll(DashboardScreen());
                        } else {
                          showErrorAlertDialog(
                            context,
                            response['message']?.toString() ?? "Failed to create purchase order",
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

