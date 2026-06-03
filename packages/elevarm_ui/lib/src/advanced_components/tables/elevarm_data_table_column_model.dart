import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';

class ElevarmDataTableColumnModel {
  final String label;
  final TextAlign textAlign;
  final bool isCheckbox;
  final ElevarmCheckboxSize checkboxSize;
  final bool checkboxChecked;
  final bool checkIndeterminate;
  final VoidCallback? checkboxOnPressed;

  ElevarmDataTableColumnModel({
    required this.label,
    required this.textAlign,
    this.isCheckbox = false,
    this.checkboxSize = ElevarmCheckboxSize.sm,
    this.checkboxChecked = false,
    this.checkIndeterminate = false,
    this.checkboxOnPressed,
  });
}
