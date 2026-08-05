import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/widgets/AppDrawer.dart';
import 'package:apnagodam/core/utils/helper.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/BusinessProfile/BusinessProfile.dart';
import 'package:apnagodam/presentation/BusinessProfile/BusinessProfileListing.dart';
import 'package:apnagodam/presentation/BusinessProfile/Service/BusinessProfileService.dart';
import 'package:apnagodam/presentation/Feedback/Feedbackscreen.dart';
import 'package:apnagodam/presentation/GstProfile/GstListingScreen.dart';
import 'package:apnagodam/presentation/GstProfile/GstProfileScreen.dart';
import 'package:apnagodam/presentation/GstProfile/Service/GstService.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/MandiTaxListingScreen.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Service/MandiTaxProfileService.dart';
import 'package:apnagodam/presentation/dashboard/WarehouseBookings.dart';
import 'package:apnagodam/presentation/dashboard/model/CaseIdStatusModel.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/home_screen/models/summary_commodity_model.dart';
import 'package:apnagodam/presentation/home_screen/service/home_response_model.dart';
import 'package:apnagodam/presentation/home_screen/ui/AccountSettings.dart';
import 'package:apnagodam/presentation/home_screen/ui/Findwarehousescreen.dart';
import 'package:apnagodam/presentation/home_screen/ui/QualityCalculationScreen.dart';
import 'package:apnagodam/presentation/market_screen/service/market_service.dart';
import 'package:apnagodam/presentation/mybuy_screen/BuySellScreen.dart';
import 'package:apnagodam/presentation/sbt/service/model/MatchedOrdersModel.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackinward_screen.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackoutward_screen.dart';
import 'package:apnagodam/widgets/CustomTItleWidget.dart';
import 'package:apnagodam/widgets/enums.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:elevarm_icons/elevarm_icons.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/core/providers/app_language_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:apnagodam/presentation/sbt/service/SbtService.dart'
    as sbtService;

import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/main.dart';
import 'package:apnagodam/presentation/LP_list_screen/service/LpService.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/MandiTaxProfileScreen.dart';
import 'package:apnagodam/presentation/PurchaseOrder/PurchaseOrderScreen.dart';
import 'package:apnagodam/presentation/PurchaseOrder/PurchaseOrdersListScreen.dart';
import 'package:apnagodam/presentation/TripId/TripIdScreen.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/sbt/HoldSummary/SbtSummary.dart';
import 'package:apnagodam/presentation/sbt/SbtDeals.dart';
import 'package:apnagodam/presentation/sbt/SbtOrders.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../../core/utils/no_data_found_widget.dart';
import '../../LP_list_screen/google_map_screen.dart';
import '../../TripId/TripRequests/TripRequestScreen.dart';
import '../../credit/credit_screen.dart';
import '../../language/language.dart';
import '../../my_order_screen/my_order_screen.dart';
import '../../profile_screen/profile_screen.dart';
import '../../repayment_screen/repayment_screen.dart';
import '../../singup_screen/termandcon_webview.dart';
import '../../spot_order_booking_screen/spot_order_booking_screen.dart';
import '../../wallet_tabbar_screen/wallet_screen.dart';
import '../../warehouse_Tab/warehouse_tabbar.dart';
import '../kyc.dart';
import '../service/home_screen_service.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:apnagodam/presentation/home_screen/ui/FinanceScreen.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

var constitutionTypeProvider = StateProvider<ConstitutionType?>((ref) => null);
var isQualityPending = false;

class _HomepageState extends ConsumerState<Homepage> {
  final locationPermissionProvider = StateProvider(
    (ref) => Geolocator.checkPermission(),
  );

