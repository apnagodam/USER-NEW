import 'dart:io';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/GRNRequestListScreen.dart';
import 'package:apnagodam/presentation/sbt/service/SbtService.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:apnagodam/widgets/dailogs/customAlertDialog.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GuarantorScreen extends ConsumerStatefulWidget {
  const GuarantorScreen({super.key});

  @override
  _GuarantorScreenState createState() => _GuarantorScreenState();
}

class _GuarantorScreenState extends ConsumerState<GuarantorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  // ref.watch(grnRequestListProvider).when(
  //       data: (data) => ListView.builder(
  //             padding: Pad(all: 10),
  //             itemCount: (data['data'] as List<dynamic>?)?.length ?? 0,
  //             shrinkWrap: true,
  //             physics: NeverScrollableScrollPhysics(),
  //             itemBuilder: (context, index) => Card(
  //               color: Colors.white,
  //               elevation: 8,
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                   side: BorderSide(color: ColorConstant.maingreen)),
  //               child: Padding(
  //                 padding: Pad(all: 10),
  //                 child: ColumnSuper(children: [
  //                   Center(
  //                       child: Text(
  //                     "${data['data']?[index]['order_id'] ?? 0}",
  //                     style: TextStyle(
  //                         fontSize: Adaptive.sp(16),
  //                         fontWeight: FontWeight.bold),
  //                   )),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   // Row(
  //                   //   children: [
  //                   //     Expanded(
  //                   //         child: Text(
  //                   //       "Type",
  //                   //       style: TextStyle(
  //                   //           fontSize: Adaptive.sp(16),
  //                   //           fontWeight: FontWeight.w500),
  //                   //     )),
  //                   //     Text(
  //                   //       "${ref.watch(sellOrdersListProvider)?[index].type ?? 0}",
  //                   //       style: TextStyle(
  //                   //           fontSize: Adaptive.sp(16),
  //                   //           fontWeight: FontWeight.w500),
  //                   //     )
  //                   //   ],
  //                   // ),
  //                   //  SizedBox(
  //                   //   height: 10,
  //                   // ),
  //                   // Row(
  //                   //   children: [
  //                   //     Expanded(
  //                   //         child: Text(
  //                   //       "Buyer Name",
  //                   //       style: TextStyle(
  //                   //           fontSize: Adaptive.sp(16),
  //                   //           fontWeight: FontWeight.w500),
  //                   //     )),
  //                   //     Text(
  //                   //       "${data.data?[index]. ?? ''}",
  //                   //       style: TextStyle(
  //                   //           fontSize: Adaptive.sp(16),
  //                   //           fontWeight: FontWeight.w500),
  //                   //     )
  //                   //   ],
  //                   // ),
  //                   //  SizedBox(
  //                   //   height: 10,
  //                   // ),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                           child: Text(
  //                         "Sales Type",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )),
  //                       Text(
  //                         "${data['data']?[index]['sales_status'] ?? "--"}",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                           child: Text(
  //                         "Request Date",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )),
  //                       Text(
  //                         "${data['data']?[index]['request_date'] ?? 0}",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                           child: Text(
  //                         "Quantity",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )),
  //                       Text(
  //                         "${data['data']?[index]['weight'] ?? 0} Qtl.",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                           child: Text(
  //                         "Vehicle Number",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )),
  //                       Text(
  //                         "${data['data']?[index]['vehicle_number'] ?? "--"} ",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                           child: Text(
  //                         "Driver Number",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )),
  //                       Text(
  //                         "${data['data']?[index]['driver_number']}",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                           child: Text(
  //                         "Driver Number",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )),
  //                       Text(
  //                         "${data['data']?[index]['driver_number']}",
  //                         style: TextStyle(
  //                             fontSize: Adaptive.sp(16),
  //                             fontWeight: FontWeight.w500),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   if (data['data']?[index]['check_kanta_parchi'] != null)
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                             child: Text(
  //                           "Kanta Parchi Image",
  //                           style: TextStyle(
  //                               fontSize: Adaptive.sp(16),
  //                               fontWeight: FontWeight.w500),
  //                         )),
  //                         InstaImageViewer(
  //                           imageUrl: data['data']?[index]['kanta_parchi'].toString(),
  //                           child: Icon(Icons.remove_red_eye,
  //                               color: ColorConstant.maingreen),
  //                         )
  //                       ],
  //                     ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   if (data['data']?[index]['check_bilty'] != null)
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                             child: Text(
  //                           "Bilty Image",
  //                           style: TextStyle(
  //                               fontSize: Adaptive.sp(16),
  //                               fontWeight: FontWeight.w500),
  //                         )),
  //                         InstaImageViewer(
  //                           imageUrl: data['data']?[index]['bilty'].toString(),
  //                           child: Icon(Icons.remove_red_eye,
  //                               color: ColorConstant.maingreen),
  //                         )
  //                       ],
  //                     ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   if (data['data']?[index]['check_grn'] != null)
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                             child: Text(
  //                           "Grn Image",
  //                           style: TextStyle(
  //                               fontSize: Adaptive.sp(16),
  //                               fontWeight: FontWeight.w500),
  //                         )),
  //                         InstaImageViewer(
  //                           imageUrl: data['data']?[index]['grn'].toString(),
  //                           child: Icon(Icons.remove_red_eye,
  //                               color: ColorConstant.maingreen),
  //                         )
  //                       ],
  //                     ),

  //                   if (data['data']?[index]['check_draft_invoice'] != null)
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                             child: Text(
  //                           "Draft Invoice Image",
  //                           style: TextStyle(
  //                               fontSize: Adaptive.sp(16),
  //                               fontWeight: FontWeight.w500),
  //                         )),
  //                         InstaImageViewer(
  //                           imageUrl: data['data']?[index]
  //                               ['draft_invoice_copy'].toString(),
  //                           child: Icon(Icons.remove_red_eye,
  //                               color: ColorConstant.maingreen),
  //                         )
  //                       ],
  //                     ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   if (data['data']?[index]['check_invoice_copy'] != null)
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                             child: Text(
  //                           "Invoice Copy Image",
  //                           style: TextStyle(
  //                               fontSize: Adaptive.sp(16),
  //                               fontWeight: FontWeight.w500),
  //                         )),
  //                         InstaImageViewer(
  //                           imageUrl: data['data']?[index]['invoice_copy'].toString(),
  //                           child: Icon(Icons.remove_red_eye,
  //                               color: ColorConstant.maingreen),
  //                         )
  //                       ],
  //                     ),
  //                   if (data['data']?[index]['check_receiving_kanta_parchi'] !=
  //                       null)
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                             child: Text(
  //                           "Receiving Kanta Image",
  //                           style: TextStyle(
  //                               fontSize: Adaptive.sp(16),
  //                               fontWeight: FontWeight.w500),
  //                         )),
  //                         InstaImageViewer(
  //                           imageUrl: data['data']?[index]
  //                               ['recieving_kanta_parchi'].toString(),
  //                           child: Icon(
  //                             Icons.remove_red_eye,
  //                             color: ColorConstant.maingreen,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   if (data['data']?[index]['check_receiving_kanta_parchi'] !=
  //                       null)
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                             child: Text(
  //                           "Receiving Kanta Image",
  //                           style: TextStyle(
  //                               fontSize: Adaptive.sp(16),
  //                               fontWeight: FontWeight.w500),
  //                         )),
  //                         InstaImageViewer(
  //                           imageUrl: data['data']?[index]
  //                               ['recieving_kanta_parchi'].toString(),
  //                           child: Icon(
  //                             Icons.remove_red_eye,
  //                             color: ColorConstant.maingreen,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),

  //                   SizedBox(height: 10),
  //                   Center(
  //                       child: Text(
  //                     data['data']?[index]['check_grn'] != null &&
  //                             data?['data'][index]['status'].toString() == "1"
  //                         ? "Verification Pending"
  //                         : data['data']?[index]['check_grn'] != null &&
  //                                 data['data']?[index]['status'].toString() ==
  //                                     "2"
  //                             ? "Approval Pending"
  //                             : data['data']?[index]['check_grn'] != null &&
  //                                     data['data']?[index]['status']
  //                                             .toString() ==
  //                                         "3"
  //                                 ? "Done"
  //                                 : "",
  //                     style: TextStyle(
  //                         fontSize: Adaptive.sp(16),
  //                         fontWeight: FontWeight.bold),
  //                   )),
  //                 ]),
  //               ),
  //             ),
  //           ),
  //       error: (e, s) => Container(),
  //       loading: () => Container())
}
