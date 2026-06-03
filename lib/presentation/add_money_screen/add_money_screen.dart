import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/add_money_screen/service/add_money_service.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class AddMoney extends ConsumerStatefulWidget {
  const AddMoney({super.key, required this.isAppBarVisible});

  final bool isAppBarVisible;

  @override
  ConsumerState<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends ConsumerState<AddMoney> {
  var bankDetailsProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
  var isLoadingBankData = StateProvider<bool>((ref) => true);

  @override
  void initState() {
    super.initState();
    _fetchBankDetails();
  }

  Future<void> _fetchBankDetails() async {
    try {
      final response = await ref.read(dioProvider).post(
          'user_api/get_user_bank_details',
          queryParameters: {"type": "1"});

      if (response.data != null && response.data['status'] == '1') {
        ref.read(bankDetailsProvider.notifier).state = response.data;
      }
    } catch (e) {
      print('Error fetching bank details: $e');
    } finally {
      ref.read(isLoadingBankData.notifier).state = false;
    }
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
                      ],
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: Adaptive.sp(16),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: Adaptive.sp(16),
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class Option {
  final String label;
  bool isSelected;

  Option(this.label, this.isSelected);
}
