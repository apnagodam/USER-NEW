import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/image_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:apnagodam/presentation/home_screen/ui/TradesbtSummary.dart';
import 'package:apnagodam/presentation/home_screen/ui/Tradewalletscreen.dart';
import 'package:apnagodam/presentation/market_screen/SBT/Sbtscreen.dart';
import 'package:apnagodam/presentation/market_screen/WBT/WbtScreen.dart';
import 'package:apnagodam/presentation/market_screen/ai_assistant/ai_voice_assistant.dart';
import 'package:apnagodam/presentation/mybuy_screen/BuySellScreen.dart';
import 'package:apnagodam/widgets/AppDrawer.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Trade extends ConsumerStatefulWidget {
  const Trade({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TradeState();
}

final tabs = [
  {"label": "SBT", "index": 0, "icon": Icons.analytics_rounded},
  {"label": "WBT", "index": 1, "icon": Icons.warehouse_rounded},
  {"label": "SPOT", "index": 2, "icon": Icons.bolt_rounded},
  {"label": "Face to Face", "index": 3, "icon": Icons.handshake_rounded},
];

var selectedTabIndex = StateProvider((ref) => 0);

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

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AnimatedBuilder(
        animation: _fabPulseCtrl,
        builder: (context, child) {
          final scale = 1.0 + (_fabPulseCtrl.value * 0.12);
          final alpha = (1.0 - _fabPulseCtrl.value) * 0.45;

          return Stack(
            alignment: Alignment.center,
            children: [
              // Outer Glowing Pulsing Ring 1
              Transform.scale(
                scale: scale + 0.1,
                child: Container(
                  width: 146,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.amber.withValues(alpha: alpha * 0.5),
                  ),
                ),
              ),
              // Outer Glowing Pulsing Ring 2
              Transform.scale(
                scale: scale,
                child: Container(
                  width: 138,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorConstant.maingreen.withValues(alpha: alpha),
                  ),
                ),
              ),
              // Main Animated Floating Action Button
              InkWell(
                onTap: () => showAiVoiceAssistant(context, ref),
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF12281B), // Dark forest green
                        Color(0xFF275135), // Primary green
                        Color(0xFF3E7251), // Vibrant green accent
                      ],
                    ),
                    border: Border.all(
                      color: Colors.amber.shade400,
                      width: 1.6,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.maingreen.withValues(alpha: 0.5),
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Bouncing Animated Mic Icon
                      Transform.scale(
                        scale: 1.0 + (_fabPulseCtrl.value * 0.15),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.mic_rounded,
                            color: Color(0xFF12281B),
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isHindi ? 'भाव पूछें' : 'Ask Rates',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
            Text(
              isHindi ?'व्यापार' : 'Trade',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.white,
                letterSpacing: 0.4,
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
          if (ref.watch(authProvider).value !=
              AuthStatus.loggedIn)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: ColorConstant.maingreen,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.amber.shade400, width: 1.2),
                      ),
                    ),
                    onPressed: () {
                      showLoginBottomsheet(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.msgLoging,
                      style: GoogleFonts.poppins(
                        color: ColorConstant.maingreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Premium Category Tab Selector (SBT, WBT, SPOT, Face to Face)
              Container(
                color: Colors.grey.shade50,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(tabs.length, (i) {
                      final tab = tabs[i];
                      final isSelected =
                          ref.watch(selectedTabIndex) == tab['index'];

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      Color(0xFF12281B),
                                      Color(0xFF275135),
                                      Color(0xFF3E7251),
                                    ],
                                  )
                                : null,
                            color: isSelected ? null : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: ColorConstant.maingreen
                                          .withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.04),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                            border: Border.all(
                              color: isSelected
                                  ? Colors.amber.shade400
                                  : Colors.grey.shade300,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              ref.read(selectedTabIndex.notifier).state =
                                  int.parse(tab['index'].toString());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 11),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    tab['icon'] as IconData,
                                    color: isSelected
                                        ? Colors.amber
                                        : ColorConstant.maingreen,
                                    size: 19,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${tab['label']}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

              // Screen View Content
              Expanded(
                child: ref.watch(authProvider).when(
                      data: (data) => ref.watch(selectedTabIndex) == 0
                          ? const Sbtscreen()
                          : ref.watch(selectedTabIndex) == 1
                              ? const Wbtscreen()
                              : ref.watch(selectedTabIndex) == 2
                                  ? Buysellscreen(type: 1)
                                  : ref.watch(selectedTabIndex) == 3
                                      ? Buysellscreen(type: 2)
                                      : ref.watch(selectedTabIndex) == 4
                                          ? const Tradewalletscreen()
                                          : const Tradesbtsummary(
                                              walletType: "2"),
                      error: (e, s) => const SizedBox(),
                      loading: () => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
