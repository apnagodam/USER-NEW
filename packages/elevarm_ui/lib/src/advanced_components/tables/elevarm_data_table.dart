import 'package:collection/collection.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:elevarm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';

class ElevarmDataTable extends StatelessWidget {
  final ScrollController scrollController;
  final List<ElevarmDataTableColumnModel> columns;
  final List<DataRow> rows;
  final bool isLoading;
  final bool usePaginationFooter;
  final int? currentPage;
  final int? numPages;
  final int? totalData;
  final int? perPage;
  final VoidCallback? onPressedPrevious;
  final VoidCallback? onPressedNext;
  final Function(int page)? onPressedPage;
  final bool isMobile;
  final void Function(int? value)? onChangedLimit;

  const ElevarmDataTable({
    required this.columns,
    required this.rows,
    required this.scrollController,
    this.onChangedLimit,
    this.currentPage,
    this.numPages,
    this.totalData,
    this.perPage,
    super.key,
    this.isLoading = false,
    this.onPressedPrevious,
    this.onPressedNext,
    this.onPressedPage,
    this.usePaginationFooter = true,
    this.isMobile = false,
  }) : assert(
          (usePaginationFooter &&
                  currentPage != null &&
                  numPages != null &&
                  totalData != null &&
                  perPage != null &&
                  onChangedLimit != null) ||
              !usePaginationFooter,
          '''When 'usePaginationFooter' is true, then 'currentPage', 'numPages', 'totalData', 'perPage', and 'onChangedLimit' must not be null.''',
        );

  @override
  Widget build(BuildContext context) {
    List<DataRow> finalRows = rows;
    if (rows.isEmpty) {
      if (isLoading) {
        finalRows = [
          DataRow(
            cells: columns
                .mapIndexed(
                  (index, e) =>
                      DataCell(Text(index == 0 ? 'Memuat data...' : '')),
                )
                .toList(),
          ),
        ];
      } else {
        finalRows = [
          DataRow(
            cells: columns
                .mapIndexed(
                  (index, e) => DataCell(Text(index == 0 ? 'Data kosong' : '')),
                )
                .toList(),
          ),
        ];
      }
    }

    return Column(
      children: [
        if (isLoading && rows.isNotEmpty)
          const ElevarmLinearProgressIndicator(
            minHeight: 4.0,
          ),
        SizedBox(
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Scrollbar(
                thickness: 8.0,
                radius: const Radius.circular(8.0),
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraint.minWidth),
                    child: DataTable(
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                          color: ElevarmColors.neutral50,
                        ),
                        bottom: BorderSide(
                          color: ElevarmColors.neutral50,
                        ),
                      ),
                      dividerThickness: 1,
                      columnSpacing: 32,
                      horizontalMargin: 16,
                      dataRowMaxHeight: double.infinity,
                      dataRowMinHeight: 52,
                      dataRowColor:
                          WidgetStateProperty.all(ElevarmColors.white),
                      headingRowHeight: 44,
                      headingRowColor:
                          WidgetStateProperty.all(ElevarmColors.neutral50),
                      columns:
                          columns.map((e) => _buildTableHeader(e)).toList(),
                      rows: finalRows,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (usePaginationFooter) ..._buildPaginationFooter(),
      ],
    );
  }

  List<Widget> _buildPaginationFooter() {
    bool canPressedPrevious = !isLoading && currentPage! > 1;
    bool canPressedNext = !isLoading && currentPage! < numPages!;
    return [
      const SizedBox(height: 12.0),
      isMobile
          ? ElevarmMobilePaginationFooter(
              currentPage: currentPage!,
              numPages: numPages!,
              onPressedPrevious: canPressedPrevious ? onPressedPrevious : null,
              onPressedNext: canPressedNext ? onPressedNext : null,
            )
          : ElevarmDesktopPaginationFooter(
              currentPage: currentPage!,
              numPages: numPages!,
              onPressedPrevious: canPressedPrevious ? onPressedPrevious : null,
              onPressedNext: canPressedNext ? onPressedNext : null,
              onPressedPage: !isLoading ? onPressedPage : null,
              onChangedLimit: onChangedLimit,
              totalData: totalData,
              perPage: perPage,
            ),
    ];
  }

  DataColumn _buildTableHeader(
    ElevarmDataTableColumnModel column,
  ) {
    return DataColumn(
      label: Expanded(
        child: !column.isCheckbox
            ? Text(
                column.label,
                style: LibraryTextStyles.interXsMediumNeutral,
                textAlign: column.textAlign,
              )
            : ElevarmCheckbox(
                size: column.checkboxSize,
                checked: column.checkboxChecked,
                indeterminate: column.checkIndeterminate,
                onPressed: column.checkboxOnPressed,
              ),
      ),
    );
  }
}
