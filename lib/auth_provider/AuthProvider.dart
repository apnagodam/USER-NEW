import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/login_screen/login_screen.dart';
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
  FutureOr<AuthStatus> build() async {
    final prefs = await SharedPreferences.getInstance();
    final token = ref.watch(sharedPreferencesProvider).getString('token');

    if (token?.isNotEmpty ?? false) {
      state = const AsyncData(AuthStatus.loggedIn);
    }
    if (loginStatus == AuthStatus.loggedOut) {
      Get.to(LoginScreen());
    }
    return token?.isNotEmpty ?? false
        ? AuthStatus.loggedIn
        : AuthStatus.loggedOut;
  }

  Future<void> login(String token) async {
    await ref.watch(sharedPreferencesProvider).setString('token', token);

    await ref.watch(sharedPreferencesProvider).setBool('isLogin', true);
    ref.watch(sharedUtilityProvider).setToken(token);

    Future.delayed(Duration(seconds: 1));

    Fluttertoast.showToast(
      msg: "Login successful",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: ColorConstant.maingreen,
    );
    state = const AsyncData(AuthStatus.loggedIn);
    ref.invalidate(userDetailsProvider);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.setBool("isLogin", false);
    await prefs.clear();
    // Get.to(LoginScreen());
    ref.watch(sharedUtilityProvider).setToken('');

    ref.watch(sharedPreferencesProvider).clear();

    state = const AsyncData(AuthStatus.loggedOut);
  }

  // Optional helper for quick access
  get loginStatus => state.value;
}
