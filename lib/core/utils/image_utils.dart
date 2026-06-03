import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as ui;
import 'package:image_watermark/image_watermark.dart';

class ImageUtils {
  Future<Uint8List> createStampedImage(Uint8List u8int) async {
    Uint8List watermarkedImgBytes = Uint8List(0);

    watermarkedImgBytes = await ImageWatermark.addTextWatermark(
      watermarkText: '\n${DateTime.now()}',
      dstX: 20,
      dstY: 20,
      font: ui.arial24,
      imgBytes: u8int,
      color: Colors.white,
    );

    return watermarkedImgBytes;
  }
}

Future<Uint8List> addWatermarkInIsolate(Map<String, dynamic> args) async {
  Uint8List watermarkBytes = args['watermarkBytes'];

  // Process image watermark
  Uint8List? watermarkedImage = await ImageWatermark.addTextWatermark(
      watermarkText: '\n${DateTime.now()}',
      dstX: 20,
      dstY: 20,
      font: ui.arial48,
      imgBytes: watermarkBytes,
      color: Colors.white);

  return watermarkedImage;
}

Future<Uint8List> processImageWithWatermark(Uint8List watermarkBytes) async {
  // Run watermark processing in a separate isolate
  return await compute(addWatermarkInIsolate, {
    'watermarkBytes': watermarkBytes,
  });
}
