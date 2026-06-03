import 'package:flutter/material.dart';
// import 'package:just_the_tooltip/just_the_tooltip.dart';

/// Custom stacked horizontal bar chart data point class that supports any numeric value.
class CustomStackedHorizontalBarChartData<T> {
  /// The data point's label.
  final String label;

  /// The data point's value (supports int, double, and num).
  final num value;

  /// The data point's color.
  final Color color;

  /// The data point's custom data.
  final T? customData;

  CustomStackedHorizontalBarChartData({
    required this.label,
    required this.value,
    required this.color,
    this.customData,
  });
}

/// Custom stacked horizontal bar chart that supports decimal and integer values.
class CustomStackedHorizontalBarChart extends StatelessWidget {
  /// Chart's list of data.
  final List<CustomStackedHorizontalBarChartData> dataSource;

  /// String builder for legend value. If null, raw value will be used.
  final String Function(CustomStackedHorizontalBarChartData data)?
      legendValueBuilder;

  /// Chart's tooltip title.
  final String? tooltipTitle;

  /// Decimal places for displaying values (default: 2).
  final int decimalPlaces;

  const CustomStackedHorizontalBarChart({
    required this.dataSource,
    this.legendValueBuilder,
    this.tooltipTitle,
    this.decimalPlaces = 2,
    super.key,
  });

  String _formatValue(num value) {
    if (value is int || value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(decimalPlaces);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total for proportional display
    final total = dataSource.fold<num>(0, (sum, item) => sum + item.value);

    return Column(
      children: [
        SizedBox(
          height: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...dataSource.map(
                  (dataPoint) {
                    // Calculate flex value (proportional width)
                    final flexValue = total > 0
                        ? ((dataPoint.value / total) * 1000).round()
                        : 1;

                    return Expanded(
                      flex: flexValue,
                      child: Tooltip(
                        message:
                            '${dataPoint.label}: ${legendValueBuilder != null ? legendValueBuilder!(dataPoint) : _formatValue(dataPoint.value)}',
                        decoration: BoxDecoration(
                          color: const Color(0xFF2F2F2F),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        child: Container(
                          color: dataPoint.color,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Column(
          children: [
            ...dataSource.asMap().entries.map(
              (entry) {
                final dataPoint = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: dataPoint.color,
                              ),
                              height: 8.0,
                              width: 8.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: '${dataPoint.label}: ',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4B5563),
                              ),
                              children: [
                                TextSpan(
                                  text: legendValueBuilder != null
                                      ? legendValueBuilder!(dataPoint)
                                      : _formatValue(dataPoint.value),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF4B5563),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    entry.key < dataSource.length - 1
                        ? const SizedBox(height: 8.0)
                        : Container(),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
