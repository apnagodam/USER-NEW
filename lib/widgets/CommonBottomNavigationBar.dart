import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/image_constant.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class CommonBottomNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CommonBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const double unselectedIconSize = 25.0;
  static const double selectedIconSize = 28.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = Get.locale?.languageCode == 'hi';

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.6)
                    : ColorConstant.maingreen.withValues(alpha: 0.9),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFF12281B), // Deep green-black
                    Color(0xFF275135), // Main green
                    Color(0xFF3E7251),
                  ],
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 1.0,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.amber.withValues(alpha: 0.15),
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: onTap,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconSize: selectedIconSize,
                  showUnselectedLabels: true,
                  selectedItemColor: Colors.amber.shade400,
                  unselectedItemColor: Colors.white.withValues(alpha: 0.85),
                  selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Adaptive.sp(15.5),
                    letterSpacing: 0.2,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Adaptive.sp(14),
                  ),
                  items: [
                    // Tab 0: Dashboard (Formerly Home)
                    _rippleItem(
                      isHindi ? 'डैशबोर्ड' : 'Dashboard',
                      CupertinoIcons.square_grid_2x2_fill,
                      0,
                      ref,
                      context,
                    ),
                    // Tab 1: Storage
                    _rippleItem(
                      AppLocalizations.of(context)!.storage,
                      ImageConstant.imgwarehouse,
                      1,
                      ref,
                      context,
                      isImage: true,
                    ),
                    // Tab 2: Home Page (Landing Page - Formerly Trade/Commercial)
                    _rippleItem(
                      isHindi ? 'होम पेज' : 'Home Page',
                      CupertinoIcons.house_fill,
                      2,
                      ref,
                      context,
                    ),
                    // Tab 3: Wallet
                    _rippleItem(
                      AppLocalizations.of(context)!.wallet,
                      Icons.account_balance_wallet_rounded,
                      3,
                      ref,
                      context,
                      isImage: false,
                    ),
                    // Tab 4: Invoices / Challan
                    _rippleItem(
                      isHindi ? 'चालान' : 'Invoices',
                      Icons.receipt_long_rounded,
                      4,
                      ref,
                      context,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _rippleItem(
    String label,
    dynamic icon,
    int index,
    WidgetRef ref,
    BuildContext context, {
    bool isImage = false,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected ? Colors.amber.shade400 : Colors.white;
    final currentIconSize = isSelected ? selectedIconSize : unselectedIconSize;

    Widget iconWidget;
    if (isImage) {
      iconWidget = Image.asset(
        icon as String,
        width: currentIconSize,
        height: currentIconSize,
        color: color,
      );
    } else {
      iconWidget = Icon(
        icon as IconData,
        size: currentIconSize,
        color: color,
      );
    }

    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3, top: 2),
        child: AnimatedScale(
          scale: isSelected ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: iconWidget,
        ),
      ),
      label: label,
    );
  }
}
