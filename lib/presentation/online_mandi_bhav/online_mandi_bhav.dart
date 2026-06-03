import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/theme/app_style.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class OnlineMandiBhav extends ConsumerStatefulWidget {
  const OnlineMandiBhav({super.key});

  @override
  ConsumerState<OnlineMandiBhav> createState() => _OnlineMandiBhavState();
}

class _OnlineMandiBhavState extends ConsumerState<OnlineMandiBhav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgcolor,
      appBar: AppBar(
        backgroundColor: ColorConstant.maingreen,
        title: Text(
          AppLocalizations.of(context)!.msgOnlineMandiBhav,
          style: AppStyle.lblAppbar,
        ),
        centerTitle: true,
      ),
      // body: ref.watch(mandiBhavProvider).when(
      //     data: (data) => GridView.builder(
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2),
      //       scrollDirection: Axis.vertical,
      //       physics: ScrollPhysics(),
      //       shrinkWrap: true,
      //       itemCount: data.emandiData?.length,
      //       itemBuilder: (context, index) => Container(
      //         margin: const EdgeInsets.all(10),
      //         decoration: const BoxDecoration(
      //             borderRadius:
      //             BorderRadius.all(Radius.circular(10)),
      //             color: Colors.white,
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Color(0xffd8d7d5),
      //                   blurRadius: 5,
      //                   spreadRadius: 1,
      //                   offset: Offset(1, 0.5))
      //             ]),
      //         child: Column(
      //           children: [
      //             Expanded(
      //                 child: CachedNetworkImage(
      //                     imageUrl:
      //                     "${IMAGE_BASE_URL}category/${data.emandiData?[index].commodityImg.toString()}")),
      //             const SizedBox(
      //               height: 8.0,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(
      //                   left: 10.0, bottom: 5),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   FittedBox(
      //                     child: Text(
      //                       "${data.emandiData?[index].commodity}",
      //                       style: AppStyle
      //                           .lblonlinemandibiglistdetail,
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(
      //                         top: 4.0, bottom: 4.0),
      //                     child: Row(
      //                       mainAxisAlignment:
      //                       MainAxisAlignment.start,
      //                       crossAxisAlignment:
      //                       CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                           AppLocalizations.of(context)!.msgMandi,
      //                           style: AppStyle.lbldateanddetail,
      //                         ),
      //                         Expanded(
      //                           child: Text(
      //                             "${data.emandiData?[index].mandiName}",
      //                             style: AppStyle.lbldateanddetail,
      //                             maxLines: 2,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   Row(
      //                     mainAxisAlignment:
      //                     MainAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         AppLocalizations.of(context)!.msgPrice,
      //                         style: AppStyle.lbldateanddetail,
      //                       ),
      //                       Text(
      //                         "${data.emandiData?[index].price}",
      //                         style: AppStyle.lbldateanddetail,
      //                       ),
      //                     ],
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(top: 4.0),
      //                     child: Row(
      //                       mainAxisAlignment:
      //                       MainAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                           AppLocalizations.of(context)!.msgDate,
      //                           style: AppStyle.lbldateandtime,
      //                         ),
      //                         Text(
      //                           "${data.emandiData?[index].createdAt}"
      //                               .toString(),
      //                           style: AppStyle.lbldateandtime,
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //     error: (e, s) => Container(),
      //     loading: () => defaultLoader())
    );
  }
}
