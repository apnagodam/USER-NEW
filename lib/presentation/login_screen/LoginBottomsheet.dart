import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/extensions.dart';
import 'package:apnagodam/core/utils/image_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/language/language.dart';
import 'package:apnagodam/presentation/login_screen/otp_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:apnagodam/presentation/singup_screen/singup_screen.dart';
import 'package:apnagodam/presentation/singup_screen/termandcon_webview.dart';
import 'package:apnagodam/widgets/PhoneNumberService.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class LoginBottomSheet extends ConsumerStatefulWidget {
  const LoginBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginBottomSheetState();
}

class _LoginBottomSheetState extends ConsumerState<LoginBottomSheet> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController signUpMobilenumberController = TextEditingController();
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final _isOtpSent = StateProvider<bool>((ref) => false);

  @override
  void initState() {
    super.initState();

    // Fetch user's phone number
    _fetchPhoneNumber();
  }

  Future<void> _fetchPhoneNumber() async {
    String? phoneNumber = await PhoneNumberService.getPhoneNumber();
    if (phoneNumber != null) {
      setState(() {
        mobilenumberController.text = phoneNumber; // Update the phone number
      });
      print("User's phone number: $phoneNumber");
    } else {
      print("Unable to fetch phone number.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(_isOtpSent)
        ? SizedBox(
          height: Get.height,
          child: Otpscreen(
            phoneNumber: mobilenumberController.text,
            otpType: 'login',
          ),
        )
        : Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  AppLocalizations.of(context)!.msgLoging,
                  style: AppStyle.lblloging.copyWith(
                    fontSize: Adaptive.sp(21),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 10),
            Form(
              key: _formkey,
              child: ElevarmTextInputField(
                label: AppLocalizations.of(context)!.mobileNumber,
                hintText:
                    AppLocalizations.of(context)!.pleaseInputYourMobileNumber,
                suffixIconAssetName: Icons.mobile_friendly,
                onTapSuffix: null,
                errorText: null,
                enabled: true,
                isRequired: true,
                maxLength: 10,
                controller: mobilenumberController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return AppLocalizations.of(context)!.messageValidation;
                  }
                  if (!value.isValidMobileNumber()) {
                    return AppLocalizations.of(
                      context,
                    )!.pleaseInputYourMobileNumber;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: AppStyle.buttonStyle,
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    if (mobilenumberController.text.length == 10) {
                      ref
                          .watch(
                            sendOtpV1Provider(
                              number: mobilenumberController.text,
                            ).future,
                          )
                          .then((response) {
                            if (response.status.toString() == "1") {
                              ref.watch(_isOtpSent.notifier).state = true;
                              // Get.to(Otpscreen(
                              //   phoneNumber: mobilenumberController.text,
                              //   otpType: 'login',
                              // ));
                            } else if (response.status.toString() == "2") {
                              Get.to(
                                SingupScreen(
                                  mobileNumber: mobilenumberController.text,
                                ),
                              );
                            }
                          });
                    }
                  }
                  // }
                },
                child: Text(
                  AppLocalizations.of(context)!.sendOtp,
                  style: TextStyle(
                    fontSize: Adaptive.sp(16),
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.mainwhite,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.msgDontHaveAn,
                  style: AppStyle.lblforgotpassword.copyWith(
                    fontSize: Adaptive.sp(16),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(
                      SingupScreen(mobileNumber: mobilenumberController.text),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.msgSignup,
                    style: TextStyle(
                      fontSize: Adaptive.sp(16),
                      color: ColorConstant.maingreen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
  }
}
