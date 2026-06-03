import 'dart:io';

import 'package:apnagodam/core/utils/Image.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Model/DistrictsResponseModel.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Model/StatesResponseModel.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Service/MandiTaxProfileService.dart';
import 'package:apnagodam/presentation/Registration/Service/BankListModel.dart';
import 'package:apnagodam/presentation/Registration/Service/ProfileRegistrationService.dart';
import 'package:apnagodam/presentation/Verification/service/AadharVerificationService.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/widgets/dailogs/customAlertDialog.dart';
import 'package:apnagodam/widgets/enums.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dotted_border/dotted_border.dart' as dottedBorder;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

import 'RegistrationScreen.dart';

class Propregistration extends ConsumerStatefulWidget {
  const Propregistration({super.key, required this.userType});
  final UserType userType;
  @override
  ConsumerState<Propregistration> createState() => _PropregistrationState();
}

class _PropregistrationState extends ConsumerState<Propregistration> {
  final formKey = GlobalKey<FormState>();

  var propProvider = StateProvider((ref) => 0);
  var propNameProvider = StateProvider((ref) => "Select Constitution");
  var propDocProvider = StateProvider(
    (ref) => "Select Proprietorship Document Type",
  );
  var panImageProvider = StateProvider<File?>((ref) => null);
  var propDocImageProvider = StateProvider<File?>((ref) => null);

  var chequeImageProvider = StateProvider<File?>((ref) => null);

  var adharImageProvider = StateProvider<File?>((ref) => null);
  var adhaBackImageProvider = StateProvider<File?>((ref) => null);
  var personalImageProvider = StateProvider<File?>((ref) => null);

  var isRegisteringProvider = StateProvider((ref) => false);

  final imagePicker = ImagePicker();

  TextEditingController panController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController firmController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  var propTypeList = ['GST', 'License', 'MSME'];
  var propTypeProvider = StateProvider((ref) => '');
  var activeStepProvider = StateProvider((ref) => 0);
  final firmKey = GlobalKey<FormState>();
  final identificationKey = GlobalKey<FormState>();
  final bankDetailsKey = GlobalKey<FormState>();
  final personalDetailsKey = GlobalKey<FormState>();
  var bankProvider = StateProvider<BankDatum?>((ref) => null);

  var statesProvider = StateProvider<StatesDatum?>((ref) => null);

  var districtProvider = StateProvider<DistrictDatum?>((ref) => null);
  final _isOtpSentProvider = StateProvider((ref) => false);
  final _aadharVerifiedProvider = StateProvider((ref) => false);
  final _agreementCheckedProvider = StateProvider((ref) => false);
  final _requestIdProvider = StateProvider((ref) => '');

