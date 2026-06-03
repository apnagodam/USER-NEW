import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/routes/RoutesStrings.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  var routesStrings = RoutesStrings();
  return GoRouter(
      debugLogDiagnostics: kDebugMode,
      redirect: (context, state) {
        if (ref.watch(sharedUtilityProvider).getToken().isEmpty) {
          if (state.fullPath == routesStrings.dashboard) {
            return routesStrings.login;
          }
          return null;
        }
        return null;
      },
      routes: []);
}
