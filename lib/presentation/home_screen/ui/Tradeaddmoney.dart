import 'dart:async';
import 'dart:io';

import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/progress_dialog_utils.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/add_money_screen/add_money_summary.dart';
import 'package:apnagodam/presentation/add_money_screen/provider/add_money_repo_impl.dart';
import 'package:apnagodam/presentation/add_money_screen/service/add_money_service.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../widgets/dailogs/error.dart';

class TradeAddMoney extends ConsumerStatefulWidget {
  final bool isAppBarVisible;

  const TradeAddMoney({super.key, required this.isAppBarVisible});

  @override
  ConsumerState<TradeAddMoney> createState() => _TradeAddMoneyState();
}

class _TradeAddMoneyState extends ConsumerState<TradeAddMoney> {
  TextEditingController receptNocontroller = TextEditingController();
  TextEditingController ammountcontroller = TextEditingController();

  List<Option> options = [
    Option('UPI', false),
    Option('RTGS', false),
    Option('Cheque', false),
  ];
  final ImagePicker _picker = ImagePicker();
  var upiValProvider = StateProvider<bool>((ref) => false);
  var rtgsValProvider = StateProvider((ref) => false);
  var checkValProvider = StateProvider((ref) => false);

  var paymentTypeProvider = StateProvider((ref) => '');

  var imageFile = StateProvider<File?>((ref) => null);

  var bankDetailsProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
  var isLoadingBankData = StateProvider<bool>((ref) => true);

  @override
  void initState() {
    super.initState();
    _fetchBankDetails();
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    //   Get.defaultDialog(
    //     title: '',
    //     middleText: '',
    //     titlePadding: Pad(all: 0),
    //     contentPadding: Pad(all: 0),
    //     content:  Consumer(
    //       builder: (context, ref, child) => Container(
    //         color: Colors.white,
    //         padding: Pad(all: 10),
    //         margin: Pad(all: 10),
    //         alignment: Alignment.center,
    //         child: ColumnSuper(
    //           children: [
    //             Icon(
    //               Icons.warning_rounded,
    //               color: Colors.red.shade600,
    //               size: Adaptive.sp(50),
    //             ),
    //             Text(
    //               AppLocalizations.of(context)!.bankChanged,
    //               style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: Adaptive.sp(17)),
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             ref.watch(timeProvider) > 0
    //                 ?
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width,
    //               child: ElevatedButton(
    //                 onPressed: () async {

    //                 },
    //                 style: AppStyle.buttonStyle.copyWith(backgroundColor: MaterialStatePropertyAll(Colors.grey)),
    //                 child: Text('${ref.watch(timeProvider)}',
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.white,
    //                         fontSize: Adaptive.sp(17))),
    //               ),
    //             )
    //                 : SizedBox(
    //               width: MediaQuery.of(context).size.width,
    //               child: ElevatedButton(
    //                 onPressed: () async {
    //                   Navigator.of(context, rootNavigator: true)
    //                       .pop();
    //                 },
    //                 style: AppStyle.buttonStyle,
    //                 child: Text(
    //                   "Ok",
    //                   style: AppStyle.lblmoneybtn,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       )),barrierDismissible: false,backgroundColor: Colors.white);
    // });
  }

  Future<void> _fetchBankDetails() async {
    try {
      final response = await ref.read(dioProvider).post(
          'user_api/get_user_bank_details',
          queryParameters: {"type": "2"});

      if (response.data != null && response.data['status'] == '1') {
        ref.read(bankDetailsProvider.notifier).state = response.data;
      }
    } catch (e) {
      print('Error fetching bank details: $e');
    } finally {
      ref.read(isLoadingBankData.notifier).state = false;
    }
  }

  int _virtualAccountFlag() {
    final value =
        ref.watch(bankDetailsProvider)?['bankArray']?['virtual_account'];
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? -1;
  }

