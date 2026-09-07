import 'package:anywhere_loader/provider/anywhere_loader_context_provider.dart';
import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/BusinessProfile/BusinessProfile.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/MandiTaxProfileScreen.dart';
import 'package:apnagodam/presentation/home_screen/Invoices.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/home_screen/ui/HomePage.dart';
import 'package:apnagodam/presentation/home_screen/ui/HomeWallet.dart';
import 'package:apnagodam/presentation/home_screen/ui/StoragePage.dart';
import 'package:apnagodam/presentation/home_screen/ui/Trade.dart';

import 'package:apnagodam/widgets/CommonBottomNavigationBar.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

var selectedIndex = StateProvider((ref) => 2);

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

var listOfScreens = [
  Homepage(),

  Storagepage(),
  Trade(),

  // MyStockScreen(comodityTag: "", commodityid: "", salesStutas: ""),

  HomeWalletScreen(),
  InvoicesScreen()
  // Market(),
  // MyBuy(),
  // MySell(),
];

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent default back behavior
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // If not on home page tab (Tab 2), navigate to home page tab first
        if (ref.watch(selectedIndex) != 2) {
          ref.watch(selectedIndex.notifier).state = 2;
          return;
        }

        // Show exit confirmation dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.exitApp),
              content: Text(AppLocalizations.of(context)!.exitAppConfirm),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(), // Dismiss dialog
                  child: Text(AppLocalizations.of(context)!.msgNo),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss dialog
                    SystemNavigator.pop(); // Exit app
                  },
                  child: Text(AppLocalizations.of(context)!.msgYes),
                ),
              ],
            );
          },
        );
      },
      child: AnyWhereLoaderContextProvider(
          child: Scaffold(
              body: Stack(
                children: [
                  listOfScreens[ref.watch(selectedIndex)],
                ],
              ),
              bottomNavigationBar: CommonBottomNavigationBar(
                  currentIndex: ref.watch(selectedIndex),
                  onTap: (index) {
                    ref.watch(selectedIndex.notifier).state = index;

                    // if (index == 3) {
                    //   ColorConstant.maingreen = Colors.amber;
                    // } else {
                    //   ColorConstant.maingreen = Color(0xff275135);
                    // }
                  }))),
    );
  }
}
