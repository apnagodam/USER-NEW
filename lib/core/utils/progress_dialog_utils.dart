import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'image_constant.dart';

class ProgressDialogUtils {
  static Route<void>? _progressRoute;

  ///common method for showing progress dialog
  static void showProgressDialog({isCancellable = true}) {
    if (_progressRoute?.isActive ?? false) return;
    final context = Get.overlayContext ?? Get.context;
    if (context == null) return;

    final route = DialogRoute<void>(
      context: context,
      barrierDismissible: isCancellable,
      builder: (dialogContext) => Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Lottie.asset(
              ImageConstant.imgisloding,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
    _progressRoute = route;
    Navigator.of(context, rootNavigator: true).push(route);
  }

  ///common method for hiding progress dialog
  static void hideProgressDialog() {
    final route = _progressRoute;
    _progressRoute = null;
    if (route == null || !route.isActive) return;
    final context = Get.overlayContext ?? Get.context;
    if (context == null) return;
    Navigator.of(context, rootNavigator: true).removeRoute(route);
  }
}
