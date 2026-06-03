import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/GstProfile/Model/GstListingModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'GstService.g.dart';

@riverpod
Future<Map<String, dynamic>> insertGstProfile(InsertGstProfileRef ref,
    {required String? gstNumber,
    required String? stateCode,
    required String? address,
    File? gstImage,
    String? isRequired}) async {
  FormData formData = FormData.fromMap({
    if (gstImage != null)
      'gst_image': await MultipartFile.fromFile(
        gstImage.path ?? "",
      ),
    'gst_number': gstNumber,
    'state_code': stateCode,
    'address': address,
    'is_require': isRequired
  });
  var response =
      await ref.watch(dioProvider).post(addGstProfile, data: formData);
  ref.invalidate(gstListProvider);
  return response.data;
}

@riverpod
Stream<GstListingModel> gstList(GstListRef ref) async* {
  var response = await ref.watch(dioProvider).post(getGstProfileListing);
  yield gstListingModelFromJson(jsonEncode(response.data));
}
