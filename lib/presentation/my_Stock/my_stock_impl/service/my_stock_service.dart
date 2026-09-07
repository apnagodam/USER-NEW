import 'dart:convert';

import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/emandi_sell_response_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/stock_response_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/model/want_to_sell_response_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_stock_service.g.dart';

// page, url, search, commodityid, salesstatus, warehouseid
@riverpod
Future<List<Datum>> myStock(MyStockRef ref,
    {String? page, String? search = "", String? limit = "3"}) async {
  var response = await ref.watch(dioProvider).get(
      'user_api/apna_u_get_inventories',
      queryParameters: {'limit': limit, 'page': page, 'search': search});

  try {
    Future.microtask(() {
      ref.read(listOfBanks.notifier).state =
          stockResponseModelFromMap(jsonEncode(response.data)).banks ?? [];
    });
  } catch (_) {}

  return stockResponseModelFromMap(jsonEncode(response.data))
          .inventories
          ?.data ??
      [];
}

@riverpod
Future<EmandiSellResponseModel> getEmandiSellData(GetEmandiSellDataRef ref,
    {String? inventoryId, String? commodityId}) async {
  var response = await ref.watch(dioProvider).get(
      'user_api/apna_u_get_settlement',
      queryParameters: {'inventory_id': inventoryId, 'commodity': commodityId});

  return emandiSellResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<WantToSellResponseModel> getWantToSellResponse(
    GetWantToSellResponseRef ref,
    {String? inventoryId,
    String? price}) async {
  var response = await ref.watch(dioProvider).get(
      'user_api/apna_u_get_quality_claim',
      queryParameters: {'inventory_id': inventoryId, 'price': price});

  return wantToSellResponseModelFromMap(jsonEncode(response.data));
}

var listOfBanks = StateProvider<List<Bank>>((ref) => []);
