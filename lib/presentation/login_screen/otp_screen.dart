import 'dart:async';

import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/SmsStrategy.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:apnagodam/widgets/PhoneNumberService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';

import '../../core/utils/image_constant.dart';
import 'controller/login_controller.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Otpscreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String otpType;
  final String? userName;
  final String? userId;

  const Otpscreen({
    super.key,
    required this.phoneNumber,
    required this.otpType,
    this.userName,
    this.userId,
  });

  @override
  ConsumerState<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends ConsumerState<Otpscreen> {
  var logincont = Get.put(LoginController());
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  late Timer _timer;
  TextEditingController otpController = TextEditingController();
  var timeProvider = StateProvider((ref) => 20);
  bool _isVerifying = false;
  late String _phoneNumber;

  @override
  void initState() {
    super.initState();
    _phoneNumber = widget.phoneNumber;

    // Fetch user's phone number
    if (GetPlatform.isAndroid) {
      _fetchPhoneNumber();
    }

    // Check and request SMS permissions
    if (GetPlatform.isAndroid) {
      _checkPermissions();
    }

    // Initialize OTP Interactor
    _otpInteractor = OTPInteractor();
    _otpInteractor
        .getAppSignature()
        .then((value) => debugPrint('signature - $value'));

    // Initialize OTP Controller
    controller = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        if (code.isNotEmpty) {
          otpController.text = code; // Auto-fill OTP
          setState(() {});
        }
      },
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})'); // Extract 6-digit OTP
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [
          Smsstrategy(),
        ],
      );

    // Start countdown timer
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
  }

  Future<void> _fetchPhoneNumber() async {
    try {
      String? phoneNumber = await PhoneNumberService.getPhoneNumber();
      if (phoneNumber != null && mounted) {
        setState(() {
          _phoneNumber = phoneNumber;
        });
      }
    } catch (_) {}
  }

  Future<void> _checkPermissions() async {
    try {
      if (await Permission.sms.isGranted) {
        debugPrint("SMS permission granted");
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose OTP controller
    _timer.cancel(); // Cancel timer
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  ImageConstant.mainlogopng,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              if (widget.userName != null && widget.userName!.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.maingreen.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorConstant.maingreen.withOpacity(0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        color: ColorConstant.maingreen,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          widget.userName!,
                          style: TextStyle(
                            color: ColorConstant.maingreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],
              Text(
                "Enter the 6-digit OTP sent to",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "+91 $_phoneNumber",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Pinput(
                controller: otpController,
                length: 6,
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
              ),
              const SizedBox(height: 24),
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
                            style: TextStyle(
                              color: ColorConstant.maingreen,
                              fontWeight: FontWeight.bold,
                            ),
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
                          "in ${ref.watch(timeProvider)}s",
                          style: AppStyle.lblforgotpassword.copyWith(
                            color: ColorConstant.maingreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: AppStyle.buttonStyle,
                  onPressed: _isVerifying
                      ? null
                      : () {
                          final otp = otpController.text.trim();
                          if (otp.length == 6) {
                            _verifyOtp(otp);
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please enter a valid 6-digit OTP",
                              backgroundColor: ColorConstant.red500,
                            );
                          }
                        },
                  child: _isVerifying
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Verify & Proceed",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
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
