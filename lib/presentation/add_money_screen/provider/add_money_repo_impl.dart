import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/add_money_screen/provider/add_money_repo.dart';
import 'package:apnagodam/presentation/add_money_screen/provider/add_money_summary_model.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../my_Stock/my_stock_impl/service/my_stock_impl.dart';

part 'add_money_repo_impl.g.dart';

class AddMoneyRepoImpl extends AddMoneyRepo {
  @override
  Stream<AddMoneySummaryModel> getSummary() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    var dio = Dio(BaseOptions(baseUrl: BASEURL, headers: requestHeaders));

    var response = await dio.get('user_api/apna_u_get_repayment_request');
    yield addMoneySummaryModelFromMap(jsonEncode(response.data));
  }
}

@riverpod
Future<AddMoneySummaryModel> getSummary(GetSummaryRef ref,
    {required String type}) async {
  var response = await ref.watch(dioProvider).get(
      'user_api/apna_u_get_repayment_request',
      queryParameters: {'wallet_type': type});
  return addMoneySummaryModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> addMoney(AddMoneyRef ref,
    {String? paymenttype,
    String? receptno,
    String? amount,
    String? amountAccType,
    File? files}) async {
  FormData formData = FormData.fromMap({
    'payment_type': paymenttype,
    'recept_no': receptno,
    'amount': amount,
    'amount_acc_type': amountAccType,
    if (files != null)
      'bilty_image': await MultipartFile.fromFile(
        files.path,
        filename: files.path.split('/').last,
      ),
  });

  var response = await ref.watch(dioProvider).post(ADD_MONEY, data: formData);

  return response.data;
  // ref.watch(dioProvider).options.headers = requestHeaders;
  // var response = await ref.watch(dioProvider).get(SBT_BUYER_SELLER,queryParameters:{
  //   'state':cityState,
  //   'commodity_id':commodityId
  // });
  //
}

var addMoneySummaryProvider =
    StreamProvider((ref) => AddMoneyRepoImpl().getSummary());
