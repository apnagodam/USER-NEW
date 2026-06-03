import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/warehouse_Tab/provider/warehouse_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class InwardsListingScreen extends ConsumerWidget {
  const InwardsListingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.maingreen,
          centerTitle: true,
          actions: [],
        ),
        body: ref.watch(GetinwardsSummaryProvider(page: 0)).when(
            data: (data) => Column(
                  children: [
                    Container(
                        // alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorConstant.maingreen,
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!.msgStackno,
                                      style: AppStyle.lblbuydetail),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.white,
                                width: 10,
                                thickness: 2,
                              ),
                              FittedBox(
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .msgTerminalname,
                                    style: AppStyle.lblbuydetail,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.white,
                                width: 10,
                                thickness: 2,
                              ),
                              FittedBox(
                                child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .msgCommodityy,
                                      style: AppStyle.lblbuydetail),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.white,
                                width: 10,
                                thickness: 2,
                              ),
                              FittedBox(
                                child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!.msgAction,
                                      style: AppStyle.lblbuydetail),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.data?.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.only(bottom: 3.0),
                                decoration: BoxDecoration(
                                  color: (index % 2 == 0)
                                      ? ColorConstant.mainlistgrayclr
                                      : Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IntrinsicHeight(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                    data.data?.data?[index]
                                                            .stackNumber ??
                                                        "_",
                                                    style:
                                                        AppStyle.aplayforloan),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color:
                                                  ColorConstant.listdivaderclr,
                                              width: 10,
                                              thickness: 2,
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    data.data?.data?[index]
                                                            .name ??
                                                        "",
                                                    style: AppStyle
                                                        .lblontestimonalname
                                                        .copyWith(fontSize: 12),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color:
                                                  ColorConstant.listdivaderclr,
                                              width: 10,
                                              thickness: 2,
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  data.data?.data?[index]
                                                          .category ??
                                                      "",
                                                  style: AppStyle
                                                      .lblontestimonalname,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color:
                                                  ColorConstant.listdivaderclr,
                                              width: 10,
                                              thickness: 2,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // if (cont.inwardData[index].status == 1 || cont.inwardData[index].status != null)...[
                                                    //   InkWell(
                                                    //     onTap: (){
                                                    //       print("Id");
                                                    //       print(cont.inwardData[index].id);
                                                    //       alertDialog(cont.inwardData[index].id.toString(),cont);
                                                    //     },
                                                    //     child: Container(
                                                    //         decoration: BoxDecoration(
                                                    //           color:Colors.red,
                                                    //           borderRadius: BorderRadius.circular(6),
                                                    //         ),
                                                    //         child:Padding(
                                                    //           padding:  EdgeInsets.only(left: 8.0,right: 8.0,bottom: 5.0,top: 5.0),
                                                    //           child: Text(AppLocalizations.of(context)!.reject,style: TextStyle(color: Colors.white,fontFamily: 'Roboto'),),
                                                    //         )
                                                    //     ),
                                                    //   ),
                                                    // ],
                                                    //
                                                    // if ( cont.inwardData[index].status == 2 ||cont.inwardData[index].status != null) ...[
                                                    //   Padding(
                                                    //     padding:  EdgeInsets.only(left: 8.0,right: 8.0,bottom: 5.0,top: 5.0),
                                                    //     child: Text(AppLocalizations.of(context)!.msgStatusRejected,style: TextStyle(color: Colors.grey,fontFamily: 'Roboto'),),
                                                    //   ),
                                                    //
                                                    // ],
                                                    //
                                                    // if ( cont.inwardData[index].status == 0 ||cont.inwardData[index].status != null) ...[
                                                    //   Container(
                                                    //       decoration: BoxDecoration(
                                                    //         color:Colors.transparent,
                                                    //         borderRadius: BorderRadius.circular(6),
                                                    //       ),
                                                    //       child:Padding(
                                                    //         padding:  EdgeInsets.only(left: 8.0,right: 8.0,bottom: 5.0,top: 5.0),
                                                    //         child: Text(AppLocalizations.of(context)!.msgSubmit,style: TextStyle(color: Colors.green,fontFamily: 'Roboto'),),
                                                    //       )
                                                    //   ),
                                                    //
                                                    // ],
                                                    data.data?.data?[index]
                                                                .status ==
                                                            1
                                                        ? InkWell(
                                                            onTap: () {
                                                              print("Id");
                                                              print(data
                                                                  .data
                                                                  ?.data?[index]
                                                                  .id);
                                                              // alertDialog(
                                                              //     data
                                                              //         .data
                                                              //         ?.data?[
                                                              //             index]
                                                              //         .id
                                                              //         .toString(),
                                                              //     warehousecont);
                                                            },
                                                            child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0,
                                                                      bottom:
                                                                          5.0,
                                                                      top: 5.0),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .reject,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            'Roboto'),
                                                                  ),
                                                                )),
                                                          )
                                                        : data
                                                                    .data
                                                                    ?.data?[
                                                                        index]
                                                                    .status ==
                                                                0
                                                            ? Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8.0,
                                                                        right:
                                                                            8.0,
                                                                        bottom:
                                                                            5.0,
                                                                        top:
                                                                            5.0),
                                                                child: Text(
                                                                  AppLocalizations.of(context)!.msgStatusRejected3,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontFamily:
                                                                          'Roboto'),
                                                                ),
                                                              )
                                                            : data
                                                                        .data
                                                                        ?.data?[
                                                                            index]
                                                                        .status ==
                                                                    2
                                                                ? Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .transparent,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              8.0,
                                                                          right:
                                                                              8.0,
                                                                          bottom:
                                                                              5.0,
                                                                          top:
                                                                              5.0),
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .msgSubmit,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.green,
                                                                            fontFamily: 'Roboto'),
                                                                      ),
                                                                    ))
                                                                : Container(),
                                                    InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: AlertDialog(
                                                              titlePadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              content: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(6))),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Wrap(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Get.back();
                                                                              },
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(4.0),
                                                                                    child: Icon(
                                                                                      Icons.close_outlined,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  )),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        IntrinsicHeight(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Text(
                                                                                AppLocalizations.of(context)!.msgStackno,
                                                                                style: AppStyle.lbleyepopup,
                                                                              )),
                                                                              Expanded(
                                                                                child: VerticalDivider(
                                                                                  width: 5,
                                                                                  thickness: 1,
                                                                                  color: ColorConstant.grey,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                  child: Text(
                                                                                data.data?.data?[index].stackNumber ?? "",
                                                                                // cont.wareHouseData[index].id.toString(),
                                                                                style: AppStyle.lbleyepopupsecond,
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                            color:
                                                                                Colors.grey),
                                                                        IntrinsicHeight(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Text(
                                                                                AppLocalizations.of(context)!.msgTerminalname,
                                                                                style: AppStyle.lbleyepopup,
                                                                              )),
                                                                              Expanded(
                                                                                child: VerticalDivider(
                                                                                  width: 5,
                                                                                  thickness: 1,
                                                                                  color: ColorConstant.grey,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                  child: Text(
                                                                                data.data?.data?[index].name ?? "",
                                                                                style: AppStyle.lbleyepopupsecond,
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                            color:
                                                                                Colors.grey),
                                                                        IntrinsicHeight(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Text(
                                                                                AppLocalizations.of(context)!.msgCommodity,
                                                                                style: AppStyle.lbleyepopup,
                                                                              )),
                                                                              Expanded(
                                                                                child: VerticalDivider(
                                                                                  width: 5,
                                                                                  thickness: 1,
                                                                                  color: ColorConstant.grey,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                  child: Text(
                                                                                data.data?.data?[index].category ?? "",
                                                                                style: AppStyle.lbleyepopupsecond,
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                            color:
                                                                                Colors.grey),
                                                                        IntrinsicHeight(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Text(
                                                                                AppLocalizations.of(context)!.msgNetweight,
                                                                                style: AppStyle.lbleyepopup,
                                                                              )),
                                                                              Expanded(
                                                                                child: VerticalDivider(
                                                                                  width: 5,
                                                                                  thickness: 1,
                                                                                  color: ColorConstant.grey,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                  child: Text(
                                                                                data.data?.data?[index].requestWeight ?? "",
                                                                                style: AppStyle.lbleyepopupsecond,
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                            color:
                                                                                Colors.grey),
                                                                        IntrinsicHeight(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Text(
                                                                                AppLocalizations.of(context)!.vehicleNo,
                                                                                style: AppStyle.lbleyepopup,
                                                                              )),
                                                                              Expanded(
                                                                                child: VerticalDivider(
                                                                                  width: 5,
                                                                                  thickness: 1,
                                                                                  color: ColorConstant.grey,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                  child: Text(
                                                                                data.data?.data?[index].vehicleNo ?? "",
                                                                                style: AppStyle.lbleyepopupsecond,
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                            color:
                                                                                Colors.grey),
                                                                        IntrinsicHeight(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Text(
                                                                                AppLocalizations.of(context)!.createDate,
                                                                                style: AppStyle.lbleyepopup,
                                                                              )),
                                                                              Expanded(
                                                                                child: VerticalDivider(
                                                                                  width: 5,
                                                                                  thickness: 1,
                                                                                  color: ColorConstant.grey,
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                  child: Text(
                                                                                data.data?.data?[index].createdAt ?? "",
                                                                                style: AppStyle.lbleyepopupsecond,
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                            color:
                                                                                Colors.grey),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        color: ColorConstant
                                                            .maingreen,
                                                      ),
                                                    ),
                                                  ]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          }),
                    ),
                  ],
                ),
            error: (e, s) {
              print(e.toString() + s.toString());
              return Container(
                child: Text(e.toString() + s.toString()),
              );
            },
            loading: () => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Container(
                          height: 70,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                )));
  }
}
