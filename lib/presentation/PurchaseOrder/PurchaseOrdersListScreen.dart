import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/PurchaseOrder/model/PurchaseOrdersListingModel.dart';
import 'package:apnagodam/presentation/PurchaseOrder/service/PurchaseOrderService.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:apnagodam/widgets/dailogs/customAlertDialog.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class Purchaseorderslistscreen extends ConsumerStatefulWidget {
  const Purchaseorderslistscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PurchaseorderslistscreenState();
}

class _PurchaseorderslistscreenState
    extends ConsumerState<Purchaseorderslistscreen> {
  String _getPoImageUrl(Datum? po) {
    if (po == null) return '';
    final poImage = po.poImage?.toString().trim() ?? '';
    final imageUrl = po.imageUrl?.toString().trim() ?? '';

    if (poImage.isEmpty && imageUrl.isEmpty) return '';

    // If poImage is already a full URL
    if (poImage.startsWith('http://') || poImage.startsWith('https://')) {
      return poImage;
    }

    // If imageUrl is already a full URL
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      if (imageUrl.endsWith('/') && poImage.isNotEmpty) {
        return '$imageUrl$poImage';
      } else if (poImage.isNotEmpty && !imageUrl.endsWith(poImage)) {
        return '$imageUrl/$poImage';
      }
      return imageUrl;
    }

    // Base prefix from imageUrl or fallback to 'resources/assets/upload/po/'
    String pathPrefix =
        imageUrl.isNotEmpty ? imageUrl : 'resources/assets/upload/po/';
    if (pathPrefix.startsWith('/')) {
      pathPrefix = pathPrefix.substring(1);
    }
    if (!pathPrefix.endsWith('/')) {
      pathPrefix = '$pathPrefix/';
    }

    if (poImage.isNotEmpty) {
      if (poImage.startsWith(pathPrefix)) {
        return '$BASEURL$poImage';
      }
      return '$BASEURL$pathPrefix$poImage';
    }

    return '$BASEURL$pathPrefix';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.purchaseOrderList),
        bottom: PreferredSize(
          preferredSize: Size(Adaptive.w(100), Adaptive.sh(5)),
          child: Container(
            color: ColorConstant.maingreen.withOpacity(0.8),
            padding: const Pad(all: 10),
            child: IntrinsicHeight(
              child: Row(children: [
                Expanded(
                    child: Text(
                  AppLocalizations.of(context)!.uniqueId,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: Adaptive.sp(16)),
                )),
                const VerticalDivider(),
                Expanded(
                    child: Text(
                  AppLocalizations.of(context)!.msgCommodity,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: Adaptive.sp(16)),
                )),
                const VerticalDivider(),
                Expanded(
                    child: Text(
                  AppLocalizations.of(context)!.warehousename,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: Adaptive.sp(16)),
                )),
                const VerticalDivider(),
                Expanded(
                    child: Text(
                  AppLocalizations.of(context)!.msgWeightt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: Adaptive.sp(16)),
                )),
              ]),
            ),
          ),
        ),
      ),
      body: puchaseOrderListLayout(),
    );
  }

  Widget puchaseOrderListLayout() {
    return RefreshIndicator.adaptive(
        child: ListView(
          children: [
            ref.watch(purchaseOrdersListProvider).when(
                data: (data) {
                  var activeList = data.data
                      ?.where((po) => po.status.toString() == "1")
                      .toList();
                  return ListView.builder(
                    itemCount: activeList?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      color: index % 2 == 0
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.white,
                      padding: const Pad(all: 10),
                      child: IntrinsicHeight(
                        child: Row(children: [
                          Expanded(
                              child: Text.rich(
                            TextSpan(
                              text: "${activeList?[index].uniqueId}",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                      context: context,
                                      builder: (dialogContext) =>
                                          showCustomAlertDialog(
                                              context,
                                              ColumnSuper(children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.terminal5,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                      "${activeList?[index].warehouseName}",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize:
                                                              Adaptive.sp(16)),
                                                    )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(AppLocalizations.of(context)!.poNo2,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].uniqueId}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.deliveredQty2,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].deliverdQty ?? "na"}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.availableQty2,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].avaiQty ?? "na"}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.holdQty2,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  0, 0, 0, 1),
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].holdQty ?? "na"}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.poImage2,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: _getPoImageUrl(activeList?[index]).isNotEmpty
                                                          ? (_getPoImageUrl(activeList?[index]).toLowerCase().endsWith('.pdf')
                                                              ? InkWell(
                                                                  onTap: () async {
                                                                    final uri = Uri.parse(_getPoImageUrl(activeList?[index]));
                                                                    if (await canLaunchUrl(uri)) {
                                                                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons.picture_as_pdf,
                                                                    color: ColorConstant.maingreen,
                                                                  ),
                                                                )
                                                              : InstaImageViewer(
                                                                  imageUrl:
                                                                      _getPoImageUrl(activeList?[index]),
                                                                  child: Icon(
                                                                    CupertinoIcons.eye,
                                                                    color: ColorConstant
                                                                        .maingreen,
                                                                  ),
                                                                ))
                                                          : const Text("N/A"),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(AppLocalizations.of(context)!.broker2,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].broker}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.buyerName2,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].buyerName}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.buyerPhone4,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].buyerPhone}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.buyerAddress3,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].buyerAddress}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.deliveryPincode3,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].deliveryPincode}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          AppLocalizations.of(context)!.qualityCondition3,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].qualityCondition}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(AppLocalizations.of(context)!.remark4,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Adaptive.sp(
                                                                      16))),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${activeList?[index].remark ?? "na"}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize:
                                                                Adaptive.sp(
                                                                    16)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                if (activeList?[index]
                                                        .activeStatus
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "active")
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text.rich(
                                                        TextSpan(
                                                            text: AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .poEdit,
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    Get.bottomSheet(
                                                                        editPurchaseOrderLayout(
                                                                            dialogContext,
                                                                            activeList![
                                                                                index]),
                                                                        backgroundColor:
                                                                            Colors
                                                                                .white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5)));
                                                                  },
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                decorationColor:
                                                                    ColorConstant
                                                                        .maingreen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: ColorConstant
                                                                    .maingreen,
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                        14))),
                                                        textAlign:
                                                            TextAlign.end,
                                                      )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                          child: Text.rich(
                                                        TextSpan(
                                                            text: AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .poDelete,
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    ref.watch(
                                                                        deletePOProvider(
                                                                            id: "${activeList?[index].id}"));
                                                                    Navigator.of(
                                                                            dialogContext)
                                                                        .pop();
                                                                  },
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                decorationColor:
                                                                    Colors.red
                                                                        .shade500,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .red
                                                                    .shade500,
                                                                fontSize:
                                                                    Adaptive.sp(
                                                                        14))),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ))
                                                    ],
                                                  )
                                              ]),
                                              AppLocalizations.of(context)!
                                                  .poDetails));
                                },
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: Adaptive.sp(16)),
                          )),
                          const VerticalDivider(),
                          Expanded(
                              child: Text(
                            "${activeList?[index].commodityName}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Adaptive.sp(16)),
                          )),
                          const VerticalDivider(),
                          Expanded(
                              child: Text(
                            "${activeList?[index].warehouseName ?? 0.0}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Adaptive.sp(16)),
                          )),
                          const VerticalDivider(),
                          Expanded(
                              child: Text(
                            "${activeList?[index].weight}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: Adaptive.sp(16)),
                          )),
                        ]),
                      ),
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
        onRefresh: () {
          return Future.value((_) {
            ref.invalidate(purchaseOrdersListProvider);
          });
        });
  }

  editPurchaseOrderLayout(context, Datum data) {
    final pendingQuantityController = TextEditingController();
    final expiryDateController = TextEditingController();
    final remarkController = TextEditingController();
    final editingKey = GlobalKey<FormState>();
    return Form(
        key: editingKey,
        child: Padding(
          padding: Pad(all: 10),
          child: ColumnSuper(children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.updatePurchaseOrder,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: Adaptive.sp(17), fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(
              endIndent: 150,
              thickness: 4,
              color: ColorConstant.maingreen,
            ),
            SizedBox(
              height: 10,
            ),
            CommonTextField(
              label: AppLocalizations.of(context)!.pendingQuantity,
              controller: pendingQuantityController,
              textInputAction: TextInputAction.next,
              inputType: const TextInputType.numberWithOptions(decimal: false),
              enabled: true,
              isRequired: true,
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2050),
                ).then((dateValue) {
                  if (dateValue != null) {
                    expiryDateController.text =
                        DateFormat('dd-MM-yyyy').format(dateValue);
                  }
                });
              },
              child: CommonTextField(
                label: AppLocalizations.of(context)!.expiryDate2,
                isDate: true,
                controller: expiryDateController,
                hintText: "e.g 01/01/2025",
                textInputAction: TextInputAction.next,
                inputType: TextInputType.datetime,
                enabled: false,
                readOnly: true,
                isRequired: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CommonTextField(
              label: AppLocalizations.of(context)!.remark3,
              controller: remarkController,
              textInputAction: TextInputAction.done,
              inputType: TextInputType.text,
              enabled: true,
              isRequired: true,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (editingKey.currentState!.validate()) {
                    ref
                        .watch(editPoProvider(
                                id: data.id.toString(),
                                remark: remarkController.text,
                                expiry: expiryDateController.text,
                                pendingQty: pendingQuantityController.text)
                            .future)
                        .then((value) {
                      if (value['status'].toString() == "1") {
                        Get.back();
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: value['message'].toString(),
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: ColorConstant.maingreen);
                      } else {
                        Fluttertoast.showToast(
                            msg: value['message'].toString(),
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: ColorConstant.red500);
                      }
                    }).onError((e, s) {
                      Get.back();
                      Navigator.of(context).pop();
                    });
                  }
                },
                style: AppStyle.buttonStyle,
                child: Text(
                  AppLocalizations.of(context)!.msgSubmit,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ));
  }
}
