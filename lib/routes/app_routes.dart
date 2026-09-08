import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/home_screen/binding/home_binding.dart';
import 'package:apnagodam/presentation/home_screen/ui/HomePage.dart';
import 'package:apnagodam/presentation/login_screen/otp_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:go_router/go_router.dart';

import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/singup_screen/binding/singup_binding.dart';
import '../presentation/singup_screen/singup_screen.dart';
import '../presentation/splash_screen/binding/splash_binding.dart';
import '../presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  static  String splashScreen = '/splash_screen';
  static  String loginScreen = '/login_screen';
  static  String singupScreen = '/singup_screen';
  static  String homepage = '/home_screen';
  static  String dashbordview = '/dashboard_screen';
  static  String otpscreen = '/otp_screen';
  static  String appNavigationScreen = '/app_navigation_screen';
  static  String initialRoute = '/initialRoute';

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: singupScreen,
      page: () => SingupScreen(
        mobileNumber: "",
      ),
      bindings: [
        SingupBinding(),
      ],
    ),

    GetPage(
      name: homepage,
      page: () => Homepage(),
      bindings: [
        HomeBinding(),
      ],
    ),

    GetPage(
      name: dashbordview,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    // GetPage(
    //   name: otpscreen,
    //   page: () => Otpscreen(),
    //   /*bindings: [
    //     LoginBinding(),
    //   ],*/
    // )
  ];
}

var goRouterProvider = StateProvider((ref) => GoRouter(
        debugLogDiagnostics: kDebugMode,
        // redirect: (context, state) {
        //   if (ref.watch(sharedUtilityProvider).getUser() == null) {
        //     if (state.fullPath == '/') return '/login';
        //     return null;
        //   }
        // },
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => DashboardScreen(),
            routes: [
              GoRoute(
                name: "/login",
                path: "/login",
                builder: (context, state) =>  LoginScreen(),
              ),
              GoRoute(
                name: '/otp',
                path: "/otp",
                builder: (context, state) {
                  final data = state.extra! as Map<String, dynamic>;
                  return Otpscreen(
                    phoneNumber: data['phone'],
                    otpType: data['type'],
                    userId: data['user_id']?.toString() ?? data['userId']?.toString(),
                    userName: data['userName']?.toString(),
                  );
                },
              ),
            ],
          )

        ]));
