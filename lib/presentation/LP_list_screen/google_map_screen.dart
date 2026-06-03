import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/LP_list_screen/service/LpService.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/cancel_dailog.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import 'controller/lplist_controller.dart';
import 'track_bookings_Detail_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class GooglemapScreen extends ConsumerStatefulWidget {
  final image;
  final name;
  final lpuserId;

  const GooglemapScreen({super.key, this.image, this.name, this.lpuserId});

  @override
  ConsumerState<GooglemapScreen> createState() => _GooglemapScreenState();
}

final controller = Get.put(LplistController());

class _GooglemapScreenState extends ConsumerState<GooglemapScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(allBookingsProvider(status: '1').future).then((value) {
        if ((value.orders ?? []).isNotEmpty &&
            value.orders?.first.pricingStatus != null &&
            value.orders?.first.pricingStatus.toString() == "1") {
          showBarModalBottomSheet(
              isDismissible: true,
              context: context,
              builder: (context) => Container(
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 15, bottom: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)!
                                              .finalPriceOf,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto')),
                                      Text(
                                          " : ${value.orders![0].category.toString()}"
                                              .tr),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)!
                                              .newPriceInQti,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Roboto')),
                                      Text(
                                          value.orders![0].finalPrice == null
                                              ? "0"
                                              : value.orders![0].finalPrice
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Roboto')),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RowSuper(
                                    fill: true,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print("objecta");
                                          showDecisionDialog(
                                            context,
                                            AppLocalizations.of(context)!
                                                .msgAlert,
                                            AppLocalizations.of(context)!
                                                .declineMmsg,
                                            (bool userClickedOK) {
                                              if (userClickedOK) {
                                                controller
                                                    .apnauserCancilBooking(
                                                        value.orders![0].id
                                                            .toString(),
                                                        widget.lpuserId
                                                            .toString(),
                                                        value.orders![0]
                                                            .lpCancelReason
                                                            .toString())
                                                    .then((value) {
                                                  ref.invalidate(
                                                      allBookingsProvider);

                                                  if (value["status"] == "1") {
                                                    Get.close(1);

                                                    Get.offAll(() =>
                                                        DashboardScreen());
                                                  }
                                                });
                                              } else {
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: ColorConstant.maingreen,
                                          ),
                                          child: Center(
                                              child: Text(
                                            AppLocalizations.of(context)!
                                                .msgCencel,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller
                                              .submitRequstPrice(value
                                                  .orders![0].id
                                                  .toString())
                                              .then((value) {
                                            ref.invalidate(allBookingsProvider);

                                            if (value["status"] == "1") {
                                              // wait here
                                              Get.close(1);
                                              Get.offAll(
                                                  () => DashboardScreen());
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: ColorConstant.maingreen,
                                          ),
                                          child: Center(
                                              child: Text(
                                            AppLocalizations.of(context)!
                                                .msgSubmit,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ));
        }

        if ((value.orders ?? []).isNotEmpty &&
            value.orders?.first.weightStatus != null &&
            value.orders?.first.weightStatus.toString() == "1") {
          showBarModalBottomSheet(
              context: context,
              builder: (context) => Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.msgCommodityy,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto')),
                              Text(" : ${value.orders?[0].category.toString()}"
                                  .tr),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.finalWeightOf,
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Roboto')),
                              Text(
                                  "${value.orders?[0].weight == null ? "0" : value.orders?[0].weight.toString()} (Qtl.)"
                                      .tr,
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Roboto')),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.finalamount,
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Roboto')),
                              Text(
                                  " : ${value.orders?[0].finalPrice == null ? "0" : value.orders?[0].finalPrice.toString()}"
                                      .tr,
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Roboto')),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              //

                              controller
                                  .submitPriceRequst(
                                value.orders?[0].id.toString(),
                              )
                                  .then((value) {
                                ref.invalidate(allBookingsProvider);
                                if (value["status"] == "1") {
                                  Get.close(1);
                                  Get.offAll(() => DashboardScreen());
                                }
                              });
                            },
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ColorConstant.maingreen,
                              ),
                              child: Center(
                                  child: Text(
                                AppLocalizations.of(context)!.msgSubmit,
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
        }
      });
    });

    controller.setLpuserId(widget.lpuserId);
  }

  var panelController = StateProvider((ref) => PanelController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(allBookingsProvider(status: '1').future).then((value) {
        if ((value.orders ?? []).isNotEmpty &&
            value.orders?.first.pricingStatus != null &&
            value.orders?.first.pricingStatus.toString() == "1") {
          showBarModalBottomSheet(
              isDismissible: true,
              context: context,
              builder: (context) => Container(
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 15, bottom: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)!
                                              .finalPriceOf,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto')),
                                      Text(
                                          " : ${value.orders![0].category.toString()}"
                                              .tr),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)!
                                              .newPriceInQti,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Roboto')),
                                      Text(
                                          value.orders![0].finalPrice == null
                                              ? "0"
                                              : value.orders![0].finalPrice
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Roboto')),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RowSuper(
                                    fill: true,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print("objecta");
                                          showDecisionDialog(
                                            context,
                                            AppLocalizations.of(context)!
                                                .msgAlert,
                                            AppLocalizations.of(context)!
                                                .declineMmsg,
                                            (bool userClickedOK) {
                                              if (userClickedOK) {
                                                controller
                                                    .apnauserCancilBooking(
                                                        value.orders![0].id
                                                            .toString(),
                                                        widget.lpuserId
                                                            .toString(),
                                                        value.orders![0]
                                                            .lpCancelReason
                                                            .toString())
                                                    .then((value) {
                                                  ref.invalidate(
                                                      allBookingsProvider);

                                                  if (value["status"] == "1") {
                                                    Get.close(1);

                                                    Get.offAll(() =>
                                                        DashboardScreen());
                                                  }
                                                });
                                              } else {
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: ColorConstant.maingreen,
                                          ),
                                          child: Center(
                                              child: Text(
                                            AppLocalizations.of(context)!
                                                .msgCencel,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller
                                              .submitRequstPrice(value
                                                  .orders![0].id
                                                  .toString())
                                              .then((value) {
                                            ref.invalidate(allBookingsProvider);

                                            if (value["status"] == "1") {
                                              // wait here
                                              Get.close(1);
                                              Get.offAll(
                                                  () => DashboardScreen());
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: ColorConstant.maingreen,
                                          ),
                                          child: Center(
                                              child: Text(
                                            AppLocalizations.of(context)!
                                                .msgSubmit,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ));
        }

        if ((value.orders ?? []).isNotEmpty &&
            value.orders?.first.weightStatus != null &&
            value.orders?.first.weightStatus.toString() == "1") {
          showBarModalBottomSheet(
              context: context,
              builder: (context) => Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.msgCommodityy,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto')),
                              Text(" : ${value.orders?[0].category.toString()}"
                                  .tr),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.finalWeightOf,
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Roboto')),
                              Text(
                                  "${value.orders?[0].weight == null ? "0" : value.orders?[0].weight.toString()} (Qtl.)"
                                      .tr,
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Roboto')),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.finalamount,
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Roboto')),
                              Text(
                                  " : ${value.orders?[0].finalPrice == null ? "0" : value.orders?[0].finalPrice.toString()}"
                                      .tr,
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Roboto')),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              //

                              controller
                                  .submitPriceRequst(
                                value.orders?[0].id.toString(),
                              )
                                  .then((value) {
                                ref.invalidate(allBookingsProvider);
                                if (value["status"] == "1") {
                                  Get.close(1);
                                  Get.offAll(() => DashboardScreen());
                                }
                              });
                            },
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ColorConstant.maingreen,
                              ),
                              child: Center(
                                  child: Text(
                                AppLocalizations.of(context)!.msgSubmit,
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
        }
      });
    });

    controller.setLpuserId(widget.lpuserId);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(allBookingsProvider(status: '1')).when(
        data: (data) => Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstant.maingreen,
              title: Center(child: Text("")),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.notifications,
                    color: ColorConstant.maingreen,
                  ),
                )
              ],
            ),
            body: SlidingUpPanel(
              controller: ref.watch(panelController),
              minHeight: 30,
              defaultPanelState: PanelState.OPEN,
              maxHeight: Adaptive.h(30),
              parallaxEnabled: true,
              panelBuilder: () => Card(
                  margin: Pad.zero,
                  elevation: 5,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: ColorConstant.maingreen),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  child: ListView(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 8.0,
                                        top: 8.0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        data.orders?[0].imagePath == null
                                            ? Image.asset(
                                                ImageConstant.imgnoimage,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : CircleAvatar(
                                                radius: 35,
                                                backgroundImage: NetworkImage(
                                                    "$IMAGE_BASE_URL${data.orders?[0].imagePath ?? ""}/${data.orders?[0].passportImage ?? ""}")),
                                        /*CircleImageView(
                                    radius: 35,
                                    image: IMAGE_BASE_URL+cont.ordersmodeldata!.orders![0].imagePath.toString()+"/"+cont.ordersmodeldata!.orders![0].passportImage.toString(),
                                  ),*/
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${data.orders?[0].name}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 8.0,
                                                  top: 10.0,
                                                  bottom: 8.0),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      // print("idy");
                                                      // print(cont.ordersmodeldata!.orders![0].id);
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TrackbookingDetails(
                                                                      bookingId:
                                                                          "${data.orders?[0].id}")),
                                                        );
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: ColorConstant
                                                              .maingreen),
                                                      child: Center(
                                                          child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    18.0,
                                                                vertical: 8.0),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .trackRide,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Roboto'),
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                          .apnauserCancilBooking(
                                                              data.orders?[0].id
                                                                  .toString(),
                                                              widget.lpuserId
                                                                  .toString(),
                                                              data.orders?[0]
                                                                  .lpCancelReason
                                                                  .toString())
                                                          .then((value) {
                                                        ref.invalidate(
                                                            allBookingsProvider);

                                                        if (value["status"] ==
                                                            "1") {
                                                          Get.offAll(
                                                              DashboardScreen());
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: ColorConstant
                                                              .red500),
                                                      child: Center(
                                                          child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    18.0,
                                                                vertical: 8.0),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .rejectRide,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Roboto'),
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  )),
              body: Container(),
            )),
        error: (e, s) => Container(),
        loading: () => defaultLoader());
  }
}

var positionStream = StreamProvider((ref) => Geolocator.getPositionStream(
    locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 0)));

var locationProvider = StateProvider<Position?>((ref) {
  Position? position;
  Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
              accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 0))
      .then((value) {
    position = value;
  });

  return position;
});
