// ignore_for_file: deprecated_member_use_from_same_package

import 'package:elevarm_icons/elevarm_icons.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:elevarm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

class ElevarmBreadcrumb extends StatelessWidget {
  final IconData icon;
  @Deprecated('Use data instead')
  final List<String> steps;
  final List<ElevarmBreadcrumbDataModel>? data;
  final Widget Function(
    BuildContext context,
    int index,
    ElevarmBreadcrumbDataModel data,
    Widget child,
  )? buildLink;

  const ElevarmBreadcrumb({
    required this.icon,
    @Deprecated('Use data instead') this.steps = const [],
    this.data,
    this.buildLink,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> breadcrumbs = [];

    if (data != null) {
      for (var i = 0; i < data!.length; i++) {
        String step = data![i].label;
        VoidCallback? onPressed = data![i].onPressed;
        bool isLastStep = i == data!.length - 1;
        // Add step
        if (isLastStep) {
          breadcrumbs.add(
            Text(
              step,
              style: LibraryTextStyles.interSmMediumPrimary500,
            ),
          );
        } else {
          if (onPressed != null) {
            Widget child = ElevarmLinkNeutralButton.text(
              text: step,
              height: ElevarmButtonHeights.sm,
              onPressed: onPressed,
            );
            if (buildLink != null) {
              breadcrumbs.add(buildLink!(context, i, data![i], child));
            } else {
              breadcrumbs.add(child);
            }
          } else {
            breadcrumbs.add(
              Text(
                step,
                style: LibraryTextStyles.interSmRegularNeutral400,
              ),
            );
          }
        }
        // Add separator if not last step
        if (!isLastStep) {
          breadcrumbs.addAll([
            const SizedBox(width: 8.0),
            const ElevarmIcon(
              ElevarmIconsOutline.chevron_right,
              size: 16,
              color: ElevarmColors.neutral200,
            ),
            const SizedBox(width: 8.0),
          ]);
        }
      }
    } else {
      for (var i = 0; i < steps.length; i++) {
        String step = steps[i];
        bool isLastStep = i == steps.length - 1;
        // Add step
        breadcrumbs.add(
          Text(
            step,
            style: !isLastStep
                ? LibraryTextStyles.interSmRegularNeutral400
                : LibraryTextStyles.interSmMediumPrimary500,
          ),
        );
        // Add separator if not last step
        if (!isLastStep) {
          breadcrumbs.addAll([
            const SizedBox(width: 8.0),
            const ElevarmIcon(
              ElevarmIconsOutline.chevron_right,
              size: 16,
              color: ElevarmColors.neutral200,
            ),
            const SizedBox(width: 8.0),
          ]);
        }
      }
    }

    return Wrap(
      runSpacing: 8.0,
      direction: Axis.horizontal,
      children: [
        ElevarmIcon(
          icon,
          color: ElevarmColors.neutral400,
          size: 16.0,
        ),
        const SizedBox(width: 4.0),
        ...breadcrumbs,
      ],
    );
  }
}
