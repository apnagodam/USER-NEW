import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/presentation/spot_order_booking_screen/service/spot_orders_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:thermal_printer/esc_pos_utils_platform/src/enums.dart';
// import 'package:thermal_printer/thermal_printer.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/theme/app_style.dart';
import 'order_summary_screen.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class SpotOrderList extends ConsumerStatefulWidget {
  const SpotOrderList({super.key});

  @override
  ConsumerState<SpotOrderList> createState() => _SpotOrderListState();
}

// final PagingController<int, Datum> _pagingController =
// PagingController(firstPageKey: 0, invisibleItemsThreshold: 1);
class _SpotOrderListState extends ConsumerState<SpotOrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.bgcolor,
        appBar: AppBar(
          backgroundColor: ColorConstant.maingreen,
          automaticallyImplyLeading: true,
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.msgPurchase,
              style: AppStyle.lblAppbar,
            ),
          ),
        ),
        body: ref.watch(getWantToSellResponseProvider).when(
              data: (orders) => Padding(
                padding: EdgeInsets.all(00),
                child: (orders.data ?? []).isEmpty
                    ? noDataFoundOrders(context)
                    : ListView.builder(
                        itemCount: orders.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var status = orders.data?[index].status;
                          String statusvalue = "";

                          switch (status) {
                            case 0:
                              statusvalue = AppLocalizations.of(context)!
                                  .msgStatusRejected;
                              break;
                            case 1:
                              statusvalue = AppLocalizations.of(context)!
                                  .msgStatusRunning;
                              break;
                            case 2:
                              statusvalue = AppLocalizations.of(context)!
                                  .msgStatusApproved;
                              break;
                            case 2:
                              statusvalue = AppLocalizations.of(context)!
                                  .msgStatusVerified;
                              break;
                            default:
                              statusvalue = AppLocalizations.of(context)!
                                  .msgStatusRunning;
                              break;
                          }

                          var date = DateFormat('dd/MM/yyyy').format(orders
                                      .data?[index].inventory?.createdAt !=
                                  null
                              ? DateTime.parse(
                                  "${orders.data?[index].inventory?.createdAt}")
                              : DateTime.now());
                          return InkWell(
                            onTap: () {
                              if (orders.data != null) {
                                Get.to(() => OrderSummary(
                                    indexData: orders.data![index]));
                              }
                            },
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: ColorConstant.maingreen
                                          .withOpacity(0.3))),
                              margin: EdgeInsets.all(10),
                              surfaceTintColor: Colors.white,
                              child: Column(
                                children: [
                                  // IconButton(
                                  //   tooltip: 'Select Printer',
                                  //   icon: Icon(Icons.print),
                                  //   onPressed: () => _showPrinterSelection(
                                  //       context, orders.data![index]),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        /*CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/mung.jpeg'),
                                ),*/
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey,
                                          child: Image.network(
                                            "${IMAGE_BASE_URL}category/${orders.data?[index].inventory?.category?.image}",
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                            errorBuilder: (context, exception,
                                                    stackTrack) =>
                                                Image.asset(
                                              ImageConstant.imgnoimage,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${orders.data?[index].inventory?.category?.category}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(16),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .msgDate,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Adaptive.sp(16),
                                                      ),
                                                    ),
                                                    Text(
                                                      date,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Adaptive.sp(16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                VerticalDivider(
                                                  color: Colors.black,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .msgPriceorder,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Adaptive.sp(16),
                                                      ),
                                                    ),
                                                    Text(
                                                      " ${orders.data?[index].inventory?.price}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Adaptive.sp(16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.maingreen,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(6),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .msgOrderid,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(16),
                                                    color: Colors.white)),
                                            Text(
                                                "${orders.data?[index].orderId}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(16),
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .msgStatus,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(16),
                                                    color: Colors.white)),
                                            Text(statusvalue,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Adaptive.sp(16),
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
              ),
              error: (e, s) => Text(e.toString() + s.toString()),
              loading: () => defaultLoader(),
            ));
  }

  // void _showPrinterSelection(BuildContext context, Datum data) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) {
  //       return AlertDialog(
  //         title: Text('Select Printer'),
  //         content: StreamBuilder<List<dynamic>>(
  //           stream: PrinterHelper.instance.devicesStream,
  //           initialData: PrinterHelper.instance.devices,
  //           builder: (context, snapshot) {
  //             final list = snapshot.data ?? [];
  //             if (list.isEmpty) {
  //               return Padding(
  //                 padding: const EdgeInsets.all(12.0),
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.search_off, color: Colors.grey),
  //                     SizedBox(width: 8),
  //                     Expanded(
  //                       child: Text(
  //                         'No printers found.',
  //                         style: TextStyle(color: Colors.grey[700]),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }

  //             return ConstrainedBox(
  //               constraints: BoxConstraints(maxHeight: 320),
  //               child: ListView.separated(
  //                 shrinkWrap: true,
  //                 itemCount: list.length,
  //                 separatorBuilder: (c, i) => Divider(height: 1),
  //                 itemBuilder: (context, index) {
  //                   final d = list[index];
  //                   final isConnected = PrinterHelper.instance.isConnected &&
  //                       (PrinterHelper.instance.connectedName ==
  //                           (d.name ?? d.address));

  //                   return Container(
  //                     margin: const EdgeInsets.symmetric(
  //                       horizontal: 4,
  //                       vertical: 6,
  //                     ),
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(8),
  //                       border: Border.all(
  //                         color: Theme.of(
  //                           context,
  //                         ).dividerColor.withOpacity(0.6),
  //                       ),
  //                     ),
  //                     child: ListTile(
  //                       contentPadding: EdgeInsets.symmetric(
  //                         horizontal: 12,
  //                         vertical: 8,
  //                       ),
  //                       leading: CircleAvatar(
  //                         backgroundColor: Theme.of(
  //                           context,
  //                         ).primaryColor.withOpacity(0.1),
  //                         child: Icon(
  //                           Icons.print,
  //                           color: Theme.of(context).primaryColor,
  //                         ),
  //                       ),
  //                       title: Text(
  //                         d.name ?? d.address ?? 'Unknown',
  //                         style: TextStyle(fontWeight: FontWeight.w600),
  //                       ),
  //                       subtitle: Text(d.address ?? ''),
  //                       trailing: Row(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           if (isConnected)
  //                             Container(
  //                               margin: EdgeInsets.only(right: 8),
  //                               child: Chip(
  //                                 label: Text(
  //                                   'Connected',
  //                                   style: TextStyle(color: Colors.white),
  //                                 ),
  //                                 backgroundColor: Colors.green.shade700,
  //                               ),
  //                             ),
  //                           TextButton(
  //                             onPressed: () async {
  //                               if (isConnected) {
  //                                 await PrinterHelper.instance.disconnect();
  //                               } else {
  //                                 final ok = await PrinterHelper.instance
  //                                     .connect(d, isBle: false);
  //                                 if (ok) {
  //                                   ScaffoldMessenger.of(context).showSnackBar(
  //                                     SnackBar(
  //                                       content: Text(
  //                                         'Connected to ${d.name ?? d.address}',
  //                                       ),
  //                                     ),
  //                                   );
  //                                 } else {
  //                                   ScaffoldMessenger.of(context).showSnackBar(
  //                                     SnackBar(
  //                                       content: Text('Failed to connect'),
  //                                     ),
  //                                   );
  //                                 }
  //                               }
  //                               setState(() {});
  //                             },
  //                             child: Text(
  //                               isConnected ? 'Disconnect' : 'Connect',
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       onTap: () async {
  //                         // quick tap toggles connect/disconnect
  //                         if (isConnected) {
  //                           await PrinterHelper.instance.disconnect();
  //                         } else {
  //                           final ok = await PrinterHelper.instance.connect(
  //                             d,
  //                             isBle: false,
  //                           );
  //                           if (ok) {
  //                             ScaffoldMessenger.of(context).showSnackBar(
  //                               SnackBar(
  //                                 content: Text(
  //                                   'Connected to ${d.name ?? d.address}',
  //                                 ),
  //                               ),
  //                             );
  //                           }
  //                         }
  //                         setState(() {});
  //                       },
  //                     ),
  //                   );
  //                 },
  //               ),
  //             );
  //           },
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () async {
  //               final ok = await PrinterHelper.instance
  //                   .printTestTicketWithPaper(
  //                       type: PrinterType.bluetooth,
  //                       paperSize: PaperSize.mm58,
  //                       data: data);
  //               if (ok) {
  //                 ScaffoldMessenger.of(
  //                   context,
  //                 ).showSnackBar(SnackBar(content: Text('Print job sent')));
  //               } else {
  //                 ScaffoldMessenger.of(
  //                   context,
  //                 ).showSnackBar(SnackBar(content: Text('Print failed')));
  //               }
  //             },
  //             child: Text('Print'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               await PrinterHelper.instance.startDiscovery(isBle: false);
  //               setState(() {});
  //             },
  //             child: Text('Scan'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               await PrinterHelper.instance.stopDiscovery();
  //               Navigator.of(ctx).pop();
  //             },
  //             child: Text(AppLocalizations.of(context)!.close),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
