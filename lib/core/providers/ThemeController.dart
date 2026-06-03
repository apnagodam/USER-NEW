// providers/theme_controller.dart
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabIndexProvider = StateProvider<int>((ref) => 0);

// Maps tab index to a corresponding ThemeData
final dynamicThemeProvider = StateProvider<Color>((ref) {
  return ColorConstant.maingreen;
});
