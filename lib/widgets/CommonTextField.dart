import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/widgets/DateTextFormatter.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool isRequired;
  final bool isOnlyDigit;
  final bool? enabled;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final void Function(String)? onEditComplete;
  final void Function()? onEditingComplete;
  final double? height;
  final dynamic prefixIcon;
  final bool? filled;
  final dynamic fillColor;
  final bool? isPassword;
  final bool isDate;
  final FocusNode? focusNode;

  const CommonTextField({
    this.controller,
    this.label,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.isRequired = true,
    this.isOnlyDigit = false,
    this.enabled = true,
    this.textInputAction,
    this.onEditComplete,
    this.onEditingComplete,
    this.height,
    this.readOnly = false,
    super.key,
    this.prefixIcon,
    this.filled,
    this.fillColor,
    this.isPassword,
    this.focusNode,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevarmTextInputField(
      onChanged:
          onEditComplete != null ? (value) => onEditComplete!(value) : null,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      keyboardType: inputType,
      controller: controller,
      enabled: enabled ?? false,
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      obscureText: isPassword ?? false,
      isRequired: isRequired,
      inputFormatters: [
        // Use FilteringTextInputFormatter.digitsOnly to allow only digits
        isOnlyDigit
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.allow(RegExp(r'.*')),

        isDate
            ? DateTextFormatter()
            : FilteringTextInputFormatter.allow(RegExp(r'.*')),
      ],
      validator:
          isRequired
              ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this field';
                }
                return null;
              }
              : null,
      label: label ?? "",
      hintText: hintText,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      autocorrect: false,
    );
  }
}
