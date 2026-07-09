import 'dart:io';
import 'dart:ui';

import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/firebase_options.dart';
import 'package:apnagodam/presentation/LP_list_screen/controller/lplist_controller.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/splash_screen/splash_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/SharedPrefs/SharedUtility.dart';
import 'core/utils/notification_service.dart';
// legacy GetX translations removed; using Flutter gen_l10n and AppLocalizations
import 'core/providers/app_language_provider.dart';

//

GlobalKey<NavigatorState> mainNavKey = GlobalKey();
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  debugPrint(response.payload);
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

void main() async {
  // HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // No need to add this line
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final sharedPreferences = await SharedPreferences.getInstance();

  ElevarmFontFamilies.init();
  try {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
            }
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      }
    });
  } catch (e) {}

  // Get saved language code from SharedPreferences
  String? langCode = sharedPreferences.getString('lang');
  Locale initialLocale;
  if (langCode == 'hi') {
    initialLocale = const Locale('hi', 'IN');
  } else if (langCode == 'kn') {
    initialLocale = const Locale('kn', 'IN');
  } else if (langCode == 'en') {
    initialLocale = const Locale('en', 'US');
  } else {
    // Default to Hindi if no language is saved
    initialLocale = const Locale('hi', 'IN');
  }

  // Initialize GetX with the correct locale
  Get.updateLocale(initialLocale);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );

  _subscribeToFcmTopic();
}

Future<void> _subscribeToFcmTopic() async {
  try {
    if (GetPlatform.isIOS) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken == null) {
        await Future.delayed(Duration(seconds: 2));
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      }
      if (apnsToken != null) {
        // Now safe to subscribe or get FCM token
        await FirebaseMessaging.instance.subscribeToTopic('all');
      }
    } else {
      await FirebaseMessaging.instance.subscribeToTopic('all');
    }
  } catch (e) {
    print(e.toString());
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NotificationService.init(ref);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        // DeviceOrientation.portraitDown,
      ]);
      _handleUserAndDeviceInfo();
    });
  }

  Future<void> _handleUserAndDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    if (ref.watch(authProvider).value == AuthStatus.loggedIn) {
      final userData = await ref.watch(userDetailsProvider.future);
      if (userData.userDetails != null) {
        await _updateDeviceId(androidInfo.id, userData);
      }
    }
  }

  Future<void> _updateDeviceId(String deviceId, userData) async {
    final position = await _getPosition();

    final dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: Duration(minutes: 10),
        sendTimeout: Duration(minutes: 10),
        receiveTimeout: Duration(minutes: 10),
      ),
    )..interceptors.add(PrettyDioLogger());

    await dio.post(
      'location/userLocation',
      data: {
        "fullName": "${userData.userDetails?.fname}",
        "phone": "${userData.userDetails?.phone}",
        "loginType": "user",
        "deviceId": deviceId,
        "empId": "NULL",
        "location": {
          "type": "Point",
          "coordinates": [
            position?.longitude ?? 0.0,
            position?.latitude ?? 0.0,
          ],
        },
        "appType": "user",
      },
    );
  }

  String _getBaseUrl() {
    final url = ref.watch(dioProvider).options.baseUrl.toLowerCase();
    if (url.contains('test') || url.contains('demo')) {
      return 'http://localhost:3000/api/';
    } else {
      return 'https://swlpl-next.vercel.app/api/';
    }
  }

  Future<Position?> _getPosition() async {
    final permission = await requestLocationPermission();
    if (permission) {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      ref.watch(sharedUtilityProvider).setPosition(position);
      return position;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Watch the appLanguageProvider to rebuild when language changes
    final langCode = ref.watch(appLanguageProvider);
    Locale effectiveLocale;
    if (langCode == 'hi') {
      effectiveLocale = const Locale('hi', 'IN');
    } else if (langCode == 'kn') {
      effectiveLocale = const Locale('kn', 'IN');
    } else {
      effectiveLocale = const Locale('en', 'US');
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) => GetMaterialApp(
          theme: ThemeData(
            fontFamily: GoogleFonts.lato().fontFamily,
            scaffoldBackgroundColor: Colors.white,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
                TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
              },
            ),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: ColorConstant.maingreen,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
          ),
          debugShowCheckedModeBanner: false,
          locale: effectiveLocale,
          fallbackLocale: const Locale('hi', 'IN'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: SplashScreen(),
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale?.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
        ),
      ),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LplistController>(() => LplistController());
  }
}
//
// var dataBaseProvider = StreamProvider(
//     (ref) => FirebaseFirestore.instance.collection("app_version").snapshots());

Future<bool> requestLocationPermission() async {
  try {
    // Check if location services are enabled.
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (GetPlatform.isAndroid) {
        await Geolocator.openLocationSettings();
        Fluttertoast.showToast(
          msg: "Location services are disabled. Please enable them.",
        );
      }

      return false;
    }

    // Check the current permission status.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if it is denied.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && GetPlatform.isAndroid) {
        Fluttertoast.showToast(
          msg: "Location permission denied. Please allow access.",
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) { 
      // Handle the case where permission is permanently denied.

      if (GetPlatform.isAndroid) {
        Fluttertoast.showToast(
          msg:
              "Location permission is permanently denied. Please enable it in settings.",
        );
        await Geolocator.openAppSettings();
      }
      return false;
    }

    // Permission granted.
    return true;
  } catch (e) {
    // Handle unexpected errors.
    Fluttertoast.showToast(
      msg: "An error occurred while requesting location permission: $e",
    );
    return false;
  }
}
