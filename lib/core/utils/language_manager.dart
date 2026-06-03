import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_language_provider.dart';

class LanguageManager {
  static Locale localeFromCode(String code) {
    if (code == 'hi') return const Locale('hi', 'IN');
    if (code == 'kn') return const Locale('kn', 'IN');
    return const Locale('en', 'US');
  }

  static Future<void> changeLanguage(WidgetRef ref, String langCode) async {
    final locale = localeFromCode(langCode);
    // Update Riverpod provider
    ref.read(appLanguageProvider.notifier).state = langCode;
    // Update GetX locale (for widgets using GetX translations)
    try {
      Get.updateLocale(locale);
    } catch (_) {}
    // Persist selection
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', langCode);
  }
}
