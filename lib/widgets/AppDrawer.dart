import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/helper.dart';
import 'package:apnagodam/core/utils/image_constant.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/presentation/BusinessProfile/BusinessProfile.dart';
import 'package:apnagodam/presentation/BusinessProfile/BusinessProfileListing.dart';
import 'package:apnagodam/presentation/Feedback/Feedbackscreen.dart';
import 'package:apnagodam/presentation/GstProfile/GstListingScreen.dart';
import 'package:apnagodam/presentation/GstProfile/GstProfileScreen.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/MandiTaxListingScreen.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/MandiTaxProfileScreen.dart';
import 'package:apnagodam/presentation/PurchaseOrder/PurchaseOrderScreen.dart';
import 'package:apnagodam/presentation/PurchaseOrder/PurchaseOrdersListScreen.dart';
import 'package:apnagodam/presentation/TripId/TripIdScreen.dart';
import 'package:apnagodam/presentation/TripId/TripRequests/TripRequestScreen.dart';
import 'package:apnagodam/presentation/credit/credit_screen.dart';
import 'package:apnagodam/presentation/home_screen/kyc.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/home_screen/ui/AccountSettings.dart';
import 'package:apnagodam/presentation/home_screen/ui/QualityCalculationScreen.dart';
import 'package:apnagodam/presentation/language/language.dart';
import 'package:apnagodam/presentation/my_order_screen/my_order_screen.dart';
import 'package:apnagodam/presentation/mybuy_screen/BuySellScreen.dart';
import 'package:apnagodam/presentation/profile_screen/profile_screen.dart';
import 'package:apnagodam/presentation/repayment_screen/repayment_screen.dart';
import 'package:apnagodam/presentation/sbt/HoldSummary/SbtSummary.dart';
import 'package:apnagodam/presentation/sbt/SbtDeals.dart';
import 'package:apnagodam/presentation/sbt/SbtOrders.dart';
import 'package:apnagodam/presentation/singup_screen/termandcon_webview.dart';
import 'package:apnagodam/presentation/spot_order_booking_screen/spot_order_booking_screen.dart';
import 'package:apnagodam/presentation/wallet_tabbar_screen/wallet_screen.dart';
import 'package:apnagodam/presentation/warehouse_Tab/warehouse_tabbar.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// 100% Identical Shared Drawer Widget used across Dashboard & Home Page
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn =
        ref.watch(authProvider.notifier).loginStatus == AuthStatus.loggedIn;

    return Drawer(
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Padding(
          padding: Pad(
            left: 10,
            right: 10,
            top: MediaQuery.of(context).padding.top,
          ),
          child: ListView(
            children: [
              isLoggedIn
                  ? InkWell(
                      onTap: () {
                        Get.to(Profile());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: ColorConstant.maingreen),
                        ),
                        color: Colors.white,
                        elevation: 3,
                        child: ref.watch(userDetailsProvider).when(
                              data: (userData) {
                                final user = userData.userDetails ??
                                    ref.watch(sharedUtilityProvider).getUser();
                                final isKycComplete = userData
                                            .userDetails?.verifiedAccount
                                            .toString() ==
                                        "2"
                                    ? true
                                    : ref
                                        .watch(sharedUtilityProvider)
                                        .isKycComplete();

                                return Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Avatar + Name/Phone/Balance
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ElevarmAvatar(
                                            showVerifiedTick: isKycComplete,
                                            image: CachedNetworkImageProvider(
                                              "$IMAGE_BASE_URL_FRONTEND${user?.profileImage}",
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  user?.fname ?? '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: Adaptive.sp(16),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  user?.phone ?? '',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: Adaptive.sp(15),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '${AppLocalizations.of(context)!.walletBalance}: \u{20B9}${user?.power ?? 0}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    fontSize: Adaptive.sp(15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 16),

                                      // Action buttons
                                      Row(
                                        children: [
                                          Expanded(
                                            child: actionButton(
                                              onTap: () => Get.to(
                                                Wallet(
                                                  isAppBarVisible: true,
                                                ),
                                              ),
                                              icon: ImageConstant.wallet,
                                              label: AppLocalizations.of(
                                                context,
                                              )!
                                                  .wallet,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              error: (e, s) => const SizedBox(),
                              loading: () => const Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            ),
                      ),
                    )
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
                            text: AppLocalizations.of(context)!.msgLoging,
                            callback: () => showLoginBottomsheet(context),
                          ),
                        ],
                      ),
                    ),

              const SizedBox(height: 10),
              actionButton(
                onTap: () => Get.to(LanguageScreen()),
                icon: ImageConstant.languagee,
                label: AppLocalizations.of(context)!.msgLanuage,
              ),
              InkWell(
                onTap: () {
                  Get.to(Qualitycalculationscreen());
                },
                child: Padding(
                  padding: Pad(all: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calculate_outlined,
                        color: ColorConstant.maingreen,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.start,
                          AppLocalizations.of(
                            context,
                          )!
                              .qualityVarianceCalculator,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16),
                            color: ColorConstant.maingreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),
              if (isLoggedIn)
                InkWell(
                  onTap: () {
                    if (ref.watch(authProvider).value ==
                        AuthStatus.loggedIn) {
                      Get.to(WarehouseTab());
                    } else {
                      showLoginBottomsheet(context);
                    }
                  },
                  child: Padding(
                    padding: Pad(all: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageConstant.imgwarehouse,
                          width: 20,
                          height: 20,
                          color: ColorConstant.maingreen,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.start,
                            AppLocalizations.of(
                              context,
                            )!
                                .msgWarehousefacility,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16),
                              color: ColorConstant.maingreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (isLoggedIn) const SizedBox(height: 10),
              if (isLoggedIn)
                InkWell(
                  onTap: () {
                    if (ref.watch(authProvider).value ==
                        AuthStatus.loggedIn) {
                      Get.to(RepaymentScreen());
                    } else {
                      showLoginBottomsheet(context);
                    }
                  },
                  child: Padding(
                    padding: Pad(all: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageConstant.imgrepayment,
                          width: 20,
                          height: 20,
                          color: ColorConstant.maingreen,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.start,
                            AppLocalizations.of(context)!.msgRepayment,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16),
                              color: ColorConstant.maingreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (isLoggedIn) const SizedBox(height: 10),
              if (isLoggedIn)
                ExpansionTile(
                  tilePadding: Pad(left: 10),
                  title: Row(
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        AppLocalizations.of(context)!.profiling,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Adaptive.sp(16),
                          color: ColorConstant.maingreen,
                        ),
                      ),
                    ],
                  ),
                  leading: SvgPicture.asset(
                    ImageConstant.mandiTax,
                    width: 20,
                    height: 20,
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        if (ref.watch(authProvider).value ==
                            AuthStatus.loggedIn) {
                          Get.to(KYC(isAppbarVisible: true, kyctag: ""));
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      child: Padding(
                        padding: Pad(all: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ImageConstant.mandiTax,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                AppLocalizations.of(context)!.kycProfile,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                            ref
                                        .watch(sharedUtilityProvider)
                                        .isKycComplete() ==
                                    false
                                ? const Icon(Icons.verified, color: Colors.grey)
                                : Icon(
                                    Icons.verified,
                                    color: ColorConstant.maingreen,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        if (ref.watch(authProvider).value ==
                            AuthStatus.loggedIn) {
                          if (ref
                              .watch(sharedUtilityProvider)
                              .isBusinessProfileActive()) {
                            Get.to(Businessprofilelisting());
                          } else {
                            Get.to(Businessprofile());
                          }
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      child: Padding(
                        padding: Pad(all: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ImageConstant.mandiTax,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                AppLocalizations.of(context)!.businessProfile,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                            ref
                                        .watch(sharedUtilityProvider)
                                        .isBusinessProfileActive() ==
                                    false
                                ? const Icon(Icons.verified, color: Colors.grey)
                                : Icon(
                                    Icons.verified,
                                    color: ColorConstant.maingreen,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        if (ref.watch(authProvider).value ==
                            AuthStatus.loggedIn) {
                          if (ref
                              .watch(sharedUtilityProvider)
                              .isMandiTaxProfileActive()) {
                            Get.to(Manditaxlistingscreen());
                          } else {
                            Get.to(
                              Manditaxprofilescreen(isAppbarVisible: true),
                            );
                          }
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      child: Padding(
                        padding: Pad(all: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ImageConstant.mandiTax,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                AppLocalizations.of(context)!.mandiTaxProfile,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                            ref
                                        .watch(sharedUtilityProvider)
                                        .isMandiTaxProfileActive() ==
                                    false
                                ? const Icon(Icons.verified, color: Colors.grey)
                                : Icon(
                                    Icons.verified,
                                    color: ColorConstant.maingreen,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        if (ref.watch(authProvider).value ==
                            AuthStatus.loggedIn) {
                          if (ref
                              .watch(sharedUtilityProvider)
                              .isGstProfileActive()) {
                            Get.to(Gstlistingscreen());
                          } else {
                            Get.to(Gstprofilescreen());
                          }
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      child: Padding(
                        padding: Pad(all: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ImageConstant.mandiTax,
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                AppLocalizations.of(context)!.gstProfile,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                            ref
                                        .watch(sharedUtilityProvider)
                                        .isGstProfileActive() ==
                                    false
                                ? const Icon(Icons.verified, color: Colors.grey)
                                : Icon(
                                    Icons.verified,
                                    color: ColorConstant.maingreen,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              if (isLoggedIn) const SizedBox(height: 10),

              if (isLoggedIn)
                ExpansionTile(
                  tilePadding: Pad(left: 10),
                  title: Text(
                    textAlign: TextAlign.start,
                    AppLocalizations.of(context)!.msgTrip,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.sp(16),
                      color: ColorConstant.maingreen,
                    ),
                  ),
                  leading: Icon(
                    Icons.trip_origin_outlined,
                    color: ColorConstant.maingreen,
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        if (ref.watch(authProvider).value ==
                            AuthStatus.loggedIn) {
                          Get.to(
                            Tripidscreen(
                              terminalFrom: TerminalTypeFrom.location,
                              terminalTo: TerminalTypeTo.terminal,
                              title: AppLocalizations.of(context)!.pickUp,
                            ),
                          );
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      child: Padding(
                        padding: Pad(all: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.trip_origin_outlined,
                              color: ColorConstant.maingreen,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                AppLocalizations.of(context)!.pickUp,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        if (ref.watch(authProvider).value ==
                            AuthStatus.loggedIn) {
                          Get.to(
                            Tripidscreen(
                              terminalFrom: TerminalTypeFrom.terminal,
                              terminalTo: TerminalTypeTo.location,
                              title: AppLocalizations.of(context)!.drop,
                            ),
                          );
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      child: Padding(
                        padding: Pad(all: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.trip_origin_outlined,
                              color: ColorConstant.maingreen,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                AppLocalizations.of(context)!.drop,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Get.to(Triprequestscreen());
                      },
                      child: Padding(
                        padding: Pad(all: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.trip_origin_outlined,
                              color: ColorConstant.maingreen,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                AppLocalizations.of(context)!.tripRequests,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ExpansionTile(
                tilePadding: Pad(left: 10),
                title: Text(
                  textAlign: TextAlign.start,
                  AppLocalizations.of(context)!.purchaseOrderTechniqueSystem,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen,
                  ),
                ),
                leading: SvgPicture.asset(
                  ImageConstant.purchaseOrder,
                  height: 20,
                  width: 20,
                ),
                children: [
                  InkWell(
                    onTap: () {
                      if (ref.watch(authProvider).value ==
                          AuthStatus.loggedIn) {
                        Get.to(Purchaseorderscreen());
                      } else {
                        showLoginBottomsheet(context);
                      }
                    },
                    child: Padding(
                      padding: Pad(all: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageConstant.purchaseOrder,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.start,
                              AppLocalizations.of(
                                context,
                              )!
                                  .createPurchaseOrder,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16),
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      if (ref.watch(authProvider).value ==
                          AuthStatus.loggedIn) {
                        Get.to(Purchaseorderslistscreen());
                      } else {
                        showLoginBottomsheet(context);
                      }
                    },
                    child: Padding(
                      padding: Pad(all: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageConstant.purchaseOrder,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.start,
                              AppLocalizations.of(context)!.purchaseOrderList,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16),
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (isLoggedIn) const SizedBox(height: 10),

              if (isLoggedIn)
                InkWell(
                  onTap: () {
                    Get.to(Credit());
                  },
                  child: Padding(
                    padding: Pad(all: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageConstant.imgcredit,
                          width: 20,
                          height: 20,
                          color: ColorConstant.maingreen,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.start,
                            AppLocalizations.of(context)!.bnpl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16),
                              color: ColorConstant.maingreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 10),
              ExpansionTile(
                tilePadding: Pad(left: 10),
                title: Text(
                  textAlign: TextAlign.start,
                  AppLocalizations.of(context)!.sbt,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen,
                  ),
                ),
                leading: Image.asset(
                  ImageConstant.imgmarket,
                  width: 20,
                  height: 20,
                  color: ColorConstant.maingreen,
                ),
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(Sbtorders());
                    },
                    child: Padding(
                      padding: Pad(all: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstant.imgmarket,
                            width: 20,
                            height: 20,
                            color: ColorConstant.maingreen,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.start,
                              AppLocalizations.of(context)!.deals,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16),
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Get.to(Sbtdeals());
                    },
                    child: Padding(
                      padding: Pad(all: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstant.imgmarket,
                            width: 20,
                            height: 20,
                            color: ColorConstant.maingreen,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.start,
                              AppLocalizations.of(context)!.marking,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16),
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              if (isLoggedIn) const SizedBox(height: 10),
              if (isLoggedIn)
                InkWell(
                  onTap: () {
                    Get.to(SbtHoldSummary(walletType: '1'));
                  },
                  child: Padding(
                    padding: Pad(all: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageConstant.imgmarket,
                          width: 20,
                          height: 20,
                          color: ColorConstant.maingreen,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.start,
                            AppLocalizations.of(context)!.holdSummary,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16),
                              color: ColorConstant.maingreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              ExpansionTile(
                tilePadding: Pad(left: 10),
                title: Text(
                  textAlign: TextAlign.start,
                  AppLocalizations.of(context)!.otherTrades,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(16),
                    color: ColorConstant.maingreen,
                  ),
                ),
                leading: Icon(
                  Icons.trip_origin_outlined,
                  color: ColorConstant.maingreen,
                ),
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(OrderList());
                    },
                    child: Padding(
                      padding: Pad(all: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstant.imgorder,
                            width: 20,
                            height: 20,
                            color: ColorConstant.maingreen,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.start,
                              AppLocalizations.of(context)!.msgMyorders,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16),
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Get.to(SpotOrderList());
                    },
                    child: Padding(
                      padding: Pad(all: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstant.imgspotorder,
                            width: 20,
                            height: 20,
                            color: ColorConstant.maingreen,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.start,
                              AppLocalizations.of(context)!.msgSpotorder,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16),
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Get.to(Buysellscreen(type: 0));
                    },
                    child: Padding(
                      padding: Pad(all: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstant.imgmysell,
                            width: 20,
                            height: 20,
                            color: ColorConstant.maingreen,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.start,
                              AppLocalizations.of(context)!.buySell,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16),
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(height: 10),

              InkWell(
                onTap: () {
                  Get.to(Webview(url: "https://apnagodam.com/about-us"));
                },
                child: Padding(
                  padding: Pad(all: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 22,
                        color: ColorConstant.maingreen,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.start,
                          AppLocalizations.of(context)!.aboutUs,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16),
                            color: ColorConstant.maingreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(FeedbackScreen());
                },
                child: Padding(
                  padding: Pad(all: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.rate_review,
                        size: 22,
                        color: ColorConstant.maingreen,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.start,
                          AppLocalizations.of(context)!.feedback,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(16),
                            color: ColorConstant.maingreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isLoggedIn) const SizedBox(height: 10),

              if (isLoggedIn)
                InkWell(
                  onTap: () {
                    Get.to(Accountsettings());
                  },
                  child: Padding(
                    padding: Pad(all: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 22,
                          color: ColorConstant.maingreen,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.start,
                            AppLocalizations.of(context)!.accountSettings,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(16),
                              color: ColorConstant.maingreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  if (ref.watch(authProvider).value == AuthStatus.loggedIn) {
                    ref.watch(authProvider.notifier).logout();
                  } else {
                    showLoginBottomsheet(context);
                  }
                },
                child: Padding(
                  padding: Pad(all: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 22,
                        color: ColorConstant.maingreen,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ref.watch(authProvider).when(
                              data: (data) => Text(
                                textAlign: TextAlign.start,
                                data == AuthStatus.loggedIn
                                    ? AppLocalizations.of(
                                        context,
                                      )!
                                        .msgLogout
                                    : AppLocalizations.of(
                                        context,
                                      )!
                                        .msgLoging,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              error: (e, s) => Container(),
                              loading: () => Container(),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
