import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/sbt/DispatchRequests/DispatchQualityScreen.dart';
import 'package:apnagodam/presentation/sbt/DispatchRequests/FactoryDispatchPhotoUpdate.dart';
import 'package:apnagodam/presentation/sbt/DispatchRequests/FactoryDispatchScreen.dart';
import 'package:apnagodam/presentation/sbt/service/SbtService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Factorydispatchlistingscreen extends ConsumerStatefulWidget {
  const Factorydispatchlistingscreen({super.key, required this.sbtOrderId});

  final String? sbtOrderId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FactorydispatchlistingscreenState();
}

class _FactorydispatchlistingscreenState
    extends ConsumerState<Factorydispatchlistingscreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Refresh data when screen is first loaded
    Future.microtask(() => ref.invalidate(dispatchListingNewProvider));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh data when app comes back to foreground
      ref.invalidate(dispatchListingNewProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.msgDispatchRequests,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Get.to(() => FactoryDispatchRequestsScreen(
                  sbtOrder: widget.sbtOrderId ?? ''));
              if (result == true) {
                ref.invalidate(dispatchListingNewProvider);
              }
            },
            tooltip: AppLocalizations.of(context)!.msgCreateDispatchRequest,
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[50],
        child: ref
            .watch(dispatchListingNewProvider(sbtOrderId: widget.sbtOrderId))
            .when(
              data: (data) {
                final requests = data['data'] as List<dynamic>? ?? [];
                if (requests.isEmpty) {
                  return Container();
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(dispatchRequestProvider(
                        sbtOrderId: widget.sbtOrderId ?? ""));
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final request = requests[index] as Map<String, dynamic>;
                      return _buildDispatchRequestCard(request);
                    },
                  ),
                );
              },
              error: (e, s) => Container(),
              loading: () => defaultLoader(),
            ),
      ),
    );
  }

  Widget _buildDispatchRequestCard(Map<String, dynamic> request) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        request['order_id']?.toString() ?? 'N/A',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    _buildStatusChip(request['dispatch_status']),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Request Date: ${request['request_date']?.toString() ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(height: 1, color: Colors.grey[100]),

          // Content Sections
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location Section
                _buildSectionTitle(
                    AppLocalizations.of(context)!.msgLocationDetails),
                SizedBox(height: 12),
                _buildDetailRow(AppLocalizations.of(context)!.msgAddress,
                    request['address']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.msgLocation,
                    request['location']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.msgDistrict,
                    request['district']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.msgState,
                    request['states']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.msgPinCode,
                    request['pin_code']?.toString() ?? 'N/A'),

                SizedBox(height: 20),

                // Weight & Quantity Section
                _buildSectionTitle(
                    AppLocalizations.of(context)!.msgWeightQuantity),
                SizedBox(height: 12),
                _buildDetailRow(AppLocalizations.of(context)!.weightInQuintals,
                    request['weight']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.msgBags,
                    request['bags']?.toString() ?? 'N/A'),

                SizedBox(height: 20),

                // Compliance Section
                _buildSectionTitle(
                    AppLocalizations.of(context)!.msgComplianceSales),
                SizedBox(height: 12),
                _buildDetailRow(
                    AppLocalizations.of(context)!.msgMandiCompliance,
                    request['mandi_compliance']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.salesType,
                    request['sales_status']?.toString() ?? 'N/A'),

                SizedBox(height: 20),

                // Transport Section
                _buildSectionTitle(
                    AppLocalizations.of(context)!.msgTransportInfo),
                SizedBox(height: 12),
                _buildDetailRow(AppLocalizations.of(context)!.msgTransportType,
                    request['transport_type']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.msgVehicleType,
                    request['vehicle_type']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.msgVehicleNumber,
                    request['vehicle_number']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.msgDriverNumber,
                    request['driver_number']?.toString() ?? 'N/A'),
                _buildDetailRow(AppLocalizations.of(context)!.msgBiltyNumber,
                    request['bilty_number']?.toString() ?? 'N/A'),
              ],
            ),
          ),

          // Action Buttons Section
          _buildActionButtons(request),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> request) {
    print(request);
    var dispatchStatus = request['dispatch_status']?.toString();
    final showAddQuality = (dispatchStatus == '1');
    final showAddImages = (dispatchStatus == '2');
    final showFinalSubmission = (dispatchStatus == '3');
    final isPendingApproval = (dispatchStatus == '4');

    // If status is 4, show only pending approval message
    if (isPendingApproval) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.orange[200]!,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.hourglass_empty,
                  color: Colors.orange[700],
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.msgPendingApproval,
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          // Main action buttons row
          if (showAddQuality || showAddImages)
            Row(
              children: [
                if (showAddQuality) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final result = await Get.to(Dispatchqualityscreen(
                          dispatchRequestId: request['id']?.toString(),
                          sbtOrderId: widget.sbtOrderId,
                        ));
                        if (result == true) {
                          ref.invalidate(dispatchListingNewProvider);
                        }
                      },
                      label:
                          Text(AppLocalizations.of(context)!.msgUpdateQuality),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.maingreen,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  if (showAddImages) SizedBox(width: 12),
                ],
                if (showAddImages) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final result = await Get.to(Factorydispatchphotoupdate(
                          sbtOrderId: widget.sbtOrderId,
                          dispatchRequestId: request['id']?.toString(),
                        ));
                        if (result == true) {
                          ref.invalidate(dispatchListingNewProvider);
                        }
                      },
                      label: Text(AppLocalizations.of(context)!.msgAddImages),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.maingreen,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          if (showAddQuality || showAddImages) SizedBox(height: 12),
          // Final submission button
          if (showFinalSubmission) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showFinalSubmissionPreview(request),
                label: Text(AppLocalizations.of(context)!.msgFinalSubmission),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.maingreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
          // Reject button
          if (!isPendingApproval) ...[
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _rejectDispatchRequest(request),
                label: Text(AppLocalizations.of(context)!.msgRejectRequest),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _rejectDispatchRequest(Map<String, dynamic> request) async {
    // Show confirmation dialog
    final shouldReject = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.msgRejectDispatchRequest),
          content: Text(
              'Are you sure you want to reject this dispatch request? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(AppLocalizations.of(context)!.msgCancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text(AppLocalizations.of(context)!.msgReject),
            ),
          ],
        );
      },
    );

    if (shouldReject == true) {
      try {
        final response = await ref.read(deleteDispatchRequestProvider(
          id: request['id']?.toString(),
          sbtOrderId: widget.sbtOrderId ?? "",
        ).future);

        if (response['status'] == '1') {
          Get.rawSnackbar(
            message:
                response['message'] ?? 'Dispatch request rejected successfully',
            backgroundColor: ColorConstant.maingreen,
            duration: Duration(seconds: 2),
          );
          // Refresh the list
          ref.invalidate(dispatchListingNewProvider);
        } else {
          Get.rawSnackbar(
            message: response['message'] ?? 'Failed to reject dispatch request',
            backgroundColor: Colors.red.shade600,
            duration: Duration(seconds: 2),
          );
        }
      } catch (e) {
        Get.rawSnackbar(
          message: 'Error rejecting dispatch request: ${e.toString()}',
          backgroundColor: Colors.red.shade600,
          duration: Duration(seconds: 2),
        );
      }
    }
  }

  void _showFinalSubmissionPreview(Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Final Submission Preview'),
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Dispatch Details'),
                    SizedBox(height: 8),
                    _buildDetailRow(
                        'Order ID', request['order_id']?.toString() ?? 'N/A'),
                    SizedBox(height: 16),
                    _buildSectionTitle('Location Information'),
                    SizedBox(height: 8),
                    _buildDetailRow(
                        'Address', request['address']?.toString() ?? 'N/A'),
                    // _buildDetailRow(
                    //     'Location', request['location']?.toString() ?? 'N/A'),
                    _buildDetailRow(
                        'District', request['district']?.toString() ?? 'N/A'),
                    _buildDetailRow(
                        'State', request['states']?.toString() ?? 'N/A'),
                    _buildDetailRow(
                        'Pin Code', request['pin_code']?.toString() ?? 'N/A'),
                    SizedBox(height: 16),
                    _buildSectionTitle('Quality & Quantity'),
                    SizedBox(height: 8),
                    _buildDetailRow('Weight (in Quintals)',
                        request['weight']?.toString() ?? 'N/A'),
                    _buildDetailRow(
                        'Bags', request['bags']?.toString() ?? 'N/A'),
                    SizedBox(height: 16),
                    _buildSectionTitle('Uploaded Documents'),
                    SizedBox(height: 8),
                    if (request['kanta_parchi_photo_with_url'] != null &&
                        request['kanta_parchi_photo_with_url']
                            .toString()
                            .isNotEmpty) ...[
                      _buildImageRow('Kanta Parchi',
                          request['kanta_parchi_photo_with_url'].toString()),
                      SizedBox(height: 8),
                    ],
                    if (request['bilty_with_url'] != null &&
                        request['bilty_with_url'].toString().isNotEmpty) ...[
                      _buildImageRow(
                          'Bilty', request['bilty_with_url'].toString()),
                      SizedBox(height: 8),
                    ],
                    if (request['load_truck_photo_with_url'] != null &&
                        request['load_truck_photo_with_url']
                            .toString()
                            .isNotEmpty) ...[
                      _buildImageRow('Load Truck Photo',
                          request['load_truck_photo_with_url'].toString()),
                      SizedBox(height: 8),
                    ],
                    if (request['truck_driver_photo_with_url'] != null &&
                        request['truck_driver_photo_with_url']
                            .toString()
                            .isNotEmpty) ...[
                      _buildImageRow('Truck Driver Photo',
                          request['truck_driver_photo_with_url'].toString()),
                      SizedBox(height: 8),
                    ],
                    if (request['quality_photo_with_url'] != null &&
                        request['quality_photo_with_url']
                            .toString()
                            .isNotEmpty) ...[
                      _buildImageRow('Quality Photo',
                          request['quality_photo_with_url'].toString()),
                      SizedBox(height: 8),
                    ],
                    if (request['mandi_tax_photo_with_url'] != null &&
                        request['mandi_tax_photo_with_url']
                            .toString()
                            .isNotEmpty) ...[
                      _buildImageRow('Mandi Tax Photo',
                          request['mandi_tax_photo_with_url'].toString()),
                      SizedBox(height: 8),
                    ],
                    SizedBox(height: 16),
                    Text(
                      'By proceeding with final submission, this dispatch request will be marked as completed and no further changes can be made.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _submitFinalDispatch(request);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.maingreen,
                  foregroundColor: Colors.white,
                ),
                child: Text(AppLocalizations.of(context)!.submitFinal),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitFinalDispatch(Map<String, dynamic> request) async {
    bool isLoading = true;

    // Show loading indicator
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Call the final dispatch submission API
      await ref.watch(finalDispatchSubmissionProvider(
        id: request['id']?.toString(),
        sbtOrderId: widget.sbtOrderId ?? "",
      ).future);

      isLoading = false;
      // Close loading dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // Show success message
      Get.rawSnackbar(
        message: 'Dispatch request submitted successfully!',
        backgroundColor: ColorConstant.maingreen,
        duration: Duration(seconds: 3),
      );

      // Refresh the list
      ref.invalidate(dispatchListingNewProvider);
    } catch (e) {
      isLoading = false;
      // Close loading dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // Show error message
      Get.rawSnackbar(
        message: 'Failed to submit dispatch request: ${e.toString()}',
        backgroundColor: Colors.red.shade600,
        duration: Duration(seconds: 3),
      );
    } finally {
      // Ensure dialog is closed if still showing
      if (isLoading && (Get.isDialogOpen ?? false)) {
        Get.back();
      }
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageRow(String label, String imageUrl) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => _showImagePreview(label, imageUrl),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey[400],
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(dynamic status) {
    final statusValue = status?.toString();
    final statusInfo = _getStatusInfo(statusValue);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusInfo['color']!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: statusInfo['color']!.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusInfo['color'],
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6),
          Text(
            statusInfo['text']!,
            style: TextStyle(
              color: statusInfo['color'],
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getStatusInfo(String? status) {
    switch (status) {
      case '1':
        return {
          'text': 'Active',
          'color': Colors.green[700]!,
        };
      case '0':
        return {
          'text': 'Inactive',
          'color': Colors.red[700]!,
        };
      default:
        return {
          'text': 'Pending',
          'color': Colors.orange[700]!,
        };
    }
  }

  void _showImagePreview(String title, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: EdgeInsets.all(10),
          child: Stack(
            children: [
              // Close button
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // Image
              Center(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.broken_image,
                              color: Colors.white70,
                              size: 60,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Failed to load image',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Title overlay
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
