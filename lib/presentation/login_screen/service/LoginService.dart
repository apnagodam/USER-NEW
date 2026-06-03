import 'dart:convert';

import 'package:apnagodam/presentation/login_screen/models/AuthenticationModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../models/OtpResponsModel.dart';

part 'LoginService.g.dart';

@riverpod
Future<OtpResponseModel> sendOtp(SendOtpRef ref, {String? number,String? fcmToken}) async {
  var response = await ref.watch(dioProvider).post(
      "${BASEURL}api/v1_apna_send_otp",
      queryParameters: {'number': int.parse(number.toString()), 'app_type': 'User',"token":fcmToken});
  return ref.watch(dioProvider).options.baseUrl.contains('test')
      ? otpResponseModelFromMap(jsonEncode(response.data))
      : otpResponseModelFromMap(response.data);
}

@riverpod
Future<OtpResponseModel> sendOtpV1(SendOtpV1Ref ref, {String? number,String? fcmToken}) async {
  var response = await ref.watch(dioProvider).post(
      "${BASEURL}api/v1_apna_send_otp?number=$number",
      queryParameters: {'number': number, 'app_type': 'User','token':fcmToken});
  return otpResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<AuthenticationModel> verifyOtp(VerifyOtpRef ref,
    {String? num, String? otp,String? fcmToken}) async {
  var response = await ref
      .watch(dioProvider)
      .post(DOOTPVERIFY, queryParameters: {"number": num, 'otp': otp,'token':fcmToken});
  return authenticationModelFromMap(jsonEncode(response.data));
}
