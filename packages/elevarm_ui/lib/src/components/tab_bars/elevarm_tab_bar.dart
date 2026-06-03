import 'package:collection/collection.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:elevarm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

/// Elevarm UI's Outline Tab Bar component widget.
class ElevarmTabBar extends StatelessWidget {
  /// Currently active index.
  final int activeIndex;

  /// Tabs' label.
  final List<String> labels;

  /// Callback when a tab is clicked.
  final void Function(int index) onChange;

  /// Whether the tab is expanded or not.
  final bool isTabExpanded;

  /// Whether the tab is scrollable or not.
  final bool isTabScrollable;

  final BoxDecoration decoration;

  final List<String?>? tagValues;

  final List<int?>? expandedFlexes;

  const ElevarmTabBar({
    required this.labels,
    required this.activeIndex,
    required this.onChange,
    super.key,
    this.isTabExpanded = true,
    this.isTabScrollable = false,
    this.decoration = const BoxDecoration(
      color: ElevarmColors.neutral50,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    this.tagValues,
    this.expandedFlexes,
  })  : assert(
          !(isTabExpanded && isTabScrollable),
          'Both isTabExpanded and isTabScrollable cannot be true',
        ),
        assert(
          tagValues == null || tagValues.length == labels.length,
          'tagValues length must match labels length',
        ),
        assert(
          expandedFlexes == null || expandedFlexes.length == labels.length,
          'expandedFlexes length must match labels length',
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
        ),
        child: isTabScrollable
            ? SingleChildScrollView(
                primary: false,
                scrollDirection: Axis.horizontal,
                child: _buildTabsContent(),
              )
            : _buildTabsContent(),
      ),
    );
  }

  /// Build tabs content widget.
  Widget _buildTabsContent() {
    return Row(
      children: labels.mapIndexed<Widget>(
        (index, label) {
          final tagValue = tagValues != null && index < tagValues!.length
              ? tagValues![index]
              : null;
          final expandedFlex =
              expandedFlexes != null && index < expandedFlexes!.length
                  ? expandedFlexes![index]
                  : null;
          if (index == activeIndex) {
            return _buildActiveTab(
              label: label,
              tagValue: tagValue,
              expandedFlex: expandedFlex ?? 1,
              onPressed: () {
                onChange(index);
              },
            );
          }
          return _buildInactiveTab(
            label: label,
            tagValue: tagValue,
            expandedFlex: expandedFlex ?? 1,
            onPressed: () {
              onChange(index);
            },
          );
        },
      ).toList(),
    );
  }

  /// Build active tab widget.
  Widget _buildActiveTab({
    required String label,
    required VoidCallback onPressed,
    required int expandedFlex,
    String? tagValue,
  }) {
    if (isTabExpanded) {
      return Expanded(
        flex: expandedFlex,
        child: _buildActiveTabContent(
          label: label,
          onPressed: onPressed,
          tagValue: tagValue,
        ),
      );
    } else {
      return _buildActiveTabContent(
        label: label,
        onPressed: onPressed,
        tagValue: tagValue,
      );
    }
  }

  /// Build active tab content widget.
  Widget _buildActiveTabContent({
    required String label,
    required VoidCallback onPressed,
    String? tagValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: ElevarmBoxShadow.sm,
        ),
        child: Material(
          color: ElevarmColors.white,
          borderRadius: BorderRadius.circular(6.0),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(6.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              child: Center(
                child: Row(
                  spacing: 4,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        label,
                        style: LibraryTextStyles.interSmSemiboldNeutral,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (tagValue != null)
                      ElevarmTag(
                        text: tagValue,
                        size: ElevarmTagSize.sm,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build inactive tab widget.
  Widget _buildInactiveTab({
    required String label,
    required VoidCallback onPressed,
    required int expandedFlex,
    String? tagValue,
  }) {
    if (isTabExpanded) {
      return Expanded(
        flex: expandedFlex,
        child: _buildInactiveTabContent(
          label: label,
          onPressed: onPressed,
          tagValue: tagValue,
        ),
      );
    } else {
      return _buildInactiveTabContent(
        label: label,
        onPressed: onPressed,
        tagValue: tagValue,
      );
    }
  }

  /// Build inactive tab widget.
  Widget _buildInactiveTabContent({
    required String label,
    required VoidCallback onPressed,
    String? tagValue,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 12.0,
          ),
          child: Center(
            child: Row(
              spacing: 4,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: LibraryTextStyles.interSmMediumNeutral300,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (tagValue != null)
                  ElevarmTag(
                    text: tagValue,
                    size: ElevarmTagSize.sm,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
