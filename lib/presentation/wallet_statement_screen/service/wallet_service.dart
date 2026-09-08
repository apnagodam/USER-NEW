import 'dart:convert';

import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/models/WalletStatementSummaryModel.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/models/wallet_transactions_list_model.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/wallet_statement_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
part 'wallet_service.g.dart';

@riverpod
Stream<WalletTransactionListModel> getWalletList(GetWalletListRef ref,
    {required String walletType}) async* {
  
  final fromDate = ref.watch(fromDateProvider);
  final toDate = ref.watch(toDateProvider);

  var response = await ref.read(dioProvider).get(
    WALLET_STATEMENT,
    queryParameters: {
      'from_date': fromDate,
      'to_date': toDate,
      'wallet_type': walletType,
    },
  );

  final model = walletTransactionListModelFromMap(jsonEncode(response.data));

  ref.read(openingBalance.notifier).state =
      num.tryParse(model.openingBalance?.toString() ?? '0')?.toDouble() ?? 0.0;
  ref.read(closingBalance.notifier).state =
      model.closingBalance?.toString() ?? "0.0";

  yield model;
}

@riverpod
Stream<WalletStatementSummaryModel> walletSummaryData(Ref ref,
    {String? fromDate, String? toDate, required String walletType}) async* {
  var response = await ref.watch(dioProvider).post(getWalletSummary,
      queryParameters: {
        'from_date': fromDate,
        'to_date': toDate,
        'wallet_type': walletType
      });

  yield walletStatementSummaryModelFromJson(jsonEncode(response.data));
}
