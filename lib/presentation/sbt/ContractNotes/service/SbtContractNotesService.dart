import 'dart:convert';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/sbt/ContractNotes/model/SbtBuyerContractModel.dart';
import 'package:apnagodam/presentation/sbt/ContractNotes/model/SbtSellerContractModel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'SbtContractNotesService.g.dart';

@riverpod
Stream<SbtBuyerContractModel> buyerContractNote(BuyerContractNoteRef ref,
    {String? orderId, String? type}) async* {
  var response = await ref.watch(dioProvider).post(getSbtContractNote,
      queryParameters: {'order_id': orderId, "type": type});
  yield sbtBuyerContractModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<SbtSellerContractModel> sellerContractNote(SellerContractNoteRef ref,
    {String? orderId, String? type}) async* {
  var response = await ref.watch(dioProvider).post(getSbtContractNote,
      queryParameters: {'order_id': orderId, "type": type});
  yield sbtSellerContractModelFromMap(jsonEncode(response.data));
}
@riverpod
Stream<SbtBuyerContractModel> buyerContractNoteSBT(BuyerContractNoteSBTRef ref,
    {String? orderId, String? type}) async* {
  var response = await ref.watch(dioProvider).post(getBuyerSbtContractNote,
      queryParameters: {'order_id': orderId, "type": type});
  yield sbtBuyerContractModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<SbtSellerContractModel> sellerContractNoteSBT(SellerContractNoteSBTRef ref,
    {String? orderId, String? type}) async* {
  var response = await ref.watch(dioProvider).post(getBuyerSbtContractNote,
      queryParameters: {'order_id': orderId, "type": type});
  yield sbtSellerContractModelFromMap(jsonEncode(response.data));
}