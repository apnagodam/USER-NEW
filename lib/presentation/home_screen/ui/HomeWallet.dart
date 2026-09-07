import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/home_screen/ui/FinanceScreen.dart';
import 'package:apnagodam/presentation/home_screen/ui/Tradewalletscreen.dart';
import 'package:apnagodam/presentation/wallet_tabbar_screen/wallet_screen.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:apnagodam/l10n/app_localizations.dart';

class HomeWalletScreen extends ConsumerStatefulWidget {
  const HomeWalletScreen({super.key});

  @override
  ConsumerState<HomeWalletScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<HomeWalletScreen> {
  // Tab labels use localized getters inside build(context) where a BuildContext is available.
  // This avoids calling AppLocalizations.of(context) outside of a widget lifecycle.

  var selectedTabIndex = StateProvider((ref) => 0);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {
        "label": AppLocalizations.of(context)!.tradewallet,
        "index": 0,
        "icon": Icons.qr_code_2
      },
      {
        "label": AppLocalizations.of(context)!.warehousewallet,
        "index": 1,
        "icon": Icons.warehouse
      },
      {
        "label": AppLocalizations.of(context)!.financewallet,
        "index": 2,
        "icon": Icons.layers
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.wallet),
        backgroundColor: ColorConstant.maingreen,
        centerTitle: true,
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
        actions: [
          if (ref.watch(authProvider).value !=
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
        ],
      ),
      body: Column(
        children: [
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

                  return InkWell(
                    onTap: () {
                      ref.read(selectedTabIndex.notifier).state =
                          int.parse(tab['index'].toString());
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      padding: Pad(left: 12, right: 12, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorConstant.maingreen
                            : ColorConstant.maingreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Color(0xFF12281B), // Deep green-black
                              Color(0xFF275135), // Your main green
                              Color(0xFF3E7251),
                            ]),
                        border: Border.all(
                            color: ColorConstant.maingreen, width: 1.5),
                        boxShadow: isSelected
                            ? [BoxShadow(color: Colors.black12, blurRadius: 4)]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon(
                          //   tab['icon'] as IconData,
                          //   size: 16,
                          //   color: isSelected
                          //       ? Colors.white
                          //       : ColorConstant.maingreen,
                          // ),
                          SizedBox(width: 6),
                          Text(
                            tab['label'] as String,
                            style: TextStyle(
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
          ),
          Expanded(
            // Added Expanded to constrain the ListView
            child: ref.watch(selectedTabIndex) == 0
                ? Tradewalletscreen()
                : ref.watch(selectedTabIndex) == 1
                    ? Wallet()
                    : FinanceScreen(),
          ),
        ],
      ),
    );
  }
}
