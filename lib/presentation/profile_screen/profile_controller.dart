import 'dart:io';

import 'package:apnagodam/presentation/login_screen/LoginBottomsheet.dart';
import 'package:apnagodam/presentation/splash_screen/splash_screen.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/color_constant.dart';
import '../../../data/apiClient/apiClient.dart';
import '../home_screen/models/UserDetailModal.dart';

class ProfileController extends GetxController {
  // Rx<HomeModel> homeModelObj = HomeModel().obs;

  UserDetailsModel? userDetailModal;

  @override
  void onReady() {
    update();
    super.onReady();
  }

  TextEditingController panController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController userEmailcontroller = TextEditingController();
  TextEditingController userKycPancontroller = TextEditingController();
  TextEditingController userKycAcccontroller = TextEditingController();
  TextEditingController userKycAadharcontroller = TextEditingController();
  String pan = "";
  String acccount = "";
  String aadhar = "";
  double walletamount = 0.0;
  ScrollController homeviewcontroller = ScrollController();

  bool userisLoading = true;
  bool isLoad = true;

  var bankIndex = -1;

  int currentIndex = 0;
  int currentIndexhome = 0;

  var totalData;
  var nextUrl;

  var lyinLoad = false;
  var lyinLoading = false;
  var totalDatalyin;
  var lyingnextUrl;

  double walletAmount = 0.0;

  bool useremailCheck = false;
  bool userinputpanCheck = false;
  bool userAccCheck = false;
  bool userinputAadharCheck = false;
  bool userprofileCheck = false;
  bool userpassbookCheck = false;
  bool userpanCheck = false;
  bool usergstCheck = false;
  bool useraadharCheck = false;

  @override
  void onInit() {
    userDetail();

    super.onInit();
  }

  onInClick(context) async {}

  userDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userisLoading = true;
    update();
    // await ApiClient.userdetaillistData().then((value) {
    //   if (value != null) {
    //     if (value["status"] == "3") {
    //       prefs.setBool("isLogin", false);
    //       Get.offAll(() => SplashScreen());
    //       Get.rawSnackbar(
    //           message: value["message"],
    //           duration: const Duration(seconds: 2),
    //           backgroundColor: ColorConstant.red500);
    //     } else {
    //       userisLoading = false;
    //       ProgressDialogUtils.hideProgressDialog();
    //       update();
    //       debugPrint("profile: ${value}", wrapWidth: 2448);
    //
    //       userDetailModal = userDetailsModelFromMap(value);
    //
    //       prefs.setString(
    //           "wallatAmount", userDetailModal!.userDetails!.power.toString());
    //       prefs.setString(
    //           "firstname", userDetailModal!.userDetails!.fname.toString());
    //       prefs.setString("bnplusedpower",
    //           userDetailModal!.userDetails!.bnplUsedPower.toString());
    //       prefs.setString(
    //           "bnplpower", userDetailModal!.userDetails!.bnplPower.toString());
    //       prefs.setString("accountVerifyed",
    //           userDetailModal!.userDetails!.verifiedAccount.toString());
    //       prefs.setString(
    //           "panstatus", userDetailModal!.userDetails!.panStatus.toString());
    //       prefs.setString(
    //           "bnplterms", userDetailModal!.userDetails!.bnplTerms.toString());
    //       prefs.setString("tradeterms",
    //           userDetailModal!.userDetails!.tradeTerms.toString());
    //       prefs.setString("pancardimage",
    //           userDetailModal!.userDetails!.pancardImage.toString());
    //       prefs.setString(
    //           "userId", userDetailModal!.userDetails!.userId.toString());
    //       update();
    //       panController.text = userDetailModal!.userDetails!.pancardNo;
    //       accountController.text = userDetailModal!.userDetails!.bankAccNo;
    //       aadharController.text = userDetailModal!.userDetails!.aadharNo;
    //       userEmailcontroller.text = userDetailModal!.userDetails!.email;
    //       userKycPancontroller.text = userDetailModal!.userDetails!.pancardNo;
    //       userKycAadharcontroller.text = userDetailModal!.userDetails!.aadharNo;
    //     }
    //   }
    // });
  }

  Future apanaUpdateUserProfileandPassbookData(
    String profile,
    String passbook,
    String panCard,
    String gst,
    String aadhar,
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await ApiClient.apanaUpdateUserProfileandPassbookDataService(
      profile,
      passbook,
      panCard,
      gst,
      aadhar,
    ).then((value) {
      if (value != null) {
        if (value["status"] == "3") {
          showBottomSheet(
            context: context,
            builder:
                (bottomsheetContext) => ElevarmDraggableBottomSheet(
                  title: "Login to Continue",
                  onPressedClose: () => Get.back(),
                  children: [LoginBottomSheet()],
                ),
          );
        } else {
          userDetail();
          update();

          Get.rawSnackbar(
            message: value["message"],
            duration: const Duration(seconds: 10),
            backgroundColor: ColorConstant.maingreen,
          );
        }
      }
    });
  }

  apanaUpdateUserData(
    var email,
    var whatsupNumber,
    var panNumber,
    var aadharNumber,
    var address,
    var areaVillage,
    var city,
    var district,
    var state,
    var pincode,
    File panCardImage,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await ApiClient.apanaUpdateUserDataService(
      email,
      whatsupNumber,
      panNumber,
      aadharNumber,
      address,
      areaVillage,
      city,
      district,
      state,
      pincode,
      panCardImage,
    ).then((value) {
      if (value != null) {
        if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
          Get.offAll(() => SplashScreen());
          Get.rawSnackbar(
            message: value["message"],
            duration: const Duration(seconds: 10),
            backgroundColor: ColorConstant.red500,
          );
        } else {
          userDetail();
          update();

          Get.rawSnackbar(
            message: value["message"],
            duration: const Duration(seconds: 10),
            backgroundColor: ColorConstant.maingreen,
          );
        }
      }
    });
  }

  bankChangeIndex(var index) {
    bankIndex = index;
    update();
  }
}
