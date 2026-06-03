import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/providers/app_language_provider.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/helper.dart';
import 'package:apnagodam/core/utils/progress_dialog_utils.dart';
import 'package:dio/dio.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as getx;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../core/utils/color_constant.dart';

class Diointerceptor extends InterceptorsWrapper {
  Diointerceptor(this.ref);

  final ProviderRef ref;
  final Stopwatch stopWatch = Stopwatch();

  // Loader reference counter
  static int _loaderCount = 0;

  void _safeStopAllLoaders() {
    try {
      if (getx.Get.isDialogOpen ?? false) {
        ProgressDialogUtils.hideProgressDialog();
      }
    } catch (_) {}
  }

  void _decrementLoader() {
    _loaderCount = (_loaderCount - 1).clamp(0, double.infinity).toInt();
    if (_loaderCount == 0) {
      _safeStopAllLoaders();
    }
  }

  void _showProfileErrorDialog(String message) async {
    _safeStopAllLoaders();


    getx.Get.defaultDialog(
      title: "Error",
      radius: 8,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Adaptive.sp(17),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevarmPrimaryButton.text(
                  text: 'OK',
                  buttonThemeData: ElevarmPrimaryButtonThemeData(
                    primaryColor: Colors.red.shade700,
                  ),
                  onPressed: () {
                    getx.Get.back();
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ElevarmPrimaryButton.text(
                  text: 'Contact IVR',
                  buttonThemeData: ElevarmPrimaryButtonThemeData(
                    primaryColor: ColorConstant.maingreen,
                  ),
                  onPressed: () => CallLaunch('tel:+917733901154'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    stopWatch.reset();
    stopWatch.start();
    final langCode = ref.watch(appLanguageProvider);
    options.headers = {
      'Authorization':
          ref.watch(sharedPreferencesProvider).getString('token') ?? "",
      'lang': langCode,
      'lat': ref.watch(sharedUtilityProvider).getPosition().latitude,
      'long': ref.watch(sharedUtilityProvider).getPosition().longitude,
    };

    // Increment loader count
  if (!options.path.contains('user_api/sbt-contract-note-list') &&
    !options.path.contains('user_api/apna_u_sell_buy_list') &&
    !options.path.contains('user_api/apna_u_stack_buy_sell_list') &&
    !options.path.contains('user_api/mark-delivery') &&
    !options.path.contains('user_api/match-order-list')) {
  _loaderCount++;
  if (_loaderCount == 1) {
    if (options.method.toLowerCase() == 'post') {
      ProgressDialogUtils.showProgressDialog();
    }
  }
}

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    stopWatch.stop();
    _decrementLoader();

    final data = response.data;
    final status = data['status'].toString();

    if (status == '3' ||
        data['message'].toString().toLowerCase().contains('user not found')) {
      ref.watch(authProvider.notifier).logout();
    }
    if (!ref.watch(sharedUtilityProvider).isBusinessProfileActive()) {
    } else if (!ref.watch(sharedUtilityProvider).isBusinessProfileActive()) {}
   if (status == '0') {
  if (data['message'].toString() != "OTP Expired !" &&
      !response.requestOptions.path.contains('get_user_profile') &&
      !response.requestOptions.path.contains('get_user_gst_profile') &&
      !response.requestOptions.path.contains('get_user_mandi_tax_profile')) {
    _showProfileErrorDialog(
      data['message'] ?? data['Message'] ?? "Unknown error",
    );
  }
}

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    stopWatch.stop();
    _decrementLoader();

    final errorMessage = err.message ?? "Something went wrong.";

    if (!(err.type == DioExceptionType.badResponse &&
        err.requestOptions.path.contains('apna_u_user_details'))) {
      Fluttertoast.showToast(msg: errorMessage, toastLength: Toast.LENGTH_LONG);
    }

    handler.next(err);
  }
}
