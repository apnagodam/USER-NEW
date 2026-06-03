import 'dart:async';

import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/cancel_dailog.dart';
import '../../../core/utils/color_constant.dart';
import '../../../core/utils/progress_dialog_utils.dart';
import '../../../data/apiClient/apiClient.dart';
import '../../../main.dart';
import '../../splash_screen/splash_screen.dart';
import '../model/All_bookings_model.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class LplistController extends GetxController {
  // late GoogleMapController mapController;
  // LatLng? currentLocation;

  AllBookingsModel? ordersmodeldata;

  String lpuserId = '';

  void setLpuserId(String id) {
    lpuserId = id;
    print("lpuserId$lpuserId");
    goMap();
    apnauserAllBooking("1");
  }

  @override
  void onInit() {
    apnauserAllBooking("1");
    //
    // timer  = Timer.periodic(const Duration(seconds: 3), (Timer t) {
    //
    //   apnauserAllBooking("1");
    //
    // });

    super.onInit();
  }

  Future apnauOnBookMgpLp(
      var lpuserId,
      var commodityId,
      var quantity,
      var price,
      var salesStatus,
      var categoryImage,
      var commodityImagePath,
      var terminalId,
      var agCommission,
      var lpCommission,
      var user,
      var distance,
      var lpLat,
      var lpLong,
      var corporateUsersLat,
      var corporateUsersLong,
      var finalPrice,
      var subPrice,
      var transportPrice,
      var loadingCharge,
      var mandiTax) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    refresh();
    await ApiClient.apnauOnBookMgpLpService(
            lpuserId,
            commodityId,
            quantity,
            price,
            salesStatus,
            categoryImage,
            commodityImagePath,
            terminalId,
            agCommission,
            lpCommission,
            user,
            distance,
            lpLat,
            lpLong,
            corporateUsersLat,
            corporateUsersLong,
            finalPrice,
            subPrice,
            transportPrice,
            loadingCharge,
            mandiTax)
        .then((value) {
      update();
      if (value != null) {
        if (value['status'].toString() == "1") {
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);
          print(value);
          return value;
        } else if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
          Get.offAll(() => SplashScreen());
        }
        Get.rawSnackbar(
            message: value["message"],
            duration: const Duration(seconds: 2),
            backgroundColor: ColorConstant.red500);
      }

      // return value;
    });
  }

  Future apnauserAllBooking(var status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ProgressDialogUtils.showProgressDialog(isCancellable: true);
    update();
    await ApiClient.apnauserAllBookingService(status).then((value) {
      update();

      print(value);
      print("hi ss");
      if (value != null) {
        if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
          // Get.offAll(() => SplashScreen());
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        } else {
          ordersmodeldata = AllBookingsModel.fromMap(value);
          update();
        }
      }
    });
  }

  Future apnauserCancilBooking(
      var bookingId, var lpUserId, var cancilreson) async {
    var valueT;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    update();
    await ApiClient.apnauserCancilBookingService(
            bookingId, lpUserId, cancilreson)
        .then((value) {
      update();
      valueT = value;
      if (value != null) {
        if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
          Get.offAll(() => SplashScreen());
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        }
        if (value["status"] == "1") {
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);
        } else {}
      }
    });
    return valueT;
  }

  Future submitRequstPrice(var bookingId) async {
    var valueT;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    update();
    await ApiClient.submitWeightRequst(bookingId).then((value) {
      update();
      valueT = value;
      if (value != null) {
        if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
          Get.offAll(() => SplashScreen());
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        }
        if (value["status"] == "1") {
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);
        } else {}
      }
    });
    return valueT;
  }

  Future submitPriceRequst(var bookingId) async {
    var valueT;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    update();
    await ApiClient.submitPriceRequst(bookingId).then((value) {
      update();
      valueT = value;
      if (value != null) {
        if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
          Get.offAll(() => SplashScreen());
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        }
        if (value["status"] == "1") {
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);
        } else {}
      }
    });
    return valueT;
  }

  void goMap() async {
    try {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((position) {
        //  currentLocation = LatLng(position.latitude, position.longitude);
      });

      refresh();
    } catch (e) {
      printError(info: "$e");
    }
  }

  weightConfirmation(Order orders) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      context: mainNavKey.currentContext!,
      builder: (context) {
        return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 15, bottom: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.msgCommodityy,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                          Text(" : ${orders.category.toString()}"),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.finalWeightOf,
                              style: const TextStyle(
                                  fontSize: 14, fontFamily: 'Roboto')),
                          Text(
                              "${orders.weight == null ? "0" : orders.weight.toString()} (Qtl.)"
                                  .tr,
                              style: const TextStyle(
                                  fontSize: 14, fontFamily: 'Roboto')),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.finalamount,
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: 'Roboto')),
                          Text(
                              " : ${orders.finalPrice == null ? "0" : orders.finalPrice.toString()}"
                                  .tr,
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: 'Roboto')),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          //
                          submitPriceRequst(
                            ordersmodeldata!.orders![0].id.toString(),
                          ).then((value) {
                            if (value["status"] == "1") {}
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
              ],
            ));
      },
    );
  }

  priceConfirmation(Order orders) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      context: mainNavKey.currentContext!,
      builder: (context) {
        return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 15, bottom: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.finalPriceOf,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                          Text(" : ${orders.category.toString()}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.newPriceInQti,
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: 'Roboto')),
                          Text(
                              orders.finalPrice == null
                                  ? "0"
                                  : orders.finalPrice.toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontFamily: 'Roboto')),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("objecta");
                                showDecisionDialog(
                                  context,
                                  AppLocalizations.of(context)!.msgAlert,
                                  AppLocalizations.of(context)!.declineMmsg,
                                  (bool userClickedOK) {
                                    if (userClickedOK) {
                                      apnauserCancilBooking(
                                        ordersmodeldata?.orders?[0].id
                                            .toString(),
                                        lpuserId.toString(),
                                        ordersmodeldata
                                            ?.orders?[0].lpCancelReason
                                            .toString(),
                                      ).then((value) {
                                        if (value["status"] == "1") {
                                          Navigator.of(context).pop();

                                          Get.offAll(() => DashboardScreen());
                                        }
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                      //
                                      print('User clicked Cancel');
                                      // Perform actions for 'Cancel' button click
                                    }
                                  },
                                );
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: ColorConstant.maingreen,
                                ),
                                child: Center(
                                    child: Text(
                                  AppLocalizations.of(context)!.msgCencel,
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                submitRequstPrice(ordersmodeldata!.orders![0].id
                                        .toString())
                                    .then((value) {
                                  if (value["status"] == "1") {
                                    Navigator.of(context).pop();
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
