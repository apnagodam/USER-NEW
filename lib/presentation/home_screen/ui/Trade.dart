import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/image_constant.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/presentation/dashboard/model/sbt_commodity_model.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/gpt_assistant/ui/gpt_voice_assistant.dart';
import 'package:apnagodam/presentation/market_screen/SBT/Sbtscreen.dart';
import 'package:apnagodam/presentation/market_screen/WBT/WbtScreen.dart';
import 'package:apnagodam/presentation/notice/ui/notice_screen.dart';
import 'package:apnagodam/widgets/AppDrawer.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ── [COMMENTED OUT PREVIOUS TABS & NAVIGATION FOR ROLLBACK] ──
/*
import 'package:apnagodam/presentation/home_screen/ui/TradesbtSummary.dart';
import 'package:apnagodam/presentation/home_screen/ui/Tradewalletscreen.dart';
import 'package:apnagodam/presentation/mybuy_screen/BuySellScreen.dart';

final tabs = [
  {"label": "SBT", "index": 0, "icon": Icons.analytics_rounded},
  {"label": "WBT", "index": 1, "icon": Icons.warehouse_rounded},
  {"label": "SPOT", "index": 2, "icon": Icons.bolt_rounded},
  {"label": "Face to Face", "index": 3, "icon": Icons.handshake_rounded},
];

var selectedTabIndex = StateProvider((ref) => 0);
*/

/// New Trade Dashboard State Providers
/// 0 = Delivery, 1 = Truck Load, 2 = Stock Transfer
final selectedTradeTabProvider = StateProvider<int>((ref) => 0);
final selectedCommodityFilterProvider = StateProvider<String>((ref) => 'All');
final selectedLocationFilterProvider = StateProvider<String>((ref) => 'All');

