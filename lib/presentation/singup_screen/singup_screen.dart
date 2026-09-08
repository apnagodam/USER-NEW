import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/extensions.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/login_screen/register_otp_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/singup_screen/termandcon_webview.dart';
import 'package:apnagodam/widgets/enums.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/image_constant.dart';
import '../../routes/app_routes.dart';
import '../login_screen/controller/login_controller.dart';
import 'package:apnagodam/l10n/app_localizations.dart';


class SingupScreen extends ConsumerStatefulWidget {
  const SingupScreen({super.key, required this.mobileNumber});

  final String mobileNumber;
  @override
  ConsumerState<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends ConsumerState<SingupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController mobilenumberController = TextEditingController();
  final TextEditingController signUpMobilenumberController =
      TextEditingController();
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  var logincont = Get.put(LoginController());
  var constitutionTypeProvider = StateProvider<ConstitutionType?>(
    (ref) => null,
  );
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    signUpMobilenumberController.text = widget.mobileNumber;
  }

  @override
  void dispose() {
    mobilenumberController.dispose();
    signUpMobilenumberController.dispose();
    signUpNameController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Navigator.canPop(context))
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black87,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                      child: Image.asset(
                        ImageConstant.imgwellcome,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.msgSignup,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Adaptive.sp(21),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevarmDropdownInputField<ConstitutionType>(
                    label: AppLocalizations.of(context)!.selectConstitution3,
                    hintText: AppLocalizations.of(context)!.selectConstitution3,
                    onChanged: (value) {
                      ref.watch(constitutionTypeProvider.notifier).state =
                          value;
                    },
                    options: List.generate(
                      ConstitutionType.values.length,
                      (index) => ElevarmDropdownInputFieldOption(
                        title: ConstitutionType.values[index].label,
                        subtitle: '',
                        value: ConstitutionType.values[index],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevarmTextInputField(
                    label:
                        ref.watch(constitutionTypeProvider) ==
                                ConstitutionType.individual
                            ? AppLocalizations.of(context)!.enterYourName
                            : AppLocalizations.of(context)!.enterCompanyName2,
                    hintText:
                        ref.watch(constitutionTypeProvider) ==
                                ConstitutionType.individual
                            ? AppLocalizations.of(context)!.enterYourName
                            : AppLocalizations.of(context)!.enterCompanyName2,
                    suffixIconAssetName: Icons.person,
                    onTapSuffix: null,
                    errorText: null,
                    enabled: !_isLoading,
                    isRequired: true,
                    controller: signUpNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return ref.watch(constitutionTypeProvider) ==
                                ConstitutionType.individual
                            ? AppLocalizations.of(context)!.enterYourName
                            : AppLocalizations.of(context)!.enterCompanyName2;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevarmTextInputField(
                    label:
                        ref.watch(constitutionTypeProvider) ==
                                ConstitutionType.individual
                            ? AppLocalizations.of(
                                context,
                              )!.enterYourMobileNumber
                            : AppLocalizations.of(context)!.enterCompanyNumber2,
                    hintText:
                        ref.watch(constitutionTypeProvider) ==
                                ConstitutionType.individual
                            ? AppLocalizations.of(
                                context,
                              )!.enterYourMobileNumber
                            : AppLocalizations.of(context)!.enterCompanyNumber2,
                    suffixIconAssetName: Icons.mobile_friendly,
                    onTapSuffix: null,
                    errorText: null,
                    enabled: !_isLoading,
                    isRequired: true,
                    maxLength: 10,
                    controller: signUpMobilenumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return AppLocalizations.of(context)!.messageValidation;
                      }
                      if (!value.isValidMobileNumber()) {
                        return AppLocalizations.of(
                          context,
                        )!.pleaseInputValidMobileNumber;
                      }
                      return null;
                    },
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                        child: Text.rich(
                          TextSpan(
                            text: AppLocalizations.of(context)!.msgByContinuing,
                            children: [
                              TextSpan(
                                text:
                                    " ${AppLocalizations.of(context)!.msgTermAnd}",
                                style: AppStyle.lbltermncon.copyWith(
                                  fontSize: Adaptive.sp(16),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(
                                        Webview(
                                          url:
                                              "https://swlpl-next.onrender.com/terms",
                                        ),
                                      ),
                              ),
                              TextSpan(
                                text:
                                    " ${AppLocalizations.of(context)!.and} ",
                              ),
                              TextSpan(
                                text:
                                    " ${AppLocalizations.of(context)!.privecy}",
                                style: AppStyle.lbltermncon.copyWith(
                                  fontSize: Adaptive.sp(16),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(
                                        Webview(
                                          url:
                                              "https://swlpl-next.onrender.com/terms",
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            color: ColorConstant.black900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: AppStyle.buttonStyle,
                      onPressed: _isLoading
                          ? null
                          : () async {
                              if (ref.read(constitutionTypeProvider) == null) {
                                Fluttertoast.showToast(
                                  msg: AppLocalizations.of(context)!
                                      .pleaseSelectConstitution,
                                  toastLength: Toast.LENGTH_LONG,
                                );
                                return;
                              }

                              if (!_formkey.currentState!.validate()) return;

                              if (signUpMobilenumberController.text.length !=
                                  10) {
                                return;
                              }

                              otpController.clear();
                              setState(() {
                                _isLoading = true;
                              });

                              try {
                                String token = '';
                                try {
                                  if (GetPlatform.isIOS) {
                                    String? apnsToken = await FirebaseMessaging
                                        .instance
                                        .getAPNSToken();
                                    if (apnsToken == null) {
                                      await Future.delayed(
                                        const Duration(seconds: 2),
                                      );
                                      apnsToken = await FirebaseMessaging
                                          .instance
                                          .getAPNSToken();
                                    }
                                    if (apnsToken != null) {
                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('all');
                                      token = await FirebaseMessaging.instance
                                              .getToken() ??
                                          "";
                                    }
                                  } else {
                                    token = await FirebaseMessaging.instance
                                            .getToken() ??
                                        "";
                                  }
                                } catch (_) {}

                                final value = await ref.read(
                                  userRegisterProvider(
                                    number: signUpMobilenumberController.text,
                                    userName: signUpNameController.text,
                                    fcmToken: token,
                                    constitutionType:
                                        ref.read(constitutionTypeProvider)?.type ??
                                            1,
                                  ).future,
                                );


                                if (!mounted) return;
                                setState(() {
                                  _isLoading = false;
                                });

                                if (value.status.toString() == "1") {
                                  final userId = value.userId.toString();
                                  final authHeader =
                                      value.authorization?.toString() ?? "";

                                  if (authHeader.isNotEmpty) {
                                    await ref
                                        .read(sharedPreferencesProvider)
                                        .setString("token", authHeader);
                                    ref
                                        .read(sharedUtilityProvider)
                                        .setToken(authHeader);
                                    ref.invalidate(dioProvider);
                                    await Future.delayed(
                                      const Duration(milliseconds: 300),
                                    );
                                  }

                                  // Send OTP
                                  try {
                                    final response = await ref.read(
                                      userSendOtpProvider(
                                        userId: userId,
                                        fcmToken: token,
                                      ).future,
                                    );
                                    if (response.status.toString() == "1") {
                                      Fluttertoast.showToast(
                                        msg: response.message ??
                                            "OTP Send successfully",
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor:
                                            ColorConstant.maingreen,
                                      );
                                    }
                                  } catch (_) {}

                                  Get.to(
                                    () => RegisterOtpScreen(
                                      phoneNumber:
                                          signUpMobilenumberController.text,
                                      otpType: 'register',
                                      userName: signUpNameController.text,
                                      userId: userId,
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: value.message?.toString() ??
                                        "Registration failed",
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: ColorConstant.red500,
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                                debugPrint("Registration error: $e");
                                Fluttertoast.showToast(
                                  msg:
                                      "Something went wrong. Please try again.",
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: ColorConstant.red500,
                                );
                              }
                            },
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!.msgSignup,
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
                        AppLocalizations.of(context)!.msgAlreadyHaveAn,
                        style: AppStyle.lblforgotpassword.copyWith(
                          fontSize: Adaptive.sp(16),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          mobilenumberController.clear();
                          Get.toNamed(AppRoutes.loginScreen);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.msgLoging,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff53B175),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
