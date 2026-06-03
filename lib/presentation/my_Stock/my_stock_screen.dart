// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';

import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/home_screen/bank_list_screen.dart';
import 'package:apnagodam/presentation/home_screen/stock_summary.dart';
import 'package:apnagodam/presentation/market_screen/service/market_service.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/stock_response_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_service.dart';
import 'package:apnagodam/presentation/my_Stock/stacksListing/StacksListing.dart';
import 'package:apnagodam/presentation/pdf/pdf_service/pdf_service.dart';
import 'package:apnagodam/widgets/pdf/pdf.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:standard_searchbar/old/standard_searchbar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/comman_dailog.dart';
import '../../core/utils/helper.dart';
import '../../widgets/CommonTextField.dart';
import '../../widgets/dailogs/error.dart';
import '../credit/credit_screen.dart';
import '../home_screen/kyc.dart';
import '../market_screen/bindding.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

final debouncer = Debouncer(delay: Duration(milliseconds: 500));
final debouncerPaging = Debouncer(delay: Duration(milliseconds: 1000));

class MyStockScreen extends ConsumerStatefulWidget {
  final comodityTag;
  final commodityid;
  final salesStutas;

  const MyStockScreen({
    super.key,
    this.comodityTag,
    this.commodityid,
    this.salesStutas,
  });

  @override
  ConsumerState<MyStockScreen> createState() => _MyStockScreenState();
}

class _MyStockScreenState extends ConsumerState<MyStockScreen> {
  int page = 1;
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController emandiSellPriceController = TextEditingController();
  TextEditingController emandiSellWeightController = TextEditingController();

  var totalData;
  var nextUrl;

  bool lytBal = false;
  bool btnSubmit = false;
  bool lytWallet = false;
  bool msgAlert = false;

  double? totalPayableAmt = 0.0;
  double? finalPendingAmt = 0.0;
  double? approxDealAmt = 0.0;
  double? finalInterestRent = 0.0;
  double? totalPendingAmt = 0.0;
  double? balanceAmt = 0.0;

  double? netWeight = 0.0;
  double? bidPrice = 0.0;
  double? actualAmountDeal = 0.0;
  double? remBalanceAmt = 0.0;
  double? walletSettlementAmt = 0.0;
  double? walletPower = 0.0;
  double? remCapUser = 0.0;
  double? walletRemaningAmt = 0.0;
  double? submitButtonValue = 0.0;

  double? wrb = 0.0;

  double? resultDealPayment = 0.0;
  double? effectivePending = 0.0;
  double? mandiTax = 0.0;

  double? quantityActualAmountDay = 0.0;
  double? quantityFinalAmount = 0.0;

  double? priceValve = 0.0;
  double? weight = 0.0;
  double? qualityClaimData = 0.0;