class Trade extends ConsumerStatefulWidget {
  const Trade({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TradeState();
}

class _TradeState extends ConsumerState<Trade> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _fabPulseCtrl;

  @override
  void initState() {
    super.initState();
    _fabPulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _fabPulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = Get.locale?.languageCode == 'hi';
    final currentTab = ref.watch(selectedTradeTabProvider);
    final selectedCommodity = ref.watch(selectedCommodityFilterProvider);
    final selectedLocation = ref.watch(selectedLocationFilterProvider);
    final sbtAsync = ref.watch(getSbtCommodityProvider);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: AnimatedBuilder(
      //   animation: _fabPulseCtrl,
      //   builder: (context, child) {
      //     final scale = 1.0 + (_fabPulseCtrl.value * 0.12);
      //     final alpha = (1.0 - _fabPulseCtrl.value) * 0.45;
      //
      //     return Stack(
      //       alignment: Alignment.center,
      //       children: [
      //         // Outer Glowing Pulsing Ring 1
      //         Transform.scale(
      //           scale: scale + 0.1,
      //           child: Container(
      //             width: 146,
      //             height: 52,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(30),
      //               color: Colors.amber.withValues(alpha: alpha * 0.5),
      //             ),
      //           ),
      //         ),
      //         // Outer Glowing Pulsing Ring 2
      //         Transform.scale(
      //           scale: scale,
      //           child: Container(
      //             width: 138,
      //             height: 48,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(30),
      //               color: ColorConstant.maingreen.withValues(alpha: alpha),
      //             ),
      //           ),
      //         ),
      //         // Main Animated Floating Action Button
      //         InkWell(
      //           onTap: () => showGptVoiceAssistant(context),
      //           borderRadius: BorderRadius.circular(28),
      //           child: Container(
      //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(28),
      //               gradient: const LinearGradient(
      //                 begin: Alignment.topLeft,
      //                 end: Alignment.bottomRight,
      //                 colors: [
      //                   Color(0xFF12281B), // Dark forest green
      //                   Color(0xFF275135), // Primary green
      //                   Color(0xFF3E7251), // Vibrant green accent
      //                 ],
      //               ),
      //               border: Border.all(
      //                 color: Colors.amber.shade400,
      //                 width: 1.6,
      //               ),
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: ColorConstant.maingreen.withValues(alpha: 0.5),
      //                   blurRadius: 12,
      //                   spreadRadius: 1,
      //                   offset: const Offset(0, 4),
      //                 ),
      //               ],
      //             ),
      //             child: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 // Bouncing Animated Mic Icon
      //                 Transform.scale(
      //                   scale: 1.0 + (_fabPulseCtrl.value * 0.15),
      //                   child: Container(
      //                     padding: const EdgeInsets.all(5),
      //                     decoration: const BoxDecoration(
      //                       color: Colors.amber,
      //                       shape: BoxShape.circle,
      //                     ),
      //                     child: const Icon(
      //                       Icons.mic_rounded,
      //                       color: Color(0xFF12281B),
      //                       size: 18,
      //                     ),
      //                   ),
      //                 ),
      //                 const SizedBox(width: 10),
      //                 Text(
      //                   isHindi ? 'AG Assistant से पूछें' : 'AG Assistant',
      //                   style: GoogleFonts.poppins(
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 14,
      //                     letterSpacing: 0.3,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // ),
      appBar: AppBar(

        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // White Pill Container for Apna Godam Logo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
               shape: BoxShape.circle,
                border: Border.all(color: Colors.amber.shade300, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(
                ImageConstant.mainlogopng,
                height: 22,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/images/mainlogopng.png',
                  height: 22,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Center(
              child: Text(
                isHindi ?'व्यापार' : 'Trade',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF12281B), // Deep green-black
                Color(0xFF275135), // Main green
                Color(0xFF3E7251), // Light green accent
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.maingreen,
        actions: [
          Builder(
            builder: (context) {
              final authState = ref.watch(authProvider);
              final token = ref.watch(sharedPreferencesProvider).getString('token');
              final isLoggedIn = authState.valueOrNull == AuthStatus.loggedIn &&
                  (token != null && token.isNotEmpty);

              if (isLoggedIn) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const NoticeScreen());
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.campaign_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              isHindi ? 'सूचना' : 'Notice',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              // Logged out: Always show Login Button prominently
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorConstant.maingreen,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        minimumSize: const Size(0, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.amber.shade400, width: 1.4),
                        ),
                      ),
                      onPressed: () {
                        showLoginBottomsheet(context);
                      },
                      icon: const Icon(
                        Icons.login_rounded,
                        size: 17,
                        color: Color(0xFF1B4D2E),
                      ),
                      label: Text(
                        AppLocalizations.of(context)!.msgLoging,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF1B4D2E),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: NestedScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── 1. Top Mode Selector Tabs (Delivery, Truck Load, Stock Transfer) ──
                    _buildTopModeTabs(isHindi, currentTab),

                    // ── 2. Filters (Commodity & Location Dropdowns in 1 Row) ──
                    if (currentTab == 0 || currentTab == 1) ...[
                      _buildDropdownFiltersRow(
                        isHindi: isHindi,
                        selectedCommodity: selectedCommodity,
                        selectedLocation: selectedLocation,
                        sbtData: sbtAsync.value?.data ?? [],
                        filterType: currentTab,
                      ),
                    ],

                    const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                  ],
                ),
              ),
            ];
          },
          body: Builder(
            builder: (context) {
              switch (currentTab) {
                case 0:
                  // Delivery Mode
                  return Sbtscreen(
                    filterType: 0,
                    selectedCommodity: selectedCommodity,
                    selectedLocation: selectedLocation,
                    showTopTradingTabs: false,
                  );
                case 1:
                  // Truck Load Mode
                  return Sbtscreen(
                    filterType: 1,
                    selectedCommodity: selectedCommodity,
                    selectedLocation: selectedLocation,
                    showTopTradingTabs: false,
                  );
                case 2:
                  // Stock Transfer Mode (Stackwise & Gatepass wise)
                  return const Wbtscreen(isAppbarVisible: false);
                default:
                  return Sbtscreen(
                    filterType: 0,
                    selectedCommodity: selectedCommodity,
                    selectedLocation: selectedLocation,
                    showTopTradingTabs: false,
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  // ── 1. Top Mode Selector Tabs ──
  Widget _buildTopModeTabs(bool isHindi, int currentTab) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            // Delivery Tab
            _buildModeTabButton(
              index: 0,
              label: isHindi ? 'डिलीवरी' : 'Delivery',
              icon: Icons.local_shipping_rounded,
              isSelected: currentTab == 0,
            ),
            const SizedBox(width: 8),

            // Truck Load Tab
            _buildModeTabButton(
              index: 1,
              label: isHindi ? 'ट्रक लोड' : 'Truck Load',
              icon: Icons.local_shipping_outlined,
              isSelected: currentTab == 1,
            ),
            const SizedBox(width: 8),

            // Stock Transfer Tab
            _buildModeTabButton(
              index: 2,
              label: isHindi ? 'स्टॉक ट्रांसफर' : 'Stock Transfer',
              icon: Icons.swap_horiz_rounded,
              isSelected: currentTab == 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeTabButton({
    required int index,
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        ref.read(selectedTradeTabProvider.notifier).state = index;
      },
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1B4D2E) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.amber.shade400 : const Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1B4D2E).withValues(alpha: 0.25),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 19,
              color: isSelected ? const Color(0xFFFFD54F) : const Color(0xFF275135),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              maxLines: 1,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── 2. Unified Dropdown Filters Row (Commodity & Location side-by-side in 1 Row) ──
  Widget _buildDropdownFiltersRow({
    required bool isHindi,
    required String selectedCommodity,
    required String selectedLocation,
    required List<SbtDatum> sbtData,
    required int filterType,
  }) {
    // 1. Extract distinct commodities from live data for current mode
    final Set<String> allCommodities = {};
    for (final item in sbtData) {
      if (filterType == 0 && !item.isDelivery) continue;
      if (filterType == 1 && !item.isTruckLoad) continue;

      final comm = (item.commodity ?? '').toString().trim();
      if (comm.isNotEmpty && comm.toLowerCase() != 'null') {
        allCommodities.add(comm);
      }
    }
    final List<String> commodityList = ['All', ...allCommodities];

    // 2. Extract distinct locations from live data for current mode
    final locations = _extractLocations(sbtData, filterType);
    final List<String> locationList = ['All', ...locations];

    final currentComm = commodityList.contains(selectedCommodity) ? selectedCommodity : 'All';
    final currentLoc = locationList.contains(selectedLocation) ? selectedLocation : 'All';

    final isCommActive = currentComm != 'All';
    final isLocActive = currentLoc != 'All';

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          // ── Commodity Dropdown (Left) ──
          Expanded(
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isCommActive ? const Color(0xFFE8F5E9) : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCommActive ? const Color(0xFF1B4D2E) : const Color(0xFFD1D5DB),
                  width: isCommActive ? 1.5 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.eco_rounded,
                    size: 19,
                    color: isCommActive ? const Color(0xFF1B4D2E) : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: currentComm,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 21,
                          color: isCommActive ? const Color(0xFF1B4D2E) : Colors.grey.shade700,
                        ),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: isCommActive ? const Color(0xFF1B4D2E) : Colors.grey.shade800,
                        ),
                        items: commodityList.map((String item) {
                          final displayName = (item == 'All')
                              ? (isHindi ? 'सभी कमोडिटी' : 'All Commodities')
                              : item;
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            ref.read(selectedCommodityFilterProvider.notifier).state = newValue;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ── Location Dropdown (Right) ──
          Expanded(
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isLocActive ? const Color(0xFFE8F5E9) : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isLocActive ? const Color(0xFF1B4D2E) : const Color(0xFFD1D5DB),
                  width: isLocActive ? 1.5 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 19,
                    color: isLocActive ? const Color(0xFF1B4D2E) : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: currentLoc,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 21,
                          color: isLocActive ? const Color(0xFF1B4D2E) : Colors.grey.shade700,
                        ),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: isLocActive ? const Color(0xFF1B4D2E) : Colors.grey.shade800,
                        ),
                        items: locationList.map((String item) {
                          final displayName = (item == 'All')
                              ? (isHindi ? 'सभी स्थान' : 'All Locations')
                              : item;
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            ref.read(selectedLocationFilterProvider.notifier).state = newValue;
                          }
                        },
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

  List<String> _extractLocations(List<SbtDatum> items, int filterType) {
    final Set<String> locations = {};

    for (final item in items) {
      if (filterType == 0 && !item.isDelivery) continue;
      if (filterType == 1 && !item.isTruckLoad) continue;

      // 1. If districtName is returned from API, use it directly
      final distName = (item.districtName ?? '').toString().trim();
      if (distName.isNotEmpty && distName.toLowerCase() != 'null') {
        locations.add(distName);
        continue;
      }

      // 2. Extract city/district from district text if districtName is not set
      final district = (item.district ?? '').toString().trim();
      if (district.isNotEmpty && district.toLowerCase() != 'null') {
        final lower = district.toLowerCase();
        if (lower.contains('jaipur') || lower.contains('जयपुर')) {
          locations.add('Jaipur');
        } else if (lower.contains('madhepura') || lower.contains('मधेपुरा')) {
          locations.add('Madhepura');
        } else if (lower.contains('bhagalpur') || lower.contains('भागलपुर')) {
          locations.add('Bhagalpur');
        } else if (lower.contains('neemuch') || lower.contains('नीमच')) {
          locations.add('Neemuch');
        } else if (lower.contains('indore') || lower.contains('इंदौर')) {
          locations.add('Indore');
        } else if (lower.contains('raj nandgaon') || lower.contains('rajnandgaon')) {
          locations.add('Raj Nandgaon');
        } else if (lower.contains('bikaner') || lower.contains('बीकानेर')) {
          locations.add('Bikaner');
        } else if (lower.contains('sikar') || lower.contains('सीकर')) {
          locations.add('Sikar');
        } else if (lower.contains('chomu') || lower.contains('morija')) {
          locations.add('Chomu');
        } else {
          final parts = district.split(',');
          if (parts.length >= 2) {
            final possibleCity = parts[parts.length - 2].trim();
            if (possibleCity.isNotEmpty && possibleCity.length < 25) {
              locations.add(possibleCity);
              continue;
            }
          }
          locations.add(district);
        }
      }
    }

    return locations.toList();
  }
}
