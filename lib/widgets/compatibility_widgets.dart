// Compatibility layer for elevarm_ui - provides local implementations
import 'package:flutter/material.dart';

// Font size constants (matching elevarm_ui)
class ElevarmFontSizes {
  static const double xs = 12.0;
  static const double sm = 14.0;
  static const double md = 16.0;
  static const double lg = 18.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 28.0;
}

// Color constants (matching elevarm_ui)
class ElevarmColors {
  static const Color primary = Color(0xFF1976D2);
  static const Color secondary = Color(0xFF424242);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
}

// Divider widget replacement
class ElevarmDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final Color? color;

  const ElevarmDivider({Key? key, this.height, this.thickness, this.color})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness ?? 1.0,
      color: color ?? Colors.grey[300],
    );
  }
}

// Card widget replacement
class ElevarmNeutralCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const ElevarmNeutralCard({Key? key, this.child, this.padding, this.margin})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

// Text input field replacement
class ElevarmTextInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final void Function(String)? onChanged;

  const ElevarmTextInputField({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
    );
  }
}

// Primary button theme data
class ElevarmPrimaryButtonThemeData {
  final Color? backgroundColor;
  final double? height;
  final double? elevation;

  const ElevarmPrimaryButtonThemeData({
    this.backgroundColor,
    this.height,
    this.elevation,
  });
}

// Primary button replacement
class ElevarmPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ElevarmPrimaryButtonThemeData? buttonThemeData;

  const ElevarmPrimaryButton.text(
    this.text, {
    Key? key,
    this.onPressed,
    this.buttonThemeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonThemeData?.height ?? 48.0,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              buttonThemeData?.backgroundColor ??
              Theme.of(context).primaryColor,
          elevation: buttonThemeData?.elevation ?? 2.0,
        ),
        child: Text(text),
      ),
    );
  }
}

// Draggable bottom sheet replacement
Widget ElevarmDraggableBottomSheet({
  required BuildContext context,
  required Widget child,
  double? initialChildSize,
  double? minChildSize,
  double? maxChildSize,
}) {
  return DraggableScrollableSheet(
    initialChildSize: initialChildSize ?? 0.5,
    minChildSize: minChildSize ?? 0.25,
    maxChildSize: maxChildSize ?? 0.9,
    builder: (context, scrollController) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: child,
        ),
      );
    },
  );
}
