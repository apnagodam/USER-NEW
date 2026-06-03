import 'dart:io';
import 'dart:typed_data';
import 'package:elevarm_ui/elevarm_ui.dart';

import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/image_utils.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/Registration/CompanyRegistration.dart';
import 'package:apnagodam/presentation/Registration/IndividualRegistration.dart';
import 'package:apnagodam/presentation/Registration/PartnershipRegistration.dart';
import 'package:apnagodam/presentation/Registration/PropRegistration.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/login_screen/models/AuthenticationModel.dart';
import 'package:apnagodam/widgets/enums.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/SharedPrefs/SharedUtility.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/progress_dialog_utils.dart';
import '../../widgets/CommonTextField.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/dailogs/error.dart';
import '../dashboard/dashboard_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class KYC extends ConsumerStatefulWidget {
  KYC({super.key, required this.kyctag, this.isAppbarVisible = true});
  bool isAppbarVisible;
  final kyctag;

  @override
  ConsumerState<KYC> createState() => _KYCState();
}

class _KYCState extends ConsumerState<KYC> {
  var profileImageFile = StateProvider<File?>((ref) => null);
  var panImageFile = StateProvider<File?>((ref) => null);
  var aadharBackImageFile = StateProvider<File?>((ref) => null);
  var aadharFrontImageFile = StateProvider<File?>((ref) => null);

  var passbookImageFile = StateProvider<File?>((ref) => null);
  var gstImageFile = StateProvider<File?>((ref) => null);

