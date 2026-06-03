import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/providers/ThemeController.dart';
import 'package:apnagodam/core/utils/helper.dart';
import 'package:apnagodam/presentation/PurchaseOrder/model/BrokerBuyerModel.dart';
import 'package:apnagodam/presentation/dashboard/model/base_response_model.dart';
import 'package:apnagodam/presentation/home_screen/models/InvoicesModel.dart';
import 'package:apnagodam/presentation/home_screen/models/InvoicesPdfModel.dart';
import 'package:apnagodam/presentation/home_screen/models/QualityParamsModel.dart';
import 'package:apnagodam/presentation/home_screen/models/TerminalModel.dart';
import 'package:apnagodam/presentation/home_screen/models/UserDetailModal.dart';
import 'package:apnagodam/presentation/home_screen/models/summary_filter_response_model.dart';
import 'package:apnagodam/presentation/home_screen/models/warehouse_response_model.dart';
import 'package:apnagodam/presentation/home_screen/service/TerminalsListModel.dart';
import 'package:apnagodam/presentation/home_screen/stock_summary.dart';
import 'package:apnagodam/presentation/loan_screens/loan_&_finance.dart';
import 'package:apnagodam/presentation/login_screen/login_screen.dart';
import 'package:apnagodam/presentation/splash_screen/splash_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getX;
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/color_constant.dart';
import '../../../database/Database.dart';
import '../../dashboard/model/IndexDataModel.dart';
import '../../login_screen/models/AuthenticationModel.dart';
import '../../my_Stock/my_stock_impl/service/my_stock_impl.dart';
import '../models/FinanceTermModel.dart';
import '../models/apna_finance_list_model.dart';
import '../models/bnpl_list_model.dart';
import '../models/graph_model.dart';
import '../models/summary_commodity_model.dart';
import 'home_response_model.dart';

part 'home_screen_service.g.dart';

