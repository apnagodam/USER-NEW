import 'dart:convert';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/warehouse_Tab/provider/model/inwards_summary_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'warehouse_repo_impl.g.dart';

@riverpod
Future<InwardsSummaryModel> getinwardsSummary(GetinwardsSummaryRef ref,
    {String search = '', int page = 0, int limit = 30}) async {

  var response = await ref
      .watch(dioProvider)
      .get('$APANA_U_GET_INWORD_REQUEST_LIST?limit=15&search=$search');

  return inwardsSummaryModelFromMap(jsonEncode(response.data));
}
