import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/MandiTaxProfileScreen.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/Service/MandiTaxProfileService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Manditaxlistingscreen extends ConsumerWidget {
  const Manditaxlistingscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(mandiTaxProfilesProvider).isLoading;
    final data = ref.watch(mandiTaxProfilesProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myMandiTaxProfiles),
        backgroundColor: ColorConstant.maingreen,
        centerTitle: true,
        elevation: 2,
        toolbarHeight: 56,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(Manditaxprofilescreen(isAppbarVisible: true));
            },
            icon: Icon(Icons.add, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          Expanded(
            child: isLoading
                ? _buildSkeletonLoader()
                : _buildProfileList(context, data?.data ?? []),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorConstant.maingreen, width: 1.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 120, height: 20, color: Colors.grey[300]),
                    Spacer(),
                    Container(width: 80, height: 16, color: Colors.grey[300]),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                    width: double.infinity, height: 1, color: Colors.grey[300]),
                SizedBox(height: 8),
                Container(width: 100, height: 16, color: Colors.grey[300]),
                SizedBox(height: 6),
                Container(width: 150, height: 16, color: Colors.grey[300]),
                SizedBox(height: 6),
                Container(width: 120, height: 16, color: Colors.grey[300]),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(width: 100, height: 32, color: Colors.grey[300]),
                    SizedBox(width: 8),
                    Container(width: 80, height: 32, color: Colors.grey[300]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileList(BuildContext context, List profiles) {
    if (profiles.isEmpty) {
      return noStockData(context);
    }

    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final item = profiles[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorConstant.maingreen, width: 1.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.licanceNumber ?? 'N/A',
                          style: TextStyle(
                            color: ColorConstant.maingreen,
                            fontWeight: FontWeight.bold,
                            fontSize: Adaptive.sp(17),
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.issueDate ?? '-',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: Adaptive.sp(13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(color: ColorConstant.maingreen, height: 1.0),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_city_rounded,
                          color: ColorConstant.maingreen, size: 16),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.districtName ?? 'N/A',
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
                      Icon(Icons.person_rounded,
                          color: ColorConstant.maingreen, size: 16),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.userName ?? 'N/A',
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
                      Icon(Icons.business_rounded,
                          color: ColorConstant.maingreen, size: 16),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.licanceType ?? 'N/A',
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
                      ElevatedButton.icon(
                        onPressed: () => _showDetailsDialog(context, item),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.maingreen,
                          foregroundColor: Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: null,
                        label: Text(AppLocalizations.of(context)!.detail,
                            style: TextStyle(fontSize: 14)),
                      ),
                      SizedBox(width: 8),
                      // OutlinedButton.icon(
                      //   onPressed: () {
                      //     Get.to(Manditaxprofilescreen(isAppbarVisible: true));
                      //   },
                      //   style: OutlinedButton.styleFrom(
                      //     foregroundColor: ColorConstant.maingreen,
                      //     side: BorderSide(color: ColorConstant.maingreen),
                      //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //   ),
                      //   icon: Icon(Icons.edit, size: 16),
                      //   label: Text('Edit', style: TextStyle(fontSize: 14)),
                      // ),
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

  void _showDetailsDialog(BuildContext context, dynamic item) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: ColorConstant.maingreen),
            SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.msgLicenseDetails,
                style: TextStyle(color: ColorConstant.maingreen)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow(AppLocalizations.of(context)!.msgLicenseNo,
                  item.licanceNumber ?? '-'),
              _buildDetailRow(AppLocalizations.of(context)!.msgLicenseType,
                  item.licanceType ?? '-'),
              _buildDetailRow(AppLocalizations.of(context)!.msgLicenseHolder,
                  item.userName ?? '-'),
              _buildDetailRow(AppLocalizations.of(context)!.msgDistrict,
                  item.districtName ?? '-'),
              _buildDetailRow(AppLocalizations.of(context)!.msgState,
                  item.stateName ?? '-'),
              _buildDetailRow(
                  AppLocalizations.of(context)!.msgPhone, item.phone ?? '-'),
              _buildDetailRow(AppLocalizations.of(context)!.msgIssueDate,
                  item.issueDate ?? '-'),
              _buildDetailRow(AppLocalizations.of(context)!.msgExpiryDate,
                  item.expiryDate ?? '-'),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // OutlinedButton(
              //   onPressed: () {
              //     Navigator.of(dialogContext).pop();
              //     // Add delete functionality here
              //   },
              //   style: OutlinedButton.styleFrom(
              //     foregroundColor: Colors.red,
              //     side: BorderSide(color: Colors.red),
              //   ),
              //   child: Text('Delete'),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(dialogContext).pop();
              //     Get.to(Manditaxprofilescreen(isAppbarVisible: true));
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: ColorConstant.maingreen,
              //   ),
              //   child: Text('Edit',style: TextStyle(color: Colors.white),),
              // ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(AppLocalizations.of(context)!.msgClose,
                    style: TextStyle(color: ColorConstant.maingreen)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
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
}
