import 'dart:convert';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/BusinessProfile/Model/BusinessListingModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'BusinessProfileService.g.dart';

@riverpod
Stream<BusinessLIstingModel> businessProfiles(BusinessProfilesRef ref) async* {
  var response = await ref.watch(dioProvider).get(getBusinessProfileListing);
  yield businessLIstingModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> addBusinessProfile(AddBusinessProfileRef ref,
    {required Map<String, dynamic> data}) async {
  var response =
      await ref.watch(dioProvider).post(setBusinessProfile, data: data);
  ref.invalidate(businessProfilesProvider);
  return response.data;
}
