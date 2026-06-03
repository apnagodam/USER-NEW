import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Accountsettings extends ConsumerStatefulWidget {
  const Accountsettings({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AccountsettingsState();
}

class _AccountsettingsState extends ConsumerState<Accountsettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.accountSettings3),
        centerTitle: true,
        backgroundColor: ColorConstant.maingreen,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: ColorConstant.red500,
                                  size: 40,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  AppLocalizations.of(context)!.deleteAccount2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(17),
                                    color: ColorConstant.red500,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.areYouSureYouWantToDeleteYourAccountThisCannotBeUndone2,
                                  style: TextStyle(fontSize: Adaptive.sp(16)),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevarmPrimaryButton.text(
                                        text:
                                            AppLocalizations.of(
                                              context,
                                            )!.cancel,
                                        buttonThemeData:
                                            ElevarmPrimaryButtonThemeData(
                                              primaryColor:
                                                  ColorConstant.maingreen,
                                            ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: ElevarmPrimaryButton.text(
                                        text:
                                            AppLocalizations.of(
                                              context,
                                            )!.delete,
                                        buttonThemeData:
                                            ElevarmPrimaryButtonThemeData(
                                              primaryColor:
                                                  ColorConstant.red500,
                                            ),
                                        onPressed: () async {
                                          ref
                                              .watch(
                                                disableAccountProvider.future,
                                              )
                                              .then((value) {
                                                if (value['status']
                                                        .toString() ==
                                                    "1") {
                                                  context.successToast(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.yourAccountHasBeenDeleted2,
                                                  );
                                                  ref
                                                      .watch(
                                                        authProvider.notifier,
                                                      )
                                                      .logout();

                                                  Get.off(DashboardScreen());
                                                  // Navigate user to login or initial screens
                                                } else {
                                                  context.errorToast(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.failedToDeleteAccountPleaseTryAgain2,
                                                  );
                                                }
                                              })
                                              .catchError((error) {
                                                context.errorToast(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.anErrorOccurredPleaseTryAgain2,
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 12.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_forever_rounded,
                        size: 28,
                        color: ColorConstant.red500,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.deleteAccount2,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adaptive.sp(17),
                                color: ColorConstant.red500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.removeYourAccountPermanently2,
                              style: TextStyle(
                                fontSize: Adaptive.sp(14),
                                color: Colors.grey.shade600,
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
            SizedBox(height: 24),
            // Add more account settings options here as needed
          ],
        ),
      ),
    );
  }
}
