import 'dart:async';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/LP_list_screen/service/LpService.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/service/wallet_service.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/wallet_statement_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'AuthProvider.g.dart';

enum AuthStatus {
  loggedIn,
  loggedOut,
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  static bool _isLoggingOut = false;
  Timer? _sessionTimer;

  @override
  FutureOr<AuthStatus> build() {
    ref.onDispose(() {
      _sessionTimer?.cancel();
      _sessionTimer = null;
    });

    final token = ref.watch(sharedPreferencesProvider).getString('token');
    if (token != null && token.isNotEmpty) {
      _startSessionHeartbeat();
      return AuthStatus.loggedIn;
    }
    _sessionTimer?.cancel();
    return AuthStatus.loggedOut;
  }

  void _startSessionHeartbeat() {
    _sessionTimer?.cancel();
    // Periodically verify token validity (every 12 seconds) so multi-device login invalidation is detected promptly
    _sessionTimer = Timer.periodic(const Duration(seconds: 12), (timer) async {
      if (state.value != AuthStatus.loggedIn || _isLoggingOut) {
        timer.cancel();
        return;
      }
      try {
        final token = ref.read(sharedPreferencesProvider).getString('token');
        if (token == null || token.isEmpty) {
          timer.cancel();
          logout(showToast: false);
          return;
        }

        // Lightweight ping to check session validity
        final response = await ref.read(dioProvider).get(
          USER_DETAILS,
          options: Options(
            headers: {'Authorization': token},
            sendTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
          ),
        );

        if (response.data is Map) {
          final status = response.data['status']?.toString();
          if (status == '3') {
            debugPrint("🚨 Session invalidated on another device (status: 3). Logging out immediately.");
            timer.cancel();
            logout(showToast: true);
          }
        }
      } catch (e) {
        // DioInterceptor will catch status 3 automatically if returned by error response
        debugPrint("Session heartbeat check caught: $e");
      }
    });
  }

  Future<void> login(String token) async {
    final prefs = ref.read(sharedPreferencesProvider);
    final lang = prefs.getString('lang');

    // 1. Wipe any leftover stale preferences first, keeping language
    await prefs.clear();
    if (lang != null && lang.isNotEmpty) {
      await prefs.setString('lang', lang);
    }

    // 2. Set new user token & session
    await prefs.setString('token', token);
    await prefs.setBool('isLogin', true);
    ref.read(sharedUtilityProvider).setToken(token);

    // 3. Clear image caches so old profile/avatars don't linger in memory
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    // 4. Delete all old GetX controllers from memory
    Get.deleteAll(force: true);

    // 5. Invalidate dioProvider so interceptors immediately bind to the new token
    ref.invalidate(dioProvider);

    // 6. Invalidate all user providers and SBT commodity list
    ref.invalidate(userDetailsProvider);
    ref.invalidate(homeDataProvider);
    ref.invalidate(allBookingsProvider);
    ref.invalidate(warehouseBookingsProvider);
    ref.invalidate(matchedOrdersProvider);
    ref.invalidate(getSbtCommodityProvider);
    ref.invalidate(getWalletListProvider);
    ref.invalidate(walletSummaryDataProvider);
    ref.read(openingBalance.notifier).state = 0.0;
    ref.read(closingBalance.notifier).state = '0.0';
    ref.read(fromDateProvider.notifier).state = DateFormat(
      'dd-MM-yyyy',
    ).format(DateTime.now().subtract(Duration(days: 30)));
    ref.read(toDateProvider.notifier).state =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    ref.read(selectedFilterProvider.notifier).state = '1 Month';

    state = const AsyncData(AuthStatus.loggedIn);
    _startSessionHeartbeat();

    Fluttertoast.showToast(
      msg: "Login successful",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: ColorConstant.maingreen,
    );

    // 7. Immediately refresh & fetch new user details so fresh data is loaded instantly!
    try {
      final _ = await ref.refresh(userDetailsProvider.future);
    } catch (e) {
      debugPrint("Error loading new user data on login: $e");
    }
  }

  Future<void> logout({bool showToast = true}) async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;
    _sessionTimer?.cancel();
    _sessionTimer = null;

    try {
      final prefs = ref.read(sharedPreferencesProvider);
      final lang = prefs.getString('lang');
      final token = prefs.getString('token');

      // 1. Instantly clear ALL SharedPreferences completely (preserving only app language)
      await prefs.clear();
      if (lang != null && lang.isNotEmpty) {
        await prefs.setString('lang', lang);
      }
      await prefs.setBool("isLogin", false);
      await prefs.setString('token', '');

      // Reset SharedUtility in-memory references
      ref.read(sharedUtilityProvider).setToken('');
      ref.read(sharedUtilityProvider).setFinanceToken('');

      // 2. Clear Image Cache so old user avatar/photos are removed from memory
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      // 3. Delete all GetX controllers from memory
      Get.deleteAll(force: true);

      // 4. Invalidate all Riverpod providers and dioProvider
      try {
        ref.invalidate(dioProvider);
        ref.invalidate(userDetailsProvider);
        ref.invalidate(homeDataProvider);
        ref.invalidate(allBookingsProvider);
        ref.invalidate(warehouseBookingsProvider);
        ref.invalidate(matchedOrdersProvider);
        ref.invalidate(getSbtCommodityProvider);
        ref.invalidate(getWalletListProvider);
        ref.invalidate(walletSummaryDataProvider);
        ref.invalidate(selectedIndex);
        ref.read(openingBalance.notifier).state = 0.0;
        ref.read(closingBalance.notifier).state = '0.0';
        ref.read(fromDateProvider.notifier).state = DateFormat(
          'dd-MM-yyyy',
        ).format(DateTime.now().subtract(Duration(days: 30)));
        ref.read(toDateProvider.notifier).state =
            DateFormat('dd-MM-yyyy').format(DateTime.now());
        ref.read(selectedFilterProvider.notifier).state = '1 Month';
      } catch (e) {
        debugPrint("Error invalidating providers on logout: $e");
      }

      // 5. Instantly switch auth state to loggedOut
      state = const AsyncData(AuthStatus.loggedOut);

      if (showToast) {
        Fluttertoast.showToast(
          msg: "Logged out successfully",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: ColorConstant.maingreen,
        );
      }

      // 6. Non-blocking server cleanup in background (fire-and-forget)
      if (token != null && token.isNotEmpty) {
        ref.read(dioProvider).post(
          APANA_USER_LOGUT,
          options: Options(
            headers: {'Authorization': token},
            sendTimeout: const Duration(seconds: 3),
            receiveTimeout: const Duration(seconds: 3),
          ),
        ).then((_) {
          debugPrint("Background server logout completed");
        }).catchError((e) {
          debugPrint("Background server logout error: $e");
        });
      }

      FirebaseMessaging.instance.deleteToken().catchError((e) {
        debugPrint("Background deleteToken error: $e");
      });
    } finally {
      _isLoggingOut = false;
    }
  }

  // Helper for quick access
  AuthStatus? get loginStatus => state.value;
}
