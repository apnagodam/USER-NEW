import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../core/utils/image_constant.dart';
import '../core/utils/theme/app_style.dart';
import 'circle_image_view.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

homeloader(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: ColorConstant.maingreen,
    child: ListView(
      padding: Pad(all: 10),
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: Adaptive.sh(25),
          child: InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/slider1.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.buySellCommoduty,
                  style: TextStyle(
                    fontSize: Adaptive.sp(17),
                    color: ColorConstant.maingreen,
                    fontWeight: FontWeight.w700,
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.view,
                    style: TextStyle(
                      fontSize: Adaptive.sp(16),
                      decoration: TextDecoration.underline,
                      color: ColorConstant.maingreen,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ]),
        ColumnSuper(children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 9,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.maingreen),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: Adaptive.sp(33),
                          width: Adaptive.sp(33),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextOneLine(
                          "loading",
                          style: AppStyle.lblaccontsecond
                              .copyWith(fontSize: Adaptive.sp(16)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  RowSuper(
                    fill: true,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.maingreen,
                            // border: Border.all(
                            //     color: Colors.green),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10)),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.msgBuy,
                            style: AppStyle.lblsellnbuy
                                .copyWith(fontSize: Adaptive.sp(16)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorConstant.maingreen,
                              // border: Border.all(
                              //     color: Colors.green),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10))),
                          child: Text(
                            AppLocalizations.of(context)!.msgSell,
                            style: AppStyle.lblsellnbuy
                                .copyWith(fontSize: Adaptive.sp(16)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          ),
          SizedBox(
            height: 10,
          ),
          /*cont.ismystockLoad ?  SizedBox() : */
          Container(
              height: Adaptive.sh(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/slider_2_warehouse3.jpg",
                  fit: BoxFit.fill,
                ),
              ))
          // Stack(
          //   children: [
          //     Positioned(
          //       bottom: 0,
          //       top: 0,
          //       left: 0,
          //       right: 0,
          //       child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius:
          //                 BorderRadius.circular(10),
          //           ),
          //           child: ClipRRect(
          //             borderRadius:
          //                 BorderRadius.circular(10),
          //             child: Image.asset(
          //               "assets/images/slider_2_warehouse3.jpg",
          //               fit: BoxFit.fill,
          //             ),
          //           )),
          //     ),
          //     Positioned(
          //         top: 10,
          //         right: 10,
          //         child: GestureDetector(
          //           onTap: () async {
          //             SharedPreferences prefs =
          //                 await SharedPreferences
          //                     .getInstance();
          //             if (ref
          //                 .watch(
          //                     sharedUtilityProvider)
          //                 .isKycComplete()) {
          //               // ignore: use_build_context_synchronously
          //               CommanDialog(
          //                 context,
          //                 AppLocalizations.of(context)!.msgAlert,
          //                 AppLocalizations.of(context)!.varifyMsg2,
          //                 (bool userClickedOK) {
          //                   if (userClickedOK) {
          //                     // Navigator.push(
          //                     //   context,
          //                     //   MaterialPageRoute(builder: (context) => KYC(kyctag:"",)),
          //                     // );
          //                     Get.off(KYC(
          //                       kyctag: "",
          //                     ));
          //                     /* Navigator.of(
          //               context)
          //               .pop();*/
          //                   } else {
          //                     Navigator.of(context,
          //                             rootNavigator:
          //                                 true)
          //                         .pop();
          //                   }
          //                 },
          //               );
          //             } else {
          //               Get.to(WarehouseTab());
          //             }
          //           },
          //           child: Container(
          //             padding:  Pad(
          //                 left: 15,
          //                 right: 15,
          //                 top: 5,
          //                 bottom: 5),
          //             decoration: BoxDecoration(
          //                 color:
          //                     ColorConstant.maingreen,
          //                 borderRadius:
          //                     BorderRadius.circular(
          //                   08,
          //                 )),
          //             child: Text(
          //               AppLocalizations.of(context)!.msgBook,
          //               style: AppStyle.lblbuydetail
          //                   .copyWith(
          //                       fontSize:
          //                           Adaptive.sp(16)),
          //             ),
          //           ),
          //         ))
          //   ],
          // ),
          // buildGallery3DWare(),
          ,
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: Adaptive.sh(25),
            child: Card(
              surfaceTintColor: Colors.amber,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorConstant.maingreen),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Expanded(
                      child: ColumnSuper(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18.0, top: 10),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(ImageConstant.imgtestimonialcoma),
                            width: 15,
                            color: ColorConstant.maingreen,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 10, left: 40, right: 40),
                            child: Text(
                              maxLines: 5,
                              "Loading",
                              style: AppStyle.lbltestimonial.copyWith(
                                  color: Colors.black,
                                  fontSize: Adaptive.sp(16),
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image(
                            image: AssetImage(
                                ImageConstant.imgtestimonialcomaright),
                            width: 15,
                            color: ColorConstant.maingreen,
                          )
                        ],
                      ),
                    ),
                  ])),
                  Expanded(
                      child: RowSuper(
                    alignment: Alignment.center,
                    innerDistance: 10,
                    children: [
                      CircleAvatar(
                          radius: Adaptive.sp(20),
                          backgroundImage: NetworkImage("")),
                      Text(
                        'Loading',
                        style: AppStyle.lblontestimonalname.copyWith(
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
          //____________testimnial_________________
          // FlutterCarousel.builder(
          //     options: CarouselOptions(
          //         aspectRatio: 16 / 9,
          //         autoPlay: true,
          //         viewportFraction: 1,
          //         autoPlayCurve: Curves.linear,
          //         floatingIndicator: false,
          //         slideIndicator:
          //              CircularSlideIndicator(
          //                 slideIndicatorOptions:
          //                     SlideIndicatorOptions(
          //                         indicatorBackgroundColor:
          //                             ColorConstant
          //                                 .maingreen,
          //                         currentIndicatorColor:
          //                             Colors.yellow)),
          //         onPageChanged: (index, reason) {
          //           // cont.currentIndex = index;
          //           // cont.update();
          //         }),
          //     itemCount: data.testimonials?.length,
          //     itemBuilder:
          //         (context, index, itemIndex) {
          //       return Card(
          //         surfaceTintColor: Colors.amber,
          //         elevation: 5,
          //         shape: RoundedRectangleBorder(
          //             side:  BorderSide(
          //                 color: ColorConstant
          //                     .maingreen),
          //             borderRadius:
          //                 BorderRadius.circular(8)),
          //         child: Column(
          //           children: [
          //             Expanded(
          //                 child:
          //                     ColumnSuper(children: [
          //               Padding(
          //                 padding:
          //                      EdgeInsets.only(
          //                         left: 18.0,
          //                         top: 10),
          //                 child: Row(
          //                   children: [
          //                     Image(
          //                       image: AssetImage(
          //                           ImageConstant
          //                               .imgtestimonialcoma),
          //                       width: 15,
          //                       color: ColorConstant
          //                           .maingreen,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               Row(
          //                 children: [
          //                   Expanded(
          //                     child: Padding(
          //                       padding:
          //                            EdgeInsets
          //                               .only(
          //                               top: 5.0,
          //                               bottom: 10,
          //                               left: 40,
          //                               right: 40),
          //                       child: Text(
          //                         maxLines: 5,
          //                         data
          //                                 .testimonials?[
          //                                     index]
          //                                 .description ??
          //                             "",
          //                         style: AppStyle
          //                             .lbltestimonial
          //                             .copyWith(
          //                                 color: Colors
          //                                     .black,
          //                                 fontSize:
          //                                     Adaptive.sp(
          //                                         16),
          //                                 fontWeight:
          //                                     FontWeight
          //                                         .w700),
          //                         textAlign: TextAlign
          //                             .center,
          //                       ),
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               Padding(
          //                 padding:
          //                      EdgeInsets.only(
          //                   right: 18,
          //                 ),
          //                 child: Row(
          //                   mainAxisAlignment:
          //                       MainAxisAlignment.end,
          //                   children: [
          //                     Image(
          //                       image: AssetImage(
          //                           ImageConstant
          //                               .imgtestimonialcomaright),
          //                       width: 15,
          //                       color: ColorConstant
          //                           .maingreen,
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ])),
          //             Expanded(
          //                 child: RowSuper(
          //               alignment: Alignment.center,
          //               innerDistance: 10,
          //               children: [
          //                 CircleAvatar(
          //                     radius: Adaptive.sp(20),
          //                     backgroundImage:
          //                         NetworkImage(
          //                             "$BASEURL${data.testimonials?[index].image}")),
          //                 Text(
          //                   '${data.testimonials?[index].name} (${data.testimonials?[index].location.toString()})',
          //                   style: AppStyle
          //                       .lblontestimonalname
          //                       .copyWith(
          //                           fontSize:
          //                               Adaptive.sp(
          //                                   15),
          //                           fontWeight:
          //                               FontWeight
          //                                   .w700),
          //                 ),
          //               ],
          //             ))
          //           ],
          //         ),
          //       );
          //     }),
          ,
          SizedBox(
            height: 10,
          ),
        ])
      ],
    ));

