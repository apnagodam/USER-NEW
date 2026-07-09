import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

showCustomAlertDialog(BuildContext context, Widget child, String title) =>
    AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold),
          ),
          Divider(
            endIndent: 150,
            thickness: 4,
            color: ColorConstant.maingreen,
          )
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      content: child,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: AppStyle.buttonStyle,
          child: Text(
            AppLocalizations.of(context)!.ok,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
showErrorDialog(BuildContext context,
        {required String titleText,
        required String messageText,
        VoidCallback? action}) =>
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      headerBackgroundColor: ColorConstant.maingreen,
      title: titleText,
      text: messageText,
      showCancelBtn: false,
      showConfirmBtn: true,
      confirmBtnText: "Okay",
      confirmBtnColor: ColorConstant.maingreen,
      onConfirmBtnTap: () {
        Get.back();

        // action!();
      },
      widget: const Text(''),
    );

showForceLogoutDialog(BuildContext context,
        {required String titleText,
        required String messageText,
        VoidCallback? action}) =>
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      headerBackgroundColor: ColorConstant.maingreen,
      title: titleText,
      text: messageText,
      showCancelBtn: false,
      showConfirmBtn: true,
      confirmBtnText: "Okay",
      confirmBtnColor: ColorConstant.maingreen,
      onConfirmBtnTap: () {
        action!();
        Get.back();
      },
      widget: const Text(''),
    );
Future<void> showImageSourceDialog(
    BuildContext context, Function(XFile) onImagePicked) async {
  final ImagePicker picker = ImagePicker();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(AppLocalizations.of(context)!.selectImageSource),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(AppLocalizations.of(context)!.camera),
              onTap: () async {
                Navigator.of(context, rootNavigator: false)
                    .pop(); // Close the dialog
                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  onImagePicked(image);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(AppLocalizations.of(context)!.gallery),
              onTap: () async {
                Navigator.of(context, rootNavigator: false)
                    .pop(); // Close the dialog
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  onImagePicked(image);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<void> showImageSourceFilePickerDialog(
    BuildContext context, Function(XFile) onImagePicked) async {
  final ImagePicker picker = ImagePicker();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(AppLocalizations.of(context)!.selectImageSource),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(AppLocalizations.of(context)!.camera),
              onTap: () async {
                Navigator.of(context, rootNavigator: false)
                    .pop(); // Close the dialog
                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  onImagePicked(image);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(AppLocalizations.of(context)!.gallery),
              onTap: () async {
                Navigator.of(context, rootNavigator: false)
                    .pop(); // Close the dialog

                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  onImagePicked(image);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
