import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/comman_dailog.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/home_screen/kyc.dart';
import 'package:apnagodam/presentation/line_graph/graph_screen.dart';
import 'package:apnagodam/presentation/market_screen/bindding.dart';

import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';

import 'package:apnagodam/widgets/circle_image_view.dart';
import 'package:elevarm_ui/elevarm_ui.dart';

import 'package:apnagodam/widgets/enums.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Wbtscreen extends ConsumerStatefulWidget {
  const Wbtscreen({super.key, this.isAppbarVisible = false});
  final bool? isAppbarVisible;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WbtscreenState();
}

class _WbtscreenState extends ConsumerState<Wbtscreen> {
  final selectedTabIndex = StateProvider<int>((ref) => 0);
  List<Map<String, dynamic>> get tabs => [
        {
          "label": AppLocalizations.of(context)!.stackWise,
          "index": 0,
          "icon": null,
        },
        {
          "label": AppLocalizations.of(context)!.gatepassWise,
          "index": 1,
          "icon": null,
        },
        // {"label": "Buy Deals".tr, "index": 2, "icon": Icons.receipt_long},
        // {"label": "Sell Deals".tr, "index": 3, "icon": Icons.wallet},
        // {"label": "Orders Status".tr, "index": 2, "icon": null},
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppbarVisible == true
          ? AppBar(
              title: Text(AppLocalizations.of(context)!.warehouseBasedTrade),
            )
          : null,
      body: RefreshIndicator(
        child: DefaultTabController(
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
                  child: TabBar(
                    onTap: (index) {
                      ref.watch(selectedTabIndex.notifier).state = index;
                    },
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                      fontSize: Adaptive.sp(15),
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
                          AppLocalizations.of(context)!.stackWise,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.gatepassWise,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    StackSellScreen(),
                    ref.watch(getMandiBhavProvider).when(
                          data: (data) {
                            return (data.data ?? []).isEmpty
                                ? SizedBox(
                                    child: noStockData(),
                                    height: Get.height / 2,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.data?.length ?? 0,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return GestureDetector(
                                        onTap: () async {
                                          if (ref.watch(authProvider).value ==
                                              AuthStatus.loggedIn) {
                                            Get.to(
                                              Bidding(
                                                id: data.data?[index].id
                                                    .toString(),
                                                sellerID: data
                                                    .data?[index].sellerCatId
                                                    .toString(),
                                              ),
                                            );
                                          } else {
                                            showLoginBottomsheet(context);
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                          ),
                                          child: Card(
                                            surfaceTintColor: Colors.white,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: ColorConstant.maingreen,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            elevation: 5,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      CircleImageView(
                                                        radius: Adaptive.sp(22),
                                                        image:
                                                            "${IMAGE_BASE_URL}category/${data.data?[index].image.toString()}",
                                                      ),

                                                      // NetworkImage("${IMAGE_BASE_URL}category/${cont.wbtMarket!.data![index].image.toString()}", )
                                                      SizedBox(width: 7),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${data.data?[index].commodity}",
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorConstant
                                                                      .maingreen,
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      Adaptive
                                                                          .sp(
                                                                    17,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  Get.to(
                                                                    GraphScreen(
                                                                      id: "${data.data?[index].sellerCatId}",
                                                                      wichtag:
                                                                          "market",
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  AppLocalizations
                                                                          .of(
                                                                    context,
                                                                  )!
                                                                      .msgViewgraph3,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Adaptive
                                                                            .sp(
                                                                      15,
                                                                    ),
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    decorationColor:
                                                                        Colors
                                                                            .blue,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text.rich(
                                                            TextSpan(
                                                              text:
                                                                  " ${data.data?[index].state}",
                                                              style: AppStyle
                                                                  .lblonbordingp
                                                                  .copyWith(
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                  16,
                                                                ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "(${data.data?[index].gatepass})",
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                  fontSize:
                                                                      Adaptive
                                                                          .sp(
                                                                    14,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.data?[index].expDate}",
                                                                style: AppStyle
                                                                    .lblonbordingp
                                                                    .copyWith(
                                                                  fontSize:
                                                                      Adaptive
                                                                          .sp(
                                                                    14,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                softWrap: false,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            "Last Trade Price: ${data.data?[index].ltp}",
                                                            style: AppStyle
                                                                .lblonbordingp
                                                                .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                16,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: Get.width,
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorConstant.maingreen,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: RowSuper(
                                                    fill: true,
                                                    fitHorizontally: true,
                                                    innerDistance: 5,
                                                    children: [
                                                      RowSuper(
                                                        children: [
                                                          SizedBox(width: 5),
                                                          Text.rich(
                                                            TextSpan(
                                                              text: 'Low: ',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                  16,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      "${data.data?[index].minPrice}",
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          SizedBox(width: 5),
                                                          Text.rich(
                                                            TextSpan(
                                                              text: 'High: ',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                  16,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      "${data.data?[index].maxPrice}",
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text.rich(
                                                            TextSpan(
                                                              text: 'Buyer: ',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                  16,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      "${data.data?[index].buyerPrice}",
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text.rich(
                                                            TextSpan(
                                                              text: 'Seller: ',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                  16,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      "${data.data?[index].sellerPrice}",
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          },
                          error: (e, s) => Container(
                            child: Text(e.toString() + s.toString()),
                          ),
                          loading: () => _gatepassLoader(),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onRefresh: () => Future(() => ref.invalidate(getMandiBhavProvider)),
      ),
    );
  }

  _gatepassLoader() => Skeletonizer(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {},
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: ColorConstant.maingreen),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleImageView(radius: Adaptive.sp(22), image: ""),

                            // NetworkImage("${IMAGE_BASE_URL}category/${cont.wbtMarket!.data![index].image.toString()}", )
                            SizedBox(width: 7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Loading... ",
                                      style: TextStyle(
                                        color: ColorConstant.maingreen,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(17),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () async {},
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .msgViewgraph,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(15),
                                          fontFamily: 'Roboto',
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.blue,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: "Loading...",
                                    style: AppStyle.lblonbordingp.copyWith(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "00000",
                                      style: AppStyle.lblonbordingp.copyWith(
                                        fontSize: Adaptive.sp(14),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "00000",
                                      style: AppStyle.lblonbordingp.copyWith(
                                        fontSize: Adaptive.sp(14),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Last Trade Price: ",
                                  style: AppStyle.lblonbordingp.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: Adaptive.sp(16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ColorConstant.maingreen,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: RowSuper(
                          fill: true,
                          fitHorizontally: true,
                          innerDistance: 5,
                          children: [
                            RowSuper(
                              children: [
                                SizedBox(width: 5),
                                Text.rich(
                                  TextSpan(
                                    text: 'Low: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "")],
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(width: 5),
                                Text.rich(
                                  TextSpan(
                                    text: 'High: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "")],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Buyer: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "")],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text.rich(
                                  TextSpan(
                                    text: 'Seller: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "")],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}

class StackSellScreen extends ConsumerWidget {
  const StackSellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      child: ref.watch(stackSellListProvider).when(
            data: (list) {
              return (list.data ?? []).isEmpty
                  ? noStockData()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        var isBuyer = false;
                        var isSeller = ref
                                .watch(sharedUtilityProvider)
                                .getUser()
                                ?.userId
                                .toString() ==
                            list.data?[index].sellerId.toString();
                        Future.delayed(Duration(seconds: 1));

                        list.data![index].stackBuySellConver
                            ?.forEach((element) {
                          if (element.userId.toString() ==
                              ref
                                  .watch(sharedUtilityProvider)
                                  .getUser()
                                  ?.userId
                                  .toString()) {
                            isBuyer = true;
                          }
                        });
                        return GestureDetector(
                          onTap: () async {
                            if (ref.watch(authProvider).value ==
                                AuthStatus.loggedIn) {
                              Get.to(StackSellBiddingScreen(index: index));
                            } else {
                              showLoginBottomsheet(context);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              top: 10.0,
                            ),
                            child: Card(
                              surfaceTintColor: Colors.white,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.amber.shade900),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              child: ColumnSuper(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        CircleImageView(
                                          radius: Adaptive.sp(25),
                                          image:
                                              "${IMAGE_BASE_URL}category/${list.data?[index].commodityImage.toString()}",
                                        ),

                                        // NetworkImage("${IMAGE_BASE_URL}category/${cont.wbtMarket!.data![index].image.toString()}", )
                                        SizedBox(width: 5),
                                        Container(
                                          child: Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    text:
                                                        "${list.data?[index].commodityName}",
                                                  ),
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstant.maingreen,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(17),
                                                  ),
                                                ),
                                                Text.rich(
                                                  TextSpan(
                                                    text:
                                                        " ${list.data?[index].warehouseName}",
                                                    style: AppStyle
                                                        .lblonbordingp
                                                        .copyWith(
                                                      fontSize: Adaptive.sp(
                                                        16,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    HtmlWidget(
                                                      " ${list.data?[index].bidTime}",
                                                    ),
                                                    SizedBox(width: 10),
                                                  ],
                                                ),
                                                if (isSeller)
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IntrinsicWidth(
                                                      child: Container(
                                                        padding: Pad(
                                                          left: 10,
                                                          right: 10,
                                                          top: 5,
                                                          bottom: 5,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorConstant
                                                              .maingreen,
                                                          border: Border.all(
                                                            color: ColorConstant
                                                                .maingreen,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'My Sell',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Adaptive.sp(
                                                              14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (isBuyer)
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IntrinsicWidth(
                                                      child: Container(
                                                        padding: Pad(
                                                          left: 10,
                                                          right: 10,
                                                          top: 5,
                                                          bottom: 5,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorConstant
                                                              .maingreen,
                                                          border: Border.all(
                                                            color: ColorConstant
                                                                .maingreen,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'My Buy',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Adaptive.sp(
                                                              14,
                                                            ),
                                                          ),
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
                                  Container(
                                    width: Get.width,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.shade900,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: RowSuper(
                                      fill: true,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: 'Best Buyer: ',
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(14),
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${list.data?[index].bestBuyerPrice ?? "0"}",
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        if (!isSeller)
                                          Text.rich(
                                            TextSpan(
                                              text: isSeller
                                                  ? 'My Price(seller): '
                                                  : 'My Price: ',
                                              style: TextStyle(
                                                fontSize: Adaptive.sp(14),
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${isSeller ? (list.data?[index].sellerPrice ?? 0) : list.data?[index].buyerPrice ?? 0}",
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        Text.rich(
                                          TextSpan(
                                            text: 'Seller: ',
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(14),
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${list.data?[index].sellerPrice}",
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
            loading: () => _stackSellLoader(),
            error: (e, s) => Center(child: Text("Error loading data: $e")),
          ),
      onRefresh: () {
        {}
        return Future(() => ref.invalidate(stackSellListProvider));
      },
    );
  }

  _stackSellLoader() => Skeletonizer(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {},
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.amber.shade900),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: RowSuper(
                          fill: true,
                          children: [
                            CircleImageView(radius: Adaptive.sp(25), image: ""),

                            // NetworkImage("${IMAGE_BASE_URL}category/${cont.wbtMarket!.data![index].image.toString()}", )
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(
                                      TextSpan(text: "Loading..."),
                                      style: TextStyle(
                                        color: ColorConstant.maingreen,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(17),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: "Loading...",
                                    style: AppStyle.lblonbordingp.copyWith(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade900,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: RowSuper(
                          fill: true,
                          children: [
                            RowSuper(
                              children: [
                                SizedBox(width: 5),
                                Text.rich(
                                  TextSpan(
                                    text: 'Low: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "Loading...")],
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(width: 5),
                                Text.rich(
                                  TextSpan(
                                    text: 'High: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "Loading...")],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Seller: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "")],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}

class StacksOrderListing extends ConsumerWidget {
  const StacksOrderListing({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(stackOrderListProvider).when(
          data: (list) {
            return (list['data'] ?? []).isEmpty
                ? noStockData()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: list['data'].length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          if (ref.watch(authProvider).value ==
                              AuthStatus.loggedIn) {
                            if (!ref
                                .watch(sharedUtilityProvider)
                                .isKycComplete()) {
                              CommanDialog(
                                context,
                                AppLocalizations.of(context)!.msgAlert,
                                AppLocalizations.of(context)!.verify,
                                (bool userClickedOK) {
                                  if (userClickedOK) {
                                    Get.to(KYC(kyctag: ""));
                                  } else {
                                    Get.back();
                                  }
                                },
                              );
                            } else {}
                          } else {
                            showLoginBottomsheet(context);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            top: 10.0,
                          ),
                          child: Card(
                            surfaceTintColor: Colors.white,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color:
                                    list['data'][index]['status'].toString() ==
                                            "1"
                                        ? Colors.amber
                                        : Colors.red.shade900,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: RowSuper(
                                    fill: true,
                                    children: [
                                      CircleImageView(
                                        radius: Adaptive.sp(25),
                                        image:
                                            "${IMAGE_BASE_URL}category/${list['data'][index]['commodity_image'].toString()}",
                                      ),

                                      // NetworkImage("${IMAGE_BASE_URL}category/${cont.wbtMarket!.data![index].image.toString()}", )
                                      SizedBox(width: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text:
                                                      "${list['data']?[index]['commodity_name']}",
                                                ),
                                                style: TextStyle(
                                                  color:
                                                      ColorConstant.maingreen,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Adaptive.sp(17),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  " ${list['data']?[index]['warehouse_name']}",
                                              style: AppStyle.lblonbordingp
                                                  .copyWith(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              text: 'Stack No.: ',
                                              style: TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${list['data']?[index]['stack_number']}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: Pad(all: 10),
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Order Status: ',
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: list['data'][index]['status']
                                                      .toString() ==
                                                  "1"
                                              ? ' No Bids Yet'
                                              : " Bid Not Accepted Yet",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: list['data'][index]['status']
                                                .toString() ==
                                            "1"
                                        ? Colors.amber
                                        : Colors.red.shade900,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                  child: RowSuper(
                                    fill: true,
                                    children: [
                                      RowSuper(
                                        children: [
                                          SizedBox(width: 5),
                                          Text.rich(
                                            TextSpan(
                                              text: 'Lifting Days: ',
                                              style: TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${list['data']?[index]['lifiting_days'] ?? "No Bids yet"}",
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text: 'Seller Price: ',
                                              style: TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${list['data']?[index]['seller_price']}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
          loading: () => _stackSellLoader(),
          error: (e, s) => Center(child: Text("Error loading data: $e")),
        );
  }

  _stackSellLoader() => Skeletonizer(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {},
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.amber.shade900),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: RowSuper(
                          fill: true,
                          children: [
                            CircleImageView(radius: Adaptive.sp(25), image: ""),

                            // NetworkImage("${IMAGE_BASE_URL}category/${cont.wbtMarket!.data![index].image.toString()}", )
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(
                                      TextSpan(text: "Loading..."),
                                      style: TextStyle(
                                        color: ColorConstant.maingreen,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(17),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: "Loading...",
                                    style: AppStyle.lblonbordingp.copyWith(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade900,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: RowSuper(
                          fill: true,
                          children: [
                            RowSuper(
                              children: [
                                SizedBox(width: 5),
                                Text.rich(
                                  TextSpan(
                                    text: 'Low: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "Loading...")],
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(width: 5),
                                Text.rich(
                                  TextSpan(
                                    text: 'High: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "Loading...")],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Seller: ',
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [TextSpan(text: "")],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}

class StackSellBiddingScreen extends ConsumerStatefulWidget {
  const StackSellBiddingScreen({super.key, required this.index});
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StackSellBiddingScreenState();
}

var selectedSchemeIndex = StateProvider<int?>((ref) => null);

class _StackSellBiddingScreenState
    extends ConsumerState<StackSellBiddingScreen> {
  final isUserBid = StateProvider((ref) => false);
  final isOwner = StateProvider((ref) => false);
  final financeTypeProvider = StateProvider<FinanceType?>((ref) => null);
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(stackSellListProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack Sell Bidding')),
      body: ref.watch(stackSellListProvider).when(
            data: (data) {
              if ((data.data ?? []).isEmpty) {
                return noStockData();
              }
              Future.delayed(Duration(seconds: 1)).then((_) {
                ref.watch(isOwner.notifier).state =
                    "${data.data![widget.index].sellerId}" ==
                        "${ref.watch(sharedUtilityProvider).getUser()?.userId}";
                for (var e
                    in data.data![widget.index].stackBuySellConver ?? []) {
                  if (e.userId.toString() ==
                      ref
                          .watch(sharedUtilityProvider)
                          .getUser()
                          ?.userId
                          .toString()) {
                    ref.watch(isUserBid.notifier).state = true;
                    break;
                  }
                }
              });
              return SingleChildScrollView(
                padding: Pad(all: 5),
                child: Column(
                  children: [
                    Card(
                      elevation: 8,
                      color: ColorConstant.maingreen,
                      child: Padding(
                        padding: Pad(all: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Stack No - ${data.data![widget.index].stackNumber}"
                                  .tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(17),
                              ),
                            ),
                            Divider(color: Colors.white, thickness: 2),
                            Text.rich(
                              TextSpan(
                                text: AppLocalizations.of(
                                  context,
                                )!
                                    .msgTerminalname,
                                style: AppStyle.lblbuydetail.copyWith(
                                  fontSize: Adaptive.sp(16),
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        " :  ${data.data![widget.index].warehouseName}",
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.white, thickness: 2),
                            Text.rich(
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.msgCommodity,
                                style: AppStyle.lblbuydetail.copyWith(
                                  fontSize: Adaptive.sp(16),
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        " :  ${data.data![widget.index].commodityName}",
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.white, thickness: 2),
                            Text.rich(
                              TextSpan(
                                text: AppLocalizations.of(
                                  context,
                                )!
                                    .warehouseAddress,
                                style: AppStyle.lblbuydetail.copyWith(
                                  fontSize: Adaptive.sp(16),
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        " :  ${data.data![widget.index].warehouseAddress}",
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.white, thickness: 2),
                            IntrinsicHeight(
                              child: RowSuper(
                                fitHorizontally: true,
                                children: [
                                  RowSuper(
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .msgQuantity,
                                        style: AppStyle.lblsellnbuy.copyWith(
                                          fontSize: Adaptive.sp(16),
                                        ),
                                      ),
                                      Text(
                                        " : ${data.data![widget.index].quantity}",
                                        style: AppStyle.lblsellnbuy.copyWith(
                                          fontSize: Adaptive.sp(16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      right: 4,
                                    ),
                                    child: VerticalDivider(
                                      thickness: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .sellerPrice,
                                        style: AppStyle.lblsellnbuy.copyWith(
                                          fontSize: Adaptive.sp(16),
                                        ),
                                      ),
                                      // Text(cont.yourpricecontroller.text,
                                      //   style: AppStyle.lblsellnbuy,
                                      // ),
                                      Text(
                                        '${data.data![widget.index].sellerPrice}',
                                        style: AppStyle.lblsellnbuy.copyWith(
                                          fontSize: Adaptive.sp(16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: Colors.white, thickness: 2),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Center(
                      child: ElevatedButton(
                        style: AppStyle.buttonStyle,
                        onPressed: () {
                          final priceController =
                              TextEditingController(text: "");
                          final daysController = TextEditingController();
                          if (ref.watch(isOwner)) {
                            priceController.text =
                                "${data.data![widget.index].sellerPrice}";
                          }
                          showBarModalBottomSheet(
                            context: context,
                            builder: (bottomsheetContext) => Consumer(
                              builder: (context, ref, child) => Form(
                                key: formKey,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!
                                              .msgMybid,
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(17),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 10),
                                        titleWidget(
                                          text: AppLocalizations.of(
                                            context,
                                          )!
                                              .msgPrice_1,
                                          fontSize: ElevarmFontSizes.xl,
                                        ),
                                        Padding(
                                          padding: Pad(all: 10),
                                          child: Row(
                                            children: [
                                              // -10 button
                                              GestureDetector(
                                                onTap: () {
                                                  final current = int.tryParse(
                                                          priceController
                                                              .text) ??
                                                      0;
                                                  final newVal = (current - 10)
                                                      .clamp(0, 25000);
                                                  priceController.text =
                                                      newVal.toString();
                                                  priceController.selection =
                                                      TextSelection
                                                          .fromPosition(
                                                    TextPosition(
                                                        offset: priceController
                                                            .text.length),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorConstant.maingreen,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  padding: Pad(all: 10),
                                                  child: Text(
                                                    '-10',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: Adaptive.sp(18),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              // text field in the middle
                                              Expanded(
                                                child: TextFormField(
                                                  controller: priceController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize:
                                                          Adaptive.sp(16)),
                                                  decoration: InputDecoration(
                                                    hintText: ref.watch(isOwner)
                                                        ? "${data.data![widget.index].sellerPrice ?? "0"}"
                                                        : "Enter Price",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: ColorConstant
                                                              .maingreen),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: ColorConstant
                                                              .maingreen,
                                                          width: 2),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: ColorConstant
                                                              .maingreen),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 8),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty ||
                                                        value.trim() == "0" ||
                                                        value.trim() == "0.0") {
                                                      return AppLocalizations
                                                              .of(context)!
                                                          .inputValidValue3;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              // +10 button
                                              GestureDetector(
                                                onTap: () {
                                                  final current = int.tryParse(
                                                          priceController
                                                              .text) ??
                                                      0;
                                                  final newVal = (current + 10)
                                                      .clamp(0, 25000);
                                                  priceController.text =
                                                      newVal.toString();
                                                  priceController.selection =
                                                      TextSelection
                                                          .fromPosition(
                                                    TextPosition(
                                                        offset: priceController
                                                            .text.length),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorConstant.maingreen,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  padding: Pad(all: 10),
                                                  child: Text(
                                                    '+10',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: Adaptive.sp(18),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        if (!ref.watch(isOwner))
                                          titleWidget(
                                            text: AppLocalizations.of(
                                              context,
                                            )!
                                                .liftingDays,
                                            fontSize: ElevarmFontSizes.xl,
                                          ),
                                        if (!ref.watch(isOwner))
                                          Padding(
                                            padding: Pad(all: 10),
                                            child: SizedBox(
                                              width: Get.width,
                                              child: InputQty(
                                                maxVal: 365,
                                                initVal: 1,
                                                minVal: 1,
                                                steps: 1,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value == 0) {
                                                    return AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .inputValidValue3;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                qtyFormProps: QtyFormProps(
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                    decimal: false,
                                                  ),
                                                ),
                                                onQtyChanged: (val) {
                                                  daysController.text =
                                                      double.tryParse(
                                                    '${val ?? 0.0}',
                                                  ).toString();
                                                  // yourpricecontroller
                                                  //     .text = double
                                                  //         .tryParse(
                                                  //             '${val ?? 0.0}')
                                                  //     .toString();
                                                  print(val);
                                                },
                                                decoration: QtyDecorationProps(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5,
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: ColorConstant
                                                          .maingreen,
                                                    ),
                                                  ),
                                                  qtyStyle: QtyStyle.classic,
                                                  minusBtn: Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .maingreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5,
                                                      ),
                                                    ),
                                                    padding: Pad(
                                                      all: 10,
                                                    ),
                                                    child: Text(
                                                      '-1',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: Adaptive.sp(
                                                          18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  plusBtn: Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .maingreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        5,
                                                      ),
                                                    ),
                                                    padding: Pad(
                                                      all: 10,
                                                    ),
                                                    child: Text(
                                                      '+1',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: Adaptive.sp(
                                                          18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!ref.watch(isOwner))
                                          titleWidget(
                                            text: AppLocalizations.of(
                                              context,
                                            )!
                                                .selectFinanceType,
                                            fontSize: ElevarmFontSizes.xl,
                                          ),
                                        if (!ref.watch(isOwner))
                                          SizedBox(height: 10),
                                        if (!ref.watch(isOwner))
                                          DropdownSearch<FinanceType?>(
                                            compareFn: (item1, item2) =>
                                                item1?.type == item2?.type,
                                            popupProps: PopupProps.menu(
                                              searchFieldProps: TextFieldProps(
                                                autofocus: true,
                                                cursorColor:
                                                    ColorConstant.maingreen,
                                                padding: Pad(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                decoration: InputDecoration(
                                                  contentPadding: Pad(
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen,
                                                    ),
                                                  ),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen,
                                                    ),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen,
                                                    ),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: ColorConstant
                                                          .maingreen,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              menuProps: MenuProps(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color:
                                                        ColorConstant.maingreen,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: Adaptive.sp(
                                                          16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    color:
                                                        Colors.grey.withOpacity(
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
                                            items: (s, k) => FinanceType.values,
                                            itemAsString: (FinanceType? u) =>
                                                u?.label ?? "",
                                            validator: (value) {
                                              if (value == null) {
                                                return AppLocalizations.of(
                                                  context,
                                                )!
                                                    .selectFinanceType3;
                                              }
                                              return null;
                                            },
                                            onChanged: (FinanceType? data) =>
                                                ref
                                                    .watch(
                                                      financeTypeProvider
                                                          .notifier,
                                                    )
                                                    .state = data,
                                            decoratorProps:
                                                DropDownDecoratorProps(
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      8,
                                                    ),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color:
                                                        ColorConstant.maingreen,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                        if (!ref.watch(isOwner))
                                          SizedBox(height: 10),
                                        ref
                                            .watch(
                                              stackSellTermsProvider(
                                                stackId:
                                                    "${data.data![widget.index].id}",
                                              ),
                                            )
                                            .when(
                                              data: (data) => Column(
                                                children: [
                                                  titleWidget(
                                                    text: AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .termsConditions2,
                                                    fontSize:
                                                        ElevarmFontSizes.sm,
                                                  ),
                                                  Text(
                                                    '${data['data'] ?? ""}'
                                                        .replaceAll(
                                                          '<p>',
                                                          '',
                                                        )
                                                        .replaceAll(
                                                          "</p>",
                                                          '',
                                                        ),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              error: (e, s) => Container(),
                                              loading: () =>
                                                  CircularProgressIndicator(),
                                            ),

                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text(
                                        //       AppLocalizations.of(context)!.msgTermAnd,
                                        //       style: AppStyle
                                        //           .lblonlinemandibiglistdetail
                                        //           .copyWith(
                                        //               fontSize:
                                        //                   Adaptive.sp(16)),
                                        //     ),
                                        //     Text(
                                        //       AppLocalizations.of(context)!.tCOne,
                                        //       style: AppStyle
                                        //           .lblonlinemandibiglistdetail
                                        //           .copyWith(
                                        //               fontSize:
                                        //                   Adaptive.sp(16)),
                                        //     ),
                                        //     Text(
                                        //       AppLocalizations.of(context)!.tCTwo,
                                        //       style: AppStyle
                                        //           .lblonlinemandibiglistdetail
                                        //           .copyWith(
                                        //               fontSize:
                                        //                   Adaptive.sp(16)),
                                        //     ),
                                        //     Text(
                                        //       AppLocalizations.of(context)!.tCThree,
                                        //       style: AppStyle
                                        //           .lblonlinemandibiglistdetail
                                        //           .copyWith(
                                        //               fontSize:
                                        //                   Adaptive.sp(16)),
                                        //     ),
                                        //     Text(
                                        //       AppLocalizations.of(context)!.tCFour,
                                        //       style: AppStyle
                                        //           .lblonlinemandibiglistdetail
                                        //           .copyWith(
                                        //               fontSize:
                                        //                   Adaptive.sp(16)),
                                        //     ),
                                        //   ],
                                        // ),
                                        SizedBox(height: 15),
                                        InkWell(
                                          onTap: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (ref.watch(
                                                        financeTypeProvider,
                                                      ) ==
                                                      null &&
                                                  !ref.watch(isOwner)) {
                                                context.errorToast(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .selectFinanceType3,
                                                );
                                                return;
                                              } else {
                                                if (ref.watch(
                                                  isOwner,
                                                )) {
                                                  ref
                                                      .watch(
                                                    updateSellerPriceProvider(
                                                      price: priceController
                                                          .text
                                                          .toString(),
                                                      stackId:
                                                          "${data.data![widget.index].id}",
                                                    ).future,
                                                  )
                                                      .then((value) {
                                                    if (value['status']
                                                            .toString() ==
                                                        '1') {
                                                      context.successToast(
                                                        value['message'],
                                                      );
                                                      Navigator.of(
                                                        bottomsheetContext,
                                                        rootNavigator: false,
                                                      ).pop([
                                                        ref.invalidate(
                                                          stackSellListProvider,
                                                        ),
                                                      ]);
                                                    } else {
                                                      context.errorToast(
                                                        value['message']
                                                            .toString(),
                                                      );
                                                    }
                                                  });
                                                } else {
                                                  ref
                                                      .watch(
                                                    bidSellStackProvider(
                                                      price: priceController
                                                          .text
                                                          .toString(),
                                                      id: "${data.data![widget.index].id}",
                                                      walletType: ref
                                                              .watch(
                                                                financeTypeProvider,
                                                              )
                                                              ?.type
                                                              .toString() ??
                                                          "",
                                                      liftingDays:
                                                          daysController.text
                                                              .toString(),
                                                    ).future,
                                                  )
                                                      .then((value) {
                                                    if (value['status']
                                                            .toString() ==
                                                        '1') {
                                                      context.successToast(
                                                        value['message'],
                                                      );
                                                      Navigator.of(
                                                        bottomsheetContext,
                                                        rootNavigator: false,
                                                      ).pop([
                                                        ref.invalidate(
                                                          stackSellListProvider,
                                                        ),
                                                      ]);
                                                    } else if (value['status']
                                                                .toString() ==
                                                            "2" &&
                                                        value['wallet_type']
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "finance") {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (
                                                          financeContext,
                                                        ) =>
                                                            Consumer(
                                                          builder: (
                                                            context,
                                                            ref,
                                                            child,
                                                          ) =>
                                                              ElevarmDraggableBottomSheet(
                                                            initialChildSize: 1,
                                                            title: AppLocalizations
                                                                    .of(
                                                              context,
                                                            )!
                                                                .santionLimitSchemes2,
                                                            onPressedClose: () {
                                                              Get.back();
                                                            },
                                                            children: [
                                                              titleWidget(
                                                                text:
                                                                    "Sanctioned Amount: ${value['data']['sanction_limit']}",
                                                              ),
                                                              ColumnSuper(
                                                                children: [
                                                                  Container(
                                                                    padding:
                                                                        Pad(
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
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(
                                                                              context,
                                                                            )!
                                                                                .action,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: Adaptive.sp(
                                                                                15,
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
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(
                                                                              context,
                                                                            )!
                                                                                .schemeName3,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: Adaptive.sp(
                                                                                15,
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
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(
                                                                              context,
                                                                            )!
                                                                                .pf1,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: Adaptive.sp(
                                                                                16,
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
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(
                                                                              context,
                                                                            )!
                                                                                .interestRate1,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: Adaptive.sp(
                                                                                16,
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
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(
                                                                              context,
                                                                            )!
                                                                                .ltv1,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: Adaptive.sp(
                                                                                16,
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
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(
                                                                              context,
                                                                            )!
                                                                                .tenor,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: Adaptive.sp(
                                                                                16,
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
                                                                        //             fontSize: Adaptive.sp(16),
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
                                                                  ListView
                                                                      .builder(
                                                                    itemCount:
                                                                        value['data']['schemes']?.length ??
                                                                            0,
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemBuilder: (
                                                                      context,
                                                                      index,
                                                                    ) =>
                                                                        value['data']['schemes'][index]['scheme_name'].toString().toLowerCase().trim() == "bnpl takeover"
                                                                            ? SizedBox()
                                                                            : Container(
                                                                                color: index % 2 == 0
                                                                                    ? Colors.grey.withOpacity(
                                                                                        0.1,
                                                                                      )
                                                                                    : Colors.white,
                                                                                child: Padding(
                                                                                  padding: Pad(
                                                                                    all: 10,
                                                                                  ),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Checkbox(
                                                                                          activeColor: ColorConstant.maingreen,
                                                                                          value: ref.watch(
                                                                                                selectedSchemeIndex,
                                                                                              ) ==
                                                                                              index,
                                                                                          onChanged: (
                                                                                            isSelected,
                                                                                          ) {
                                                                                            if (isSelected ?? false) {
                                                                                              ref
                                                                                                  .watch(
                                                                                                    selectedSchemeIndex.notifier,
                                                                                                  )
                                                                                                  .state = index;
                                                                                            } else {
                                                                                              ref.invalidate(
                                                                                                selectedSchemeIndex,
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
                                                                                              16,
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
                                                                                              16,
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
                                                                                              16,
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
                                                                                              16,
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
                                                                                              16,
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
                                                                                      //             fontSize: Adaptive.sp(16),
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
                                                                    width: Get
                                                                        .width,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (ref.watch(
                                                                              selectedSchemeIndex,
                                                                            ) ==
                                                                            null) {
                                                                          Fluttertoast
                                                                              .showToast(
                                                                            msg: AppLocalizations.of(
                                                                              context,
                                                                            )!
                                                                                .pleaseSelectScheme,
                                                                          );
                                                                        } else {
                                                                          ref
                                                                              .watch(
                                                                            bidSellStackProvider(
                                                                              price: priceController.text.toString(),
                                                                              id: "${data.data![widget.index].id}",
                                                                              liftingDays: daysController.text.toString(),
                                                                              schemeId: "${value['data']['schemes'][ref.watch(selectedSchemeIndex)]['id']}",
                                                                              loanType: "1",
                                                                              walletType: ref
                                                                                      .watch(
                                                                                        financeTypeProvider,
                                                                                      )
                                                                                      ?.type
                                                                                      .toString() ??
                                                                                  "",
                                                                            ).future,
                                                                          )
                                                                              .then(
                                                                            (
                                                                              value,
                                                                            ) {
                                                                              if (value['status'] == "1") {
                                                                                Get.back(
                                                                                  closeOverlays: true,
                                                                                );
                                                                              }
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                      style: AppStyle
                                                                          .buttonStyle,
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!
                                                                            .apply,
                                                                        style:
                                                                            TextStyle(
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
                                                        ),
                                                      );
                                                    } else {
                                                      context.errorToast(
                                                        value['message']
                                                            .toString(),
                                                      );
                                                    }
                                                  });
                                                }
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: ColorConstant.maingreen,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                08,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!
                                                    .submitBid,
                                                style: AppStyle.lblmoneybtn
                                                    .copyWith(
                                                  fontSize: Adaptive.sp(
                                                    16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ref.watch(isOwner)
                                ? Text(
                                    AppLocalizations.of(context)!.bidUpdate,
                                    style: AppStyle.lbldrawerbtn.copyWith(
                                      fontSize: Adaptive.sp(16),
                                    ),
                                  )
                                : Text(
                                    ref.watch(isUserBid) == true
                                        ? AppLocalizations.of(context)!
                                            .bidUpdate
                                        : AppLocalizations.of(context)!
                                            .addUpdate,
                                    style: AppStyle.lbldrawerbtn.copyWith(
                                      fontSize: Adaptive.sp(16),
                                    ),
                                  ),
                            SizedBox(width: 10),
                            Icon(Icons.highlight_sharp, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    if (ref.watch(isOwner))
                      Center(
                        child: ElevatedButton(
                          style: AppStyle.buttonStyle.copyWith(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.red.shade700,
                            ),
                          ),
                          onPressed: () {
                            ElevarmConfirmAlertDialog(
                              title: AppLocalizations.of(context)!.deleteBid,
                              subtitle: AppLocalizations.of(
                                context,
                              )!
                                  .areYouSureYouWantToDeleteThisBid2,
                              onPositiveButton: () {
                                ref
                                    .watch(
                                  deleteSellerPriceProvider(
                                    stackId: "${data.data![widget.index].id}",
                                  ).future,
                                )
                                    .then((value) {
                                  if (value['status'].toString() == '1') {
                                    context.successToast(value['message']);
                                    ref.invalidate(stackSellListProvider);
                                    Get.close(2);
                                  } else {
                                    context.errorToast(
                                      value['message'].toString(),
                                    );
                                  }
                                });
                              },
                              onNegativeButton: () {
                                Get.back();
                              },
                              positiveText:
                                  AppLocalizations.of(context)!.msgYes,
                              negativeText:
                                  AppLocalizations.of(context)!.cancel,
                              variant: ElevarmDialogVariant.danger,
                            ).show(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.deleteBid3,
                                style: AppStyle.lbldrawerbtn.copyWith(
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.highlight_sharp, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 20),

                    // cont.apnaBiddingListModel == null ? SizedBox():
                    ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      primary: true,
                      itemCount:
                          data.data![widget.index].stackBuySellConver?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return IntrinsicHeight(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: data
                                                  .data![widget.index]
                                                  .stackBuySellConver?[index]
                                                  .userId
                                                  .toString() ==
                                              ref
                                                  .watch(
                                                    sharedUtilityProvider,
                                                  )
                                                  .getUser()
                                                  ?.userId
                                                  .toString()
                                          ? Colors.amber.shade900
                                          : Colors.white,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 4,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: data
                                                .data![widget.index]
                                                .stackBuySellConver?[index]
                                                .userId
                                                .toString() !=
                                            ref
                                                .watch(
                                                  sharedUtilityProvider,
                                                )
                                                .getUser()
                                                ?.userId
                                                .toString()
                                        ? BorderRadius.all(
                                            Radius.circular(10),
                                          )
                                        : BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!
                                                .trader,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Adaptive.sp(16),
                                            ),
                                          ),
                                          Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Adaptive.sp(16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 18.0,
                                          right: 18.0,
                                        ),
                                        child: VerticalDivider(
                                          thickness: 2,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!
                                                .bidPrice,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Adaptive.sp(16),
                                            ),
                                          ),
                                          Text(
                                            "₹${data.data![widget.index].stackBuySellConver?[index].price.toString()}",
                                            style: TextStyle(
                                              color: ColorConstant.maingreen,
                                              fontWeight: FontWeight.w500,
                                              fontSize: Adaptive.sp(16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 18.0,
                                          right: 18.0,
                                        ),
                                        child: VerticalDivider(
                                          thickness: 2,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!
                                                .liftingDays,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Adaptive.sp(16),
                                            ),
                                          ),
                                          Text(
                                            "${data.data![widget.index].stackBuySellConver?[index].lifitingDays ?? 0}",
                                            style: TextStyle(
                                              color: ColorConstant.maingreen,
                                              fontWeight: FontWeight.w500,
                                              fontSize: Adaptive.sp(16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (data.data![widget.index]
                                        .stackBuySellConver?[index].userId
                                        .toString() ==
                                    ref
                                        .watch(sharedUtilityProvider)
                                        .getUser()
                                        ?.userId
                                        .toString())
                                  Container(
                                    width: Get.width,
                                    padding: Pad(all: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: data
                                                    .data![widget.index]
                                                    .stackBuySellConver?[index]
                                                    .userId
                                                    .toString() ==
                                                ref
                                                    .watch(
                                                      sharedUtilityProvider,
                                                    )
                                                    .getUser()
                                                    ?.userId
                                                    .toString()
                                            ? Colors.amber.shade900
                                            : Colors.white,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 4,
                                        ),
                                      ],
                                      color: Colors.amber.shade900,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.msgMybid,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            error: (e, s) => Container(),
            loading: () => defaultLoader(),
          ),
    );
  }
}