myStockLoader() => Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: ColorConstant.maingreen,
    child: SizedBox(
      height: Get.height,
      width: Get.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: ColorConstant.maingreen.withOpacity(0.3))),
            surfaceTintColor: Colors.white,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ColumnSuper(
                children: [
                  TextOneLine("Loading...",
                      style: AppStyle.mystoke.copyWith(
                          color: ColorConstant.maingreen,
                          fontSize: Adaptive.sp(16),
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "assets/images/mung.jpeg",
                                width: Adaptive.sp(30),
                                height: Adaptive.sp(30),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: ColumnSuper(
                                alignment: Alignment.centerLeft,
                                children: [
                                  RowSuper(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .msgGatepass,
                                        style: AppStyle.mystokedetail.copyWith(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: FontWeight.w700),
                                      ),
                                      InkWell(
                                        onTap: () async {},
                                        child: Text(
                                          "Loading...",
                                          style: AppStyle.mystokedetailblueclr
                                              .copyWith(
                                                  fontSize: Adaptive.sp(16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 6.0, bottom: 6.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .msgWeightt,
                                          style: AppStyle.mystokedetail
                                              .copyWith(
                                                  fontSize: Adaptive.sp(16),
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "0.0",
                                          style: AppStyle.mystokedetail
                                              .copyWith(
                                                  fontSize: Adaptive.sp(16)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.msgBags,
                                        style: AppStyle.mystokedetail.copyWith(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "0.0",
                                        style: AppStyle.mystokedetail.copyWith(
                                            fontSize: Adaptive.sp(16)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ColumnSuper(
                          alignment: Alignment.topLeft,
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.msgStackno,
                                  style: AppStyle.mystokedetail.copyWith(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '0',
                                  style: AppStyle.mystokedetail
                                      .copyWith(fontSize: Adaptive.sp(16)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       "msg_rent"
                            //           .tr,
                            //       style: AppStyle
                            //           .mystokedetail
                            //           .copyWith(
                            //               fontSize:
                            //                   Adaptive.sp(16)),
                            //     ),
                            //     Text(
                            //       (data[index].rentAmount ??
                            //               0.0)
                            //           .toStringAsFixed(
                            //               2),
                            //       style: AppStyle
                            //           .mystokedetail
                            //           .copyWith(
                            //               fontSize:
                            //                   Adaptive.sp(16)),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 4.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.quality,
                                    style: AppStyle.mystokedetail.copyWith(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    " : ${AppLocalizations.of(context)!.clickHere}",
                                    style: AppStyle.mystokedetailblueclr
                                        .copyWith(fontSize: Adaptive.sp(16)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                        ColumnSuper(alignment: Alignment.centerLeft, children: [
                      TextOneLine(
                          textAlign: TextAlign.start,
                          '${AppLocalizations.of(context)!.msgCommodity} }',
                          style: AppStyle.lblmystock
                              .copyWith(fontSize: Adaptive.sp(16))),
                      SizedBox(
                        height: 5,
                      ),
                      TextOneLine(
                          textAlign: TextAlign.start,
                          '${AppLocalizations.of(context)!.msgExpirydate}}',
                          style: AppStyle.lblmystock
                              .copyWith(fontSize: Adaptive.sp(16))),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: RowSuper(
                      fitHorizontally: true,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.msgViewgraph,
                          style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        ),
                        Icon(
                          Icons.auto_graph_rounded,
                          color: Colors.blue,
                          size: Adaptive.sp(16),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Visibility(
                        child: Expanded(
                            child: ElevatedButton(
                          style: AppStyle.buttonStyle,
                          onPressed: () async {},
                          child: Text(
                            AppLocalizations.of(context)!.msgApplyloan,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: Adaptive.sp(16),
                            ),
                          ),
                        )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Stack(
                        fit: StackFit.loose,
                        children: [
                          Visibility(
                            child: Row(
                              children: [
                                // Text(
                                //   "rejected"
                                //       .tr,
                                //   style:
                                //   TextStyle(
                                //     fontWeight:
                                //     FontWeight.bold,
                                //     color: ColorConstant.red500
                                //     ,
                                //     fontSize:
                                //     Adaptive.sp(16),
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: 5,
                                // ),

                                /*Text(
                                                  AppLocalizations.of(context)!.reapply,
                                                  style:
                                                       TextStyle(
                                                    fontWeight:
                                                        FontWeight
                                                            .bold,
                                                    color: Colors
                                                        .white,
                                                    fontSize: 9.0,
                                                  ),
                                                ),*/
                              ],
                            ),
                          ),
                          Visibility(
                            child: ElevatedButton(
                              style: AppStyle.buttonStyle,
                              onPressed: () async {},
                              child: FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)!.reapply,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: Adaptive.sp(16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.approvedloan,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 17, 32, 17),
                                    fontSize: Adaptive.sp(16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        child: Expanded(
                          child: Visibility(
                            child: ElevatedButton(
                                style: AppStyle.buttonStyle.copyWith(
                                    backgroundColor: WidgetStateProperty.all(
                                        Colors.transparent.withOpacity(0.0)),
                                    shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: Colors.red)))),
                                onPressed: null,
                                child: Text(
                                  AppLocalizations.of(context)!.loanapplied,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                    fontSize: Adaptive.sp(16),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Visibility(
                        visible: true,
                        child: Expanded(
                            child: ElevatedButton(
                          style: AppStyle.buttonStyle,
                          onPressed: () async {},
                          child: FittedBox(
                            child: Text(
                              AppLocalizations.of(context)!.msgWanttosell,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          ),
                        )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Visibility(
                        child: Expanded(
                            child: ElevatedButton(
                          style: AppStyle.buttonStyle.copyWith(
                              backgroundColor: WidgetStateProperty.resolveWith(
                                  (states) => ColorConstant.orangeA200)),
                          onPressed: () async {
                            // Handle button click
                          },
                          child: FittedBox(
                            child: Text(
                              AppLocalizations.of(context)!.msgMybid,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: Adaptive.sp(16),
                              ),
                            ),
                          ),
                        )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));

wbtLoader() => Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: ColorConstant.maingreen,
    child: Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () async {},
                child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: ColorConstant.maingreen,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  CircleImageView(
                                    radius: Adaptive.sp(22),
                                    image: "",
                                  ),
                                  // NetworkImage("${IMAGE_BASE_URL}category/${cont.wbtMarket!.data![index].image.toString()}", )

                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Loading...",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16)),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Loading...",
                                            style: AppStyle.lblonbordingp
                                                .copyWith(
                                                    fontSize: Adaptive.sp(14),
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                          ),
                                          Text(
                                            "",
                                            style: AppStyle.lblonbordingp
                                                .copyWith(
                                                    fontSize: Adaptive.sp(14),
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                          ),
                                          Text(
                                            "Loading...",
                                            style: AppStyle.lblonbordingp
                                                .copyWith(
                                                    fontSize: Adaptive.sp(14),
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Last Trade Price: ",
                                        style: AppStyle.lblonbordingp.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: Adaptive.sp(16)),
                                      ),
                                      InkWell(
                                        onTap: () async {},
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .msgViewgraph,
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(15),
                                              fontFamily: 'Roboto',
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.blue,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          Container(
                            width: Get.width,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: ColorConstant.maingreen,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )),
                            child: RowSuper(
                              fill: true,
                              fitHorizontally: true,
                              innerDistance: 5,
                              children: [
                                RowSuper(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Low: ',
                                        style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        children: [TextSpan(text: "")])),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'High: ',
                                        style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        children: [TextSpan(text: "")])),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text.rich(TextSpan(
                                        text: 'Buyer: ',
                                        style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        children: [TextSpan(text: "")])),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Seller: ',
                                        style: TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        children: [TextSpan(text: "")])),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            })));