  String profileBase = "";
  String passbookBase = "";
  String panBase = "";
  String gstBase = "";
  String aadharBase = "";
  String note = "";
  final ScrollController _scrollController = ScrollController();
  var stockList = StateProvider<List<Datum?>>((ref) => []);
  var searchProvider = StateProvider((ref) => '');
  var pageProvider = StateProvider((ref) => 0);
  var lastPageProvider = StateProvider((ref) => 1);
  var isLoading = StateProvider((ref) => false);
  var isPaginating = StateProvider((ref) => false);
  var hasMoreDataProvider = StateProvider((ref) => true);
  var selectedTabIndex = StateProvider((ref) => 0);
  var selectedLienTabIndex = StateProvider((ref) => 0);
  static const int _pageSize = 10;
  List<Map<String, dynamic>> get tabs => [
        {
          "label": AppLocalizations.of(context)!.stackWise,
          "index": 0,
          "icon": Icons.layers,
        },
        {
          "label": AppLocalizations.of(context)!.gatepassWise,
          "index": 1,
          "icon": Icons.qr_code_2,
        },
        {
          "label": AppLocalizations.of(context)!.msgSummary,
          "index": 2,
          "icon": Icons.receipt_long,
        },
      ];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var isLoggedIn = ref.watch(authProvider).value;
      if (isLoggedIn == AuthStatus.loggedIn) {
        _initializeStockData();
      }
    });

    _scrollController.addListener(_loadMoreData);
  }

  Future<void> _initializeStockData() async {
    ref.read(isLoading.notifier).state = true;
    ref.read(isPaginating.notifier).state = false;
    ref.read(hasMoreDataProvider.notifier).state = true;
    ref.read(pageProvider.notifier).state = 0;
    ref.read(selectedLienTabIndex.notifier).state = 0;

    try {
      final value = await ref.read(
        myStockProvider(page: '0', search: '', limit: '$_pageSize').future,
      );
      ref.read(stockList.notifier).state = value;
      ref.read(hasMoreDataProvider.notifier).state = value.length >= _pageSize;
    } catch (e) {
      ref.read(hasMoreDataProvider.notifier).state = false;
      debugPrint("Error initializing stock data: $e");
    } finally {
      ref.read(isLoading.notifier).state = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreData() async {
    if (ref.read(selectedTabIndex) != 1) return;
    if (ref.read(searchProvider).toString().isNotEmpty) return;
    if (ref.read(isLoading)) return;
    if (ref.read(isPaginating)) return;
    if (!ref.read(hasMoreDataProvider)) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      // Adding a small threshold (100 px) to trigger a bit earlier
      debouncerPaging.call(() async {
        final currentPage = ref.read(pageProvider);
        ref.read(isPaginating.notifier).state = true;

        try {
          final nextPage = currentPage + 1;
          final newData = await ref.read(
            myStockProvider(page: '$nextPage', search: '', limit: '$_pageSize')
                .future,
          );

          final existingList = ref.read(stockList);
          final existingIds = existingList
              .where((item) => item?.id != null)
              .map((item) => item!.id.toString())
              .toSet();

          final uniqueNewData = newData
              .where((item) => !existingIds.contains(item.id?.toString()))
              .toList();

          ref.read(stockList.notifier).state = [
            ...existingList,
            ...uniqueNewData,
          ];

          ref.read(pageProvider.notifier).state = nextPage;
          ref.read(hasMoreDataProvider.notifier).state =
              newData.length >= _pageSize;
        } catch (e) {
          debugPrint("Error loading more stock data: $e");
        } finally {
          ref.read(isPaginating.notifier).state = false;
        }
      });
    }
  }

  void _handleSearch(String value) {
    debouncer.call(() async {
      if (value.isEmpty) {
        ref.read(searchProvider.notifier).state = '';
        await _initializeStockData();
        return;
      }

      ref.read(isLoading.notifier).state = true;
      ref.read(isPaginating.notifier).state = false;
      ref.read(hasMoreDataProvider.notifier).state = false;
      try {
        final result = await ref.read(
          myStockProvider(search: value, page: '0', limit: '$_pageSize').future,
        );
        ref.read(stockList.notifier).state = result;
      } catch (e) {
        debugPrint("Search error: $e");
      } finally {
        ref.read(isLoading.notifier).state = false;
      }

      ref.read(searchProvider.notifier).state = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ColorConstant.maingreen,
      //   title: Text(
      //     AppLocalizations.of(context)!.msgMystock,
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     widget.comodityTag == ""
      //         ? SizedBox()
      //         : Expanded(
      //             child: Text(
      //               " " + widget.comodityTag.toString(),
      //               style: AppStyle.lblAppbar.copyWith(fontSize: 14),
      //               maxLines: 1,
      //               textAlign: TextAlign.center,
      //               overflow: TextOverflow.ellipsis,
      //             ),
      //           ),
      //   ],
      // ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(padding: Pad(all: 10),child: titleWidget(text: 'Filter By:-',fontSize: ElevarmFontSizes.md),),
            Padding(
              padding: Pad(all: 10),
              child: Wrap(
                spacing: 8,
                runSpacing: 10,
                children: List.generate(tabs.length, (i) {
                  final tab = tabs[i];
                  final isSelected =
                      ref.watch(selectedTabIndex) == tab['index'];

                  return InkWell(
                    onTap: () {
                      Future.delayed(Duration(milliseconds: 100), () {
                        if (tab['index'] as int == 0) {
                          _initializeStockData();
                        }
                      });
                      ref.read(selectedTabIndex.notifier).state = int.parse(
                        tab['index'].toString(),
                      );
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      padding: Pad(left: 12, right: 12, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? ColorConstant.maingreen : Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: ColorConstant.maingreen,
                          width: 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            tab['icon'] as IconData,
                            size: 16,
                            color: isSelected
                                ? Colors.white
                                : ColorConstant.maingreen,
                          ),
                          SizedBox(width: 6),
                          Text(
                            tab['label'] as String,
                            style: TextStyle(
                              fontSize: Adaptive.sp(14),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            ref.watch(authProvider).when(
                  data: (data) => Expanded(
                    child: ref.watch(selectedTabIndex) == 1
                        ? data == AuthStatus.loggedOut
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/mainlogopng.png',
                                      height: 150,
                                      width: 150,
                                    ),
                                    simpleButton(
                                      text: AppLocalizations.of(
                                        context,
                                      )!
                                          .loginToViewYourGatepasses2,
                                      callback: () => showLoginBottomsheet(
                                        context,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: Pad(all: 10),
                                    child: StandardSearchBar(
                                      cursorColor: ColorConstant.maingreen,
                                      startIconColor: ColorConstant.maingreen,
                                      borderRadius: 8,
                                      onChanged: (value) {
                                        _handleSearch(value);
                                      },
                                      onSubmitted: (value) {
                                        _handleSearch(value);
                                      },
                                    ),
                                  ),
                                  Consumer(
                                    builder: (context, ref, child) =>
                                        _gatepassInventoriesLayout(),
                                  ),
                                ],
                              )
                        : ref.watch(selectedTabIndex) == 0
                            ? data == AuthStatus.loggedOut
                                ? Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/images/mainlogopng.png',
                                          height: 150,
                                          width: 150,
                                        ),
                                        simpleButton(
                                          text: AppLocalizations.of(
                                            context,
                                          )!
                                              .loginToViewYourStacks2,
                                          callback: () => showLoginBottomsheet(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Stackslisting()
                            : data == AuthStatus.loggedOut
                                ? Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/images/mainlogopng.png',
                                          height: 150,
                                          width: 150,
                                        ),
                                        simpleButton(
                                          text: AppLocalizations.of(
                                            context,
                                          )!
                                              .loginToViewYourStockSummary2,
                                          callback: () =>
                                              showLoginBottomsheet(context),
                                        ),
                                      ],
                                    ),
                                  )
                                : StockSummary(),
                  ),
                  error: (e, s) => Container(),
                  loading: () => Container(),
                ),
          ],
        ),
      ),
    );
  }

  Widget _gatepassInventoriesLayout() => Expanded(
        child: Column(
          children: [
            Padding(
              padding: Pad(left: 10, right: 10, top: 4, bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: _buildLienTab(
                      title: 'Unlien',
                      count: _getFilteredGatepassItems(isUnlien: true).length,
                      isSelected: ref.watch(selectedLienTabIndex) == 0,
                      onTap: () =>
                          ref.read(selectedLienTabIndex.notifier).state = 0,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildLienTab(
                      title: 'Lien',
                      count: _getFilteredGatepassItems(isUnlien: false).length,
                      isSelected: ref.watch(selectedLienTabIndex) == 1,
                      onTap: () =>
                          ref.read(selectedLienTabIndex.notifier).state = 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Skeletonizer(
                enabled: ref.watch(isLoading),
                child: Builder(
                  builder: (context) {
                    final loadingInitial = ref.watch(isLoading);
                    final paginating = ref.watch(isPaginating);
                    final showingUnlien = ref.watch(selectedLienTabIndex) == 0;
                    final filteredItems = loadingInitial
                        ? <Map<String, dynamic>>[]
                        : _getFilteredGatepassItems(isUnlien: showingUnlien);

                    if (!loadingInitial && filteredItems.isEmpty) {
                      return Center(
                        child: Text(
                          showingUnlien
                              ? 'No Unlien stocks found'
                              : 'No Lien stocks found',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: loadingInitial
                          ? 3
                          : filteredItems.length + (paginating ? 1 : 0),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (!loadingInitial &&
                            paginating &&
                            index == filteredItems.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                          );
                        }

                        var item = loadingInitial
                            ? null
                            : filteredItems[index]['item'] as Datum?;
                        final itemIndex = loadingInitial
                            ? index
                            : filteredItems[index]['originalIndex'] as int;
                        return Card(
                          color: Colors.white,
                          margin: Pad(all: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color:
                                    ColorConstant.maingreen.withOpacity(0.3)),
                          ),
                          surfaceTintColor: Colors.white,
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ColumnSuper(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${IMAGE_BASE_URL}category/${item?.image}",
                                        height: Adaptive.sp(28),
                                        width: Adaptive.sp(28),
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          text:
                                              '${"${item?.catName ?? ""} ${item?.salesStatus.toString() == "1" ? AppLocalizations.of(context)!.msgKisasni : AppLocalizations.of(context)!.taxPaid2}"}\n',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.maingreen,
                                            fontSize: Adaptive.sp(16),
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "${item?.name.toString()}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: Pad(left: 10, right: 10, top: 0),
                                      child: Row(
                                        children: [
                                          // Text.rich(TextSpan(
                                          //     text:
                                          //         '${item!.catName.toString() + " " + (item?.salesStatus.toString() == "1" ? AppLocalizations.of(context)!.kisaniMsg : AppLocalizations.of(context)!.taxPaid2)}',
                                          //     style: TextStyle(
                                          //         fontWeight: FontWeight.bold,
                                          //         fontSize: Adaptive.sp(15)))),
                                          // Spacer(),
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  '${AppLocalizations.of(context)!.msgExpirydate} \n${item?.catExpDate == null ? "" : DateFormat('MM-dd-yyyy').format(item?.catExpDate!).toString()}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(15),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () async {
                                    //     await Get.to(GraphScreen(
                                    //       id: '${item?.id}',
                                    //       wichtag: "mystock",
                                    //     ));
                                    //   },
                                    //   child: RowSuper(
                                    //     fitHorizontally: true,
                                    //     children: [
                                    //       Text(
                                    //         AppLocalizations.of(context)!.msgViewgraph,
                                    //         style: TextStyle(
                                    //             fontSize: Adaptive.sp(15),
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Colors.blue),
                                    //       ),
                                    //       Icon(
                                    //         Icons.auto_graph_rounded,
                                    //         color: Colors.blue,
                                    //         size: Adaptive.sp(15),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: ColumnSuper(
                                              alignment: Alignment.centerLeft,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text: AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .msgGatepass,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: Adaptive.sp(15),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            "${item?.gatePassWr}",
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () =>
                                                                  _generatePdfAndNavigate(
                                                                    item,
                                                                  ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    text: AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .msgWeightt,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: Adaptive.sp(15),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            "${item?.quantity ?? 0.0}",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .msgBags,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: Adaptive.sp(15),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              "${item?.bags}"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .msgStackno,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(15),
                                              ),
                                              children: [
                                                TextSpan(
                                                    text: "${item?.stackNo}")
                                              ],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .quality,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(15),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      " : ${AppLocalizations.of(context)!.clickHere}",
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () =>
                                                            _showQualityData(
                                                                item),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (item?.ownership.toString() == "1")
                                            Column(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text: AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .vehicleNo,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            ': ${item?.vehicleNo}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                              Adaptive.sp(14),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: Adaptive.sp(14),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: item?.financesId == null ||
                                          item?.financesStatus == null,
                                      child: Expanded(
                                        child: ElevatedButton(
                                          style: AppStyle.buttonStyle,
                                          onPressed: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            if (item?.sellQuantity != null) {
                                              CommanDialog(
                                                context,
                                                "",
                                                AppLocalizations.of(context)!
                                                    .loanopencase,
                                                (bool userClickedOK) {
                                                  if (userClickedOK) {
                                                    // CallLaunch('tel:7733901154');
                                                    Navigator.of(
                                                      context,
                                                      rootNavigator: true,
                                                    ).pop();
                                                  } else {
                                                    Navigator.of(
                                                      context,
                                                      rootNavigator: true,
                                                    ).pop();
                                                  }
                                                },
                                              );
                                            } else {
                                              checkLoanAction(
                                                ref,
                                                itemIndex,
                                                context,
                                                item!,
                                                ref.watch(listOfBanks),
                                              );
                                            }
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .msgApplyloan,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: Adaptive.sp(16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Stack(
                                      fit: StackFit.loose,
                                      children: [
                                        Visibility(
                                          visible: item?.financesStatus == 0,
                                          child: Row(children: []),
                                        ),
                                        Visibility(
                                          visible: item?.financesStatus == 0 ||
                                              item?.financesStatus == 3,
                                          child: ElevatedButton(
                                            style: AppStyle.buttonStyle,
                                            onPressed: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              if (item?.sellQuantity != null) {
                                                CommanDialog(
                                                  context,
                                                  "",
                                                  AppLocalizations.of(context)!
                                                      .loanopencase,
                                                  (bool userClickedOK) {
                                                    if (userClickedOK) {
                                                      CallLaunch(
                                                          'tel:7733901154');
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                );
                                              } else {
                                                checkLoanAction(
                                                  ref,
                                                  itemIndex,
                                                  context,
                                                  item!,
                                                  ref.watch(listOfBanks),
                                                );
                                              }
                                            },
                                            child: FittedBox(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .reapply,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: Adaptive.sp(14),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: item?.financesStatus == 2 ||
                                              item?.checkLoanCount == 1,
                                          child: Column(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .approvedloan,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 17, 32, 17),
                                                  fontSize: Adaptive.sp(14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: item?.financesId != null,
                                      child: Expanded(
                                        child: Visibility(
                                          visible: item?.financesStatus == 1,
                                          child: ElevatedButton(
                                            style:
                                                AppStyle.buttonStyle.copyWith(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                Colors.transparent
                                                    .withOpacity(0.0),
                                              ),
                                              shape: WidgetStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: BorderSide(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            onPressed: null,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .loanapplied,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red,
                                                fontSize: Adaptive.sp(14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Visibility(
                                      visible: true,
                                      child: Expanded(
                                        child: ElevatedButton(
                                          style: AppStyle.buttonStyle,
                                          onPressed: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            // Handle button click
                                            if (item?.financesStatus != null) {
                                              if (item?.financesStatus == 2) {
                                                wantToSell(
                                                  itemIndex,
                                                  context,
                                                  item!,
                                                  ref,
                                                );
                                              } else if (item?.financesStatus !=
                                                  1) {
                                                wantToSell(
                                                  itemIndex,
                                                  context,
                                                  item!,
                                                  ref,
                                                );
                                              } else {
                                                wantToSell(
                                                  itemIndex,
                                                  context,
                                                  item!,
                                                  ref,
                                                );
                                              }
                                            } else {
                                              wantToSell(
                                                itemIndex,
                                                context,
                                                item!,
                                                ref,
                                              );
                                            }
                                          },
                                          child: FittedBox(
                                            child: Text(
                                              item?.sellQuantity != null
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .updatePrice
                                                  : AppLocalizations.of(
                                                      context,
                                                    )!
                                                      .msgWanttosell,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: Adaptive.sp(16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Visibility(
                                      visible: item?.sellQuantity != null,
                                      child: Expanded(
                                        child: ElevatedButton(
                                          style: AppStyle.buttonStyle.copyWith(
                                            backgroundColor:
                                                WidgetStateProperty.resolveWith(
                                              (states) =>
                                                  ColorConstant.orangeA200,
                                            ),
                                          ),
                                          onPressed: () async {
                                            // Handle button click
                                            Get.to(
                                              Bidding(
                                                id: item?.id.toString(),
                                                sellerID: item?.userId,
                                              ),
                                            );
                                          },
                                          child: FittedBox(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .msgMybid,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: Adaptive.sp(16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );

  bool _isUnlienItem(Datum? item) {
    return item?.financesId == null || item?.financesStatus == null;
  }

  List<Map<String, dynamic>> _getFilteredGatepassItems({
    required bool isUnlien,
  }) {
    final items = ref.watch(stockList);
    final filteredItems = <Map<String, dynamic>>[];

    for (var i = 0; i < items.length; i++) {
      final currentItem = items[i];
      if (_isUnlienItem(currentItem) == isUnlien) {
        filteredItems.add({
          'item': currentItem,
          'originalIndex': i,
        });
      }
    }
    return filteredItems;
  }

  Widget _buildLienTab({
    required String title,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 220),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorConstant.maingreen
              : ColorConstant.maingreen.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstant.maingreen.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              color: isSelected ? Colors.white : ColorConstant.maingreen,
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              '$title ($count)',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : ColorConstant.maingreen,
                fontSize: Adaptive.sp(14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void wantToSell(
    int index,
    BuildContext context,
    Datum data,
    WidgetRef ref,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      walletPower = double.tryParse(
            ref.watch(sharedUtilityProvider).getUser()?.tradePower ?? "0",
          ) ??
          0.0;

      emandiSellWeightController.text = data.quantity?.toString() ?? "0.0";
      emandiSellPriceController.text = "0.0";
      lytBal = false;

      final emandiData = await ref.watch(
        getEmandiSellDataProvider(
          inventoryId: data.id?.toString() ?? "",
          commodityId: data.commodity?.toString() ?? "",
        ).future,
      );

      final principalAmount = double.tryParse(
            emandiData.data?.principalAmount?.toString() ?? "0.0",
          ) ??
          0.0;
      final interestAmount = double.tryParse(
            emandiData.data?.totalInterestAmount?.toString() ?? "0.0",
          ) ??
          0.0;
      final rentAmount = double.tryParse(
            emandiData.data?.totalRentAmount?.toString() ?? "0.0",
          ) ??
          0.0;
      final bnplAmount =
          double.tryParse(emandiData.data?.bnplAmount?.toString() ?? "0.0") ??
              0.0;
      final bnplInterest =
          double.tryParse(emandiData.data?.bnplInterest?.toString() ?? "0.0") ??
              0.0;

      totalPayableAmt = principalAmount + interestAmount;
      finalPendingAmt =
          totalPayableAmt! + rentAmount + bnplAmount + bnplInterest;
      finalInterestRent = interestAmount;
      setState(() {});

      _wantToSellBottomsheet(data, emandiData, index);
    } catch (e, s) {
      debugPrint("Error in wantToSell: $e\n$s");
      errorBottomSheet(context, e.toString());
    }
  }

  void _wantToSellBottomsheet(
    dynamic data,
    dynamic emandiData,
    int index,
  ) async {
    showBarModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) => SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: Pad(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 7.0),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.wantToSellEmandi,
                          style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Divider(thickness: 1),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text.rich(
                        TextSpan(
                          text: AppLocalizations.of(context)!.msgTerminalname,
                          style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.bold,
                          ),
                          children: [TextSpan(text: " : ${data.name}")],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: AppLocalizations.of(context)!.msgGatepass,
                              style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(text: "${data.gatePassWr}"),
                              ],
                            ),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: AppLocalizations.of(context)!.msgCommodity,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.bold,
                            ),
                            children: [TextSpan(text: "${data.catName}")],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!
                                      .msgYourprice,
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              CommonTextField(
                                // hintText: "Your Price:",
                                onEditComplete: (value) {
                                  _calculatePriceData(value, setModalState);
                                },
                                controller: emandiSellPriceController,
                                textInputAction: TextInputAction.done,
                                inputType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                enabled: true,
                                isRequired: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!
                                      .msgNetweight,
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              CommonTextField(
                                controller: emandiSellWeightController,
                                onEditComplete: (value) {
                                  _calculateWeightData(
                                    value,
                                    data,
                                    emandiData,
                                    setModalState,
                                  );
                                },
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                enabled: true,
                                isRequired: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.rentCalculation,
                              style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "From ${emandiData.data?.rentFromDate ?? 0} Till ${emandiData.data?.rentToDate ?? 0}",
                              style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.period,
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${emandiData.data?.totalRentDays ?? "0"} days",
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!
                                      .totalAmount3,
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  currencyFormat.format(
                                    double.parse(
                                      "${emandiData.data?.totalRentAmount ?? 0.0}",
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    double.parse(
                              "${emandiData.data?.principalAmount ?? 0.0}",
                            ) >
                            0
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.msgLoan,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Interest Date : From ${emandiData.data?.interestFromDate ?? 0.0}  to ${emandiData.data?.interestToDate}',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .principal,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        currencyFormat.format(
                                          double.parse(
                                            "${emandiData.data?.principalAmount}",
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .intPeriod,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${emandiData.data!.totalInterestDays.toString()} Days",
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.rate,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        currencyFormat.format(
                                          double.parse(
                                            "${emandiData.data?.rateOfInterest ?? 0.0}",
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.payable,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        currencyFormat.format(
                                          double.parse(
                                            "${emandiData.data?.totalInterestAmount ?? 0.0}",
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .totalAmount3,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        currencyFormat.format(
                                          totalPayableAmt,
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 15),
                    num.parse("${emandiData.data?.bnplAmount ?? 0.0}") > 0
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.bnpl,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .bnplAmount,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        currencyFormat.format(
                                          double.parse(
                                            "${emandiData.data!.bnplAmount ?? 0.0}",
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .bnplInterest,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        currencyFormat.format(
                                          double.parse(
                                            "${emandiData.data?.bnplInterest ?? 0.0}",
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                    lytBal == true
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!
                                          .msgApproxdeal,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      currencyFormat.format(approxDealAmt),
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!
                                              .totalPandigAmount,
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!
                                              .rentInterstLoanBnpl,
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      currencyFormat.format(totalPendingAmt),
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!
                                          .approxBalanceAmount,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      currencyFormat.format(balanceAmt),
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!
                                          .msgWalletbalance,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      currencyFormat.format(walletPower),
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!
                                          .walletRemainig,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      currencyFormat.format(wrb),
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          )
                        : SizedBox(),
                    msgAlert == true ? SizedBox(height: 5) : SizedBox(),
                    msgAlert == true
                        ? Text(
                            AppLocalizations.of(context)!.failedToConnect,
                            style: TextStyle(
                              color: ColorConstant.red500,
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 10),
                    titleWidget(
                      text: AppLocalizations.of(
                        context,
                      )!
                          .termsConditions2,
                      fontSize: ElevarmFontSizes.xl2,
                    ),
                    Consumer(
                        builder: (context, ref, child) => ref
                                .watch(
                                    wbtTermsProvider(invId: data.id.toString()))
                                .when(data: (data) {
                              return HtmlWidget(
                                data['data'] ?? "",
                              );
                            }, error: (e, s) {
                              return SizedBox();
                            }, loading: () {
                              return SizedBox();
                            })),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: AppStyle.buttonStyle,
                              onPressed: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.msgCencel,
                                style: TextStyle(
                                  fontSize: Adaptive.sp(16),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              style: AppStyle.buttonStyle,
                              onPressed: () async {
                                _callWantToSellApi(data, emandiData, index);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.updatePrice,
                                style: TextStyle(
                                  fontSize: Adaptive.sp(16),
                                  fontWeight: FontWeight.bold,
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
        );
      },
    );
  }

  void checkLoanAction(
    WidgetRef ref,
    int index,
    BuildContext context,
    Datum data,
    List<Bank>? bankList,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!ref.watch(sharedUtilityProvider).isKycComplete()) {
      Get.to(KYC(kyctag: "bnpl"));
    } else {
      ref
          .watch(
        checkLoanStatusProvider(inventoriesId: data.id.toString()).future,
      )
          .then((value) {
        if (value['data'] == null) {
          ref
              .watch(
            checkLoanActionProvider(
              catName: data.catName.toString(),
              invId: data.id.toString(),
            ).future,
          )
              .then((value) {
            if (value.loanStatus.toString() == "1") {
              if (value.commodityPrice != null) {
                Get.to(
                  LoanApply(
                    inventorryID: data.id.toString(),
                    loanAmount: value.commodityPrice.toString(),
                    quantity: data.quantity.toString(),
                    mandibav: data.commodityPrice == null
                        ? ""
                        : data.commodityPrice.toString(),
                    bankList: bankList ?? [],
                  ),
                );
              } else {
                // Utility.showDilog(mContext, getString(R.string.alert), getString(R.string.loanmsg), new Utility.AlertCallback() {
                // @Override
                // public void callback() {
                // singlePermm();
                // }
                // });
              }
              Fluttertoast.showToast(
                msg: value.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: ColorConstant.maingreen,
              );
            } else {
              Fluttertoast.showToast(
                msg: value.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: ColorConstant.red500,
              );
            }
          }).onError((e, s) {
            errorBottomSheet(context, "$e");
          });
        }
      }).onError((e, s) {
        errorBottomSheet(context, "$e");
      });
    }
  }

  void _generatePdfAndNavigate(dynamic item) async {
    ref
        .watch(getPdfDataProvider(invId: item?.id.toString()).future)
        .then((value) async {
      log(value.data ?? "");

      PDFDocument doc = await PDFDocument.fromURL(value.data ?? "");

      Get.bottomSheet(
        Stack(
          children: [
            PDFViewer(document: doc),
            Padding(
              padding: Pad(all: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: AppStyle.buttonStyle,
                  onPressed: () async {
                    downloadFileBG(
                      fileName: 'gatepass_${item?.gatePassWr}',
                      url: value.data,
                    );
                  },
                  child: Text(
                    'Download',
                    style: TextStyle(
                      fontSize: Adaptive.sp(16),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        isScrollControlled: true,
      );
    }).onError((e, s) {
      errorBottomSheet(context, "$e");
    });
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.accessMediaLocation,
    ].request();
  }

  void _showQualityData(dynamic item) async {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      context: context,
      builder: (context) {
        return ElevarmDraggableBottomSheet(
          initialChildSize: 1,
          title: "Quality Report",
          onPressedClose: () => Get.back(),
          children: [
            ColumnSuper(
              children: [
                Padding(
                  padding: Pad(all: 0),
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
                                      fontSize: Adaptive.sp(16),
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
                                    AppLocalizations.of(context)!.value,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          item?.qualityParameter?.length ?? 0,
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
                                    '${item?.qualityParameter![qualityIndex].parameter}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Adaptive.sp(16),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${item?.qualityParameter![qualityIndex].value}',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
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
              ],
            ),
          ],
        );
      },
    );
  }

  void _calculatePriceData(
    String value,
    void Function(void Function()) setModalState,
  ) async {
    debouncer.call(() {
      if (double.parse(value.toString().trim()) > 20000.0) {
        emandiSellPriceController.text = "0";
      } else {
        if (emandiSellWeightController.text.isNotEmpty) {
          setModalState(() {
            lytBal = true;
            netWeight = double.parse(emandiSellWeightController.text.trim());
            bidPrice = double.parse(emandiSellPriceController.text.trim());
            actualAmountDeal = netWeight!.toDouble() * bidPrice!.toDouble();
            remBalanceAmt =
                actualAmountDeal!.toDouble() - finalPendingAmt!.toDouble();

            approxDealAmt = actualAmountDeal;
            totalPendingAmt = finalPendingAmt;
            balanceAmt = remBalanceAmt;

            wrb = (approxDealAmt! - totalPendingAmt!) + walletPower!;

            resultDealPayment = actualAmountDeal;
            effectivePending = finalPendingAmt;
          });

          if (remBalanceAmt! > 0) {
            setModalState(() {
              btnSubmit = true;
              lytWallet = false;
              msgAlert = false;
              walletSettlementAmt = 0.0;
            });
          } else {
            if (double.parse(walletPower.toString()) > 0.0) {
              if (walletPower! >= balanceAmt!) {
                setModalState(() {
                  remCapUser = remCapUser!.toDouble() - walletPower!.toDouble();

                  walletRemaningAmt = remCapUser;

                  btnSubmit = true;
                  lytWallet = true;
                  msgAlert = false;
                  walletSettlementAmt = balanceAmt;
                });
              } else {
                setModalState(() {
                  btnSubmit = false;
                  lytWallet = false;
                  msgAlert = true;
                  walletSettlementAmt = 0.0;
                });
              }
            } else {
              setModalState(() {
                btnSubmit = false;
                lytWallet = false;
                msgAlert = true;
                walletSettlementAmt = 0.0;
              });
            }
          }
        } else {
          setModalState(() {
            approxDealAmt = 0.0;
            totalPendingAmt = 0.0;
            submitButtonValue = 0.0;
          });
        }
      }
    });
  }

  void _calculateWeightData(
    String value,
    dynamic data,
    dynamic emandiData,
    void Function(void Function()) setModalState,
  ) async {
    debouncer.call(() {
      if (value.isNotEmpty) {
        if (double.parse(value.toString().trim()) >
            double.parse(data.quantity ?? "0.0")) {
          // cont.emandiSellWeightController.text = data.quantity.toString();
        } else {
          if (emandiSellWeightController.text.isNotEmpty) {
            if (emandiSellPriceController.text.isNotEmpty) {
              lytBal = true;
              netWeight = double.parse(emandiSellWeightController.text.trim());
              bidPrice = double.parse(emandiSellPriceController.text.trim());
              actualAmountDeal = netWeight!.toDouble() * bidPrice!.toDouble();
              remBalanceAmt =
                  actualAmountDeal!.toDouble() - finalPendingAmt!.toDouble();

              approxDealAmt = actualAmountDeal;
              totalPendingAmt = finalPendingAmt;

              wrb = (approxDealAmt! - totalPendingAmt!) + walletPower!;

              balanceAmt = remBalanceAmt;

              resultDealPayment = actualAmountDeal;
              effectivePending = finalPendingAmt;
              if (remBalanceAmt! > 0) {
                setModalState(() {
                  btnSubmit = true;
                  lytWallet = false;
                  msgAlert = false;
                  walletSettlementAmt = 0.0;
                });
              } else {
                if (double.parse(walletPower.toString()) > 0.0) {
                  if (walletPower! >= balanceAmt!) {
                    setModalState(() {
                      remCapUser =
                          remCapUser!.toDouble() - walletPower!.toDouble();
                      walletRemaningAmt = remCapUser;
                      btnSubmit = true;
                      lytWallet = true;
                      msgAlert = false;
                      walletSettlementAmt = balanceAmt;
                    });
                  } else {
                    setModalState(() {
                      btnSubmit = false;
                      lytWallet = false;
                      msgAlert = true;
                      walletSettlementAmt = 0.0;
                    });
                  }
                } else {
                  setModalState(() {
                    btnSubmit = false;
                    lytWallet = false;
                    msgAlert = true;
                    walletSettlementAmt = 0.0;
                  });
                }
              }
            } else {
              setModalState(() {
                lytBal = false;
                approxDealAmt = 0.0;
                balanceAmt = 0.0;
                netWeight = double.parse(
                  emandiSellWeightController.text.trim(),
                );
                quantityActualAmountDay =
                    netWeight!.toDouble() * finalInterestRent!.toDouble();
                quantityFinalAmount = quantityActualAmountDay!.toDouble() *
                    double.parse(emandiData.data!.totalRentDays.toString());
              });
            }
          } else {
            setModalState(() {
              approxDealAmt = 0.0;
              totalPendingAmt = 0.0;
              balanceAmt = 0.0;
              lytBal = false;
            });
          }
        }
      }
    });
  }

  void _callWantToSellApi(dynamic data, dynamic emandiData, int index) async {
    if (emandiSellPriceController.text.isEmpty ||
        emandiSellPriceController.text == "0") {
      Get.rawSnackbar(
        message: "Please Enter Your Price",
        duration: Duration(seconds: 10),
        backgroundColor: ColorConstant.maingreen,
      );
    } else if (emandiSellWeightController.text.isEmpty) {
      Get.rawSnackbar(
        message: "Please Enter Net Weight",
        duration: Duration(seconds: 10),
        backgroundColor: ColorConstant.maingreen,
      );
    } else if (double.parse(emandiSellWeightController.text.trim()) >
        double.parse(data.quantity.toString())) {
      Get.rawSnackbar(
        message: "Please Enter  Less Weight or Equal to net weight",
        duration: Duration(seconds: 10),
        backgroundColor: ColorConstant.maingreen,
      );
    } else {
      priceValve = double.parse(emandiSellPriceController.text.trim());
      weight = double.parse(emandiSellWeightController.text.trim());
      resultDealPayment = double.parse(resultDealPayment!.toStringAsFixed(2));
      effectivePending = double.parse(effectivePending!.toStringAsFixed(2));
      balanceAmt = double.parse(balanceAmt!.toStringAsFixed(2));
      mandiTax = double.parse(emandiData.mandiTax!.toStringAsFixed(2));
      if (emandiData.salesStatus.toString() == "2") {
        mandiTax = 0.0;
      }
      await ref
          .watch(
        getWantToSellResponseProvider(
          inventoryId: data.id.toString(),
          price: emandiSellPriceController.text,
        ).future,
      )
          .then((value) {
        if (data.qualityPCondition.toString() == "1") {
          note =
              "ऐप द्वारा दिया गया भाव ₹ ${emandiSellPriceController.text.trim()} गुणवत्ता के मानको अधीन है, इसमें से क्वालिटी क्लेम राशि ${value.data} रूपए (Qtl.) वॉलेट से काट लिया जायेगा ।";

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Alert"),
                content: Text(note),
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      // var inventoriesId,
                      // var price,
                      // var weight,
                      // double resultDealPayment,
                      // double effectivePending,
                      // balanceAmount,
                      // double walletSettlementAmount
                      ref
                          .watch(
                        apnaWantToSellProvider(
                          inventoryId: data.id.toString(),
                          price: emandiSellPriceController.text,
                          quantity: emandiSellWeightController.text,
                          rentRowId: null,
                          mandiAmount: double.parse(
                            "${resultDealPayment ?? 0.0}",
                          ).toString(),
                          finalSettlementAmount: double.parse(
                            "${effectivePending ?? 0.0}",
                          ).toString(),
                          remFinalAmount: double.parse(
                            "${balanceAmt ?? 0.0}",
                          ).toString(),
                          walletSettlementAmount: double.parse(
                            "${walletSettlementAmt ?? 0.0}",
                          ).toString(),
                        ).future,
                      )
                          .then((value) {
                        if (value.status.toString() == "1") {
                          Get.rawSnackbar(
                            message: value.message.toString(),
                            duration: Duration(seconds: 10),
                            backgroundColor: ColorConstant.maingreen,
                          );
                          ref
                              .watch(stockList.notifier)
                              .state[index]
                              ?.sellQuantity = emandiSellWeightController.text;
                          setState(() {});
                          Get.back(closeOverlays: true);
                        } else {
                          Get.rawSnackbar(
                            message: value.message.toString(),
                            duration: Duration(seconds: 10),
                            backgroundColor: ColorConstant.red500,
                          );
                        }
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.msgOk,
                      style: AppStyle.lbltermncon,
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          ref
              .watch(
            apnaWantToSellProvider(
              inventoryId: data.id.toString(),
              price: emandiSellPriceController.text,
              quantity: emandiSellWeightController.text,
              rentRowId: null,
              mandiAmount: double.parse(
                "${resultDealPayment ?? 0.0}",
              ).toString(),
              finalSettlementAmount:
                  double.parse("${effectivePending ?? 0.0}").toString(),
              remFinalAmount: double.parse("${balanceAmt ?? 0.0}").toString(),
              walletSettlementAmount: double.parse(
                "${walletSettlementAmt ?? 0.0}",
              ).toString(),
            ).future,
          )
              .then((value) {
            if (value.status.toString() == "1") {
              Get.rawSnackbar(
                message: value.message.toString(),
                duration: Duration(seconds: 10),
                backgroundColor: ColorConstant.maingreen,
              );
              ref.watch(stockList.notifier).state[index]?.sellQuantity =
                  ref.watch(stockList.notifier).state[index]?.quantity;
              setState(() {});
              Get.back(closeOverlays: true);
            } else {
              Get.rawSnackbar(
                message: value.message.toString(),
                duration: Duration(seconds: 10),
                backgroundColor: ColorConstant.red500,
              );
            }
          });
        }
      });
    }
  }
}
