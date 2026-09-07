import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/add_money_screen/add_money_summary.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/home_screen/ui/Tradeaddmoney.dart';
import 'package:apnagodam/presentation/home_screen/ui/TradewalletBalance.dart';
import 'package:apnagodam/presentation/home_screen/ui/Tradewalletstatement.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/wallet_statement_screen.dart';
import 'package:apnagodam/presentation/withdraw_money_screen/withdraw_money_list.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Tradewalletscreen extends ConsumerStatefulWidget {
  const Tradewalletscreen({super.key});

  @override
  ConsumerState<Tradewalletscreen> createState() => _TradewalletscreenState();
}

final selectedTabIndexProvider = StateProvider<int>((ref) => 0);

// ✅ CHANGE 1: Added "with TickerProviderStateMixin"
class _TradewalletscreenState extends ConsumerState<Tradewalletscreen>
    with TickerProviderStateMixin {

  // ✅ CHANGE 2: Declare a TabController
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // ✅ CHANGE 2: Initialize TabController and sync it with the provider
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref.read(selectedTabIndexProvider.notifier).state = _tabController.index;
        ref.invalidate(userDetailsProvider);
        ref.invalidate(toDateProvider);
        ref.invalidate(fromDateProvider);
      }
    });
  }

  @override
  void dispose() {
    // ✅ CHANGE 2: Dispose the TabController
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 55,
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
                    // ✅ CHANGE 2: Pass the explicit controller
                    controller: _tabController,
                    onTap: (index) {
                      // No need to manually update provider here anymore —
                      // the listener in initState handles it reliably.
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
                          AppLocalizations.of(context)!.msgAddmoney,
                          textAlign: TextAlign.center,

                        ),
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.msgWithdraw,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context)!.msgStatement,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
              ),
            ),

            // ✅ CHANGE 3: Use _tabController.index instead of ref.watch(selectedTabIndexProvider)
            // This reads the REAL current tab — never stale.
            ListenableBuilder(
              listenable: _tabController,
              builder: (context, _) {
                if (_tabController.index == 0) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: simpleButton(
                        text: AppLocalizations.of(context)!.summary,
                        callback: () {
                          Get.to(AddSummaryScreen(type: "2"));
                        },
                      ),
                    ),
                  );
                } else if (_tabController.index == 1) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: simpleButton(
                        text: AppLocalizations.of(context)!.summary,
                        callback: () {
                          Get.to(WithdrawlListScreen(type: "2"));
                        },
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),

            ref.watch(authProvider).when(
                data: (data) => Expanded(
                        child: TabBarView(
                            // ✅ CHANGE 2: Pass the explicit controller here too
                            controller: _tabController,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                          data == AuthStatus.loggedOut
                              ? Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 32),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                            'assets/images/mainlogopng.png',
                                            height: 120,
                                            width: 120),
                                        SizedBox(height: 18),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .loginToAddMoney,
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                        SizedBox(height: 14),
                                        simpleButton(
                                            text: AppLocalizations.of(context)!
                                                .msgLoging,
                                            callback: () {
                                              showLoginBottomsheet(context);
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                              : TradeAddMoney(isAppBarVisible: false),
                          data == AuthStatus.loggedOut
                              ? Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 32),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                            'assets/images/mainlogopng.png',
                                            height: 120,
                                            width: 120),
                                        SizedBox(height: 18),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .loginToWithdrawMoney,
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                        SizedBox(height: 14),
                                        simpleButton(
                                            text: AppLocalizations.of(context)!
                                                .msgLoging,
                                            callback: () {
                                              showLoginBottomsheet(context);
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                              : Tradewalletbalance(),
                          data == AuthStatus.loggedOut
                              ? Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 32),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                            'assets/images/mainlogopng.png',
                                            height: 120,
                                            width: 120),
                                        SizedBox(height: 18),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .loginToCheckStatement,
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                        SizedBox(height: 14),
                                        simpleButton(
                                            text: AppLocalizations.of(context)!
                                                .msgLoging,
                                            callback: () {
                                              showLoginBottomsheet(context);
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                              : TradeWalletStatement(),
                        ])),
                error: (e, s) => Container(),
                loading: () => Container())
          ],
        ),
      ),
    );
  }
}