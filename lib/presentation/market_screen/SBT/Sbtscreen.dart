import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/printer_helper.dart';
import 'package:apnagodam/core/utils/printer_state.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/add_money_screen/add_money_screen.dart';
import 'package:apnagodam/presentation/credit/credit_screen.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/home_screen/ui/Tradewalletscreen.dart';
import 'package:apnagodam/presentation/market_screen/buy_sell_data_screen.dart';
import 'package:apnagodam/presentation/market_screen/buyer_list_screen.dart';
import 'package:apnagodam/presentation/market_screen/seller_list_screen.dart';
import 'package:apnagodam/presentation/market_screen/service/market_service.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/sbt/SbtDeals.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackinward_screen.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:apnagodam/widgets/enums.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:apnagodam/presentation/sbt/DispatchRequests/FactoryDispatchScreen.dart';
import 'package:apnagodam/presentation/sbt/DispatchRequests/DispatchRequestsListing.dart';
import 'package:apnagodam/presentation/sbt/service/SbtService.dart'
    hide matchedOrdersProvider;
import 'package:apnagodam/presentation/sbt/service/model/MatchOrderPrintModel.dart';
import 'package:apnagodam/presentation/sbt/widgets/HtmlViewerScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:thermal_printer/esc_pos_utils_platform/src/enums.dart';
import 'package:thermal_printer/thermal_printer.dart';

import '../../../core/constants/constants.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Sbtscreen extends ConsumerStatefulWidget {
  const Sbtscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SbtscreenState();
}

