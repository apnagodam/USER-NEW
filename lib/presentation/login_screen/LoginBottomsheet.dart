import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/extensions.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/login_screen/otp_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:apnagodam/presentation/singup_screen/singup_screen.dart';
import 'package:apnagodam/widgets/PhoneNumberService.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Fetch user's phone number
    _fetchPhoneNumber();
  }

  Future<void> _fetchPhoneNumber() async {
    try {
      String? phoneNumber = await PhoneNumberService.getPhoneNumber();
      if (phoneNumber != null && mounted) {
        setState(() {
          mobilenumberController.text = phoneNumber;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(_isOtpSent)
        ? SizedBox(
            height: Get.height * 0.7,
            child: Otpscreen(
              phoneNumber: mobilenumberController.text,
              otpType: 'login',
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
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
                  enabled: !_isLoading,
                  isRequired: true,
                  maxLength: 10,
                  controller: mobilenumberController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 10) {
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
                height: 48,
                child: ElevatedButton(
                  style: AppStyle.buttonStyle,
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (_formkey.currentState!.validate()) {
                            if (mobilenumberController.text.length == 10) {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                final response = await ref.read(
                                  sendOtpV1Provider(
                                    number: mobilenumberController.text,
                                  ).future,
                                );
                                if (!mounted) return;
                                setState(() {
                                  _isLoading = false;
                                });
                                if (response.status.toString() == "1") {
                                  ref.read(_isOtpSent.notifier).state = true;
                                } else if (response.status.toString() == "2") {
                                  Get.back();
                                  Get.to(
                                    () => SingupScreen(
                                      mobileNumber:
                                          mobilenumberController.text,
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: response.message ??
                                        'Something went wrong',
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                                Fluttertoast.showToast(
                                    msg: 'Failed to send OTP');
                              }
                            }
                          }
                        },
                  child: _isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
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
                Navigator.of(context).pop();
                Get.to(
                  () => SingupScreen(mobileNumber: mobilenumberController.text),
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
