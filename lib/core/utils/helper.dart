import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import 'color_constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:get/get.dart' as getx;
import 'package:elevarm_ui/elevarm_ui.dart';

class SnackBarUtils {
  static String? fileToBase64(File? file) {
    final bytes = file?.readAsBytesSync();
    return bytes != null ? base64Encode(bytes) : null;
  }

  static void showSnackBar(BuildContext context, String message, Color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color,
        content: Text(
          message,
          style:
              TextStyle(fontFamily: 'Poppins', color: ColorConstant.whiteA700),
        ),
      ),
    );
  }
}

Future<void> CallLaunch(url) async {
  if (await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

Future<void> SaveTOGalleryAndOpen(
    ScreenshotController controller, String fileName) async {
  print(fileName);
  try {
    String filePath = '';
    Directory? documentsDirectory;
    // Capture screenshot
    Uint8List? imageBytes = await controller.capture();

    // Create a PDF document
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Image(pw.MemoryImage(imageBytes!), fit: pw.BoxFit.fill);
        },
      ),
    );

    // Get the application documents directory
    if (Platform.isIOS) {
      documentsDirectory = await getApplicationDocumentsDirectory();
    } else {
      documentsDirectory = await getApplicationSupportDirectory();
    }
    filePath = '${documentsDirectory.path}/$fileName.pdf';
    // Save the PDF to a file
    if (await File(filePath).exists()) {
      // Open the saved PDF file
      OpenFile.open(filePath);
    } else {
      final file = File(filePath);
      await file.writeAsBytes(Uint8List.fromList(await pdf.save()));

      // Open the saved PDF file
      OpenFile.open(file.path);
    }
    // await FileSaver.instance.saveAs(
    //     name: '$fileName',
    //     file: File(filePath),
    //     mimeType: MimeType.pdf,
    //     ext: '.pdf');
  } catch (e) {
    print("Error during PDF generation and opening: $e");
    // Handle the error as needed
  }
}

String formatErrorMessage(BuildContext context, dynamic rawMessage) {
  if (rawMessage == null) return 'Something went wrong';
  String msg = rawMessage.toString();

  bool isHindi = false;
  try {
    isHindi = (Localizations.localeOf(context).languageCode == 'hi');
  } catch (_) {}

  if (!isHindi) {
    return msg;
  }

  RegExp priceRegex = RegExp(
    r'The price you have entered is not applicable for this district\.?\s*Please update the price between\s*₹?\s*([\d\.\,]+)\s*(?:and|से)?\s*([\d\.\,]+)\s*₹?',
    caseSensitive: false,
  );
  var match = priceRegex.firstMatch(msg);
  if (match != null) {
    String minPrice = match.group(1) ?? '';
    String maxPrice = match.group(2) ?? '';
    return "आपके द्वारा दर्ज किया गया मूल्य इस जिले के लिए लागू नहीं है। कृपया ₹ $minPrice और ₹ $maxPrice के बीच का मूल्य दर्ज करें।";
  }

  if (msg.toLowerCase().contains("user don't have suffcient balance") ||
      msg.toLowerCase().contains("user don't have sufficient balance") ||
      msg.toLowerCase().contains("insufficient balance")) {
    return "आपके पास पर्याप्त शेष राशि नहीं है।";
  }
  if (msg.toLowerCase().contains("quantity should be greater than 0")) {
    return "मात्रा 0 से अधिक होनी चाहिए!";
  }
  if (msg.toLowerCase().contains("something went wrong")) {
    return "कुछ गलत हो गया, कृपया पुनः प्रयास करें।";
  }

  return msg;
}

void showErrorAlertDialog(BuildContext context, dynamic rawMessage, {VoidCallback? onOk}) {
  String message = formatErrorMessage(context, rawMessage);

  getx.Get.defaultDialog(
    title: "Error",
    radius: 8,
    barrierDismissible: false,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Adaptive.sp(17),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevarmPrimaryButton.text(
                text: 'OK',
                buttonThemeData: ElevarmPrimaryButtonThemeData(
                  primaryColor: Colors.red.shade700,
                ),
                onPressed: () {
                  getx.Get.back();
                  if (onOk != null) {
                    onOk();
                  }
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: ElevarmPrimaryButton.text(
                text: 'Contact IVR',
                buttonThemeData: ElevarmPrimaryButtonThemeData(
                  primaryColor: ColorConstant.maingreen,
                ),
                onPressed: () => CallLaunch('tel:+917733901154'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

