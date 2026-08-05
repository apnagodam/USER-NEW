import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
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
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/home_screen/ui/QualityCalculationScreen.dart';
import 'package:apnagodam/presentation/kyc.dart';
import 'package:apnagodam/presentation/language/language.dart';
import 'package:apnagodam/presentation/profile_screen/profile_screen.dart';
import 'package:apnagodam/presentation/repayment_screen/repayment_screen.dart';
import 'package:apnagodam/presentation/singup_screen/termandcon_webview.dart';
import 'package:apnagodam/presentation/wallet_tabbar_screen/wallet_screen.dart';
import 'package:apnagodam/presentation/warehouse_Tab/warehouse_tabbar.dart';
import 'package:apnagodam/widgets/enums.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
            top: MediaQuery.of(context).padding.top + 10,
          ),
          child: ListView(
            children: [
              if (isLoggedIn)
                InkWell(
                  onTap: () => Get.to(Profile()),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              user?.phone ?? '',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: Adaptive.sp(15),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${AppLocalizations.of(context)!.walletBalance}: \u{20B9}${user?.power ?? 0}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: Adaptive.sp(15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: actionButton(
                                          onTap: () => Get.to(
                                            Wallet(isAppBarVisible: true),
                                          ),
                                          icon: ImageConstant.wallet,
                                          label: AppLocalizations.of(context)!
                                              .wallet,
                                        ),
                                      ),
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
              else
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/mainlogopng.png',
                        height: 120,
                        width: 120,
                      ),
                      const SizedBox(height: 8),
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
                onTap: () => Get.to(Qualitycalculationscreen()),
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
                          AppLocalizations.of(context)!
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

              if (isLoggedIn) ...[
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => Get.to(WarehouseTab()),
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
                            AppLocalizations.of(context)!.msgWarehousefacility,
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
                  onTap: () => Get.to(RepaymentScreen()),
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
              ],

              // Terms & Conditions
              const SizedBox(height: 10),
              InkWell(
                onTap: () => Get.to(TermandconWebview(
                  url: 'https://swlpl.com/term-conditions.html',
                )),
                child: Padding(
                  padding: Pad(all: 10),
                  child: Row(
                    children: [
                      Icon(Icons.description_outlined,
                          color: ColorConstant.maingreen),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.termCondition,
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

              // Feedback
              const SizedBox(height: 10),
              InkWell(
                onTap: () => Get.to(Feedbackscreen()),
                child: Padding(
                  padding: Pad(all: 10),
                  child: Row(
                    children: [
                      Icon(Icons.feedback_outlined,
                          color: ColorConstant.maingreen),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.msgFeedback,
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

              // Logout if logged in
              if (isLoggedIn) ...[
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: Text(
                    AppLocalizations.of(context)!.logout,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    ref.watch(authProvider.notifier).logout();
                    Get.back();
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
