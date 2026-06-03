import 'package:anywhere_loader/provider/anywhere_loader_context_provider.dart';
import 'package:apnagodam/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../core/utils/image_constant.dart';
import '../dashboard/dashboard_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

const token =
    r'$2y$10$SXPonFekFc8u50lWdBQeLucWUjuwZcjspn7ilrW7pNt7WBTpykz8S'; //vishambhar live

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ref.watch(sharedUtilityProvider).setToken(token);
      // ref.invalidate(dioProvider);
      // Future.delayed(Duration(seconds: 1));
      // Get.offAll(() => DashboardScreen());

      // Language is already initialized in main.dart, no need to update here
      requestLocationPermission();
      Future.delayed(Duration(seconds: 1));
      Get.offAll(() => DashboardScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnyWhereLoaderContextProvider(
      child: SafeArea(
          child: Scaffold(
        // backgroundColor: ColorConstant.mainwhite,
        body: Center(
          child: Image.asset(
            ImageConstant.mainlogopng,
            // height: 120,
            // width: 120,
            fit: BoxFit.cover,
          ),
        ),
      )),
    );
  }
}
