import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/service/warehouse_facility_service.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Warehousebookinghistory extends ConsumerStatefulWidget {
  const Warehousebookinghistory({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WarehousebookinghistoryState();
}

class _WarehousebookinghistoryState
    extends ConsumerState<Warehousebookinghistory> {
  /// Track which row index is currently rejecting (to show a per-row loader)
  final Set<int> _rejecting = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.invalidate(stackBookHistoryProvider);
        },
        child: ref.watch(stackBookHistoryProvider).when(
              data: (data) {
                final stackHistory = data.data;
                if (stackHistory == null || stackHistory.isEmpty) {
                  return Center(
                      child: Text(AppLocalizations.of(context)!.noBookingHistoryAvailable2));
                }

                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        decoration: BoxDecoration(
                          color: ColorConstant.maingreen,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              const SizedBox(width: 4),
                              _HeaderCell(
                                  AppLocalizations.of(context)!.msgStackno),
                              _VLine(
                                  color: Colors.white.withOpacity(0.35),
                                  height: 18),
                              _HeaderCell(AppLocalizations.of(context)!
                                  .msgTerminalname),
                              _VLine(
                                  color: Colors.white.withOpacity(0.35),
                                  height: 18),
                              _HeaderCell(
                                  AppLocalizations.of(context)!.msgCommodityy),
                              _VLine(
                                  color: Colors.white.withOpacity(0.35),
                                  height: 18),
                              _HeaderCell(
                                  AppLocalizations.of(context)!.msgAction),
                              const SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Rows
                      Expanded(
                        child: ListView.separated(
                          itemCount: stackHistory.length,
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Divider(
                              color: Colors.grey.shade300,
                              height: 1,
                              thickness: 1,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            final item = stackHistory[index];
                            final isRejecting = _rejecting.contains(index);

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                color: index.isEven
                                    ? Colors.white
                                    : Colors.grey.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    _TableCell('${item.stackNumber}'),
                                    _VLine(),
                                    _TableCell('${item.warehosueName}'),
                                    _VLine(),
                                    _TableCell('${item.commodityName}'),
                                    _VLine(),
                                    _ActionCell(
                                      status: item.status,
                                      isLoading: isRejecting,
                                      onView: () =>
                                          _showDetailsDialog(context, item),
                                      onReject: item.status == 1
                                          ? () => _confirmAndReject(
                                              context, item, index)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (e, s) => Container(),
              loading: () => listSkeleton(context),
            ),
      ),
    );
  }

  Future<void> _confirmAndReject(
      BuildContext context, dynamic item, int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(AppLocalizations.of(context)!.reject),
        content: Text(AppLocalizations.of(context)!.areYouSureYouWantToRejectThisBooking2),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppLocalizations.of(context)!.cancel3),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(AppLocalizations.of(context)!.reject),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _rejectStack(item, index);
    }
  }

  Future<void> _rejectStack(dynamic item, int index) async {
    setState(() => _rejecting.add(index));
    try {
      // ⚠️ Replace with your real reject call in warehouse_facility_service.dart
      // final service = WarehouseFacilityService();

      // Common possibilities — keep the one that exists and remove the others:
      // await service.rejectStack(item.id.toString());
      // await service.rejectBooking(item.id.toString());
      // await service.rejectWarehouseBooking(item.id.toString());

      // If the API needs only stackNumber, use this:
      // await service.rejectStack(item.stackNumber.toString());

      // TODO: Remove this throw once you hook the correct call:
      // throw UnimplementedError('Wire the real reject API call here.');

      // On success:
      if (!mounted) return;
      Get.snackbar(AppLocalizations.of(context)!.success3, AppLocalizations.of(context)!.bookingRejectedSuccessfully2,
          snackPosition: SnackPosition.BOTTOM);
      ref.invalidate(stackBookHistoryProvider);
    } catch (e) {
      if (!mounted) return;
      Get.snackbar(AppLocalizations.of(context)!.error2, e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1));
    } finally {
      if (mounted) setState(() => _rejecting.remove(index));
    }
  }

  void _showDetailsDialog(BuildContext context, dynamic item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.all(8),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DetailRow(AppLocalizations.of(context)!.msgStackno,
                '${item.stackNumber}'),
            _DetailRow(AppLocalizations.of(context)!.msgTerminalname,
                '${item.warehosueName}'),
            _DetailRow(AppLocalizations.of(context)!.msgCommodity,
                '${item.commodityName}'),
            _DetailRow(
                AppLocalizations.of(context)!.msgNetweight, '${item.weight}'),
          ],
        ),
      ),
    );
  }
}

/* ---------- Helpers ---------- */

class _VLine extends StatelessWidget {
  final Color? color;
  final double height;
  const _VLine({this.color, this.height = 24});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      color: color ?? Colors.grey.shade300,
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppStyle.wallatmoneylist.copyWith(
          fontSize: Adaptive.sp(17),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  const _TableCell(this.text);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Adaptive.sp(16),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _ActionCell extends StatelessWidget {
  final int status; // 0=rejected, 1=pending, 2=approved/submitted
  final bool isLoading;
  final VoidCallback? onReject;
  final VoidCallback onView;

  const _ActionCell({
    required this.status,
    required this.isLoading,
    required this.onView,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    Widget primary;

    if (status == 1) {
      // Pending -> show Reject button
      primary = SizedBox(
        height: 32,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          onPressed: isLoading ? null : onReject,
          child: isLoading
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : Text(AppLocalizations.of(context)!.reject,
                  style: const TextStyle(color: Colors.white)),
        ),
      );
    } else if (status == 0) {
      primary = _StatusChip(
          text: AppLocalizations.of(context)!.msgStatusRejected,
          color: Colors.grey);
    } else if (status == 2) {
      primary = _StatusChip(
          text: AppLocalizations.of(context)!.msgSubmit, color: Colors.green);
    } else {
      primary = const SizedBox.shrink();
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          primary,
          IconButton(
            icon: Icon(Icons.remove_red_eye, color: ColorConstant.maingreen),
            onPressed: onView,
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String text;
  final Color color;
  const _StatusChip({required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color.withOpacity(0.35)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(child: Text(label, style: AppStyle.lbleyepopup)),
              VerticalDivider(
                  width: 5, thickness: 1, color: ColorConstant.grey),
              Expanded(child: Text(value, style: AppStyle.lbleyepopupsecond)),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }
}
