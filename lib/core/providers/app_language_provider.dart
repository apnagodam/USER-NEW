import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/SharedPrefs/SharedUtility.dart';

// App language provider (stores language code like 'en','hi','kn')
final appLanguageProvider = StateProvider<String>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return sharedPreferences.getString('lang') ?? 'hi';
});
