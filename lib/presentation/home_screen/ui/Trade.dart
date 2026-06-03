import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/home_screen/ui/TradesbtSummary.dart';
import 'package:apnagodam/presentation/home_screen/ui/Tradewalletscreen.dart';
import 'package:apnagodam/presentation/market_screen/SBT/Sbtscreen.dart';
import 'package:apnagodam/presentation/market_screen/WBT/WbtScreen.dart';
import 'package:apnagodam/presentation/mybuy_screen/BuySellScreen.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Trade extends ConsumerStatefulWidget {
  const Trade({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TradeState();
}

final tabs = [
  {"label": "SBT", "index": 0, "icon": null},
  {"label": "WBT", "index": 1, "icon": null},

  {"label": "SPOT", "index": 2, "icon": null},

  {"label": "Face to Face", "index": 3, "icon": null},

  // {"label": AppLocalizations.of(context)!.wallet, "index": 4, "icon": null},

  // {"label": AppLocalizations.of(context)!.holdSummary, "index": 5, "icon": null}

  // {"label": "Buy Deals".tr, "index": 2, "icon": Icons.receipt_long},
  // {"label": "Sell Deals".tr, "index": 3, "icon": Icons.wallet},
  // {"label": AppLocalizations.of(context)!.deliveryMarking, "index": 4, "icon": Icons.warehouse},
  // {"label": "Invoice Raised by Me".tr, "index": 5, "icon": Icons.warehouse},

  // {"label": "Invoice Raised to Me".tr, "index": 6, "icon": Icons.warehouse},
  // {"label": "F2f Deal".tr, "index": 6, "icon": Icons.warehouse},
  // {
  //   "label": "Structured Trade Finance(STF)".tr,
  //   "index": 7,
  //   "icon": Icons.warehouse
  // },
];
var selectedTabIndex = StateProvider((ref) => 0);

class _TradeState extends ConsumerState<Trade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       border: Border.all(color: ColorConstant.maingreen)),
      //   child: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Text(
      //         'AI Tool',
      //         style: TextStyle(
      //             fontWeight: FontWeight.bold, fontSize: Adaptive.sp(16)),

      //       ),
      //       SizedBox(
      //         width: 10,
      //       ),
      //       Image.network(
      //         'https://marketplace.canva.com/KhGUo/MAFoNRKhGUo/1/tl/canva-ai-chip-technology-icon-MAFoNRKhGUo.png',
      //         color: ColorConstant.maingreen,
      //         height: 24,
      //         width: 24,
      //       )
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.msgTrade),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xFF12281B), // Deep green-black
                Color(0xFF275135), // Your main green
                Color(0xFF3E7251),
              ])),
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.maingreen,
        actions: [
          if (ref.watch(authProvider.notifier).loginStatus !=
              AuthStatus.loggedIn)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      style: AppStyle.loginButtonStyle,
                      onPressed: () {
                        showLoginBottomsheet(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.msgLoging,
                        style: TextStyle(color: ColorConstant.maingreen),
                      )),
                ],
              ),
            ),
          // IconButton(
          //     onPressed: () {
          //       Get.to(LanguageScreen());
          //     },
          //     icon: Icon(Icons.translate))
        ],
      ),
      body: SafeArea(
          child: DefaultTabController(
              length: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(padding: Pad(all: 10),child: titleWidget(text: 'Filter By:-',fontSize: ElevarmFontSizes.md),),
                  Padding(
                    padding: Pad(all: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: List.generate(tabs.length, (i) {
                          final tab = tabs[i];
                          final isSelected =
                              ref.watch(selectedTabIndex) == tab['index'];

                          return AnimatedContainer(
                            duration: Duration(milliseconds: 220),
                            curve: Curves.easeOut,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorConstant.maingreen
                                  : ColorConstant.maingreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    Color(0xFF12281B), // Deep green-black
                                    Color(0xFF275135), // Your main green
                                    Color(0xFF3E7251),
                                  ]),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: ColorConstant.maingreen
                                            .withOpacity(0.18),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ]
                                  : [],
                              border: Border.all(
                                color: isSelected
                                    ? ColorConstant.maingreen
                                    : Colors.grey,
                                width: 1.2,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () {
                                ref.read(selectedTabIndex.notifier).state =
                                    int.parse(tab['index'].toString());
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (tab['icon'] != null)
                                      Icon(
                                        tab['icon'] as IconData,
                                        color: isSelected
                                            ? Colors.white
                                            : ColorConstant.maingreen,
                                        size: 22,
                                      ),
                                    if (tab['icon'] != null) SizedBox(width: 8),
                                    Text(
                                      "${tab['label']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: isSelected
                                            ? Colors.white
                                            : ColorConstant.maingreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  ref.watch(authProvider).when(
                      data: (data) => Expanded(
                          child: ref.watch(selectedTabIndex) == 0
                              ? Sbtscreen()
                              : ref.watch(selectedTabIndex) == 1
                                  ? Wbtscreen()
                                  : ref.watch(selectedTabIndex) == 2
                                      ? Buysellscreen(
                                          type: 1,
                                        )
                                      : ref.watch(selectedTabIndex) == 3
                                          ? Buysellscreen(
                                              type: 2,
                                            )
                                          : ref.watch(selectedTabIndex) == 4
                                              ? Tradewalletscreen()
                                              : Tradesbtsummary(
                                                  walletType: "2",
                                                )),
                      error: (e, s) => Container(),
                      loading: () => Container())
                ],
              ))),
    );
  }
}
