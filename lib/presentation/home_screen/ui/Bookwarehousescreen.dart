import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/localization/app_localizations_extras.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/no_data_found_widget.dart';
import '../../../widgets/CommonTextField.dart';
import '../../../widgets/StackBookCard.dart';
import '../../warehousefacility_screen/ratecard_screen.dart';
import '../../warehousefacility_screen/repo_impl/warehouse_facility_repo_impl.dart';
import '../models/warehouse_response_model.dart';

class Bookwarehousescreen extends ConsumerStatefulWidget {
  const Bookwarehousescreen({
    super.key,
    required this.terminal,
    required this.commdity,
  });

  final Terminal? terminal;
  final List<Commodite>? commdity;

  @override
  ConsumerState<Bookwarehousescreen> createState() =>
      _BookwarehousescreenState();
}

class _BookwarehousescreenState extends ConsumerState<Bookwarehousescreen> {
  var dedicatedProvider = StateProvider((ref) => true);

  var selectedValueProvider = StateProvider<String?>((ref) => '');

  var dateProvider = StateProvider((ref) => '');

  var lockInDedicated = StateProvider((ref) => false);

  var lockInMix = StateProvider((ref) => false);

  var terminalDropDownProvider = StateProvider<Terminal?>((ref) => null);
  var commodityDropDownProvider = StateProvider<Commodite?>((ref) => null);

  List<String> get stackList => [
    AppLocalizations.of(context)!.slectstackType,
    "Mix",
    "Dedicated",
  ];

