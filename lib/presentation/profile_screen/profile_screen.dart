import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/home_screen/kyc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: ColorConstant.maingreen,
        //   title: const Text('My Profile'),
        //   titleSpacing: 0,
        //   titleTextStyle: AppStyle.lblAppbar,
        // ),
        backgroundColor: ColorConstant.bgcolor,
        body: KYC(
          kyctag: '',
          isAppbarVisible: true,
        ));
  }

  // ref.watch(userDetailsProvider).when(
  //           data: (data) {
  //             return SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Column(
  //                     children: [
  //                       Container(
  //                         clipBehavior: Clip.antiAlias,
  //                         height: 120,
  //                         width: 120,
  //                         decoration:
  //                             const BoxDecoration(shape: BoxShape.circle),
  //                         child: CachedNetworkImage(
  //                           fit: BoxFit.fill,
  //                           imageUrl:
  //                               "${IMAGE_BASE_URL_FRONTEND}${data.userDetails?.profileImage}",
  //                           errorWidget: (context, s, o) => Image.asset(
  //                             ImageConstant.no_photo,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       RowSuper(
  //                         fitHorizontally: true,
  //                         children: [
  //                           // CircleAvatar(
  //                           //   radius: 40,
  //                           //   backgroundImage:
  //                           //   NetworkImage(
  //                           //       "${IMAGE_BASE_URL_FRONTEND}${cont.userDetailModal!.userDetails!.profileImage}",
  //                           //       // errorBuilder: (context, exception, stackTrack) => Image.asset(ImageConstant.no_photo,fit: BoxFit.fitWidth,)
  //                           //   ),
  //                           //   backgroundColor: Colors.grey[200],
  //                           // ),

  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               Text(data.userDetails?.fname ?? "",
  //                                   softWrap: true,
  //                                   maxLines: 2,
  //                                   style: TextStyle(
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: Adaptive.sp(17))),
  //                               const SizedBox(
  //                                 height: 4,
  //                               ),
  //                               Text(
  //                                 data.userDetails?.phone ?? "",
  //                                 style: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: Adaptive.sp(16)),
  //                               )
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 16, right: 16),
  //                     child: ElevarmTextInputField(
  //                       label: AppLocalizations.of(context)!.pan,
  //                       textInputAction: TextInputAction.next,
  //                       keyboardType: TextInputType.number,
  //                       enabled: false,
  //                       hintText: data.userDetails?.pancardNo.toString(),
  //                       isRequired: false,
  //                       readOnly: true,
  //                       suffixIconAssetName: Icons.perm_identity_sharp,
  //                       onTapSuffix: null,
  //                       errorText: null,
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 16, right: 16),
  //                     child: ElevarmTextInputField(
  //                       label: AppLocalizations.of(context)!.paccountnoan2,
  //                       textInputAction: TextInputAction.next,
  //                       keyboardType: TextInputType.number,
  //                       enabled: false,
  //                       hintText: data.userDetails?.bankAccNo.toString(),
  //                       isRequired: false,
  //                       readOnly: true,
  //                       suffixIconAssetName: Icons.money,
  //                       onTapSuffix: null,
  //                       errorText: null,
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 16, right: 16),
  //                     child: ElevarmTextInputField(
  //                       label: AppLocalizations.of(context)!.aadharno,
  //                       textInputAction: TextInputAction.next,
  //                       keyboardType: TextInputType.number,
  //                       enabled: false,
  //                       hintText: data.userDetails?.aadharNo.toString(),
  //                       isRequired: false,
  //                       readOnly: true,
  //                       suffixIconAssetName: Icons.perm_identity_sharp,
  //                       onTapSuffix: null,
  //                       errorText: null,
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 15,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 16, right: 16),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           AppLocalizations.of(context)!.chequeimg,
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: Adaptive.sp(16)),
  //                         ),
  //                         const SizedBox(
  //                           height: 4,
  //                         ),
  //                         Container(
  //                           width: MediaQuery.of(context).size.width * 1,
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(08),
  //                               border:
  //                                   Border.all(color: Colors.grey, width: 1)),
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(08),
  //                             child: CachedNetworkImage(
  //                                 fit: BoxFit.fill,
  //                                 imageUrl:
  //                                     "${IMAGE_BASE_URL_FRONTEND}${data.userDetails?.chequeImage}",
  //                                 errorWidget: (context, s, o) => Image.asset(
  //                                       ImageConstant.no_photo,
  //                                       fit: BoxFit.cover,
  //                                     )),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Padding(
  //                       padding: const EdgeInsets.only(left: 16, right: 16),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             AppLocalizations.of(context)!.panImg,
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: Adaptive.sp(16)),
  //                           ),
  //                           const SizedBox(
  //                             height: 4,
  //                           ),
  //                           Container(
  //                             width: MediaQuery.of(context).size.width * 1,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(08),
  //                                 border:
  //                                     Border.all(color: Colors.grey, width: 1)),
  //                             child: ClipRRect(
  //                               borderRadius: BorderRadius.circular(08),
  //                               child: CachedNetworkImage(
  //                                   fit: BoxFit.fill,
  //                                   imageUrl:
  //                                       "${IMAGE_BASE_URL_FRONTEND}${data.userDetails?.pancardImage}",
  //                                   errorWidget: (context, s, o) => Image.asset(
  //                                         ImageConstant.no_photo,
  //                                         fit: BoxFit.cover,
  //                                       )),
  //                             ),
  //                           )
  //                         ],
  //                       )),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Padding(
  //                       padding: const EdgeInsets.only(left: 16, right: 16),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             AppLocalizations.of(context)!.gstImg,
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: Adaptive.sp(16)),
  //                           ),
  //                           const SizedBox(
  //                             height: 4,
  //                           ),
  //                           Container(
  //                             width: MediaQuery.of(context).size.width * 1,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(08),
  //                                 border:
  //                                     Border.all(color: Colors.grey, width: 1)),
  //                             child: ClipRRect(
  //                                 borderRadius: BorderRadius.circular(08),
  //                                 child: CachedNetworkImage(
  //                                     fit: BoxFit.fill,
  //                                     imageUrl:
  //                                         "${IMAGE_BASE_URL_FRONTEND}${data.userDetails?.gstImage}",
  //                                     errorWidget: (context, s, o) =>
  //                                         Image.asset(
  //                                           ImageConstant.no_photo,
  //                                           fit: BoxFit.cover,
  //                                         ))),
  //                           )
  //                         ],
  //                       )),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Padding(
  //                       padding: const EdgeInsets.only(left: 16, right: 16),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             AppLocalizations.of(context)!.aadarimg,
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: Adaptive.sp(16)),
  //                           ),
  //                           const SizedBox(
  //                             height: 4,
  //                           ),
  //                           Container(
  //                             width: MediaQuery.of(context).size.width * 1,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(08),
  //                                 border:
  //                                     Border.all(color: Colors.grey, width: 1)),
  //                             child: ClipRRect(
  //                                 borderRadius: BorderRadius.circular(08),
  //                                 child: CachedNetworkImage(
  //                                     fit: BoxFit.fill,
  //                                     imageUrl:
  //                                         "${IMAGE_BASE_URL_FRONTEND}${data.userDetails?.aadharImage}",
  //                                     errorWidget: (context, s, o) =>
  //                                         Image.asset(
  //                                           ImageConstant.no_photo,
  //                                           fit: BoxFit.cover,
  //                                         ))),
  //                           )
  //                         ],
  //                       )),
  //                 ],
  //               ),
  //             );
  //           },
  //           error: (e, s) => noStockData(),
  //           loading: () => defaultLoader())
}
