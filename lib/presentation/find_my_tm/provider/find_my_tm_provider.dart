import 'package:apnagodam/presentation/find_my_tm/model/tm_model.dart';
import 'package:apnagodam/presentation/find_my_tm/service/find_my_tm_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final findMyTmServiceProvider = Provider<FindMyTmService>((ref) {
  return FindMyTmService();
});

/// Full list of TMs for the current session (dummy data in Phase 1).
final tmListProvider = FutureProvider<List<TmModel>>((ref) async {
  final service = ref.watch(findMyTmServiceProvider);
  return service.getTmList();
});

final tmSearchQueryProvider = StateProvider<String>((ref) => '');

final selectedTmProvider = StateProvider<TmModel?>((ref) => null);

/// TMs matching the current search query, filtered by name (case-insensitive).
final filteredTmListProvider = Provider<AsyncValue<List<TmModel>>>((ref) {
  final query = ref.watch(tmSearchQueryProvider).trim().toLowerCase();
  final tmListAsync = ref.watch(tmListProvider);

  return tmListAsync.whenData((tms) {
    if (query.isEmpty) return tms;
    return tms.where((tm) => tm.name.toLowerCase().contains(query)).toList();
  });
});
