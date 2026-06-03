import 'dart:convert';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/sbt/HoldSummary/service/model/HoldSettlementListModel.dart';
import 'package:apnagodam/presentation/sbt/HoldSummary/service/model/HoldSummaryModel.dart';
import 'package:apnagodam/presentation/sbt/HoldSummary/service/model/SbtHoldModel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'HoldSummaryService.g.dart';

@riverpod
Stream<SbtHoldSummaryModel> sbtHoldSummary(SbtHoldSummaryRef ref,
    {String type = "sbt"}) async* {
  var response = await ref
      .watch(dioProvider)
      .post(getSbtHoldSummary, queryParameters: {'type': type});
  yield sbtHoldSummaryModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<HoldStatementListModel> sbtHoldStatement(SbtHoldStatementRef ref,
    {String? walletType}) async* {
  var response = await ref
      .watch(dioProvider)
      .post(getHoldStatement, queryParameters: {'wallet_type': walletType});
  yield holdStatementListModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<HoldSummaryModel> holdSummary(HoldSummaryRef ref,
    {String? type}) async* {
  var response = await ref
      .watch(dioProvider)
      .post(getHoldSummary, queryParameters: {"type": type});

  yield holdSummaryModelFromMap(jsonEncode(response.data));
}
