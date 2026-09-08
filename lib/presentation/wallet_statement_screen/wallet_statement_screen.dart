import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/Registration/IndividualRegistration.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/models/wallet_transactions_list_model.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/service/wallet_service.dart';
import 'package:apnagodam/widgets/invoice.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/utils/color_constant.dart';
import '../../widgets/dailogs/error.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class WalletStatement extends ConsumerStatefulWidget {
  const WalletStatement({super.key});

  @override
  ConsumerState<WalletStatement> createState() => _WalletStatementState();
}

class _WalletStatementState extends ConsumerState<WalletStatement> {
  late StateProvider<String> searchQueryProvider;

  @override
  void initState() {
    super.initState();
    searchQueryProvider = StateProvider<String>((ref) => "");
  }

  var dataList = StateProvider<List<Datum>>((ref) => []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.filter3,
                  style: AppStyle.lbldrawerbtn.copyWith(
                    fontSize: Adaptive.sp(17),
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.maingreen,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ChoiceChip(
                      checkmarkColor: Colors.white,
                      label: Text(AppLocalizations.of(context)!.k1Month2),
                      selected:
                          ref.watch(selectedFilterProvider) ==
                          AppLocalizations.of(context)!.k1Month2,
                      onSelected: (isSelected) {
                        ref.read(selectedFilterProvider.notifier).state =
                            AppLocalizations.of(context)!.k1Month2;
                        ref.read(fromDateProvider.notifier).state = DateFormat(
                          'dd-MM-yyyy',
                        ).format(DateTime.now().subtract(Duration(days: 30)));
                        ref.read(toDateProvider.notifier).state = DateFormat(
                          'dd-MM-yyyy',
                        ).format(DateTime.now());
                        ref.invalidate(getWalletListProvider);
                        setState(() {});
                      },
                      selectedColor: ColorConstant.maingreen,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color:
                            ref.watch(selectedFilterProvider) ==
                                    AppLocalizations.of(context)!.k1Month2
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    ChoiceChip(
                      checkmarkColor: Colors.white,
                      label: Text(AppLocalizations.of(context)!.k3Months2),
                      selected:
                          ref.watch(selectedFilterProvider) ==
                          AppLocalizations.of(context)!.k3Months2,
                      onSelected: (isSelected) {
                        ref.read(selectedFilterProvider.notifier).state =
                            AppLocalizations.of(context)!.k3Months2;
                        ref.read(fromDateProvider.notifier).state = DateFormat(
                          'dd-MM-yyyy',
                        ).format(DateTime.now().subtract(Duration(days: 90)));
                        ref.read(toDateProvider.notifier).state = DateFormat(
                          'dd-MM-yyyy',
                        ).format(DateTime.now());
                        ref.invalidate(getWalletListProvider);
                        setState(() {});
                      },
                      selectedColor: ColorConstant.maingreen,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color:
                            ref.watch(selectedFilterProvider) ==
                                    AppLocalizations.of(context)!.k3Months2
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    ChoiceChip(
                      checkmarkColor: Colors.white,
                      label: Text(AppLocalizations.of(context)!.k6Months2),
                      selected:
                          ref.watch(selectedFilterProvider) ==
                          AppLocalizations.of(context)!.k6Months2,
                      onSelected: (isSelected) {
                        ref.read(selectedFilterProvider.notifier).state =
                            AppLocalizations.of(context)!.k6Months2;
                        ref.read(fromDateProvider.notifier).state = DateFormat(
                          'dd-MM-yyyy',
                        ).format(DateTime.now().subtract(Duration(days: 180)));
                        ref.read(toDateProvider.notifier).state = DateFormat(
                          'dd-MM-yyyy',
                        ).format(DateTime.now());
                        ref.invalidate(getWalletListProvider);
                        setState(() {});
                      },
                      selectedColor: ColorConstant.maingreen,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color:
                            ref.watch(selectedFilterProvider) ==
                                    AppLocalizations.of(context)!.k6Months2
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    ChoiceChip(
                      checkmarkColor: Colors.white,
                      label: Text(AppLocalizations.of(context)!.customDate3),
                      selected: ref.read(selectedFilterProvider) == 'Custom',
                      onSelected: (isSelected) async {
                        DateTime? fromDate;
                        DateTime? toDate;
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            DateTime tempFromDate = DateTime.now();
                            DateTime tempToDate = DateTime.now();
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                    left: 16,
                                    right: 16,
                                    top: 24,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.selectDateRange,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Adaptive.sp(17),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                DateTime? picked =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate: tempFromDate,
                                                      firstDate: DateTime(2018),
                                                      lastDate: DateTime.now(),
                                                    );
                                                if (picked != null) {
                                                  setState(
                                                    () => tempFromDate = picked,
                                                  );
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 12,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorConstant.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${AppLocalizations.of(context)!.msgFromDate} ${DateFormat('dd-MM-yyyy').format(tempFromDate)}",
                                                    style: TextStyle(
                                                      fontSize: Adaptive.sp(16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                DateTime? picked =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate: tempToDate,
                                                      firstDate: tempFromDate,
                                                      lastDate: DateTime.now(),
                                                    );
                                                if (picked != null) {
                                                  setState(
                                                    () => tempToDate = picked,
                                                  );
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 12,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorConstant.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${AppLocalizations.of(context)!.msgToDate} ${DateFormat('dd-MM-yyyy').format(tempToDate)}",
                                                    style: TextStyle(
                                                      fontSize: Adaptive.sp(16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 24),
                                      ElevatedButton(
                                        onPressed: () {
                                          fromDate = tempFromDate;
                                          toDate = tempToDate;
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstant.maingreen,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.submit,
                                          style: AppStyle.lblviewbtnwithdraw
                                              .copyWith(
                                                fontSize: Adaptive.sp(14),
                                              ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                        if (fromDate != null && toDate != null) {
                          ref.watch(selectedFilterProvider.notifier).state =
                              'Custom';
                          ref.watch(fromDateProvider.notifier).state =
                              DateFormat('dd-MM-yyyy').format(fromDate!);
                          ref.watch(toDateProvider.notifier).state = DateFormat(
                            'dd-MM-yyyy',
                          ).format(toDate!);
                          ref.invalidate(getWalletListProvider);
                        }
                      },
                      selectedColor: ColorConstant.maingreen,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color:
                            ref.watch(selectedFilterProvider) == 'Custom'
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search transactions",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
ref.read(searchQueryProvider.notifier).state = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          ref.watch(getWalletListProvider(walletType: '1')).when(
                data: (data) {
                  final opening = num.tryParse(
                          data.openingBalance?.toString() ?? '0') ??
                      0.0;
                  final closing = num.tryParse(
                          data.closingBalance?.toString() ?? '0') ??
                      0.0;
                  return Container(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 5,
                      bottom: 5,
                    ),
                    color: ColorConstant.bgcolor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.msgOpeningBalance,
                              style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.msgClosingbal,
                              style: TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              NumberFormat.currency(
                                locale: 'HI',
                                symbol: '\u{20B9}',
                                decimalDigits: 2,
                              ).format(opening),
                              style: TextStyle(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'HI',
                                symbol: '\u{20B9}',
                                decimalDigits: 2,
                              ).format(closing),
                              style: TextStyle(
                                fontSize: Adaptive.sp(17),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                loading: () => Container(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 5,
                    bottom: 5,
                  ),
                  color: ColorConstant.bgcolor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.msgOpeningBalance,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.msgClosingbal,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ 0.00",
                            style: TextStyle(
                              fontSize: Adaptive.sp(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₹ 0.00",
                            style: TextStyle(
                              fontSize: Adaptive.sp(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                error: (e, s) => Container(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 5,
                    bottom: 5,
                  ),
                  color: ColorConstant.bgcolor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.msgOpeningBalance,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.msgClosingbal,
                            style: TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ 0.00",
                            style: TextStyle(
                              fontSize: Adaptive.sp(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₹ 0.00",
                            style: TextStyle(
                              fontSize: Adaptive.sp(17),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          Container(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10,
              bottom: 10,
            ),
            color: ColorConstant.gray300.withOpacity(0.4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.date,
                      style: TextStyle(fontSize: Adaptive.sp(16)),
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.debit,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(" / "),
                        Text(
                          AppLocalizations.of(context)!.msgCredit,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: Adaptive.sp(16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.msgChequeno,
                      style: AppStyle.lbldrawer.copyWith(
                        fontSize: Adaptive.sp(16),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.msgBalance,
                      style: AppStyle.lbldrawer.copyWith(
                        fontSize: Adaptive.sp(16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ref
              .watch(getWalletListProvider(walletType: '1'))
              .when(
                data: (data) {
                  var filteredData =
                      data.data?.where((transaction) {
                        var query =
                            ref.watch(searchQueryProvider).toLowerCase();
                        return transaction.narration?.toLowerCase().contains(
                              query,
                            ) ??
                            false;
                      }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
  ref.read(dataList.notifier).state = data.data ?? [];
});

                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView.builder(
                        itemCount: filteredData?.length ?? 0,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var transaction = filteredData![index];
                          DateTime abc = DateTime.parse(transaction.date ?? "");
                          var date = DateFormat('dd-MM-yyyy').format(abc);
                          String caseId =
                              transaction.referenceNo!
                                  .toString()
                                  .split(
                                    transaction.referenceNo
                                        .toString()
                                        .split(" ")
                                        .last,
                                  )
                                  .join();
                          var grading =
                              transaction.referenceNo
                                  .toString()
                                  .split(" ")
                                  .last;

                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              top: 10.0,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      date.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Adaptive.sp(16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ColumnSuper(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text: transaction.narration ?? "",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: Adaptive.sp(16),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5),
                                          Text.rich(
                                            TextSpan(
                                              text: caseId.toString(),
                                              style: TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                color: const Color(0xff786b74),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: grading.toString(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ColumnSuper(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Text(
                                            NumberFormat.currency(
                                              locale: 'HI',
                                              symbol: '\u{20B9}',
                                              decimalDigits: 2,
                                            ).format(
                                              num.parse(
                                                transaction.amount ?? "0.0",
                                              ),
                                            ),
                                            style: TextStyle(
                                              color:
                                                  transaction.type == "Credit"
                                                      ? Colors.green
                                                      : Colors.red,
                                              fontSize: Adaptive.sp(16),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            NumberFormat.currency(
                                              locale: 'HI',
                                              symbol: '\u{20B9}',
                                              decimalDigits: 2,
                                            ).format(
                                              num.parse(
                                                transaction.balance ?? "0.0",
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Adaptive.sp(16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 2),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
                error:
                    (e, s) => Expanded(
                      child: SizedBox(
                        child: noWalletTransactions(context),
                        height: Adaptive.h(100),
                      ),
                    ),
                loading:
                    () => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Skeletonizer(
                        child: ListView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder:
                              (context, index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 18,
                                        width: 80,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 4,
                                        ),
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 18,
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 4,
                                          ),
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 18,
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 4,
                                          ),
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 2),
                                ],
                              ),
                        ),
                      ),
                    ),
              ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: ref.watch(dataList).isNotEmpty,
        child: ElevatedButton(
          onPressed: () async {
            final walletState =
                ref.read(getWalletListProvider(walletType: '1')).value;
            final opBal = (walletState?.openingBalance ?? 0.0).toString();
            final clBal = (walletState?.closingBalance ?? '0.0').toString();
            ref
                .read(
                  walletSummaryDataProvider(
                    fromDate: ref.watch(fromDateProvider),
                    toDate: ref.watch(toDateProvider),
                    walletType: "1",
                  ).future,
                )
                .then((value) async {
                  makePdf(
                        context,
                        ref.watch(dataList),
                        opBal,
                        clBal,
                        ref,
                        value.data,
                      )
                      .then((file) async {
                        if (file != null) {
                          await FileSaver.instance
                              .saveAs(
                                name: 'wallet_statement',
                                file: file,
                                mimeType: MimeType.pdf,
                                ext: '.pdf',
                              )
                              .then((value) {
                                OpenFile.open(value);
                                Fluttertoast.showToast(
                                  msg: 'File saved successfully ',
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              });
                        }
                      })
                      .onError((e, s) {
                        if (e is pdfWidgets.TooManyPagesException) {
                          context.errorToast(
                            'Please Select Dates below 5 months',
                          );
                        }
                      });
                });
          },
          style: AppStyle.buttonStyle,
          child: Text(
            AppLocalizations.of(context)!.msgPdf,
            style: AppStyle.lbldrawerbtn.copyWith(fontSize: Adaptive.sp(16)),
          ),
        ),
      ),
    );
  }

  openPdf(List<Datum>? data, WidgetRef ref) async {}
}

var fromDateProvider = StateProvider(
  (ref) => DateFormat(
    'dd-MM-yyyy',
  ).format(DateTime.now().subtract(Duration(days: 30))),
);
var toDateProvider = StateProvider(
  (ref) => DateFormat('dd-MM-yyyy').format(DateTime.now()),
);

var openingBalance = StateProvider((ref) => 0.0);
var closingBalance = StateProvider((ref) => '0.0');
var selectedFilterProvider = StateProvider<String>((ref) => '1 Month');
