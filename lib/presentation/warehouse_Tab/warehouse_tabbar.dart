import 'package:apnagodam/localization/app_localizations_extras.dart';
import 'package:apnagodam/presentation/dashboard/WarehouseBookings.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/OutwardsList.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/WarehouseBookingHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import '../warehousefacility_screen/inwardList.dart';
import '../warehousefacility_screen/stackinward_screen.dart';
import '../warehousefacility_screen/stackoutward_screen.dart';
import '../warehousefacility_screen/warehousefacility.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class WarehouseTab extends ConsumerWidget {
  WarehouseTab({super.key});

  // build-time localized titles (created inside build to access context)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleList = [
      AppLocalizations.of(context)!.msgStackboking2,
      AppLocalizations.of(context)!.msgStackinward3,
      AppLocalizations.of(context)!.msgStackoutward2,
      AppLocalizations.of(context)!.qualityConsent3,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titleList[ref.watch(selectedTabIndex)]),
        backgroundColor: ColorConstant.maingreen,
        centerTitle: true,
        actions: [
          ref.watch(selectedTabIndex) == 0
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: InkWell(
                      onTap: () {
                        Get.to(const Warehousebookinghistory());
                      },
                      child: Text(
                        AppLocalizations.of(context)!.bookingHistory2,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                            // fontStyle: FontStyle.normal,
                            ),
                      )),
                ))
              : ref.watch(selectedTabIndex) == 1
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      child: InkWell(
                          onTap: () {
                            Get.to(const InwardList());
                          },
                          child: Text(
                            AppLocalizations.of(context)!.inwordList,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                                // fontStyle: FontStyle.normal,
                                ),
                          )),
                    ))
                  : ref.watch(selectedTabIndex) == 2
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: InkWell(
                              onTap: () {
                                Get.to(const Outwardslist());
                              },
                              child: Text(
                                AppLocalizations.of(context)!.outwardsList2,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                    // fontStyle: FontStyle.normal,
                                    ),
                              )),
                        ))
                      : const SizedBox(),
        ],
      ),
      body: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(
                          6.0,
                        )),
                    child: TabBar(
                        onTap: (index) {
                          ref.watch(selectedTabIndex.notifier).state = index;
                        },
                        labelPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: ColorConstant.maingreen,
                        ),
                        tabs: [
                          Tab(
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.bookAstock,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(14)),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Tab(
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.msgStackinward,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(14)),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Tab(
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.msgStackoutward2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(14)),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Tab(
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.qualityConsent,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Adaptive.sp(14)),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Expanded(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      // controller: _tabController,
                      children: [
                    StackBooking(),
                    StackInward(),
                    StackOutward(),
                    Warehousebookings()
                  ]))
            ],
          )),
    );
  }

  final selectedTabIndex = StateProvider((ref) => 0);
}
