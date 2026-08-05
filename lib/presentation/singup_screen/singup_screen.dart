import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/extensions.dart';
import 'package:apnagodam/core/utils/progress_dialog_utils.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/login_screen/login_screen.dart';
import 'package:apnagodam/presentation/login_screen/register_otp_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/singup_screen/termandcon_webview.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:apnagodam/widgets/enums.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:elevarm_ui/elevarm_ui.dart';

import '../../core/utils/image_constant.dart';
import '../../routes/app_routes.dart';
import '../home_screen/service/home_screen_service.dart';
import '../login_screen/controller/login_controller.dart';
import '../login_screen/otp_screen.dart';
import 'package:html/dom.dart' as html;
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class SingupScreen extends ConsumerStatefulWidget {
  const SingupScreen({super.key, required this.mobileNumber});

  final String mobileNumber;
  @override
  ConsumerState<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends ConsumerState<SingupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController signUpMobilenumberController = TextEditingController();
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var logincont = Get.put(LoginController());
  var constitutionTypeProvider = StateProvider<ConstitutionType?>(
    (ref) => null,
  );

  var isAgreementChecked = StateProvider<bool?>((ref) => null);
  var loadingProgress = StateProvider<double>((ref) => 0.0);
  @override
  void initState() {
    super.initState();
    signUpMobilenumberController.text = widget.mobileNumber;
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
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
                    enabled: true,
                    isRequired: true,
                    controller: signUpNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
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
                    enabled: true,
                    isRequired: true,
                    maxLength: 10,
                    controller: signUpMobilenumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 10) {
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
                      SizedBox(height: 10),
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
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => Get.to(
                                            Webview(
                                              url:
                                                  "https://swlpl-next.onrender.com/terms",
                                            ),
                                          ),
                              ),
                              TextSpan(
                                text: " ${AppLocalizations.of(context)!.and} ",
                              ),
                              TextSpan(
                                text:
                                    " ${AppLocalizations.of(context)!.privecy}",
                                style: AppStyle.lbltermncon.copyWith(
                                  fontSize: Adaptive.sp(16),
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => Get.to(
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
                 onPressed: () async {
  if (ref.read(constitutionTypeProvider) == null) {
    Fluttertoast.showToast(
      msg: AppLocalizations.of(context)!.pleaseSelectConstitution,
      toastLength: Toast.LENGTH_LONG,
    );
    return;
  }

  if (!_formkey.currentState!.validate()) return;

  if (signUpMobilenumberController.text.length != 10) return;

  otpController.clear();

  try {
    // ✅ Use ref.read() — NOT ref.watch() — for one-time calls
    final value = await ref.read(
      signUpUserProvider(
        number: signUpMobilenumberController.text,
        userName: signUpNameController.text,
        constitutionType: "${ref.read(constitutionTypeProvider)?.type}",
      ).future,
    );

  if (value['status'].toString() == "1") {
  final token = value['Authorization'].toString(); // ← note capital 'A'

  // ✅ Step 1: Save token to SharedPreferences FIRST
  await ref.read(sharedPreferencesProvider).setString("token", token);
  
  // ✅ Step 2: Save to your utility
  ref.read(sharedUtilityProvider).setToken(token);

  // ✅ Step 3: NOW invalidate so Dio rebuilds WITH the saved token
  ref.invalidate(dioProvider);

  // ✅ Step 4: Wait for Dio to rebuild
  await Future.delayed(const Duration(milliseconds: 300));

  // ✅ Step 5: Then send OTP
  try {
    final response = await ref.read(
      sendOtpV1Provider(number: signUpMobilenumberController.text).future,
    );
    if (response.status.toString() == "1") {
      Fluttertoast.showToast(
        msg: response.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  } catch (_) {}

  Get.to(RegisterOtpScreen(
    phoneNumber: signUpMobilenumberController.text,
    otpType: 'register',
    userName: signUpNameController.text,
  ));
    } else {
      // ✅ Only show error when status != 1
      Fluttertoast.showToast(
        msg: value['message'].toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Something went wrong. Please try again.",
      toastLength: Toast.LENGTH_LONG,
    );
  }
},
                      child: Text(
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
                          style: TextStyle(
                            fontSize: Adaptive.sp(16),
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
