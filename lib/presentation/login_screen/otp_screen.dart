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
import 'package:apnagodam/widgets/PhoneNumberService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';
import '../../database/Database.dart';
import '../home_screen/service/home_screen_service.dart';
import 'controller/login_controller.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Otpscreen extends ConsumerStatefulWidget {
  String phoneNumber;
  final String otpType;
  String? userName = "";

  Otpscreen({
    super.key,
    required this.phoneNumber,
    required this.otpType,
    this.userName,
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

  @override
  void initState() {
    super.initState();

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
        .then((value) => print('signature - $value'));

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
  }

  Future<void> _fetchPhoneNumber() async {
    String? phoneNumber = await PhoneNumberService.getPhoneNumber();
    if (phoneNumber != null) {
      setState(() {
        widget.phoneNumber = phoneNumber; // Update the phone number
      });
      print("User's phone number: $phoneNumber");
    } else {
      print("Unable to fetch phone number.");
    }
  }

  Future<void> _checkPermissions() async {
    // Check SMS permissions
    if (await Permission.sms.isGranted) {
      print("SMS permission granted");
    } else {
      // Request SMS permission
      final status = await Permission.sms.request();
      if (status.isGranted) {
        print("SMS permission granted after request");
      } else if (status.isDenied) {
      } else if (status.isPermanentlyDenied) {
        if (GetPlatform.isAndroid) {
          await openAppSettings();
        }
      }
    }
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose OTP controller
    _timer.cancel(); // Cancel timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Image.asset(
                ImageConstant.mainlogopng,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.msgVerificationCode,
                style: TextStyle(color: ColorConstant.grey),
              ),
              Text(
                widget.phoneNumber,
                style: TextStyle(color: ColorConstant.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
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
          SizedBox(height: 20),
          ref.watch(timeProvider) == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.msgReceiveCode,
                        style: AppStyle.lblforgotpassword),
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
                    Text(AppLocalizations.of(context)!.resendOtp,
                        style: AppStyle.lblforgotpassword),
                    SizedBox(width: 5),
                    Text(
                      "in ${ref.watch(timeProvider)}",
                      style: AppStyle.lblforgotpassword,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Future<void> _verifyOtp(String otp) async {
    var token = '';

    if (GetPlatform.isIOS) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken == null) {
        await Future.delayed(Duration(seconds: 2));
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();
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
      otp: otp,
      fcmToken: token,
    ).future)
        .then((value) async {
      if (value.status.toString() == "1") {
        Get.back(closeOverlays: true);
        await ref.watch(authProvider.notifier).login(value.authorization ?? "");
      } else {
        Fluttertoast.showToast(
          msg: value.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: ColorConstant.red500,
        );
      }
    }).onError((e, s) {
      debugPrint("Error verifying OTP: $e");
    });
  }

  void _resendOtp() {
    ref.watch(timeProvider.notifier).state = 20;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (ref.watch(timeProvider) == 0) {
          timer.cancel();
        } else {
          ref.watch(timeProvider.notifier).state = ref.watch(timeProvider) - 1;
        }
      },
    );
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
