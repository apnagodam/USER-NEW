import 'dart:ui';
import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/providers/ThemeController.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / 5;
    // Removed broken contextColors assignment
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
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF12281B), // Deep green-black
                      Color(0xFF275135), // Your main green
                      Color(0xFF3E7251),
                    ]),
                border: Border(
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
                  _rippleItem(
                    AppLocalizations.of(context)!.msgHome,
                    CupertinoIcons.home,
                    0,
                    ref,
                    context,
                  ),
                  _rippleItem(AppLocalizations.of(context)!.storage,
                      ImageConstant.imgwarehouse, 1, ref, context,
                      isImage: true),
                  _rippleItem(AppLocalizations.of(context)!.msgTrade,
                      ImageConstant.imgmarket, 2, ref, context,
                      isImage: true),
                  _rippleItem(AppLocalizations.of(context)!.wallet,
                      Icons.currency_rupee_outlined, 3, ref, context,
                      isImage: false),
                  _rippleItem(AppLocalizations.of(context)!.msgInvoices,
                      Icons.receipt_long_outlined, 4, ref, context,
                      isImage: false),
                ],
              ),
            ),
          ),
        ),
        // 🔸 Underline indicator (optional, commented out)
        // Positioned(
        //   bottom: 25,
        //   left: tabWidth * currentIndex + tabWidth / 2 - 10,
        //   child: AnimatedContainer(
        //     duration: const Duration(milliseconds: 280),
        //     curve: Curves.easeOut,
        //     width: 24,
        //     height: 3.5,
        //     decoration: BoxDecoration(
        //       color: Colors.amber,
        //       borderRadius: BorderRadius.circular(6),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.amber.withOpacity(0.4),
        //           blurRadius: 6,
        //           spreadRadius: 0.5,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  BottomNavigationBarItem _rippleItem(String label, dynamic icon, int index,
      WidgetRef ref, BuildContext context,
      {bool isImage = false}) {
    final isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      icon: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: () {
            var loggedInProvider =
                ref.watch(authProvider).value ?? AuthStatus.loggedOut;
            ref.watch(tabIndexProvider.notifier).state = index;
            onTap(index);
          },
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1.0, end: isSelected ? 1.25 : 1.0),
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: isImage
                      ? Image.asset(
                          icon,
                          width: Adaptive.sp(iconSize),
                          fit: BoxFit.fill,
                          color: isSelected && index == 5
                              ? ColorConstant.maingreen
                              : isSelected
                                  ? Colors.amber
                                  : Colors.white,
                        )
                      : Icon(
                          icon,
                          size: Adaptive.sp(iconSize),
                          color: isSelected
                              ? Colors.amber
                              : isSelected && index == 5
                                  ? ColorConstant.maingreen
                                  : Colors.white,
                        ),
                );
              },
            ),
          ),
        ),
      ),
      label: label,
    );
  }
}
