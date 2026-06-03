import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:elevarm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

class ElevarmExpandableCard extends StatelessWidget {
  final bool initiallyExpanded;
  final String title;
  final String? subtitle;
  final Widget? badge;
  final List<Widget> children;
  final Color backgroundColor;
  final EdgeInsets childrenPadding;
  final List<BoxShadow>? boxShadow;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;

  const ElevarmExpandableCard({
    required this.title,
    required this.children,
    this.subtitle,
    this.badge,
    this.initiallyExpanded = true,
    this.backgroundColor = ElevarmColors.white,
    this.childrenPadding = const EdgeInsets.only(
      left: 16,
      right: 16,
      bottom: 16,
    ),
    this.boxShadow = ElevarmBoxShadow.xs,
    this.titleTextStyle,
    this.subtitleTextStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadow,
      ),
      child: ExpansionTile(
        dense: true,
        initiallyExpanded: initiallyExpanded,
        iconColor: ElevarmColors.neutral500,
        backgroundColor: backgroundColor,
        collapsedBackgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
          side: const BorderSide(
            color: ElevarmColors.neutral100,
          ),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ElevarmBorderRadius.sm),
          side: const BorderSide(
            color: ElevarmColors.neutral100,
          ),
        ),
        collapsedIconColor: ElevarmColors.neutral500,
        childrenPadding: childrenPadding,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: subtitle == null
              ? Row(
                  spacing: 16,
                  children: [
                    Text(
                      title,
                      style: titleTextStyle ??
                          LibraryTextStyles.interMdSemiboldNeutral,
                    ),
                    if (badge != null) ...[
                      badge!,
                    ],
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.0,
                  children: [
                    Row(
                      spacing: 16,
                      children: [
                        Text(
                          title,
                          style: titleTextStyle ??
                              LibraryTextStyles.interMdSemiboldNeutral,
                        ),
                        if (badge != null) ...[
                          badge!,
                        ],
                      ],
                    ),
                    Text(
                      subtitle!,
                      style: subtitleTextStyle ??
                          LibraryTextStyles.interSmRegularNeutral300,
                    ),
                  ],
                ),
        ),
        children: children,
      ),
    );
  }
}
