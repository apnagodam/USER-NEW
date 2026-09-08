import 'dart:async';

import 'package:anywhere_loader/provider/anywhere_loader_context_provider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/extensions.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/language/language.dart';
import 'package:apnagodam/presentation/login_screen/models/CheckUserModel.dart';
import 'package:apnagodam/presentation/login_screen/otp_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:apnagodam/presentation/singup_screen/termandcon_webview.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils/image_constant.dart';
import '../singup_screen/singup_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController mobilenumberController = TextEditingController();

  CheckUserData? _selectedUser;
  List<CheckUserData> _userList = [];
  bool _isCheckingUser = false;
  bool _isSendingOtp = false;
  String? _checkUserErrorMessage;
  String _lastCheckedNumber = '';

  @override
  void initState() {
    super.initState();
    mobilenumberController.addListener(_onMobileNumberChanged);
  }

  @override
  void dispose() {
    mobilenumberController.removeListener(_onMobileNumberChanged);
    mobilenumberController.dispose();
    super.dispose();
  }

  void _onMobileNumberChanged() {
    final text = mobilenumberController.text.trim();
    if (text.length == 10) {
      FocusScope.of(context).unfocus();
      if (text != _lastCheckedNumber) {
        _checkUserAccounts(text);
      }
    } else if (text.length < 10) {
      if (_userList.isNotEmpty ||
          _selectedUser != null ||
          _checkUserErrorMessage != null) {
        setState(() {
          _userList = [];
          _selectedUser = null;
          _checkUserErrorMessage = null;
          _lastCheckedNumber = '';
        });
      }
    }
  }

  Future<void> _checkUserAccounts(String number) async {
    setState(() {
      _isCheckingUser = true;
      _checkUserErrorMessage = null;
      _lastCheckedNumber = number;
    });

    try {
      final response = await ref.read(checkUserProvider(number: number).future);
      if (!mounted) return;
      if (response.status.toString() == "1" &&
          (response.data?.isNotEmpty ?? false)) {
        setState(() {
          _userList = response.data!;
          _selectedUser = _userList.first;
          _checkUserErrorMessage = null;
          _isCheckingUser = false;
        });
      } else {
        setState(() {
          _userList = [];
          _selectedUser = null;
          _checkUserErrorMessage =
              response.message ?? 'This Number Not Registered with us';
          _isCheckingUser = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _userList = [];
        _selectedUser = null;
        _checkUserErrorMessage = 'Error checking user account';
        _isCheckingUser = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return AnyWhereLoaderContextProvider(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                const SizedBox(height: 8),
                // Top Action Bar (Back button, Help button, Language switcher)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (canPop)
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black87,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    else
                      const SizedBox(width: 20),
                    Row(
                      children: [
                        // Help / Support Button
                        InkWell(
                          onTap: _showHelpDialog,
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.08),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgHelp,
                                  style: AppStyle.lblontestimonalname.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.headset_mic_rounded,
                                  size: 18,
                                  color: ColorConstant.maingreen,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Language Switcher
                        InkWell(
                          onTap: () => Get.to(() => LanguageScreen()),
                          child: SizedBox(
                            width: 80,
                            height: 40,
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Image.asset(
                                  'assets/images/bg_icon_english.PNG',
                                  width: 40,
                                ),
                                Positioned(
                                  left: 24,
                                  child: Image.asset(
                                    'assets/images/bg_icon_hindi.PNG',
                                    fit: BoxFit.contain,
                                    width: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Welcome Illustration
                Center(
                  child: Image.asset(
                    ImageConstant.imgwellcome,
                    width: MediaQuery.of(context).size.width * 0.55,
                  ),
                ),
                const SizedBox(height: 10),
                // Title
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.msgLoging,
                    style: AppStyle.lblloging.copyWith(
                      fontSize: Adaptive.sp(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.pleaseInputYourMobileNumber,
                    style: TextStyle(
                      fontSize: Adaptive.sp(14),
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Mobile Number Input Form
                Form(
                  key: _formkey,
                  child: ElevarmTextInputField(
                    label: AppLocalizations.of(context)!.mobileNumber,
                    hintText:
                        AppLocalizations.of(context)!.pleaseInputYourMobileNumber,
                    suffixIconAssetName: Icons.mobile_friendly,
                    onTapSuffix: null,
                    errorText: null,
                    enabled: !_isSendingOtp,
                    isRequired: true,
                    maxLength: 10,
                    controller: mobilenumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
                        return AppLocalizations.of(context)!.messageValidation;
                      }
                      if (!value.isValidMobileNumber()) {
                        return 'please input valid mobile number';
                      }
                      return null;
                    },
                  ),
                ),
                // Checking accounts loading indicator
                if (_isCheckingUser) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.maingreen.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ColorConstant.maingreen,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Checking registered accounts...',
                          style: TextStyle(
                            fontSize: 13,
                            color: ColorConstant.maingreen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                // Selectable Account Cards List
                if (_userList.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Account',
                        style: TextStyle(
                          fontSize: Adaptive.sp(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.maingreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_userList.length} Accounts',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.maingreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _userList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final user = _userList[index];
                      final isSelected = _selectedUser?.userId.toString() ==
                          user.userId.toString();

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedUser = user;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorConstant.maingreen.withOpacity(0.06)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? ColorConstant.maingreen
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? ColorConstant.maingreen.withOpacity(0.12)
                                    : Colors.black.withOpacity(0.04),
                                blurRadius: isSelected ? 8 : 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Avatar circle
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? ColorConstant.maingreen.withOpacity(0.15)
                                      : Colors.grey.shade100,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: isSelected
                                        ? ColorConstant.maingreen
                                        : Colors.grey.shade600,
                                    size: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Name, Phone & User ID
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name ?? '',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? ColorConstant.maingreen
                                            : Colors.black87,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone_iphone_rounded,
                                          size: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          user.phone ?? '',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 1,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? ColorConstant.maingreen
                                                    .withOpacity(0.12)
                                                : Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'ID: ${user.userId}',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: isSelected
                                                  ? ColorConstant.maingreen
                                                  : Colors.grey.shade700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Radio selection icon
                              Icon(
                                isSelected
                                    ? Icons.check_circle_rounded
                                    : Icons.radio_button_unchecked_rounded,
                                color: isSelected
                                    ? ColorConstant.maingreen
                                    : Colors.grey.shade400,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
                // Error / Unregistered banner
                if (_checkUserErrorMessage != null && _userList.isEmpty) ...[
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.red500.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ColorConstant.red500.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: ColorConstant.red500,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _checkUserErrorMessage!,
                                style: TextStyle(
                                  color: ColorConstant.red500,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => SingupScreen(
                                mobileNumber:
                                    mobilenumberController.text.trim(),
                              ),
                            );
                          },
                          child: Text(
                            "New to Apna Godam? Click here to Register ->",
                            style: TextStyle(
                              color: ColorConstant.maingreen,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                // Send OTP Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: AppStyle.buttonStyle,
                    onPressed: (_isSendingOtp || _isCheckingUser)
                        ? null
                        : _handleSendOtp,
                    child: _isSendingOtp
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)!.sendOtp,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.mainwhite,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                // Sign Up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.msgDontHaveAn,
                      style: AppStyle.lblforgotpassword.copyWith(
                        fontSize: Adaptive.sp(15),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(
                          () => SingupScreen(
                            mobileNumber: mobilenumberController.text.trim(),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.msgSignup,
                        style: TextStyle(
                          fontSize: Adaptive.sp(15),
                          color: ColorConstant.maingreen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.connect,
                    style: AppStyle.lblalltextfromfields.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: Adaptive.sp(15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => Webview(
                              url: "https://www.facebook.com/apnagodam/",
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/facebook.png',
                          width: 40,
                          color: ColorConstant.maingreen,
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => Webview(
                              url: "https://in.linkedin.com/company/apnagodam",
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/linkedin.png',
                          width: 40,
                          color: ColorConstant.maingreen,
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => Webview(
                              url:
                                  "https://www.youtube.com/channel/UCbTi5MXhy2l7WcmBBPPnwWw",
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/youtube.png',
                          width: 40,
                          color: ColorConstant.maingreen,
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => Webview(
                              url: "https://www.instagram.com/apnagodam/",
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/instagram.png',
                          width: 40,
                          color: ColorConstant.maingreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Future<void> _handleSendOtp() async {
    if (!_formkey.currentState!.validate()) return;
    final number = mobilenumberController.text.trim();
    if (number.length != 10) return;

    if (_userList.isEmpty && _checkUserErrorMessage == null) {
      await _checkUserAccounts(number);
    }

    if (_userList.isEmpty || _selectedUser == null) {
      Fluttertoast.showToast(
        msg: _checkUserErrorMessage ?? "Please register to continue",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: ColorConstant.red500,
      );
      Get.to(
        () => SingupScreen(
          mobileNumber: number,
        ),
      );
      return;
    }

    setState(() {
      _isSendingOtp = true;
    });

    try {
      String token = '';
      try {
        if (GetPlatform.isIOS) {
          String? apnsToken =
              await FirebaseMessaging.instance.getAPNSToken();
          if (apnsToken == null) {
            await Future.delayed(
              const Duration(seconds: 2),
            );
            apnsToken = await FirebaseMessaging.instance.getAPNSToken();
          }
          if (apnsToken != null) {
            await FirebaseMessaging.instance.subscribeToTopic('all');
            token = await FirebaseMessaging.instance.getToken() ?? "";
          }
        } else {
          token = await FirebaseMessaging.instance.getToken() ?? "";
        }
      } catch (_) {}

      final response = await ref.read(
        userSendOtpProvider(
          userId: _selectedUser!.userId.toString(),
          fcmToken: token,
        ).future,
      );

      if (!mounted) return;
      setState(() {
        _isSendingOtp = false;
      });

      if (response.status.toString() == "1") {
        Fluttertoast.showToast(
          msg: response.message ?? "OTP Send successfully",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: ColorConstant.maingreen,
        );
        Get.to(
          () => Otpscreen(
            phoneNumber: number,
            otpType: 'login',
            userId: _selectedUser!.userId.toString(),
            userName: _selectedUser!.name,
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: response.message ?? "Failed to send OTP",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: ColorConstant.red500,
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSendingOtp = false;
      });
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: ColorConstant.red500,
      );
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          titlePadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          iconPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          title: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorConstant.maingreen,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.support_agent_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.msgHelp,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: Adaptive.sp(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                onTap: () async {
                  _launchUrl(
                    'whatsapp://send?text=Hello%20Apna%20Godam%20Support&phone=917733901154',
                  );
                },
                leading: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xfffcf2f0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      ImageConstant.imgwhatsapp,
                      width: 20,
                    ),
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context)!.msgWhatsapp,
                  style: TextStyle(
                    color: ColorConstant.black900,
                    fontSize: Adaptive.sp(15),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              Divider(color: Colors.grey.shade200, height: 1),
              ListTile(
                onTap: () {
                  _launchUrl('tel:7733901154');
                },
                leading: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xfffcf2f0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.phone,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context)!.msgCallforHelp,
                  style: TextStyle(
                    color: ColorConstant.black900,
                    fontSize: Adaptive.sp(15),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint("Error launching url: $e");
    }
  }
}
