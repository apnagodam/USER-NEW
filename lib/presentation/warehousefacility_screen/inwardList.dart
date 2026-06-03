import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/service/warehouse_facility_service.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/utils/color_constant.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

// ─────────────────────────────────────────────
// Reusable Dialog Components
// ─────────────────────────────────────────────

class ModularDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<DialogAction>? actions;
  final bool showCloseIcon;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;
  final double? borderRadius;

  const ModularDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.showCloseIcon = true,
    this.contentPadding,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
          color: backgroundColor ?? Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorConstant.maingreen.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius ?? 12.0),
                  topRight: Radius.circular(borderRadius ?? 12.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: ColorConstant.maingreen, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.maingreen,
                      ),
                    ),
                  ),
                  if (showCloseIcon)
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: Colors.grey[600], size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
            ),
            // Content
            Container(
              padding: contentPadding ?? const EdgeInsets.all(16),
              child: content,
            ),
            // Actions
            if (actions != null && actions!.isNotEmpty)
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!
                      .map((action) => Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: action,
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DialogAction extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Color? color;
  final bool isDestructive;

  const DialogAction({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
    this.color,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = isDestructive
        ? Colors.red
        : (color ?? (isPrimary ? ColorConstant.maingreen : Colors.grey[600]));

    return isPrimary
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          )
        : TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: buttonColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          );
  }
}

class ConfirmationDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => ModularDialog(
        title: title,
        showCloseIcon: false,
        content: Text(
          message,
          style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.4),
        ),
        actions: [
          DialogAction(
            text: cancelText,
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) onCancel();
            },
          ),
          DialogAction(
            text: confirmText,
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            isPrimary: true,
            isDestructive: isDestructive,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Status Helper
// ─────────────────────────────────────────────

/// Returns label + color based on numeric status from API
/// 0 = Rejected, 1 = Requested, 2 = Completed
Map<String, dynamic> _getStatusInfo(dynamic status) {
  final s = int.tryParse(status?.toString() ?? '') ?? -1;
  switch (s) {
    case 0:
      return {'label': 'Rejected', 'color': Colors.red};
    case 1:
      return {'label': 'Requested', 'color': Colors.orange};
    case 2:
      return {'label': 'Completed', 'color': Colors.green};
    default:
      return {'label': 'Unknown', 'color': Colors.grey};
  }
}

// ─────────────────────────────────────────────
// Main Screen
// ─────────────────────────────────────────────

class InwardList extends ConsumerStatefulWidget {
  const InwardList({super.key});

  @override
  ConsumerState<InwardList> createState() => _InwardListState();
}

class _InwardListState extends ConsumerState<InwardList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // ✅ Track locally rejected IDs in-memory (optimistic UI update)
  // Once list refreshes from API these will be reflected in status field
  final Set<String> _locallyRejectedIds = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(inwardsListProvider).isLoading;
    final data = ref.watch(inwardsListProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.inwards3),
        backgroundColor: ColorConstant.maingreen,
        centerTitle: true,
        elevation: 2,
        toolbarHeight: 56,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorConstant.maingreen, width: 1.0),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1)),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search inwards...',
                  prefixIcon: Icon(Icons.search, color: ColorConstant.maingreen),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: ColorConstant.maingreen),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
                style: TextStyle(fontSize: Adaptive.sp(14)),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: isLoading
                ? _buildSkeletonList()
                : _buildList(data),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // List Builder
  // ─────────────────────────────────────────────

  Widget _buildList(dynamic data) {
    final all = data?.data?.data ?? [];

    // ✅ Apply search filter only — show ALL statuses (0, 1, 2)
 final filtered = _searchQuery.trim().isEmpty
    ? all  // ✅ No filter, show all items
    : all.where((item) {
        final commodity = (item.category ?? '').toString().toLowerCase();
        final stack = (item.stackNumber ?? '').toString().toLowerCase();
        final location = (item.name ?? '').toString().toLowerCase();
        final q = _searchQuery.toLowerCase();
        return commodity.contains(q) || stack.contains(q) || location.contains(q);
      }).toList();

    if (filtered.isEmpty) return noStockData(context);

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];

        // ✅ If user just rejected this in current session, override status to 0
        final effectiveStatus = _locallyRejectedIds.contains(item.id.toString())
            ? 0
            : (int.tryParse(item.status?.toString() ?? '') ?? -1);

        final statusInfo = _getStatusInfo(effectiveStatus);
        final isRequested = effectiveStatus == 1;

        // Format date
        String formattedDate = '-';
        if (item.createdAt != null && '${item.createdAt}'.length >= 10) {
          try {
            formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.parse('${item.createdAt}'));
          } catch (_) {}
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorConstant.maingreen, width: 1.0),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Row 1: Category + Date + Status Badge ──
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.category ?? '-',
                          style: TextStyle(
                            color: ColorConstant.maingreen,
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(17),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Date chip
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          formattedDate,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: Adaptive.sp(13),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // ✅ Status badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (statusInfo['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: (statusInfo['color'] as Color).withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          statusInfo['label'] as String,
                          style: TextStyle(
                            color: statusInfo['color'] as Color,
                            fontWeight: FontWeight.w600,
                            fontSize: Adaptive.sp(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Divider(color: ColorConstant.maingreen, height: 1.0),
                  const SizedBox(height: 8),

                  // ── Stack Number ──
                  Row(
                    children: [
                      Icon(Icons.confirmation_number_rounded, color: ColorConstant.maingreen, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Stack Number: ${item.stackNumber ?? '-'}',
                        style: TextStyle(fontSize: Adaptive.sp(15), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // ── Location ──
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: ColorConstant.maingreen, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.name ?? 'N/A',
                          style: TextStyle(fontSize: Adaptive.sp(15), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // ── Quantity ──
                  Row(
                    children: [
                      Icon(Icons.inventory_2_rounded, color: ColorConstant.maingreen, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Qty: ${item.requestWeight ?? '-'} quintal',
                        style: TextStyle(fontSize: Adaptive.sp(15), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // ── Action Buttons ──
                  Row(
                    children: [
                      // Show Details (always visible)
                      Expanded(
                        child: simpleButton(
                          text: 'Show Details',
                          callback: () => _showDetailsDialog(context, item),
                        ),
                      ),

                      // ✅ Reject button — only for status = 1 (Requested)
                      if (isRequested) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _alertDialog(item.id.toString()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Reject'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────────
  // Details Dialog
  // ─────────────────────────────────────────────

  void _showDetailsDialog(BuildContext context, dynamic item) {
    final effectiveStatus = _locallyRejectedIds.contains(item.id.toString())
        ? 0
        : (int.tryParse(item.status?.toString() ?? '') ?? -1);
    final statusInfo = _getStatusInfo(effectiveStatus);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: ColorConstant.maingreen),
            const SizedBox(width: 8),
            Text('Inward Details', style: TextStyle(color: ColorConstant.maingreen)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Category', item.category ?? '-'),
              _buildDetailRow('Stack', item.stackNumber ?? '-'),
              _buildDetailRow('Location', item.name ?? '-'),
              _buildDetailRow('Quantity', '${item.requestWeight ?? '-'} quintal'),
              _buildDetailRow(
                'Date',
                item.createdAt != null
                    ? DateFormat('dd MMM yyyy').format(DateTime.parse('${item.createdAt}'))
                    : '-',
              ),
              // ✅ Status with colored text
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        'Status:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: (statusInfo['color'] as Color).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        statusInfo['label'] as String,
                        style: TextStyle(
                          color: statusInfo['color'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Close', style: TextStyle(color: ColorConstant.maingreen)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Reject Confirm Dialog
  // ─────────────────────────────────────────────

void _alertDialog(String id) {
  ConfirmationDialog.show(
    context: context,
    title: AppLocalizations.of(context)!.msgDeletetitale,
    message: AppLocalizations.of(context)!.msgDeleteMassage,
    onConfirm: () async {
      // ✅ Instantly show "Rejected" on the card — no waiting
      setState(() => _locallyRejectedIds.add(id));

      try {
        final value = await ref.read(rejectOrderProvider(orderId: id).future);
        if (value['status'].toString() == '1') {
          // ✅ Refresh list from API in background
          ref.refresh(inwardsListProvider);
        } else {
          // ✅ Rollback if API said it failed
          setState(() => _locallyRejectedIds.remove(id));
        }
      } catch (e) {
        // ✅ Rollback on error
        setState(() => _locallyRejectedIds.remove(id));
      }
    },
    confirmText: AppLocalizations.of(context)!.msgOk,
    cancelText: AppLocalizations.of(context)!.msgCencel,
    isDestructive: true,
  );
}

  // ─────────────────────────────────────────────
  // Detail Row Widget
  // ─────────────────────────────────────────────

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Skeleton Loader
  // ─────────────────────────────────────────────

  Widget _buildSkeletonList() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorConstant.maingreen, width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(width: 80, height: 18, color: Colors.grey[300]),
                      const Spacer(),
                      Container(width: 60, height: 18, color: Colors.grey[300]),
                      const SizedBox(width: 8),
                      Container(width: 80, height: 18, color: Colors.grey[300]),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(width: 120, height: 18, color: Colors.grey[300]),
                  const SizedBox(height: 6),
                  Container(width: 80, height: 18, color: Colors.grey[300]),
                  const SizedBox(height: 6),
                  Container(width: 160, height: 18, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(width: 120, height: 36, color: Colors.grey[300]),
                      const Spacer(),
                      Container(width: 80, height: 18, color: Colors.grey[300]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}