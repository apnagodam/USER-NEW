import 'package:apnagodam/presentation/mybuy_screen/SbtMyBuy.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import '../mybuy_screen/werehouse_deal_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class MyBuy extends ConsumerWidget {
  const MyBuy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.msgMybuy),
        backgroundColor: ColorConstant.maingreen,
        centerTitle: true,
        actions: [],
      ),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                        6.0,
                      )),
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ColorConstant.maingreen,
                      ),
                      tabs: [
                        Tab(
                          child: TextOneLine(
                            AppLocalizations.of(context)!.msgWarehouse,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Tab(
                        //   child: TextOneLine(
                        //     AppLocalizations.of(context)!.msgLpSpot,
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         fontSize: Adaptive.sp(16),
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // Tab(
                        //   child: TextOneLine(
                        //     AppLocalizations.of(context)!.msgFaceDeal,
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         fontSize: Adaptive.sp(16),
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        Tab(
                          child: TextOneLine(
                            AppLocalizations.of(context)!.sbt,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                ),
              ),
              Expanded(
                  child: TabBarView(
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                    WarehouseDeal(
                      buySellType: 'buy',
                    ),
                    // SpoatDealScreen(),
                    // FaceTofaceDeal(),
                    Sbtmybuy()
                  ]))
            ],
          )),
    );
  }
}
