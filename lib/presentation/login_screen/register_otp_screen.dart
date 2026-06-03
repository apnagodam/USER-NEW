import 'dart:async';

import 'package:anywhere_loader/provider/anywhere_loader_context_provider.dart';
import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/SmsStrategy.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/progress_dialog_utils.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';
import '../../database/Database.dart';
import '../home_screen/service/home_screen_service.dart';
import 'controller/login_controller.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class RegisterOtpScreen extends ConsumerStatefulWidget {
  final phoneNumber;
  final String otpType;
  String? userName = "";

  RegisterOtpScreen(
      {super.key,
      required this.phoneNumber,
      required this.otpType,
      this.userName});

  @override
  ConsumerState<RegisterOtpScreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends ConsumerState<RegisterOtpScreen> {
  var logincont = Get.put(LoginController());
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  late Timer timer;
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController signUpMobilenumberController = TextEditingController();
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var isOtpFilled = StateProvider((ref) => false);
  var otpProvider = StateProvider((ref) => "");
  var timeProvider = StateProvider((ref) => 20);
  late Timer _timer;
  String? otpCode;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) {
          if (ref.watch(timeProvider) == 0) {
            timer.cancel();
          } else {
            ref.watch(timeProvider.notifier).state =
                ref.watch(timeProvider) - 1;
          }
        },
      );
    });
    _otpInteractor = OTPInteractor();
    _otpInteractor
        .getAppSignature()
        .then((value) => print('signature - $value'));

    controller = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        print('Your Application receive code - $code');
        if (code.isNotEmpty) {
          otpController.text = code;
          setState(() {});
        }
      },
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [
          Smsstrategy(),
        ],
      );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 50.0,
              ),
              child: Image.asset(
                ImageConstant.mainlogopng,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.msgVerificationCode,
                style: TextStyle(
                  color: ColorConstant.grey,
                ),
              ),
              // widget.screenTag == "login"?
              Text(
                widget.phoneNumber,
                style: TextStyle(color: ColorConstant.grey),
              )
              // Text(
              //   cont.signUpMobilenumberController.text,
              //   style: TextStyle(color: ColorConstant.grey),
              // ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Pinput(
              controller: otpController,
              onCompleted: (pin) async {
                if (pin.length == 6) {
                  var token = '';

                  if (GetPlatform.isIOS) {
                    String? apnsToken =
                        await FirebaseMessaging.instance.getAPNSToken();
                    if (apnsToken == null) {
                      await Future.delayed(Duration(seconds: 2));
                      apnsToken =
                          await FirebaseMessaging.instance.getAPNSToken();
                    }
                    if (apnsToken != null) {
                      // Now safe to subscribe or get FCM token
                      await FirebaseMessaging.instance.subscribeToTopic('all');
                      token = await FirebaseMessaging.instance.getToken() ?? "";
                    }
                  } else {
                    token = await FirebaseMessaging.instance.getToken() ?? "";
                  }
                  ref
                      .watch(verifyOtpProvider(
                              num: widget.phoneNumber,
                              otp: pin,
                              fcmToken: token)
                          .future)
                      .then((value) async {
                    if (value.status.toString() == "1") {
                      ref
                          .watch(authProvider.notifier)
                          .login(value.authorization ?? "");
                      Get.offAll(DashboardScreen());
                      // ref
                      //     .watch(sharedUtilityProvider)
                      //     .setUser(value.userDetails!);
                    } else {
                      Fluttertoast.showToast(
                          msg: value.message.toString(),
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: ColorConstant.red500);
                    }
                  }).onError((e, s) {});
                }
              },
              onChanged: (value) async {
                if (value.length == 6) {
                  var token = '';

                  if (GetPlatform.isIOS) {
                    String? apnsToken =
                        await FirebaseMessaging.instance.getAPNSToken();
                    if (apnsToken == null) {
                      await Future.delayed(Duration(seconds: 2));
                      apnsToken =
                          await FirebaseMessaging.instance.getAPNSToken();
                    }
                    if (apnsToken != null) {
                      // Now safe to subscribe or get FCM token
                      await FirebaseMessaging.instance.subscribeToTopic('all');
                      token = await FirebaseMessaging.instance.getToken() ?? "";
                    }
                  } else {
                    token = await FirebaseMessaging.instance.getToken() ?? "";
                  }
                  ref
                      .watch(verifyOtpProvider(
                              num: widget.phoneNumber,
                              otp: value,
                              fcmToken: token)
                          .future)
                      .then((value) async {
                    if (value.status.toString() == "1") {
                      ref
                          .watch(authProvider.notifier)
                          .login(value.authorization ?? "");

                      Get.offAll(DashboardScreen());
                    } else {
                      Fluttertoast.showToast(
                          msg: value.message.toString(),
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: ColorConstant.red500);
                    }
                  }).onError((e, s) {});
                }
              },
              length: 6,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ref.watch(timeProvider) == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.msgReceiveCode,
                        style: AppStyle.lblforgotpassword),
                    TextButton(
                        onPressed: () {
                          controller = OTPTextEditController(
                            codeLength: 6,
                            onCodeReceive: (code) {
                              if (code.isNotEmpty) {
                                otpController.text = code;
                              }
                            },
                            otpInteractor: _otpInteractor,
                            onTimeOutException: () {
                              controller.startListenUserConsent(
                                (code) {
                                  final exp = RegExp(r'(\d{6})');
                                  return exp.stringMatch(code ?? '') ?? '';
                                },
                                strategies: [
                                  Smsstrategy(),
                                ],
                              );
                            },
                          )..startListenUserConsent(
                              (code) {
                                final exp = RegExp(r'(\d{6})');
                                return exp.stringMatch(code ?? '') ?? '';
                              },
                              strategies: [
                                Smsstrategy(),
                              ],
                            );
                          ref.watch(timeProvider.notifier).state = 20;
                          _timer = Timer.periodic(
                            Duration(seconds: 1),
                            (Timer timer) {
                              if (ref.watch(timeProvider) == 0) {
                                timer.cancel();
                              } else {
                                ref.watch(timeProvider.notifier).state =
                                    ref.watch(timeProvider) - 1;
                              }
                            },
                          );
                          ref
                              .watch(sendOtpV1Provider(
                                      number: mobilenumberController.text)
                                  .future)
                              .then((response) {
                            if (response.status.toString() == "1") {
                              Fluttertoast.showToast(
                                  msg: 'Otp Sent Successfully!',
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: ColorConstant.maingreen);
                            }
                          });
                        },
                        child: Text(
                          AppLocalizations.of(context)!.resend,
                          style: TextStyle(color: ColorConstant.maingreen),
                        ))
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.resendOtp,
                        style: AppStyle.lblforgotpassword),
                    SizedBox(
                      width: 5,
                    ),
                    Text("in ${ref.watch(timeProvider)}",
                        style: AppStyle.lblforgotpassword)
                  ],
                ),
          ref.watch(isOtpFilled) == true
              ? ElevatedButton(
                  onPressed: () async {
                    var token = '';

                    if (GetPlatform.isIOS) {
                      String? apnsToken =
                          await FirebaseMessaging.instance.getAPNSToken();
                      if (apnsToken == null) {
                        await Future.delayed(Duration(seconds: 2));
                        apnsToken =
                            await FirebaseMessaging.instance.getAPNSToken();
                      }
                      if (apnsToken != null) {
                        // Now safe to subscribe or get FCM token
                        await FirebaseMessaging.instance
                            .subscribeToTopic('all');
                        token =
                            await FirebaseMessaging.instance.getToken() ?? "";
                      }
                    } else {
                      token = await FirebaseMessaging.instance.getToken() ?? "";
                    }
                    ref
                        .watch(verifyOtpProvider(
                                num: widget.phoneNumber,
                                otp: ref.watch(otpProvider.notifier).state,
                                fcmToken: token)
                            .future)
                        .then((value) async {
                      if (value.status.toString() == "1") {
                        ref
                            .watch(authProvider.notifier)
                            .login(value.authorization ?? "");
                        Get.offAll(DashboardScreen());
                      } else {
                        Fluttertoast.showToast(
                            msg: value.message.toString(),
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: ColorConstant.red500);
                      }
                    }).onError((e, s) {});
                  },
                  style: AppStyle.buttonStyle,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white, fontSize: Adaptive.sp(16)),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {},
                  style: AppStyle.disabledButtonStyle,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white, fontSize: Adaptive.sp(16)),
                  ),
                )
        ],
      ),
    );
  }
}
