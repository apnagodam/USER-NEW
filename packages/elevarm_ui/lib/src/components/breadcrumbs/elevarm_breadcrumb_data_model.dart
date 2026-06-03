import 'dart:ui';

class ElevarmBreadcrumbDataModel {
  final String label;
  final VoidCallback? onPressed;

  ElevarmBreadcrumbDataModel({
    required this.label,
    this.onPressed,
  });
}
