import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:apnagodam/core/providers/app_language_provider.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> languages = [
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇺🇸',
      'locale': const Locale('en', 'US'),
    },
    {
      'code': 'hi',
      'name': 'Hindi',
      'nativeName': 'हिंदी',
      'flag': '🇮🇳',
      'locale': const Locale('hi', 'IN'),
    },
    {
      'code': 'kn',
      'name': 'Kannada',
      'nativeName': 'ಕನ್ನಡ',
      'flag': '🇮🇳',
      'locale': const Locale('kn', 'IN'),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    // No local `selectedLanguage` initialization needed: we derive
    // selection directly from the appLanguageProvider to keep the UI
    // reactive and avoid stale state across navigation.
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _changeLanguage(Map<String, dynamic> language) async {
    // Debug/log the requested change
    debugPrint(
        'LanguageScreen: requested language change -> ${language['code']}');

    // Update app-level provider first so the app rebuilds immediately
    try {
      ref.watch(appLanguageProvider.notifier).state = language['code'];
      debugPrint(
          'LanguageScreen: appLanguageProvider set -> ${ref.read(appLanguageProvider)}');
    } catch (e) {
      debugPrint('LanguageScreen: provider set error: $e');
    }

    // Persist the choice for future launches
    final prefs = ref.watch(sharedPreferencesProvider);
    try {
      await prefs.setString('lang', language['code']);
      debugPrint(
          'LanguageScreen: persisted lang -> ${prefs.getString('lang')}');
    } catch (e) {
      debugPrint('LanguageScreen: prefs write error: $e');
    }

    // Log current locales before updating Get
    debugPrint(
        'LanguageScreen: before Get.updateLocale -> Get.locale=${Get.locale}, Localization=${Localizations.localeOf(context)}');

    // Also update GetX locale (keeps interoperability with any leftover GetX logic)
    Get.updateLocale(language['locale']);
    debugPrint(
        'LanguageScreen: called Get.updateLocale(${language['locale']}) -> Get.locale=${Get.locale}');

    // Show localized feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${AppLocalizations.of(context)!.msgChangeLanguage}: ${language['name']}'),
        backgroundColor: ColorConstant.maingreen,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Navigate back after a short delay so the user can see the feedback
    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.selectLang,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: ColorConstant.maingreen,
        elevation: 0,
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.selectLang,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.msgChangeLanguageContent,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final language = languages[index];
                    final currentLang = ref.watch(appLanguageProvider);
                    final isSelected = currentLang == language['code'];

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? ColorConstant.maingreen
                              : Colors.grey[200]!,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color:
                                      ColorConstant.maingreen.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => _changeLanguage(language),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorConstant.maingreen
                                            .withOpacity(0.1)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      language['flag'],
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        language['name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        language['nativeName'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.maingreen,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
