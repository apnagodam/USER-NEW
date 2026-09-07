import 'dart:convert';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/bid_power/model/bid_power_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUserTradeLimitReqProvider =
    FutureProvider<UserTradeLimitReqModel>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get(GET_USER_TRADE_LIMIT_REQ);
  debugPrint("getUserTradeLimitReq response: ${response.data}");
  return userTradeLimitReqModelFromMap(jsonEncode(response.data));
});

class BidPowerService {
  final Ref ref;
  BidPowerService(this.ref);

  Future<Map<String, dynamic>> saveUserTradeLimitReq({
    required dynamic amount,
    required int type, // 1 for secure, 2 for unsecure
  }) async {
    final dio = ref.read(dioProvider);
    final data = {
      'amount': amount,
      'type': type,
    };
    debugPrint("saveUserTradeLimitReq payload: $data");
    final response = await dio.post(
      SAVE_USER_TRADE_LIMIT_REQ,
      data: data,
    );
    debugPrint("saveUserTradeLimitReq response: ${response.data}");
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return jsonDecode(jsonEncode(response.data));
  }

  Future<Map<String, dynamic>> updateTradeLimitData({
    required dynamic id,
    required dynamic amount,
  }) async {
    final dio = ref.read(dioProvider);
    final data = {
      'id': id,
      'amount': amount,
    };
    debugPrint("updateTradeLimitData payload: $data");
    final response = await dio.post(
      UPDATE_TRADE_LIMIT_DATA,
      data: data,
    );
    debugPrint("updateTradeLimitData response: ${response.data}");
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    }
    return jsonDecode(jsonEncode(response.data));
  }
}

final bidPowerServiceProvider = Provider<BidPowerService>((ref) {
  return BidPowerService(ref);
});
