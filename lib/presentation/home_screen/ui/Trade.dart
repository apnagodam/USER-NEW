import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
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
  {"label": "SBT", "index": 0, "icon": Icons.analytics_outlined},
  {"label": "WBT", "index": 1, "icon": Icons.warehouse_outlined},
  {"label": "SPOT", "index": 2, "icon": Icons.bolt_outlined},
  {"label": "Face to Face", "index": 3, "icon": Icons.handshake_outlined},
];

var selectedTabIndex = StateProvider((ref) => 0);

class _TradeState extends ConsumerState<Trade> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isHindi = Get.locale?.languageCode == 'hi';

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAiVoiceAssistant(context, ref),
        backgroundColor: ColorConstant.maingreen,
        icon: const Icon(Icons.mic_rounded, color: Colors.white, size: 24),
        label: Text(
          isHindi ? 'भाव पूछें' : 'Ask Rates',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        elevation: 6,
      ),
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 26),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.eco_rounded, color: Colors.amber, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              isHindi ? 'होम पेज' : 'Home Page',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
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
                Color(0xFF275135), // Your main green
                Color(0xFF3E7251),
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.maingreen,
        actions: [
          if (ref.watch(authProvider.notifier).loginStatus !=
              AuthStatus.loggedIn)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: ElevatedButton(
                  style: AppStyle.loginButtonStyle,
                  onPressed: () {
                    showLoginBottomsheet(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.msgLoging,
                    style: TextStyle(
                      color: ColorConstant.maingreen,
                      fontWeight: FontWeight.bold,
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
              // Category Tab Selector
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(tabs.length, (i) {
                      final tab = tabs[i];
                      final isSelected =
                          ref.watch(selectedTabIndex) == tab['index'];

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
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
                            color: isSelected
                                ? null
                                : ColorConstant.maingreen.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: ColorConstant.maingreen
                                          .withValues(alpha: 0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [],
                            border: Border.all(
                              color: isSelected
                                  ? ColorConstant.maingreen
                                  : Colors.grey.shade300,
                              width: 1.2,
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              ref.read(selectedTabIndex.notifier).state =
                                  int.parse(tab['index'].toString());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    tab['icon'] as IconData,
                                    color: isSelected
                                        ? Colors.amber
                                        : ColorConstant.maingreen,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "${tab['label']}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: isSelected
                                          ? Colors.white
                                          : ColorConstant.maingreen,
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

              const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

              // Screen View
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
