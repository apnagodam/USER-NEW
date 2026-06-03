import 'dart:async';
import 'dart:convert';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/my_order_screen/service/my_orders_response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../dashboard/model/base_response_model.dart';

part 'my_orders_service.g.dart';



@riverpod
Stream<MyOrdersResponseModel> getWantToSellResponse(GetWantToSellResponseRef ref) async* {
  var response = await ref
      .watch(dioProvider)
      .post(CORPORATE_ORDERS, queryParameters: {'limit': 15});

  yield myOrdersResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<BaseResponseModel> cancelOrders(CancelOrdersRef ref,
    {String? id = ""}) async {
  var response = await ref
      .watch(dioProvider)
      .get(CORPORATE_ORDERS_DELETE, queryParameters: {'id': id});
  return baseResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<BaseResponseModel> updateMyOrder(UpdateMyOrderRef ref,
    {String? id = "", String? quantity = "",String? price}) async {
  var response = await ref.watch(dioProvider).post(CORPORATE_ORDERS_UPDATE,
      queryParameters: {'id': id, 'quantity': quantity,'price':price});
  return baseResponseModelFromMap(jsonEncode(response.data));
}
