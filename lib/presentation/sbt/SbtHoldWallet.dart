import 'package:apnagodam/presentation/sbt/service/SbtService.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/no_data_found_widget.dart';
import '../credit/credit_screen.dart';
import 'package:get/get.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class MyHoldWallet extends ConsumerStatefulWidget {
  const MyHoldWallet({super.key});

  @override
  ConsumerState<MyHoldWallet> createState() => _MyHoldWalletState();
}

class _MyHoldWalletState extends ConsumerState<MyHoldWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myHoldWallet),
      ),
      body: ListView(
        children: [
          ref.watch(sbtHoldListProvider(walletType: '1')).when(
              data: (data) {
                var effectiveBalance =
                    "${double.parse("${data.power?.power ?? 0.0}") - double.parse("${data.power?.sbtHold ?? 0}") - double.parse("${data.power?.holdPower ?? 0}")}";
                return (data.data ?? []).isEmpty
                    ? SizedBox(
                        height: Get.height,
                        child: Center(
                          child: noStockData(context),
                        ),
                      )
                    : Padding(
                        padding: Pad(all: 10),
                        child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorConstant.maingreen,
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        stops: const [
                                          0,
                                          0,
                                          1,
                                          2,
                                          3
                                        ],
                                        colors: [
                                          Colors.transparent,
                                          ColorConstant.maingreen,
                                          ColorConstant.orangeA200,
                                          ColorConstant.orangeA200,
                                          ColorConstant.maingreen,
                                        ])),
                                child: Padding(
                                  padding: Pad(all: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            "Balance",
                                            style: TextStyle(
                                                shadows: const [
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0),
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0)
                                                ],
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16)),
                                          )),
                                          Text(
                                            currencyFormat.format(double.parse(
                                                "${data.power?.power ?? 0.0}")),
                                            style: TextStyle(
                                                shadows: const [
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0),
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0)
                                                ],
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            "Hold Balance",
                                            style: TextStyle(
                                                shadows: const [
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0),
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0)
                                                ],
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16)),
                                          )),
                                          Text(
                                            currencyFormat.format(double.parse(
                                                "${data.power?.holdPower ?? 0.0}")),
                                            style: TextStyle(
                                                shadows: const [
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0),
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0)
                                                ],
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            "Effective Balance",
                                            style: TextStyle(
                                                shadows: const [
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0),
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0)
                                                ],
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16)),
                                          )),
                                          Text(
                                            currencyFormat.format(
                                                double.parse(effectiveBalance)),
                                            style: TextStyle(
                                                shadows: const [
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0),
                                                  Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2.0)
                                                ],
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              itemCount: data.data?.length ?? 0,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (contex, index) => Card(
                                color: Colors.white,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        color: ColorConstant.maingreen)),
                                child: Padding(
                                  padding: Pad(all: 10),
                                  child: ColumnSuper(children: [
                                    Center(
                                        child: Text(
                                      "${data.data?[index].uniqueTradeId ?? 0}",
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Type",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500),
                                        )),
                                        Text(
                                          "${data.data?[index].type ?? 0}",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Hold Amount",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500),
                                        )),
                                        Text(
                                          currencyFormat.format(int.tryParse(
                                              "${data.data?[index].walletHold ?? 0}")),
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Quantity",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500),
                                        )),
                                        Text(
                                          "${data.data?[index].qty ?? 0} Qtl.",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Price",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500),
                                        )),
                                        Text(
                                          "${currencyFormat.format(int.tryParse("${data.data?[index].price ?? 0}"))} per Qtl.",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
              },
              error: (e, s) => Container(),
              loading: () => SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: defaultLoader(),
                  ))
        ],
      ),
    );
  }
}
