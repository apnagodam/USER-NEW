import 'package:apnagodam/presentation/warehousefacility_screen/service/warehouse_facility_service.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/no_data_found_widget.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Outwardslist extends ConsumerStatefulWidget {
  const Outwardslist({super.key});

  @override
  ConsumerState<Outwardslist> createState() => _OutwardslistState();
}

class _OutwardslistState extends ConsumerState<Outwardslist> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(outwardsListProvider).isLoading;
    final data = ref.watch(outwardsListProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.outwardRequest3),
        backgroundColor: ColorConstant.maingreen,
        centerTitle: true,
        elevation: 2,
        toolbarHeight: 56,
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorConstant.maingreen, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search outwards...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorConstant.maingreen,
                  ),
                  suffixIcon:
                      _searchQuery.isNotEmpty
                          ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: ColorConstant.maingreen,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                          : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                style: TextStyle(fontSize: Adaptive.sp(14)),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child:
                isLoading
                    ? Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder:
                            (context, index) => Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: ColorConstant.maingreen,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 18,
                                            color: Colors.grey[300],
                                          ),
                                          Spacer(),
                                          Container(
                                            width: 60,
                                            height: 18,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        width: 120,
                                        height: 18,
                                        color: Colors.grey[300],
                                      ),
                                      SizedBox(height: 6),
                                      Container(
                                        width: 160,
                                        height: 18,
                                        color: Colors.grey[300],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 32,
                                            color: Colors.grey[300],
                                          ),
                                          Spacer(),
                                          Container(
                                            width: 80,
                                            height: 32,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      ),
                    )
                    : (() {
                      final all = data?.data ?? [];
                      if (all.isEmpty) return noStockData(context);

                      final filtered =
                          _searchQuery.trim().isEmpty
                              ? all
                              : all.where((item) {
                                final stack =
                                    (item.stackNumber ?? "")
                                        .toString()
                                        .toLowerCase();
                                final warehouse =
                                    (item.warehouseName ?? "")
                                        .toString()
                                        .toLowerCase();
                                final commodity =
                                    (item.commodityName ?? "")
                                        .toString()
                                        .toLowerCase();
                                final vehicle =
                                    (item.vehicleNo ?? "")
                                        .toString()
                                        .toLowerCase();
                                final driver =
                                    (item.driverNumber ?? "")
                                        .toString()
                                        .toLowerCase();
                                final q = _searchQuery.toLowerCase();
                                return stack.contains(q) ||
                                    warehouse.contains(q) ||
                                    commodity.contains(q) ||
                                    vehicle.contains(q) ||
                                    driver.contains(q);
                              }).toList();

                      if (filtered.isEmpty) return noStockData(context);

                      return ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: ColorConstant.maingreen,
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.commodityName ?? 'N/A',
                                            style: TextStyle(
                                              color: ColorConstant.maingreen,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Adaptive.sp(17),
                                            ),
                                          ),
                                        ),
                                        _buildStatusChip(item.status),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Divider(
                                      color: ColorConstant.maingreen,
                                      height: 1.0,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.warehouse,
                                          color: ColorConstant.maingreen,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            item.warehouseName ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(15),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.confirmation_number_rounded,
                                          color: ColorConstant.maingreen,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            "Stack Number: ${item.stackNumber ?? '-'}",
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(15),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.local_shipping,
                                          color: ColorConstant.maingreen,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            "${item.vehicleNo ?? 'N/A'} • ${item.driverNumber ?? 'N/A'}",
                                            style: TextStyle(
                                              fontSize: Adaptive.sp(15),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        simpleButton(
                                          text: 'Show Details',
                                          callback:
                                              () => _showDetailsDialog(
                                                context,
                                                item,
                                              ),
                                        ),
                                        Spacer(),
                                        if (item.status.toString() == "1" ||
                                            item.status.toString() == "2")
                                          ElevatedButton(
                                            onPressed:
                                                () => _showRejectDialog(
                                                  context,
                                                  item,
                                                ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 8,
                                              ),
                                            ),
                                            child: Text('Reject'),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    })(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(dynamic status) {
    String statusText;
    Color statusColor;

    switch (status.toString()) {
      case "0":
        statusText = AppLocalizations.of(context)!.msgStatusRejected;
        statusColor = Colors.grey;
        break;
      case "1":
        statusText = "Pending";
        statusColor = Colors.orange;
        break;
      case "2":
        statusText = AppLocalizations.of(context)!.msgSubmit;
        statusColor = Colors.green;
        break;
      default:
        statusText = "Unknown";
        statusColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.w600,
          fontSize: Adaptive.sp(13),
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, dynamic item) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (BuildContext dialogContext) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.info_outline, color: ColorConstant.maingreen),
                SizedBox(width: 8),
                Text(
                  'Outward Details',
                  style: TextStyle(color: ColorConstant.maingreen),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Commodity', item.commodityName ?? '-'),
                  _buildDetailRow('Stack Number', item.stackNumber ?? '-'),
                  _buildDetailRow('Terminal Name', item.warehouseName ?? '-'),
                  _buildDetailRow('Vehicle Number', item.vehicleNo ?? '-'),
                  _buildDetailRow('Driver Number', item.driverNumber ?? '-'),
                  _buildDetailRow('Status', _getStatusText(item.status)),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(
                  'Close',
                  style: TextStyle(color: ColorConstant.maingreen),
                ),
              ),
            ],
          ),
    );
  }

  void _showRejectDialog(BuildContext context, dynamic item) {
    ElevarmConfirmAlertDialog(
      title: AppLocalizations.of(context)!.areYouSure3,
      subtitle: AppLocalizations.of(context)!.youWantToCancelThisOutwardRequest,
      onPositiveButton: () {
        ref.watch(rejectOutwardsRequestProvider(id: "${item.id}").future).then((
          value,
        ) {
          if (value['status'].toString() == "1") {
            ref.invalidate(outwardsListProvider);
          }
        });
        Get.back();
      },
      onNegativeButton: () {
        Get.back();
      },
      positiveText: AppLocalizations.of(context)!.msgYes,
      negativeText: AppLocalizations.of(context)!.msgNo,
      variant: ElevarmDialogVariant.danger,
    ).show(context);
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
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

  String _getStatusText(dynamic status) {
    switch (status.toString()) {
      case "0":
        return AppLocalizations.of(context)!.msgStatusRejected;
      case "1":
        return "Pending";
      case "2":
        return AppLocalizations.of(context)!.msgSubmit;
      default:
        return "Unknown";
    }
  }
}
