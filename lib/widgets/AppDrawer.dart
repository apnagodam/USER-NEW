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
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// 100% Identical Shared Drawer Widget used across Dashboard & Home Page.
/// Features interactive Long-Press functionality on all menus and sub-menus to show feature descriptions!
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  /// Shows an attractive Modal Sheet explaining the menu feature when long-pressed.
  void _showFeatureInfo({
    required BuildContext context,
    required String titleHi,
    required String titleEn,
    required String descHi,
    required String descEn,
    required IconData icon,
    VoidCallback? onOpen,
  }) {
    final isHindi = Get.locale?.languageCode == 'hi';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title Header Row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorConstant.maingreen.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.amber.shade600,
                        width: 1.5,
                      ),
                    ),
                    child: Icon(icon, color: ColorConstant.maingreen, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isHindi ? '💡 सुविधा जानकारी' : '💡 Feature Info',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isHindi ? titleHi : titleEn,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Description Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  isHindi ? descHi : descEn,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isHindi ? 'समझ गए' : 'Got It',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  if (onOpen != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          onOpen();
                        },
                        icon: const Icon(Icons.arrow_forward_rounded,
                            size: 18, color: Colors.white),
                        label: Text(
                          isHindi ? 'खोलें' : 'Open Now',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.maingreen,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn =
        ref.watch(authProvider.notifier).loginStatus == AuthStatus.loggedIn;
    final isHindi = Get.locale?.languageCode == 'hi';

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
              // 1. Profile / Profile Card
              isLoggedIn
                  ? InkWell(
                      onTap: () {
                        Get.to(Profile());
                      },
                      onLongPress: () => _showFeatureInfo(
                        context: context,
                        titleHi: 'आपकी प्रोफाइल (User Profile)',
                        titleEn: 'User Profile Details',
                        descHi:
                            'अपनी व्यक्तिगत जानकारी, मोबाइल नंबर, अवतार फोटो, पावर बैलेंस और केवाईसी सत्यापन स्थिति देखने व प्रबंधित करने के लिए।',
                        descEn:
                            'View and update your personal details, profile picture, registered phone number, power balance, and KYC status.',
                        icon: Icons.person_rounded,
                        onOpen: () => Get.to(Profile()),
                      ),
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

              // 2. Language Selector
              InkWell(
                onTap: () => Get.to(LanguageScreen()),
                onLongPress: () => _showFeatureInfo(
                  context: context,
                  titleHi: 'भाषा चयन (App Language)',
                  titleEn: 'App Language Preference',
                  descHi:
                      'अपनी पसंदीदा भाषा चुनें — हिंदी (Hindi), इंग्लिश (English), या मारवाड़ी (Marwari/Rajasthani) में ऐप चलाएं।',
                  descEn:
                      'Switch your app UI language between Hindi, English, and Marwari/Rajasthani.',
                  icon: Icons.language_rounded,
                  onOpen: () => Get.to(LanguageScreen()),
                ),
                child: actionButton(
                  onTap: () => Get.to(LanguageScreen()),
                  icon: ImageConstant.languagee,
                  label: AppLocalizations.of(context)!.msgLanuage,
                ),
              ),

              const SizedBox(height: 10),

              // 3. Quality Variance Calculator
              InkWell(
                onTap: () {
                  Get.to(Qualitycalculationscreen());
                },
                onLongPress: () => _showFeatureInfo(
                  context: context,
                  titleHi: 'गुणवत्ता जांच कैलकुलेटर (Quality Calculator)',
                  titleEn: 'Quality Variance Calculator',
                  descHi:
                      'अनाज में नमी %, FM, दाना और टिक्की के मान डालकर सटीक गुणवत्ता कटौती मूल्य (QV Price) और अंतिम सौदा भाव निकालें।',
                  descEn:
                      'Enter FM, Moisture %, and grain defect values to calculate precise QV Price and final commodity valuation.',
                  icon: Icons.calculate_outlined,
                  onOpen: () => Get.to(Qualitycalculationscreen()),
                ),
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

              // 4. Warehouse Facility
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
                  onLongPress: () => _showFeatureInfo(
                    context: context,
                    titleHi: 'गोदाम सुविधाएं (Warehouse Facility)',
                    titleEn: 'Warehouse Terminal Services',
                    descHi:
                        'नजदीकी गोदाम टर्मिनल खोजें, खाली चिठ्ठा (Stack) बुक करें और माल जमा (Inward) या निकासी (Outward) रिक्वेस्ट सबमिट करें।',
                    descEn:
                        'Explore nearby warehouse terminals, reserve vacant stacks, and submit stock Inward/Outward requests.',
                    icon: Icons.warehouse_rounded,
                    onOpen: () => Get.to(WarehouseTab()),
                  ),
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

              // 5. Repayment
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
                  onLongPress: () => _showFeatureInfo(
                    context: context,
                    titleHi: 'ऋण भुगतान (Loan Repayment)',
                    titleEn: 'Loan Repayment & EMI',
                    descHi:
                        'अपने कॉमोडिटी लोन व बीएनपीएल (BNPL) क्रेडिट की किश्तों का ऑनलाइन भुगतान करें और बकाया स्थिति देखें।',
                    descEn:
                        'Make online repayments for your commodity loans and track outstanding BNPL credit schedules.',
                    icon: Icons.payments_rounded,
                    onOpen: () => Get.to(RepaymentScreen()),
                  ),
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

              // 6. Profiling Expansion Tile
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
                    // KYC Sub-menu
                    InkWell(
                      onTap: () {
                        if (ref.watch(authProvider).value ==
                            AuthStatus.loggedIn) {
                          Get.to(KYC(isAppbarVisible: true, kyctag: ""));
                        } else {
                          showLoginBottomsheet(context);
                        }
                      },
                      onLongPress: () => _showFeatureInfo(
                        context: context,
                        titleHi: 'केवाईसी सत्यापन (KYC Verification)',
                        titleEn: 'KYC Profile Verification',
                        descHi:
                            'आधार कार्ड, पैन कार्ड और बैंक खाता विवरण सबमिट करके 100% सत्यापित खाता चालू करें।',
                        descEn:
                            'Submit Aadhar, PAN, and Bank details for verified full-access trading privileges.',
                        icon: Icons.verified_user_rounded,
                        onOpen: () => Get.to(KYC(isAppbarVisible: true, kyctag: "")),
                      ),
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

                    // Business Profile Sub-menu
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
                      onLongPress: () => _showFeatureInfo(
                        context: context,
                        titleHi: 'व्यावसायिक प्रोफाइल (Business Profile)',
                        titleEn: 'Business Profile Management',
                        descHi:
                            'अपनी फर्म, व्यापारी संस्था, प्रोपराइटरशिप या कंपनी का रजिस्ट्रेशन विवरण प्रबंधित करें।',
                        descEn:
                            'Register and manage corporate, trader, or proprietorship business entities.',
                        icon: Icons.business_center_rounded,
                        onOpen: () => Get.to(Businessprofile()),
                      ),
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

                    // Mandi Tax Sub-menu
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
                      onLongPress: () => _showFeatureInfo(
                        context: context,
                        titleHi: 'मंडी टैक्स प्रोफाइल (Mandi Tax Exemption)',
                        titleEn: 'Mandi Tax Exemption Profile',
                        descHi:
                            'कृषि मंडी लाइसेंस और मंडी टैक्स छूट के दस्तावेज अपलोड कर टैक्स में नियमानुसार छूट प्राप्त करें।',
                        descEn:
                            'Upload Mandi License & exemption certificates for official Mandi tax waivers.',
                        icon: Icons.receipt_long_rounded,
                        onOpen: () => Get.to(Manditaxprofilescreen(isAppbarVisible: true)),
                      ),
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

                    // GST Profile Sub-menu
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
                      onLongPress: () => _showFeatureInfo(
                        context: context,
                        titleHi: 'जीएसटी प्रोफाइल (GST Profile)',
                        titleEn: 'GSTIN Profile & Invoicing',
                        descHi:
                            'अपना GSTIN नंबर दर्ज करें ताकि व्यापारिक सौदों पर आधिकारिक GST इनवॉइस व इनपुट क्रेडिट प्राप्त हो सके।',
                        descEn:
                            'Manage GSTIN registration for tax invoices and B2B input tax credit benefits.',
                        icon: Icons.assignment_rounded,
                        onOpen: () => Get.to(Gstprofilescreen()),
                      ),
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

              // 7. Trips Expansion Tile
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
                    // Pickup Sub-menu
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
                      onLongPress: () => _showFeatureInfo(
                        context: context,
                        titleHi: 'पिकअप ट्रिप (Logistics Pick Up)',
                        titleEn: 'Farm Pick Up Transport',
                        descHi:
                            'खेत या मंडी से गोदाम टर्मिनल तक माल ले जाने के लिए लॉजिस्टिक्स वाहन बुक करें।',
                        descEn:
                            'Schedule transport pickup to move harvested crops directly into warehouse stacks.',
                        icon: Icons.local_shipping_rounded,
                        onOpen: () => Get.to(Tripidscreen(
                          terminalFrom: TerminalTypeFrom.location,
                          terminalTo: TerminalTypeTo.terminal,
                          title: AppLocalizations.of(context)!.pickUp,
                        )),
                      ),
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

                    // Drop Sub-menu
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
                      onLongPress: () => _showFeatureInfo(
                        context: context,
                        titleHi: 'ड्रॉप ट्रिप (Logistics Drop)',
                        titleEn: 'Destination Drop Transport',
                        descHi:
                            'गोदाम टर्मिनल से खरीदार के स्थान/फैक्ट्री तक माल पहुंचाने के लिए ट्रक ट्रिप सेट करें।',
                        descEn:
                            'Book delivery dispatch trucks from terminal stack to buyer mill or processing unit.',
                        icon: Icons.fire_truck_rounded,
                        onOpen: () => Get.to(Tripidscreen(
                          terminalFrom: TerminalTypeFrom.terminal,
                          terminalTo: TerminalTypeTo.location,
                          title: AppLocalizations.of(context)!.drop,
                        )),
                      ),
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

                    // Trip Requests Sub-menu
                    InkWell(
                      onTap: () {
                        Get.to(Triprequestscreen());
                      },
                      onLongPress: () => _showFeatureInfo(
                        context: context,
                        titleHi: 'ट्रिप अनुरोध सूची (Trip Requests)',
                        titleEn: 'Active Trip Requests Tracker',
                        descHi:
                            'अपने सभी जारी किए गए लॉजिस्टिक्स ट्रिप अनुरोधों की स्थिति लाइव ट्रैक करें।',
                        descEn:
                            'Track real-time progress and driver status of all active transport bookings.',
                        icon: Icons.track_changes_rounded,
                        onOpen: () => Get.to(Triprequestscreen()),
                      ),
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

              // 8. Purchase Order Expansion Tile
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
                  // Create PO
                  InkWell(
                    onTap: () {
                      if (ref.watch(authProvider).value ==
                          AuthStatus.loggedIn) {
                        Get.to(Purchaseorderscreen());
                      } else {
                        showLoginBottomsheet(context);
                      }
                    },
                    onLongPress: () => _showFeatureInfo(
                      context: context,
                      titleHi: 'नया पर्चेज ऑर्डर (Create PO)',
                      titleEn: 'Create Purchase Order',
                      descHi:
                          'थोक में अनाज खरीद के लिए गुणवत्ता मानकों व मात्रा के साथ नया पर्चेज ऑर्डर तैयार करें।',
                      descEn:
                          'Issue new bulk procurement orders specifying grain quality standards and tonnage.',
                      icon: Icons.post_add_rounded,
                      onOpen: () => Get.to(Purchaseorderscreen()),
                    ),
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

                  // PO List
                  InkWell(
                    onTap: () {
                      if (ref.watch(authProvider).value ==
                          AuthStatus.loggedIn) {
                        Get.to(Purchaseorderslistscreen());
                      } else {
                        showLoginBottomsheet(context);
                      }
                    },
                    onLongPress: () => _showFeatureInfo(
                      context: context,
                      titleHi: 'ऑर्डर सूची (Purchase Order List)',
                      titleEn: 'Purchase Order History',
                      descHi:
                          'अपने द्वारा जारी किए गए सभी सक्रिय और पुराने पर्चेज ऑर्डर्स की स्थिति देखें।',
                      descEn:
                          'Monitor status and fulfillment status of all active purchase contracts.',
                      icon: Icons.list_alt_rounded,
                      onOpen: () => Get.to(Purchaseorderslistscreen()),
                    ),
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

              // 9. BNPL Credit
              if (isLoggedIn)
                InkWell(
                  onTap: () {
                    Get.to(Credit());
                  },
                  onLongPress: () => _showFeatureInfo(
                    context: context,
                    titleHi: 'बीएनपीएल / कॉमोडिटी लोन (BNPL Credit)',
                    titleEn: 'BNPL Commodity Credit Line',
                    descHi:
                        'गोदाम में जमा आपकी फसल के आधार पर ₹1.5 करोड़ तक की क्रेडिट लिमिट पाएं बिना फसल बेचे।',
                    descEn:
                        'Access up to ₹1.5 Cr instant liquid credit against your stored commodity value.',
                    icon: Icons.credit_score_rounded,
                    onOpen: () => Get.to(Credit()),
                  ),
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

              // 10. SBT Expansion Tile
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
                  // Bidding Deals Sub-menu
                  InkWell(
                    onTap: () {
                      Get.to(Sbtorders());
                    },
                    onLongPress: () => _showFeatureInfo(
                      context: context,
                      titleHi: 'SBT लाइव सौदे (SBT Bidding Deals)',
                      titleEn: 'Stock Based Trade Bids',
                      descHi:
                          'स्टॉक बेस्ड ट्रेडिंग के लाइव अपर/लोअर सर्किट भाव देखें और अपनी बोली लगाएं।',
                      descEn:
                          'Track stock-backed electronic commodity auctions with live price bands.',
                      icon: Icons.gavel_rounded,
                      onOpen: () => Get.to(Sbtorders()),
                    ),
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

                  // Delivery Marking Sub-menu
                  InkWell(
                    onTap: () {
                      Get.to(Sbtdeals());
                    },
                    onLongPress: () => _showFeatureInfo(
                      context: context,
                      titleHi: 'डिलीवरी चिन्हित करें (Delivery Marking)',
                      titleEn: 'SBT Delivery Allocations',
                      descHi:
                          'मैच हुए सौदों की डिलीवरी तिथि और स्टैक डिस्पैच अलॉटमेंट प्रबंधित करें।',
                      descEn:
                          'Manage stack allocation and dispatch markings for matched trade deals.',
                      icon: Icons.task_alt_rounded,
                      onOpen: () => Get.to(Sbtdeals()),
                    ),
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

              // 11. Hold Summary
              if (isLoggedIn)
                InkWell(
                  onTap: () {
                    Get.to(SbtHoldSummary(walletType: '1'));
                  },
                  onLongPress: () => _showFeatureInfo(
                    context: context,
                    titleHi: 'होल्ड राशि ब्योरा (Hold Money Summary)',
                    titleEn: 'Wallet Hold Amount Summary',
                    descHi:
                        'सक्रिय बोलियों के लिए सुरक्षा मार्जिन के रूप में रोके गए पैसों का ब्योरा देखें।',
                    descEn:
                        'Review active escrow margins and held balance breakdown reserved for open bids.',
                    icon: Icons.account_balance_wallet_rounded,
                    onOpen: () => Get.to(SbtHoldSummary(walletType: '1')),
                  ),
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

              // 12. Other Trades Expansion Tile
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
                  // My Orders Sub-menu
                  InkWell(
                    onTap: () {
                      Get.to(OrderList());
                    },
                    onLongPress: () => _showFeatureInfo(
                      context: context,
                      titleHi: 'मेरे ऑर्डर (My Orders)',
                      titleEn: 'My Trade Orders',
                      descHi:
                          'अपने सभी एक्टिव और पुराने खरीद-बिक्री के ऑर्डर्स की स्थिति देखें।',
                      descEn:
                          'Access historical and current trade execution records.',
                      icon: Icons.shopping_bag_rounded,
                      onOpen: () => Get.to(OrderList()),
                    ),
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

                  // Spot Order Sub-menu
                  InkWell(
                    onTap: () {
                      Get.to(SpotOrderList());
                    },
                    onLongPress: () => _showFeatureInfo(
                      context: context,
                      titleHi: 'स्पॉट ऑर्डर (Spot Trade Orders)',
                      titleEn: 'Immediate Spot Orders',
                      descHi:
                          'स्पॉट मार्केट के तुरंत डिलीवरी और तत्काल भुगतान वाले सौदे देखें।',
                      descEn:
                          'Browse direct spot orders settled for immediate delivery and payout.',
                      icon: Icons.bolt_rounded,
                      onOpen: () => Get.to(SpotOrderList()),
                    ),
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

                  // Buy / Sell Sub-menu
                  InkWell(
                    onTap: () {
                      Get.to(Buysellscreen(type: 0));
                    },
                    onLongPress: () => _showFeatureInfo(
                      context: context,
                      titleHi: 'खरीद / बिक्री (Buy & Sell Market)',
                      titleEn: 'Direct Buy & Sell Platform',
                      descHi:
                          'अनाज खरीदने के लिए सीधी बोली लगाएं या अपनी फसल बिक्री के लिए दर्ज करें।',
                      descEn:
                          'Post direct purchase bids or list harvested crops for sale.',
                      icon: Icons.storefront_rounded,
                      onOpen: () => Get.to(Buysellscreen(type: 0)),
                    ),
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

              // 13. About Us
              InkWell(
                onTap: () {
                  Get.to(Webview(url: "https://apnagodam.com/about-us"));
                },
                onLongPress: () => _showFeatureInfo(
                  context: context,
                  titleHi: 'हमारे बारे में (About Apna Godam)',
                  titleEn: 'About Apna Godam Platform',
                  descHi:
                      'अपना गोदाम डिजिटल एग्री-लॉजिस्टिक्स नेटवर्क, तकनीक और सेवाओं के बारे में अधिक जानें।',
                  descEn:
                      'Discover Apna Godam digital agri-logistics network, tech solutions, and vision.',
                  icon: Icons.info_outline_rounded,
                  onOpen: () => Get.to(Webview(url: "https://apnagodam.com/about-us")),
                ),
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

              // 14. Feedback
              InkWell(
                onTap: () {
                  Get.to(FeedbackScreen());
                },
                onLongPress: () => _showFeatureInfo(
                  context: context,
                  titleHi: 'प्रतिक्रिया व सुझाव (Feedback)',
                  titleEn: 'Send App Feedback',
                  descHi:
                      'ऐप के अनुभव पर अपना सुझाव या किसी समस्या की शिकायत सीधे हमारी टीम को भेजें।',
                  descEn:
                      'Submit feature requests, user feedback, or report technical issues directly.',
                  icon: Icons.rate_review_rounded,
                  onOpen: () => Get.to(FeedbackScreen()),
                ),
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

              // 15. Account Settings
              if (isLoggedIn)
                InkWell(
                  onTap: () {
                    Get.to(Accountsettings());
                  },
                  onLongPress: () => _showFeatureInfo(
                    context: context,
                    titleHi: 'खाता सेटिंग्स (Account Settings)',
                    titleEn: 'Account Security Settings',
                    descHi:
                        'सुरक्षा सेटिंग्स, पासवर्ड, नोटिफिकेशन और बैंक खाता प्राथमिकताएं प्रबंधित करें।',
                    descEn:
                        'Manage security preferences, password change, notifications, and linked accounts.',
                    icon: Icons.settings_rounded,
                    onOpen: () => Get.to(Accountsettings()),
                  ),
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

              // 16. Logout / Login
              InkWell(
                onTap: () async {
                  if (ref.watch(authProvider).value == AuthStatus.loggedIn) {
                    ref.watch(authProvider.notifier).logout();
                  } else {
                    showLoginBottomsheet(context);
                  }
                },
                onLongPress: () => _showFeatureInfo(
                  context: context,
                  titleHi: isLoggedIn ? 'लॉगआउट (Logout)' : 'लॉगिन (Login)',
                  titleEn: isLoggedIn ? 'Account Logout' : 'Account Login',
                  descHi: isLoggedIn
                      ? 'अपने खाते को इस डिवाइस से सुरक्षित रूप से लॉगआउट करने के लिए।'
                      : 'अपने मोबाइल नंबर के साथ नए सेशन में लॉगिन करने के लिए।',
                  descEn: isLoggedIn
                      ? 'Safely terminate your active session on this device.'
                      : 'Log in using your registered mobile phone number.',
                  icon: Icons.logout_rounded,
                ),
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
