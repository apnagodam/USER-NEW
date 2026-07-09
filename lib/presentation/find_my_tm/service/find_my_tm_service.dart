import 'dart:convert';

import 'package:apnagodam/presentation/find_my_tm/model/tm_model.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Phase 1 (prototype) data source for "Find My TM": reads dummy TM
/// locations from a bundled JSON asset. Swap [getTmList] to call the
/// real backend API once it is available — callers only depend on this
/// method's return type, not on how the data is fetched.
class FindMyTmService {
  static const _assetPath = 'assets/data/tm_locations.json';

  Future<List<TmModel>> getTmList() async {
    final raw = await rootBundle.loadString(_assetPath);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final list = (decoded['tms'] as List<dynamic>? ?? []);
    return list
        .map((e) => TmModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
