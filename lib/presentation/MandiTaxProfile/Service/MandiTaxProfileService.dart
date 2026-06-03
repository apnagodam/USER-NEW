import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Model/CandFModel.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Model/DistrictsResponseModel.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Model/MandiTaxProfileListingModel.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Model/StatesResponseModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'MandiTaxProfileService.g.dart';

@riverpod
Stream<StatesResponseModel> statesList(StatesListRef ref) async* {
  var response = await ref.watch(dioProvider).get(getStates);
  yield statesResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<StatesResponseModel> statesListNew(StatesListNewRef ref) async* {
  var response = await ref.watch(dioProvider).get(getStatesNew);
  yield statesResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<DistrictsResponseModel> districtList(DistrictListRef ref,
    {String? code}) async* {
  var response = await ref
      .watch(dioProvider)
      .get(getDistricts, queryParameters: {"code": code});
  yield districtsResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<DistrictsResponseModel> districtListNew(DistrictListNewRef ref,
    {String? code}) async* {
  var response = await ref
      .watch(dioProvider)
      .get(getDistrictsNew, queryParameters: {"code": code});
  yield districtsResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<MandiTaxProfileListingModel> mandiTaxProfiles(
    MandiTaxProfilesRef ref) async* {
  var response = await ref.watch(dioProvider).get(getMandiTaxProfiles);
  yield mandiTaxProfileListingModelFromJson(jsonEncode(response.data));
}

@riverpod
Stream<CandFModel> cAndFDetails(CAndFDetailsRef ref,
    {required String stateId}) async* {
  var response = await ref
      .watch(dioProvider)
      .post(getCandF, queryParameters: {'state_id': stateId});

  yield candFModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> submitMandiTaxProfile(SubmitMandiTaxProfileRef ref,
    {String? mandiState,
    String? isLicense,
    String? licenseType,
    String? district,
    String? licenseNumber,
    String? issueDate,
    String? expiryDate,
    String? refNumber,
    String? id,
    File? image}) async {
  FormData formData = FormData.fromMap({
    "state": mandiState,
    "is_licence": isLicense,
    "licance_type": licenseType,
    "district": district,
    "licance_number": licenseNumber,
    "issue_date": issueDate,
    "expiry_date": expiryDate,
    "reference_number": refNumber,
    "candf": id,
    if (image != null)
      'image': await MultipartFile.fromFile(image.path,
          contentType: DioMediaType("image", "png"),
          filename: 'license_image.png'),
  });
  var response =
      await ref.watch(dioProvider).post(updateMandiTaxProfile, data: formData);
  ref.invalidate(mandiTaxProfilesProvider);
  return response.data;
}
