import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../presentation/login_screen/models/AuthenticationModel.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  String getToken() {
    return sharedPreferences.getString('token') ?? "";
  }

  void setToken(String token) {
    sharedPreferences.setString('token', token);
  }

  String getFinanceToken() {
    return sharedPreferences.getString('finance_token') ?? "";
  }

  void setFinanceToken(String token) {
    sharedPreferences.setString('finance_token', token);
  }

  void setLogin(bool login) {
    sharedPreferences.setBool('isLogin', login);
  }

  bool getLogin() {
    return sharedPreferences.getBool('isLogin') ?? false;
  }

  Position getPosition() {
    return sharedPreferences.get('position') != null
        ? Position.fromMap(
            jsonDecode(sharedPreferences.getString('position') ?? ""))
        : Position(
            latitude: 0.0,
            longitude: 0.0,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0);
  }

  void setPosition(Position position) {
    sharedPreferences.setString('position', jsonEncode(position.toJson()));
  }

  UserDetailsAuth? getUser() {
    return sharedPreferences.get('user') != null
        ? UserDetailsAuth.fromJson(
            jsonDecode(sharedPreferences.getString('user') ?? ""))
        : null;
  }

  void setUser(UserDetailsAuth userMap) {
    sharedPreferences.setString('user', jsonEncode(userMap));
  }

  bool isBusinessProfileActive() =>
      sharedPreferences.getBool('business_profile') ?? true;

  void setBusinessProfileStatus(bool isActive) =>
      sharedPreferences.setBool('business_profile', isActive);

  bool isMandiTaxProfileActive() =>
      sharedPreferences.getBool('manditax_profile') ?? true;

  void setMandiTaxProfileStatus(bool isActive) =>
      sharedPreferences.setBool('manditax_profile', isActive);

  bool isGstProfileActive() =>
      sharedPreferences.getBool('gst_profile') ?? false;

  void setGstProfileStatus(bool isActive) =>
      sharedPreferences.setBool('gst_profile', isActive);

  bool isKycComplete() => sharedPreferences.getBool('verified') ?? false;

  void setKyc(bool isKycComplete) =>
      sharedPreferences.setBool('verified', isKycComplete);

  bool isUnderVerification() =>
      sharedPreferences.getBool('under_verification') ?? false;

  void setUnderVerification(bool isVerified) =>
      sharedPreferences.setBool('under_verification', isVerified);
}
