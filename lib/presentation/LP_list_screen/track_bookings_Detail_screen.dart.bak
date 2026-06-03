import 'package:apnagodam/presentation/LP_list_screen/track_ride_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/helper.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/theme/app_style.dart';
import '../../widgets/circle_image_view.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class TrackbookingDetails extends StatefulWidget {
  final bookingId;
  const TrackbookingDetails({super.key, this.bookingId});

  @override
  State<TrackbookingDetails> createState() => _TrackbookingDetailsState();
}

class _TrackbookingDetailsState extends State<TrackbookingDetails> {
  int _currentStep = 3;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Trackcontroller>(
        init: Trackcontroller(widget.bookingId),
        builder: (c) {
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstant.maingreen,
              title: Center(
                  child: Text(
                AppLocalizations.of(context)!.deliveryDetail,
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
            body: c.loading
                ? SizedBox.shrink()
                : ListView(
                    children: [
                      Container(
                        color: ColorConstant.maingreen,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.pickupAt,
                                    style: AppStyle.lblAppbar
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.distance,
                                    style: AppStyle.lblAppbar
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${c.trackdata!.arrivalTime == null ? "0" : c.trackdata!.arrivalTime.toString()} AM"
                                        .tr,
                                    style: AppStyle.lblAppbar
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    "${c.trackdata!.lpToUserKm == null ? "0" : c.trackdata!.lpToUserKm.toString()} km"
                                        .tr,
                                    style: AppStyle.lblAppbar
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                              )
                            ],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: [
                                CircleImageView(
                                  radius: 35,
                                  image:
                                      "$IMAGE_BASE_URL${c.trackdata!.commodityImagePath}/${c.trackdata!.commodityImage}",
                                ),
                                Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .commodityDeails,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        c.trackdata!.category.toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      "${c.trackdata!.weight == null ? "0" : c.trackdata!.weight.toString()} (Qtl.)"
                                          .tr,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.itemPackage,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Stepper(
                                  currentStep: _currentStep,
                                  physics: NeverScrollableScrollPhysics(),
                                  onStepTapped: (int newindex) {
                                    setState(() {
                                      print(
                                        "${c.trackdata!.conectorName.toString()} confirm_booking"
                                            .tr,
                                      );
                                      print("......");
                                      _currentStep = newindex;
                                    });
                                  },
                                  controlsBuilder: (context, onStepContinue) {
                                    return SizedBox();
                                  },
                                  steps: [
                                    Step(
                                        state: StepState.complete,
                                        isActive: true,
                                        title: Text(
                                          AppLocalizations.of(context)!
                                              .bookAstock,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto'),
                                        ),
                                        content: Container()),
                                    Step(
                                      state: StepState.complete,
                                      isActive: true,
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .bookingAccepted,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto'),
                                      ),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              c.trackdata!.passportImage == null
                                                  ? Image.asset(
                                                      ImageConstant.imgnoimage,
                                                      fit: BoxFit.fitWidth,
                                                    )
                                                  : CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage: NetworkImage(
                                                          "$IMAGE_BASE_URL${c.trackdata!.imagePath}/${c.trackdata!.passportImage!}")),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${c.trackdata!.passportImage.toString()}${AppLocalizations.of(context)!.confirmBooking}",
                                                  style: AppStyle.lblalerttext,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  CallLaunch('tel:7733901154');
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black45,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.call,
                                                        color: Colors.green,
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .call,
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'Roboto'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  CallLaunch(
                                                      // "sms:917733901154"
                                                      "sms:917733901154?body=your+text+here"
                                                      // 'sms://send?text=sample text&phone=917733901154');
                                                      );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black45,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.sms_outlined,
                                                        color: Colors.green,
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .sms,
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'Roboto'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Step(
                                        state: StepState.complete,
                                        isActive: true,
                                        title: Text(
                                          AppLocalizations.of(context)!
                                              .onTheWay,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto'),
                                        ),
                                        content: Column(
                                          children: [
                                            Row(
                                              children: [
                                                // Text(AppLocalizations.of(context)!.ontheWay),
                                                Text(
                                                    "${c.trackdata!.name.toString()}${AppLocalizations.of(context)!.ontheWay}"),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Step(
                                        state: StepState.complete,
                                        isActive: true,
                                        title: Text(
                                          AppLocalizations.of(context)!
                                              .readyToPickup,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Roboto'),
                                        ),
                                        content: Column(
                                          children: [
                                            Row(
                                              children: [
                                                // Text(AppLocalizations.of(context)!.pickup),

                                                Text(
                                                    "${c.trackdata!.name.toString()}${AppLocalizations.of(context)!.pickup}"),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ]),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
          ));
        });
  }
}