  TextEditingController panController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController userEmailcontroller = TextEditingController();
  TextEditingController userKycPancontroller = TextEditingController();
  TextEditingController userKycAcccontroller = TextEditingController();
  TextEditingController userKycAadharcontroller = TextEditingController();
  var constitutionTypeProvider = StateProvider<ConstitutionType?>(
    (ref) => null,
  );
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var user = ref.watch(sharedUtilityProvider).getUser();
      userEmailcontroller.text = user?.email ?? "";
      userKycPancontroller.text = user?.pancardNo ?? "";
      userKycAadharcontroller.text = user?.aadharNo ?? "";
      print(user?.pancardNo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgcolor,
      appBar:
          widget.isAppbarVisible == true
              ? AppBar(
                automaticallyImplyLeading: true,
                title: Text(
                  AppLocalizations.of(context)!.profile,
                  style: AppStyle.lblAppbar,
                ),
              )
              : null,

      // userData.userDetails?.constitution.toString() ==
      //             "1"
      //         ? const Individualregistration()
      //         : userData.userDetails?.constitution.toString() == "2"
      //             ? const Propregistration()
      //             : userData.userDetails?.constitution.toString() == "3"
      //                 ? const Partnershipregistration()
      //                 : userData.userDetails?.constitution.toString() == "4"
      //                     ? const Companyregistration()
      //                     :
      body:
          ref.watch(authProvider).value == AuthStatus.loggedOut
              ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/mainlogopng.png',
                      height: 150,
                      width: 150,
                    ),
                    simpleButton(
                      text: AppLocalizations.of(context)!.loginToViewProfile,
                      callback: () {
                        showLoginBottomsheet(context);
                      },
                    ),
                  ],
                ),
              )
              : ref
                  .watch(userDetailsProvider)
                  .when(
                    data: (userData) {
                      if (userData.userDetails?.constitution == null) {
                        return selectConstitutionWidget();
                      } else {
                        if (ref.watch(sharedUtilityProvider).isKycComplete()) {
                          return kycProfilelayout(userData);
                        } else if (ref
                            .watch(sharedUtilityProvider)
                            .isUnderVerification()) {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!.profileUnderVerification,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          );
                        } else {
                          return newUserRegistrationWidget(userData);
                        }
                      }
                    },
                    error: (e, s) => Container(),
                    loading: () => defaultLoader(),
                  ),
    );
  }

  selectConstitutionWidget() => Column(
    // individual('Individual', 1),
    // proprietorship('Proprietorship ', 2),
    // partnership('Partnership ', 3),
    // company('Company ', 4);
    children: [
      Padding(
        padding: Pad(all: 10),
        child: ElevarmDropdownInputField<ConstitutionType>(
          label: AppLocalizations.of(context)!.selectConstitution,
          hintText: AppLocalizations.of(context)!.selectConstitution,
          onChanged: (value) {
            ref.watch(constitutionTypeProvider.notifier).state = value;
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
      ),
      Expanded(
        child:
            ref.watch(constitutionTypeProvider)?.type == 1
                ? Individualregistration(userType: UserType.oldUserType)
                : ref.watch(constitutionTypeProvider)?.type == 2
                ? Propregistration(userType: UserType.oldUserType)
                : ref.watch(constitutionTypeProvider)?.type == 3
                ? Partnershipregistration(userType: UserType.oldUserType)
                : ref.watch(constitutionTypeProvider)?.type == 4
                ? Companyregistration(userType: UserType.oldUserType)
                : SizedBox(),
      ),
    ],
  );

  newUserRegistrationWidget(AuthenticationModel userData) =>
      userData.userDetails?.constitution.toString() == "1"
          ? Individualregistration(userType: UserType.oldUserType)
          : userData.userDetails?.constitution.toString() == "2"
          ? Propregistration(userType: UserType.oldUserType)
          : userData.userDetails?.constitution.toString() == "3"
          ? Partnershipregistration(userType: UserType.oldUserType)
          : userData.userDetails?.constitution.toString() == "4"
          ? Companyregistration(userType: UserType.oldUserType)
          : SizedBox();

  kycProfilelayout(AuthenticationModel userData) => Form(
    key: formKey,
    child: ListView(
      padding: const EdgeInsets.all(12),
      children: [
        CupertinoButton(
          child: Text(
            "${userData.userDetails?.constitution.toString() == "1"
                ? AppLocalizations.of(context)!.individual
                : userData.userDetails?.constitution.toString() == "2"
                ? AppLocalizations.of(context)!.proprietor
                : userData.userDetails?.constitution.toString() == "3"
                ? AppLocalizations.of(context)!.partnership
                : userData.userDetails?.constitution.toString() == "4"
                ? AppLocalizations.of(context)!.company
                : ''}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Adaptive.sp(16),
            ),
          ),
          onPressed: () {},
        ),
        ElevarmTextInputField(
          label: AppLocalizations.of(context)!.lableEmail,
          hintText: 'e.g. olivia@untitledui.com',
          suffixIconAssetName: Icons.email,
          onTapSuffix: null,
          errorText: null,
          controller: userEmailcontroller,
          isRequired: true,
          inputFormatters: [UpperCaseTextFormatter()],
          enabled: false,
        ),
        const SizedBox(height: 20),
        ElevarmTextInputField(
          label: AppLocalizations.of(context)!.pancard,
          hintText: 'e.g. ABCDE1234F',
          suffixIconAssetName: Icons.perm_identity,
          onTapSuffix: null,
          errorText: null,
          controller: userKycPancontroller,
          isRequired: true,
          inputFormatters: [UpperCaseTextFormatter()],
          enabled: false,
        ),
        const SizedBox(height: 20),
        ElevarmTextInputField(
          label: AppLocalizations.of(context)!.adharno,
          hintText: '',
          suffixIconAssetName: Icons.perm_identity,
          onTapSuffix: null,
          errorText: null,
          initialValue: ref.watch(sharedUtilityProvider).getUser()?.aadharNo,
          isRequired: true,
          inputFormatters: [UpperCaseTextFormatter()],
          enabled: false,
        ),
        const SizedBox(height: 20),
        // ElevarmTextInputField(
        //   label: 'GST',
        //   suffixIconAssetName: Icons.email,
        //   onTapSuffix: null,
        //   errorText: null,
        //   initialValue: ref.watch(sharedUtilityProvider).getUser()?.gstNumber,
        //   isRequired: true,
        //   inputFormatters: [UpperCaseTextFormatter()],
        //   enabled: false,
        // ),
        // const SizedBox(height: 20),
        ElevarmTextInputField(
          label: AppLocalizations.of(context)!.msgBankName,
          suffixIconAssetName: Icons.email,
          onTapSuffix: null,
          errorText: null,
          initialValue: ref.watch(sharedUtilityProvider).getUser()?.bankName,
          isRequired: true,
          inputFormatters: [UpperCaseTextFormatter()],
          enabled: false,
        ),
        const SizedBox(height: 20),
        ElevarmTextInputField(
          label: AppLocalizations.of(context)!.msgAccontNo,
          suffixIconAssetName: Icons.email,
          onTapSuffix: null,
          errorText: null,
          initialValue: ref.watch(sharedUtilityProvider).getUser()?.bankAccNo,
          isRequired: true,
          inputFormatters: [UpperCaseTextFormatter()],
          enabled: false,
        ),
        const SizedBox(height: 20),
        ElevarmTextInputField(
          label: AppLocalizations.of(context)!.msgIfsc,
          suffixIconAssetName: Icons.email,
          onTapSuffix: null,
          errorText: null,
          initialValue:
              ref.watch(sharedUtilityProvider).getUser()?.bankIfscCode,
          isRequired: true,
          inputFormatters: [UpperCaseTextFormatter()],
          enabled: false,
        ),
        const SizedBox(height: 20),
        ElevarmTextInputField(
          label: AppLocalizations.of(context)!.bankbranch,
          suffixIconAssetName: Icons.email,
          onTapSuffix: null,
          errorText: null,
          initialValue: ref.watch(sharedUtilityProvider).getUser()?.bankBranch,
          isRequired: true,
          inputFormatters: [UpperCaseTextFormatter()],
          enabled: false,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: AppLocalizations.of(context)!.passportsizeImg,
                  children: [
                    const TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Adaptive.sp(16),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: AppLocalizations.of(context)!.chequeimg,
                  children: [
                    const TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Adaptive.sp(16),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child:
                  ref.watch(sharedUtilityProvider).getUser()?.chequeImage !=
                          null
                      ? CommonCachedImage(
                        image:
                            "$IMAGE_BASE_URL_FRONTEND${ref.watch(sharedUtilityProvider).getUser()?.chequeImage}",
                      )
                      : ElevarmInputFileCard(
                        onTap: () async {
                          await ImagePicker()
                              .pickImage(
                                source: ImageSource.camera,
                                imageQuality: 15,
                              )
                              .then((value) async {
                                if (value != null) {
                                  Uint8List watermarkedImage =
                                      await processImageWithWatermark(
                                        await value.readAsBytes(),
                                      );
                                  var imageFile = await File(
                                    value.path,
                                  ).writeAsBytes(watermarkedImage);
                                  ref.watch(profileImageFile.notifier).state =
                                      imageFile;
                                  ref
                                      .watch(
                                        uploadKycImagesProvider(
                                          profile: File(value.path),
                                        ).future,
                                      )
                                      .then((value) {
                                        if (value.status.toString() == "1") {
                                          Fluttertoast.showToast(
                                            msg: value.message.toString(),
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor:
                                                ColorConstant.maingreen,
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: value.message.toString(),
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor:
                                                ColorConstant.red500,
                                          );
                                        }
                                      })
                                      .onError((e, s) {});
                                }
                              })
                              .onError((e, s) {
                                errorBottomSheet(context, e.toString());
                              });
                        },
                        clickToUploadLabel:
                            AppLocalizations.of(
                              context,
                            )!.uploadYourPassportSizedPhotos,
                        orDragAndDropLabel: '',
                        textColor: ColorConstant.maingreen,
                        subtitle: 'PNG, JPG, JPEG ',
                      ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child:
                  ref.watch(sharedUtilityProvider).getUser()?.chequeImage !=
                          null
                      ? CommonCachedImage(
                        image:
                            "$IMAGE_BASE_URL_FRONTEND${ref.watch(sharedUtilityProvider).getUser()?.chequeImage}",
                      )
                      : ElevarmInputFileCard(
                        onTap: () async {
                          await ImagePicker()
                              .pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 15,
                              )
                              .then((value) async {
                                if (value != null) {
                                  ref
                                      .watch(
                                        uploadKycImagesProvider(
                                          passbook: File(value.path),
                                        ).future,
                                      )
                                      .then((value) {
                                        if (value.status.toString() == "1") {
                                          Fluttertoast.showToast(
                                            msg: value.message.toString(),
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor:
                                                ColorConstant.maingreen,
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: value.message.toString(),
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor:
                                                ColorConstant.red500,
                                          );
                                        }
                                      })
                                      .onError((e, s) {});
                                  ref
                                      .watch(passbookImageFile.notifier)
                                      .state = File(value.path);
                                }
                              })
                              .onError((e, s) {
                                errorBottomSheet(context, e.toString());
                              });
                        },
                        clickToUploadLabel:
                            AppLocalizations.of(context)!.uploadBankPassbook,
                        orDragAndDropLabel: '',
                        textColor: ColorConstant.maingreen,
                        subtitle: 'PNG, JPG, JPEG ',
                      ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 4),
          color: ColorConstant.mainwhite,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context)!.aadharFrontImage,
                        children: [
                          const TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Adaptive.sp(16),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context)!.aadharBackImage,
                        children: [
                          const TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Adaptive.sp(16),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              ref.watch(sharedUtilityProvider).getUser()?.aadharImage != null
                  ? Expanded(
                    child: CommonCachedImage(
                      image:
                          "$IMAGE_BASE_URL_FRONTEND${ref.watch(sharedUtilityProvider).getUser()?.aadharImage}",
                    ),
                  )
                  : Expanded(
                    child: ElevarmInputFileCard(
                      onTap: () async {
                        await ImagePicker()
                            .pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 15,
                            )
                            .then((value) async {
                              if (value != null) {
                                ref
                                    .watch(
                                      uploadKycImagesProvider(
                                        aadhar: File(value.path),
                                      ).future,
                                    )
                                    .then((value) {
                                      if (value.status.toString() == "1") {
                                        Fluttertoast.showToast(
                                          msg: value.message.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor:
                                              ColorConstant.maingreen,
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: value.message.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: ColorConstant.red500,
                                        );
                                      }
                                    })
                                    .onError((e, s) {});
                                ref
                                    .watch(aadharFrontImageFile.notifier)
                                    .state = File(value.path);
                              }
                            })
                            .onError((e, s) {
                              errorBottomSheet(context, e.toString());
                            });
                      },
                      clickToUploadLabel:
                          AppLocalizations.of(context)!.uploadAadharFront,
                      orDragAndDropLabel: '',
                      textColor: ColorConstant.maingreen,
                      subtitle: 'PNG, JPG, JPEG ',
                    ),
                  ),
              const SizedBox(width: 10),
              ref.watch(sharedUtilityProvider).getUser()?.aadharImage != null
                  ? Expanded(
                    child: CommonCachedImage(
                      image:
                          "$IMAGE_BASE_URL_FRONTEND${ref.watch(sharedUtilityProvider).getUser()?.aadharImage}",
                    ),
                  )
                  : Expanded(
                    child: ElevarmInputFileCard(
                      onTap: () async {
                        await ImagePicker()
                            .pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 15,
                            )
                            .then((value) async {
                              if (value != null) {
                                ref
                                    .watch(
                                      uploadKycImagesProvider(
                                        aadharBack: File(value.path),
                                      ).future,
                                    )
                                    .then((value) {
                                      if (value.status.toString() == "1") {
                                        Fluttertoast.showToast(
                                          msg: value.message.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor:
                                              ColorConstant.maingreen,
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: value.message.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: ColorConstant.red500,
                                        );
                                      }
                                    })
                                    .onError((e, s) {});
                                ref
                                    .watch(aadharBackImageFile.notifier)
                                    .state = File(value.path);
                              }
                            })
                            .onError((e, s) {
                              errorBottomSheet(context, e.toString());
                            });
                      },
                      clickToUploadLabel:
                          AppLocalizations.of(context)!.uploadAadharBack,
                      orDragAndDropLabel: '',
                      textColor: ColorConstant.maingreen,
                      subtitle: 'PNG, JPG, JPEG ',
                    ),
                  ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 4),
          color: ColorConstant.mainwhite,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context)!.panimg,
                        children: [
                          const TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Adaptive.sp(16),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        widget.kyctag == "home"
            ? const SizedBox()
            : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ref.watch(sharedUtilityProvider).getUser()?.pancardImage != null
                    ? Expanded(
                      child: CommonCachedImage(
                        image:
                            "$IMAGE_BASE_URL_FRONTEND${ref.watch(sharedUtilityProvider).getUser()?.pancardImage}",
                      ),
                    )
                    : Expanded(
                      child: ElevarmInputFileCard(
                        onTap: () async {
                          await ImagePicker()
                              .pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 15,
                              )
                              .then((value) async {
                                if (value != null) {
                                  ref
                                      .watch(
                                        uploadKycImagesProvider(
                                          panCard: File(value.path),
                                        ).future,
                                      )
                                      .then((value) {
                                        if (value.message.toString() == "1") {
                                          Fluttertoast.showToast(
                                            msg: value.message.toString(),
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor:
                                                ColorConstant.maingreen,
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: value.message.toString(),
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor:
                                                ColorConstant.red500,
                                          );
                                        }
                                      })
                                      .onError((e, s) {});
                                  ref.watch(panImageFile.notifier).state = File(
                                    value.path,
                                  );
                                }
                              })
                              .onError((e, s) {
                                errorBottomSheet(context, e.toString());
                              });
                        },
                        clickToUploadLabel:
                            AppLocalizations.of(context)!.uploadPanCardPhoto,
                        orDragAndDropLabel: '',
                        textColor: ColorConstant.maingreen,
                        subtitle: 'PNG, JPG, JPEG ',
                      ),
                    ),
                const SizedBox(width: 10),
              ],
            ),
        const SizedBox(height: 20),
        // widget.kyctag == "home"
        //     ? const SizedBox()
        //     : Container(
        //         padding: const EdgeInsets.all(5),
        //         color: ColorConstant.mainwhite,
        //         child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 AppLocalizations.of(context)!.adharimg,
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.w600,
        //                     fontSize: Adaptive.sp(16)),
        //               ),
        //               const SizedBox(
        //                 height: 5,
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                     ],
        //               )
        //             ])),
        const SizedBox(height: 20),
        // widget.kyctag == "home"
        //     ? const SizedBox()
        //     : InkWell(
        //         onTap: () {
        //           /*   if(cont.useremailCheck == true){

        //         cont.userEmailcontroller.clear();
        //       }
        //       // if(cont.userprofileCheck == true){
        //       //   cont.apanaUpdateUserProfileandPassbookData(passbookimage, aadharimage, _profileimage, gstimage, panimage);
        //       // }
        //       // if(cont.userpassbookCheck == true){
        //       //   cont.apanaUpdateUserProfileandPassbookData(passbookimage, aadharimage, _profileimage, gstimage, panimage);
        //       // }
        //       // if(cont.userpanCheck == true){
        //       //   cont.apanaUpdateUserProfileandPassbookData(passbookimage, aadharimage, _profileimage, gstimage, panimage);
        //       // }
        //       // if(cont.usergstCheck == true){
        //       //   cont.apanaUpdateUserProfileandPassbookData(passbookimage, aadharimage, _profileimage, gstimage, panimage);
        //       // }
        //       // if(cont.useraadharCheck == true){
        //       //   cont.apanaUpdateUserProfileandPassbookData(passbookimage, aadharimage, _profileimage, gstimage, panimage);
        //       // }
        //       else{
        //         Get.rawSnackbar(
        //             message: "please enter your email",
        //             duration: const Duration(seconds: 2),
        //             backgroundColor: ColorConstant.red500
        //         );
        //       }*/

        //           /*if(cont.userEmailcontroller.text.isEmpty){
        //         Get.rawSnackbar(
        //             message: AppLocalizations.of(context)!.messageEmail,
        //             duration: const Duration(seconds: 2),
        //             backgroundColor: ColorConstant.red500
        //         );
        //       }*/
        //           /* else if(cont.userKycPancontroller.text.isEmpty){
        //         Get.rawSnackbar(
        //             message: AppLocalizations.of(context)!.messagePan,
        //             duration: const Duration(seconds: 2),
        //             backgroundColor: ColorConstant.red500
        //         );
        //       }*/
        //           if (formKey.currentState!.validate()) {
        //             if (ref.watch(profileImageFile) == null) {
        //               Get.rawSnackbar(
        //                   message: AppLocalizations.of(context)!.passportValid,
        //                   duration: const Duration(seconds: 2),
        //                   backgroundColor: ColorConstant.red500);
        //             } else if (ref.watch(passbookImageFile) == null) {
        //               Get.rawSnackbar(
        //                   message: AppLocalizations.of(context)!.passbookValid,
        //                   duration: const Duration(seconds: 2),
        //                   backgroundColor: ColorConstant.red500);
        //             } else if (ref.watch(passbookImageFile) == null) {
        //               Get.rawSnackbar(
        //                   message: AppLocalizations.of(context)!.passbookValid,
        //                   duration: const Duration(seconds: 2),
        //                   backgroundColor: ColorConstant.red500);
        //             } else if (ref.watch(panImageFile) == null) {
        //               Get.rawSnackbar(
        //                   message: AppLocalizations.of(context)!.pleaseSelectPanImage2,
        //                   duration: const Duration(seconds: 2),
        //                   backgroundColor: ColorConstant.red500);
        //             }
        //             // else if (ref.watch(gstImageFile) == null) {
        //             //   Get.rawSnackbar(
        //             //       message: AppLocalizations.of(context)!.passbookValid,
        //             //       duration: const Duration(seconds: 2),
        //             //       backgroundColor: ColorConstant.red500);
        //             // }
        //             else if (ref.watch(aadharBackImageFile) == null) {
        //               Get.rawSnackbar(
        //                   message: AppLocalizations.of(context)!.pleaseSelectAadharCardImage2,
        //                   duration: const Duration(seconds: 2),
        //                   backgroundColor: ColorConstant.red500);
        //             } else {
        //               ProgressDialogUtils.showProgressDialog();
        //               ref
        //                   .watch(updateKycUserDetailsProvider(
        //                 email: userEmailcontroller.text,
        //                 panNumber: userKycPancontroller.text,
        //                 aadharNumber: userKycAadharcontroller.text,
        //               ).future)
        //                   .then((value) async {
        //                 ProgressDialogUtils.hideProgressDialog();
        //                 if (value.status.toString() == "1") {
        //                   Get.offAll(const DashboardScreen());
        //                 }

        //                 // toast(value.message);
        //               }).onError((e, s) {
        //                 ProgressDialogUtils.hideProgressDialog();
        //                 errorBottomSheet(context, e.toString());
        //               });
        //             }
        //           }
        //         },
        //         child: Container(
        //           padding: const EdgeInsets.all(10),
        //           decoration: BoxDecoration(
        //               color: ColorConstant.maingreen,
        //               borderRadius: BorderRadius.circular(8)),
        //           child: Center(
        //               child: Text(
        //             AppLocalizations.of(context)!.msgSubmit,
        //             style: AppStyle.lbldrawerbtn,
        //           )),
        //         ),
        //       ),
      ],
    ),
  );
}