  Future<void> _pickReceiptImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ref.watch(imageFile.notifier).state = File(pickedFile.path);
    }
  }

  Future<void> _submitAddPayment() async {
    if (ref.watch(paymentTypeProvider) == "") {
      Get.rawSnackbar(
        message: AppLocalizations.of(context)!.messagePayment,
        duration: const Duration(seconds: 2),
        backgroundColor: ColorConstant.red500,
      );
      return;
    }

    if (receptNocontroller.text.isEmpty) {
      Get.rawSnackbar(
        message: AppLocalizations.of(context)!.messageRcptno,
        duration: const Duration(seconds: 2),
        backgroundColor: ColorConstant.red500,
      );
      return;
    }

    if (ammountcontroller.text.isEmpty) {
      Get.rawSnackbar(
        message: AppLocalizations.of(context)!.enterAmount,
        duration: const Duration(seconds: 2),
        backgroundColor: ColorConstant.red500,
      );
      return;
    }

    if (ref.watch(imageFile) == null) {
      Get.rawSnackbar(
        message: AppLocalizations.of(context)!.chooseBankslip,
        duration: const Duration(seconds: 2),
        backgroundColor: ColorConstant.red500,
      );
      return;
    }

    ProgressDialogUtils.showProgressDialog();
    ref
        .watch(addMoneyProvider(
      paymenttype: ref.watch(paymentTypeProvider),
      receptno: receptNocontroller.text,
      amount: ammountcontroller.text,
      amountAccType: '2',
      files: ref.watch(imageFile),
    ).future)
        .then((value) {
      ProgressDialogUtils.hideProgressDialog();
      if (value['status'] == "1") {
        Get.to(AddSummaryScreen(type: '1'));
      } else {
        errorBottomSheet(
          context,
          value['message']?.toString() ?? 'Failed to add payment',
        );
      }
    }).onError((e, s) {
      ProgressDialogUtils.hideProgressDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bgcolor,
      appBar: widget.isAppBarVisible
          ? AppBar(
              backgroundColor: ColorConstant.maingreen,
              title: Text(
                AppLocalizations.of(context)!.msgAddmoney,
                style: AppStyle.lblAppbar,
              ),
              centerTitle: true,
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: SingleChildScrollView(
          child: ref.watch(settingsProvider).when(
                data: (data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 7,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(
                                context,
                              )!
                                  .msgAccountDetail,
                              style: TextStyle(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.maingreen,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .beneficiaryName,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    ref.watch(bankDetailsProvider)?['bankArray']
                                                ?['virtubankData']
                                            ?['BeneficiaryName'] ??
                                        "NA",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .msgAccontNo,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    ref.watch(bankDetailsProvider)?['bankArray']
                                                ?['virtubankData']
                                            ?['AccountNumber'] ??
                                        "NA",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .msgBankName,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    ref.watch(bankDetailsProvider)?['bankArray']
                                            ?['virtubankData']?['BankName'] ??
                                        "NA",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    softWrap: false,
                                    maxLines: 2,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.msgIfsc,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                //data.settings?.ifsc ??
                                Expanded(
                                  child: Text(
                                    ref.watch(bankDetailsProvider)?['bankArray']
                                            ?['virtubankData']?['IFSCCode'] ??
                                        "NA",
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.upi,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    ref.watch(bankDetailsProvider)?['bankArray']
                                            ?['virtubankData']?['UPI'] ??
                                        "NA",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.branchAddress,
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    ref.watch(bankDetailsProvider)?['bankArray']
                                                ?['virtubankData']
                                            ?['BranchAddress'] ??
                                        "NA",
                                    style: TextStyle(
                                      fontSize: Adaptive.sp(16),
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.normal,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            // Align(alignment: Alignment.center,child: Container(
                            //   margin: Pad(all: 10),
                            //   padding: Pad(all: 10),
                            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all()),
                            //   height: 200,
                            //   width: 200,
                            //   child: Center(
                            //       child: UPIPaymentQRCode(
                            //         embeddedImagePath: 'assets/images/user_logo.png',
                            //         upiDetails: UPIDetails(
                            //           upiID:
                            //           "swlplt${ref.watch(sharedUtilityProvider).getUser()?.phone}@hdfcbank",
                            //           payeeName: "",
                            //         ),
                            //         upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.high,
                            //       )),
                            // ),),
                            // SizedBox(
                            //   height: 10,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    if (_virtualAccountFlag() == 0) ...[
                      SizedBox(height: 18),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.msgAddmoney,
                                style: TextStyle(
                                  fontSize: Adaptive.sp(17),
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.maingreen,
                                ),
                              ),
                              SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  value: ref.watch(paymentTypeProvider).isEmpty
                                      ? null
                                      : ref.watch(paymentTypeProvider),
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .msgPaymentMode,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: ColorConstant.maingreen
                                            .withOpacity(0.35),
                                      ),
                                    ),
                                  ),
                                  hint: Text(
                                      AppLocalizations.of(context)!.slectType),
                                  items: options
                                      .map(
                                        (option) => DropdownMenuItem<String>(
                                          value: option.label,
                                          child: Text(option.label),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    ref
                                        .read(paymentTypeProvider.notifier)
                                        .state = value ?? '';
                                  },
                                ),
                              ),
                              SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: receptNocontroller,
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .msgChequeno,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: ColorConstant.maingreen
                                            .withOpacity(0.35),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: ammountcontroller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .msgAppliedAmount,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: ColorConstant.maingreen
                                            .withOpacity(0.35),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: _pickReceiptImage,
                                  icon: Icon(
                                    Icons.upload_file,
                                    color: ColorConstant.maingreen,
                                  ),
                                  label: Text(
                                    ref.watch(imageFile) == null
                                        ? AppLocalizations.of(context)!
                                            .chooseBankslip
                                        : ref
                                            .watch(imageFile)!
                                            .path
                                            .split('/')
                                            .last,
                                    style: TextStyle(
                                      color: ColorConstant.maingreen,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(52),
                                    side: BorderSide(
                                      color: ColorConstant.maingreen
                                          .withOpacity(0.6),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _submitAddPayment,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.maingreen,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.msgAddmoney,
                                    style: AppStyle.lblmoneybtn,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    // SizedBox(height: 18),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   elevation: 4,
                    //   color: Colors.white,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           "Select Payment Method",
                    //           style: TextStyle(
                    //             fontSize: Adaptive.sp(16),
                    //             fontWeight: FontWeight.w600,
                    //             color: Colors.black87,
                    //           ),
                    //         ),
                    //         SizedBox(height: 10),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: options.map((option) {
                    //             final isSelected = ref.watch(paymentTypeProvider) == option.label;
                    //             return ChoiceChip(
                    //               label: Text(option.label),
                    //               selected: isSelected,
                    //               selectedColor: ColorConstant.maingreen,
                    //               backgroundColor: Colors.grey[200],
                    //               labelStyle: TextStyle(
                    //                 color: isSelected ? Colors.white : Colors.black,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //               onSelected: (selected) {
                    //                 ref.read(paymentTypeProvider.notifier).state = option.label;
                    //               },
                    //             );
                    //           }).toList(),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 18),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   elevation: 4,
                    //   color: Colors.white,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           "Enter Amount & Receipt No.",
                    //           style: TextStyle(
                    //             fontSize: Adaptive.sp(16),
                    //             fontWeight: FontWeight.w600,
                    //             color: Colors.black87,
                    //           ),
                    //         ),
                    //         SizedBox(height: 10),
                    //         CommonTextField(
                    //           controller: ammountcontroller,
                    //           label: "Amount",
                    //           inputType: TextInputType.number,
                    //           fillColor: Colors.grey[100],
                    //         ),
                    //         SizedBox(height: 10),
                    //         CommonTextField(
                    //           controller: receptNocontroller,
                    //           label: "Receipt No.",
                    //           fillColor: Colors.grey[100],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 18),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   elevation: 4,
                    //   color: Colors.white,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           "Upload Receipt",
                    //           style: TextStyle(
                    //             fontSize: Adaptive.sp(16),
                    //             fontWeight: FontWeight.w600,
                    //             color: Colors.black87,
                    //           ),
                    //         ),
                    //         SizedBox(height: 10),
                    //         Center(
                    //           child: InkWell(
                    //             onTap: () async {
                    //               final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                    //               if (pickedFile != null) {
                    //                 ref.read(imageFile.notifier).state = File(pickedFile.path);
                    //               }
                    //             },
                    //             child: Container(
                    //               height: 120,
                    //               width: 120,
                    //               decoration: BoxDecoration(
                    //                 color: Colors.grey[100],
                    //                 borderRadius: BorderRadius.circular(12),
                    //                 border: Border.all(color: Colors.grey.shade300),
                    //               ),
                    //               child: ref.watch(imageFile) == null
                    //                   ? Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                    //                   : ClipRRect(
                    //                       borderRadius: BorderRadius.circular(12),
                    //                       child: Image.file(ref.watch(imageFile)!, fit: BoxFit.cover),
                    //                     ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 24),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 52,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       if (ref.watch(paymentTypeProvider) == "") {
                    //         Get.rawSnackbar(
                    //             message: AppLocalizations.of(context)!.messagePayment,
                    //             duration: const Duration(seconds: 2),
                    //             backgroundColor: ColorConstant.red500);
                    //       } else if (receptNocontroller.text.isEmpty) {
                    //         Get.rawSnackbar(
                    //             message: AppLocalizations.of(context)!.messageRcptno,
                    //             duration: const Duration(seconds: 2),
                    //             backgroundColor: ColorConstant.red500);
                    //       } else if (ref.watch(imageFile) == null) {
                    //         Get.rawSnackbar(
                    //             message: AppLocalizations.of(context)!.chooseBankslip,
                    //             duration: const Duration(seconds: 2),
                    //             backgroundColor: ColorConstant.red500);
                    //       } else if (ammountcontroller.text.isEmpty) {
                    //         Get.rawSnackbar(
                    //             message: AppLocalizations.of(context)!.enterAmount,
                    //             duration: const Duration(seconds: 2),
                    //             backgroundColor: ColorConstant.red500);
                    //       } else {
                    //         ProgressDialogUtils.showProgressDialog();
                    //         ref
                    //             .watch(addMoneyProvider(
                    //                     paymenttype: ref.watch(paymentTypeProvider),
                    //                     receptno: receptNocontroller.text,
                    //                     amount: ammountcontroller.text,
                    //                     files: ref.watch(imageFile))
                    //                 .future)
                    //             .then((value) {
                    //           ProgressDialogUtils.hideProgressDialog();
                    //           if (value['status'] == "1") {
                    //             Get.to(AddSummaryScreen());
                    //           }
                    //         }).onError((e, s) {});
                    //       }
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: ColorConstant.maingreen,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(14),
                    //       ),
                    //       elevation: 3,
                    //     ),
                    //     child: Text(
                    //       "Submit",
                    //       style: AppStyle.lblmoneybtn.copyWith(fontSize: Adaptive.sp(17)),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 18),
                  ],
                ),
                error: (e, s) => Container(),
                loading: () => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Skeletonizer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          height: 120,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        SizedBox(height: 18),
                        Container(
                          height: 60,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        SizedBox(height: 18),
                        Container(
                          height: 100,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        SizedBox(height: 18),
                        Container(
                          height: 100,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          height: 52,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        SizedBox(height: 18),
                      ],
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}

class Option {
  final String label;
  bool isSelected;

  Option(this.label, this.isSelected);
}
