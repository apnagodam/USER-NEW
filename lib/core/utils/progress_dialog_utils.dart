import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'image_constant.dart';

class ProgressDialogUtils {
  ///common method for showing progress dialog
  static void showProgressDialog({isCancellable = true}) async {
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
    );
  }

  ///common method for hiding progress dialog
  static void hideProgressDialog() {
    Get.back(canPop: false);
  }
}
