import 'dart:convert';

import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/spot_order_booking_screen/service/spot_orders_response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';

part 'spot_orders_service.g.dart';

@riverpod
Stream<SpotOrdersResponseModel> getWantToSellResponse(
    GetWantToSellResponseRef ref) async* {
  var response = await ref.watch(dioProvider).get(SPOT_ORDERS_LIST);
  yield spotOrdersResponseModelFromMap(jsonEncode(response.data));
}
