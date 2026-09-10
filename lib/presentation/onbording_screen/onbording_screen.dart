import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/providers/ThemeController.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/language/language.dart';
import 'package:apnagodam/presentation/login_screen/login_screen.dart';
import 'package:apnagodam/routes/app_routes.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/image_constant.dart';
import '../../widgets/CustomShapeClipper.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Onbording extends ConsumerStatefulWidget {
  const Onbording({super.key});

  @override
  ConsumerState<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends ConsumerState<Onbording> {
  PageController pageController = PageController();

  var pageChanged = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(sharedPreferencesProvider).setBool('onboarded', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        totalPage: 4,
        hasSkip: true,
        controllerColor: ColorConstant.maingreen,
        skipTextButton: Text(
          "Skip",
          style: TextStyle(color: ColorConstant.maingreen),
        ),
        skipFunctionOverride: () {
          Get.to(DashboardScreen());
        },
        background: [
          Lottie.asset(ImageConstant.introone,
              width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover),
          Lottie.asset(ImageConstant.introtwo,
              width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover),
          Lottie.asset(ImageConstant.introthree,
              width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover),
          Lottie.asset(ImageConstant.introfore,
              width: MediaQuery.of(context).size.width * 1, fit: BoxFit.cover)
        ],
        speed: 1.8,
        trailing: null,
        onFinish: () {
          Get.to(DashboardScreen());
        },
        finishButtonText: "Login",
        finishButtonStyle:
            FinishButtonStyle(backgroundColor: ColorConstant.maingreen),
        pageBodies: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: Pad(
                  bottom: Adaptive.h(10),
                  left: Adaptive.w(5),
                  right: Adaptive.w(5)),
              child: ColumnSuper(
                alignment: Alignment.centerLeft,
                children: [
                  Text(AppLocalizations.of(context)!.msgOnlineMandi,
                      style: AppStyle.lblonbordingh.copyWith(
                          fontSize: Adaptive.sp(22),
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppLocalizations.of(context)!.msgOnborderingFirst,
                    style: TextStyle(fontSize: Adaptive.sp(16)),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: Pad(
                  bottom: Adaptive.h(10),
                  left: Adaptive.w(5),
                  right: Adaptive.w(5)),
              child: ColumnSuper(
                alignment: Alignment.bottomLeft,
                children: [
                  Text(
                    AppLocalizations.of(context)!.msgFinance,
                    style: AppStyle.lblonbordingh.copyWith(
                        fontSize: Adaptive.sp(22), fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppLocalizations.of(context)!.msgOnborderingSecond,
                    style: AppStyle.lblonbordingp
                        .copyWith(fontSize: Adaptive.sp(16)),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: Pad(
                  bottom: Adaptive.h(10),
                  left: Adaptive.w(5),
                  right: Adaptive.w(5)),
              child: ColumnSuper(
                alignment: Alignment.centerLeft,
                children: [
                  Text(
                    AppLocalizations.of(context)!.msgWarehousing,
                    style: AppStyle.lblonbordingh.copyWith(
                        fontSize: Adaptive.sp(22), fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppLocalizations.of(context)!.msgOnborderingTherd,
                    style: AppStyle.lblonbordingp
                        .copyWith(fontSize: Adaptive.sp(16)),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: Pad(
                  bottom: Adaptive.h(20),
                  left: Adaptive.w(5),
                  right: Adaptive.w(5)),
              child: ColumnSuper(
                alignment: Alignment.centerLeft,
                children: [
                  Text(AppLocalizations.of(context)!.msgLogistics,
                      style: AppStyle.lblonbordingh.copyWith(
                          fontSize: Adaptive.sp(22),
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppLocalizations.of(context)!.msgOnborderingFor,
                    style: AppStyle.lblonbordingp
                        .copyWith(fontSize: Adaptive.sp(16)),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  onboardingUI() => PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          // print(pageChanged);
        },
        // scrollDirection: Axis.horizontal,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 18.0, left: 15, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            ImageConstant.mainlogopng,
                            fit: BoxFit.cover,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(LanguageScreen());
                            },
                            child: SizedBox(
                              width: 100,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/bg_icon_english.PNG',
                                    width: 45,
                                  ),
                                  Positioned(
                                      left: 30,
                                      child: Image.asset(
                                        'assets/images/bg_icon_hindi.PNG',
                                        fit: BoxFit.contain,
                                        width: 45,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        ClipPath(
                          clipper: CustomShapeClipper(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFc8f8e0),
                                  Color(0xFFe2fcef),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 38.0),
                          child: Lottie.asset(ImageConstant.introone,
                              width: MediaQuery.of(context).size.width * 1,
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    // height: MediaQuery.of(context).size.height*,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Color(0xffd4d4d4),
                            spreadRadius: 0.5)
                      ],
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          /*top:35.0*/
                          left: 25,
                          right: 25,
                          top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.msgOnlineMandi,
                              style: AppStyle.lblonbordingh
                                  .copyWith(fontSize: Adaptive.sp(22))),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                              child: Text(
                            AppLocalizations.of(context)!.msgOnborderingFirst,
                            style: TextStyle(fontSize: Adaptive.sp(16)),
                          )),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(DashboardScreen());
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.skip,
                                    style: TextStyle(
                                        fontSize: Adaptive.sp(18),
                                        color: ColorConstant.maingreen),
                                  ),
                                ),
                                SizedBox(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstant.maingreen,
                                        shape: CircleBorder()),
                                    onPressed: () {
                                      // print("vvvvvvvvvvv");
                                      pageController.jumpToPage(1);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.east,
                                            size: 12,
                                            color: ColorConstant.grey,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 18.0, left: 15, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /* SvgPicture.asset(
                            'assets/images/mainlogo.svg',
                            height: 100,
                            width: 70,
                          ),*/
                          Image.asset(
                            ImageConstant.mainlogopng,
                            // height: 120,
                            // width: 120,
                            fit: BoxFit.cover,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(LanguageScreen());
                            },
                            child: SizedBox(
                              width: 100,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/bg_icon_english.PNG',
                                    width: 45,
                                  ),
                                  Positioned(
                                      left: 30,
                                      child: Image.asset(
                                        'assets/images/bg_icon_hindi.PNG',
                                        fit: BoxFit.contain,
                                        width: 45,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        ClipPath(
                          clipper: CustomShapeClipper(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFc8f8e0),
                                  Color(0xFFe2fcef),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 38.0),
                          child: Lottie.asset(ImageConstant.introtwo,
                              width: MediaQuery.of(context).size.width * 1,
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),

                    // Image.asset('assets/images/gif_center_intro2.gif',fit: BoxFit.cover,)
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    // height: MediaQuery.of(context).size.height*,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Color(0xffd4d4d4),
                            spreadRadius: 0.5)
                      ],
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 0,
                              child: Text(
                                AppLocalizations.of(context)!.msgFinance,
                                style: AppStyle.lblonbordingh
                                    .copyWith(fontSize: Adaptive.sp(22)),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                              child: Text(
                            AppLocalizations.of(context)!.msgOnborderingSecond,
                            style: AppStyle.lblonbordingp
                                .copyWith(fontSize: Adaptive.sp(16)),
                          )),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(DashboardScreen());
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.skip,
                                    style: TextStyle(
                                        fontSize: Adaptive.sp(18),
                                        color: ColorConstant.maingreen),
                                  ),
                                ),
                                SizedBox(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstant.maingreen,
                                        shape: CircleBorder()),
                                    onPressed: () {
                                      pageController.jumpToPage(2);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.east,
                                            size: 12,
                                            color: ColorConstant.grey,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 18.0, left: 15, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            ImageConstant.mainlogopng,
                            // height: 120,
                            // width: 120,
                            fit: BoxFit.cover,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(LanguageScreen());
                            },
                            child: SizedBox(
                              width: 100,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/bg_icon_english.PNG',
                                    width: 45,
                                  ),
                                  Positioned(
                                      left: 30,
                                      child: Image.asset(
                                        'assets/images/bg_icon_hindi.PNG',
                                        fit: BoxFit.contain,
                                        width: 45,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Image.asset('assets/images/gif_center_intro3.gif',fit: BoxFit.cover,),
                    Stack(
                      children: [
                        ClipPath(
                          clipper: CustomShapeClipper(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFc8f8e0),
                                  Color(0xFFe2fcef),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 38.0),
                          child: Lottie.asset(ImageConstant.introthree,
                              width: MediaQuery.of(context).size.width * 1,
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    // height: MediaQuery.of(context).size.height*,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Color(0xffd4d4d4),
                            spreadRadius: 0.5)
                      ],
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 0,
                              child: Text(
                                AppLocalizations.of(context)!.msgWarehousing,
                                style: AppStyle.lblonbordingh
                                    .copyWith(fontSize: Adaptive.sp(22)),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                              child: Text(
                            AppLocalizations.of(context)!.msgOnborderingTherd,
                            style: AppStyle.lblonbordingp
                                .copyWith(fontSize: Adaptive.sp(16)),
                          )),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(DashboardScreen());
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.skip,
                                    style: TextStyle(
                                        fontSize: Adaptive.sp(18),
                                        color: ColorConstant.maingreen),
                                  ),
                                ),
                                SizedBox(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstant.maingreen,
                                        shape: CircleBorder()),
                                    onPressed: () {
                                      pageController.jumpToPage(
                                          3); /*Get.toNamed(AppRoutes.loginScreen);*/
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.east,
                                            size: 12,
                                            color: ColorConstant.grey,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 18.0, left: 15, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            ImageConstant.mainlogopng,
                            // height: 120,
                            // width: 120,
                            fit: BoxFit.cover,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(LanguageScreen());
                            },
                            child: SizedBox(
                              width: 100,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/bg_icon_english.PNG',
                                    width: 45,
                                  ),
                                  Positioned(
                                      left: 30,
                                      child: Image.asset(
                                        'assets/images/bg_icon_hindi.PNG',
                                        fit: BoxFit.contain,
                                        width: 45,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        ClipPath(
                          clipper: CustomShapeClipper(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFc8f8e0),
                                  Color(0xFFe2fcef),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 38.0),
                          child: Lottie.asset(ImageConstant.introfore,
                              width: MediaQuery.of(context).size.width * 1,
                              fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    // height: MediaQuery.of(context).size.height*,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Color(0xffd4d4d4),
                            spreadRadius: 0.5)
                      ],
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                                AppLocalizations.of(context)!.msgLogistics,
                                style: AppStyle.lblonbordingh
                                    .copyWith(fontSize: Adaptive.sp(22))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                              child: Text(
                            AppLocalizations.of(context)!.msgOnborderingFor,
                            style: AppStyle.lblonbordingp
                                .copyWith(fontSize: Adaptive.sp(16)),
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(DashboardScreen());
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.skip,
                                    style: TextStyle(
                                        fontSize: Adaptive.sp(18),
                                        color: ColorConstant.maingreen),
                                  ),
                                ),
                                SizedBox(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorConstant.maingreen,
                                      shape: CircleBorder(),
                                    ),
                                    onPressed: () {
                                      pageController.jumpToPage(4);
                                      Get.to(() => const LoginScreen());
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.east,
                                            size: 12,
                                            color: ColorConstant.grey,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
