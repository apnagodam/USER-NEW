import 'dart:io';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/TripId/UpdateTrip/UpdateTripScreen.dart';
import 'package:apnagodam/presentation/market_screen/market_screen.dart';
import 'package:apnagodam/presentation/sbt/service/SbtService.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:apnagodam/widgets/dailogs/customAlertDialog.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Dispatchrequestslisting extends ConsumerStatefulWidget {
  const Dispatchrequestslisting({super.key, required this.orderId});
  final String orderId;
  @override
  ConsumerState<Dispatchrequestslisting> createState() =>
      _DispatchrequestslistingState();
}

class _DispatchrequestslistingState
    extends ConsumerState<Dispatchrequestslisting> {
  final _grnImageProvider = StateProvider<File?>((ref) => null);
  final _kantaImageProvider = StateProvider<File?>((ref) => null);
  final _grnController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dispatchRequests),
      ),
      body: ref
          .watch(dispatchListingProvider(sbtOrderId: widget.orderId))
          .when(
            data:
                (data) {
                  final list = data.data ?? [];
                  if (list.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        ref.invalidate(dispatchListingProvider(sbtOrderId: widget.orderId));
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.noDataFound,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(dispatchListingProvider(sbtOrderId: widget.orderId));
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(10),
                      itemCount: list.length,
                      itemBuilder:
                          (context, index) => Card(
                        color: Colors.white,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: ColorConstant.maingreen),
                        ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                              Center(
                                child: Text(
                                  "${data.data?[index].orderId ?? 0}",
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //         child: Text(
                              //       "Type",
                              //       style: TextStyle(
                              //           fontSize: Adaptive.sp(16),
                              //           fontWeight: FontWeight.w500),
                              //     )),
                              //     Text(
                              //       "${ref.watch(sellOrdersListProvider)?[index].type ?? 0}",
                              //       style: TextStyle(
                              //           fontSize: Adaptive.sp(16),
                              //           fontWeight: FontWeight.w500),
                              //     )
                              //   ],
                              // ),
                              //  SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //         child: Text(
                              //       "Buyer Name",
                              //       style: TextStyle(
                              //           fontSize: Adaptive.sp(16),
                              //           fontWeight: FontWeight.w500),
                              //     )),
                              //     Text(
                              //       "${data.data?[index]. ?? ''}",
                              //       style: TextStyle(
                              //           fontSize: Adaptive.sp(16),
                              //           fontWeight: FontWeight.w500),
                              //     )
                              //   ],
                              // ),
                              //  SizedBox(
                              //   height: 10,
                              // ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.salesType,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${data.data?[index].salesStatus ?? "--"}",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.requestDate,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${data.data?[index].requestDate ?? 0}",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.quantityLabel,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${data.data?[index].weight ?? 0} Qtl.",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.vehicleNo,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${data.data?[index].vehicleNumber ?? "--"} ",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.msgDriverNumber,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${data.data?[index].driverNumber}",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              if (data.data?[index].checkKantaParchi != null)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.kantaImage,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    InstaImageViewer(
                                      imageUrl: data.data?[index].kantaParchi,
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color: ColorConstant.maingreen,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 10),
                              if (data.data?[index].checkBillty != null)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.biltyImage,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    InstaImageViewer(
                                      imageUrl: data.data?[index].billty,
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color: ColorConstant.maingreen,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 10),
                              if (data.data?[index].checkGrn != null)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!.grnImage,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    InstaImageViewer(
                                      imageUrl: data.data?[index].grn,
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color: ColorConstant.maingreen,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 10),

                              if (data.data?[index].checkRecevingKantaParchi !=
                                  null)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.msgReceivingKantaParchi,
                                        style: TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    InstaImageViewer(
                                      imageUrl:
                                          data.data?[index].recevingKantaParchi,
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color: ColorConstant.maingreen,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 10),

                              if (data.data?[index].checkInvoice != null &&
                                  (data.data?[index].checkGrn == null ||
                                      data.data?[index].checkKantaParchi ==
                                          null))
                                Row(
                                  children: [
                                    Expanded(child: InkWell(
                                      onTap: () async {
                                        showImageSourceFilePickerDialog(
                                          context,
                                          (value) {
                                            ref
                                                .watch(
                                                  _grnImageProvider.notifier,
                                                )
                                                .state = File(value.path);
                                          },
                                        );
                                      },
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        dashPattern: [6, 6, 6, 6],
                                        color: ColorConstant.maingreen,
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Center(
                                            child:
                                                ref.watch(_grnImageProvider) !=
                                                        null
                                                    ? Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.upload,
                                                          color:
                                                              ColorConstant
                                                                  .maingreen,
                                                        ),
                                                        SizedBox(height: 10),
                                                        Center(
                                                          child: Text(
                                                            "${ref.watch(_grnImageProvider)?.name}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    14,
                                                                  ),
                                                            ),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                    : Column(
                                                      children: [
                                                        Icon(Icons.upload),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          'Grn Image',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Adaptive.sp(14),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                          ),
                                        ),
                                      ),
                                    )),
                                    SizedBox(width: 5),
                                    Expanded(child: InkWell(
                                      onTap: () async {
                                        showImageSourceFilePickerDialog(
                                          context,
                                          (value) {
                                            ref
                                                .watch(
                                                  _kantaImageProvider.notifier,
                                                )
                                                .state = File(value.path);
                                          },
                                        );
                                      },
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        dashPattern: [6, 6, 6, 6],
                                        color: ColorConstant.maingreen,
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Center(
                                            child:
                                                ref.watch(
                                                          _kantaImageProvider,
                                                        ) !=
                                                        null
                                                    ? Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.upload,
                                                          color:
                                                              ColorConstant
                                                                  .maingreen,
                                                        ),
                                                        SizedBox(height: 10),
                                                        Center(
                                                          child: Text(
                                                            "${ref.watch(_kantaImageProvider)?.name}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                    14,
                                                                  ),
                                                            ),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                    : Column(
                                                      children: [
                                                        Icon(Icons.upload),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          'Kanta  Image',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Adaptive.sp(14),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                          ),
                                        ),
                                      ),
                                    )),
                                  ],
                                ),

                              SizedBox(height: 10),
                              if (data.data?[index].checkInvoice != null &&
                                  (data.data?[index].checkGrn == null ||
                                      data.data?[index].checkKantaParchi ==
                                          null))
                                CommonTextField(
                                  hintText:
                                      AppLocalizations.of(context)!.grnNumber,
                                  label:
                                      AppLocalizations.of(context)!.grnNumber,
                                  isRequired: true,
                                  controller: _grnController,
                                ),
                              SizedBox(height: 10),
                              if (data.data?[index].status.toString() == "1")
                                Row(
                                  children: [
                                    if ((data.data?[index].checkGrn == null ||
                                        data.data?[index].checkKantaParchi ==
                                            null))
                                      Expanded(
                                        child: ElevarmPrimaryButton.text(
                                          text: 'Update Request',
                                          onPressed: () {
                                            if (ref.watch(_grnImageProvider) ==
                                                null) {
                                              context.errorToast(
                                                'Select Grn Image',
                                              );
                                            } else if (_grnController
                                                .text
                                                .isEmpty) {
                                              context.errorToast(
                                                'Enter Grn Number',
                                              );
                                            } else if (ref.read(
                                                  _kantaImageProvider,
                                                ) ==
                                                null) {
                                              context.errorToast(
                                                'Select Kanta Image',
                                              );
                                            } else {
                                              ref
                                                  .read(
                                                    editDispatchRequestProvider(
                                                      id:
                                                          data.data?[index].id
                                                              .toString(),
                                                      grnNumber:
                                                          _grnController.text,
                                                      kantaParchiImage: ref.read(
                                                        _kantaImageProvider,
                                                      ),
                                                      grnImage: ref.read(
                                                        _grnImageProvider,
                                                      ),
                                                    ).future,
                                                  )
                                                  .then((value) {
                                                if (value['status'].toString() ==
                                                    "1") {
                                                  ref.invalidate(
                                                    dispatchListingProvider(
                                                      sbtOrderId: widget.orderId,
                                                    ),
                                                  );
                                                  ref.invalidate(
                                                    dispatchListingNewProvider,
                                                  );
                                                  Get.back();
                                                }
                                              });
                                            }
                                          },
                                          buttonThemeData:
                                              ElevarmPrimaryButtonThemeData(
                                                primaryColor:
                                                    ref.watch(
                                                                  _grnImageProvider,
                                                                ) ==
                                                                null ||
                                                            ref.watch(
                                                                  _kantaImageProvider,
                                                                ) ==
                                                                null
                                                        ? ElevarmColors
                                                            .neutral300
                                                        : ElevarmColors
                                                            .success800,
                                              ),
                                        ),
                                      ),
                                    SizedBox(width: 10),
                                    if (data.data?[index].checkInvoice == null)
                                      Expanded(
                                        child: ElevarmPrimaryButton.text(
                                          text: 'Reject Request',
                                          onPressed: () {
                                            ref
                                                .read(
                                                  deleteDispatchRequestProvider(
                                                    id:
                                                        data.data?[index].id
                                                            .toString(),
                                                    sbtOrderId: widget.orderId,
                                                  ).future,
                                                )
                                                .then((value) {
                                              if (value['status'].toString() ==
                                                  "1") {
                                                ref.invalidate(
                                                  dispatchListingProvider(
                                                    sbtOrderId: widget.orderId,
                                                  ),
                                                );
                                                ref.invalidate(
                                                  dispatchListingNewProvider,
                                                );
                                                Get.back();
                                              }
                                            });
                                          },
                                          buttonThemeData:
                                              ElevarmPrimaryButtonThemeData(
                                                primaryColor:
                                                    ElevarmColors.danger,
                                              ),
                                        ),
                                      ),
                                  ],
                                ),

                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  data.data?[index].checkGrn != null &&
                                          data.data?[index].status.toString() ==
                                              "1"
                                      ? "Verification Pending"
                                      : data.data?[index].checkGrn != null &&
                                          data.data?[index].status.toString() ==
                                              "2"
                                      ? "Approval Pending"
                                      : data.data?[index].checkGrn != null &&
                                          data.data?[index].status.toString() ==
                                              "3"
                                      ? "Done"
                                      : "",
                                  style: TextStyle(
                                    fontSize: Adaptive.sp(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
            error: (e, s) => Container(),
            loading: () => defaultLoader(),
          ),
    );
  }
}
