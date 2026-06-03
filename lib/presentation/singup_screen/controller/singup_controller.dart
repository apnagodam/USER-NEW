import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SingupController extends GetxController {
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  var otp = "";

  @override
  void onInit() {
    // usernameController.text = 'Samar2';
    // passwordController.text = '123456';
    super.onInit();
  }

  // sendOtpsignup() async {
  //   isLoading = true;
  //   update();
  //   await ApiClient.doSignUpOTPVerify(mobilenumberController.text,nameController.text).then((value) {
  //     isLoading = false;
  //     update();
  //     print("here---------->");
  //     print(value);
  //     if (value != null) {
  //       isLoading = false;
  //       update();
  //       Get.to(Otpscreen(screenTag: "signup",));
  //     }else{
  //       print("server error");
  //     }
  //   });
  // }

  onInClick(context) async {}

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    mobilenumberController.dispose();
  }
}
