import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/home_screen/buy_commodity_screen.dart';
import 'package:apnagodam/presentation/home_screen/sell_commodity_screen.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/home_screen/ui/F2fdealscreen.dart';
import 'package:apnagodam/presentation/home_screen/ui/F2fdealsellscreen.dart';
import 'package:apnagodam/presentation/home_screen/ui/Spotdealscreen.dart';
import 'package:apnagodam/presentation/home_screen/ui/Spotdealsellscreen.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';


class Buysellscreen extends ConsumerStatefulWidget {
  Buysellscreen({super.key, required this.type});

  int type;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuysellscreenState();
}

class _BuysellscreenState extends ConsumerState<Buysellscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(homeDataProvider).when(
          data: (data) => GridView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: data.commodites?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8,
                    surfaceTintColor: Colors.amberAccent,
                    child: Column(
                      children: [
                        Container(
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              height: Adaptive.sp(33),
                              width: Adaptive.sp(33),
                              imageUrl:
                                  "${IMAGE_BASE_URL}category/${data.commodites?[index].image.toString()}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text.rich(
                            TextSpan(
                              text: data.commodites?[index].category.toString(),
                              style: AppStyle.lblaccontsecond
                                  .copyWith(fontSize: Adaptive.sp(16)),
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Spacer(),
                        RowSuper(
                          fill: true,
                          children: [
                            InkWell(
                              onTap: () {
                                if (ref.watch(authProvider).value ==
                                    AuthStatus.loggedIn) {
                                  if (widget.type == 1) {
                                    Get.to(Spotdealscreen(
                                      commodityid:
                                          data.commodites?[index].id.toString(),
                                      commodityName: data
                                          .commodites?[index].category
                                          .toString(),
                                    ));
                                  } else if (widget.type == 2) {
                                    Get.to(F2fdealscreen(
                                      commodityid:
                                          data.commodites?[index].id.toString(),
                                      commodityName: data
                                          .commodites?[index].category
                                          .toString(),
                                    ));
                                  } else {
                                    Get.to(Buycommodity(
                                      commodityid:
                                          data.commodites?[index].id.toString(),
                                      commodityName: data
                                          .commodites?[index].category
                                          .toString(),
                                    ));
                                  }
                                } else {
                                  showLoginBottomsheet(context);
                                }
                              },
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
                              onTap: () {
                                if (ref.watch(authProvider).value ==
                                    AuthStatus.loggedIn) {
                                  if (widget.type == 1) {
                                    Get.to(Spotdealsellscreen(
                                      commodityid:
                                          data.commodites?[index].id.toString(),
                                      commodityName: data
                                          .commodites?[index].category
                                          .toString(),
                                    ));
                                  } else if (widget.type == 2) {
                                    Get.to(F2fdealsellscreen(
                                      commodityid:
                                          data.commodites?[index].id.toString(),
                                      commodityName: data
                                          .commodites?[index].category
                                          .toString(),
                                    ));
                                  } else {
                                    Get.to(Sellcommodity(
                                      commodityid:
                                          data.commodites?[index].id.toString(),
                                      commodityName: data
                                          .commodites?[index].category
                                          .toString(),
                                    ));
                                  }
                                } else {
                                  showLoginBottomsheet(context);
                                }
                              },
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
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
              ),
          error: (e, s) => Container(),
          loading: () => defaultLoader()),
    );
  }
}
