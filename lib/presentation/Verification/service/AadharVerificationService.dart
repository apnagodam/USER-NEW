import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'AadharVerificationService.g.dart';

@riverpod
Future<Map<String, dynamic>> sendAadharVerificationOtp(
    Ref ref,
    {required String aadharNo}) async {
  // return {"status": "1", "message": "yay!"};

  var response = await ref.watch(dioProvider).post(
      userSendAadharVerificationOtp,
      queryParameters: {"aadhar_no": aadharNo});
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> verifyAadharVerificationOtp(
    Ref ref,
    {required String aadharNo,
    required String requestId,
    required String otp}) async {
  // return {"status": "1", "message": "tet!"};

  var response = await ref.watch(dioProvider).post(userVerifAadharOtp,
      queryParameters: {
        "aadhar_no": aadharNo,
        "request_id": requestId,
        "otp": otp
      });
  return response.data;
}
