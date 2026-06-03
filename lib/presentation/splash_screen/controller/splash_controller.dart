import 'dart:async';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/onbording_screen/onbording_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/dashboard_screen.dart';
import '../models/splash_model.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;

  @override
  void onReady() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool("isLogin") ?? false;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: ColorConstant.maingreen,
      statusBarColor: ColorConstant.maingreen,
    ));
    if (isLogin) {
      Future.delayed(const Duration(milliseconds: 3000), () {
        Get.offAll(() => DashboardScreen());
      });
    } else {
      Future.delayed(const Duration(milliseconds: 3000), () {
        Get.off(() => Onbording());
      });
    }

    super.onReady();
  }
}
