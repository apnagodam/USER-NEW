import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/providers/ThemeController.dart';
import 'package:apnagodam/presentation/Registration/DirectorPartners/EditDirectorPartnerScreen.dart';
import 'package:apnagodam/presentation/Registration/Service/BankListModel.dart';
import 'package:apnagodam/presentation/Registration/Service/ListOfDirectorsModel.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/widgets/DioInterceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ProfileRegistrationService.g.dart';

@riverpod
Stream<BankListModel> bankList(Ref ref) async* {
  var dio = Dio(BaseOptions(
      baseUrl: ref.watch(dioProvider).options.baseUrl.contains('test')
          ? 'https://test.apnagodamfinance.com/api/'
          : 'https://apnagodamfinance.com/api/',
      connectTimeout: const Duration(minutes: 45),
      receiveTimeout: const Duration(minutes: 45),
      sendTimeout: const Duration(minutes: 45)))
    ..interceptors.add(PrettyDioLogger());

  dio.options.headers = {
    'Authorization': ref.watch(sharedUtilityProvider).getToken(),
    'lang': ref.watch(sharedPreferencesProvider).getString('lang')
  };
  var response = await dio.get('bank_list');

  yield bankListModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> registerUser(RegisterUserRef ref,
    {String? panCard,
    String? phone,
    String? userName,
    String? constitution,
    String? email,
    String? adharNo,
    String? address,
    String? locationState,
    String? district,
    String? pincode,
    String? bankName,
    String? bankBranch,
    String? bankAccount,
    String? ifscCode,
    String? propDocType,
    String? propDocNumber,
    String? firmName,
    String? partnerDirectorCount,
    File? panCardImage,
    File? profileImage,
    File? chequeImage,
    File? aadharImage,
    File? adharBackImage,
    File? proprietorProof,
    File? moaAoa,
    File? boardResolution,
    File? directorProof}) async {
  FormData formData = FormData.fromMap({
    "pancard_no": panCard,
    'phone': phone,
    'fname': userName,
    'name': firmName,
    'constitution': constitution,
    'email': email,
    'aadhar_no': adharNo,
    'address': address,
    'state': locationState,
    'district': district,
    'city': district,
    'pincode': pincode,
    'bank_name': bankName,
    'bank_branch': bankBranch,
    'bank_acc_no': bankAccount,
    'bank_ifsc_code': ifscCode,
    'proof': propDocType,
    'firm_proof_number': propDocNumber,
    'firm_name': firmName,
    "partners_count": partnerDirectorCount,
    "partner_director_count": partnerDirectorCount,
    "no_director": partnerDirectorCount,
    'pancard_image': await MultipartFile.fromFile(
      panCardImage?.path ?? "",
      filename: 'pan.png',
      contentType: DioMediaType("image", "png"),
    ),
    if (profileImage != null)
      'profile_image': await MultipartFile.fromFile(profileImage.path,
          contentType: DioMediaType("image", "png"), filename: 'profile.png'),
    if (chequeImage != null)
      'cheque_image': await MultipartFile.fromFile(chequeImage.path,
          contentType: DioMediaType("image", "png"), filename: 'cheque.png'),
    if (aadharImage != null)
      'aadhar_image': await MultipartFile.fromFile(aadharImage.path,
          contentType: DioMediaType("image", "png"),
          filename: 'aadharImage.png'),
    if (adharBackImage != null)
      'aadhar_back_image': await MultipartFile.fromFile(adharBackImage.path,
          contentType: DioMediaType("image", "png"),
          filename: 'adharBackImage.png'),
    if (proprietorProof != null)
      'proprietorship_proof': await MultipartFile.fromFile(
        proprietorProof.path,
        filename: 'proprietorProof.png',
        contentType: DioMediaType("image", "png"),
      ),
    if (moaAoa != null)
      'moa_aoa': await MultipartFile.fromFile(
        moaAoa.path,
        filename: 'moaAoa.png',
        contentType: DioMediaType("image", "png"),
      ),
    if (boardResolution != null)
      'partnership_deed': await MultipartFile.fromFile(
        boardResolution.path,
        filename: 'partnershipdeed.png',
        contentType: DioMediaType("image", "png"),
      ),
    if (boardResolution != null)
      'board_resolution': await MultipartFile.fromFile(
        boardResolution.path,
        filename: 'boardResolution.png',
        contentType: DioMediaType("image", "png"),
      ),
    if (directorProof != null)
      'proof_director': await MultipartFile.fromFile(
        directorProof.path,
        filename: 'directorProof.png',
        contentType: DioMediaType("image", "png"),
      ),
  });
  ref.invalidate(userDetailsProvider);
  var response =
      await ref.watch(dioProvider).post(registerUserProfile, data: formData);
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> registerOldUser(Ref ref,
    {String? panCard,
    String? phone,
    String? userName,
    String? constitution,
    String? email,
    String? adharNo,
    String? address,
    String? locationState,
    String? district,
    String? pincode,
    String? bankName,
    String? bankBranch,
    String? bankAccount,
    String? ifscCode,
    String? propDocType,
    String? propDocNumber,
    String? firmName,
    String? partnerDirectorCount,
    File? panCardImage,
    File? profileImage,
    File? chequeImage,
    File? aadharImage,
    File? adharBackImage,
    File? proprietorProof,
    File? moaAoa,
    File? boardResolution,
    File? directorProof}) async {
  FormData formData = FormData.fromMap({
    "pancard_no": panCard,
    'phone': phone,
    'fname': userName,
    'name': firmName,
    'constitution': constitution,
    'email': email,
    'aadhar_no': adharNo,
    'address': address,
    'state': locationState,
    'district': district,
    'city': district,
    'pincode': pincode,
    'bank_name': bankName,
    'bank_branch': bankBranch,
    'bank_acc_no': bankAccount,
    'bank_ifsc_code': ifscCode,
    'proof': propDocType,
    'firm_proof_number': propDocNumber,
    'firm_name': firmName,
    "partners_count": partnerDirectorCount,
    "partner_director_count": partnerDirectorCount,
    "no_director": partnerDirectorCount,
    'pancard_image': await MultipartFile.fromFile(
      panCardImage?.path ?? "",
      filename: 'pan.png',
      contentType: DioMediaType("image", "png"),
    ),
    if (profileImage != null)
      'profile_image': await MultipartFile.fromFile(profileImage.path,
          contentType: DioMediaType("image", "png"), filename: 'profile.png'),
    if (chequeImage != null)
      'cheque_image': await MultipartFile.fromFile(chequeImage.path,
          contentType: DioMediaType("image", "png"), filename: 'cheque.png'),
    if (aadharImage != null)
      'aadhar_image': await MultipartFile.fromFile(aadharImage.path,
          contentType: DioMediaType("image", "png"),
          filename: 'aadharImage.png'),
    if (adharBackImage != null)
      'aadhar_back_image': await MultipartFile.fromFile(adharBackImage.path,
          contentType: DioMediaType("image", "png"),
          filename: 'adharBackImage.png'),
    if (proprietorProof != null)
      'proprietorship_proof': await MultipartFile.fromFile(
        proprietorProof.path,
        filename: 'proprietorProof.png',
        contentType: DioMediaType("image", "png"),
      ),
    if (moaAoa != null)
      'moa_aoa': await MultipartFile.fromFile(
        moaAoa.path,
        filename: 'moaAoa.png',
        contentType: DioMediaType("image", "png"),
      ),
    if (boardResolution != null)
      'partnership_deed': await MultipartFile.fromFile(
        boardResolution.path,
        filename: 'partnershipdeed.png',
        contentType: DioMediaType("image", "png"),
      ),
    if (boardResolution != null)
      'board_resolution': await MultipartFile.fromFile(
        boardResolution.path,
        filename: 'boardResolution.png',
        contentType: DioMediaType("image", "png"),
      ),
    if (directorProof != null)
      'proof_director': await MultipartFile.fromFile(
        directorProof.path,
        filename: 'directorProof.png',
        contentType: DioMediaType("image", "png"),
      ),
  });
  ref.invalidate(userDetailsProvider);

  var response =
      await ref.watch(dioProvider).post(registerUserProfile, data: formData);
  return response.data;
}

@riverpod
Stream<ListOfDirectorsModel> directorsPartnersList(
    DirectorsPartnersListRef ref) async* {
  var response = await ref.watch(dioProvider).get(getListOfPartnersDirectors);

  // ref.watch(isVisible.notifier).state = int.parse(
  //         '${ref.watch(sharedUtilityProvider).getUser()?.partnerDirectorCount ?? 0}') <
  //     (listOfDirectorsModelFromJson(jsonEncode(response.data)).data?.length ??
  //         0);
  yield listOfDirectorsModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> sendVerifyDirectorOtp(SendVerifyDirectorOtpRef ref,
    {String? phoneNumber, String? id}) async {
  var response = await ref.watch(dioProvider).post(sendDirectorVerifyOtp,
      queryParameters: {'phone': phoneNumber, 'id': id});

  return response.data;
}

@riverpod
Future<Map<String, dynamic>> editDirectorPartner(EditDirectorPartnerRef ref,
    {required String personName,
    required String id,
    required String phoneNumber,
    required String panNo,
    required String aadharNo,
    required String otp,
    File? profilePhoto}) async {
  FormData formData = FormData.fromMap({
    'id': id,
    'name': personName,
    'phone': phoneNumber,
    'pancard_no': panNo,
    'aadhar_no': aadharNo,
    "otp": otp,
    if (profilePhoto != null)
      'profile_photo': await MultipartFile.fromFile(
        profilePhoto.path ?? "",
        filename: 'profile.png',
        contentType: DioMediaType("image", "png"),
      ),
  });
  var response =
      await ref.watch(dioProvider).post(updateDirectorPartner, data: formData);
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> addDirectorDetails(AddDirectorDetailsRef ref,
    {required String personName,
    required String phoneNumber,
    required String panNo,
    required String aadharNo,
    required String otp,
    required File profilePhoto}) async {
  FormData formData = FormData.fromMap({
    'name': personName,
    'phone': phoneNumber,
    'pancard_no': panNo,
    'aadhar_no': aadharNo,
    "otp": otp,
    'profile_photo': await MultipartFile.fromFile(
      profilePhoto.path ?? "",
      filename: 'profile.png',
      contentType: DioMediaType("image", "png"),
    ),
  });

  var response =
      await ref.watch(dioProvider).post(submitDirectorDetails, data: formData);

  return response.data;
}

@riverpod
Future<Map<String, dynamic>> sendDirectorOtp(SendDirectorOtpRef ref,
    {String? phoneNumber}) async {
  var response = await ref
      .watch(dioProvider)
      .post(directorSendOtp, queryParameters: {'phone': phoneNumber});

  return response.data;
}
