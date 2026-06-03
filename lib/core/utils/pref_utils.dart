//ignore: unused_import
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  savePreferencesData(String key, String value) async {
    _sharedPreferences?.setString(key, value);
  }

  savePreferencesBool(String key, bool value) async {
    _sharedPreferences?.setBool(key, value);
  }

  getPreferencesData(String key) async {
    _sharedPreferences?.getString(key);
    print(_sharedPreferences?.getString(key));
  }

  getPreferencesBool(String key) async {
    _sharedPreferences?.getBool(key);
  }

  ///will clear all the data stored in preference
  clearPreferencesData() async {
    _sharedPreferences!.clear();
  }
}
