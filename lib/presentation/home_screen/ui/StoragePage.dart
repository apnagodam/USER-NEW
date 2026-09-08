import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/dashboard/WarehouseBookings.dart';

import 'package:apnagodam/presentation/home_screen/ui/Findwarehousescreen.dart';
import 'package:apnagodam/presentation/language/language.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_screen.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackinward_screen.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackoutward_screen.dart';

import 'package:apnagodam/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Storagepage extends ConsumerStatefulWidget {
  const Storagepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoragepageState();
}

// tabs are computed per-build to use the current BuildContext

final selectedTabIndex = StateProvider((ref) => 0);

class _StoragepageState extends ConsumerState<Storagepage> {
  List<Map<String, dynamic>> get tabs => [
        {
          "label": AppLocalizations.of(context)!.myStock,
          "index": 0,
          "icon": Icons.inventory
        },
        {
          "label": AppLocalizations.of(context)!.findWarehouses,
          "index": 1,
          "icon": Icons.search
        },
        {
          "label": AppLocalizations.of(context)!.inwards,
          "index": 2,
          "icon": Icons.move_to_inbox
        },
        {
          "label": AppLocalizations.of(context)!.outwards,
          "index": 3,
          "icon": Icons.outbox
        },
        {
          "label": AppLocalizations.of(context)!.qualityConsent,
          "index": 4,
          "icon": Icons.pending_actions
        },
      ];

  Widget _getScreenForTab(int tabIndex, AuthStatus authStatus) {
    if (authStatus == AuthStatus.loggedOut) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/mainlogopng.png',
                height: 150, width: 150),
            simpleButton(
                text: AppLocalizations.of(context)!.loginToContinue,
                callback: () => showLoginBottomsheet(context)),
          ],
        ),
      );
    }

    switch (tabIndex) {
      case 0:
        return MyStockScreen();
      case 1: // Find Warehouses
        return Findwarehousescreen();
      case 2: // Inward Request
        return StackInward();
      case 3: // Outward Request
        return StackOutward();
      case 4: // Quality Consent
        return Warehousebookings(isAppBarVisible: false);
      default:
        return MyStockScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.storage),
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
          if (ref.watch(authProvider).value !=
              AuthStatus.loggedIn)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      style: AppStyle.buttonStyle.copyWith(
                        backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => Colors.white,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(
                              color: ColorConstant.maingreen,
                              width: 1.2,
                            ),
                          ),
                        ),
                      ),
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cross-Platform Navigation Bar (iOS + Android Hybrid)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey[400]!, width: 1),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(tabs.length, (i) {
                    final tab = tabs[i];
                    final isSelected =
                        ref.watch(selectedTabIndex) == tab['index'];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: () {
                            ref.read(selectedTabIndex.notifier).state =
                                tab['index'] as int;
                          },
                          borderRadius: BorderRadius.circular(12),
                          splashColor: ColorConstant.maingreen.withAlpha(1),
                          highlightColor: ColorConstant.maingreen.withAlpha(1),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorConstant.maingreen
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(1),
                                        blurRadius: 12,
                                        offset: Offset(0, 4),
                                      ),
                                      BoxShadow(
                                        color: ColorConstant.maingreen
                                            .withAlpha(3),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  child: Icon(
                                    tab['icon'] as IconData,
                                    size: 20,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[700],
                                  ),
                                ),
                                SizedBox(width: 8),
                                AnimatedDefaultTextStyle(
                                  duration: Duration(milliseconds: 300),
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(13),
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[800],
                                  ),
                                  child: Text(tab['label'] as String),
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
          ),
          ref.watch(authProvider).when(
              data: (data) => Expanded(
                  child: _getScreenForTab(ref.watch(selectedTabIndex), data)),
              error: (e, s) => Container(),
              loading: () => Container())
        ],
      )),
    );
  }
}
