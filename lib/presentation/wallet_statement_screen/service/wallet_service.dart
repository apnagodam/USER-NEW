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
@riverpod
Stream<WalletTransactionListModel> getWalletList(GetWalletListRef ref,
    {required String walletType}) async* {
  
  final fromDate = ref.watch(fromDateProvider); // ✅ keep watch for reactivity
  final toDate = ref.watch(toDateProvider);     // ✅ keep watch for reactivity

  var response = await ref.read(dioProvider).get(  // ✅ read, not watch
    WALLET_STATEMENT,
    queryParameters: {
      'from_date': fromDate,
      'to_date': toDate,
      'wallet_type': walletType,
    },
  );

  final model = walletTransactionListModelFromMap(jsonEncode(response.data));

  ref.read(openingBalance.notifier).state = model.openingBalance ?? 0.0; // ✅ read
  ref.read(closingBalance.notifier).state = model.closingBalance ?? "0.0"; // ✅ read

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
