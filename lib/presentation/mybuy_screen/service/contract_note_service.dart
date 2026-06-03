import 'dart:convert';

import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../model/ContractNoteModel.dart';

part 'contract_note_service.g.dart';

@riverpod
Future<ContractNoteModel> contractNotes(ContractNotesRef ref,
    {String? dealId = ''}) async {
  var response = await ref
      .watch(dioProvider)
      .get(CONTRACTNOTE, queryParameters: {"deal_id": dealId});

  return contractNoteModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> stackContractNote(StackContractNoteRef ref,
    {required String id}) async {
  var response = await ref
      .watch(dioProvider)
      .post(getStackContractNote, queryParameters: {'id': id});
  return response.data;
}
