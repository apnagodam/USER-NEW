import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/LP_list_screen/service/LpService.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/login_screen/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'AuthProvider.g.dart';

enum AuthStatus {
  loggedIn,
  loggedOut,
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  FutureOr<AuthStatus> build() {
    final token = ref.watch(sharedPreferencesProvider).getString('token');
    if (token != null && token.isNotEmpty) {
      return AuthStatus.loggedIn;
    }
    return AuthStatus.loggedOut;
  }

  Future<void> login(String token) async {
    await ref.read(sharedPreferencesProvider).setString('token', token);
    await ref.read(sharedPreferencesProvider).setBool('isLogin', true);
    ref.read(sharedUtilityProvider).setToken(token);

    state = const AsyncData(AuthStatus.loggedIn);

    Fluttertoast.showToast(
      msg: "Login successful",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: ColorConstant.maingreen,
    );

    // Invalidate and refresh userDetails and all key providers immediately so KYC, user data, and UI update without delay
    try {
      ref.invalidate(userDetailsProvider);
      ref.invalidate(homeDataProvider);
      ref.invalidate(allBookingsProvider);
      ref.invalidate(warehouseBookingsProvider);
      ref.invalidate(matchedOrdersProvider);
    } catch (e) {
      debugPrint("Error refreshing providers on login: $e");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.setBool("isLogin", false);
    await prefs.clear();
    ref.read(sharedUtilityProvider).setToken('');
    ref.read(sharedPreferencesProvider).clear();

    state = const AsyncData(AuthStatus.loggedOut);

    try {
      ref.invalidate(userDetailsProvider);
      ref.invalidate(homeDataProvider);
      ref.invalidate(allBookingsProvider);
      ref.invalidate(warehouseBookingsProvider);
      ref.invalidate(matchedOrdersProvider);
    } catch (e) {
      debugPrint("Error invalidating providers on logout: $e");
    }
  }

  // Helper for quick access
  AuthStatus? get loginStatus => state.value;
}