  @override
  Widget build(BuildContext context) {
    var widgetList = [
      firmLayout(context, ref),
      identificationLayout(context, ref),
      bankLayout(context, ref),
      personalDetailsLayout(context, ref),
    ];
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Proprietorship Registration",
                    style: TextStyle(
                      color: ColorConstant.maingreen,
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.sp(20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // EasyStepper(
                //   activeStep: ref.watch(activeStepProvider),
                //   stepShape: StepShape.rRectangle,
                //   stepBorderRadius: 15,
                //   borderThickness: 2,
                //   padding: Pad(all: 10),
                //   stepRadius: 35,
                //   finishedStepIconColor: ColorConstant.maingreen,
                //   finishedStepBorderColor: ColorConstant.maingreen,
                //   finishedStepTextColor: ColorConstant.maingreen,
                //   finishedStepBackgroundColor: Colors.white,
                //   unreachedStepBackgroundColor:
                //       Colors.grey.withOpacity(0.1),
                //   activeStepIconColor: ColorConstant.maingreen,
                //   showLoadingAnimation: false,
                //   showStepBorder: true,
                //   steps: [
                //     EasyStep(
                //       customStep: ClipRRect(
                //         borderRadius: BorderRadius.circular(15),
                //         child: Opacity(
                //           opacity:
                //               ref.watch(activeStepProvider) >= 0 ? 1 : 0.3,
                //           child: Icon(LucideIcons.building_2),
                //         ),
                //       ),
                //       customTitle:  Text(
                //         'Firm Details',
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //     EasyStep(
                //       customStep: ClipRRect(
                //         borderRadius: BorderRadius.circular(15),
                //         child: Opacity(
                //           opacity:
                //               ref.watch(activeStepProvider) >= 0 ? 1 : 0.3,
                //           child: Icon(LucideIcons.credit_card),
                //         ),
                //       ),
                //       customTitle:  Text(
                //         'Identification',
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //     EasyStep(
                //       customStep: ClipRRect(
                //         borderRadius: BorderRadius.circular(15),
                //         child: Opacity(
                //           opacity:
                //               ref.watch(activeStepProvider) >= 1 ? 1 : 0.3,
                //           child: Icon(LucideIcons.banknote),
                //         ),
                //       ),
                //       customTitle:  Text(
                //         'Bank Details',
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //     EasyStep(
                //       customStep: ClipRRect(
                //         borderRadius: BorderRadius.circular(15),
                //         child: Opacity(
                //           opacity:
                //               ref.watch(activeStepProvider) >= 2 ? 1 : 0.3,
                //           child: Icon(LucideIcons.user),
                //         ),
                //       ),
                //       customTitle:  Text(
                //         'Personal Details',
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ],
                //   onStepReached: (index) => setState(() =>
                //       ref.watch(activeStepProvider.notifier).state = index),
                // ),
                widgetList[0],

                // firmLayout(context, ref),
                // identificationLayout(context, ref),
                // bankLayout(context, ref),
                // personalDetailsLayout(context, ref),
                //
                SizedBox(height: 10),
                ref.watch(isRegisteringProvider) == true
                    ? defaultLoader()
                    : ref.watch(_aadharVerifiedProvider) == false
                    ? Text('')
                    : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (ref.watch(panImageProvider) == null) {
                              context.errorToast('Please select Pan Image');
                            } else if (ref.watch(chequeImageProvider) == null) {
                              context.errorToast('Please select cheque Image');
                            } else if (ref.watch(propTypeProvider).isEmpty) {
                              context.errorToast('Please select document type');
                            } else if (ref.watch(propDocImageProvider) ==
                                null) {
                              context.errorToast(
                                'Please select document Image',
                              );
                            } else if (ref.watch(personalImageProvider) ==
                                null) {
                              context.errorToast(
                                'Please select personal image',
                              );
                            } else {
                              ref
                                  .watch(
                                    registerUserProvider(
                                      panCard: panController.text,
                                      phone: phoneController.text.toString(),
                                      userName: nameController.text.toString(),
                                      constitution: "2",
                                      email: emailController.text.toString(),
                                      adharNo: adharController.text.toString(),
                                      address:
                                          addressController.text.toString(),
                                      locationState:
                                          ref
                                              .watch(statesProvider)
                                              ?.name
                                              .toString(),
                                      district:
                                          ref
                                              .watch(districtProvider)
                                              ?.name
                                              .toString(),
                                      pincode: pinController.text.toString(),
                                      bankName:
                                          ref.watch(bankProvider)?.bankName,
                                      bankBranch:
                                          branchController.text.toString(),
                                      bankAccount:
                                          accountController.text.toString(),
                                      ifscCode: ifscController.text.toString(),
                                      propDocType:
                                          ref
                                              .watch(propTypeProvider)
                                              .toString(),
                                      propDocNumber:
                                          gstController.text.toString(),
                                      firmName: firmController.text.toString(),
                                      panCardImage: ref.watch(panImageProvider),
                                      profileImage: ref.watch(
                                        personalImageProvider,
                                      ),
                                      adharBackImage: ref.watch(
                                        adhaBackImageProvider,
                                      ),
                                      aadharImage: ref.watch(
                                        adharImageProvider,
                                      ),
                                      chequeImage: ref.watch(
                                        chequeImageProvider,
                                      ),
                                      proprietorProof: ref.watch(
                                        propDocImageProvider,
                                      ),
                                    ).future,
                                  )
                                  .then((value) {
                                    ref
                                        .watch(isRegisteringProvider.notifier)
                                        .state = false;
                                    if (value['status'].toString() == "1") {
                                      Get.to(DashboardScreen());
                                      context.successToast(
                                        value['message'].toString(),
                                      );
                                    } else {
                                      context.errorToast(
                                        value['message'].toString(),
                                      );
                                    }
                                  })
                                  .onError((e, s) {
                                    ref
                                        .watch(isRegisteringProvider.notifier)
                                        .state = false;
                                    //toastification.show(title: Text(e.toString()));
                                  });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          backgroundColor: ColorConstant.maingreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.white, blurRadius: 0.3),
                            ],
                            fontWeight: FontWeight.w700,
                            fontSize: Adaptive.sp(16),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  personalDetailsLayout(BuildContext context, WidgetRef ref) => Form(
    key: personalDetailsKey,
    child: ColumnSuper(
      children: [
        CupertinoButton(
          child: Text(
            "Personal Details",
            style: TextStyle(
              color: ColorConstant.maingreen,
              fontWeight: FontWeight.bold,
              fontSize: Adaptive.sp(17),
            ),
          ),
          onPressed: () {},
        ),
        // TextFormField(
        //   keyboardType: TextInputType.text,
        //   controller: nameController,
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Please input value';
        //     }
        //     return null;
        //   },
        //   decoration: InputDecoration(
        //       hintText: "Enter Full Name",
        //       label:  Text("Enter Full Name"),
        //       enabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       disabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10))),
        // ),
        //  SizedBox(
        //   height: 10,
        // ),
        // TextFormField(
        //   keyboardType: TextInputType.emailAddress,
        //   controller: emailController,
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Please input email';
        //     }
        //     return null;
        //   },
        //   decoration: InputDecoration(
        //       hintText: "Enter Email",
        //       label:  Text("Enter Email"),
        //       enabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       disabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10))),
        // ),
        //  SizedBox(
        //   height: 10,
        // ),
        // TextFormField(
        //   keyboardType: TextInputType.number,
        //   maxLength: 10,
        //   readOnly: true,
        //   initialValue: ref.watch(sharedUtilityProvider).getUser()?.phone,
        //   decoration: InputDecoration(
        //       hintText: "Enter Phone Number",
        //       label:  Text("Enter Phone Number"),
        //       enabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       disabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10))),
        // ),
        //  SizedBox(
        //   height: 10,
        // ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () async {
              imagePicker.pickImage(source: ImageSource.camera).then((value) {
                if (value != null) {
                  createStampedImageFile(value, ref).then((value) {
                    ref.watch(personalImageProvider.notifier).state = File(
                      value!,
                    );
                  });
                }
              });
            },
            child: dottedBorder.DottedBorder(
              borderType: dottedBorder.BorderType.RRect,
              dashPattern: [5, 5, 5, 5],
              color: ColorConstant.maingreen,
              child: Padding(
                padding: Pad(all: 20),
                child: Center(
                  child:
                      ref.watch(personalImageProvider) != null
                          ? Stack(
                            children: [
                              Image.file(
                                ref.watch(personalImageProvider) ??
                                    File('path'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    ref.invalidate(personalImageProvider);
                                  },
                                  icon: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                          : ColumnSuper(
                            children: [
                              Icon(
                                LucideIcons.cloud_upload,
                                color: ColorConstant.maingreen,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Select Your Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        // addressLayout(context, ref),
      ],
    ),
  );
  Widget _aadharConsentLayout(WidgetRef ref, BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ElevarmTextInputField(
        isRequired: true,
        keyboardType: TextInputType.number,
        maxLength: 12,
        controller: adharController,
        hintText: 'Enter Aadhar number',
        label: "Enter Aadhar Number",
        validator: (value) {
          if (value == null || value.length != 12) {
            return 'enter valid aadhar number';
          }

          return null;
        },
      ),
      SizedBox(height: 10),
      ElevarmCheckboxListTile(
        checked: ref.watch(_agreementCheckedProvider),
        onPressed: () {
          if (!ref.watch(_agreementCheckedProvider)) {
            ref.watch(_agreementCheckedProvider.notifier).state = true;
          } else {
            ref.watch(_agreementCheckedProvider.notifier).state = false;
          }
        },
        title:
            'I Hereby declare my consent agreement for fetching my information',
        subtitle: '',
        padding: EdgeInsets.all(16.0),
        size: ElevarmCheckboxSize.sm,
        trailingWidget: Container(),
      ),
      SizedBox(height: 10),
      ElevarmPrimaryButton.text(
        text: 'Send Otp',
        onPressed: () {
          ref
              .watch(
                sendAadharVerificationOtpProvider(
                  aadharNo: adharController.text,
                ).future,
              )
              .then((value) {
                if (value['status'].toString() == "1") {
                  ref.watch(_isOtpSentProvider.notifier).state = true;
                  ref.watch(_requestIdProvider.notifier).state =
                      value['data']['request_id'];
                  context.successToast(value['message']);
                } else {
                  context.errorToast(value['message'].toString());
                }
              });
        },
        buttonThemeData: ElevarmPrimaryButtonThemeData(
          primaryColor: ColorConstant.maingreen,
        ),
      ),
    ],
  );

  Widget _otpVerificationLayout(WidgetRef ref, BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: EdgeInsets.all(0),
        child: Pinput(
          autofocus: true,
          length: 6,
          onCompleted: (pin) {
            _onOtpCompleted(
              ref,
              context,
              aadharNo: adharController.text,
              otp: pin,
              requestID: ref.watch(_requestIdProvider),
            );
          },
          defaultPinTheme: PinTheme(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorConstant.maingreen.withOpacity(0.1),
              border: Border.all(
                color: ColorConstant.maingreen.withOpacity(0.1),
              ),
            ),
          ),
          focusedPinTheme: PinTheme(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorConstant.maingreen.withOpacity(0.1),
              border: Border.all(color: ColorConstant.maingreen),
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
      Text(
        '* An OTP has been sent on your aadhar registered mobile number, Submit that OTP to verify your aadhar identity.',
      ),
      SizedBox(height: 20),
      ElevarmPrimaryButton.text(
        text: 'Re-Send OTP',
        onPressed: () {
          ref
              .watch(
                sendAadharVerificationOtpProvider(
                  aadharNo: adharController.text,
                ).future,
              )
              .then((value) {
                if (value['status'].toString() == "1") {
                  context.successToast(value['message']);
                  // ref.watch(_isOtpSentProvider.notifier).state = true;
                  // ref.watch(_requestIdProvider.notifier).state =
                  //     value['data']['request_id'];
                } else {
                  context.errorToast(value['message'].toString());
                }
              });
        },
        buttonThemeData: ElevarmPrimaryButtonThemeData(
          primaryColor: ColorConstant.maingreen,
        ),
      ),
    ],
  );

  _onOtpCompleted(
    WidgetRef ref,
    BuildContext context, {
    required aadharNo,
    required otp,
    required requestID,
  }) {
    ref
        .watch(
          verifyAadharVerificationOtpProvider(
            aadharNo: adharController.text,
            otp: otp,
            requestId: requestID,
          ).future,
        )
        .then((value) {
          if (value['status'].toString() == "1") {
            ref.watch(_aadharVerifiedProvider.notifier).state = true;
            context.successToast('aadhar verified successfully!');
          } else {
            // showErrorDialog(context,
            //     titleText: 'Error!', messageText: value['message'].toString());
            // ref.watch(_isOtpSentProvider.notifier).state = false;
          }
        });
  }

  identificationLayout(BuildContext context, WidgetRef ref) => Form(
    key: identificationKey,
    child: ColumnSuper(
      children: [
        CupertinoButton(
          child: Text(
            "Identification Details",
            style: TextStyle(
              color: ColorConstant.maingreen,
              fontWeight: FontWeight.bold,
              fontSize: Adaptive.sp(17),
            ),
          ),
          onPressed: () {},
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: adharController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input Valid Aadhar Number';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Enter Aadhar Number",
            label: Text("Enter Aadhar Number"),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () async {
              showImageSourceDialog(context, (value) {
                ref.watch(adharImageProvider.notifier).state = File(value.path);
              });
            },
            child: dottedBorder.DottedBorder(
              borderType: dottedBorder.BorderType.RRect,
              dashPattern: [5, 5, 5, 5],
              color: ColorConstant.maingreen,
              child: Padding(
                padding: Pad(all: 20),
                child: Center(
                  child:
                      ref.watch(adharImageProvider) != null
                          ? Stack(
                            children: [
                              Image.file(
                                ref.watch(adharImageProvider) ?? File('path'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    ref.invalidate(adharImageProvider);
                                  },
                                  icon: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                          : ColumnSuper(
                            children: [
                              Icon(
                                LucideIcons.cloud_upload,
                                color: ColorConstant.maingreen,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Select Aadhar Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () async {
              showImageSourceDialog(context, (value) {
                ref.watch(adhaBackImageProvider.notifier).state = File(
                  value.path,
                );
              });
            },
            child: dottedBorder.DottedBorder(
              borderType: dottedBorder.BorderType.RRect,
              dashPattern: [5, 5, 5, 5],
              color: ColorConstant.maingreen,
              child: Padding(
                padding: Pad(all: 20),
                child: Center(
                  child:
                      ref.watch(adhaBackImageProvider) != null
                          ? Stack(
                            children: [
                              Image.file(
                                ref.watch(adhaBackImageProvider) ??
                                    File('path'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    ref.invalidate(adhaBackImageProvider);
                                  },
                                  icon: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                          : ColumnSuper(
                            children: [
                              Icon(
                                LucideIcons.cloud_upload,
                                color: ColorConstant.maingreen,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Select Aadhar Back Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    ),
  );

  addressLayout(BuildContext context, WidgetRef ref) => Form(
    child: ColumnSuper(
      children: [
        ref
            .watch(statesListProvider)
            .when(
              data:
                  (states) => DropdownSearch<StatesDatum?>(
                    compareFn: (a, b) => a?.code == b?.code,
                    popupProps: PopupProps.menu(
                      searchFieldProps: TextFieldProps(
                        autofocus: true,
                        cursorColor: ColorConstant.maingreen,
                        padding: Pad(left: 10, right: 10),
                        decoration: InputDecoration(
                          contentPadding: Pad(left: 10, right: 10),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: ColorConstant.maingreen,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: ColorConstant.maingreen,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: ColorConstant.maingreen,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: ColorConstant.maingreen,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: ColorConstant.maingreen,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: ColorConstant.maingreen,
                            ),
                          ),
                        ),
                      ),
                      menuProps: MenuProps(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: ColorConstant.maingreen),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      itemBuilder:
                          (context, terminal, isVisible, _) => ColumnSuper(
                            alignment: Alignment.centerLeft,
                            children: [
                              Padding(
                                padding: Pad(all: 10),
                                child: Text(
                                  "${terminal?.name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(16),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ],
                          ),
                      title: Padding(
                        padding: Pad(all: 10),
                        child: Text(
                          'Select State',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      showSearchBox: true,
                      searchDelay: Duration(microseconds: 500),
                    ),
                    filterFn:
                        (user, filter) =>
                            user?.stateFilterByName(filter) ?? false,

                    // asyncItems: (String filter) => getData(filter),
                    items: (s, d) => states.data ?? [],
                    itemAsString: (StatesDatum? u) => u?.name ?? "",
                    onChanged:
                        (StatesDatum? data) =>
                            ref.watch(statesProvider.notifier).state = data,
                    decoratorProps: DropDownDecoratorProps(
                      decoration: InputDecoration(
                        contentPadding: Pad(left: 10, bottom: 5, top: 5),
                        hintText: "Select State",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            color: ColorConstant.maingreen,
                          ),
                        ),
                      ),
                    ),
                  ),
              error: (e, s) => Container(),
              loading: () => defaultLoader(),
            ),
        SizedBox(height: 10),
        ref.watch(statesProvider) == null
            ? SizedBox()
            : ref
                .watch(
                  districtListProvider(
                    code: ref.watch(statesProvider)?.code.toString(),
                  ),
                )
                .when(
                  data:
                      (states) => DropdownSearch<DistrictDatum?>(
                        popupProps: PopupProps.menu(
                          searchFieldProps: TextFieldProps(
                            autofocus: true,
                            cursorColor: ColorConstant.maingreen,
                            padding: Pad(left: 10, right: 10),
                            decoration: InputDecoration(
                              contentPadding: Pad(left: 10, right: 10),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: ColorConstant.maingreen),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          itemBuilder:
                              (context, terminal, isVisible, _) => ColumnSuper(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Padding(
                                    padding: Pad(all: 10),
                                    child: Text(
                                      "${terminal?.name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Adaptive.sp(16),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ],
                              ),
                          title: Padding(
                            padding: Pad(all: 10),
                            child: Text(
                              AppLocalizations.of(context)!.selectDistrict,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          showSearchBox: true,
                          searchDelay: Duration(microseconds: 500),
                        ),
                        filterFn:
                            (user, filter) =>
                                user?.districtFilterByName(filter) ?? false,

                        // asyncItems: (String filter) => getData(filter),
                        items: (s, d) => states.data ?? [],
                        itemAsString: (DistrictDatum? u) => u?.name ?? "",
                        onChanged:
                            (DistrictDatum? data) =>
                                ref.watch(districtProvider.notifier).state =
                                    data,
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            contentPadding: Pad(left: 10, bottom: 5, top: 5),
                            hintText:
                                AppLocalizations.of(context)!.selectDistrict,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: ColorConstant.maingreen,
                              ),
                            ),
                          ),
                        ),
                      ),
                  error: (e, s) => Container(),
                  loading: () => CupertinoActivityIndicator(),
                ),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          controller: pinController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input Pincode';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Enter Pincode",
            label: Text("Enter Pincode"),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: addressController,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please input Valid address';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Enter Address",
            label: Text("Enter Address"),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    ),
  );

  bankLayout(BuildContext context, WidgetRef ref) => Form(
    key: bankDetailsKey,
    child: ColumnSuper(
      children: [
        CupertinoButton(
          child: Text(
            "Bank Details",
            style: TextStyle(
              color: ColorConstant.maingreen,
              fontWeight: FontWeight.bold,
              fontSize: Adaptive.sp(17),
            ),
          ),
          onPressed: () {},
        ),
        // ref.watch(bankListProvider).when(
        //     data: (states) => DropdownSearch<BankDatum?>(
        //           validator: (value) {
        //             if (value == null || value.bankName.isEmpty) {
        //               return 'Please input valid bank name';
        //             }
        //             return null;
        //           },
        //           popupProps: PopupProps.menu(
        //               searchFieldProps:  TextFieldProps(
        //                   autofocus: true,
        //                   cursorColor: ColorConstant.maingreen,
        //                   padding: Pad(left: 10, right: 10),
        //                   decoration: InputDecoration(
        //                     contentPadding: Pad(left: 10, right: 10),
        //                     focusedErrorBorder: OutlineInputBorder(
        //                         borderSide: BorderSide(
        //                             style: BorderStyle.solid,
        //                             color: ColorConstant.maingreen)),
        //                     disabledBorder: OutlineInputBorder(
        //                         borderSide: BorderSide(
        //                             style: BorderStyle.solid,
        //                             color: ColorConstant.maingreen)),
        //                     errorBorder: OutlineInputBorder(
        //                         borderSide: BorderSide(
        //                             style: BorderStyle.solid,
        //                             color: ColorConstant.maingreen)),
        //                     focusedBorder: OutlineInputBorder(
        //                         borderSide: BorderSide(
        //                             style: BorderStyle.solid,
        //                             color: ColorConstant.maingreen)),
        //                     border: OutlineInputBorder(
        //                         borderSide: BorderSide(
        //                             style: BorderStyle.solid,
        //                             color: ColorConstant.maingreen)),
        //                     enabledBorder: OutlineInputBorder(
        //                         borderSide: BorderSide(
        //                             style: BorderStyle.solid,
        //                             color: ColorConstant.maingreen)),
        //                   )),
        //               menuProps: MenuProps(
        //                   shape: RoundedRectangleBorder(
        //                       side:  BorderSide(
        //                           color: ColorConstant.maingreen),
        //                       borderRadius: BorderRadius.circular(8))),
        //               itemBuilder: (context, terminal, isVisible) =>
        //                   ColumnSuper(
        //                       alignment: Alignment.centerLeft,
        //                       children: [
        //                         Padding(
        //                           padding:  Pad(all: 10),
        //                           child: Text(
        //                             "${terminal?.bankName}",
        //                             style: TextStyle(
        //                                 fontWeight: FontWeight.bold,
        //                                 fontSize: Adaptive.sp(16)),
        //                           ),
        //                         ),
        //                         Container(
        //                           height: 1,
        //                           color: Colors.grey.withOpacity(0.3),
        //                         ),
        //                       ]),
        //               isFilterOnline: true,
        //               title: Padding(
        //                 padding:  Pad(all: 10),
        //                 child: Text(
        //                   'Select Bank',
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                       fontSize: Adaptive.sp(16),
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //               showSearchBox: true,
        //               searchDelay:  Duration(microseconds: 500)),
        //           filterFn: (user, filter) =>
        //               user?.stateFilterByName(filter) ?? false,
        //           // asyncItems: (String filter) => getData(filter),

        //           items: states.data ?? [],
        //           itemAsString: (BankDatum? u) => "${u?.bankName}",
        //           onChanged: (BankDatum? data) =>
        //               ref.watch(bankProvider.notifier).state = data,
        //           dropdownDecoratorProps:  DropDownDecoratorProps(
        //             dropdownSearchDecoration: InputDecoration(
        //                 contentPadding: Pad(left: 10, bottom: 5, top: 5),
        //                 hintText: "Select Bank",
        //                 border: OutlineInputBorder(
        //                     borderRadius:
        //                         BorderRadius.all(Radius.circular(8)),
        //                     borderSide:
        //                         BorderSide(color: ColorConstant.maingreen))),
        //           ),
        //         ),
        //     error: (e, s) => Container(),
        //     loading: () => defaultLoader()),
        //  SizedBox(
        //   height: 10,
        // ),
        // TextFormField(
        //   keyboardType: TextInputType.text,
        //   textInputAction: TextInputAction.next,
        //   controller: branchController,
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Please input valid branch name';
        //     }
        //     return null;
        //   },
        //   decoration: InputDecoration(
        //       hintText: "Enter Bank Branch",
        //       label:  Text("Enter Bank Branch"),
        //       enabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       disabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10))),
        // ),
        //  SizedBox(
        //   height: 10,
        // ),
        // TextFormField(
        //   keyboardType: TextInputType.number,
        //   controller: accountController,
        //   textInputAction: TextInputAction.next,
        //   validator: (value) {
        //     if (value == null ||
        //         value.isEmpty ||
        //         !value.isValidBankAccount()) {
        //       return 'Please input valid account Number';
        //     }
        //     return null;
        //   },
        //   decoration: InputDecoration(
        //       hintText: "Enter Bank Account Number",
        //       label:  Text("Enter Bank Account Number"),
        //       enabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       disabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10))),
        // ),
        //  SizedBox(
        //   height: 10,
        // ),
        // TextFormField(
        //   keyboardType: TextInputType.text,
        //   controller: ifscController,
        //   textInputAction: TextInputAction.next,
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Please input valid ifsc code';
        //     }
        //     return null;
        //   },
        //   decoration: InputDecoration(
        //       hintText: "Enter Bank IFSC Code",
        //       label:  Text("Enter Bank IFSC Code"),
        //       enabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       disabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10))),
        // ),
        //  SizedBox(
        //   height: 10,
        // ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () async {
              showImageSourceDialog(context, (value) {
                ref.watch(chequeImageProvider.notifier).state = File(
                  value.path,
                );
              });
            },
            child: dottedBorder.DottedBorder(
              borderType: dottedBorder.BorderType.RRect,
              dashPattern: [5, 5, 5, 5],
              color: ColorConstant.maingreen,
              child: Padding(
                padding: Pad(all: 20),
                child: Center(
                  child:
                      ref.watch(chequeImageProvider) != null
                          ? Stack(
                            children: [
                              Image.file(
                                ref.watch(chequeImageProvider) ?? File('path'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    ref.invalidate(chequeImageProvider);
                                  },
                                  icon: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                          : ColumnSuper(
                            children: [
                              Icon(
                                LucideIcons.cloud_upload,
                                color: ColorConstant.maingreen,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Select Cheque Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    ),
  );

  firmLayout(BuildContext context, WidgetRef ref) => Form(
    key: firmKey,
    child: ColumnSuper(
      children: [
        CupertinoButton(
          child: Text(
            "Firm Details",
            style: TextStyle(
              color: ColorConstant.maingreen,
              fontWeight: FontWeight.bold,
              fontSize: Adaptive.sp(17),
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(height: 10),
        // TextFormField(
        //   keyboardType: TextInputType.text,
        //   controller: firmController,
        //   textInputAction: TextInputAction.next,
        //   validator: (value) {
        //     if (value == null || value.isEmpty) {
        //       return 'Please input firm name';
        //     }
        //     return null;
        //   },
        //   decoration: InputDecoration(
        //       hintText: "Enter Firm Name",
        //       label: Text("Enter Firm Name"),
        //       enabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       disabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        // ),
        SizedBox(height: 10),
        DropdownSearch<String>(
          popupProps: PopupProps.menu(
            searchFieldProps: TextFieldProps(
              autofocus: true,
              cursorColor: ColorConstant.maingreen,
              padding: Pad(left: 10, right: 10),
              decoration: InputDecoration(
                contentPadding: Pad(left: 10, right: 10),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorConstant.maingreen,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorConstant.maingreen,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorConstant.maingreen,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorConstant.maingreen,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorConstant.maingreen,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorConstant.maingreen,
                  ),
                ),
              ),
            ),
            menuProps: MenuProps(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: ColorConstant.maingreen),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            itemBuilder:
                (context, terminal, isVisible, _) => ColumnSuper(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: Pad(all: 10),
                      child: Text(
                        terminal,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Adaptive.sp(16),
                        ),
                      ),
                    ),
                    Container(height: 1, color: Colors.grey.withOpacity(0.3)),
                  ],
                ),
            title: Padding(
              padding: Pad(all: 10),
              child: Text(
                ref.watch(propTypeProvider),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Adaptive.sp(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            showSearchBox: true,
            searchDelay: Duration(microseconds: 500),
          ),
          items: (s, d) => propTypeList,
          itemAsString: (String? u) => u ?? "",
          onChanged: (String? data) {
            ref.watch(propTypeProvider.notifier).state =
                '${propTypeList.indexOf(data!) + 1}';
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              contentPadding: Pad(left: 10, bottom: 5, top: 5),
              hintText: "Select Proprietorship Document Type",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: ColorConstant.maingreen),
              ),
            ),
          ),
        ),
        // SizedBox(
        //   width: MediaQuery.of(context).size.width,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       showCupertinoModalPopup(
        //           context: context,
        //           builder: (context) => CupertinoActionSheet(
        //                 title: Text(
        //                   "Select Proprietorship Document Type",
        //                   style: TextStyle(
        //                       color: ColorConstant.maingreen,
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: Adaptive.sp(16)),
        //                 ),
        //                 actions: [
        //                   CupertinoActionSheetAction(
        //                     onPressed: () {
        //                       ref.watch(propDocProvider.notifier).state = "GST";
        //                       Navigator.pop(context);
        //                     },
        //                     isDefaultAction: true,
        //                     child: Text("GST",
        //                         style: TextStyle(
        //                             color: ColorConstant.maingreen,
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: Adaptive.sp(16))),
        //                   ),
        //                   CupertinoActionSheetAction(
        //                     onPressed: () {
        //                       ref.watch(propDocProvider.notifier).state =
        //                           "License";
        //                       Navigator.pop(context);
        //                     },
        //                     isDefaultAction: true,
        //                     child: Text("License",
        //                         style: TextStyle(
        //                             color: ColorConstant.maingreen,
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: Adaptive.sp(16))),
        //                   ),
        //                   CupertinoActionSheetAction(
        //                       onPressed: () {
        //                         ref.watch(propDocProvider.notifier).state =
        //                             "MSME";
        //                         Navigator.pop(context);
        //                       },
        //                       isDefaultAction: true,
        //                       child: Text("MSME",
        //                           style: TextStyle(
        //                               color: ColorConstant.maingreen,
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: Adaptive.sp(16))))
        //                 ],
        //               ));
        //     },
        //     style: ElevatedButton.styleFrom(
        //         backgroundColor: ColorsConstant.secondColorDark,
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10))),
        //     child: Text(
        //       ref.watch(propDocProvider),
        //       style: TextStyle(
        //           color: Colors.white,
        //           shadows: [ Shadow(color: Colors.white, blurRadius: 0.3)],
        //           fontWeight: FontWeight.w700,
        //           fontSize: Adaptive.sp(16)),
        //     ),
        //   ),
        // ),
        SizedBox(height: 10),
        Visibility(
          visible: ref.watch(propTypeProvider).isNotEmpty,
          child: TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: gstController,
            decoration: InputDecoration(
              hintText: "Enter ${ref.watch(propDocProvider)} Number",
              label: Text("Enter ${ref.watch(propDocProvider)} Number"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () async {
              showImageSourceDialog(context, (value) {
                ref.watch(propDocImageProvider.notifier).state = File(
                  value.path,
                );
              });
            },
            child: dottedBorder.DottedBorder(
              borderType: dottedBorder.BorderType.RRect,
              dashPattern: [5, 5, 5, 5],
              color: ColorConstant.maingreen,
              child: Padding(
                padding: Pad(all: 20),
                child: Center(
                  child:
                      ref.watch(propDocImageProvider) != null
                          ? Stack(
                            children: [
                              Image.file(
                                ref.watch(propDocImageProvider) ?? File('path'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    ref.invalidate(propDocImageProvider);
                                  },
                                  icon: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                          : ColumnSuper(
                            children: [
                              Icon(
                                LucideIcons.cloud_upload,
                                color: ColorConstant.maingreen,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Select Document Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(),
        SizedBox(height: 10),
        // TextFormField(
        //   controller: panController,
        //   keyboardType: TextInputType.text,
        //   textCapitalization: TextCapitalization.words,
        //   validator: (value) {
        //     if (value == null || value.isEmpty || !value.isValidPanCardNo()) {
        //       return 'Please input Valid Pan Number';
        //     }
        //     return null;
        //   },
        //   inputFormatters: [
        //     UpperCaseTextFormatter(),
        //   ],
        //   decoration: InputDecoration(
        //       hintText: "Enter PAN Number",
        //       label:  Text("Enter PAN Number"),
        //       enabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //       disabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        // ),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () async {
              showImageSourceDialog(context, (value) {
                ref.watch(panImageProvider.notifier).state = File(value.path);
              });
            },
            child: dottedBorder.DottedBorder(
              borderType: dottedBorder.BorderType.RRect,
              dashPattern: [5, 5, 5, 5],
              color: ColorConstant.maingreen,
              child: Padding(
                padding: Pad(all: 20),
                child: Center(
                  child:
                      ref.watch(panImageProvider) != null
                          ? Stack(
                            children: [
                              Image.file(
                                ref.watch(panImageProvider) ?? File('path'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    ref.invalidate(panImageProvider);
                                  },
                                  icon: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                          : ColumnSuper(
                            children: [
                              Icon(
                                LucideIcons.cloud_upload,
                                color: ColorConstant.maingreen,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Select Pan Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Upload Document Image,\n  Supports JPG, JPEG, PNG",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.maingreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Adaptive.sp(16),
                                ),
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        bankLayout(context, ref),
        personalDetailsLayout(context, ref),
        ref.watch(_aadharVerifiedProvider) == true
            ? Text('')
            : !ref.watch(_isOtpSentProvider)
            ? _aadharConsentLayout(ref, context)
            : _otpVerificationLayout(ref, context),
      ],
    ),
  );
}
