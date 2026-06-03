import 'dart:convert';
import 'dart:ui';

import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/providers/ThemeController.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/presentation/login_screen/login_screen.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/StackSellListModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/StackSettlementModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/StacksCommodityListModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/StacksListModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/StacksTerminalListModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/emandi_sell_response_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/stock_response_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/want_to_sell_response_model.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../widgets/DioInterceptor.dart';
import '../../../LP_list_screen/google_map_screen.dart';

part 'my_stock_impl.g.dart';

@riverpod
Stream<StockResponseModel> myStock(MyStockRef ref, page, url, search,
    commodityid, salesstatus, warehouseid) async* {
  var response = await ref.watch(dioProvider).get(
      'user_api/apna_u_get_inventories',
      queryParameters: {'limit': "15", 'page': page, 'search': search});

  yield stockResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<EmandiSellResponseModel> getEmandiSellData(
    GetEmandiSellDataRef ref, String inventoryId, String commodityId) async {
  var response = await ref.watch(dioProvider).get(
      'user_api/apna_u_get_settlement',
      queryParameters: {'inventory_id': inventoryId, 'commodity': commodityId});

  return emandiSellResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<WantToSellResponseModel> getWantToSellResponse(
    GetWantToSellResponseRef ref, String inventoryId, String price) async {
  var response = await ref.watch(dioProvider).get(
      'user_api/apna_u_get_quality_claim',
      queryParameters: {'inventory_id': inventoryId, 'price': price});

  return wantToSellResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<StacksTerminalListModel> stacksTerminalList(
    StacksTerminalListRef ref) async {
  var response = await ref.watch(dioProvider).post(getStacksTerminals);
  return stacksTerminalListModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<StacksCommodityListModel> stacksCommodityList(StacksCommodityListRef ref,
    {required String terminalId}) async {
  var response = await ref
      .watch(dioProvider)
      .post(getStacksCommodity, queryParameters: {"terminal_id": terminalId});
  return stacksCommodityListModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<StacksListModel> stacksList(StacksListRef ref,
    {required String terminalId, required String commodityId}) async {
  var response = await ref.watch(dioProvider).post(getStacks, queryParameters: {
    "terminal_id": terminalId,
    "commodity_id": commodityId
  });
  return stacksListModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> updateSellerPrice(UpdateSellerPriceRef ref,
    {required String stackId, required String price}) async {
  var response =
      await ref.watch(dioProvider).post(postSellerPriceUpdate, data: {
    "stack_sell_id": stackId,
    "price": price,
  });
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> stackSellTerms(StackSellTermsRef ref,
    {required String stackId}) async {
  var response = await ref.watch(dioProvider).post(fetchStackSellTerms, data: {
    "stack_sell_id": stackId,
  });
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> deleteSellerPrice(DeleteSellerPriceRef ref,
    {required String stackId}) async {
  var response =
      await ref.watch(dioProvider).post(postSellerPriceDelete, data: {
    "stack_sell_id": stackId,
  });
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> bidSellStack(BidSellStackRef ref,
    {required String price,
    required String liftingDays,
    required String id,
    required String walletType,
    String? loanType,
    String? schemeId}) async {
  var response =
      await ref.watch(dioProvider).post(postStackBid, queryParameters: {
    'price': price,
    'lifting_days': liftingDays,
    'stack_sell_id': id,
    'wallet_type': walletType,
    'loan_type': loanType,
    'scheme_id': schemeId
  });
  return response.data;
}

@riverpod
Stream<StackSettlementModel> stackSettlement(StackSettlementRef ref,
    {required String terminalId,
    required String commodityId,
    required String stackId,
    required String price}) async* {
  var response =
      await ref.watch(dioProvider).post(getStackSettlementData, data: {
    "terminal_id": terminalId,
    "stack_id": stackId,
    "price": price,
    "commodity_id": commodityId
  });
  yield stackSettlementModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> stackWantToSell(StackWantToSellRef ref,
    {required String terminalId,
    required String commodityId,
    required String stackId,
    required String price}) async {
  var response = await ref.watch(dioProvider).post(postWantToSell, data: {
    "terminal_id": terminalId,
    "stack_id": stackId,
    "price": price,
    "commodity_id": commodityId
  });

  return response.data;
}

@riverpod
Stream<StackSellListModel> stackSellList(StackSellListRef ref) async* {
  var response = await ref.watch(dioProvider).post(
      ref.watch(authProvider.notifier).loginStatus == AuthStatus.loggedIn
          ? getStackSellListing
          : getDefaultStackSellListing);
  yield stackSellListModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<Map<String, dynamic>> stackOrderList(StackOrderListRef ref) async* {
  var response = await ref.watch(dioProvider).post(getStackOrdersListing);
  yield response.data;
}

var dioProvider = Provider((ref) {
  var dio = Dio(BaseOptions(
      baseUrl: BASEURL,
      connectTimeout: const Duration(minutes: 45),
      receiveTimeout: const Duration(minutes: 45),
      sendTimeout: const Duration(minutes: 45)))
    ..interceptors.addAll([
      Diointerceptor(ref),
      PrettyDioLogger(requestHeader: true, requestBody: true)
    ]);

  return dio;
});

class DioInstance {
  Dio initDio() {
    var dio = Dio(BaseOptions(
        baseUrl: BASEURL,
        connectTimeout: const Duration(minutes: 45),
        receiveTimeout: const Duration(minutes: 45),
        sendTimeout: const Duration(minutes: 45)));

    return dio;
  }
}

@riverpod
Dio initDio(InitDioRef ref) {
  var dio = Dio(BaseOptions(
      baseUrl: BASEURL,
      connectTimeout: const Duration(minutes: 45),
      receiveTimeout: const Duration(minutes: 45),
      sendTimeout: const Duration(minutes: 45)))
    ..interceptors.add(Diointerceptor(ref));
  // ..interceptors.add(PrettyDioLogger(
  //   responseHeader: false,
  //   error: true,
  //   compact: true,
  //   maxWidth: 90,
  // ))
  return dio;
}
