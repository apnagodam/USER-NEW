import 'dart:async';
import 'dart:convert';

import 'package:apnagodam/presentation/credit/service/bnpl_summary_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';

part 'bnpl_service.g.dart';

@riverpod
Stream<BnplSummaryModel> bnplSummary(BnplSummaryRef ref) async* {
  var response = await ref.watch(dioProvider).get(BNPL_SUMMARY_LIST);

  yield bnplSummaryModelFromMap(jsonEncode(response.data));
}