  var positionStream = StreamProvider(
    (ref) => Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      ),
    ),
  );

  CardSwiperController cardSwiperController = CardSwiperController();
  final buyOrdersListProvider = StateProvider((ref) => <MatchedOrdersDatum>[]);
  final sellOrdersListProvider = StateProvider((ref) => <MatchedOrdersDatum>[]);
  final islastItemProvider = StateProvider((ref) => false);
  var commoditiesList = StateProvider<List<Commodit>?>((ref) => []);
  var testimonialsList = StateProvider<List<Testimonial>?>((ref) => []);
  var comId;
  var wareId;
  double maxValue = 0.0;
  double currentValue = 0.0;
  double progressValue = 0.0;
  List<ChartData> chartData = [];
  var commodityFilterList = StateProvider<List<Datum?>>((ref) => []);
  var terminalFilterList = StateProvider<List<WareHousedatum?>>((ref) => []);
  var terminalRequestList = StateProvider<List<WareHousedatum>>((ref) => []);
  var commodityRequestList = StateProvider<List<Datum>>((ref) => []);
  var isLoading = StateProvider((ref) => true);

  var bannerList = [
    'assets/images/trade_banner.png',
    'assets/images/warehousing_banner.png',
    'assets/images/finance_banner.png',
  ];

  var whatsnew = [
    'https://www.agritell.com/wp-content/uploads/2025/08/Agritell-com-banner-2.jpg',
    'https://khetigaadi.com/news/wp-content/uploads/2021/10/MicrosoftTeams-image-46.jpg',
    'https://commodity-board.com/wordpress/wp-content/uploads/2024/11/Close-up-of-wheat-grains-in-a-farmers-hand-showcasing-the-quality-and-abundance-of-the-crop.-Little-bit-far-and-it-should-look-like-real.jpg',
  ];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await _checkAndShowLanguageDialog();
      await _initializeHomePage();
    });
  }

  Future<void> _checkAndShowLanguageDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShownLanguageDialog =
        prefs.getBool('hasShownLanguageDialog') ?? false;

    if (!hasShownLanguageDialog) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.msgChangeLanguage),
          content: Text(
            AppLocalizations.of(context)!.msgChangeLanguageContent,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.msgNo),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to language selection screen
                Get.to(LanguageScreen());
              },
              child: Text(AppLocalizations.of(context)!.msgYes),
            ),
          ],
        ),
      );

      await prefs.setBool('hasShownLanguageDialog', true);
    }
  }

  Future<void> _initializeHomePage() async {
    try {
      if (ref.watch(authProvider.notifier).loginStatus == AuthStatus.loggedIn) {
        await _fetchProfiles();
      }
      await _fetchHomeData();
      await _handleWarehouseBookings();
      await _setupNotificationHandlers();
      await _fetchBookingsData();
      await _handleUserAndDeviceInfo();
    } catch (e) {
      debugPrint("Error during init: $e");
    }
  }

  Future<void> _fetchBookingsData() async {
    final bookings = await ref.watch(allBookingsProvider(status: '1').future);

    if ((bookings.orders ?? []).isNotEmpty) {
      final firstOrder = bookings.orders!.first;

      if (firstOrder.pricingStatus?.toString() == "1" ||
          firstOrder.weightStatus?.toString() == "1") {
        Get.to(
          GooglemapScreen(
            image: firstOrder.passportImage?.toString(),
            name: firstOrder.name?.toString(),
            lpuserId: firstOrder.lpUserId?.toString(),
          ),
        );
      }
    }
  }

  Future<void> _fetchHomeData() async {
    ref.watch(isLoading.notifier).state = true;
    final homeData = await ref.watch(homeDataProvider.future);
    ref.watch(commoditiesList.notifier).state = homeData.commodites;

    ref.watch(isLoading.notifier).state = false;

    ref.watch(testimonialsList.notifier).state = homeData.testimonials;
  }

  Future<void> _handleWarehouseBookings() async {
    final bookingData = await ref.watch(warehouseBookingsProvider.future);
    final isQualityPending = bookingData.data?.any(
          (e) => e.firstQuality != null && e.fqTagging == null,
        ) ??
        false;

    if (isQualityPending) {
      showDialog(
        useSafeArea: true,
        context: context,
        builder: (_) => qualityPopupCardLayout(),
      );
    }
  }

  Future<void> _handleUserAndDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    if (ref.watch(authProvider.notifier).loginStatus == AuthStatus.loggedIn) {
      final userData = await ref.watch(userDetailsProvider.future);
      if (userData.userDetails != null) {
        await _updateDeviceId(androidInfo.id, userData);
      }
    }
  }

  Future<void> _updateDeviceId(String deviceId, userData) async {
    final position = await _getPosition();

    final dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: Duration(minutes: 10),
        sendTimeout: Duration(minutes: 10),
        receiveTimeout: Duration(minutes: 10),
      ),
    )..interceptors.add(PrettyDioLogger());

    await dio.post(
      'location/userLocation',
      data: {
        "fullName": "${userData.userDetails?.fname}",
        "phone": "${userData.userDetails?.phone}",
        "loginType": "user",
        "deviceId": deviceId,
        "empId": "NULL",
        "location": {
          "type": "Point",
          "coordinates": [
            position?.longitude ?? 0.0,
            position?.latitude ?? 0.0,
          ],
        },
        "appType": "user",
      },
    );
  }

  String _getBaseUrl() {
    final url = ref.watch(dioProvider).options.baseUrl.toLowerCase();
    if (url.contains('test') || url.contains('demo')) {
      return 'http://localhost:3000/api/';
    } else {
      return 'https://swlpl-next.vercel.app/api/';
    }
  }

  Future<Position?> _getPosition() async {
    final permission = await requestLocationPermission();
    if (permission) {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      ref.watch(sharedUtilityProvider).setPosition(position);
      return position;
    }
    return null;
  }

  Future<void> _fetchProfiles() async {
  try {
    final businessProfiles = await ref.watch(businessProfilesProvider.future);
    ref.watch(sharedUtilityProvider).setBusinessProfileStatus(businessProfiles.data != null);
  } catch (_) {
    ref.watch(sharedUtilityProvider).setBusinessProfileStatus(false);
  }

  try {
    final mandiTaxProfiles = await ref.watch(mandiTaxProfilesProvider.future);
    ref.watch(sharedUtilityProvider).setMandiTaxProfileStatus((mandiTaxProfiles.data ?? []).isNotEmpty);
  } catch (_) {
    ref.watch(sharedUtilityProvider).setMandiTaxProfileStatus(false);
  }

  try {
    final gstProfile = await ref.watch(gstListProvider.future);
    ref.watch(sharedUtilityProvider).setGstProfileStatus((gstProfile.data ?? []).isNotEmpty);
  } catch (_) {
    ref.watch(sharedUtilityProvider).setGstProfileStatus(false);
  }
}

  Future<void> _setupNotificationHandlers() async {
    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundNotification);

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _showLocalNotification(initialMessage);
    }
  }

  void _handleForegroundNotification(RemoteMessage message) {
    _showLocalNotification(message);
  }

  void _handleBackgroundNotification(RemoteMessage message) {
    _showLocalNotification(message);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    await FlutterLocalNotificationsPlugin().show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          icon: 'ic_stat_notify',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: data['value'],
    );
  }

  void fetchOrderData() async {
    final value = await ref.watch(sbtService.matchedOrdersProvider.future);
    final buyOrders = value.data
            ?.where((element) => element.type.toString().toLowerCase() == "buy")
            .toList() ??
        [];
    ref.watch(buyOrdersListProvider.notifier).state = buyOrders;

    final sellerOrders = value.data
            ?.where(
              (element) => element.type.toString().toLowerCase() == "sell",
            )
            .toList() ??
        [];
    ref.watch(sellOrdersListProvider.notifier).state = sellerOrders;
  }

  Widget qualityPopupCardLayout() => Consumer(
        builder: (context, ref, child) => ListView(
          children: [
            ref.watch(warehouseBookingsProvider).when(
                  data: (data) {
                    data.data = data.data
                        ?.where(
                          (e) => e.firstQuality != null && e.fqTagging == null,
                        )
                        .toList();

                    Future.value(Duration.zero).then((value) {
                      if ((data.data?.length ?? 0) <= 1) {
                        ref.watch(islastItemProvider.notifier).state = true;
                      }
                    });
                    return IntrinsicHeight(
                      child: SizedBox(
                        height: Adaptive.sh(100),
                        child: (data.data ?? []).isEmpty
                            ? Text(
                                AppLocalizations.of(context)!.noDataFound,
                              )
                            : CardSwiper(
                                controller: cardSwiperController,
                                cardsCount: data.data?.length ?? 0,
                                numberOfCardsDisplayed:
                                    data.data?.length == 1 ? 1 : 2,
                                cardBuilder: (
                                  context,
                                  index,
                                  percentThresholdX,
                                  percentThresholdY,
                                ) =>
                                    Container(
                                  padding: Pad(all: 10),
                                  margin: Pad(all: 20),
                                  child: IntrinsicHeight(
                                    child: Card(
                                      child: Padding(
                                        padding: Pad(all: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              )!
                                                  .approveQuality,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(18),
                                              ),
                                            ),
                                            ElevarmDivider(),
                                            SizedBox(height: 10),
                                            Text.rich(
                                              TextSpan(
                                                text: AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .warehouse +
                                                    ':',
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${data.data?[index].terminalName}",
                                                  ),
                                                ],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: Adaptive.sp(
                                                    16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .msgGatepass,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "${data.data?[index].gatePass}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!
                                                      .msgCommodity,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Text.rich(
                                                  TextSpan(
                                                    text:
                                                        "${data.data?[index].cateName ?? ""}",
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(
                                                      16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            ref
                                                .watch(
                                                  bookingQualityParametersProvider(
                                                    caseId:
                                                        "${data.data?[index].caseId}",
                                                  ),
                                                )
                                                .when(
                                                  data: (
                                                    qualityData,
                                                  ) =>
                                                      ColumnSuper(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0,
                                                        ),
                                                        child: ColumnSuper(
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      AppLocalizations
                                                                              .of(
                                                                        context,
                                                                      )!
                                                                          .name,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                          16,
                                                                        ),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      AppLocalizations
                                                                              .of(
                                                                        context,
                                                                      )!
                                                                          .value,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            Adaptive.sp(
                                                                          16,
                                                                        ),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Column(
                                                              children:
                                                                  List.generate(
                                                                qualityData.data
                                                                        ?.length ??
                                                                    0,
                                                                (
                                                                  qualityIndex,
                                                                ) =>
                                                                    Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        '${qualityData.data?[qualityIndex].parameter}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontSize:
                                                                              Adaptive.sp(
                                                                            16,
                                                                          ),
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        '${qualityData.data?[qualityIndex].value}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              Adaptive.sp(
                                                                            16,
                                                                          ),
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    AppLocalizations
                                                                            .of(
                                                                      context,
                                                                    )!
                                                                        .live,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          Adaptive
                                                                              .sp(
                                                                        16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    '${qualityData.liveInsects ?? 0}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          Adaptive
                                                                              .sp(
                                                                        16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 30,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            ElevarmDivider(),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 30,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    AppLocalizations
                                                                            .of(
                                                                      context,
                                                                    )!
                                                                        .qualityClaimPerQtl,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          Adaptive
                                                                              .sp(
                                                                        16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    '\u{20B9}${qualityData.qvAmount ?? 0}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          Adaptive
                                                                              .sp(
                                                                        16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 30,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  error: (e, s) => Container(),
                                                  loading: () =>
                                                      defaultLoader(),
                                                ),
                                            Spacer(),
                                            IntrinsicWidth(
                                              child: actionWidget(
                                                data.data?[index],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    );
                  },
                  error: (e, s) => Container(),
                  loading: () => defaultLoader(),
                ),
          ],
        ),
      );

  Widget actionWidget(CaseIdDatum? data) {
    var textStyle = TextStyle(
      fontSize: Adaptive.sp(16),
      fontWeight: FontWeight.bold,
    );
    if (data?.labourbook == null) {
      return ElevarmPrimaryButton.text(
        text: AppLocalizations.of(context)!.labourBookPending,
        buttonThemeData: ElevarmPrimaryButtonThemeData(
          disabledColor: ColorConstant.maingreen.withOpacity(0.3),
        ),
      );
    } else if (data?.firstKantaParchi == null && data?.labourbook != null) {
      return ElevarmPrimaryButton.text(
        text: AppLocalizations.of(context)!.firstKantaPending,
        buttonThemeData: ElevarmPrimaryButtonThemeData(
          disabledColor: ColorConstant.maingreen.withOpacity(0.3),
        ),
      );
    } else if (data?.firstKantaParchi != null && data?.firstQuality == null) {
      return ElevarmPrimaryButton.text(
        text: AppLocalizations.of(context)!.firstQualityPending,
        buttonThemeData: ElevarmPrimaryButtonThemeData(
          disabledColor: ColorConstant.maingreen.withOpacity(0.3),
        ),
      );
    } else if (data?.firstQuality != null && data?.fqTagging == null) {
      return Padding(
        padding: Pad(all: 10),
        child: Row(
          children: [
            Expanded(
              child: ElevarmPrimaryButton.text(
                buttonThemeData: ElevarmPrimaryButtonThemeData(
                  primaryColor: ColorConstant.maingreen,
                ),
                text: AppLocalizations.of(context)!.approve,
                onPressed: () {
                  ref
                      .watch(
                    approveBookingParametersProvider(
                      caseId: "${data?.caseId}",
                    ).future,
                  )
                      .then((value) {
                    if (value['status'].toString() == "1") {
                      ref.invalidate(warehouseBookingsProvider);
                      Fluttertoast.showToast(
                        msg: value['message'],
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.green,
                      );

                      if (ref.watch(islastItemProvider)) {
                        Navigator.of(context, rootNavigator: false).pop();
                      }
                    }
                  });
                },
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: ElevarmPrimaryButton.text(
                buttonThemeData: ElevarmPrimaryButtonThemeData(
                  primaryColor: ElevarmColors.danger,
                ),
                text: AppLocalizations.of(context)!.reject,
                onPressed: () {
                  ref
                      .watch(
                    rejectQualityProvider(caseId: "${data?.caseId}").future,
                  )
                      .then((value) {
                    if (value['status'].toString() == "1") {
                      ref.invalidate(warehouseBookingsProvider);
                      Fluttertoast.showToast(
                        msg: value['message'],
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.green,
                      );

                      if (ref.watch(islastItemProvider)) {
                        Navigator.of(context, rootNavigator: false).pop();
                      }
                    }
                  });
                },
              ),
            ),
          ],
        ),
      );
    } else if (data?.fqTagging != null && data?.sKParchi == null) {
      return ElevarmPrimaryButton.text(
        text: AppLocalizations.of(context)!.secondKantaParchiPending,
        buttonThemeData: ElevarmPrimaryButtonThemeData(
          disabledColor: ColorConstant.maingreen.withOpacity(0.3),
        ),
      );
    } else if (data?.fqTagging != null && data?.sQualityReport == null) {
      return ElevarmPrimaryButton.text(
        text: AppLocalizations.of(context)!.secondQualityReportPending,
        buttonThemeData: ElevarmPrimaryButtonThemeData(
          disabledColor: ColorConstant.maingreen.withOpacity(0.3),
        ),
      );
    } else if (data?.ivrReport == null) {
      return ElevarmPrimaryButton.text(
        text: AppLocalizations.of(context)!.gatepassRecommended,
        buttonThemeData: ElevarmPrimaryButtonThemeData(
          disabledColor: ColorConstant.maingreen.withOpacity(0.3),
        ),
      );
    } else if (data?.ivrReport != null && data?.gatepassReport == null) {
      return ElevarmPrimaryButton.text(
        text: AppLocalizations.of(context)!.gatepassPending,
        buttonThemeData: ElevarmPrimaryButtonThemeData(
          disabledColor: ColorConstant.maingreen.withOpacity(0.3),
        ),
      );
    }
    return Text(AppLocalizations.of(context)!.done);
  }

  Widget _buildGridItem(
    BuildContext context, {
    required VoidCallback onTap,
    required Widget icon,
    required String label,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorConstant.maingreen.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.maingreen.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text.rich(
              TextSpan(text: label),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Adaptive.sp(14),
                color: ColorConstant.maingreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWrapItem(
    BuildContext context, {
    required VoidCallback onTap,
    required Widget icon,
    required String label,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorConstant.maingreen.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.maingreen.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text.rich(
              TextSpan(text: label),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Adaptive.sp(14),
                color: ColorConstant.maingreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch locale provider to trigger rebuild on language change
    //   ref.watch(localeProvider);
    requestLocationPermission();
    return Scaffold(
      backgroundColor: ColorConstant.bgcolor,
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
        title: TextButton(
          onPressed: () async {
            // Get.to(Profilingregistration());
          },
          child: Text(
            ref.watch(authProvider.notifier).loginStatus == AuthStatus.loggedIn
                ? ref.watch(sharedUtilityProvider).isKycComplete()
                    ? AppLocalizations.of(context)!.dashboard
                    : AppLocalizations.of(context)!.msgKycupdate
                : AppLocalizations.of(context)!.dashboard,
            style: AppStyle.lblmoneybtn,
          ),
        ),
        actions: [
          // InkWell(
          //   onTap: () {
          //     Get.to(Wallet(
          //       isAppBarVisible: true,
          //     ));
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.all(10.0),
          //     child: Image.asset(
          //       'assets/images/icon_wallet.png',
          //       height: 16,
          //       width: 16,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          ref.watch(authProvider.notifier).loginStatus == AuthStatus.loggedIn
              ? IconButton(
                  onPressed: () {
                    Get.to(Profile());
                  },
                  icon: ref.watch(authProvider.notifier).loginStatus ==
                          AuthStatus.loggedOut
                      ? CircleAvatar(
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 17,
                          ),
                        )
                      : ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                "$IMAGE_BASE_URL_FRONTEND${ref.watch(sharedUtilityProvider).getUser()?.profileImage}",
                            fit: BoxFit.cover,
                            width: 40,
                            height: 50,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                              color: Colors.transparent,
                            ),
                            errorWidget: (context, url, error) => DottedBorder(
                              borderType: BorderType.Circle,
                              padding: Pad(all: 10),
                              child: Center(
                                child: ElevarmIcon(
                                  ElevarmIconsOutline.image_01,
                                ),
                              ),
                            ),
                          ),
                        ),
                )
              : ElevatedButton(
                  onPressed: () {
                    showLoginBottomsheet(context);
                  },
                  style: AppStyle.buttonStyle.copyWith(
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => Colors.white,
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.msgLoging,
                    style: TextStyle(
                      color: ColorConstant.maingreen,
                      fontSize: Adaptive.sp(15),
                  ),
                ),
          )],
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(homeDataProvider);
            ref.invalidate(allBookingsProvider);
            ref.invalidate(warehouseBookingsProvider);
            ref.invalidate(userDetailsProvider);
            ref.invalidate(matchedOrdersProvider);
            await Future.delayed(const Duration(milliseconds: 600));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                // // Locale test: shows current app language provider and a sample localized string
                // Card(
                //   margin: EdgeInsets.symmetric(horizontal: 10),
                //   child: Padding(
                //     padding: EdgeInsets.all(12),
                //     child: Consumer(
                //       builder: (context, ref, child) {
                //         final code = ref.watch(appLanguageProvider);
                //         final sample = AppLocalizations.of(context)!.msgLanuage;
                //         return Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text('Locale test: $code',
                //                 style: TextStyle(fontWeight: FontWeight.bold)),
                //             SizedBox(height: 4),
                //             Text('Localized sample: $sample'),
                //           ],
                //         );
                //       },
                //     ),
                //   ),
                // ),
                SizedBox(height: 10),
                FlutterCarousel.builder(
                  itemCount: bannerList.length,
                  options: FlutterCarouselOptions(
                    floatingIndicator: false,
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayCurve: Curves.easeInOut,
                    slideIndicator: CircularSlideIndicator(
                      slideIndicatorOptions: SlideIndicatorOptions(
                        enableAnimation: true,
                        enableHalo: true,
                        indicatorBackgroundColor: ColorConstant.whiteA700,
                        currentIndicatorColor: ColorConstant.maingreen,
                      ),
                    ),
                  ),
                  itemBuilder: (context, index, _) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Image.asset(
                              bannerList[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.5),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                            // Positioned(
                            //   bottom: 20,
                            //   left: 20,
                            //   child: Text(
                            //     index == 0
                            //         ? "Trading"
                            //         : index == 1
                            //             ? "Warehousing"
                            //             : AppLocalizations.of(context)!.finance,
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold,
                            //       shadows: [
                            //         Shadow(
                            //           offset: Offset(0, 2),
                            //           blurRadius: 4,
                            //           color: Colors.black.withOpacity(0.8),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // InkWell(
                //   onTap: () {},
                //   child: Image.asset('assets/images/apnagodam_finance.png'),
                // ),
                SizedBox(height: 16),
                // customTitleWidget(title: AppLocalizations.of(context)!.trade2),
                // SizedBox(height: 10),
                // Bidsscreen(),
                SizedBox(height: 16),
                customTitleWidget(
                  title: AppLocalizations.of(context)!.warehousingSolutions,
                ),
                SizedBox(height: 16),
                GridView.count(
                  padding: EdgeInsets.all(5),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                  children: [
                    _buildGridItem(
                      context,
                      onTap: () {
                        Get.to(Findwarehousescreen(isAppBarVisible: true));
                      },
                      icon: Image.asset(
                        ImageConstant.imgwarehouse,
                        width: 40,
                        height: 40,
                        color: ColorConstant.maingreen,
                      ),
                      label: AppLocalizations.of(context)!.findWarehouses,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {
                        if (ref.watch(authProvider.notifier).loginStatus ==
                            AuthStatus.loggedIn) {
                          Get.to(StackInward(isAppbarVisible: true));
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      icon: Image.asset(
                        'assets/images/inward.png',
                        color: ColorConstant.maingreen,
                        width: 60,
                        height: 60,
                      ),
                      label: AppLocalizations.of(context)!.inwards,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {
                        if (ref.watch(authProvider.notifier).loginStatus ==
                            AuthStatus.loggedIn) {
                          Get.to(StackOutward(isAppBarVisible: true));
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      icon: Image.asset(
                        'assets/images/outward.png',
                        color: ColorConstant.maingreen,
                        width: 60,
                        height: 60,
                      ),
                      label: AppLocalizations.of(context)!.outwards,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {
                        if (ref.watch(authProvider.notifier).loginStatus ==
                            AuthStatus.loggedIn) {
                          Get.to(Warehousebookings(isAppBarVisible: true));
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      icon: Image.asset(
                        'assets/images/quality.png',
                        color: ColorConstant.maingreen,
                        width: 60,
                        height: 60,
                      ),
                      label: AppLocalizations.of(context)!.qualityConsent,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {
                        if (ref.watch(authProvider.notifier).loginStatus ==
                            AuthStatus.loggedIn) {
                          Get.to(RepaymentScreen());
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      icon: Image.asset(
                        ImageConstant.imgrepayment,
                        width: 40,
                        height: 40,
                        color: ColorConstant.maingreen,
                      ),
                      label: AppLocalizations.of(context)!.msgRepayment,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {
                        Get.to(Qualitycalculationscreen());
                      },
                      icon: Icon(
                        Icons.calculate_outlined,
                        color: ColorConstant.maingreen,
                        size: 40,
                      ),
                      label: AppLocalizations.of(context)!.calculateQuality,
                    ),
                  ],
                ),
                // Padding(
                //   padding: Pad(horizontal: 10),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(12),
                //     child: Stack(
                //       children: [
                //         Image.asset(
                //           'assets/banner_warehousing.png',
                //           fit: BoxFit.cover,
                //           width: double.infinity,
                //           height: 200,
                //         ),
                //         Positioned.fill(
                //           child: Container(
                //             decoration: BoxDecoration(
                //               gradient: LinearGradient(
                //                 colors: [
                //                   Colors.black.withOpacity(0.8),
                //                   Colors.transparent,
                //                 ],
                //                 begin: Alignment.bottomCenter,
                //                 end: Alignment.topCenter,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Positioned(
                //           bottom: 20,
                //           left: 20,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 AppLocalizations.of(context)!.msgWarehousing,
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 20,
                //                   fontWeight: FontWeight.bold,
                //                   shadows: [
                //                     Shadow(
                //                       offset: Offset(0, 2),
                //                       blurRadius: 4,
                //                       color: Colors.black.withOpacity(0.8),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               SizedBox(height: 8),
                //               TextButton(
                //                 onPressed: () {
                //                   ref.watch(selectedIndex.notifier).state = 1;
                //                 },
                //                 style: TextButton.styleFrom(
                //                   backgroundColor:
                //                       Colors.white.withOpacity(0.8),
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(8),
                //                   ),
                //                   padding: EdgeInsets.symmetric(
                //                       vertical: 8, horizontal: 16),
                //                 ),
                //                 child: Text(
                //                   'Learn More',
                //                   style: TextStyle(
                //                     color: ColorConstant.maingreen,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 16),
                customTitleWidget(title: AppLocalizations.of(context)!.finance),
                SizedBox(height: 16),
                Padding(
                  padding: Pad(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/swfl.png',
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: 200,
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!
                                    .financialSolutions,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              TextButton(
                                onPressed: () {
                                  Get.to(FinanceScreen());
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(
                                    0.8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.learnMore,
                                  style: TextStyle(
                                    color: ColorConstant.maingreen,
                                    fontWeight: FontWeight.bold,
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

                // SizedBox(height: 16),
                // customTitleWidget(title: AppLocalizations.of(context)!.bulletinBoard2),
                // SizedBox(height: 10),
                // FlutterCarousel.builder(
                //   itemCount: whatsnew.length,
                //   options: FlutterCarouselOptions(
                //     floatingIndicator: false,
                //     aspectRatio: 16 / 10,
                //     autoPlay: true,
                //     viewportFraction: 1,
                //     autoPlayCurve: Curves.linear,
                //     slideIndicator: CircularSlideIndicator(
                //       slideIndicatorOptions: SlideIndicatorOptions(
                //         enableAnimation: true,
                //         enableHalo: true,
                //         indicatorBackgroundColor: ColorConstant.whiteA700,
                //         currentIndicatorColor: ColorConstant.maingreen,
                //       ),
                //     ),
                //   ),
                //   itemBuilder: (context, index, _) {
                //     return ClipRRect(
                //       borderRadius: BorderRadius.circular(5),
                //       child: Image.network(
                //         whatsnew[index],
                //         fit: BoxFit.fill,
                //       ),
                //     );
                //   },
                // ),
                // SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: RippleAnimation(
              color: ColorConstant.red500,
              delay: Duration(milliseconds: 150),
              repeat: true,
              minRadius: 0,
              maxRadius: 0,
              ripplesCount: 8,
              duration: Duration(milliseconds: 6 * 300),
              child: IconButton(
                icon: Image.asset(
                  ImageConstant.imgwhatsapp,
                  width: Adaptive.sp(30),
                  height: Adaptive.sp(30),
                ),
                // onPressed: (){},
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (bottomsheetContext) => ElevarmBottomSheet(
                      initialChildSize: 1,
                      minChildSize: 1,
                      onPressedClose: () {
                        Navigator.of(bottomsheetContext).pop();
                      },
                      title: 'Help',
                      children: [
                        Column(
                          children: [
                            // Container(
                            //   decoration:  BoxDecoration(
                            //       color: ColorConstant.maingreen,
                            //       borderRadius: BorderRadius.only(
                            //           topLeft: Radius.circular(8),
                            //           topRight: Radius.circular(8))),
                            //   child: Padding(
                            //     padding:  EdgeInsets.only(
                            //         left: 25.0, top: 10, bottom: 10),
                            //     child: Row(
                            //       children: [
                            //          Icon(
                            //           Icons.support_agent,
                            //           color: Colors.amber,
                            //         ),
                            //          SizedBox(
                            //           width: 10,
                            //         ),
                            //         Text(AppLocalizations.of(context)!.msgHelp,
                            //             style: AppStyle.lblbuydetail
                            //                 .copyWith(
                            //                     fontSize: Adaptive.sp(17))),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 8),
                            Consumer(
                              builder: (context, ref, child) => ref
                                  .watch(faqProvider)
                                  .when(
                                    data: (faqData) => ExpansionTile(
                                      title: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!
                                            .faq,
                                        style: AppStyle.lblalerttext.copyWith(
                                          fontSize: Adaptive.sp(
                                            17,
                                          ),
                                        ),
                                      ),
                                      leading: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xfffcf2f0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            8.0,
                                          ),
                                          child: Image.asset(
                                            ImageConstant.imgwhatsapp,
                                            width: 28,
                                          ),
                                        ),
                                      ),
                                      children: faqData.data!
                                          .map(
                                            (
                                              element,
                                            ) =>
                                                ListTile(
                                              onTap: () async {
                                                var launchUrl = element.type
                                                            .toString()
                                                            .toLowerCase() ==
                                                        "other"
                                                    ? 'https://api.whatsapp.com/send/?phone=917733901154'
                                                    : 'https://api.whatsapp.com/send/?phone=917733901154&text=${element.type ?? ""}';
                                                Navigator.of(
                                                  context,
                                                  rootNavigator: true,
                                                ).pop();
                                                CallLaunch(
                                                  launchUrl,
                                                );
                                              },
                                              leading: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(
                                                    0xfffcf2f0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Image.asset(
                                                    ImageConstant.imgwhatsapp,
                                                    width: 28,
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                "${element.type}",
                                                style: AppStyle.lblalerttext
                                                    .copyWith(
                                                  fontSize: Adaptive.sp(
                                                    17,
                                                  ),
                                                ),
                                              ),
                                              trailing: Icon(
                                                Icons.chevron_right_outlined,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    error: (e, s) => Container(),
                                    loading: () => defaultLoader(),
                                  ),
                            ),
                            Divider(color: ColorConstant.grey),
                            ListTile(
                              onTap: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                                CallLaunch('tel:+917733901154');
                              },
                              leading: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xfffcf2f0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              title: Text(
                                AppLocalizations.of(
                                  context,
                                )!
                                    .msgCallforHelp,
                                style: AppStyle.lblalerttext.copyWith(
                                  fontSize: Adaptive.sp(17),
                                ),
                              ),
                              trailing: Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeLoader() => Skeletonizer(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // My Sell & My Buy Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildOrderCard(
                        title: 'My Selling Deals',
                        count: ref.watch(sellOrdersListProvider).length,
                        onTap: () => Get.to(Sbtdeals(selectedIndex: 0)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildOrderCard(
                        title: 'My Buying Deals',
                        count: ref.watch(buyOrdersListProvider).length,
                        onTap: () => Get.to(Sbtdeals(selectedIndex: 1)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Commodity Grid Title
                GridView.count(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                  children: [
                    _buildGridItem(
                      context,
                      onTap: () {},
                      icon: Image.asset(
                        ImageConstant.imgwarehouse,
                        width: 40,
                        height: 40,
                        color: ColorConstant.maingreen,
                      ),
                      label: AppLocalizations.of(context)!.msgWarehousefacility,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {},
                      icon: Image.asset(
                        ImageConstant.imgrepayment,
                        width: 40,
                        height: 40,
                        color: ColorConstant.maingreen,
                      ),
                      label: AppLocalizations.of(context)!.msgRepayment,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {},
                      icon: Icon(
                        Icons.calculate_outlined,
                        color: ColorConstant.maingreen,
                        size: 40,
                      ),
                      label: AppLocalizations.of(context)!.calculateQuality,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {},
                      icon: Image.asset(
                        ImageConstant.imgmarket,
                        color: ColorConstant.maingreen,
                      ),
                      label: AppLocalizations.of(context)!.trading,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {},
                      icon: Icon(
                        Icons.wallet_outlined,
                        color: ColorConstant.maingreen,
                        size: 40,
                      ),
                      label: AppLocalizations.of(context)!.wallet,
                    ),
                    _buildGridItem(
                      context,
                      onTap: () {},
                      icon: Image.asset(
                        ImageConstant.imgmysell,
                        color: ColorConstant.maingreen,
                      ),
                      label: AppLocalizations.of(context)!.buySellCommodity,
                    ),
                  ],
                ),
                customTitleWidget(title: "buy_sell_commoduty"),
                SizedBox(height: 10),

                // Commodity Grid
                _summaryLoader(),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 66,
                            width: 66,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            child: ClipOval(
                              child: SizedBox(
                                  // fallback skeleton for null image
                                  ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Loading....",
                            style: AppStyle.lblaccontsecond.copyWith(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),

                // Testimonials Title
                customTitleWidget(title: "What Customers says"),
                SizedBox(height: 10),

                // Testimonials Carousel
                FlutterCarousel.builder(
                  itemCount: 2,
                  options: FlutterCarouselOptions(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayCurve: Curves.linear,
                    slideIndicator: CircularSlideIndicator(
                      slideIndicatorOptions: SlideIndicatorOptions(
                        indicatorBackgroundColor: ColorConstant.maingreen,
                        currentIndicatorColor: Colors.yellow,
                      ),
                    ),
                  ),
                  itemBuilder: (context, index, _) {
                    return Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(
                              child: Text(
                                "Most farmers in the country are unable to reap the benefits of their hard labour as they get cheated by middlemen.With Apnagodam increasing the ear country.",
                                style: AppStyle.lbltestimonial.copyWith(
                                  color: Colors.black,
                                  fontSize: Adaptive.sp(16),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: Adaptive.sp(20),
                                  backgroundImage: NetworkImage("loading..."),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Loading...",
                                    style:
                                        AppStyle.lblontestimonalname.copyWith(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
  Widget _buildOrderCard({
    required String title,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: ColorConstant.maingreen,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Adaptive.sp(16),
                  color: Colors.white,
                ),
              ),
              Text(
                '$count',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Adaptive.sp(18),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_summaryLoader() => Skeletonizer(
      child: Column(
        children: [
          ColumnSuper(
            children: [
              SizedBox(height: 10),
              ElevarmOutlinedCard(
                child: ElevarmStackedHorizontalBarChart(
                  tooltipTitle: 'Commodities',
                  legendValueBuilder: (data) => '1',
                  dataSource: [
                    ElevarmStackedHorizontalBarChartData(
                      label: 'Released Weight(in Qtl.)',
                      value: num.parse('0').toInt(),
                      color: ElevarmColors.success,
                      customData: '',
                    ),
                    ElevarmStackedHorizontalBarChartData(
                      label: 'Funded Weight(in Qtl.)',
                      value: num.parse('0').toInt(),
                      color: ElevarmColors.danger,
                      customData: 'hello',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: Pad(all: 5),
                child: ElevarmDonutChartCard(
                  title: 'Released and Funded',
                  subtitle: 'Total Weight:  Total Bags: ',
                  dataSource: [
                    ElevarmDonutChartData(
                      label: 'Released Weight (in Qtl.): ',
                      value: num.parse('0').toInt(),
                      color: ColorConstant.maingreen,
                    ),
                    ElevarmDonutChartData(
                      label: 'Funded Weight (in Qtl.): ',
                      value: num.parse('0').toInt(),
                      color: ElevarmColors.danger,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Filter Commodity ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Adaptive.sp(16),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () async {},
            child: Text(
              'Loading...',
              style: TextStyle(
                color: ColorConstant.maingreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Filter Terminals ',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Adaptive.sp(16),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () async {},
            child: Text(
              'Loading...',
              style: TextStyle(
                color: ColorConstant.maingreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
var commodityNameProvider = StateProvider<List<String?>>((ref) => []);
var warehouseNameProvider = StateProvider<List<String?>>((ref) => []);

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 240,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: color,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xFF12281B), // Deep green-black
                        Color(0xFF275135), // Your main green
                        Color(0xFF3E7251),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorConstant.maingreen,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(icon, color: color, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle1,
                    style: TextStyle(
                      fontSize: Adaptive.sp(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevarmDivider(),
                  Text(
                    subtitle2,
                    style: TextStyle(
                      fontSize: Adaptive.sp(15),
                      fontWeight: FontWeight.bold,
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
}
