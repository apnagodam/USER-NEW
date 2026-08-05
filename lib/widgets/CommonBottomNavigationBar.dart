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

  static const double iconSize = 22;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHindi = Get.locale?.languageCode == 'hi';

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black.withOpacity(0.5)
                    : ColorConstant.maingreen.withOpacity(0.85),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF12281B), // Deep green-black
                      Color(0xFF275135), // Your main green
                      Color(0xFF3E7251),
                    ]),
                border: const Border(
                  top: BorderSide(
                    color: Colors.white,
                    width: 0.6,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: onTap,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                showUnselectedLabels: true,
                selectedItemColor: Colors.amber,
                unselectedItemColor: Colors.white,
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Adaptive.sp(14),
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: Adaptive.sp(13),
                ),
                items: [
                  // Tab 0: Dashboard (Formerly Home)
                  _rippleItem(
                    isHindi ? 'डैशबोर्ड' : 'Dashboard',
                    CupertinoIcons.square_grid_2x2,
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
                    CupertinoIcons.home,
                    2,
                    ref,
                    context,
                  ),
                  // Tab 3: Wallet
                  _rippleItem(
                    AppLocalizations.of(context)!.wallet,
                    Icons.currency_rupee_outlined,
                    3,
                    ref,
                    context,
                    isImage: false,
                  ),
                  // Tab 4: Invoices / Challan
                  _rippleItem(
                    isHindi ? 'चालान' : 'Invoices',
                    Icons.receipt_long_outlined,
                    4,
                    ref,
                    context,
                  ),
                ],
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
    final color = isSelected ? Colors.amber : Colors.white;

    Widget iconWidget;
    if (isImage) {
      iconWidget = Image.asset(
        icon as String,
        width: iconSize,
        height: iconSize,
        color: color,
      );
    } else {
      iconWidget = Icon(
        icon as IconData,
        size: iconSize,
        color: color,
      );
    }

    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: iconWidget,
      ),
      label: label,
    );
  }
}
