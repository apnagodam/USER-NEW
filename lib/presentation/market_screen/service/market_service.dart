import 'dart:convert';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/dashboard/model/BookingQualityModel.dart';
import 'package:apnagodam/presentation/market_screen/model/DistrictWiseCommodityModel.dart';
import 'package:apnagodam/presentation/market_screen/model/DistrictWiseSbtModel';
import 'package:apnagodam/presentation/market_screen/model/QualityParametersModel.dart';
import 'package:apnagodam/presentation/market_screen/model/WarehouseListModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/model/bidding_response_model.dart';
import '../../my_Stock/my_stock_impl/service/my_stock_impl.dart';

part 'market_service.g.dart';

@riverpod
Future<BiddingResponseModel> biddingData(BiddingDataRef ref,
    {String? inventoryId, String? status}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> requestHeaders = {
    'language': prefs.getString("lang").toString(),
    'Authorization': prefs.getString("token").toString(),
    'lat': prefs.getString("lat").toString(),
    'long': prefs.getString("long").toString(),
  };
  ref.watch(dioProvider).options.headers = requestHeaders;
  var response = await ref.watch(dioProvider).post('',
      queryParameters: {'inventory_id': inventoryId, "status": status});
  return biddingResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<ProductQualityModel> productQuality(ProductQualityRef ref,
    {String? id}) async* {
  var response = await ref
      .watch(dioProvider)
      .post(getProductQuality, queryParameters: {"product_id": id});
  yield productQualityModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<WarehouseListModel> warehouseList(WarehouseListRef ref,
    {String? id}) async* {
  var response = await ref
      .watch(dioProvider)
      .post(getWarehouseList, queryParameters: {'product_id': id});
  yield warehouseListModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> sbtTerms(
  Ref ref, {
  String? userType,
  String? productId,
}) async {
  var response =
      await ref.watch(dioProvider).post(getSbtTerms, queryParameters: {
    "user_type": userType,
    "product_id": productId,
  });
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> wbtTerms(
  Ref ref, {
  String? invId,
}) async {
  var response =
      await ref.watch(dioProvider).post(gatePassTerms, queryParameters: {
    "inv_id": invId,
  });
  return response.data;
}

@riverpod
Future<DistrictWiseSbtModel> districtSbtData(DistrictSbtDataRef ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> requestHeaders = {
    'language': prefs.getString("lang").toString(),
    'Authorization': prefs.getString("token").toString(),
    'lat': prefs.getString("lat").toString(),
    'long': prefs.getString("long").toString(),
  };
  ref.watch(dioProvider).options.headers = requestHeaders;
  var response = await ref.watch(dioProvider).get(
        DISTRICTSBTLIST,
      );
  return districtWiseSbtModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<DistrictWiseCommodityModel> commodityByDistict(CommodityByDistictRef ref,
    {String? districtId}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> requestHeaders = {
    'language': prefs.getString("lang").toString(),
    'Authorization': prefs.getString("token").toString(),
    'lat': prefs.getString("lat").toString(),
    'long': prefs.getString("long").toString(),
  };
  ref.watch(dioProvider).options.headers = requestHeaders;
  var response = await ref.watch(dioProvider).get(DISTRICT_COMMODITY_LIST,
      queryParameters: {"district_id": districtId});
  return districtWiseCommodityModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> deleteOrder(DeleteOrderRef ref,
    {String? orderId}) async {
  var response = await ref
      .watch(dioProvider)
      .get(deleteSbtOrder, queryParameters: {'order_id': orderId});
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> checkForUserWallet(
  CheckForUserWalletRef ref, {
  String? districtId,
  String? commodity,
  String? productId,
  String? qty,
  String? type,
  String? price,
  String? loanType, // 0 for wallet ,1 for bnpl,2 for finance
}) async {
  var response =
      await ref.watch(dioProvider).post(checkUserWallet, queryParameters: {
    "district_id": districtId,
    "commodity": commodity,
    "product_id": productId,
    "qty": qty,
    "type": type ?? "0",
    "price": price,
    "loan_type": loanType ?? "0" // 0 for wallet ,1 for bnpl,2 for finance
  });
  return response.data;
}

@riverpod
Stream<BookingQualityModel> bookingQualityParameters(
    BookingQualityParametersRef ref,
    {String? caseId}) async* {
  //getBookingQuality
  var response = await ref
      .watch(dioProvider)
      .post(getBookingQuality, queryParameters: {"case_id": caseId});
  yield bookingQualityModelFromJson(jsonEncode(response.data));
}
