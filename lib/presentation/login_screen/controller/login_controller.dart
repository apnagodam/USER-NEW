import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/login_screen/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/apiClient/apiClient.dart';
import '../../singup_screen/singup_screen.dart';
import '../models/login_model.dart';

class LoginController extends GetxController {
  Rx<LoginModel> loginModelObj = LoginModel().obs;
  Rx<bool> isShowPassword = true.obs;
  bool isLoading = false;
  var otp = "";
  var signUpOtp = "";

  var secondsRemaining = 60;
  var enableResend = false;

  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController signUpMobilenumberController = TextEditingController();
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  sendOtp() async {
    // final isConnected = await ConnectivityService().checkConnectivity();
    // print(isConnected);
    // ConnectivityService().showConnectivityToast(context, isConnected);
    isLoading = true;
    update();
    await ApiClient.doLogin(
      mobilenumberController.text,
    ).then((value) {
      isLoading = false;
      update();
      if (value != null) {
        if (value["status"] == "1") {
          secondsRemaining = 60;
          enableResend = false;
          otpController.clear();
          isLoading = false;
          update();
          otp = value["otp"].toString();
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);
          Get.to(Otpscreen(
            phoneNumber: mobilenumberController.text,
            otpType: 'login',
          ));
        } else if (value["status"] == "2") {
          isLoading = false;
          update();
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);
          signUpMobilenumberController.text = mobilenumberController.text;

          Get.to(SingupScreen(
            mobileNumber: '',
          ));
        } else if (value["status"] == "0") {
          isLoading = false;
          update();
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        } else {
          isLoading = false;
          update();
        }
      }
    });
  }

  apnaverifyotp(var otp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    update();
    await ApiClient.doOTPVerify(mobilenumberController.text, otp).then((value) {
      isLoading = false;
      update();
      print("here---------->");
      print(value);
      if (value != null) {
        prefs.setString("token", value["Authorization"].toString());
        isLoading = false;
        update();
        prefs.setBool("isLogin", true);
        Get.offAll(DashboardScreen());
      } else {
        print("server error");
      }
    });
  }

  signUpSendOtp() async {
    isLoading = true;
    update();
    await ApiClient.signUpSendOtpData(
      signUpMobilenumberController.text,
    ).then((value) {
      isLoading = false;
      update();
      if (value != null) {
        if (value["status"] == "1") {
          secondsRemaining = 60;
          enableResend = false;
          signUpOtp = value["otp"].toString();
          print("test signup otp---------->");
          print(signUpOtp);
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);
        } else if (value["status"] == "0") {
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        }
      }
    });
  }

  signUpVerifyOtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    update();
    if (signUpOtp == otpController.text) {
      await ApiClient.signUpVerifyOtpData(
              signUpMobilenumberController.text, signUpNameController.text)
          .then((value) {
        isLoading = false;
        update();

        print(value);

        if (value != null) {
          print("---------------correct------------");
          isLoading = false;
          update();
          prefs.setBool("isLogin", true);
          prefs.setString("token", value["Authorization"].toString());
          print(prefs.getString("token"));
          Get.rawSnackbar(
              message: "You are Successfully Registered.",
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);

          Get.offAll(DashboardScreen());
        } else {
          print("server error");
        }
      });
    } else {
      print("---------------Incorrect------------");
      isLoading = false;
      update();

      Get.rawSnackbar(
          message: "please type correct otp.",
          duration: const Duration(seconds: 2),
          backgroundColor: ColorConstant.red500);
    }
  }
}
