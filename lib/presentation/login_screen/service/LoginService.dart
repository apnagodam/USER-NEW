import 'dart:convert';

import 'package:apnagodam/presentation/login_screen/models/AuthenticationModel.dart';
import 'package:apnagodam/presentation/login_screen/models/CheckUserModel.dart';
import 'package:apnagodam/presentation/login_screen/models/UserRegisterResponseModel.dart';
import 'package:apnagodam/presentation/login_screen/models/UserSendOtpResponseModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../models/OtpResponsModel.dart';

part 'LoginService.g.dart';

@riverpod
Future<OtpResponseModel> sendOtp(SendOtpRef ref,
    {String? number, String? fcmToken}) async {
  var response = await ref.watch(dioProvider).post(
      "${BASEURL}api/v1_apna_send_otp",
      queryParameters: {
        'number': int.parse(number.toString()),
        'app_type': 'User',
        "token": fcmToken
      });
  return ref.watch(dioProvider).options.baseUrl.contains('test')
      ? otpResponseModelFromMap(jsonEncode(response.data))
      : otpResponseModelFromMap(response.data);
}

@riverpod
Future<OtpResponseModel> sendOtpV1(SendOtpV1Ref ref,
    {String? number, String? fcmToken}) async {
  var response = await ref.watch(dioProvider).post(
      "${BASEURL}api/v1_apna_send_otp?number=$number",
      queryParameters: {
        'number': number,
        'app_type': 'User',
        'token': fcmToken
      });
  return otpResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<AuthenticationModel> verifyOtp(VerifyOtpRef ref,
    {String? num, String? otp, String? fcmToken}) async {
  var response = await ref.watch(dioProvider).post(DOOTPVERIFY,
      queryParameters: {"number": num, 'otp': otp, 'token': fcmToken});
  return authenticationModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<CheckUserModel> checkUser(CheckUserRef ref,
    {required String number}) async {
  final formData = FormData.fromMap({'number': number});
  var response = await ref.watch(dioProvider).post(
        CHECK_USER_URL,
        data: formData,
      );
  return response.data is String
      ? checkUserModelFromMap(response.data)
      : CheckUserModel.fromMap(response.data);
}

@riverpod
Future<UserRegisterResponseModel> userRegister(UserRegisterRef ref, {
  required String number,
  required String userName,
  required String fcmToken,
  required int constitutionType,
}) async {
  final formData = FormData.fromMap({
    'number': number,
    'name': userName,
    'fcm_token': fcmToken,
    'ConstitutionType': constitutionType,
  });
  var response = await ref.watch(dioProvider).post(
        USER_REGISTER_URL,
        data: formData,
      );
  return response.data is String
      ? userRegisterResponseModelFromMap(response.data)
      : UserRegisterResponseModel.fromMap(response.data);
}

@riverpod
Future<UserSendOtpResponseModel> userSendOtp(UserSendOtpRef ref, {
  required String userId,
  required String fcmToken,
}) async {
  final formData = FormData.fromMap({
    'user_id': userId,
    'fcm_token': fcmToken,
  });
  var response = await ref.watch(dioProvider).post(
        USER_SEND_OTP_URL,
        data: formData,
      );
  return response.data is String
      ? userSendOtpResponseModelFromMap(response.data)
      : UserSendOtpResponseModel.fromMap(response.data);
}

@riverpod
Future<AuthenticationModel> userVerifyOtp(UserVerifyOtpRef ref, {
  required String userId,
  required String otp,
  required String fcmToken,
}) async {
  final formData = FormData.fromMap({
    'user_id': userId,
    'otp': otp,
    'token': fcmToken,
  });
  var response = await ref.watch(dioProvider).post(
        USER_VERIFY_OTP_URL,
        data: formData,
      );
  return response.data is String
      ? authenticationModelFromMap(response.data)
      : AuthenticationModel.fromMap(response.data);
}

@riverpod
Future<dynamic> userLogout(UserLogoutRef ref) async {
  try {
    var response = await ref.watch(dioProvider).post(APANA_USER_LOGUT);
    return response.data;
  } catch (e) {
    return null;
  }
}
