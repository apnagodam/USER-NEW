import 'dart:core';
import 'dart:math';

import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/LP_list_screen/model/LpResponseModel.dart';
import 'package:apnagodam/presentation/LP_list_screen/service/LpService.dart';
import 'package:apnagodam/presentation/home_screen/controller/home_controller.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/color_constant.dart';
import '../../widgets/CommonTextField.dart';
import '../LP_list_screen/google_map_screen.dart';
import 'controller/lplist_controller.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Lplistscreen extends ConsumerStatefulWidget {
  String? lat = '';
  String? long = '';
  String? commoditId = '';
  String? quantity = '';
  String? dealType = '';
  String? salesStatus = '';

  Lplistscreen(
      {super.key,
      required this.lat,
      required this.long,
      required this.commoditId,
      required this.quantity,
      required this.dealType,
      required this.salesStatus});

  @override
  ConsumerState<Lplistscreen> createState() => _LplistscreenState();
}

class _LplistscreenState extends ConsumerState<Lplistscreen> {
  var homecont = Get.put(HomeController());
  var userImage;
  var username;
  var bookId;
  List<LpList?> lpList = [];
  var isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Geolocator.getCurrentPosition().then((Position position) {
        ref.watch(sharedUtilityProvider).setPosition(position);
        ref
            .watch(lpDataProvider(
                    lat: position.latitude.toString(),
                    long: position.longitude.toString(),
                    commodityImage: "",
                    commodity: widget.commoditId,
                    quantity: widget.quantity,
                    dealType: widget.dealType,
                    salesStatus: widget.salesStatus,
                    pincode: "")
                .future)
            .then((value) {
          isLoading = false;
        }).onError((e, s) {
          isLoading = false;
        });
      }).catchError((e) {
        print(e);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LplistController>(
        init: LplistController(),
        builder: (cont) {
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstant.maingreen,
              title: Center(
                  child: Text(
                AppLocalizations.of(context)!.lpList,
                style: AppStyle.lblAppbar,
              )),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.notifications,
                    color: ColorConstant.maingreen,
                  ),
                )
              ],
            ),
            body: isLoading
                ? defaultLoader()
                : (lpList ?? []).isEmpty
                    ? noStockData()
                    : ListView.builder(
                        primary: true,
                        shrinkWrap: true,
                        itemCount: lpList.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          userImage =
                              "${IMAGE_BASE_URL}category/${lpList[index]?.categoryImage.toString()}";
                          username = lpList[index]?.name.toString();
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0, top: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3,
                                        spreadRadius: 1)
                                  ]),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 8.0,
                                        top: 8.0),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                              radius: 35,
                                              backgroundImage: NetworkImage(
                                                  "${IMAGE_BASE_URL}logistic_partner/${lpList?[index]?.passportImage}")),
                                          /* CircleImageView(
                                        radius: 35,
                                        image: IMAGE_BASE_URL+"logistic_partner/"+homecont.lpdataList[index].passportImage.toString(),
                                      ),*/

                                          VerticalDivider(thickness: 1),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${lpList[index]?.name}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0, bottom: 3.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .distanceKm,
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    Text(
                                                      "${lpList[index]?.distance}",
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .mobileNo,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                  Text(
                                                    '${lpList[index]?.phone}',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          VerticalDivider(thickness: 1),
                                          Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .priceLp,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                " : ${lpList[index]?.userPrice.toString()}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: 5.0,
                                        bottom: 8.0),
                                    child: RowSuper(
                                      fill: true,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            //   {
                                            //     "lp_user_id": "510",
                                            //   "commodity_id": "8",
                                            //   "quantity": "200",
                                            //   "price": "2600",
                                            //   "sales_status": "1",
                                            //   "category_image": "15b701.png",
                                            //   "commodity_image_path": "1",
                                            //   "terminal_id": "14",
                                            //   "ag_commission": "2",
                                            //   "lp_commission": "0",
                                            //   "user": "508",
                                            //   "distance": "0",
                                            //   "lp_lat": "26.858725",
                                            //   "lp_long": "75.7595533",
                                            //   "corporate_users_lat": "27.431251518706876",
                                            //   "corporate_users_long": "75.42056322097778",
                                            //   "final_price": "2539",
                                            //   "sub_price": "2590",
                                            //   "transport_price": "0",
                                            //   "loading_charge": "10",
                                            //   "mandi_tax": "0"
                                            // }
                                            //
                                            ref
                                                .watch(bookingRequestProvider(
                                                        lpUserId: lpList[index]
                                                            ?.lpUserId
                                                            .toString(),
                                                        commodityId: lpList[index]
                                                            ?.commodityId
                                                            .toString(),
                                                        quantity: lpList[index]
                                                            ?.quantity
                                                            .toString(),
                                                        price: lpList[index]
                                                            ?.price
                                                            .toString(),
                                                        salesStatus: lpList[index]
                                                            ?.salesStatus
                                                            .toString(),
                                                        catImage: lpList[index]
                                                            ?.categoryImage
                                                            .toString(),
                                                        commodityImagePath:
                                                            lpList[index]
                                                                ?.commodityImagePath
                                                                .toString(),
                                                        terminalId: lpList[index]
                                                            ?.terminalId
                                                            .toString(),
                                                        agCommission: lpList[index]
                                                            ?.agCommission
                                                            .toString(),
                                                        lpCommision: lpList[index]
                                                            ?.lpCommission
                                                            .toString(),
                                                        user: lpList[index]
                                                            ?.user
                                                            .toString(),
                                                        distance: lpList[index]
                                                            ?.distance
                                                            .toString(),
                                                        lpLat: lpList[index]
                                                            ?.lpLat
                                                            .toString(),
                                                        lpLong: lpList[index]
                                                            ?.lpLong
                                                            .toString(),
                                                        corpLat: lpList[index]?.corporateUsersLat.toString(),
                                                        corpLong: lpList[index]?.corporateUsersLong.toString(),
                                                        finalPrice: lpList[index]?.finalPrice.toString(),
                                                        subPrice: lpList[index]?.subPrice.toString(),
                                                        transportPrice: lpList[index]?.transportPrice.toString(),
                                                        loadingCharge: lpList[index]?.loadingCharge.toString(),
                                                        mandiTax: lpList[index]?.mandiTax.toString())
                                                    .future)
                                                .then((value) {
                                              if (value['status'].toString() ==
                                                  "1") {
                                                Get.to(GooglemapScreen(
                                                  image: userImage,
                                                  name: username,
                                                  lpuserId: lpList[index]
                                                      ?.lpUserId
                                                      .toString(),
                                                ));
                                              }
                                              Fluttertoast.showToast(
                                                  msg: value['message']
                                                      .toString(),
                                                  toastLength:
                                                      Toast.LENGTH_LONG);
                                            }).onError((e, s) {
                                              Fluttertoast.showToast(
                                                  msg: e.toString(),
                                                  toastLength:
                                                      Toast.LENGTH_LONG);
                                            });
                                            // cont
                                            //     .apnauOnBookMgpLp(
                                            //     data.lpList?[index]
                                            //         .lpUserId
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .commodityId
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .quantity
                                            //         .toString(),
                                            //     data.lpList?[index].price
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .salesStatus
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .categoryImage
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .commodityImagePath
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .terminalId
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .agCommission
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .lpCommission
                                            //         .toString(),
                                            //     data.lpList?[index].user
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .distance
                                            //         .toString(),
                                            //     data.lpList?[index].lpLat
                                            //         .toString(),
                                            //     data.lpList?[index].lpLong
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .corporateUsersLat
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .corporateUsersLong
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .finalPrice
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .subPrice
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .transportPrice
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .loadingCharge
                                            //         .toString(),
                                            //     data.lpList?[index]
                                            //         .mandiTax.toString())
                                            //     .then((value) {
                                            //   if (value['status']
                                            //       .toString() ==
                                            //       "1") {
                                            //
                                            //   }
                                            // });
                                          },
                                          child: Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: ColorConstant.maingreen),
                                            child: Center(
                                                child: Text(
                                              AppLocalizations.of(context)!
                                                  .msgBook,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto'),
                                            )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                titlePadding: EdgeInsets.zero,
                                                insetPadding: EdgeInsets.zero,
                                                contentPadding: EdgeInsets.zero,
                                                // content: ,
                                                title: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .yourBid,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .close_rounded,
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(
                                                          thickness: 2,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              CommonTextField(
                                                            // controller: ,
                                                            hintText:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .yourPrice,
                                                            // textInputAction: TextInputAction.next,
                                                            inputType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            enabled: true,
                                                            // isOnlyDigit: true,
                                                            isRequired: true,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6.0),
                                                                  color: ColorConstant
                                                                      .maingreen),
                                                              child: Center(
                                                                child: Text(
                                                                  AppLocalizations.of(context)!.msgSubmit3,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: ColorConstant.maingreen),
                                            child: Center(
                                                child: Text(
                                              AppLocalizations.of(context)!
                                                  .yourBid,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto'),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
          ));
        });
  }
}
// VerticalDivider
