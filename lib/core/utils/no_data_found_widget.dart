import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import 'image_constant.dart';

noDataFoundOrders([BuildContext? context]) => Center(
      child: ColumnSuper(alignment: Alignment.center, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/noimage.png',
            height: Adaptive.h(15),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: Adaptive.h(5),
        ),
        Text(
          context != null
              ? AppLocalizations.of(context)!.nocurrentorders
              : 'No current orders',
          style:
              TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold),
        )
      ]),
    );

noBids([BuildContext? context]) => Center(
      child: ColumnSuper(alignment: Alignment.center, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/noimage.png',
            height: Adaptive.h(15),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: Adaptive.h(2),
        ),
        Text(
          context != null
              ? AppLocalizations.of(context)!.nocurrentbids
              : 'No current bids',
          style:
              TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.w400),
        )
      ]),
    );

noStockData([BuildContext? context]) => Center(
      child: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/noimage.png',
                height: Adaptive.h(15),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: Adaptive.h(5),
            ),
            Text(
              context != null
                  ? AppLocalizations.of(context)!.noDataFound
                  : 'No data found',
              style: TextStyle(
                  fontSize: Adaptive.sp(17), fontWeight: FontWeight.w400),
            )
          ]),
    );
somethingWentWrong([BuildContext? context]) => Center(
      child: ColumnSuper(alignment: Alignment.center, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/noimage.png',
            height: Adaptive.h(15),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: Adaptive.h(5),
        ),
        Text(
          context != null
              ? AppLocalizations.of(context)!.somethingwentwrongyoumay
              : 'Something went wrong',
          style:
              TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.w400),
        )
      ]),
    );

noWalletTransactions([BuildContext? context]) => Center(
      child: ColumnSuper(alignment: Alignment.center, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/noimage.png',
            height: Adaptive.h(15),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: Adaptive.h(5),
        ),
        Text(
          context != null
              ? AppLocalizations.of(context)!.notransactionsfound
              : 'No transactions found',
          style:
              TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.w400),
        )
      ]),
    );

noFinancesFound([BuildContext? context]) => Center(
      child: ColumnSuper(alignment: Alignment.center, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/noimage.png',
            height: Adaptive.h(15),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: Adaptive.h(5),
        ),
        Text(
          context != null
              ? AppLocalizations.of(context)!.nofinancesfound
              : 'No finances found',
          style:
              TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.w400),
        )
      ]),
    );

noBnplData([BuildContext? context]) => Center(
      child: ColumnSuper(alignment: Alignment.center, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/noimage.png',
            height: Adaptive.h(15),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: Adaptive.h(5),
        ),
        Text(
          context != null
              ? AppLocalizations.of(context)!.nobnpldatafound
              : 'No BNPL data found',
          style:
              TextStyle(fontSize: Adaptive.sp(17), fontWeight: FontWeight.w400),
        )
      ]),
    );

listLoader() => Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 68,
                color: Colors.grey,
              ),
            );
          }),
    ));

stockLoader() => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: Adaptive.w(100),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 250,
                  height: 10,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          // shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: 60,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: Container(
                              height: 10,
                              width: 60,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 40,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 10,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 50,
                        height: 10,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                width: 200,
                height: 10,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        // width: 200,
                        height: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        // width: 200,
                        height: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

walletTransactionsLoader() => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: Adaptive.w(100),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: 250,
                  height: 10,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: 60,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: Container(
                              height: 10,
                              width: 60,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 40,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 10,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 50,
                        height: 10,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                width: 200,
                height: 10,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        // width: 200,
                        height: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        // width: 200,
                        height: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

defaultLoader() => Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Lottie.asset(
            ImageConstant.imgisloding,
            width: 140,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
