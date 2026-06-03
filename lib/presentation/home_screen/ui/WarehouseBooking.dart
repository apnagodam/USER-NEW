import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/home_screen/ui/Findwarehousescreen.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackinward_screen.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/stackoutward_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Warehousebooking extends ConsumerStatefulWidget {
  const Warehousebooking({super.key});

  @override
  ConsumerState<Warehousebooking> createState() => _WarehousebookingState();
}

class _WarehousebookingState extends ConsumerState<Warehousebooking> {
  List<Map<String, dynamic>> get tabs => [
        {
          "label": AppLocalizations.of(context)!.findWarehouses,
          "index": 0,
          "icon": Icons.warehouse
        },
        {
          "label": AppLocalizations.of(context)!.inwardRequest,
          "index": 1,
          "icon": Icons.warehouse
        },
        {
          "label": AppLocalizations.of(context)!.outwardRequest,
          "index": 2,
          "icon": Icons.receipt_long
        },
      ];
  var selectedTabIndex = StateProvider((ref) => 0);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10), // Increased padding
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ]),
                child: TabBar(
                    onTap: (index) {
                      ref.watch(selectedTabIndex.notifier).state = index;
                    },
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                      fontSize: Adaptive.sp(15),
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelColor: Colors.black87,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstant.maingreen,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.maingreen.withOpacity(0.18),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.findWarehouses,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.inwardRequest,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.outwardRequest,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
                child: TabBarView(children: [
              Findwarehousescreen(),
              StackInward(),
              StackOutward(),
            ])),
          ],
        ));
  }
}
