import 'dart:async';
import 'dart:convert';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/commodity_finance/service/commodity_finance_list_model.dart';
import 'package:apnagodam/presentation/dashboard/model/base_response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../my_Stock/my_stock_impl/service/my_stock_impl.dart';
import '../model/finance_bank_list_response.dart';

part 'commodity_finance_service.g.dart';

@riverpod
Stream<CommodityFinanceListModel> getFinanceList(GetFinanceListRef ref) async* {
  var response = await ref.watch(dioProvider).get(SANCTION_LIMIT_LIST);

  yield commodityFinanceListModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<FinanceBankListResponse> financeBanksList(
    FinanceBanksListRef ref) async* {
  var response = await ref.watch(dioProvider).get(FINANCE_BANKS);
  yield financeBankListResponseFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> checkSanctionLimit(CheckSanctionLimitRef ref,
    {String? bankId = ""}) async {
  var response = await ref
      .watch(dioProvider)
      .get(SANCTION_LIMIT_TERM, queryParameters: {'bank_id': bankId});
  return response.data;
}

@riverpod
Future<BaseResponseModel> applySenctionLimit(ApplySenctionLimitRef ref,
    {String? bankId = "", String? requestedAmount = ""}) async {
  var response = await ref.watch(dioProvider).post(SANCTION_LIMIT_APPLY,
      queryParameters: {
        'bank_id': bankId,
        'requested_amount': requestedAmount
      });
  return baseResponseModelFromMap(jsonEncode(response.data));
}
