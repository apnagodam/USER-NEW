import 'dart:convert';

import 'package:apnagodam/presentation/dashboard/model/base_response_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/repayment_screen/model/PurchaseOrderTypeModel.dart';
import 'package:apnagodam/presentation/repayment_screen/model/settlement_list_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../model/repayment_model.dart';

part 'repayment_service.g.dart';

@riverpod
Stream<RepaymentModel> repaymentTerminals(RepaymentTerminalsRef ref,
    {String? terminalId = "",
    String? commodityId = "",
    String? type = ""}) async* {
  var response = await ref.watch(dioProvider).get(USER_COMMODITY_TERMINAL,
      queryParameters: {
        'terminal_id': terminalId,
        'commodity_id': commodityId,
        'type': type
      });
  yield repaymentModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<RepaymentModel> repaymentCommodity(RepaymentCommodityRef ref,
    {String? terminalId = "",
    String? commodityId = "",
    String? type = ""}) async* {
  var response = await ref.watch(dioProvider).get(USER_COMMODITY_TERMINAL,
      queryParameters: {
        'terminal_id': terminalId,
        'commodity_id': commodityId,
        'type': type
      });
  yield repaymentModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<RepaymentModel> repaymentStacks(RepaymentStacksRef ref,
    {String? terminalId = "",
    String? commodityId = "",
    String? type = ""}) async* {
  var response = await ref.watch(dioProvider).get(USER_COMMODITY_TERMINAL,
      queryParameters: {
        'terminal_id': terminalId,
        'commodity_id': commodityId,
        'type': type
      });
  yield repaymentModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<BaseResponseModel> repaymentSettlement(RepaymentSettlementRef ref,
    {String? settlementId = "", String? totalSettlementAmount = ""}) async {
  var response = await ref.watch(dioProvider).post(USER_REPAYMENT_SETTLEMENT,
      data: {
        'sett_inv_ids': settlementId,
        'total_settAmt': totalSettlementAmount
      });
  return baseResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<SettlementListModel> settlementList(SettlementListRef ref,
    {String? terminalId = "",
    String? commodityId = "",
    String? stackNumber = ""}) async* {
  var response = await ref
      .watch(dioProvider)
      .get(STACK_WISE_SETTLEMENT_TERMINAL, queryParameters: {
    'terminal_id': terminalId,
    "commodity_id": commodityId,
    "stack_number": stackNumber
  });
  yield settlementListModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<PurchaseOrderTypeModel> purchaseOrderListOutwards(Ref ref,
    {required String terminalId, required String commodityId}) async* {
  var response = await ref.watch(dioProvider).get(getPoOutwards,
      queryParameters: {'terminal': terminalId, 'commodity': commodityId});
  yield purchaseOrderTypeModelFromJson(jsonEncode(response.data));
}
