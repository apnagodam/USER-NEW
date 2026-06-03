import 'dart:convert';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/withdraw_money_screen/wallet_impl/wallet_impl.dart';
import 'package:apnagodam/presentation/withdraw_money_screen/wallet_impl/withdrawl_model.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../my_Stock/my_stock_impl/service/my_stock_impl.dart';

part 'wallet_imple_repo.g.dart';

class WalletRepoImple extends WalletRepo {
  @override
  Stream<WalletWithdrawlModel> getWalletList() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    Dio dio = Dio(BaseOptions(baseUrl: BASEURL, headers: requestHeaders))
      ..interceptors.add(LogInterceptor());

    var response = await dio.get('user_api/withdrawal-request-list');
    yield walletWithdrawlModelFromMap(jsonEncode(response.data));
  }
}

@riverpod
Stream<WalletWithdrawlModel> getWalletList(GetWalletListRef ref,
    {required String? walletType}) async* {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> requestHeaders = {
    'language': prefs.getString("lang").toString(),
    'Authorization': prefs.getString("token").toString(),
    'lat': prefs.getString("lat").toString(),
    'long': prefs.getString("long").toString(),
  };
  Dio dio = Dio(BaseOptions(baseUrl: BASEURL, headers: requestHeaders))
    ..interceptors.add(LogInterceptor());

  var response = await dio.get('user_api/withdrawal-request-list',
      queryParameters: {'wallet_type': walletType});
  yield walletWithdrawlModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> withdrawMoney(WithdrawMoneyRef ref,
    {String? requestAmount, String? walletType}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, String> requestHeaders = {
    'language': prefs.getString("lang").toString(),
    'Authorization': prefs.getString("token").toString(),
    'lat': prefs.getString("lat").toString(),
    'long': prefs.getString("long").toString(),
  };

  var response = await ref.watch(dioProvider).post(WITHDRAW_MONEY,
      data: {'requested_amount': requestAmount, 'wallet_type': walletType});

  return response.data;
}

var walletFutureProvider =
    StreamProvider((ref) => WalletRepoImple().getWalletList());
