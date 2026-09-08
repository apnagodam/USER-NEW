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
      ProgressDialogUtils.hideProgressDialog();
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
    showErrorAlertDialog(getx.Get.context, message);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    stopWatch.reset();
    stopWatch.start();
    final langCode = ref.read(appLanguageProvider);
    final token = ref.read(sharedPreferencesProvider).getString('token');
    final position = ref.read(sharedUtilityProvider).getPosition();
    options.headers = {
      if (token != null && token.trim().isNotEmpty) 'Authorization': token,
      'lang': langCode,
      'lat': position.latitude,
      'long': position.longitude,
    };

    // Increment loader count only for POST requests that need it
    final isPost = options.method.toLowerCase() == 'post';
    final isExcluded = options.path.contains('user_api/sbt-contract-note-list') ||
        options.path.contains('user_api/apna_u_sell_buy_list') ||
        options.path.contains('user_api/apna_u_stack_buy_sell_list') ||
        options.path.contains('user_api/user_terminal_list') ||
        options.path.contains('user_api/user_commodity_list') ||
        options.path.contains('user_api/user_stack_list') ||
        options.path.contains('user_api/user_stack_settlement_list') ||
        options.path.contains('user_api/default_get_stack_want_to_sell_list') ||
        options.path.contains('user_api/get_stack_want_to_sell_list') ||
        options.path.contains('user_api/user_stack_want_to_sell_list') ||
        options.path.contains('user_api/user_sbt_terms') ||
        options.path.contains('user_api/get_stack_sell_terms') ||
        options.path.contains('user_api/get_broker_buyer_list') ||
        options.path.contains('user_api/get_rise_by_me_invoice') ||
        options.path.contains('user_api/get_clpl_pdf_data') ||
        options.path.contains('user_api/get_address_from_pincode') ||
        options.path.contains('user_api/get_') ||
        options.path.contains('user_api/mark-delivery') ||
        options.path.contains('user_api/match-order-list') ||
        options.path.contains('user_api/new-taja-bhav') ||
        options.path.contains('new-taja-bhav') ||
        options.path.contains('check_user') ||
        options.path.contains('user_register') ||
        options.path.contains('user_send_otp') ||
        options.path.contains('user_verify_otp') ||
        options.path.contains('buyer_stack_want_to_buy') ||
        options.path.contains('seller_stack_sell_price_update') ||
        options.path.contains('seller_stack_sell_price_delete') ||
        options.path.contains('apna_u_loan_request') ||
        options.path.contains('sbt_trade_save') ||
        options.path.contains('check_user_wallet') ||
        options.path.contains('v1_apna_send_otp') ||
        options.path.contains('send_otp') ||
        options.path.contains('v1_apna_verify_otp') ||
        options.path.contains('verify_otp') ||
        options.path.contains('sbt_api');

    if (isPost && !isExcluded) {
      options.extra['show_loader'] = true;
      _loaderCount++;
      if (_loaderCount == 1) {
        ProgressDialogUtils.showProgressDialog();
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    stopWatch.stop();
    if (response.requestOptions.extra['show_loader'] == true) {
      _decrementLoader();
    }

    final data = response.data;
    final status = data is Map ? data['status']?.toString() : null;

    if (status == '3') {
      final isLogoutRequest =
          response.requestOptions.path.contains('apna_user_logout') ||
          response.requestOptions.path.contains('user_logout');
      final isAuthLoggedIn =
          ref.read(authProvider).value == AuthStatus.loggedIn;
      if (isAuthLoggedIn && !isLogoutRequest) {
        ref.read(authProvider.notifier).logout(showToast: false);
      }
    }
   if (status == '0') {
  final msg = data is Map ? (data['message']?.toString() ?? data['Message']?.toString() ?? "") : "";
  if (msg != "OTP Expired !" &&
      !msg.toLowerCase().contains("user not found") &&
      !msg.toLowerCase().contains("no user found") &&
      !response.requestOptions.path.contains('get_user_profile') &&
      !response.requestOptions.path.contains('get_user_gst_profile') &&
      !response.requestOptions.path.contains('get_user_mandi_tax_profile') &&
      !response.requestOptions.path.contains('sbt_trade_save') &&
      !response.requestOptions.path.contains('check_user_wallet') &&
      !response.requestOptions.path.contains('sbt_api') &&
      !response.requestOptions.path.contains('apna_u_bid_by_buyer') &&
      !response.requestOptions.path.contains('wbt_update_sell_price') &&
      !response.requestOptions.path.contains('v1_apna_send_otp') &&
      !response.requestOptions.path.contains('send_otp') &&
      !response.requestOptions.path.contains('check_user') &&
      !response.requestOptions.path.contains('user_register') &&
      !response.requestOptions.path.contains('user_send_otp') &&
      !response.requestOptions.path.contains('user_verify_otp') &&
      !response.requestOptions.path.contains('verify_otp') &&
      !response.requestOptions.path.contains('new-taja-bhav')) {
    _showProfileErrorDialog(
      msg.isNotEmpty ? msg : "Unknown error",
    );
  }
}

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    stopWatch.stop();
    if (err.requestOptions.extra['show_loader'] == true) {
      _decrementLoader();
    }

    String errorMessage = "Something went wrong. Please try again.";
    if (err.response?.data is Map &&
        (err.response?.data['message'] != null ||
            err.response?.data['Message'] != null)) {
      errorMessage =
          (err.response?.data['message'] ?? err.response?.data['Message'])
              .toString();
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      errorMessage =
          "Connection timed out. Please check your internet connection.";
    } else if (err.type == DioExceptionType.connectionError) {
      errorMessage = "No internet connection. Please check your network.";
    } else if (err.response?.statusCode == 500) {
      if (err.requestOptions.path.contains('get_address_from_pincode') ||
          err.requestOptions.path.contains('addressFromPincode')) {
        errorMessage = "Unable to fetch location. Please change the pincode.";
      } else {
        errorMessage = "Server error. Please try again later.";
      }
    } else if (err.message != null &&
        !err.message!.contains("This exception was thrown") &&
        !err.message!.contains("status code of")) {
      errorMessage = err.message!;
    }

    final errStatus = err.response?.data is Map ? err.response?.data['status']?.toString() : null;
    if (errStatus == '3' || err.response?.statusCode == 401) {
      final isLogoutRequest =
          err.requestOptions.path.contains('apna_user_logout') ||
          err.requestOptions.path.contains('user_logout');
      final isAuthLoggedIn =
          ref.read(authProvider).value == AuthStatus.loggedIn;
      if (isAuthLoggedIn && !isLogoutRequest) {
        ref.read(authProvider.notifier).logout(showToast: false);
      }
    }

    if (!(err.type == DioExceptionType.badResponse &&
            err.requestOptions.path.contains('apna_u_user_details')) &&
        !err.requestOptions.path.contains('apna_user_logout') &&
        !err.requestOptions.path.contains('user_logout')) {
      showErrorAlertDialog(getx.Get.context, errorMessage);
    }

    handler.next(err);
  }
}