  var terminalNameProvider = StateProvider((ref) => '');
  var terminalIdProvider = StateProvider((ref) => '');
  var terminalFromDateProvider = StateProvider((ref) => '');
  var terminalToDateProvider = StateProvider((ref) => '');
  var warehouseCommodityNameProvider = StateProvider((ref) => '');
  var warehouseCommodityIdProvider = StateProvider((ref) => '');
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: ColorConstant.maingreen,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF12281B), // Deep green-black
                Color(0xFF275135), // Your main green
                Color(0xFF3E7251),
              ],
            ),
          ),
        ),
        title: Text(AppLocalizations.of(context)!.msgBookWarehouse),
      ),
      body: ListView(
        padding: Pad(all: 10),
        children: [
          Card(
            margin: Pad(all: 0),
            color: Colors.white,
            child: Padding(
              padding: Pad(all: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: Get.width,
                      height: Get.height * 0.25,
                      color: Colors.grey[200],
                      child: CachedNetworkImage(
                        imageUrl:
                            // "https://demoaws.apnagodam.com/resources/assets/upload/warehouses/${widget.terminal?.image}",
                            "https://apnagodam.com/resources/assets/upload/warehouses/${widget.terminal?.image}",
                        fit: BoxFit.cover,
                        errorWidget:
                            (context, _, __) =>
                                const Icon(Icons.warehouse, size: 40),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(text: '${widget.terminal?.name}'),
                    style: ElevarmFontFamilies.inter(
                      color: ColorConstant.maingreen,
                      fontSize: Adaptive.sp(16),
                      fontWeight: ElevarmFontWeights.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: ColorConstant.maingreen),
                      SizedBox(width: 5),
                      Text(
                        '${widget.terminal?.district}, ${widget.terminal?.state}',
                        style: TextStyle(
                          fontSize: Adaptive.sp(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      titleWidget(
                        text: AppLocalizations.of(context)!.locateOnMap,
                        callback: () {
                          MapsLauncher.createCoordinatesUri(
                            num.parse(
                              "${widget.terminal?.latitude ?? 0.0}",
                            ).toDouble(),
                            num.parse(
                              "${widget.terminal?.longitude ?? 0.0}",
                            ).toDouble(),
                          );
                        },
                        fontSize: Adaptive.sp(14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevarmDivider(
            child: Text(
              AppLocalizations.of(context)!.bookWarehouse,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Visibility(
            visible: widget.terminal != null,
            child: DropdownSearch<Commodite?>(
              compareFn: (terminal, terminal2) => terminal?.id == terminal2?.id,
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
                            "${terminal?.category}",
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
              items: (s, d) => widget.commdity ?? [],
              itemAsString: (Commodite? u) => u?.category ?? "",
              onChanged:
                  (Commodite? data) =>
                      ref.watch(commodityDropDownProvider.notifier).state =
                          data,
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
          ),
          SizedBox(height: 10),
          Visibility(
            visible: ref.watch(commodityDropDownProvider) != null,
            child: DropdownSearch<String?>(
              compareFn: (terminal, terminal2) => terminal == terminal2,
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
                    (context, terminal, isVisibl, _) => ColumnSuper(
                      alignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: Pad(all: 10),
                          child: Text(
                            "$terminal",
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
                    AppLocalizations.of(context)!.slectstackType,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Adaptive.sp(16),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                showSearchBox: false,
                searchDelay: Duration(microseconds: 500),
              ),

              // asyncItems: (String filter) => getData(filter),
              items: (s, d) => stackList,
              itemAsString: (String? u) => u ?? "",
              onChanged: (String? val) {
                ref.watch(dedicatedProvider.notifier).state =
                    val == "Dedicated";
                ref.watch(selectedValueProvider.notifier).state = val ?? "";
              },
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  contentPadding: Pad(left: 10, bottom: 5, top: 5),
                  hintText: AppLocalizations.of(context)!.slectstackType,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: ColorConstant.maingreen),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
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
          InkWell(
            onTap: () async {
              if (ref.watch(commodityDropDownProvider) == null) {
                Get.rawSnackbar(
                  message: AppLocalizations.of(context)!.selectYourCommodity,
                  duration: Duration(seconds: 2),
                  backgroundColor: ColorConstant.red500,
                );
              } else if (ref.watch(selectedValueProvider)!.isEmpty ||
                  ref.watch(selectedValueProvider) ==
                      AppLocalizations.of(context)!.slectstackType) {
                Get.rawSnackbar(
                  message: AppLocalizations.of(context)!.slectstackType,
                  duration: Duration(seconds: 2),
                  backgroundColor: ColorConstant.red500,
                );
              } else if (weightController.text.isEmpty &&
                  !ref.watch(dedicatedProvider)) {
                Get.rawSnackbar(
                  message: AppLocalizations.of(context)!.selectYourWeight,
                  duration: Duration(seconds: 2),
                  backgroundColor: ColorConstant.red500,
                );
              } else {
                Get.bottomSheet(
                  Consumer(
                    builder:
                        (context, ref, child) => ElevarmDraggableBottomSheet(
                          title: AppLocalizations.of(context)!.bookAstock,
                          onPressedClose: () => Get.back(),
                          children: [
                            ref
                                .watch(
                                  getAvailableStacksProvider(
                                    terminalid: widget.terminal?.id,
                                    commodityid:
                                        ref
                                            .watch(commodityDropDownProvider)!
                                            .id
                                            .toString(),
                                    weightreqst:
                                        ref.watch(dedicatedProvider)
                                            ? "0"
                                            : weightController.text,
                                    in_out_status: "IN",
                                    stack_type: ref.watch(
                                      selectedValueProvider,
                                    ),
                                    vehicle_no: "",
                                    driverNumber: "",
                                  ),
                                )
                                .when(
                                  data: (data) {
                                    if (data.status.toString() == "0") {
                                      return Container(
                                        height: Get.height / 2,
                                        child: noStockData(context),
                                        alignment: Alignment.center,
                                      );
                                    }
                                    return (data.data ?? []).isEmpty
                                        ? Container(child: noStockData(context))
                                        : SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height,
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: 35,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                          color:
                                                              ColorConstant
                                                                  .red500,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.yourbooked,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Roboto',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                          color:
                                                              ColorConstant
                                                                  .maingreen,
                                                        ),
                                                        height: 35,
                                                        child: Center(
                                                          child: Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!.emptystack,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Roboto',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Expanded(
                                                // height: MediaQuery.of(context).size.height*0.4,
                                                child: GridView.builder(
                                                  padding: Pad(all: 0),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        mainAxisSpacing: 0,
                                                        childAspectRatio: 3 / 4,
                                                        crossAxisSpacing: 10,
                                                      ),
                                                  itemCount:
                                                      data.data == null
                                                          ? 0
                                                          : data.data?.length,
                                                  itemBuilder:
                                                      (
                                                        context,
                                                        index,
                                                      ) => InkWell(
                                                        child: StackBookCard(
                                                          stack:
                                                              data.data![index],
                                                        ),
                                                        onTap: () {
                                                          StackbookDialog(
                                                            context,
                                                            stackNumber:
                                                                data
                                                                    .data![index]
                                                                    .stackNumber,
                                                            stackRowId:
                                                                data
                                                                    .data![index]
                                                                    .id
                                                                    .toString(),
                                                            wsaCharge:
                                                                ref.read(
                                                                      dedicatedProvider,
                                                                    )
                                                                    ? "0.0"
                                                                    : "${data.wsaCharge ?? 0}",
                                                            whRentData:
                                                                '${data.whRentData ?? 0}',
                                                            entryLoadCharge:
                                                                ref.read(
                                                                      dedicatedProvider,
                                                                    )
                                                                    ? "0.0"
                                                                    : '${data.entryLoad ?? 0}',
                                                            exitLoadCharge:
                                                                ref.read(
                                                                      dedicatedProvider,
                                                                    )
                                                                    ? "0.0"
                                                                    : '${data.exitLoad ?? 0}',
                                                            stacktype: ref.read(
                                                              selectedValueProvider,
                                                            ),
                                                            lockIn:
                                                                data.lockIn
                                                                    .toString(),
                                                            requestedWeight:
                                                                ref.watch(
                                                                      dedicatedProvider,
                                                                    )
                                                                    ? data
                                                                        .data![index]
                                                                        .stackMaxCapacity
                                                                        .toString()
                                                                    : weightController
                                                                        .text
                                                                        .toString(),
                                                            stackRequestId:
                                                                data
                                                                    .data![index]
                                                                    .stackNumber,
                                                            labourCharge:
                                                                data.labourCharge,
                                                            lockInDate:
                                                                ref
                                                                    .watch(
                                                                      dateProvider
                                                                          .notifier,
                                                                    )
                                                                    .state,
                                                            commodityId:
                                                                ref
                                                                    .watch(
                                                                      commodityDropDownProvider,
                                                                    )!
                                                                    .id
                                                                    .toString(),
                                                            warehouesName:
                                                                ref
                                                                    .watch(
                                                                      terminalDropDownProvider,
                                                                    )
                                                                    ?.name ??
                                                                "",
                                                            commodityName:
                                                                ref
                                                                    .watch(
                                                                      commodityDropDownProvider,
                                                                    )
                                                                    ?.category ??
                                                                "",
                                                            terminalId:
                                                                widget
                                                                    .terminal
                                                                    ?.id
                                                                    .toString() ??
                                                                "",
                                                          );
                                                        },
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                  },
                                  error: (e, s) => Container(),
                                  loading:
                                      () => Skeletonizer(
                                        child: stacksLoader(context),
                                      ),
                                ),
                          ],
                        ),
                  ),
                  isScrollControlled: true,
                );
              }
            },
            child: Container(
              height: 46,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstant.maingreen,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.msgSubmit,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  StackbookDialog(
    BuildContext context, {
    String? stackNumber = '',
    String? stackRowId = "",
    String? wsaCharge = "",
    String? whRentData = "",
    String? entryLoadCharge = '',
    String? exitLoadCharge = '',
    String? stacktype = '',
    String? lockIn = '',
    String? requestedWeight = '',
    String? stackRequestId = '',
    String? labourCharge = '',
    String? lockInDate = '',
    String? commodityId = '',
    String? warehouesName = "",
    String? commodityName = "",
    String? terminalId = "",
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: AlertDialog(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            titlePadding: EdgeInsets.all(10),
            insetPadding: EdgeInsets.zero,
            title: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.msgConditions,
                        style: TextStyle(fontSize: 17, fontFamily: 'Roboto'),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 18,
                          color: ColorConstant.maingreen,
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 1),
                  Container(
                    color: Colors.white,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Table(
                              columnWidths: {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(4),
                              },
                              border: TableBorder.all(color: Colors.black),
                              children: [
                                TableRow(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 10.0,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.srnumber,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 10.0,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.conditions,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        'किराये की गणना दैनिक होगी | डेडिकेटेड स्टैक होने पर पुरे स्टैक का किराया पहले दिन से चालू होगा |',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstant.maingreen,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          "2",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        'फुमिगशन और इन्शुरन्स किराये में शामिल है, ख़राब माल आने पर 20 ₹ प्रति क्विन्टल फ्यूमिगेशन चार्ज लागु होगा |',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstant.maingreen,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          "3",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        '⁠यदि कमोडिटी मूल्य 50 रुपये किलो से ऊपर है तो इन्शुरन्स चार्ज अलग से देना होगा |',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstant.maingreen,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          "4",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        'किराया और ब्याज हर महीने की 5 तारीख से पहले देना होगा |',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstant.maingreen,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          "5",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        'किसी भी प्रकार की बकाया राशि होने पर माल रिलीज़ नहीं किया जायेगा |',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstant.maingreen,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Center(
                                        child: Text(
                                          "6",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        'लेबर की व्यवस्था क्लाइंट के कहने पर की गयी है | लेबर लेट आने और जल्दी जाने एवं लेबर के कारण गाड़ी  वेयरहाउस पर खड़े रहने की कंडीशन में वेयरहाउस की कोई जिम्मेदारी नहीं होगी |',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstant.maingreen,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => RateCard(
                                    stackNumber: stackNumber,
                                    stackRowId: stackRowId.toString(),
                                    wsaCharge: wsaCharge,
                                    whRentData: whRentData,
                                    entryLoadCharge: entryLoadCharge,
                                    exitLoadCharge: exitLoadCharge,
                                    stacktype: stacktype,
                                    lockIn: lockIn,
                                    requestedWeight: requestedWeight,
                                    stackRequestId: stackRequestId,
                                    labourCharge: labourCharge,
                                    lockInDate: lockInDate,
                                    commodityId: commodityId,
                                    warehouesName: warehouesName,
                                    commodityName: commodityName,
                                    terminalId: terminalId,
                                  ),
                                );
                                // Get.to(() => WarehouseTab());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    right: 20,
                                    left: 20,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.msgOk,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