@riverpod
Future<InvoicesPdfModel> getInvoicePdf(GetInvoicePdfRef ref,
    {required String? invoiceId}) async {
  var response = await ref
      .watch(dioProvider)
      .post(invoicePdf, queryParameters: {'id': invoiceId});
  return invoicesPdfModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<InvoicesModel> getInvoices(GetInvoicesRef ref,
    {required String? type}) async {
  var response = await ref
      .watch(dioProvider)
      .post(invoiceData, queryParameters: {'type': type});
  return invoicesModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<HomeResponseModel> homeData(HomeDataRef ref) async* {
  var response = await ref.watch(dioProvider).get(COMMIDITY_LIST);

  yield homeResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<GraphModel> getGraphData(GetGraphDataRef ref, {String? id}) async {
  var response =
      await ref.watch(dioProvider).get(GRAPH, queryParameters: {'id': id});
  return graphModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<TerminalsModel> terminalList(TerminalListRef ref) async {
  var response = await ref.watch(dioProvider).get(TERMINAL_LIST);
  return terminalsModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<BnplListModel> bnplList(BnplListRef ref) async* {
  var response = await ref.watch(dioProvider).get(BNPL_REQUEST_LIST);

  yield bnplListModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<dynamic> bnplAddRequest(BnplAddRequestRef ref,
    {String? requestAmount}) async {
  var response = await ref.watch(dioProvider).post(BNPL_REQUEST_ADD,
      queryParameters: {'requested_amount': requestAmount});

  return response.data;
}

@riverpod
Future<dynamic> bnplDeleteRequest(BnplDeleteRequestRef ref,
    {String? id}) async {
  var response = await ref
      .watch(dioProvider)
      .get(BNPL_DESTORY, queryParameters: {'id': id});

  return response.data;
}

@riverpod
Future<AnpnaFinanceListModel> apnaFinanceList(ApnaFinanceListRef ref,
    {String? search}) async {
  var response =
      await ref.watch(dioProvider).get(APANA_U_FINANCE_LIST, queryParameters: {
    'limit': "15",
    'page': ref.watch(loanPageProvider),
    'search': ref.watch(loanSearchProvider)
  });
  ref.watch(loanCurrentPageProvider.notifier).state =
      anpnaFinanceListModelFromMap(jsonEncode(response.data))
              .finances
              ?.currentPage
              ?.toInt() ??
          1;
  ref.watch(loanLastPageProvider.notifier).state =
      anpnaFinanceListModelFromMap(jsonEncode(response.data))
              .finances
              ?.lastPage
              ?.toInt() ??
          1;

  return anpnaFinanceListModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> applyForLoan(ApplyForLoanRef ref,
    {String? inventoryId,
    String? bankId,
    String? quantity,
    String? disbursement,
    String? loanAmount}) async {
  var response =
      await ref.watch(dioProvider).post(APNA_U_LOAN_REQUEST, queryParameters: {
    'inventory_id': inventoryId,
    'bank_id': bankId,
    'quantity': quantity,
    'disbursement': disbursement,
    'loan_t_per_amount': loanAmount,
  });

  return response.data;
}

@riverpod
Future<Map<String, dynamic>> signUpUserOtp(SignUpUserOtpRef ref,
    {String? number, String? otp}) async {
  var response = await ref.watch(dioProvider).post(SIGN_UP_OTP_SEND,
      queryParameters: {'number': number, 'login_otp': otp});

  return response.data;
}

@riverpod
Future<Map<String, dynamic>> signUpUser(SignUpUserRef ref,
    {String? number, String? userName, String? constitutionType}) async {
  var response =
      await ref.watch(dioProvider).post(DOSIGNUPOTPVERIFY, queryParameters: {
    'number': number,
    'name': userName,
    'user_type': '1',
    'token': '',
    'referred_by': '',
    'btn_type': 'signupBtn',
    'ConstitutionType': constitutionType
  });

  return response.data;
}

@riverpod
Stream<SummaryCommodityModel> summaryData(SummaryDataRef ref) async* {
  var response = await ref.watch(dioProvider).get(
        USER_COMMODITY_LIST,
      );

  yield summaryCommodityModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<SummaryFilterResponseModel> userSummaryData(
  UserSummaryDataRef ref,
) async* {
  var response = await ref.watch(dioProvider).post(USER_COMMODITY_DATA, data: {
    "commodity_id": ref.watch(commodityNameProvider),
    "warehouse_id": ref.watch(warehouseNameProvider)
  });

  yield summaryFilterResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<FinanceTermModel> financeTermData(FinanceTermDataRef ref,
    {String? bankId, String? inventoryId}) async {
  var response = await ref.watch(dioProvider).get(FINANCE_TERM,
      queryParameters: {"bank_id": bankId, "inventory_id": inventoryId});
  return financeTermModelFromMap(jsonEncode(response.data));
}

@Riverpod(keepAlive: true)
Future<IndexDataModel> indexData(IndexDataRef ref) async {
  var response = await ref.watch(dioProvider).get(COMMIDITY_LIST);

  return indexDataModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<BaseResponseModel> uploadKycImages(UploadKycImagesRef ref,
    {File? profile,
    File? passbook,
    File? panCard,
    File? gst,
    File? aadhar,
    File? aadharBack}) async {
  FormData formData = FormData.fromMap({
    if (passbook != null)
      'pass_book': await MultipartFile.fromFile(passbook.path ?? "",
          contentType: DioMediaType("image", "png"), filename: 'passbook.png'),
    if (aadhar != null)
      'aadhar_image': await MultipartFile.fromFile(aadhar.path ?? "",
          contentType: DioMediaType("image", "png"), filename: 'aadhar.png'),
    if (aadhar != null)
      'aadhar_back_image': await MultipartFile.fromFile(aadharBack?.path ?? "",
          contentType: DioMediaType("image", "png"),
          filename: 'aadhar_back.png'),
    if (profile != null)
      'profile_image': await MultipartFile.fromFile(profile.path ?? "",
          contentType: DioMediaType("image", "png"), filename: 'profile.png'),
    if (gst != null)
      'gst_image': await MultipartFile.fromFile(gst.path ?? "",
          contentType: DioMediaType("image", "png"), filename: 'gst.png'),
    if (panCard != null)
      'pancard_image': await MultipartFile.fromFile(
        panCard.path ?? "",
        filename: 'pancard.png',
        contentType: DioMediaType("image", "png"),
      ),
  });

  var response = await ref
      .watch(dioProvider)
      .post(APNA_U_UPDATE_USER_IMAGE, data: formData);

  return baseResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<BaseResponseModel> updateKycUserDetails(
  UpdateKycUserDetailsRef ref, {
  String? email = "",
  String? whatsupNumber = "",
  String? panNumber = "",
  String? aadharNumber = "",
  String? address = "",
  String? areaVillage = "",
  String? city = "",
  String? district = "",
  String? selectedState = "",
  String? pincode = "",
  File? panCardFile,
}) async {
  var response = await ref.watch(dioProvider).post(APNA_U_UPDATE_USER, data: {
    "email": email,
    "whatsapp": whatsupNumber,
    "pancard_no": panNumber,
    "aadhar_no": aadharNumber,
    "address": address,
    "area_vilage": areaVillage,
    "city": city,
    "district": district,
    "state": selectedState,
    "pincode": pincode,
    "hidden_pancard_image": SnackBarUtils.fileToBase64(panCardFile)
  });

  return baseResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<WarehouseReponseModel> warehouseData(WarehouseDataRef ref) async {
  var response = await ref.watch(dioProvider).get(WAREHOUSE_DEFAULT_LIST);
  return warehouseReponseModelFromMap(jsonEncode(response.data));
}

@Riverpod(keepAlive: true)
Stream<TerminalsListModel> warehousesList(WarehousesListRef ref) async* {
  var response = await ref.watch(dioProvider).get(getWarehouseData);
  yield terminalsListModelFromJson(jsonEncode(response.data));
}

@riverpod
Stream<BrokerBuyerModel> getBrokerNames(GetBrokerNamesRef ref) async* {
  var response = await ref.watch(dioProvider).post(getBrokerList);
  yield brokerBuyerModelFromJson(jsonEncode(response.data));
}

@riverpod
Stream<AuthenticationModel> userDetails(UserDetailsRef ref) async* {
  var response = await ref.watch(dioProvider).get(USER_DETAILS);
  var userDetailModal = authenticationModelFromMap(jsonEncode(response.data));

  if (userDetailModal != null) {
    ref.watch(sharedUtilityProvider).setUser(userDetailModal.userDetails!);

    if (userDetailModal.userDetails!.verifiedAccount.toString() == "0") {
      ref.watch(sharedUtilityProvider).setKyc(false);
    } else {
      ref.watch(sharedUtilityProvider).setKyc(true);
    }

    if (userDetailModal.userDetails!.verifiedAccount.toString() != "2" &&
        ref.watch(sharedUtilityProvider).isKycComplete() == false &&
        userDetailModal.userDetails!.pancardNo != null) {
      ref.watch(sharedUtilityProvider).setUnderVerification(true);
    } else {
      ref.watch(sharedUtilityProvider).setUnderVerification(false);
    }

    ref.watch(sharedPreferencesProvider).setString(
        "wallatAmount", userDetailModal.userDetails!.power.toString());
    ref
        .watch(sharedPreferencesProvider)
        .setString("firstname", userDetailModal.userDetails!.fname.toString());
    ref.watch(sharedPreferencesProvider).setString(
        "bnplusedpower", userDetailModal.userDetails!.bnplUsedPower.toString());
    ref.watch(sharedPreferencesProvider).setString(
        "bnplpower", userDetailModal.userDetails!.bnplPower.toString());
    ref.watch(sharedPreferencesProvider).setString("accountVerifyed",
        userDetailModal.userDetails!.verifiedAccount.toString());
    ref
        .watch(sharedPreferencesProvider)
        .setString("panstatus", userDetailModal.userDetails!.status.toString());
    ref.watch(sharedPreferencesProvider).setString(
        "bnplterms", userDetailModal.userDetails!.bnplTerms.toString());
    ref.watch(sharedPreferencesProvider).setString(
        "tradeterms", userDetailModal.userDetails!.tradeTerms.toString());
    ref.watch(sharedPreferencesProvider).setString(
        "pancardimage", userDetailModal.userDetails!.pancardImage.toString());
    ref
        .watch(sharedPreferencesProvider)
        .setString("userId", userDetailModal.userDetails!.userId.toString());
  }

  yield authenticationModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<QualityParamsModel> qualityParameters(QualityParametersRef ref,
    {required String stateCode,
    required String districtId,
    required String commodityId}) async* {
  var response = await ref.watch(dioProvider).post(getQualityParamsList,
      queryParameters: {
        'state_code': stateCode,
        'district_id': districtId,
        'commodity_id': commodityId
      });

  yield qualityParamsModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> calculateQualityPrice(CalculateQualityPriceRef ref,
    {required Map<String, dynamic> data}) async {
  var response = await ref.watch(dioProvider).post(getQualityPrice, data: data);

  return response.data;
}

@riverpod
Future<Map<String, dynamic>> punchBuySellOrder(PunchBuySellOrderRef ref,
    {String? deliveryAt,
    String? terminalId,
    String? shipmentCode,
    String? commodityId,
    String? quantity,
    String? price}) async {
  var response =
      await ref.watch(dioProvider).post(BUY_ORDER_CREATE, queryParameters: {
    'delivery_at': deliveryAt,
    'terminal_id': terminalId,
    'shipment_pincode': shipmentCode,
    "commodity_id": commodityId,
    'quantity': quantity,
    "price": price
  });
  return response.data;
}
