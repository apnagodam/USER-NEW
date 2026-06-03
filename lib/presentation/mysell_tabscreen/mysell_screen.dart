import 'package:apnagodam/presentation/mybuy_screen/face_to_face_deal.dart';
import 'package:apnagodam/presentation/mysell_tabscreen/SbtMySell.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/utils/color_constant.dart';
import '../../widgets/CommonTextField.dart';
import '../mybuy_screen/spot_deal_screen.dart';
import '../mybuy_screen/werehouse_deal_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class MySell extends StatefulWidget {
  const MySell({super.key});

  @override
  State<MySell> createState() => _MySellState();
}

//this one alos
class _MySellState extends State<MySell> with SingleTickerProviderStateMixin {
  void onSearchTextChanged(String searchText) {
    print("Search text changed in MyBuy: $searchText");
  }

  bool isSearching = false;
  TabController? _tabController;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(_handleTabChange);

    super.initState();
  }

  void _handleTabChange() {
    if (_tabController!.indexIsChanging) {
      setState(() {
        isSearching = false;
        searchController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? SizedBox(
                height: 42,
                child: CommonTextField(
                  controller: searchController,
                  hintText: AppLocalizations.of(context)!.enterTextAsPer,
                  textInputAction: TextInputAction.done,
                  inputType: TextInputType.text,
                  fillColor: Colors.white38,
                  filled: true,
                  enabled: true,
                  isRequired: true,
                ),
              )
            : Text(AppLocalizations.of(context)!.msgMysell),
        backgroundColor: ColorConstant.maingreen,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;

                if (!isSearching) {
                  // Clear the search field and perform any cleanup
                  searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      /*appBar: AppBar(
        backgroundColor: ColorConstant.maingreen,
        title: Text(AppLocalizations.of(context)!.msgMysell,),
        titleTextStyle: AppStyle.lblAppbar,
        centerTitle: true,
      ),*/
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
                      controller: _tabController,
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
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
                      controller: _tabController,
                      children: [
                    WarehouseDeal(
                      buySellType: 'sell',
                    ),
                    // SpoatDealScreen(),
                    // FaceTofaceDeal(),
                    Sbtmysell()
                  ]))
            ],
          )),
    );
  }
}
