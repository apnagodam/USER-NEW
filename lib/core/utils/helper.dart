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
