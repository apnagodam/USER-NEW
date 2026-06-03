import 'dart:convert';

import 'package:apnagodam/presentation/add_money_screen/service/model/settings_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../../my_Stock/my_stock_impl/service/my_stock_impl.dart';

part 'add_money_service.g.dart';

@riverpod
Future<SettingsModel> settings(SettingsRef ref) async {
  var response = await ref.watch(dioProvider).get(SETTINGS_URL);
  return settingsModelFromMap(jsonEncode(response.data));
}
