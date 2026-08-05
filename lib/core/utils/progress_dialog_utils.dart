import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'image_constant.dart';

class ProgressDialogUtils {
  static bool isProgressDialogOpen = false;

  ///common method for showing progress dialog
  static void showProgressDialog({isCancellable = true}) async {
    if (isProgressDialogOpen) return;
    isProgressDialogOpen = true;
    Get.dialog(
      Center(
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
      barrierDismissible: isCancellable,
    ).then((_) {
      isProgressDialogOpen = false;
    });
  }

  ///common method for hiding progress dialog
  static void hideProgressDialog() {
    if (isProgressDialogOpen) {
      isProgressDialogOpen = false;
      if (Get.isDialogOpen ?? false) {
        Get.back(canPop: false);
      }
    }
  }
}
