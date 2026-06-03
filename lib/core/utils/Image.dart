import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/main.dart';
import 'package:apnagodam/presentation/LP_list_screen/google_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watermark_unique/image_format.dart';
import 'package:watermark_unique/watermark_unique.dart';

Future<String?> createStampedImageFile(XFile imageFile, WidgetRef ref) async {
  // final image = await ;
  Position? position;
  // watermarkedImgBytes = await ImageWatermark.addTextWatermark(
  //   watermarkText:
  //       '\n${ref.watch(sharedUtilityProvider).getUser()?.firstName} ${ref.watch(sharedUtilityProvider).getUser()?.lastName} (${ref.watch(sharedUtilityProvider).getUser()?.empId})\n${ref.watch(addressProvider)} \n${ref.watch(locationProvider)?.latitude ?? 0.0}, ${ref.watch(locationProvider)?.longitude ?? 0.0}  \n${DateTime.now()}',
  //   dstX: 20,
  //   dstY: 20,
  //   font: ui.arial24,
  //   imgBytes: u8int,
  //   color: Colors.white,
  // );
  requestLocationPermission().then((status) async {
    if (status) {
      position = await ref.watch(locationProvider);
    }
  });
  return WatermarkUnique().addTextWatermark(
    filePath: imageFile.path, // image file path
    text:
        '\n${ref.watch(sharedUtilityProvider).getUser()?.fname}  \n${DateTime.now()}', // watermark text
    x: 10, // position by x
    y: 20, // position by y
    quality: 35, //
    textSize: 18, // text size
    color: Colors.white, // color of text
    imageFormat: ImageFormat.jpeg,
    isNeedRotateToPortrait:
        true, // rotation image to portrait (Default: false) ONLY ANDROID
    backgroundTextColor:
        Colors.black.withOpacity(0.6), // color of background text (optional)
    backgroundTextPaddingLeft: 12, // padding of background text (optional)
    backgroundTextPaddingTop: 12, // padding of background text (optional)
    backgroundTextPaddingRight: 12, // padding of background text (optional)
    backgroundTextPaddingBottom: 12, // padding of background text (optional)
  );
}
