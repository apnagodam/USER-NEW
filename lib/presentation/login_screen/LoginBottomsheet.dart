import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/extensions.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/login_screen/models/CheckUserModel.dart';
import 'package:apnagodam/presentation/login_screen/otp_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:apnagodam/presentation/singup_screen/singup_screen.dart';
import 'package:apnagodam/widgets/PhoneNumberService.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  final TextEditingController mobilenumberController = TextEditingController();
  final TextEditingController signUpMobilenumberController =
      TextEditingController();
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final _isOtpSent = StateProvider<bool>((ref) => false);
  bool _isLoading = false;

  CheckUserData? _selectedUser;
  List<CheckUserData> _userList = [];
  bool _isCheckingUser = false;
  String? _checkUserErrorMessage;
  String _lastCheckedNumber = '';

  @override
  void initState() {
    super.initState();
    mobilenumberController.addListener(_onMobileNumberChanged);
    _fetchPhoneNumber();
  }

  @override
  void dispose() {
    mobilenumberController.removeListener(_onMobileNumberChanged);
    mobilenumberController.dispose();
    signUpMobilenumberController.dispose();
    signUpNameController.dispose();
    otpController.dispose();
    super.dispose();
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

  void _onMobileNumberChanged() {
    final text = mobilenumberController.text.trim();
    if (text.length == 10 && text != _lastCheckedNumber) {
      _checkUserAccounts(text);
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
    return ref.watch(_isOtpSent)
        ? SizedBox(
            height: Get.height * 0.7,
            child: Otpscreen(
              phoneNumber: mobilenumberController.text,
              otpType: 'login',
              userId: _selectedUser?.userId?.toString(),
              userName: _selectedUser?.name,
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
              if (_isCheckingUser) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorConstant.maingreen,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Checking registered accounts...',
                      style: TextStyle(
                        fontSize: 13,
                        color: ColorConstant.grey,
                      ),
                    ),
                  ],
                ),
              ],
              if (_userList.isNotEmpty) ...[
                const SizedBox(height: 15),
                ElevarmDropdownInputField<CheckUserData>(
                  label: 'Select Account',
                  hintText: 'Select Account',
                  initialValue: _selectedUser,
                  onChanged: (value) {
                    setState(() {
                      _selectedUser = value;
                    });
                  },
                  options: _userList
                      .map(
                        (user) => ElevarmDropdownInputFieldOption<CheckUserData>(
                          title: user.name ?? '',
                          subtitle: user.phone ?? '',
                          value: user,
                        ),
                      )
                      .toList(),
                ),
              ],
              if (_checkUserErrorMessage != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstant.red500.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ColorConstant.red500.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: ColorConstant.red500,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _checkUserErrorMessage!,
                          style: TextStyle(
                            color: ColorConstant.red500,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: AppStyle.buttonStyle,
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (!_formkey.currentState!.validate()) return;
                          final number = mobilenumberController.text.trim();
                          if (number.length != 10) return;

                          if (_userList.isEmpty &&
                              _checkUserErrorMessage == null) {
                            await _checkUserAccounts(number);
                          }

                          if (_userList.isEmpty || _selectedUser == null) {
                            Fluttertoast.showToast(
                              msg: _checkUserErrorMessage ??
                                  "Please register to continue",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: ColorConstant.red500,
                            );
                            Get.back();
                            Get.to(
                              () => SingupScreen(
                                mobileNumber: number,
                              ),
                            );
                            return;
                          }

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

                            final response = await ref.read(
                              userSendOtpProvider(
                                userId: _selectedUser!.userId.toString(),
                                fcmToken: token,
                              ).future,
                            );

                            if (!mounted) return;
                            setState(() {
                              _isLoading = false;
                            });

                            if (response.status.toString() == "1") {
                              ref.read(_isOtpSent.notifier).state = true;
                            } else {
                              Fluttertoast.showToast(
                                msg: response.message ??
                                    'Failed to send OTP',
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
                            Fluttertoast.showToast(
                              msg: 'Failed to send OTP',
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: ColorConstant.red500,
                            );
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
                        () => SingupScreen(
                          mobileNumber: mobilenumberController.text,
                        ),
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
