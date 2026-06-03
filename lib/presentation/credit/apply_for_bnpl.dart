import 'package:apnagodam/core/utils/no_data_found_widget.dart';

import 'package:apnagodam/core/utils/theme/app_style.dart';

import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:apnagodam/presentation/login_screen/LoginBottomsheet.dart';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import 'credit_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class ApplyforBNPL extends ConsumerStatefulWidget {
  const ApplyforBNPL({super.key});

  @override
  ConsumerState<ApplyforBNPL> createState() => _ApplyforBNPLState();
}

class _ApplyforBNPLState extends ConsumerState<ApplyforBNPL> {
  TextEditingController bnplrequestAmountController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgcolor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstant.maingreen,
        title: Text(
          AppLocalizations.of(context)!.applyForBnpl,
          style: AppStyle.lblAppbar,
        ),
      ),
      body: ref
          .watch(userDetailsProvider)
          .when(
            data:
                (userDetails) => SingleChildScrollView(
                  child: Padding(
                    padding: Pad(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/images/bnpl-banner-1.svg",
                              height: Adaptive.sh(25),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20,
                                left: 10,
                                right: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.usedamount,
                                        style: AppStyle.lblloging,
                                      ),
                                      Text(
                                        currencyFormat.format(
                                          userDetails
                                              .userDetails
                                              ?.bnplUsedPower,
                                        ),
                                        style: AppStyle.lblloging,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.balance,
                                        style: AppStyle.lblloging,
                                      ),
                                      Text(
                                        " : ${currencyFormat.format(userDetails.userDetails?.bnplPower)}",
                                        style: AppStyle.lblloging,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.0,
                                right: 15,
                                bottom: 10,
                              ),
                              child: Form(
                                key: _formkey,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  // color: Colors.red,
                                  child: Container(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      controller: bnplrequestAmountController,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.currency_rupee,
                                          color: Colors.black,
                                        ),
                                        hintText: 'Enter amount',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 7,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            7,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            7,
                                          ),
                                          borderSide: BorderSide(
                                            color: ColorConstant.maingreen,
                                          ),
                                        ),
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return AppLocalizations.of(
                                            context,
                                          )!.enterAmount;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            error: (e, s) => noStockData(),
            loading: () => defaultLoader(),
          ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        child: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.bnplMessage,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: AppLocalizations.of(context)!.wallet,
                      style: TextStyle(color: Colors.red, fontFamily: 'Roboto'),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.bnplMessage,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: ColorConstant.maingreen,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      await ref
                          .watch(
                            bnplAddRequestProvider(
                              requestAmount: bnplrequestAmountController.text,
                            ).future,
                          )
                          .then((value) async {
                            if (value['status'] == 1) {
                              Get.rawSnackbar(
                                message: value["message"].toString(),
                                duration: Duration(seconds: 10),
                                backgroundColor: ColorConstant.maingreen,
                              );
                              ref.invalidate(bnplListProvider);
                              Get.back(closeOverlays: true);
                            } else if (value['status'] == 0) {
                              Get.rawSnackbar(
                                message: value["message"].toString(),
                                duration: Duration(seconds: 10),
                                backgroundColor: ColorConstant.red500,
                              );
                            } else {
                              showBottomSheet(
                                context: context,
                                builder:
                                    (bottomsheetContext) =>
                                        ElevarmDraggableBottomSheet(
                                          title: "Login to Continue",
                                          onPressedClose: () => Get.back(),
                                          children: [LoginBottomSheet()],
                                        ),
                              );
                            }
                          });
                    } else {}
                  },
                  child: Text(
                    AppLocalizations.of(context)!.applyForBnpl,
                    style: AppStyle.lblmoneybtn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
