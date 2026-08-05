import 'package:anywhere_loader/provider/anywhere_loader_context_provider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/extensions.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/language/language.dart';
import 'package:apnagodam/presentation/login_screen/otp_screen.dart';
import 'package:apnagodam/presentation/login_screen/service/LoginService.dart';
import 'package:apnagodam/presentation/singup_screen/termandcon_webview.dart';
import 'package:apnagodam/routes/app_routes.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/utils/image_constant.dart';
import '../singup_screen/singup_screen.dart';
import 'controller/login_controller.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController signUpMobilenumberController = TextEditingController();
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnyWhereLoaderContextProvider(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              titlePadding: EdgeInsets.zero,
                              actionsPadding: EdgeInsets.zero,
                              buttonPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              iconPadding: EdgeInsets.zero,
                              insetPadding: EdgeInsets.zero,
                              title: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstant.maingreen,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 25.0,
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.support_agent,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.msgHelp,
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
                                  SizedBox(height: 8),
                                  ListTile(
                                    onTap: () async {
                                      _launchUrl(
                                        'whatsapp://send?text=sample text&phone=917733901154',
                                      );
                                    },
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xfffcf2f0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          ImageConstant.imgwhatsapp,
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      AppLocalizations.of(context)!.msgWhatsapp,
                                      style: TextStyle(
                                        // fontWeight: FontWeight.w700,fcf2f0
                                        color: ColorConstant.black900,

                                        fontSize: Adaptive.sp(16),
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right_outlined,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                  ),
                                  Divider(color: ColorConstant.grey),
                                  ListTile(
                                    onTap: () {
                                      _launchUrl('tel:7733901154');
                                    },
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xfffcf2f0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.msgCallforHelp,
                                      style: TextStyle(
                                        color: ColorConstant.black900,
                                        fontSize: Adaptive.sp(16),
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right_outlined,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 48,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 2,
                              color: Colors.grey,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.msgHelp,
                              style: AppStyle.lblontestimonalname,
                            ),
                            Icon(Icons.headset_mic, size: 20),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20),
                      child: InkWell(
                        onTap: () {
                          Get.to(LanguageScreen());
                        },
                        child: SizedBox(
                          width: 100,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/bg_icon_english.PNG',
                                width: 45,
                              ),
                              Positioned(
                                left: 30,
                                child: Image.asset(
                                  'assets/images/bg_icon_hindi.PNG',
                                  fit: BoxFit.contain,
                                  width: 45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Image.asset(
                    ImageConstant.imgwellcome,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      AppLocalizations.of(context)!.msgLoging,
                      style: AppStyle.lblloging.copyWith(
                        fontSize: Adaptive.sp(21),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(height: 10),
                Form(
                  key: _formkey,
                  child: ElevarmTextInputField(
                    label: 'Mobile Number',
                    hintText: 'Please input your mobile Number',
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
                        return 'please input valid mobile number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: AppStyle.buttonStyle,
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        if (mobilenumberController.length == 10) {
                          ref
                              .watch(
                                sendOtpV1Provider(
                                  number: mobilenumberController.text,
                                ).future,
                              )
                              .then((response) {
                                if (response.status.toString() == "1") {
                                  Get.to(
                                    Otpscreen(
                                      phoneNumber: mobilenumberController.text,
                                      otpType: 'login',
                                    ),
                                  );
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
                          SingupScreen(
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
                SizedBox(height: 10),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.connect,
                    style: AppStyle.lblalltextfromfields.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: Adaptive.sp(16),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(Icons.facebook,size: 44,color: ColorConstant.maingreen,),
                      InkWell(
                        onTap: () {
                          Get.to(
                            Webview(url: "https://www.facebook.com/apnagodam/"),
                          );
                        },
                        child: Image.asset(
                          'assets/images/facebook.png',
                          width: 44,
                          color: ColorConstant.maingreen,
                        ),
                      ),
                      SizedBox(width: 9),
                      InkWell(
                        onTap: () {
                          Get.to(
                            Webview(
                              url: "https://in.linkedin.com/company/apnagodam",
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/linkedin.png',
                          width: 44,
                          color: ColorConstant.maingreen,
                        ),
                      ),
                      SizedBox(width: 9),
                      InkWell(
                        onTap: () {
                          Get.to(
                            Webview(
                              url:
                                  "https://www.youtube.com/channel/UCbTi5MXhy2l7WcmBBPPnwWw",
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/youtube.png',
                          width: 44,
                          color: ColorConstant.maingreen,
                        ),
                      ),

                      SizedBox(width: 9),
                      InkWell(
                        onTap: () {
                          Get.to(
                            Webview(
                              url: "https://www.instagram.com/apnagodam/",
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/instagram.png',
                          width: 44,
                          color: ColorConstant.maingreen,
                        ),
                      ),
                      SizedBox(width: 9),

                      InkWell(
                        onTap: () {
                          Get.to(Webview(url: "https://twitter.com/Apnagodam"));
                        },
                        child: ElevarmAvatar(
                          backgroundColor: ColorConstant.maingreen,
                          image: NetworkImage(
                            'https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/x-social-media-white-icon.png',
                          ),
                        ),
                      ),
                      // Icon(Icons.,size: 44,color: ColorConstant.maingreen,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    // if (await launchUrl(Uri.parse(_url))) {
    //   throw Exception('Could not launch $_url');
    // }
  }
}
