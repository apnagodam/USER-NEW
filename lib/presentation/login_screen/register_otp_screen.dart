import 'dart:async';

import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/SmsStrategy.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';

import '../../core/utils/image_constant.dart';
import 'controller/login_controller.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class RegisterOtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String otpType;
  final String? userName;
  final String? userId;

  const RegisterOtpScreen({
    super.key,
    required this.phoneNumber,
    required this.otpType,
    this.userName,
    this.userId,
  });

  @override
  ConsumerState<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends ConsumerState<RegisterOtpScreen> {
  var logincont = Get.put(LoginController());
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  TextEditingController otpController = TextEditingController();
  var timeProvider = StateProvider((ref) => 20);
  late Timer _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
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
    _timer.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.msgVerificationCode,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  ImageConstant.mainlogopng,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.msgVerificationCode,
                style: TextStyle(color: ColorConstant.grey),
              ),
              const SizedBox(width: 4),
              Text(
                widget.phoneNumber,
                style: TextStyle(color: ColorConstant.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Pinput(
              controller: otpController,
              onCompleted: (pin) async {
                if (pin.length == 6) {
                  await _verifyOtp(pin);
                }
              },
              onChanged: (value) async {
                if (value.length == 6) {
                  await _verifyOtp(value);
                }
              },
              length: 6,
            ),
          ),
          if (_isVerifying) ...[
            const SizedBox(height: 15),
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: ColorConstant.maingreen,
                strokeWidth: 2.5,
              ),
            ),
          ],
          const SizedBox(height: 20),
          ref.watch(timeProvider) == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.msgReceiveCode,
                      style: AppStyle.lblforgotpassword,
                    ),
                    TextButton(
                      onPressed: _resendOtp,
                      child: Text(
                        AppLocalizations.of(context)!.resend,
                        style: TextStyle(color: ColorConstant.maingreen),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.resendOtp,
                      style: AppStyle.lblforgotpassword,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "in ${ref.watch(timeProvider)}",
                      style: AppStyle.lblforgotpassword,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verifyOtp(String otp) async {
    if (_isVerifying) return;
    setState(() {
      _isVerifying = true;
    });

    var token = '';
    try {
      if (GetPlatform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken == null) {
          await Future.delayed(const Duration(seconds: 2));
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

    if (widget.userId != null && widget.userId!.isNotEmpty) {
      try {
        final value = await ref.read(
          userVerifyOtpProvider(
            userId: widget.userId!,
            otp: otp,
            fcmToken: token,
          ).future,
        );

        if (!mounted) return;
        setState(() {
          _isVerifying = false;
        });

        if (value.status.toString() == "1") {
          await ref
              .read(authProvider.notifier)
              .login(value.authorization ?? "");
          Get.offAll(() => const DashboardScreen());
        } else {
          Fluttertoast.showToast(
            msg: value.message?.toString() ?? "OTP verification failed",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: ColorConstant.red500,
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isVerifying = false;
          });
        }
        debugPrint("Error verifying OTP: $e");
        Fluttertoast.showToast(
          msg: "Invalid OTP or error verifying OTP",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: ColorConstant.red500,
        );
      }
    } else {
      try {
        final value = await ref.read(
          verifyOtpProvider(
            num: widget.phoneNumber,
            otp: otp,
            fcmToken: token,
          ).future,
        );

        if (!mounted) return;
        setState(() {
          _isVerifying = false;
        });

        if (value.status.toString() == "1") {
          await ref
              .read(authProvider.notifier)
              .login(value.authorization ?? "");
          Get.offAll(() => const DashboardScreen());
        } else {
          Fluttertoast.showToast(
            msg: value.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: ColorConstant.red500,
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isVerifying = false;
          });
        }
        debugPrint("Error verifying OTP: $e");
      }
    }
  }

  void _resendOtp() {
    ref.watch(timeProvider.notifier).state = 20;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (ref.watch(timeProvider) == 0) {
          timer.cancel();
        } else {
          ref.watch(timeProvider.notifier).state =
              ref.watch(timeProvider) - 1;
        }
      },
    );

    if (widget.userId != null && widget.userId!.isNotEmpty) {
      () async {
        var token = '';
        try {
          if (GetPlatform.isIOS) {
            String? apnsToken =
                await FirebaseMessaging.instance.getAPNSToken();
            if (apnsToken != null) {
              token = await FirebaseMessaging.instance.getToken() ?? "";
            }
          } else {
            token = await FirebaseMessaging.instance.getToken() ?? "";
          }
        } catch (_) {}

        try {
          final response = await ref.read(
            userSendOtpProvider(
              userId: widget.userId!,
              fcmToken: token,
            ).future,
          );
          if (response.status.toString() == "1") {
            Fluttertoast.showToast(
              msg: response.message ?? 'Otp Sent Successfully!',
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: ColorConstant.maingreen,
            );
          } else {
            Fluttertoast.showToast(
              msg: response.message ?? 'Failed to send OTP',
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: ColorConstant.red500,
            );
          }
        } catch (e) {
          debugPrint("Error resending OTP: $e");
        }
      }();
    } else {
      ref
          .watch(sendOtpV1Provider(number: widget.phoneNumber).future)
          .then((response) {
        if (response.status.toString() == "1") {
          Fluttertoast.showToast(
            msg: 'Otp Sent Successfully!',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: ColorConstant.maingreen,
          );
        }
      });
    }
  }
}