class _SbtscreenState extends ConsumerState<Sbtscreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  late double _buyPrice;
  late TextEditingController buyPriceController;
  late TextEditingController sellPriceController;
  late TextEditingController buyWeightController;
  late TextEditingController sellWeightController;

  final buyKey = GlobalKey<FormState>();
  final sellKey = GlobalKey<FormState>();

  final buyWeight = StateProvider<double>((ref) => 0.0);
  final sellWeight = StateProvider<double>((ref) => 0.0);
  final selectedIndex = StateProvider<int?>((ref) => null);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    buyPriceController = TextEditingController();
    sellPriceController = TextEditingController();
    buyWeightController = TextEditingController();
    sellWeightController = TextEditingController();
    _buyPrice = 0.0;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    buyPriceController.dispose();
    sellPriceController.dispose();
    buyWeightController.dispose();
    sellWeightController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // App returned to foreground (unlock or similar) -> refresh data
      refreshAllData();
    }
  }

  /// Invalidate/refresh providers used by this screen. Add other providers
  /// here if you want them refreshed on unlock/resume.
  void refreshAllData() {
    try {
      // Primary provider for the SBT list
      ref.invalidate(getSbtCommodityProvider);

      // Invalidate other commonly-used providers on this screen if needed.
      ref.invalidate(matchedOrdersProvider);

      // Force a rebuild so UI updates immediately
      setState(() {});
    } catch (e, st) {
      // Swallow errors but log if needed
      debugPrint('Error refreshing data on resume: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final commodityProvider = ref.watch(getSbtCommodityProvider);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10), // Increased padding
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: TabBar(
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                      fontSize: Adaptive.sp(17),
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelColor: Colors.black87,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstant.maingreen,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.maingreen.withOpacity(0.18),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          l10n.trading,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          l10n.deliveryMarking,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  commodityProvider.when(
                    data: (data) {
                      final dataList = data.data ?? [];
                      return dataList.isEmpty
                          ? Center(child: noStockData())
                          : ListView.builder(
                              cacheExtent: 1000,
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: true,
                              itemCount: dataList.length,
                              itemBuilder:
                                  (BuildContext context, int mainIndex) {
                                final item = dataList[mainIndex];
                                final typeColor = _sbtTypeColor(
                                  item.sbtType?.toString(),
                                );
                                final bestBuyer =
                                    currencyFormat.format(item.bestBuyer ?? 0);
                                final bestSeller = currencyFormat.format(
                                  item.bestSeller
                                      .toString()
                                      .convertToDouble(defaultValue: 0.00),
                                );

                                return Card(
                                  elevation: 2,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: typeColor,
                                      width: 2,
                                    ),
                                  ),
                                  margin: const EdgeInsets.all(10),
                                  surfaceTintColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Title with district
                                        Text.rich(
                                          TextSpan(
                                            text: "${item.commodity} ",
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(19),
                                              fontWeight: FontWeight.w700,
                                              color: typeColor,
                                            ),
                                            children: [],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 12),
                                        Text.rich(
                                          TextSpan(
                                            text: "${item.district}",
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(17),
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12),

                                        // Buyer/Seller best prices
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _buildPriceRow(
                                              label: l10n.msgBuyerBest,
                                              value: bestBuyer,
                                            ),
                                            _buildPriceRow(
                                              label: l10n.msgSellerBest,
                                              value: bestSeller,
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 10),

                                        // Tap for details + Icon and Label
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 8),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: ColorConstant.bgcolor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: Adaptive.sp(16),
                                                color: ColorConstant.maingreen,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                l10n.bidTime,
                                                style: TextStyle(
                                                  fontSize: Adaptive.sp(15),
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              Text(
                                                ': ',
                                                style: TextStyle(
                                                  fontSize: Adaptive.sp(15),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                item.date ?? '',
                                                style: TextStyle(
                                                  fontSize: Adaptive.sp(15),
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: ColorConstant.bgcolor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.currency_rupee,
                                                size: Adaptive.sp(16),
                                                color: ColorConstant.maingreen,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                l10n.lastTradePrice,
                                                style: TextStyle(
                                                  fontSize: Adaptive.sp(15),
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              Text(
                                                ': ',
                                                style: TextStyle(
                                                  fontSize: Adaptive.sp(15),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                '₹${item.ltp ?? ''}',
                                                style: TextStyle(
                                                  fontSize: Adaptive.sp(16),
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width,
                                          child: ElevatedButton(
                                            style: AppStyle.buttonStyle,
                                            child: Text(
                                              l10n.order,
                                              style: TextStyle(
                                                fontSize: Adaptive.sp(18),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (ref
                                                      .watch(authProvider)
                                                      .value ==
                                                  AuthStatus.loggedIn) {
                                                ref.watch(userDetailsProvider);
                                              }

                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                useSafeArea: true,
                                                builder: (
                                                  sheetContext,
                                                ) =>
                                                    Consumer(
                                                  builder: (
                                                    context,
                                                    ref,
                                                    child,
                                                  ) =>
                                                      ElevarmBottomSheet(
                                                    initialChildSize: 1,
                                                    title:
                                                        '${dataList[mainIndex].commodity} - ${dataList[mainIndex].district.toString()} ',
                                                    onPressedClose: () {
                                                      Navigator.of(
                                                        sheetContext,
                                                      ).pop();
                                                    },
                                                    children: [
                                                      // Text(
                                                      //   '${AppLocalizations.of(context)!.msgBuyerBest}  ${currencyFormat.format(dataList[mainIndex].bestBuyer.toString().convertToDouble(defaultValue: 0.00))}   ${AppLocalizations.of(context)!.msgSellerBest} ${currencyFormat.format(dataList[mainIndex].bestSeller.toString().convertToDouble(defaultValue: 0.00))}',
                                                      // ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  FinanceTypeParent?
                                                                      financeType;
                                                                  FinanceTypeChild?
                                                                      financeTypeChild;
                                                                  if (ref
                                                                          .watch(
                                                                            authProvider,
                                                                          )
                                                                          .value ==
                                                                      AuthStatus
                                                                          .loggedIn) {
                                                                    _buyPrice =
                                                                        double
                                                                            .parse(
                                                                      '${dataList[mainIndex].lowerCircuit ?? 0.0}',
                                                                    );

                                                                    ref
                                                                        .watch(
                                                                          buyWeight
                                                                              .notifier,
                                                                        )
                                                                        .state = 0.0;

                                                                    buyPriceController
                                                                        .clear();
                                                                    buyWeightController
                                                                        .clear();

                                                                    showBarModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.vertical(
                                                                          top: Radius
                                                                              .circular(
                                                                            10.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      builder: (
                                                                        bottomsheetContext,
                                                                      ) {
                                                                        return Consumer(
                                                                          builder: (
                                                                            context,
                                                                            ref,
                                                                            child,
                                                                          ) =>
                                                                              Scaffold(
                                                                            resizeToAvoidBottomInset:
                                                                                false,
                                                                            body:
                                                                                Form(
                                                                              key: buyKey,
                                                                              child: Padding(
                                                                                padding: Pad(
                                                                                  bottom: 20,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: Pad(
                                                                                    all: 10,
                                                                                  ),
                                                                                  child: SingleChildScrollView(
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsets.only(
                                                                                            top: 12.0,
                                                                                            bottom: 7.0,
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              AppLocalizations.of(
                                                                                                context,
                                                                                              )!
                                                                                                  .msgBuy,
                                                                                              style: TextStyle(
                                                                                                fontSize: Adaptive.sp(
                                                                                                  18,
                                                                                                ),
                                                                                                fontWeight: FontWeight.bold,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Divider(
                                                                                          thickness: 1,
                                                                                        ),
                                                                                        Center(
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(
                                                                                              bottom: 8.0,
                                                                                            ),
                                                                                            child: Text.rich(
                                                                                              TextSpan(
                                                                                                text: AppLocalizations.of(
                                                                                                  context,
                                                                                                )!
                                                                                                    .product,
                                                                                                style: TextStyle(
                                                                                                  fontSize: Adaptive.sp(
                                                                                                    16,
                                                                                                  ),
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                ),
                                                                                                children: [
                                                                                                  TextSpan(
                                                                                                    text: " : ${data.data != null ? data.data![mainIndex].commodity : ''} (${data.data != null ? data.data![mainIndex].district : ''})",
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        RowSuper(
                                                                                          fill: true,
                                                                                          children: [
                                                                                            // Text.rich(TextSpan(
                                                                                            //     text: "Commodity: ",
                                                                                            //     style: TextStyle(
                                                                                            //         fontSize:
                                                                                            //             Adaptive.sp(
                                                                                            //                 16),
                                                                                            //         fontWeight:
                                                                                            //             FontWeight
                                                                                            //                 .bold),
                                                                                            //     children: [
                                                                                            //       TextSpan(
                                                                                            //           text:
                                                                                            //               "${widget.dataList?[widget.index ?? 0].commodity}",
                                                                                            //           style: TextStyle(
                                                                                            //               fontSize:
                                                                                            //                   Adaptive.sp(
                                                                                            //                       16),
                                                                                            //               fontFamily:
                                                                                            //                   'Roboto',
                                                                                            //               color: ColorConstant
                                                                                            //                   .maingreen,
                                                                                            //               fontWeight:
                                                                                            //                   FontWeight
                                                                                            //                       .bold))
                                                                                            //     ])),
                                                                                            // Text.rich(
                                                                                            //   TextSpan(
                                                                                            //     text:
                                                                                            //         "Date: ",
                                                                                            //     style: TextStyle(
                                                                                            //       fontSize: Adaptive.sp(
                                                                                            //         16,
                                                                                            //       ),
                                                                                            //       fontFamily:
                                                                                            //           'Roboto',
                                                                                            //       fontWeight:
                                                                                            //           FontWeight.bold,
                                                                                            //     ),
                                                                                            //     children: [
                                                                                            //       TextSpan(
                                                                                            //         text:
                                                                                            //             "${dataList[mainIndex].date}",
                                                                                            //         style: TextStyle(
                                                                                            //           fontSize: Adaptive.sp(
                                                                                            //             16,
                                                                                            //           ),
                                                                                            //           fontFamily:
                                                                                            //               'Roboto',
                                                                                            //           color:
                                                                                            //               ColorConstant.maingreen,
                                                                                            //           fontWeight:
                                                                                            //               FontWeight.bold,
                                                                                            //         ),
                                                                                            //       ),
                                                                                            //     ],
                                                                                            //   ),
                                                                                            // ),
                                                                                          ],
                                                                                        ),
                                                                                        Divider(),
                                                                                        SizedBox(
                                                                                          height: 15,
                                                                                        ),
                                                                                        Column(
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsets.only(
                                                                                                bottom: 5.0,
                                                                                              ),
                                                                                              child: Text(
                                                                                                AppLocalizations.of(
                                                                                                  context,
                                                                                                )!
                                                                                                    .msgYourprice,
                                                                                                style: TextStyle(
                                                                                                  fontSize: Adaptive.sp(
                                                                                                    16,
                                                                                                  ),
                                                                                                  fontFamily: 'Roboto',
                                                                                                  color: ColorConstant.maingreen,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: Pad(
                                                                                                all: 10,
                                                                                              ),
                                                                                              child: SizedBox(
                                                                                                width: Get.width,
                                                                                                child: CommonTextField(
                                                                                                  controller: buyPriceController,
                                                                                                  inputType: TextInputType.numberWithOptions(
                                                                                                    decimal: true,
                                                                                                  ),
                                                                                                  hintText: '0',
                                                                                                  label: AppLocalizations.of(
                                                                                                    context,
                                                                                                  )!
                                                                                                      .enterBuyPrice,
                                                                                                  onEditComplete: (
                                                                                                    value,
                                                                                                  ) {
                                                                                                    debouncer.call(
                                                                                                      () {
                                                                                                        setState(
                                                                                                          () {
                                                                                                            _buyPrice = double.tryParse(
                                                                                                                  value,
                                                                                                                ) ??
                                                                                                                0.0;
                                                                                                          },
                                                                                                        );
                                                                                                      },
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Column(
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsets.only(
                                                                                                    bottom: 5.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    AppLocalizations.of(
                                                                                                      context,
                                                                                                    )!
                                                                                                        .msgNetweight,
                                                                                                    style: TextStyle(
                                                                                                      fontSize: Adaptive.sp(
                                                                                                        16,
                                                                                                      ),
                                                                                                      fontFamily: 'Roboto',
                                                                                                      color: ColorConstant.maingreen,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: Pad(
                                                                                                    all: 10,
                                                                                                  ),
                                                                                                  child: SizedBox(
                                                                                                    width: Get.width,
                                                                                                    child: CommonTextField(
                                                                                                      controller: buyWeightController,
                                                                                                      inputType: TextInputType.numberWithOptions(
                                                                                                        decimal: true,
                                                                                                      ),
                                                                                                      label: AppLocalizations.of(
                                                                                                        context,
                                                                                                      )!
                                                                                                          .enterWeight,
                                                                                                      hintText: '0.0',
                                                                                                      onEditComplete: (
                                                                                                        value,
                                                                                                      ) {
                                                                                                        ref
                                                                                                            .watch(
                                                                                                              buyWeight.notifier,
                                                                                                            )
                                                                                                            .state = double
                                                                                                                .tryParse(
                                                                                                              value,
                                                                                                            ) ??
                                                                                                            0.0;
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                if (item.sbtType.toString() == "1") ...[
                                                                                                  titleWidget(text: 'Select Finance Type'),
                                                                                                  if (ref.watch(sharedUtilityProvider).getUser()?.isParent.toString() == "1")
                                                                                                    DropdownSearch<FinanceTypeParent?>(
                                                                                                      compareFn: (item1, item2) => item1?.type == item2?.type,
                                                                                                      popupProps: PopupProps.menu(
                                                                                                        searchFieldProps: TextFieldProps(
                                                                                                          autofocus: true,
                                                                                                          cursorColor: ColorConstant.maingreen,
                                                                                                          padding: Pad(
                                                                                                            left: 10,
                                                                                                            right: 10,
                                                                                                          ),
                                                                                                          decoration: InputDecoration(
                                                                                                            contentPadding: Pad(
                                                                                                              left: 10,
                                                                                                              right: 10,
                                                                                                            ),
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
                                                                                                            side: BorderSide(
                                                                                                              color: ColorConstant.maingreen,
                                                                                                            ),
                                                                                                            borderRadius: BorderRadius.circular(
                                                                                                              8,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        itemBuilder: (
                                                                                                          context,
                                                                                                          terminal,
                                                                                                          isVisible,
                                                                                                          _,
                                                                                                        ) =>
                                                                                                            ColumnSuper(
                                                                                                          alignment: Alignment.centerLeft,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: Pad(
                                                                                                                all: 10,
                                                                                                              ),
                                                                                                              child: Text(
                                                                                                                "${terminal?.label}",
                                                                                                                style: TextStyle(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontSize: Adaptive.sp(
                                                                                                                    16,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              height: 1,
                                                                                                              color: Colors.grey.withOpacity(
                                                                                                                0.3,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        title: Padding(
                                                                                                          padding: Pad(all: 10),
                                                                                                          child: Text(
                                                                                                            AppLocalizations.of(
                                                                                                              context,
                                                                                                            )!
                                                                                                                .selectFinanceType3,
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: TextStyle(
                                                                                                              fontSize: Adaptive.sp(16),
                                                                                                              fontWeight: FontWeight.w700,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        showSearchBox: false,
                                                                                                        searchDelay: Duration(
                                                                                                          microseconds: 500,
                                                                                                        ),
                                                                                                      ),

                                                                                                      // asyncItems: (String filter) => getData(filter),
                                                                                                      items: (s, k) => FinanceTypeParent.values,
                                                                                                      itemAsString: (FinanceTypeParent? u) => u?.label ?? "",
                                                                                                      validator: (value) {
                                                                                                        if (value == null) {
                                                                                                          return AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!
                                                                                                              .selectFinanceType3;
                                                                                                        }
                                                                                                        return null;
                                                                                                      },
                                                                                                      onChanged: (FinanceTypeParent? data) => financeType = data,
                                                                                                      decoratorProps: DropDownDecoratorProps(
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: Pad(
                                                                                                            left: 10,
                                                                                                            bottom: 5,
                                                                                                            top: 5,
                                                                                                          ),
                                                                                                          hintText: AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!
                                                                                                              .selectFinanceType3,
                                                                                                          border: OutlineInputBorder(
                                                                                                            borderRadius: BorderRadius.all(
                                                                                                              Radius.circular(
                                                                                                                8,
                                                                                                              ),
                                                                                                            ),
                                                                                                            borderSide: BorderSide(
                                                                                                              color: ColorConstant.maingreen,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  else
                                                                                                    DropdownSearch<FinanceTypeChild?>(
                                                                                                      compareFn: (item1, item2) => item1?.type == item2?.type,
                                                                                                      popupProps: PopupProps.menu(
                                                                                                        searchFieldProps: TextFieldProps(
                                                                                                          autofocus: true,
                                                                                                          cursorColor: ColorConstant.maingreen,
                                                                                                          padding: Pad(
                                                                                                            left: 10,
                                                                                                            right: 10,
                                                                                                          ),
                                                                                                          decoration: InputDecoration(
                                                                                                            contentPadding: Pad(
                                                                                                              left: 10,
                                                                                                              right: 10,
                                                                                                            ),
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
                                                                                                            side: BorderSide(
                                                                                                              color: ColorConstant.maingreen,
                                                                                                            ),
                                                                                                            borderRadius: BorderRadius.circular(
                                                                                                              8,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        itemBuilder: (
                                                                                                          context,
                                                                                                          terminal,
                                                                                                          isVisible,
                                                                                                          _,
                                                                                                        ) =>
                                                                                                            ColumnSuper(
                                                                                                          alignment: Alignment.centerLeft,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: Pad(
                                                                                                                all: 10,
                                                                                                              ),
                                                                                                              child: Text(
                                                                                                                "${terminal?.label}",
                                                                                                                style: TextStyle(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontSize: Adaptive.sp(
                                                                                                                    16,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              height: 1,
                                                                                                              color: Colors.grey.withOpacity(
                                                                                                                0.3,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        title: Padding(
                                                                                                          padding: Pad(all: 10),
                                                                                                          child: Text(
                                                                                                            AppLocalizations.of(
                                                                                                              context,
                                                                                                            )!
                                                                                                                .selectFinanceType3,
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: TextStyle(
                                                                                                              fontSize: Adaptive.sp(16),
                                                                                                              fontWeight: FontWeight.w700,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        showSearchBox: false,
                                                                                                        searchDelay: Duration(
                                                                                                          microseconds: 500,
                                                                                                        ),
                                                                                                      ),

                                                                                                      // asyncItems: (String filter) => getData(filter),
                                                                                                      items: (s, k) => FinanceTypeChild.values,
                                                                                                      itemAsString: (FinanceTypeChild? u) => u?.label ?? "",
                                                                                                      validator: (value) {
                                                                                                        if (value == null) {
                                                                                                          return AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!
                                                                                                              .selectFinanceType3;
                                                                                                        }
                                                                                                        return null;
                                                                                                      },
                                                                                                      onChanged: (FinanceTypeChild? data) => financeTypeChild = data,
                                                                                                      decoratorProps: DropDownDecoratorProps(
                                                                                                        decoration: InputDecoration(
                                                                                                          contentPadding: Pad(
                                                                                                            left: 10,
                                                                                                            bottom: 5,
                                                                                                            top: 5,
                                                                                                          ),
                                                                                                          hintText: AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!
                                                                                                              .selectFinanceType3,
                                                                                                          border: OutlineInputBorder(
                                                                                                            borderRadius: BorderRadius.all(
                                                                                                              Radius.circular(
                                                                                                                8,
                                                                                                              ),
                                                                                                            ),
                                                                                                            borderSide: BorderSide(
                                                                                                              color: ColorConstant.maingreen,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                ]
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 15,
                                                                                        ),
                                                                                        ref
                                                                                            .watch(
                                                                                              sbtTermsProvider(
                                                                                                userType: "1",
                                                                                                productId: "${dataList[mainIndex].productId}",
                                                                                              ),
                                                                                            )
                                                                                            .when(
                                                                                              data: (
                                                                                                data,
                                                                                              ) =>
                                                                                                  HtmlWidget(
                                                                                                data['data'] ?? "",
                                                                                              ),
                                                                                              error: (
                                                                                                e,
                                                                                                s,
                                                                                              ) =>
                                                                                                  Container(),
                                                                                              loading: () => Center(
                                                                                                child: CircularProgressIndicator(),
                                                                                              ),
                                                                                            ),
                                                                                        Padding(
                                                                                          padding: EdgeInsets.only(
                                                                                            top: 15,
                                                                                          ),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: ElevatedButton(
                                                                                                  style: AppStyle.buttonStyle.copyWith(
                                                                                                    backgroundColor: WidgetStatePropertyAll(
                                                                                                      Colors.red,
                                                                                                    ),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Get.back();
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    AppLocalizations.of(
                                                                                                      context,
                                                                                                    )!
                                                                                                        .msgCencel,
                                                                                                    style: TextStyle(
                                                                                                      fontSize: Adaptive.sp(
                                                                                                        18,
                                                                                                      ),
                                                                                                      fontFamily: 'Roboto',
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 20,
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: ElevatedButton(
                                                                                                  style: AppStyle.buttonStyle,
                                                                                                  onPressed: () async {
                                                                                                    if (_buyPrice < 1) {
                                                                                                      context.errorToast(
                                                                                                        'Please input valid buying price',
                                                                                                      );
                                                                                                    } else {
                                                                                                      if (ref.watch(
                                                                                                            buyWeight,
                                                                                                          ) >
                                                                                                          0.0) {
                                                                                                        if (buyKey.currentState!.validate()) {
                                                                                                          if (item.sbtType.toString() == "1") {
                                                                                                            if (ref.watch(sharedUtilityProvider).getUser()?.isParent.toString() == "1") {
                                                                                                              if (financeType == null) {
                                                                                                                context.errorToast(
                                                                                                                  'Please select finance type',
                                                                                                                );
                                                                                                                return;
                                                                                                              } else if ((financeType!.type == 3 || financeType!.type == 2)) {
                                                                                                                ref.watch(dioProvider).post("/user_api/get_schemes_data", queryParameters: {
                                                                                                                  "product_id": "${dataList[mainIndex].productId}"
                                                                                                                }).then((value) {
                                                                                                                  if ((value.data['data'] as List).isNotEmpty) {
                                                                                                                    ref.invalidate(selectedIndex);
                                                                                                                    _schemesWidget(value.data, dataList[mainIndex].productId, dataList[mainIndex].commodityId, dataList[mainIndex].districtId, financeType?.type);
                                                                                                                  } else {
                                                                                                                    context.errorToast(
                                                                                                                      'No Schemes found',
                                                                                                                    );
                                                                                                                  }
                                                                                                                }).onError((e, s) {
                                                                                                                  context.errorToast(
                                                                                                                    'Failed to fetch schemes',
                                                                                                                  );
                                                                                                                });
                                                                                                              } else {
                                                                                                                _handleBuyOption(
                                                                                                                  dataList,
                                                                                                                  mainIndex,
                                                                                                                  bottomsheetContext,
                                                                                                                  ref.watch(
                                                                                                                    buyWeight,
                                                                                                                  ),
                                                                                                                  _buyPrice,
                                                                                                                );
                                                                                                              }
                                                                                                            } else {
                                                                                                              if (financeTypeChild == null) {
                                                                                                                context.errorToast(
                                                                                                                  'Please select finance type',
                                                                                                                );
                                                                                                                return;
                                                                                                              } else if ((financeTypeChild!.type == 2)) {
                                                                                                                ref.watch(dioProvider).post("/user_api/get_schemes_data", queryParameters: {
                                                                                                                  "product_id": "${dataList[mainIndex].productId}"
                                                                                                                }).then((value) {
                                                                                                                  if ((value.data['data'] as List).isNotEmpty) {
                                                                                                                    ref.invalidate(selectedIndex);

                                                                                                                    _schemesWidget(value.data, dataList[mainIndex].productId, dataList[mainIndex].commodityId, dataList[mainIndex].districtId, financeTypeChild?.type);
                                                                                                                  } else {
                                                                                                                    context.errorToast(
                                                                                                                      'No Schemes found',
                                                                                                                    );
                                                                                                                  }
                                                                                                                }).onError((e, s) {
                                                                                                                  context.errorToast(
                                                                                                                    'Failed to fetch schemes',
                                                                                                                  );
                                                                                                                });
                                                                                                              } else {
                                                                                                                _handleBuyOption(
                                                                                                                  dataList,
                                                                                                                  mainIndex,
                                                                                                                  bottomsheetContext,
                                                                                                                  ref.watch(
                                                                                                                    buyWeight,
                                                                                                                  ),
                                                                                                                  _buyPrice,
                                                                                                                );
                                                                                                              }
                                                                                                            }
                                                                                                          } else {
                                                                                                            _handleBuyOption(
                                                                                                              dataList,
                                                                                                              mainIndex,
                                                                                                              bottomsheetContext,
                                                                                                              ref.watch(
                                                                                                                buyWeight,
                                                                                                              ),
                                                                                                              _buyPrice,
                                                                                                            );
                                                                                                          }
                                                                                                        }
                                                                                                      } else {
                                                                                                        Fluttertoast.showToast(
                                                                                                          msg: 'Quantity should be greater than 0!',
                                                                                                          toastLength: Toast.LENGTH_LONG,
                                                                                                          backgroundColor: Colors.red,
                                                                                                        );
                                                                                                      }
                                                                                                    }
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    AppLocalizations.of(
                                                                                                      context,
                                                                                                    )!
                                                                                                        .msgSubmit,
                                                                                                    style: TextStyle(
                                                                                                      fontSize: Adaptive.sp(
                                                                                                        18,
                                                                                                      ),
                                                                                                      fontFamily: 'Roboto',
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).onError(
                                                                      (
                                                                        e,
                                                                        s,
                                                                      ) {},
                                                                    );
                                                                  } else {
                                                                    showLoginBottomsheet(
                                                                      context,
                                                                    );
                                                                  }
                                                                  // final result =
                                                                  //     await Get.to(
                                                                  //         Sbtdailog(
                                                                  //   coomodityId:
                                                                  //       "${data.data![index].commodity}",
                                                                  //   type: type,
                                                                  //   tagg: "",
                                                                  // ));
                                                                  // if (result !=
                                                                  //     null) {
                                                                  //   if (result) {
                                                                  //     Navigator.pop(
                                                                  //         context);
                                                                  //     ref.invalidate(
                                                                  //         getSbtCommodityProvider);
                                                                  //     ref.invalidate(
                                                                  //         getBuyerSellerListProvider);
                                                                  //   }
                                                                  // }
                                                                },
                                                                style: AppStyle
                                                                    .buttonStyle
                                                                    .copyWith(
                                                                  backgroundColor:
                                                                      WidgetStateProperty
                                                                          .resolveWith(
                                                                    (
                                                                      states,
                                                                    ) =>
                                                                        ColorConstant
                                                                            .maingreen,
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .msgBuy,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  sellPriceController
                                                                      .clear();
                                                                  sellWeightController
                                                                      .clear();
                                                                  ref
                                                                          .watch(
                                                                            sellWeight.notifier,
                                                                          )
                                                                          .state =
                                                                      0.0;
                                                                  if (ref
                                                                          .watch(
                                                                            authProvider,
                                                                          )
                                                                          .value ==
                                                                      AuthStatus
                                                                          .loggedIn) {
                                                                    showBarModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.vertical(
                                                                          top: Radius
                                                                              .circular(
                                                                            10.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      builder: (
                                                                        context,
                                                                      ) {
                                                                        return Consumer(
                                                                          builder:
                                                                              (
                                                                            context,
                                                                            ref,
                                                                            _,
                                                                          ) {
                                                                            return Padding(
                                                                              padding: EdgeInsets.only(
                                                                                bottom: MediaQuery.of(
                                                                                  context,
                                                                                ).viewInsets.bottom,
                                                                              ),
                                                                              child: SingleChildScrollView(
                                                                                child: Form(
                                                                                  key: sellKey,
                                                                                  child: Padding(
                                                                                    padding: Pad(
                                                                                      bottom: 20,
                                                                                    ),
                                                                                    child: SingleChildScrollView(
                                                                                      padding: EdgeInsetsDirectional.only(
                                                                                        start: 20,
                                                                                        end: 20,
                                                                                        bottom: 30,
                                                                                        top: 8,
                                                                                      ),
                                                                                      child: Wrap(
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(
                                                                                              top: 12.0,
                                                                                              bottom: 7.0,
                                                                                            ),
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                AppLocalizations.of(
                                                                                                  context,
                                                                                                )!
                                                                                                    .msgSell,
                                                                                                style: TextStyle(
                                                                                                  fontSize: Adaptive.sp(
                                                                                                    18,
                                                                                                  ),
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Divider(
                                                                                            thickness: 1,
                                                                                          ),
                                                                                          Center(
                                                                                            child: Padding(
                                                                                              padding: EdgeInsets.only(
                                                                                                bottom: 8.0,
                                                                                              ),
                                                                                              child: Text.rich(
                                                                                                TextSpan(
                                                                                                  text: AppLocalizations.of(
                                                                                                    context,
                                                                                                  )!
                                                                                                      .product,
                                                                                                  style: TextStyle(
                                                                                                    fontSize: Adaptive.sp(
                                                                                                      16,
                                                                                                    ),
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                  ),
                                                                                                  children: [
                                                                                                    TextSpan(
                                                                                                      text: " : ${dataList[mainIndex].commodity} (${dataList[mainIndex].district})",
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 10,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          RowSuper(
                                                                                            fill: true,
                                                                                            children: [
                                                                                              // Text.rich(TextSpan(
                                                                                              //     text: "Commodity: ",
                                                                                              //     style: TextStyle(
                                                                                              //         fontSize:
                                                                                              //             Adaptive.sp(16),
                                                                                              //
                                                                                              //         fontWeight:
                                                                                              //             FontWeight.bold),
                                                                                              //     children: [
                                                                                              //       TextSpan(
                                                                                              //           text:
                                                                                              //               "${widget.dataList?[widget.index ?? 0].commodity}",
                                                                                              //           style: TextStyle(
                                                                                              //               fontSize:
                                                                                              //                   Adaptive.sp(
                                                                                              //                       16),
                                                                                              //               fontFamily:
                                                                                              //                   'Roboto',
                                                                                              //               color: ColorConstant
                                                                                              //                   .maingreen,
                                                                                              //               fontWeight:
                                                                                              //                   FontWeight
                                                                                              //                       .bold))
                                                                                              //     ])),
                                                                                              // Text.rich(
                                                                                              //   TextSpan(
                                                                                              //     text:
                                                                                              //         AppLocalizations.of(
                                                                                              //           context,
                                                                                              //         )!.msgDate,
                                                                                              //     style: TextStyle(
                                                                                              //       fontSize: Adaptive.sp(
                                                                                              //         16,
                                                                                              //       ),
                                                                                              //       fontWeight:
                                                                                              //           FontWeight.bold,
                                                                                              //     ),
                                                                                              //     children: [
                                                                                              //       TextSpan(
                                                                                              //         text:
                                                                                              //             "${dataList[mainIndex].date}",
                                                                                              //         style: TextStyle(
                                                                                              //           fontSize: Adaptive.sp(
                                                                                              //             16,
                                                                                              //           ),
                                                                                              //           fontFamily:
                                                                                              //               'Roboto',
                                                                                              //           color:
                                                                                              //               ColorConstant.maingreen,
                                                                                              //           fontWeight:
                                                                                              //               FontWeight.bold,
                                                                                              //         ),
                                                                                              //       ),
                                                                                              //     ],
                                                                                              //   ),
                                                                                              // ),
                                                                                            ],
                                                                                          ),
                                                                                          Divider(),
                                                                                          Column(
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: EdgeInsets.only(
                                                                                                  bottom: 5.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  AppLocalizations.of(
                                                                                                    context,
                                                                                                  )!
                                                                                                      .msgYourprice,
                                                                                                  style: TextStyle(
                                                                                                    fontSize: Adaptive.sp(
                                                                                                      16,
                                                                                                    ),
                                                                                                    fontFamily: 'Roboto',
                                                                                                    color: ColorConstant.maingreen,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: Pad(
                                                                                                  all: 10,
                                                                                                ),
                                                                                                child: SizedBox(
                                                                                                  width: Get.width,
                                                                                                  child: CommonTextField(
                                                                                                    controller: sellPriceController,
                                                                                                    inputType: TextInputType.numberWithOptions(
                                                                                                      decimal: true,
                                                                                                    ),
                                                                                                    label: AppLocalizations.of(
                                                                                                      context,
                                                                                                    )!
                                                                                                        .enterSellPrice,
                                                                                                    hintText: '0',
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 10,
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsets.only(
                                                                                                  bottom: 5.0,
                                                                                                ),
                                                                                                child: Text(
                                                                                                  AppLocalizations.of(
                                                                                                    context,
                                                                                                  )!
                                                                                                      .msgNetweight,
                                                                                                  style: TextStyle(
                                                                                                    fontSize: Adaptive.sp(
                                                                                                      16,
                                                                                                    ),
                                                                                                    fontFamily: 'Roboto',
                                                                                                    color: ColorConstant.maingreen,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: Pad(
                                                                                                  all: 10,
                                                                                                ),
                                                                                                child: SizedBox(
                                                                                                  width: Get.width,
                                                                                                  child: CommonTextField(
                                                                                                    controller: sellWeightController,
                                                                                                    inputType: TextInputType.numberWithOptions(
                                                                                                      decimal: true,
                                                                                                    ),
                                                                                                    label: AppLocalizations.of(
                                                                                                      context,
                                                                                                    )!
                                                                                                        .enterWeight,
                                                                                                    hintText: '0.0',
                                                                                                    onEditComplete: (
                                                                                                      value,
                                                                                                    ) {
                                                                                                      debouncer.call(
                                                                                                        () {
                                                                                                          ref
                                                                                                              .watch(
                                                                                                                sellWeight.notifier,
                                                                                                              )
                                                                                                              .state = double
                                                                                                                  .tryParse(
                                                                                                                value,
                                                                                                              ) ??
                                                                                                              0.0;
                                                                                                        },
                                                                                                      );
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 15,
                                                                                          ),
                                                                                          ref
                                                                                              .watch(
                                                                                                sbtTermsProvider(
                                                                                                  userType: "2",
                                                                                                  productId: "${dataList[mainIndex].productId}",
                                                                                                ),
                                                                                              )
                                                                                              .when(
                                                                                                data: (
                                                                                                  data,
                                                                                                ) =>
                                                                                                    HtmlWidget(
                                                                                                  data['data'] ?? "",
                                                                                                ),
                                                                                                error: (
                                                                                                  e,
                                                                                                  s,
                                                                                                ) =>
                                                                                                    Container(),
                                                                                                loading: () => Center(
                                                                                                  child: CircularProgressIndicator(),
                                                                                                ),
                                                                                              ),
                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(
                                                                                              top: 15,
                                                                                            ),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                  child: ElevatedButton(
                                                                                                    style: AppStyle.buttonStyle,
                                                                                                    onPressed: () {
                                                                                                      Navigator.of(
                                                                                                        sheetContext,
                                                                                                      ).pop();
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      AppLocalizations.of(
                                                                                                        context,
                                                                                                      )!
                                                                                                          .msgCencel,
                                                                                                      style: TextStyle(
                                                                                                        fontSize: Adaptive.sp(
                                                                                                          18,
                                                                                                        ),
                                                                                                        fontFamily: 'Roboto',
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        color: Colors.white,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 20,
                                                                                                ),
                                                                                                Expanded(
                                                                                                  child: ElevatedButton(
                                                                                                    style: AppStyle.buttonStyle.copyWith(
                                                                                                      backgroundColor: WidgetStatePropertyAll(
                                                                                                        ColorConstant.red500,
                                                                                                      ),
                                                                                                    ),
                                                                                                    onPressed: () async {
                                                                                                      if (sellPriceController.text.isEmpty ||
                                                                                                          double.tryParse(
                                                                                                                sellPriceController.text,
                                                                                                              ) ==
                                                                                                              null ||
                                                                                                          double.parse(
                                                                                                                sellPriceController.text,
                                                                                                              ) <
                                                                                                              1) {
                                                                                                        context.errorToast(
                                                                                                          AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!
                                                                                                              .pleaseInputValidValue,
                                                                                                        );
                                                                                                      } else {
                                                                                                        if (ref.watch(
                                                                                                              sellWeight,
                                                                                                            ) >
                                                                                                            0.0) {
                                                                                                          if (sellKey.currentState!.validate()) {
                                                                                                            ElevarmConfirmAlertDialog(
                                                                                                              title: AppLocalizations.of(
                                                                                                                context,
                                                                                                              )!
                                                                                                                  .areYouSure,
                                                                                                              subtitle: '${AppLocalizations.of(context)!.commodityPrice} ${sellPriceController.text}\n${AppLocalizations.of(context)!.commodityWeight}${ref.watch(sellWeight)} in Quintal',
                                                                                                              onPositiveButton: () async {
                                                                                                                Get.back();

                                                                                                                await ref
                                                                                                                    .read(
                                                                                                                  postSbtProvider(
                                                                                                                    productId: "${dataList[mainIndex].productId}",
                                                                                                                    commodityId: "${dataList[mainIndex].commodityId}",
                                                                                                                    district_id: "${dataList[mainIndex].districtId}",
                                                                                                                    qty: "${ref.watch(sellWeight)}",
                                                                                                                    price: sellPriceController.text,
                                                                                                                    type: "2",
                                                                                                                  ).future,
                                                                                                                )
                                                                                                                    .then(
                                                                                                                  (
                                                                                                                    value,
                                                                                                                  ) async {
                                                                                                                    if (value['status'].toString() == "1") {
                                                                                                                      ref.invalidate(
                                                                                                                        matchedOrdersProvider,
                                                                                                                      );
                                                                                                                      ref.invalidate(
                                                                                                                        getBuyerSellerListProvider,
                                                                                                                      );

                                                                                                                      ref.invalidate(
                                                                                                                        getSbtCommodityProvider,
                                                                                                                      );

                                                                                                                      Navigator.of(
                                                                                                                        sheetContext,
                                                                                                                      ).pop();

                                                                                                                      Fluttertoast.showToast(
                                                                                                                        msg: value['message'],
                                                                                                                        toastLength: Toast.LENGTH_LONG,
                                                                                                                        backgroundColor: Colors.green,
                                                                                                                      );
                                                                                                                    }
                                                                                                                    // else: error already surfaced by the global Dio response interceptor.
                                                                                                                  },
                                                                                                                ).onError(
                                                                                                                  (
                                                                                                                    e,
                                                                                                                    s,
                                                                                                                  ) {
                                                                                                                    context.hideloader();
                                                                                                                  },
                                                                                                                );
                                                                                                              },
                                                                                                              onNegativeButton: () {
                                                                                                                Get.back();
                                                                                                              },
                                                                                                              positiveText: AppLocalizations.of(
                                                                                                                context,
                                                                                                              )!
                                                                                                                  .msgSubmit,
                                                                                                              negativeText: AppLocalizations.of(
                                                                                                                context,
                                                                                                              )!
                                                                                                                  .msgNo,
                                                                                                              variant: ElevarmDialogVariant.primary,
                                                                                                            ).show(
                                                                                                              context,
                                                                                                            );
                                                                                                          }
                                                                                                        } else {
                                                                                                          Fluttertoast.showToast(
                                                                                                            msg: AppLocalizations.of(
                                                                                                              context,
                                                                                                            )!
                                                                                                                .quantityShouldBeGreaterThan0,
                                                                                                            toastLength: Toast.LENGTH_LONG,
                                                                                                            backgroundColor: Colors.red,
                                                                                                          );
                                                                                                        }
                                                                                                      }
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      AppLocalizations.of(
                                                                                                        context,
                                                                                                      )!
                                                                                                          .msgSubmit,
                                                                                                      style: TextStyle(
                                                                                                        fontSize: Adaptive.sp(
                                                                                                          18,
                                                                                                        ),
                                                                                                        fontFamily: 'Roboto',
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        color: Colors.white,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    );
                                                                  } else {
                                                                    showLoginBottomsheet(
                                                                      context,
                                                                    );
                                                                  }
                                                                },
                                                                style: AppStyle
                                                                    .buttonStyle
                                                                    .copyWith(
                                                                  backgroundColor:
                                                                      WidgetStateProperty
                                                                          .resolveWith(
                                                                    (
                                                                      states,
                                                                    ) =>
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .msgSell,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      18,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      ElevarmLinkPrimaryButton
                                                          .icon(
                                                        buttonThemeData:
                                                            ElevarmLinkButtonThemeData(
                                                          onPrimaryColor:
                                                              ColorConstant
                                                                  .maingreen,
                                                        ),
                                                        text:
                                                            AppLocalizations.of(
                                                          context,
                                                        )!
                                                                .viewChart,
                                                        onPressed: () {
                                                          Get.to(
                                                            BuySellData(
                                                              data: dataList[
                                                                  mainIndex],
                                                              index: data.data
                                                                  ?.indexOf(
                                                                dataList[
                                                                    mainIndex],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        leadingIconAssetName:
                                                            CupertinoIcons
                                                                .chart_bar,
                                                        trailingIconAssetName:
                                                            CupertinoIcons
                                                                .forward,
                                                      ),
                                                      ElevarmDivider(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: ColorConstant
                                                                    .maingreen,
                                                              ),
                                                            ),
                                                            child: BuyerList(
                                                              data: dataList[
                                                                  mainIndex],
                                                              index: mainIndex,
                                                            ),
                                                          ),
                                                          ElevarmDivider(),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color:
                                                                    ColorConstant
                                                                        .red500,
                                                              ),
                                                            ),
                                                            padding: Pad(
                                                              all: 10,
                                                            ),
                                                            child: SellerList(
                                                              data: dataList[
                                                                  mainIndex],
                                                              index: mainIndex,
                                                            ),
                                                          ),
                                                          ElevarmDivider(),
                                                        ],
                                                      ),

                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "Matching Deals",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Adaptive.sp(
                                                              16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      ref
                                                          .watch(
                                                            matchedOrdersProvider(
                                                              productId:
                                                                  "${dataList[mainIndex].productId}",
                                                            ),
                                                          )
                                                          .when(
                                                            data: (
                                                              data,
                                                            ) =>
                                                                (data.tradeOrderData ??
                                                                            [])
                                                                        .isEmpty
                                                                    ? Center(
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(
                                                                            context,
                                                                          )!
                                                                              .noDataFound,
                                                                        ),
                                                                      )
                                                                    : ListView
                                                                        .builder(
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: data
                                                                            .tradeOrderData
                                                                            ?.length,
                                                                        itemBuilder:
                                                                            (
                                                                          BuildContext
                                                                              context,
                                                                          int index,
                                                                        ) {
                                                                          return Card(
                                                                            elevation:
                                                                                5,
                                                                            color:
                                                                                Colors.white,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              side: BorderSide(
                                                                                color: ColorConstant.maingreen.withOpacity(
                                                                                  0.3,
                                                                                ),
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(
                                                                                10,
                                                                              ),
                                                                            ),
                                                                            margin:
                                                                                EdgeInsets.symmetric(
                                                                              vertical: 10,
                                                                            ),
                                                                            surfaceTintColor:
                                                                                Colors.white,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(
                                                                                10,
                                                                              ),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Center(
                                                                                    child: Text.rich(
                                                                                      TextSpan(
                                                                                        text: ref
                                                                                                    .watch(
                                                                                                      sharedUtilityProvider,
                                                                                                    )
                                                                                                    .getUser()
                                                                                                    ?.firmName
                                                                                                    .toString()
                                                                                                    .toLowerCase() ==
                                                                                                data.tradeOrderData?[index].buyer.toString().toLowerCase()
                                                                                            ? AppLocalizations.of(
                                                                                                context,
                                                                                              )!
                                                                                                .buyingDeal
                                                                                            : ref
                                                                                                        .watch(
                                                                                                          sharedUtilityProvider,
                                                                                                        )
                                                                                                        .getUser()
                                                                                                        ?.firmName
                                                                                                        .toString()
                                                                                                        .toLowerCase() ==
                                                                                                    data.tradeOrderData?[index].seller.toString().toLowerCase()
                                                                                                ? AppLocalizations.of(
                                                                                                    context,
                                                                                                  )!
                                                                                                    .sellingDeal
                                                                                                : "",
                                                                                        style: TextStyle(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: ref
                                                                                                      .watch(
                                                                                                        sharedUtilityProvider,
                                                                                                      )
                                                                                                      .getUser()
                                                                                                      ?.firmName
                                                                                                      .toString()
                                                                                                      .toLowerCase() ==
                                                                                                  data.tradeOrderData?[index].buyer.toString().toLowerCase()
                                                                                              ? ColorConstant.maingreen
                                                                                              : ref
                                                                                                          .watch(
                                                                                                            sharedUtilityProvider,
                                                                                                          )
                                                                                                          .getUser()
                                                                                                          ?.firmName
                                                                                                          .toString()
                                                                                                          .toLowerCase() ==
                                                                                                      data.tradeOrderData?[index].seller.toString().toLowerCase()
                                                                                                  ? Colors.red
                                                                                                  : ColorConstant.maingreen,
                                                                                          fontSize: Adaptive.sp(
                                                                                            17,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      TextOneLine(
                                                                                        "${AppLocalizations.of(context)!.msgOrderid} ${data.tradeOrderData?[index].orderId}",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          color: ColorConstant.maingreen,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  ElevarmDivider(),

                                                                                  // SizedBox(
                                                                                  //   height: 10,
                                                                                  // ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        "${AppLocalizations.of(context)!.msgDate} ${data.tradeOrderData?[index].date}",
                                                                                        textAlign: TextAlign.end,
                                                                                        style: TextStyle(
                                                                                          color: ColorConstant.maingreen,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Text(
                                                                                    "${AppLocalizations.of(context)!.msgExpirydate} ${data.tradeOrderData?[index].expiryDate}",
                                                                                    textAlign: TextAlign.end,
                                                                                    style: TextStyle(
                                                                                      color: ColorConstant.maingreen,
                                                                                      fontWeight: FontWeight.w700,
                                                                                      fontSize: Adaptive.sp(
                                                                                        16,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  ElevarmDivider(),

                                                                                  Text.rich(
                                                                                    TextSpan(
                                                                                      text: "${data.tradeOrderData?[index].commodity}",
                                                                                      style: TextStyle(
                                                                                        color: ColorConstant.maingreen,
                                                                                        fontWeight: FontWeight.w700,
                                                                                        fontSize: Adaptive.sp(
                                                                                          16,
                                                                                        ),
                                                                                      ),
                                                                                      children: [
                                                                                        TextSpan(
                                                                                          text: "- ${data.tradeOrderData?[index].district.toString()}",
                                                                                          style: TextStyle(
                                                                                            fontSize: Adaptive.sp(
                                                                                              18,
                                                                                            ),
                                                                                            color: Colors.black,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  ElevarmDivider(),

                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!
                                                                                            .rate,
                                                                                        style: AppStyle.mystoke.copyWith(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Text(
                                                                                        currencyFormat.format(
                                                                                          double.parse(
                                                                                            "${data.tradeOrderData?[index].rate ?? "0.0"}",
                                                                                          ),
                                                                                        ),
                                                                                        style: AppStyle.mystoke.copyWith(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  ElevarmDivider(),

                                                                                  SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!
                                                                                            .quantity,
                                                                                        style: AppStyle.mystoke.copyWith(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                      ),
                                                                                      Spacer(),
                                                                                      Text(
                                                                                        '${data.tradeOrderData?[index].qty}(Qtl.)',
                                                                                        style: AppStyle.mystoke.copyWith(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  ElevarmDivider(),

                                                                                  SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        AppLocalizations.of(
                                                                                          context,
                                                                                        )!
                                                                                            .pendingQuantity,
                                                                                        style: AppStyle.mystoke.copyWith(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Text(
                                                                                        '${(num.parse("${data.tradeOrderData?[index].qty}") - num.parse(data.tradeOrderData?[index].deliverQty)).toStringAsFixed(0)}(Qtl.)',
                                                                                        style: AppStyle.mystoke.copyWith(
                                                                                          fontSize: Adaptive.sp(
                                                                                            16,
                                                                                          ),
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  ElevarmDivider(),

                                                                                  // Print and View PDF buttons
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: OutlinedButton.icon(
                                                                                          onPressed: () async {
                                                                                            try {
                                                                                              // Show loading
                                                                                              showDialog(
                                                                                                context: context,
                                                                                                barrierDismissible: false,
                                                                                                builder: (
                                                                                                  context,
                                                                                                ) =>
                                                                                                    Center(
                                                                                                  child: CircularProgressIndicator(
                                                                                                    color: ColorConstant.maingreen,
                                                                                                  ),
                                                                                                ),
                                                                                              );

                                                                                              // Call the print API
                                                                                              final printData = await ref.read(
                                                                                                fetchMatchOrderPrintProvider(
                                                                                                  orderId: '${data.tradeOrderData?[index].orderId}',
                                                                                                ).future,
                                                                                              );

                                                                                              // Close loading
                                                                                              Navigator.of(
                                                                                                context,
                                                                                              ).pop();

                                                                                              // Show printer selection dialog
                                                                                              await _showPrinterSelectionForReceipt(
                                                                                                context,
                                                                                                printData,
                                                                                              );
                                                                                            } catch (e) {
                                                                                              // Close loading if still open
                                                                                              if (Navigator.canPop(
                                                                                                context,
                                                                                              )) {
                                                                                                Navigator.of(
                                                                                                  context,
                                                                                                ).pop();
                                                                                              }
                                                                                              Fluttertoast.showToast(
                                                                                                msg: 'Failed to load print data: $e',
                                                                                                backgroundColor: Colors.red,
                                                                                                textColor: Colors.white,
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                          icon: Icon(
                                                                                            Icons.print,
                                                                                            size: Adaptive.sp(
                                                                                              18,
                                                                                            ),
                                                                                          ),
                                                                                          label: Text(
                                                                                            'Print',
                                                                                            style: TextStyle(
                                                                                              fontSize: Adaptive.sp(
                                                                                                14,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          style: OutlinedButton.styleFrom(
                                                                                            foregroundColor: ColorConstant.maingreen,
                                                                                            side: BorderSide(
                                                                                              color: ColorConstant.maingreen,
                                                                                            ),
                                                                                            padding: EdgeInsets.symmetric(
                                                                                              vertical: 12,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Container(
                                                                                        decoration: BoxDecoration(
                                                                                          gradient: LinearGradient(
                                                                                            colors: [
                                                                                              ColorConstant.maingreen,
                                                                                              ColorConstant.maingreen.withOpacity(
                                                                                                0.8,
                                                                                              ),
                                                                                            ],
                                                                                            begin: Alignment.topLeft,
                                                                                            end: Alignment.bottomRight,
                                                                                          ),
                                                                                          borderRadius: BorderRadius.circular(
                                                                                            8,
                                                                                          ),
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: ColorConstant.maingreen.withOpacity(
                                                                                                0.3,
                                                                                              ),
                                                                                              blurRadius: 8,
                                                                                              offset: Offset(
                                                                                                0,
                                                                                                4,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        child: ElevatedButton.icon(
                                                                                          onPressed: () async {
                                                                                            try {
                                                                                              // Show loading
                                                                                              showDialog(
                                                                                                context: context,
                                                                                                barrierDismissible: false,
                                                                                                builder: (
                                                                                                  context,
                                                                                                ) =>
                                                                                                    Center(
                                                                                                  child: CircularProgressIndicator(
                                                                                                    color: ColorConstant.maingreen,
                                                                                                  ),
                                                                                                ),
                                                                                              );

                                                                                              // Call the PDF URL API

                                                                                              final pdfUrl = "${ref.read(dioProvider).options.baseUrl}$getMatchOrderPdf?order_id=${data.tradeOrderData?[index].orderId}";

                                                                                              // Get auth token from shared utility
                                                                                              final authToken = ref
                                                                                                  .read(
                                                                                                    dioProvider,
                                                                                                  )
                                                                                                  .options
                                                                                                  .headers['Authorization']
                                                                                                  ?.toString();

                                                                                              // Close loading
                                                                                              Navigator.of(
                                                                                                context,
                                                                                              ).pop();

                                                                                              // Navigate to webview with PDF URL and auth token
                                                                                              Get.to(
                                                                                                () => HtmlViewerScreen(
                                                                                                  pdfUrl: pdfUrl,
                                                                                                  authToken: authToken,
                                                                                                  title: 'Order ${data.tradeOrderData?[index].orderId}',
                                                                                                ),
                                                                                              );
                                                                                            } catch (e) {
                                                                                              // Close loading if still open
                                                                                              if (Navigator.canPop(
                                                                                                context,
                                                                                              )) {
                                                                                                Navigator.of(
                                                                                                  context,
                                                                                                ).pop();
                                                                                              }
                                                                                            }
                                                                                          },
                                                                                          icon: Icon(
                                                                                            Icons.picture_as_pdf_rounded,
                                                                                            size: Adaptive.sp(
                                                                                              18,
                                                                                            ),
                                                                                          ),
                                                                                          label: Text(
                                                                                            'View PDF',
                                                                                            style: TextStyle(
                                                                                              fontSize: Adaptive.sp(
                                                                                                14,
                                                                                              ),
                                                                                              fontWeight: FontWeight.w600,
                                                                                            ),
                                                                                          ),
                                                                                          style: ElevatedButton.styleFrom(
                                                                                            backgroundColor: Colors.transparent,
                                                                                            foregroundColor: Colors.white,
                                                                                            shadowColor: Colors.transparent,
                                                                                            padding: EdgeInsets.symmetric(
                                                                                              vertical: 12,
                                                                                              horizontal: 16,
                                                                                            ),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(
                                                                                                8,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      // Expanded(
                                                                                      //   child: OutlinedButton.icon(
                                                                                      //     onPressed: () async {
                                                                                      //       try {
                                                                                      //         // Show loading
                                                                                      //         showDialog(
                                                                                      //           context: context,
                                                                                      //           barrierDismissible: false,
                                                                                      //           builder: (context) => Center(
                                                                                      //             child: CircularProgressIndicator(
                                                                                      //               color: ColorConstant.maingreen,
                                                                                      //             ),
                                                                                      //           ),
                                                                                      //         );

                                                                                      //         // Call the PDF URL API

                                                                                      //         final pdfUrl = "${ref.read(dioProvider).options.baseUrl}$getMatchOrderPdf?order_id=${data.tradeOrderData?[index].orderId}";

                                                                                      //         // Get auth token from shared utility
                                                                                      //         final authToken = ref.read(dioProvider).options.headers['Authorization']?.toString();

                                                                                      //         // Close loading
                                                                                      //         Navigator.of(context).pop();

                                                                                      //         // Navigate to webview with PDF URL and auth token
                                                                                      //         Get.to(() => HtmlViewerScreen(
                                                                                      //               pdfUrl: pdfUrl,
                                                                                      //               authToken: authToken,
                                                                                      //               title: 'Order ${data.tradeOrderData?[index].orderId}',
                                                                                      //             ));
                                                                                      //       } catch (e) {
                                                                                      //         // Close loading if still open
                                                                                      //         if (Navigator.canPop(context)) {
                                                                                      //           Navigator.of(context).pop();
                                                                                      //         }
                                                                                      //       }
                                                                                      //     },
                                                                                      //     icon: Icon(Icons.picture_as_pdf, size: Adaptive.sp(18)),
                                                                                      //     label: Text(
                                                                                      //       'View PDF',
                                                                                      //       style: TextStyle(fontSize: Adaptive.sp(14)),
                                                                                      //     ),
                                                                                      //     style: OutlinedButton.styleFrom(
                                                                                      //       foregroundColor: ColorConstant.maingreen,
                                                                                      //       side: BorderSide(color: ColorConstant.maingreen),
                                                                                      //       padding: EdgeInsets.symmetric(vertical: 12),
                                                                                      //     ),
                                                                                      //   ),
                                                                                      // ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),

                                                                                  if (ref
                                                                                          .watch(
                                                                                            sharedUtilityProvider,
                                                                                          )
                                                                                          .getUser()
                                                                                          ?.firmName
                                                                                          .toString()
                                                                                          .toLowerCase() ==
                                                                                      data.tradeOrderData?[index].buyer.toString().toLowerCase())
                                                                                    Center(
                                                                                      child: ElevarmPrimaryButton.text(
                                                                                        onPressed: () {
                                                                                          Get.to(
                                                                                            Sbtdeals(),
                                                                                          )?.then((_) {
                                                                                                ref.invalidate(getSbtCommodityProvider);
                                                                                                ref.invalidate(matchedOrdersProvider);
                                                                                              });
                                                                                        },
                                                                                        buttonThemeData: ElevarmPrimaryButtonThemeData(
                                                                                          primaryColor: ColorConstant.maingreen,
                                                                                        ),
                                                                                        text: AppLocalizations.of(
                                                                                          context,
                                                                                        )!
                                                                                            .checkDealStatus,
                                                                                      ),
                                                                                    ),

                                                                                  if (ref
                                                                                              .watch(
                                                                                                sharedUtilityProvider,
                                                                                              )
                                                                                              .getUser()
                                                                                              ?.firmName
                                                                                              .toString()
                                                                                              .toLowerCase() ==
                                                                                          data.tradeOrderData?[index].seller.toString().toLowerCase() &&
                                                                                      dataList[mainIndex].sbtType.toString() == "1")
                                                                                    RowSuper(
                                                                                      fitHorizontally: true,
                                                                                      children: [
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            Get.back();
                                                                                            if (dataList[mainIndex].sbtType.toString() == "1") {
                                                                                              Get.to(
                                                                                                StackInward(
                                                                                                  isAppbarVisible: true,
                                                                                                ),
                                                                                              );
                                                                                            } else {
                                                                                              Get.to(
                                                                                                FactoryDispatchRequestsScreen(
                                                                                                  sbtOrder: data.tradeOrderData?[index].orderId,
                                                                                                ),
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                          child: Text(
                                                                                            AppLocalizations.of(
                                                                                              context,
                                                                                            )!
                                                                                                .msgStackinward,
                                                                                            style: TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: ColorConstant.maingreen,
                                                                                              fontSize: Adaptive.sp(
                                                                                                16,
                                                                                              ),
                                                                                              decoration: TextDecoration.underline,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            Get.back();
                                                                                            if (dataList[mainIndex].sbtType.toString() == "1") {
                                                                                              showModalBottomSheet(
                                                                                                context: context,
                                                                                                builder: (
                                                                                                  bottomsheetContext,
                                                                                                ) =>
                                                                                                    ElevarmDraggableBottomSheet(
                                                                                                  title: AppLocalizations.of(
                                                                                                    context,
                                                                                                  )!
                                                                                                      .markDelivery,
                                                                                                  onPressedClose: () => Get.back(),
                                                                                                  initialChildSize: 1,
                                                                                                  children: [
                                                                                                    DeliveryMarking(
                                                                                                      isScreen: false,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                isScrollControlled: true,
                                                                                              ).then((_) {
                                                                                                ref.invalidate(getSbtCommodityProvider);
                                                                                                ref.invalidate(matchedOrdersProvider);
                                                                                              });
                                                                                            } else {
                                                                                              showModalBottomSheet(
                                                                                                context: context,
                                                                                                builder: (
                                                                                                  bottomsheetContext,
                                                                                                ) =>
                                                                                                    ElevarmDraggableBottomSheet(
                                                                                                  title: '',
                                                                                                  onPressedClose: () => Get.back(),
                                                                                                  children: [
                                                                                                    FactoryDispatchRequestsScreen(
                                                                                                      sbtOrder: data.tradeOrderData?[index].orderId ?? "",
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                isScrollControlled: true,
                                                                                              ).then((_) {
                                                                                                ref.invalidate(getSbtCommodityProvider);
                                                                                                ref.invalidate(matchedOrdersProvider);
                                                                                              });
                                                                                            }
                                                                                          },
                                                                                          child: Text(
                                                                                            AppLocalizations.of(
                                                                                              context,
                                                                                            )!
                                                                                                .markDelivery,
                                                                                            style: TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: ColorConstant.maingreen,
                                                                                              fontSize: Adaptive.sp(
                                                                                                16,
                                                                                              ),
                                                                                              decoration: TextDecoration.underline,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            Get.back();
                                                                                            Get.to(
                                                                                              Tradewalletscreen(),
                                                                                            )?.then((_) {
                                                                                                ref.invalidate(getSbtCommodityProvider);
                                                                                                ref.invalidate(matchedOrdersProvider);
                                                                                              });
                                                                                          },
                                                                                          child: Text(
                                                                                            AppLocalizations.of(
                                                                                              context,
                                                                                            )!
                                                                                                .walletRefund,
                                                                                            style: TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: ColorConstant.maingreen,
                                                                                              fontSize: Adaptive.sp(
                                                                                                16,
                                                                                              ),
                                                                                              decoration: TextDecoration.underline,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),

                                                                                  if (ref
                                                                                              .watch(
                                                                                                sharedUtilityProvider,
                                                                                              )
                                                                                              .getUser()
                                                                                              ?.firmName
                                                                                              .toString()
                                                                                              .toLowerCase() ==
                                                                                          data.tradeOrderData?[index].seller.toString().toLowerCase() &&
                                                                                      dataList[mainIndex].sbtType.toString() == "2")
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: simpleButton(
                                                                                            text: AppLocalizations.of(
                                                                                              context,
                                                                                            )!
                                                                                                .dispatch,
                                                                                            callback: () {
                                                                                              Get.back();
                                                                                              if (dataList[mainIndex].sbtType.toString() == "1") {
                                                                                                Get.to(
                                                                                                  StackInward(
                                                                                                    isAppbarVisible: true,
                                                                                                  ),
                                                                                                )?.then((_) {
                                                                                                ref.invalidate(getSbtCommodityProvider);
                                                                                                ref.invalidate(matchedOrdersProvider);
                                                                                              });
                                                                                              } else {
                                                                                                Get.to(
                                                                                                  FactoryDispatchRequestsScreen(
                                                                                                    sbtOrder: data.tradeOrderData?[index].orderId,
                                                                                                  ),
                                                                                                )?.then((_) {
                                                                                                ref.invalidate(getSbtCommodityProvider);
                                                                                                ref.invalidate(matchedOrdersProvider);
                                                                                              });
                                                                                              }
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: simpleButton(
                                                                                            text: AppLocalizations.of(
                                                                                              context,
                                                                                            )!
                                                                                                .msgGrn,
                                                                                            callback: () {
                                                                                              Get.back();
                                                                                              if (dataList[mainIndex].sbtType.toString() == "1") {
                                                                                                Get.to(
                                                                                                  Sbtdeals(
                                                                                                    selectedIndex: ref
                                                                                                                .watch(
                                                                                                                  sharedUtilityProvider,
                                                                                                                )
                                                                                                                .getUser()
                                                                                                                ?.firmName
                                                                                                                .toString()
                                                                                                                .toLowerCase() ==
                                                                                                            data.tradeOrderData?[index].buyer.toString().toLowerCase()
                                                                                                        ? 1
                                                                                                        : ref
                                                                                                                    .watch(
                                                                                                                      sharedUtilityProvider,
                                                                                                                    )
                                                                                                                    .getUser()
                                                                                                                    ?.firmName
                                                                                                                    .toString()
                                                                                                                    .toLowerCase() ==
                                                                                                                data.tradeOrderData?[index].seller.toString().toLowerCase()
                                                                                                            ? 0
                                                                                                            : 0,
                                                                                                    sbtOrderId: data.tradeOrderData?[index].orderId ?? "",
                                                                                                  ),
                                                                                                )?.then((_) {
                                                                                                ref.invalidate(getSbtCommodityProvider);
                                                                                                ref.invalidate(matchedOrdersProvider);
                                                                                              });
                                                                                              } else {
                                                                                                Get.to(
                                                                                                  Dispatchrequestslisting(
                                                                                                    orderId: data.tradeOrderData?[index].orderId ?? "",
                                                                                                  ),
                                                                                                )?.then((_) {
                                                                                                ref.invalidate(getSbtCommodityProvider);
                                                                                                ref.invalidate(matchedOrdersProvider);
                                                                                              });
                                                                                              }
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: simpleButton(
                                                                                            text: AppLocalizations.of(
                                                                                              context,
                                                                                            )!
                                                                                                .payment,
                                                                                            callback: () {
                                                                                              Get.back();
                                                                                              Get.to(
                                                                                                Tradewalletscreen(),
                                                                                              )?.then((_) {
                                                                                                ref.invalidate(getSbtCommodityProvider);
                                                                                                ref.invalidate(matchedOrdersProvider);
                                                                                              });
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                            error: (
                                                              e,
                                                              s,
                                                            ) =>
                                                                noStockData(
                                                              context,
                                                            ),
                                                            loading: () =>
                                                                _matchedOrdersLoader(),
                                                          ),

                                                      ElevarmDivider(),
                                                      // Text(
                                                      //   'Apps',
                                                      //   style: ElevarmFontFamilies.inter(
                                                      //       fontSize: Adaptive.sp(
                                                      //           13),
                                                      //       fontWeight: FontWeight
                                                      //           .bold,
                                                      //       color:
                                                      //           ElevarmColors.neutral),
                                                      // ),
                                                      //  SizedBox(
                                                      //   width: 10,
                                                      // ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          _commodityParamsLayout(
                                                            "${dataList[mainIndex].productId}",
                                                            "${dataList[mainIndex].commodity}",
                                                          ),
                                                          ElevarmDivider(),
                                                          Row(
                                                            children: [
                                                              Center(
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .deliveryCenters,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      17,
                                                                    ),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    SizedBox(),
                                                              ),
                                                              // InkWell(
                                                              //   onTap: () async {
                                                              //     final position = await Geolocator.getCurrentPosition(
                                                              //       desiredAccuracy: LocationAccuracy.high,
                                                              //     );

                                                              //     List<Map<String, dynamic>> list = [];
                                                              //     ref.watch(warehouseListProvider(id: "${dataList[mainIndex].productId}").future).then((value) {
                                                              //       var deliveryCenterList = value.data?.where((e) => num.parse(e.emptySpace.toString()).toStringAsFixed(0) != "0").toList();

                                                              //       deliveryCenterList?.forEach((e) {
                                                              //         // Calculate distance between user and delivery center
                                                              //         if (e.lat != null && e.long != null) {
                                                              //           final terminalLat = double.tryParse(e.lat.toString()) ?? 0.0;
                                                              //           final terminalLng = double.tryParse(e.long.toString()) ?? 0.0;
                                                              //           final distance = Geolocator.distanceBetween(
                                                              //             position.latitude,
                                                              //             position.longitude,
                                                              //             terminalLat,
                                                              //             terminalLng,
                                                              //           );

                                                              //           // Add delivery center to the list if within 200 km
                                                              //           list.add({
                                                              //             'location': LatLng(terminalLat, terminalLng),
                                                              //             'imageUrl': "${BASEURL}resources/assets/upload/warehouses/default_warehouse.png",
                                                              //             'text': '${e.warehouseName ?? 'Unknown Warehouse'}',
                                                              //           });
                                                              //         }
                                                              //       });

                                                              //       // Navigate to the map screen with filtered markers
                                                              //       Get.to(DeliveryCentersMap(markersData: list));
                                                              //     });
                                                              //   },
                                                              //   child: Text(
                                                              //     AppLocalizations.of(context)!.viewAllWarehouses,
                                                              //     style: TextStyle(color: ColorConstant.maingreen, decoration: TextDecoration.underline, fontWeight: FontWeight.bold, decorationColor: ColorConstant.maingreen, fontSize: Adaptive.sp(16)),
                                                              //   ),
                                                              // )
                                                            ],
                                                          ),
                                                          _deliveryCenters(
                                                            "${dataList[mainIndex].productId}",
                                                            "${dataList[mainIndex].sbtType}",
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                    error: (e, s) => noStockData(),
                    loading: () => _sbttLoader(),
                  ),
                  ref.watch(authProvider).value ==
                          AuthStatus.loggedIn
                      ? DeliveryMarking(isScreen: false)
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/mainlogopng.png',
                                height: 150,
                                width: 150,
                              ),
                              simpleButton(
                                text: AppLocalizations.of(context)!
                                    .loginToContinue,
                                callback: () => showLoginBottomsheet(context),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _schemesWidget(dynamic value, productId, commodityId, districtId, loanType) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: false,
        builder: (
          bottomsheetContext,
        ) =>
            ElevarmDraggableBottomSheet(
          initialChildSize: 1,
          title: AppLocalizations.of(
            context,
          )!
              .pleaseSelectScheme,
          onPressedClose: () => Get.back(),
          children: [
            Consumer(
              builder: (
                context,
                ref,
                child,
              ) =>
                  SizedBox(
                height: Get.height / 2,
                width: Get.width,
                child: value['data'] == null
                    ? Text(
                        AppLocalizations.of(
                          context,
                        )!
                            .noData,
                      )
                    : ColumnSuper(
                        children: [
                          Container(
                            padding: Pad(
                              all: 10,
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstant.maingreen,
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .action,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(
                                        14,
                                      ),
                                      shadows: [
                                        Shadow(
                                          color: Colors.white,
                                          blurRadius: 1,
                                          offset: Offset(
                                            0.2,
                                            0.2,
                                          ),
                                        ),
                                      ],
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 28,
                                  color: Colors.white54,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .totalAmount,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(
                                        14,
                                      ),
                                      shadows: [
                                        Shadow(
                                          color: Colors.white,
                                          blurRadius: 1,
                                          offset: Offset(
                                            0.2,
                                            0.2,
                                          ),
                                        ),
                                      ],
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 28,
                                  color: Colors.white54,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .pF,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(
                                        14,
                                      ),
                                      shadows: [
                                        Shadow(
                                          color: Colors.white,
                                          blurRadius: 1,
                                          offset: Offset(
                                            0.2,
                                            0.2,
                                          ),
                                        ),
                                      ],
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 28,
                                  color: Colors.white54,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .interestRate,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(
                                        14,
                                      ),
                                      shadows: [
                                        Shadow(
                                          color: Colors.white,
                                          blurRadius: 1,
                                          offset: Offset(
                                            0.2,
                                            0.2,
                                          ),
                                        ),
                                      ],
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 28,
                                  color: Colors.white54,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .lTV,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(
                                        14,
                                      ),
                                      shadows: [
                                        Shadow(
                                          color: Colors.white,
                                          blurRadius: 1,
                                          offset: Offset(
                                            0.2,
                                            0.2,
                                          ),
                                        ),
                                      ],
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 28,
                                  color: Colors.white54,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .tenor,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(
                                        14,
                                      ),
                                      shadows: [
                                        Shadow(
                                          color: Colors.white,
                                          blurRadius: 1,
                                          offset: Offset(
                                            0.2,
                                            0.2,
                                          ),
                                        ),
                                      ],
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //     child: Text("Days",
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //             fontSize: Adaptive.sp(17),
                                //             shadows:  [
                                //               Shadow(
                                //                   color: Colors.white,
                                //                   blurRadius: 1,
                                //                   offset: Offset(0.2, 0.2))
                                //             ],
                                //             color: Colors.white,
                                //             fontWeight: FontWeight.w800)))
                              ],
                            ),
                          ),
                          ListView.builder(
                            itemCount: value['data']?.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (
                              context,
                              index,
                            ) =>
                                value['data'][index]['scheme_name']
                                            .toString()
                                            .toLowerCase()
                                            .trim() ==
                                        "bnpl takeover"
                                    ? SizedBox()
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: index % 2 == 0
                                              ? Colors.grey.withOpacity(
                                                  0.1,
                                                )
                                              : Colors.white,
                                          border: Border(
                                            left: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: 1,
                                            ),
                                            right: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: 1,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: Pad(
                                            all: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Checkbox(
                                                  activeColor:
                                                      ColorConstant.maingreen,
                                                  value: ref.watch(
                                                        selectedIndex,
                                                      ) ==
                                                      index,
                                                  onChanged: (
                                                    isSelected,
                                                  ) {
                                                    if (isSelected ?? false) {
                                                      ref
                                                          .watch(
                                                            selectedIndex
                                                                .notifier,
                                                          )
                                                          .state = index;
                                                    } else {
                                                      ref.invalidate(
                                                        selectedIndex,
                                                      );
                                                    }
                                                    setState(
                                                      () {},
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 28,
                                                color: Colors.grey.shade400,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${value['data'][index]['limit_amount'] ?? ""}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: Adaptive.sp(
                                                      14,
                                                    ),
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.white,
                                                        blurRadius: 1,
                                                        offset: Offset(
                                                          0.2,
                                                          0.2,
                                                        ),
                                                      ),
                                                    ],
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 28,
                                                color: Colors.grey.shade400,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${value['data'][index]['processing_fee'] ?? ""}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: Adaptive.sp(
                                                      14,
                                                    ),
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.white,
                                                        blurRadius: 1,
                                                        offset: Offset(
                                                          0.2,
                                                          0.2,
                                                        ),
                                                      ),
                                                    ],
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 28,
                                                color: Colors.grey.shade400,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${value['data'][index]['interest_rate'] ?? ""}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: Adaptive.sp(
                                                      14,
                                                    ),
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.white,
                                                        blurRadius: 1,
                                                        offset: Offset(
                                                          0.2,
                                                          0.2,
                                                        ),
                                                      ),
                                                    ],
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 28,
                                                color: Colors.grey.shade400,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${value['data'][index]['ltp'] ?? ""}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: Adaptive.sp(
                                                      14,
                                                    ),
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.white,
                                                        blurRadius: 1,
                                                        offset: Offset(
                                                          0.2,
                                                          0.2,
                                                        ),
                                                      ),
                                                    ],
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 28,
                                                color: Colors.grey.shade400,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${value['data'][index]['tenor_days']} ${value['data'][index]['tenor_type']}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: Adaptive.sp(
                                                      14,
                                                    ),
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.white,
                                                        blurRadius: 1,
                                                        offset: Offset(
                                                          0.2,
                                                          0.2,
                                                        ),
                                                      ),
                                                    ],
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              // Expanded(
                                              //     child: Text(
                                              //         data.data?[index]
                                              //                 .loanPassDays ??
                                              //             "",,
                                              //         textAlign: TextAlign.center,
                                              //         style: TextStyle(
                                              //             fontSize: Adaptive.sp(17),
                                              //             shadows:  [
                                              //               Shadow(
                                              //                   color: Colors.white,
                                              //                   blurRadius: 1,
                                              //                   offset: Offset(
                                              //                       0.2, 0.2))
                                              //             ],
                                              //             color: Colors.black,
                                              //             fontWeight:
                                              //                 FontWeight.w800)))
                                            ],
                                          ),
                                        ),
                                      ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () {
                                if (ref.watch(
                                      selectedIndex,
                                    ) ==
                                    null) {
                                  Fluttertoast.showToast(
                                    msg: AppLocalizations.of(
                                      context,
                                    )!
                                        .pleaseSelectScheme,
                                  );
                                } else {
                                  context.showLoader();
                                  ref
                                      .read(
                                    postSbtProvider(
                                      loanType: loanType.toString(),
                                      productId: "${productId}",
                                      commodityId: "${commodityId}",
                                      district_id: "${districtId}",
                                      qty: "${ref.watch(buyWeight)}",
                                      price: _buyPrice.toString(),
                                      type: "1",
                                      schemeId:
                                          "${value['data'][ref.watch(selectedIndex)]['id']}",
                                    ).future,
                                  )
                                      .then(
                                    (
                                      value,
                                    ) {
                                      context.hideloader();
                                      if (value['status'].toString() == "0") {
                                        return;
                                      } else {
                                        Navigator.of(bottomsheetContext).pop();

                                        Get.back(
                                          closeOverlays: true,
                                          canPop: true,
                                        );
                                      }
                                    },
                                  ).onError(
                                    (
                                      e,
                                      s,
                                    ) {
                                      context.hideloader();
                                    },
                                  );
                                }
                              },
                              style: AppStyle.buttonStyle,
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      );
  _matchedOrdersLoader() => Skeletonizer(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: ColorConstant.maingreen.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Selling Deal",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.maingreen,
                            fontSize: Adaptive.sp(17),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        TextOneLine(
                          "Order ID:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorConstant.maingreen,
                            fontWeight: FontWeight.w700,
                            fontSize: Adaptive.sp(17),
                          ),
                        ),
                      ],
                    ),
                    ElevarmDivider(),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date:",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: ColorConstant.maingreen,
                            fontWeight: FontWeight.w700,
                            fontSize: Adaptive.sp(17),
                          ),
                        ),
                        Text(
                          "Expiry Date: ",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: ColorConstant.maingreen,
                            fontWeight: FontWeight.w700,
                            fontSize: Adaptive.sp(17),
                          ),
                        ),
                      ],
                    ),
                    ElevarmDivider(),

                    Text.rich(
                      TextSpan(
                        text: "Loading...",
                        style: TextStyle(
                          color: ColorConstant.maingreen,
                          fontWeight: FontWeight.w700,
                          fontSize: Adaptive.sp(17),
                        ),
                        children: [
                          TextSpan(
                            text: "- Loading...",
                            style: TextStyle(
                              fontSize: Adaptive.sp(17),
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevarmDivider(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.msgPrice_1,
                              style: AppStyle.mystoke.copyWith(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '0',
                              style: AppStyle.mystoke.copyWith(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.msgQuantity,
                              style: AppStyle.mystoke.copyWith(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '0(Qtl.)',
                              style: AppStyle.mystoke.copyWith(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    ElevarmDivider(),

                    SizedBox(width: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.msgRemainingquantity,
                          style: AppStyle.mystoke.copyWith(
                            fontSize: Adaptive.sp(17),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '0(Qtl.)',
                          style: AppStyle.mystoke.copyWith(
                            fontSize: Adaptive.sp(17),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    ElevarmDivider(),

                    // Center(
                    //   child: ElevarmPrimaryButton.text(
                    //       onPressed: () {},
                    //       buttonThemeData: ElevarmPrimaryButtonThemeData(
                    //           primaryColor: ColorConstant.maingreen),
                    //       text: 'Check Deal Status'),
                    // ),
                    RowSuper(
                      fitHorizontally: true,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)!.msgStackinward,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.maingreen,
                              fontSize: Adaptive.sp(17),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Mark Delivery',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.maingreen,
                              fontSize: Adaptive.sp(17),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                            Get.to(Tradewalletscreen());
                          },
                          child: Text(
                            'Wallet Refund',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.maingreen,
                              fontSize: Adaptive.sp(17),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: simpleButton(
                            text: AppLocalizations.of(context)!.dispatch,
                            callback: () {},
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: simpleButton(
                            text: AppLocalizations.of(context)!.msgGrn,
                            callback: () {},
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: simpleButton(
                            text: AppLocalizations.of(context)!.payment,
                            callback: () {
                              Get.back();
                              Get.to(Tradewalletscreen());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  _sbttLoader() => Skeletonizer(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int mainIndex) {
            return InkWell(
              onTap: () async {
                // Get.to();
              },
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: ColorConstant.maingreen, width: 2),
                ),
                margin: EdgeInsets.all(10),
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with district
                      Text.rich(
                        TextSpan(
                          text: "Barley ",
                          style: TextStyle(
                            fontSize: Adaptive.sp(17),
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.maingreen,
                          ),
                          children: [
                            TextSpan(
                              text: "- Loading....",
                              style: TextStyle(
                                fontSize: Adaptive.sp(17),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12),

                      // Buyer/Seller best prices
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPriceRow(
                            label: AppLocalizations.of(context)!.msgBuyerBest,
                            value: currencyFormat.format(0),
                          ),
                          _buildPriceRow(
                            label: AppLocalizations.of(context)!.msgSellerBest,
                            value: currencyFormat.format(0),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      // Tap for details + Icon and Label
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tapForDetails,
                            style: AppStyle.mystoke.copyWith(
                              fontSize: Adaptive.sp(17),
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.warehouse,
                            size: 30,
                            color: ColorConstant.maingreen,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Warehouse',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(17),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );

  _deliverCentersLoader() => Skeletonizer(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          padding: Pad(all: 0),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, whIndex) {
            return InkWell(
              onTap: () async {},
              child: Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorConstant.maingreen),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                surfaceTintColor: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width,
                            child: Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "",
                                    style: TextStyle(
                                      color: ColorConstant.maingreen,
                                      fontWeight: FontWeight.w700,
                                      fontSize: Adaptive.sp(17),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      MapsLauncher.launchQuery("");
                                    },
                                    child: Text(
                                      'Locate',
                                      style: TextStyle(
                                        color: ColorConstant.maingreen,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        decorationColor:
                                            ColorConstant.maingreen,
                                        fontSize: Adaptive.sp(17),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "-",
                            style: TextStyle(
                              fontSize: Adaptive.sp(17),
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: Pad(all: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorConstant.maingreen,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.charges,
                              style: TextStyle(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Table(
                              border: TableBorder.all(
                                color: ColorConstant.maingreen,
                              ),
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: Pad(all: 10),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .labourRate,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: Pad(all: 10),
                                      child: Text.rich(
                                        TextSpan(
                                          text: 'Entry Load -  ',
                                          children: [
                                            TextSpan(
                                              text: '\nSeller',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: Pad(all: 10),
                                      child: Text.rich(
                                        TextSpan(
                                          text:
                                              'Exit Load - rent lock-in applicable  ',
                                          children: [
                                            TextSpan(
                                              text: 'Outwards',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: Pad(all: 10),
                                      child: Text.rich(
                                        TextSpan(
                                          text:
                                              'Weight Shortage Allowance -   ',
                                          children: [
                                            TextSpan(
                                              text: '\nStockist',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: Pad(all: 10),
                                      child: Text.rich(
                                        TextSpan(
                                          text:
                                              'Rent - \u{20B9} / per Qtl. / per month ',
                                          children: [
                                            TextSpan(
                                              text: '\nStockist',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: Pad(all: 10),
                                      child: Text(
                                        'Balance space in mixed Stacks -  (in Qtl.)',
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // TableRow(children: [
                                //   Padding(padding:  Pad(all: 10), child: Text('Balance space in mixed Stacks - ${item?.emptySpace ?? 0} (in Qtl.)', style: TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold))),
                                //   Padding(padding:  Pad(all: 10), child: Text('', style: TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold))),
                                // ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   width: Get.width,
                    //   padding: Pad(all: 10),
                    //   decoration: BoxDecoration(
                    //       color: ColorConstant.maingreen,
                    //       borderRadius:  BorderRadius.only(
                    //         bottomRight: Radius.circular(8),
                    //         bottomLeft: Radius.circular(8),
                    //       )),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text.rich(TextSpan(text: 'Labour Rate - ${item?.labourRate ?? 0}r s / per Qtl.', style: TextStyle(fontSize: Adaptive.sp(17), color: Colors.white, fontWeight: FontWeight.bold), recognizer: TapGestureRecognizer()..onTap = () async {}, children: [])),
                    //       // Text.rich(TextSpan(
                    //       //     text: 'Delivery Centres',
                    //       //     style: TextStyle(fontSize: Adaptive.sp(17), color: Colors.white, fontWeight: FontWeight.bold),
                    //       //     recognizer: TapGestureRecognizer()
                    //       //       ..onTap = () async {
                    //       //
                    //       //         ref.watch(warehouseListProvider(id: "${data.data?[index].productId}").future).then((value) {
                    //       //
                    //       //         });
                    //       //       },
                    //       //     children: [])),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  void _showUsbConnectedPopup(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('USB Printer Connected'),
        content: Text('Connected to $name'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showPrinterSelectionForReceipt(
    BuildContext context,
    MatchOrderPrintModel printData,
  ) async {
    PrinterType selectedType = PrinterType.bluetooth;
    // Start discovery and wait for it to initialize
    await ref
        .read(printerStateProvider.notifier)
        .startDiscovery(isBle: false, type: selectedType);

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Select Printer',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            spacing: 8,
                            children: [
                              ChoiceChip(
                                label: Text('Bluetooth'),
                                selected: selectedType == PrinterType.bluetooth,
                                onSelected: (v) async {
                                  if (!v) return;
                                  setState(
                                    () => selectedType = PrinterType.bluetooth,
                                  );
                                  await ref
                                      .read(printerStateProvider.notifier)
                                      .startDiscovery(
                                        isBle: false,
                                        clearPrevious: true,
                                        type: selectedType,
                                      );
                                },
                              ),
                              ChoiceChip(
                                label: Text('USB'),
                                selected: selectedType == PrinterType.usb,
                                onSelected: (v) async {
                                  if (!v) return;
                                  setState(
                                    () => selectedType = PrinterType.usb,
                                  );
                                  await ref
                                      .read(printerStateProvider.notifier)
                                      .startDiscovery(
                                        clearPrevious: true,
                                        type: selectedType,
                                      );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Consumer(
                            builder: (context, ref, _) {
                              final printerState = ref.watch(
                                printerStateProvider,
                              );
                              final list = printerState.devices;
                              if (list.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'No printers found.',
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 320),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: list.length,
                                  separatorBuilder: (c, i) =>
                                      Divider(height: 1),
                                  itemBuilder: (context, index) {
                                    final d = list[index];
                                    final detailLine = d.address ??
                                        (d.vendorId != null
                                            ? 'VID:${d.vendorId} PID:${d.productId}'
                                            : '');
                                    final isConnected =
                                        printerState.isConnected &&
                                            printerState.selectedType ==
                                                selectedType &&
                                            (printerState.connectedName ==
                                                (d.name ?? d.address));

                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Theme.of(
                                            context,
                                          ).dividerColor.withOpacity(0.6),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          // quick tap toggles connect/disconnect
                                          if (isConnected) {
                                            await ref
                                                .read(
                                                  printerStateProvider.notifier,
                                                )
                                                .disconnect(type: selectedType);
                                          } else {
                                            final ok = await ref
                                                .read(
                                                  printerStateProvider.notifier,
                                                )
                                                .connect(
                                                  d,
                                                  isBle: false,
                                                  type: selectedType,
                                                );
                                            if (ok) {
                                              final connectedName = d.name ??
                                                  d.address ??
                                                  'Printer';
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Connected to $connectedName',
                                                  ),
                                                ),
                                              );
                                              if (selectedType ==
                                                  PrinterType.usb) {
                                                _showUsbConnectedPopup(
                                                  context,
                                                  connectedName,
                                                );
                                              }
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Theme.of(
                                                  context,
                                                ).primaryColor.withOpacity(0.1),
                                                child: Icon(
                                                  Icons.print,
                                                  color: Theme.of(
                                                    context,
                                                  ).primaryColor,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      d.name ??
                                                          d.address ??
                                                          'Unknown',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      detailLine,
                                                      style: TextStyle(
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  if (isConnected)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 6,
                                                      ),
                                                      child: Chip(
                                                        label: Text(
                                                          'Connected',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        backgroundColor: Colors
                                                            .green.shade700,
                                                      ),
                                                    ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      if (isConnected) {
                                                        await ref
                                                            .read(
                                                              printerStateProvider
                                                                  .notifier,
                                                            )
                                                            .disconnect(
                                                              type:
                                                                  selectedType,
                                                            );
                                                      } else {
                                                        final ok = await ref
                                                            .read(
                                                              printerStateProvider
                                                                  .notifier,
                                                            )
                                                            .connect(
                                                              d,
                                                              isBle: false,
                                                              type:
                                                                  selectedType,
                                                            );
                                                        if (ok) {
                                                          final connectedName =
                                                              d.name ??
                                                                  d.address ??
                                                                  'Printer';
                                                          ScaffoldMessenger.of(
                                                            context,
                                                          ).showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Connected to $connectedName',
                                                              ),
                                                            ),
                                                          );
                                                          if (selectedType ==
                                                              PrinterType.usb) {
                                                            _showUsbConnectedPopup(
                                                              context,
                                                              connectedName,
                                                            );
                                                          }
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                            context,
                                                          ).showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Failed to connect',
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                      isConnected
                                                          ? 'Disconnect'
                                                          : 'Connect',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            // Show loading indicator
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Center(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(height: 16),
                                          Text('Printing...'),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );

                            final ok = await PrinterHelper.instance
                                .printReceiptWithPaper(
                              type: selectedType,
                              paperSize: PaperSize.mm58,
                              printData: printData,
                            );

                            // Close loading indicator
                            Navigator.of(context).pop();

                            if (ok) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Print job sent')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Print failed')),
                              );
                            }
                          },
                          child: Text('Print'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await ref
                                .read(printerStateProvider.notifier)
                                .startDiscovery(
                                  isBle: false,
                                  clearPrevious: true,
                                  type: selectedType,
                                );
                          },
                          child: Text('Scan'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await ref
                                .read(printerStateProvider.notifier)
                                .stopDiscovery();
                            Navigator.of(ctx).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.close),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _commodityParamsLoader() => Skeletonizer(
        child: ColumnSuper(
          children: [
            SizedBox(height: 10),
            Center(
              child: Text(
                "${AppLocalizations.of(context)!.qualityParameters}  - ",
                style: TextStyle(
                  fontSize: Adaptive.sp(17),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: Pad(bottom: 10),
              child: RowSuper(
                fill: true,
                children: [
                  DataTable(
                    headingRowColor: WidgetStateProperty.all(
                      ColorConstant.maingreen,
                    ),
                    showBottomBorder: true,
                    columnSpacing: 36,
                    headingTextStyle: TextStyle(color: Colors.white),
                    border:
                        TableBorder(borderRadius: BorderRadius.circular(10)),
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.name,
                                style: TextStyle(
                                  fontSize: Adaptive.sp(17),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.normal,
                                style: TextStyle(
                                  fontSize: Adaptive.sp(17),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.extreme,
                                style: TextStyle(
                                  fontSize: Adaptive.sp(17),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      4,
                      (qualityIndex) => DataRow(
                        color: WidgetStateProperty.all(
                          qualityIndex % 2 == 0
                              ? Colors.white
                              : Colors.grey.withOpacity(0.1),
                        ),
                        cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                '0',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(17),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                '0',
                                style: TextStyle(
                                  fontSize: Adaptive.sp(17),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                '0',
                                style: TextStyle(
                                  fontSize: Adaptive.sp(17),
                                  fontWeight: FontWeight.w700,
                                ),
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
            SizedBox(height: 10),
          ],
        ),
      );

  Widget _deliveryCenters(dynamic productId, dynamic sbtType) => Consumer(
        builder: (context, ref, child) => FutureBuilder<Position>(
          future: Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return _deliverCentersLoader();
            }
            final userPosition = snapshot.data!;

            return ref.watch(warehouseListProvider(id: productId)).when(
                  data: (value) {
                    var deliveryCenterList = value.data
                        ?.where(
                          (e) =>
                              num.parse(
                                e.emptySpace.toString(),
                              ).toStringAsFixed(0) !=
                              "0",
                        )
                        .toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: deliveryCenterList?.length,
                      padding: Pad(all: 0),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, whIndex) {
                        var item = deliveryCenterList?[whIndex];

                        // Calculate distance
                        double? distanceKm;
                        if (item?.lat.toString().isNotEmpty == true &&
                            item?.long.toString().isNotEmpty == true) {
                          if (item?.lat != null && item?.long != null) {
                            distanceKm = _calculateDistance(
                              userPosition.latitude,
                              userPosition.longitude,
                              double.parse(item!.lat!),
                              double.parse(item.long!),
                            );
                            // Convert meters to kilometers
                          }
                        }
                        return InkWell(
                          onTap: () async {},
                          child: Card(
                            elevation: 1,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            surfaceTintColor: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      text:
                                                          "${item?.warehouseName}",
                                                      style: TextStyle(
                                                        color: ColorConstant
                                                            .maingreen,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: Adaptive.sp(
                                                          17,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (distanceKm != null)
                                                    Text(
                                                      "Distance: ${distanceKm.toStringAsFixed(1)} km",
                                                      style: TextStyle(
                                                        color: ColorConstant
                                                            .maingreen,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: Adaptive.sp(
                                                          14,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                MapsLauncher.launchQuery(
                                                  "${item?.warehouseAddress ?? ""}",
                                                );
                                              },
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!
                                                    .locateOnMap,
                                                style: TextStyle(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontWeight: FontWeight.bold,
                                                  decorationColor:
                                                      ColorConstant.maingreen,
                                                  fontSize: Adaptive.sp(17),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        "- ${item?.warehouseAddress}",
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: Pad(all: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.maingreen,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.charges,
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(17),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      sbtType.toString() == "1"
                                          ? Container(
                                              color: Colors.white,
                                              child: sbtType.toString() == "1"
                                                  ? Table(
                                                      border: TableBorder.all(
                                                        color: ColorConstant
                                                            .maingreen,
                                                      ),
                                                      children: [
                                                        TableRow(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  Pad(all: 10),
                                                              child: Text(
                                                                '${AppLocalizations.of(context)!.labourRate}  ${item?.labourRate ?? 0}₹ / per Bag.',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  Pad(all: 10),
                                                              child: Text(
                                                                '${AppLocalizations.of(context)!.weightShortageAllowance} - ${item?.wsa ?? 0}%',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        TableRow(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  Pad(all: 10),
                                                              child: Text(
                                                                '${AppLocalizations.of(context)!.buycommission} - ${item?.buyCommission ?? 0}%',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  Pad(all: 10),
                                                              child: Text(
                                                                '${AppLocalizations.of(context)!.sellcommission} - ${item?.sellCommission ?? 0}%',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive.sp(
                                                                          16),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // TableRow(
                                                        //   children: [
                                                        //     Padding(
                                                        //       padding: Pad(
                                                        //         all: 10,
                                                        //       ),
                                                        //       child: Text.rich(
                                                        //         TextSpan(
                                                        //           text: AppLocalizations
                                                        //                   .of(
                                                        //             context,
                                                        //           )!
                                                        //               .exitLoad,
                                                        //           children: [
                                                        //             TextSpan(
                                                        //               text:
                                                        //                   "\n${AppLocalizations.of(context)!.outwards}",
                                                        //               style:
                                                        //                   TextStyle(
                                                        //                 color: Colors
                                                        //                     .red,
                                                        //               ),
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //         style:
                                                        //             TextStyle(
                                                        //           fontSize:
                                                        //               Adaptive
                                                        //                   .sp(
                                                        //             16,
                                                        //           ),
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .bold,
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //     Padding(
                                                        //       padding: Pad(
                                                        //         all: 10,
                                                        //       ),
                                                        //       child: Text.rich(
                                                        //         TextSpan(
                                                        //           text:
                                                        //               '${AppLocalizations.of(context)!.weightShortageAllowance} - ${item?.wsa ?? 0}%  ',
                                                        //           children: [
                                                        //             TextSpan(
                                                        //               text:
                                                        //                   '\n${AppLocalizations.of(context)!.stockist}',
                                                        //               style:
                                                        //                   TextStyle(
                                                        //                 color: Colors
                                                        //                     .red,
                                                        //               ),
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //         style:
                                                        //             TextStyle(
                                                        //           fontSize:
                                                        //               Adaptive
                                                        //                   .sp(
                                                        //             16,
                                                        //           ),
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .bold,
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        TableRow(
                                                          children: [
                                                            Padding(
                                                              padding: Pad(
                                                                all: 10,
                                                              ),
                                                              child: Text.rich(
                                                                TextSpan(
                                                                  text:
                                                                      '${AppLocalizations.of(context)!.rent} - ${item?.rent ?? 0}\u{20B9} / per Qtl. / per month ',
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          '\n${AppLocalizations.of(context)!.stockist}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive
                                                                          .sp(
                                                                    16,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: Pad(
                                                                all: 10,
                                                              ),
                                                              child: Text(
                                                                '${AppLocalizations.of(context)!.balanceSpaceInMixedStacks} - ${item?.emptySpace ?? 0} (in Qtl.)',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive
                                                                          .sp(
                                                                    16,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // TableRow(children: [
                                                        //   Padding(padding:  Pad(all: 10), child: Text('Balance space in mixed Stacks - ${item?.emptySpace ?? 0} (in Qtl.)', style: TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold))),
                                                        //   Padding(padding:  Pad(all: 10), child: Text('', style: TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold))),
                                                        // ]),
                                                      ],
                                                    )
                                                  : Table(
                                                      border: TableBorder.all(
                                                        color: ColorConstant
                                                            .maingreen,
                                                      ),
                                                      children: [
                                                        TableRow(
                                                          children: [
                                                            Padding(
                                                              padding: Pad(
                                                                all: 10,
                                                              ),
                                                              child: Text(
                                                                '${AppLocalizations.of(context)!.labourRate} - ${item?.labourRate ?? 0}\u{20B9} / per Qtl.',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive
                                                                          .sp(
                                                                    16,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: Pad(
                                                                all: 10,
                                                              ),
                                                              child: Text.rich(
                                                                TextSpan(
                                                                  text:
                                                                      '${AppLocalizations.of(context)!.entryLoad} - ${item?.entryLoad ?? 0}% ',
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          '\n${AppLocalizations.of(context)!.seller}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive
                                                                          .sp(
                                                                    16,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // TableRow(children: [
                                                        //   Padding(padding:  Pad(all: 10), child: Text.rich(TextSpan(text: 'Exit Load - rent lock-in applicable  ', children: [TextSpan(text: '\Outwards', style: TextStyle(color: Colors.red))]), style: TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold))),
                                                        //   Padding(padding:  Pad(all: 10), child: Text.rich(TextSpan(text: 'Weight Shortage Allowance - ${item?.wsa ?? 0}%  ', children: [TextSpan(text: '\nStockist', style: TextStyle(color: Colors.red))]), style: TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold))),
                                                        // ]),
                                                        TableRow(
                                                          children: [
                                                            Padding(
                                                              padding: Pad(
                                                                all: 10,
                                                              ),
                                                              child: Text(
                                                                '${AppLocalizations.of(context)!.balanceSpaceInMixedStacks} - ${item?.emptySpace ?? 0} (in Qtl.)',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive
                                                                          .sp(
                                                                    16,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: Pad(
                                                                all: 10,
                                                              ),
                                                              child: Text.rich(
                                                                TextSpan(
                                                                  text: '',
                                                                  children: [
                                                                    TextSpan(
                                                                      text: '',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      Adaptive
                                                                          .sp(
                                                                    16,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // TableRow(children: [
                                                        //   Padding(padding:  Pad(all: 10), child: Text('Balance space in mixed Stacks - ${item?.emptySpace ?? 0} (in Qtl.)', style: TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold))),
                                                        //   Padding(padding:  Pad(all: 10), child: Text('', style: TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold))),
                                                        // ]),
                                                      ],
                                                    ),
                                            )
                                          : HtmlWidget(
                                              "${item?.content ?? ""}",
                                            ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   width: Get.width,
                                //   padding: Pad(all: 10),
                                //   decoration: BoxDecoration(
                                //       color: ColorConstant.maingreen,
                                //       borderRadius:  BorderRadius.only(
                                //         bottomRight: Radius.circular(8),
                                //         bottomLeft: Radius.circular(8),
                                //       )),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text.rich(TextSpan(text: 'Labour Rate - ${item?.labourRate ?? 0}r s / per Qtl.', style: TextStyle(fontSize: Adaptive.sp(17), color: Colors.white, fontWeight: FontWeight.bold), recognizer: TapGestureRecognizer()..onTap = () async {}, children: [])),
                                //       // Text.rich(TextSpan(
                                //       //     text: 'Delivery Centres',
                                //       //     style: TextStyle(fontSize: Adaptive.sp(17), color: Colors.white, fontWeight: FontWeight.bold),
                                //       //     recognizer: TapGestureRecognizer()
                                //       //       ..onTap = () async {
                                //       //
                                //       //         ref.watch(warehouseListProvider(id: "${data.data?[index].productId}").future).then((value) {
                                //       //
                                //       //         });
                                //       //       },
                                //       //     children: [])),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) => Container(
                    child: Center(
                      child: Text(
                        AppLocalizations.of(
                          context,
                        )!
                            .errorLoadingDeliveryCenters,
                      ),
                    ),
                  ),
                  loading: () => _deliverCentersLoader(),
                );
          },
        ),
      );
  double _calculateDistance(
      double userLat, double userLong, double centerLat, double centerLong) {
    return Geolocator.distanceBetween(
            userLat, userLong, centerLat, centerLong) /
        1000; // Convert meters to kilometers
  }

  Widget _commodityParamsLayout(
    dynamic productId,
    dynamic commodity,
  ) =>
      Consumer(
        builder: (context, ref, child) => ref
            .watch(productQualityProvider(id: "$productId"))
            .when(
              data: (value) => Padding(
                padding: EdgeInsets.only(left: 0.0, right: 0.0),
                child: ColumnSuper(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "${AppLocalizations.of(context)!.qualityParameters}  - $commodity",
                        style: TextStyle(
                          fontSize: Adaptive.sp(17),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Image and Video Section
                    Padding(
                      padding: Pad(bottom: 10),
                      child: RowSuper(
                        fill: true,
                        children: [
                          DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              ColorConstant.maingreen,
                            ),
                            showBottomBorder: true,
                            columnSpacing: 36,
                            headingTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: TableBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            columns: [
                              DataColumn(
                                label: Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.name,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .normal,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .extreme,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            rows: List.generate(
                              value.data?.length ?? 0,
                              (qualityIndex) => DataRow(
                                color: WidgetStateProperty.all(
                                  qualityIndex % 2 == 0
                                      ? Colors.white
                                      : Colors.grey.withOpacity(0.1),
                                ),
                                cells: [
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${value.data?[qualityIndex].parameters?.parameter ?? ""}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: Adaptive.sp(17),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${value.data?[qualityIndex].min ?? ""}',
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${value.data?[qualityIndex].max ?? ""}',
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(17),
                                          fontWeight: FontWeight.w700,
                                        ),
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
                    if (value.photos != null &&
                        (value.photos?.image != null ||
                            value.photos?.videos != null)) ...[
                      Padding(
                        padding: Pad(all: 15, top: 5, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.media,
                              style: TextStyle(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.maingreen,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image Section
                                if (value.photos?.image != null)
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorConstant.maingreen
                                                  .withOpacity(0.1),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.image_outlined,
                                                  size: 18,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                                SizedBox(width: 6),
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .image,
                                                  style: TextStyle(
                                                    fontSize: Adaptive.sp(
                                                      14,
                                                    ),
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        ColorConstant.maingreen,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                12,
                                              ),
                                              bottomRight: Radius.circular(
                                                12,
                                              ),
                                            ),
                                            child: InstaImageViewer(
                                              child: Image.network(
                                                '${ref.watch(dioProvider).options.baseUrl}${value.photos?.url ?? ""}${value.photos?.image ?? ""}',
                                                height: 180,
                                                width: double.infinity,
                                                fit: BoxFit.contain,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) =>
                                                    Container(
                                                  height: 180,
                                                  color: Colors.grey[200],
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .broken_image_outlined,
                                                          size: 50,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!
                                                              .imageNotAvailable,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize:
                                                                Adaptive.sp(
                                                              12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                loadingBuilder: (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Container(
                                                    height: 180,
                                                    color: Colors.grey[100],
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                        color: ColorConstant
                                                            .maingreen,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (value.photos?.image != null &&
                                    value.photos?.videos != null)
                                  SizedBox(width: 12),
                                // Video Section
                                if (value.photos?.videos != null)
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorConstant.maingreen
                                                  .withOpacity(0.1),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.video_library_outlined,
                                                  size: 18,
                                                  color:
                                                      ColorConstant.maingreen,
                                                ),
                                                SizedBox(width: 6),
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .video,
                                                  style: TextStyle(
                                                    fontSize: Adaptive.sp(
                                                      14,
                                                    ),
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        ColorConstant.maingreen,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _showVideoPlayer(
                                                context,
                                                '${ref.watch(dioProvider).options.baseUrl}${value.photos?.url ?? ""}${value.photos?.videos ?? ""}',
                                              );
                                            },
                                            child: Container(
                                              height: 180,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.black87,
                                                    Colors.black54,
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    12,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    12,
                                                  ),
                                                ),
                                              ),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                      20,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .maingreen
                                                          .withOpacity(0.3),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.play_arrow_rounded,
                                                      size: 50,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 12,
                                                    left: 12,
                                                    right: 12,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(
                                                          0.6,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          6,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.touch_app,
                                                            size: 16,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 6,
                                                          ),
                                                          Text(
                                                            AppLocalizations.of(
                                                              context,
                                                            )!
                                                                .tapToPlay,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                13,
                                                              ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
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
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                    SizedBox(height: 10),
                  ],
                ),
              ),
              error: (e, s) => Container(),
              loading: () => _commodityParamsLoader(),
            ),
      );

  Color _sbtTypeColor(String? sbtType) {
    if (sbtType == '2') {
      return Colors.amber.shade900;
    }
    if (sbtType == '1') {
      return ColorConstant.maingreen;
    }
    return ColorConstant.red500;
  }

  Widget _buildPriceRow({required String label, required String value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppStyle.mystoke.copyWith(
            fontSize: Adaptive.sp(17),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Text(
            value,
            style: AppStyle.mystoke.copyWith(
              fontSize: Adaptive.sp(17),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  _handleBuyOption(
    dynamic dataList,
    dynamic mainIndex,
    BuildContext bottomsheetContext,
    double quantity,
    double price,
  ) {
    final buyQty = ref.read(buyWeight);
    ElevarmConfirmAlertDialog(
      title: AppLocalizations.of(context)!.areYouSure,
      subtitle:
          '${AppLocalizations.of(context)!.commodityPrice}: ${price.toString()}\n${AppLocalizations.of(context)!.commodityWeight}: $buyQty in Quintal',
      onPositiveButton: () {
        Get.back();
        context.showLoader();

        ref
            .read(
          checkForUserWalletProvider(
            districtId: dataList[mainIndex ?? 0].districtId.toString(),
            commodity: dataList[mainIndex ?? 0].commodityId.toString(),
            productId: dataList[mainIndex ?? 0].productId.toString(),
            qty: buyQty.toString(),
            type: "1",
            //bnpl or finance type
            price: price.toString(),
            loanType: null, // 0
          ).future,
        )
            .then((value) async {
          context.hideloader();
          if (value["error"].toString().toLowerCase() == "no") {
            context.showLoader();
            ref
                .read(
              postSbtProvider(
                productId: "${dataList[mainIndex ?? 0].productId}",
                commodityId: "${dataList[mainIndex ?? 0].commodityId}",
                district_id: "${dataList[mainIndex ?? 0].districtId}",
                qty: "$quantity",
                price: "$price",
                type: "1",
                loanType: null,
              ).future,
            )
                .then((value) {
              context.hideloader();
              if (value['status'].toString() == "1") {
                Navigator.of(bottomsheetContext).pop();

                Fluttertoast.showToast(
                  msg: value['message'],
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.green,
                );
              }
            }).onError((e, s) {
              context.hideloader();
            });
          } else {
             if (value['status'].toString() == "0") {
  // Error message already surfaced by the global Dio response interceptor.
  return;
}
               final errorType = value['error_type']?.toString().toLowerCase() ?? '';
  final walletType = value['wallet_type']?.toString().toLowerCase() ?? '';
          if (errorType == 'wallet' && walletType == 'finance') {
            
                showModalBottomSheet(
                  context: context,
                  builder: (bottomsheetContext) => ElevarmDraggableBottomSheet(
                    title: AppLocalizations.of(
                      context,
                    )!
                        .youDontHaveSufficientBalance,
                    onPressedClose: () => Get.back(),
                    footerWidget: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              context.showLoader();
                              ref
                                  .read(
                                checkForUserWalletProvider(
                                  districtId: dataList[mainIndex ?? 0]
                                      .districtId
                                      .toString(),
                                  commodity: dataList[mainIndex ?? 0]
                                      .commodityId
                                      .toString(),
                                  productId: dataList[mainIndex ?? 0]
                                      .productId
                                      .toString(),
                                  qty: ref.watch(buyWeight).toString(),
                                  type: "1",
                                  //bnpl or finance type
                                  price: price.toString(),
                                  loanType: "1", // 0
                                ).future,
                              )
                                  .then((value) {
                                context.hideloader();
                                if (value['wallet_type'] != null) {
                                  if (value['error'].toString().toLowerCase() ==
                                          "yes" &&
                                      value['wallet_type']
                                              .toString()
                                              .toLowerCase() ==
                                          "bnpl") {
                                    Get.back(
                                      canPop: true,
                                      closeOverlays: true,
                                    );
                                    Get.to(
                                      AddMoney(
                                        isAppBarVisible: true,
                                      ),
                                    );
                                  } else {
                                    context.hideloader();
                                    ref
                                        .read(
                                      postSbtProvider(
                                        productId:
                                            "${dataList[mainIndex ?? 0].productId}",
                                        commodityId:
                                            "${dataList[mainIndex ?? 0].commodityId}",
                                        district_id:
                                            "${dataList[mainIndex ?? 0].districtId}",
                                        qty: "${ref.watch(buyWeight)}",
                                        price: price.toString(),
                                        type: "1",
                                        loanType: "1",
                                        schemeId: null,
                                      ).future,
                                    )
                                        .then((value) {
                                      context.hideloader();
                                      Get.back(
                                        canPop: true,
                                        closeOverlays: true,
                                      );

                                      if (value['status'].toString() == "1") {
                                        Fluttertoast.showToast(
                                          msg: value['message'],
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: Colors.green,
                                        );
                                      }
                                    }).onError((e, s) {
                                      context.hideloader();
                                      Get.back(
                                        canPop: true,
                                        closeOverlays: true,
                                      );
                                    });
                                  }
                                }
                              }).onError((e, s) {
                                context.hideloader();

                                Get.back(
                                  canPop: true,
                                  closeOverlays: true,
                                );
                              });
                            },
                            style: AppStyle.buttonStyle,
                            child: Text(
                              AppLocalizations.of(context)!.wallet,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(17),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              context.showLoader();
                              ref
                                  .read(
                                checkForUserWalletProvider(
                                  districtId: dataList[mainIndex ?? 0]
                                      .districtId
                                      .toString(),
                                  commodity: dataList[mainIndex ?? 0]
                                      .commodityId
                                      .toString(),
                                  productId: dataList[mainIndex ?? 0]
                                      .productId
                                      .toString(),
                                  qty: ref.watch(buyWeight).toString(),
                                  type: "1",
                                  //bnpl or finance type
                                  price: price.toString(),
                                  loanType: "2", // 0
                                ).future,
                              )
                                  .then((value) async {
                                context.hideloader();
                                if (value['wallet_type'] != null) {
                                  if (value['error'].toString().toLowerCase() ==
                                          "yes" &&
                                      value['error_type']
                                              .toString()
                                              .toLowerCase() ==
                                          "finance") {
                                    await LaunchApp.openApp(
                                      androidPackageName: 'com.swfl.swfl',
                                    );

                                    Get.back(
                                      canPop: true,
                                      closeOverlays: true,
                                    );
                                  } else {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (
                                        bottomsheetContext,
                                      ) =>
                                          ElevarmDraggableBottomSheet(
                                        title: AppLocalizations.of(
                                          context,
                                        )!
                                            .pleaseSelectScheme,
                                        onPressedClose: () => Get.back(),
                                        children: [
                                          Consumer(
                                            builder: (
                                              context,
                                              ref,
                                              child,
                                            ) =>
                                                SizedBox(
                                              height: Get.height / 2,
                                              width: Get.width,
                                              child: value['data'] == null
                                                  ? Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!
                                                          .noData,
                                                    )
                                                  : ColumnSuper(
                                                      children: [
                                                        Container(
                                                          padding: Pad(
                                                            all: 10,
                                                          ),
                                                          color: ColorConstant
                                                              .maingreen,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .action,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      17,
                                                                    ),
                                                                    shadows: [
                                                                      Shadow(
                                                                        color: Colors
                                                                            .white,
                                                                        blurRadius:
                                                                            1,
                                                                        offset:
                                                                            Offset(
                                                                          0.2,
                                                                          0.2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .schemeName,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      17,
                                                                    ),
                                                                    shadows: [
                                                                      Shadow(
                                                                        color: Colors
                                                                            .white,
                                                                        blurRadius:
                                                                            1,
                                                                        offset:
                                                                            Offset(
                                                                          0.2,
                                                                          0.2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .pf1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      17,
                                                                    ),
                                                                    shadows: [
                                                                      Shadow(
                                                                        color: Colors
                                                                            .white,
                                                                        blurRadius:
                                                                            1,
                                                                        offset:
                                                                            Offset(
                                                                          0.2,
                                                                          0.2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .interestRate1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      17,
                                                                    ),
                                                                    shadows: [
                                                                      Shadow(
                                                                        color: Colors
                                                                            .white,
                                                                        blurRadius:
                                                                            1,
                                                                        offset:
                                                                            Offset(
                                                                          0.2,
                                                                          0.2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .ltv1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      17,
                                                                    ),
                                                                    shadows: [
                                                                      Shadow(
                                                                        color: Colors
                                                                            .white,
                                                                        blurRadius:
                                                                            1,
                                                                        offset:
                                                                            Offset(
                                                                          0.2,
                                                                          0.2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .tenor,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      17,
                                                                    ),
                                                                    shadows: [
                                                                      Shadow(
                                                                        color: Colors
                                                                            .white,
                                                                        blurRadius:
                                                                            1,
                                                                        offset:
                                                                            Offset(
                                                                          0.2,
                                                                          0.2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Expanded(
                                                              //     child: Text("Days",
                                                              //         textAlign: TextAlign.center,
                                                              //         style: TextStyle(
                                                              //             fontSize: Adaptive.sp(17),
                                                              //             shadows:  [
                                                              //               Shadow(
                                                              //                   color: Colors.white,
                                                              //                   blurRadius: 1,
                                                              //                   offset: Offset(0.2, 0.2))
                                                              //             ],
                                                              //             color: Colors.white,
                                                              //             fontWeight: FontWeight.w800)))
                                                            ],
                                                          ),
                                                        ),
                                                        ListView.builder(
                                                          itemCount: value[
                                                                          'data']
                                                                      [
                                                                      'schemes']
                                                                  ?.length ??
                                                              0,
                                                          shrinkWrap: true,
                                                          itemBuilder: (
                                                            context,
                                                            index,
                                                          ) =>
                                                              value['data']['schemes'][index]
                                                                              [
                                                                              'scheme_name']
                                                                          .toString()
                                                                          .toLowerCase()
                                                                          .trim() ==
                                                                      "bnpl takeover"
                                                                  ? SizedBox()
                                                                  : Container(
                                                                      color: index % 2 ==
                                                                              0
                                                                          ? Colors
                                                                              .grey
                                                                              .withOpacity(
                                                                              0.1,
                                                                            )
                                                                          : Colors
                                                                              .white,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            Pad(
                                                                          all:
                                                                              10,
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Checkbox(
                                                                                activeColor: ColorConstant.maingreen,
                                                                                value: ref.watch(
                                                                                      selectedIndex,
                                                                                    ) ==
                                                                                    index,
                                                                                onChanged: (
                                                                                  isSelected,
                                                                                ) {
                                                                                  if (isSelected ?? false) {
                                                                                    ref
                                                                                        .watch(
                                                                                          selectedIndex.notifier,
                                                                                        )
                                                                                        .state = index;
                                                                                  } else {
                                                                                    ref.invalidate(
                                                                                      selectedIndex,
                                                                                    );
                                                                                  }
                                                                                  setState(
                                                                                    () {},
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                "${value['data']['schemes'][index]['scheme_name'] ?? ""}",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: Adaptive.sp(
                                                                                    17,
                                                                                  ),
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: Colors.white,
                                                                                      blurRadius: 1,
                                                                                      offset: Offset(
                                                                                        0.2,
                                                                                        0.2,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w800,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                "${value['data']['schemes'][index]['processing_fee'] ?? ""}",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: Adaptive.sp(
                                                                                    17,
                                                                                  ),
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: Colors.white,
                                                                                      blurRadius: 1,
                                                                                      offset: Offset(
                                                                                        0.2,
                                                                                        0.2,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w800,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                "${value['data']['schemes'][index]['interest_rate'] ?? ""}",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: Adaptive.sp(
                                                                                    17,
                                                                                  ),
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: Colors.white,
                                                                                      blurRadius: 1,
                                                                                      offset: Offset(
                                                                                        0.2,
                                                                                        0.2,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w800,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                "${value['data']['schemes'][index]['ltv'] ?? ""}",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: Adaptive.sp(
                                                                                    17,
                                                                                  ),
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: Colors.white,
                                                                                      blurRadius: 1,
                                                                                      offset: Offset(
                                                                                        0.2,
                                                                                        0.2,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w800,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                "${value['data']['schemes'][index]['tenor']} ${value['data']['schemes'][index]['tenor_type']}",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: Adaptive.sp(
                                                                                    17,
                                                                                  ),
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      color: Colors.white,
                                                                                      blurRadius: 1,
                                                                                      offset: Offset(
                                                                                        0.2,
                                                                                        0.2,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w800,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            // Expanded(
                                                                            //     child: Text(
                                                                            //         data.data?[index]
                                                                            //                 .loanPassDays ??
                                                                            //             "",,
                                                                            //         textAlign: TextAlign.center,
                                                                            //         style: TextStyle(
                                                                            //             fontSize: Adaptive.sp(17),
                                                                            //             shadows:  [
                                                                            //               Shadow(
                                                                            //                   color: Colors.white,
                                                                            //                   blurRadius: 1,
                                                                            //                   offset: Offset(
                                                                            //                       0.2, 0.2))
                                                                            //             ],
                                                                            //             color: Colors.black,
                                                                            //             fontWeight:
                                                                            //                 FontWeight.w800)))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        SizedBox(
                                                          width: Get.width,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              if (ref.watch(
                                                                    selectedIndex,
                                                                  ) ==
                                                                  null) {
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg: AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .pleaseSelectScheme,
                                                                );
                                                              } else {
                                                                context
                                                                    .showLoader();
                                                                ref
                                                                    .read(
                                                                  postSbtProvider(
                                                                    productId:
                                                                        "${dataList[mainIndex ?? 0].productId}",
                                                                    commodityId:
                                                                        "${dataList[mainIndex ?? 0].commodityId}",
                                                                    district_id:
                                                                        "${dataList[mainIndex ?? 0].districtId}",
                                                                    qty:
                                                                        "${ref.watch(buyWeight)}",
                                                                    price: price
                                                                        .toString(),
                                                                    type: "1",
                                                                    loanType:
                                                                        "2",
                                                                    schemeId:
                                                                        "${value['data']['schemes'][ref.watch(selectedIndex)]['id']}",
                                                                  ).future,
                                                                )
                                                                    .then(
                                                                  (
                                                                    value,
                                                                  ) {
                                                                    context
                                                                        .hideloader();
                                                                    if (value['status']
                                                                            .toString() ==
                                                                        "0") {
                                                                    } else {
                                                                      Get.back(
                                                                        closeOverlays:
                                                                            true,
                                                                        canPop:
                                                                            true,
                                                                      );
                                                                    }
                                                                  },
                                                                ).onError(
                                                                  (
                                                                    e,
                                                                    s,
                                                                  ) {
                                                                    context
                                                                        .hideloader();
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            style: AppStyle
                                                                .buttonStyle,
                                                            child: Text(
                                                              "Apply",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }).onError((e, s) {
                                context.hideloader();
                              });
                            },
                            style: AppStyle.buttonStyle.copyWith(
                              backgroundColor: WidgetStateProperty.all(
                                Colors.amber,
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!
                                  .purchaseFinance,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(17),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: Pad(all: 10),
                        child: Column(
                          children: [
                            // Image.asset('assets/images/swfl.png'),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!
                                  .youDontHaveSufficientBalance,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(17),
                              ),
                            ),
                            SizedBox(height: 10),

                            SizedBox(height: 10, child: Divider()),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              
            }

            else if (value['error_type'].toString().toLowerCase() == 'wallet') {
      Fluttertoast.showToast(
        msg: value['message']?.toString() ??
            'Insufficient balance. Please add funds to your wallet.',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
          }
        }).onError((e, s) {});
      },
      onNegativeButton: () {
        Get.back();
      },
      positiveText: AppLocalizations.of(context)!.msgSubmit,
      negativeText: AppLocalizations.of(context)!.msgNo,
      variant: ElevarmDialogVariant.success,
    ).show(context);
  }

  void _showVideoPlayer(BuildContext context, String videoUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: VideoPlayerDialog(videoUrl: videoUrl),
      ),
    );
  }
}

class VideoPlayerDialog extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerDialog({super.key, required this.videoUrl});

  @override
  State<VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: ColorConstant.maingreen,
          handleColor: ColorConstant.maingreen,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.white70,
        ),
        placeholder: Container(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(color: ColorConstant.maingreen),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 48),
                SizedBox(height: 16),
                Text(
                  'Error loading video',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        maxWidth: MediaQuery.of(context).size.width * 0.95,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            if (_isInitialized && _chewieController != null)
              Center(
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: Chewie(controller: _chewieController!),
                ),
              )
            else if (_hasError)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline, color: Colors.white, size: 48),
                      SizedBox(height: 16),
                      Text(
                        'Failed to load video',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: ColorConstant.maingreen),
                    SizedBox(height: 16),
                    Text(
                      'Loading video...',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.black.withOpacity(0.5),
                shape: CircleBorder(),
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 24),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Close',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
