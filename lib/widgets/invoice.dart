import 'dart:io';

import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/presentation/sbt/ContractNotes/model/SbtBuyerContractModel.dart';
import 'package:apnagodam/presentation/sbt/ContractNotes/model/SbtSellerContractModel.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/models/WalletStatementSummaryModel.dart';
import 'package:apnagodam/presentation/wallet_statement_screen/models/wallet_transactions_list_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:pdf/widgets.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

Future<File?> makePdf(
    BuildContext flutterContext,
    List<Datum>? invoice,
    String opening,
    String closing,
    WidgetRef ref,
    List<WalletStatementSummaryDatum>? summaryDatum) async {
  final pdf = Document();
  int index = 0;
  final img = await rootBundle.load('assets/images/user_logo.png');
  final imageBytes = img.buffer.asUint8List();
  Image image1 = Image(MemoryImage(imageBytes), width: 20, height: 20);
  List<WalletStatementSummaryDatum>? summaryList = [];

  List<WalletStatementSummaryDatum>? debitList = [];
  List<WalletStatementSummaryDatum>? creditList = [];

  for (var element in summaryDatum!) {
    if (element.type.toString().toLowerCase() == "debit") {
      debitList.add(element);
    } else {
      creditList.add(element);
    }
  }

  summaryList.addAll(debitList);
  summaryList.addAll(creditList);
  pdf.addPage(
    MultiPage(
      maxPages: 100,
      header: (context) =>
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [image1, Text("Apna Godam")]),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5, bottom: 5),
            decoration:
                BoxDecoration(border: Border.all(color: PdfColors.black)),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "User Id: ${ref.watch(sharedUtilityProvider).getUser()?.phone ?? ""}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Name: ${ref.watch(sharedUtilityProvider).getUser()?.fname ?? ""}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Address: ${ref.watch(sharedUtilityProvider).getUser()?.address ?? ""}(${ref.watch(sharedUtilityProvider).getUser()?.pincode ?? ""})",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "City: ${ref.watch(sharedUtilityProvider).getUser()?.city ?? ""}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "State: ${ref.watch(sharedUtilityProvider).getUser()?.state ?? ""}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Phone: ${ref.watch(sharedUtilityProvider).getUser()?.phone ?? ""}",
                      style: TextStyle( fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Email: ${ref.watch(sharedUtilityProvider).getUser()?.email ?? ""}",
                      style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          )
        ])),
        Expanded(
            child: Container(
          height: 150,
          padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 15, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Wallet Balance: ${ref.watch(sharedUtilityProvider).getUser()?.power ?? ""}",
                    style: TextStyle(fontSize: 10)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Bank A/C: ${ref.watch(sharedUtilityProvider).getUser()?.bankAccNo ?? ""}",
                    style: TextStyle(fontSize: 10)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "IFSC: ${ref.watch(sharedUtilityProvider).getUser()?.bankIfscCode ?? ""}",
                    style: TextStyle(fontSize: 10)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Branch: ${ref.watch(sharedUtilityProvider).getUser()?.bankBranch ?? ""}",
                    style: TextStyle(fontSize: 10)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Account Type: Apna Godam Escrow Account",
                    style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
        )),
        SizedBox(height: 10),
      ]),
      footer: (context) =>
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
            'Singodwala Warehousing and Logistics Pvt. Ltd  \n*Closing Balance includes funds earmarked for hold and uncleared funds.\nContents of this statement will be considered correct if no error is reported within 3 days of receipt of statement.',
            style: TextStyle(fontSize: 8)),
        Text(
            'Registered Office Address:Basement Plot no 16 Govind Villa Sector 9 Vidhyadhar Nagar \nJuridiction Location : Jaipur, Rajasthan - 302019',
            style: TextStyle(fontSize: 8)),
        Center(
          child: Text(
            "Page ${context.pageNumber} of ${context.pagesCount}",
            style: TextStyle(fontSize: 10),
          ),
        )
      ]),
      build: (context) => <Widget>[
        Column(
          children: [
            Text(
                "Statement of Account for period: ${DateFormat('MM/dd/yyyy').format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(invoice!.first.date ?? ""))} to ${DateFormat('MM/dd/yyyy').format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(invoice.last.date ?? ""))}",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center),
            Divider(),
            Row(children: [
              Expanded(
                  child: Text("Summary",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center)),
            ]),
            Divider(),
            Table(border: TableBorder.all(color: PdfColors.black), children: [
              TableRow(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  decoration: BoxDecoration(color: PdfColors.black),
                  children: [
                    Text(AppLocalizations.of(flutterContext)!.sirealno,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: PdfColors.white),
                        textAlign: TextAlign.center),
                    Expanded(
                      child: Text(
                          AppLocalizations.of(flutterContext)!.msgNarration,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: PdfColors.white),
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                        child: Text(
                            AppLocalizations.of(flutterContext)!.typeLabel,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: PdfColors.white),
                            textAlign: TextAlign.center)),
                    Expanded(
                        child: Text(
                            AppLocalizations.of(flutterContext)!.paymentAmount,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: PdfColors.white),
                            textAlign: TextAlign.center)),
                  ]),
              ...summaryList.map((e) {
                index++;
                var label = "";
                var interestLabel = '';
                if (e.label.toString().toLowerCase() == "loan" &&
                    e.type.toString().toLowerCase() == "credit") {
                  label = "Loan Disbursed";
                } else if (e.label.toString().toLowerCase() == "loan" &&
                    e.type.toString().toLowerCase() == "debit") {
                  label = "Loan Repaid";
                } else {
                  label = e.label.toString().isEmpty ? "--" : e.label ?? "--";
                }

                if (e.label.toString().toLowerCase() == "interest" &&
                    e.type.toString().toLowerCase() == "credit") {
                  interestLabel = "Interest Disbursed";
                } else if (e.label.toString().toLowerCase() == "interest" &&
                    e.type.toString().toLowerCase() == "debit") {
                  interestLabel = "Interest Repaid";
                } else {
                  interestLabel =
                      e.label.toString().isEmpty ? "--" : e.label ?? "--";
                }
                return TableRow(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$index',
                        ),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(e.label.toString().toLowerCase() == "interest"
                            ? interestLabel
                            : label),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          e.type,
                        ),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          e.amount,
                        ),
                      ]),
                ]);
              })
            ]),
          ],
        ),
      ],
    ),
  );
  pdf.addPage(MultiPage(
    build: (context) => [
      Table(border: TableBorder.all(color: PdfColors.black), children: [
        TableRow(
            verticalAlignment: TableCellVerticalAlignment.middle,
            decoration: BoxDecoration(color: PdfColors.black),
            children: [
              Expanded(
                child: Text(AppLocalizations.of(flutterContext)!.date,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: PdfColors.white),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                  child: Text(AppLocalizations.of(flutterContext)!.narration,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: PdfColors.white),
                      textAlign: TextAlign.center)),
              Expanded(
                  child: Text(
                      AppLocalizations.of(flutterContext)!.msgGatepastwo,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: PdfColors.white),
                      textAlign: TextAlign.center)),
              Expanded(
                  child: Text(AppLocalizations.of(flutterContext)!.debit,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: PdfColors.white),
                      textAlign: TextAlign.center)),
              Expanded(
                  child: Text(AppLocalizations.of(flutterContext)!.credit,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: PdfColors.white),
                      textAlign: TextAlign.center)),
              Expanded(
                  child: Text(
                      AppLocalizations.of(flutterContext)!.msgClosingbal,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: PdfColors.white),
                      textAlign: TextAlign.center)),
            ]),
        ...invoice!.map((e) {
          DateTime parseDate =
              DateFormat("yyyy-MM-dd HH:mm:ss").parse(e.date ?? "");
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('MM/dd/yyyy');
          var outputDate = outputFormat.format(inputDate);
          return TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Expanded(
                  child: Text(e.date.toString().isEmpty ? "--" : outputDate,
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                      "${e.narration.toString().isEmpty ? "--" : e.narration}",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                      "${e.referenceNo.toString().isEmpty ? "--" : e.referenceNo}",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                      e.type.toString().toLowerCase() == "debit"
                          ? NumberFormat.currency(
                                  locale: 'en_IN', symbol: '', decimalDigits: 2)
                              .format(double.tryParse(e.amount ?? "0") ?? 0)
                          : "--",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                      e.type.toString().toLowerCase() == "credit"
                          ? NumberFormat.currency(
                                  locale: 'en_IN', symbol: '', decimalDigits: 2)
                              .format(double.tryParse(e.amount ?? '0') ?? 0)
                          : "--",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                      NumberFormat.currency(
                              locale: 'en_IN', symbol: '', decimalDigits: 2)
                          .format(double.tryParse(e.balance ?? "0") ?? 0),
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center),
                  flex: 1,
                ),
              ]);
        })
      ]),
    ],
    footer: (context) =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
          'Singodwala Warehousing and Logistics Pvt. Ltd  \n*Closing Balance includes funds earmarked for hold and uncleared funds.\nContents of this statement will be considered correct if no error is reported within 3 days of receipt of statement.',
          style: TextStyle(fontSize: 8)),
      Text(
          'Registered Office Address: Basement Plot no 16 Govind Villa Sector 9 Vidhyadhar Nagar \nJuridiction Location : Jaipur, Rajasthan - 302019',
          style: TextStyle(fontSize: 8)),
      Center(
        child: Text(
          "Page ${context.pageNumber} of ${context.pagesCount}",
          style: TextStyle(fontSize: 10),
        ),
      )
    ]),
  ));

  final output = await getTemporaryDirectory();
  final file = File('${output.path}/wallet_statement.pdf');
  if (file.existsSync()) {
    file.deleteSync();
  }
  await file.writeAsBytes(await pdf.save());

  // Open the generated PDF using a package like `open_file`
  // Make sure to add the open_file package to your pubspec.yaml
  return file;
}

Future<File?> settlementPdf(SbtBuyerContractModel invoice, String opening,
    String closing, WidgetRef ref) async {
  final pdf = Document();
  int index = 0;
  final img = await rootBundle.load('assets/images/user_logo.png');
  final imageBytes = img.buffer.asUint8List();
  Image image1 = Image(MemoryImage(imageBytes), width: 20, height: 20);

  num defaultQty = num.parse("${invoice.data?.defaultQty ?? 0}");
  num totalBags = 0;
  num totalWeight = 0;
  num agComission = 0;
  num netAmount = 0;

  if (invoice.data!.buySellData!.length == 1) {
    for (int i = 0; i < invoice.data!.buySellData!.length; i++) {
      totalBags = num.parse("${invoice.data!.buySellData![i].bags ?? 0}");

      totalWeight = num.parse("${invoice.data!.buySellData![i].qty ?? 0}");
      agComission =
          num.parse("${invoice.data!.buySellData![i].agCommisison ?? 0}");

      netAmount = num.parse("${invoice.data!.buySellData![i].netAmount ?? 0}");
    }
  } else {
    for (int i = 0; i < invoice.data!.buySellData!.length; i++) {
      for (int j = 0; j < i; j++) {
        totalBags = num.parse("${invoice.data!.buySellData![i].bags ?? 0}") +
            num.parse("${invoice.data!.buySellData![j].bags ?? 0}");

        totalWeight = num.parse("${invoice.data!.buySellData![i].qty ?? 0}") +
            num.parse("${invoice.data!.buySellData![j].qty ?? 0}");
        agComission =
            num.parse("${invoice.data!.buySellData![i].agCommisison ?? 0}") +
                num.parse("${invoice.data!.buySellData![j].agCommisison ?? 0}");

        netAmount =
            num.parse("${invoice.data!.buySellData![i].netAmount ?? 0}") +
                num.parse("${invoice.data!.buySellData![j].netAmount ?? 0}");
      }
    }
  }
  totalWeight = totalWeight + defaultQty;
  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a3,
      header: (context) => Column(children: [
        SizedBox(height: 40),
        Text('Buyer Detailed Settlement Report -',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        Text('Deal ID - ${invoice.data?.orderId}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text('Order Matching Date ${invoice.data?.orderMatchDate}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('MTP Sale',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            Text('Commodity: ${invoice.data?.commodity}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Buyer Name: ${invoice.data?.buyerName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            Text('Rate (in Rs.): ${invoice.data?.price}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Seller Name: ${invoice.data?.sellerName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            Text('Quantity(Qtl.): ${invoice.data?.quantity}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Funds Lein: ${invoice.data?.loanType}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            Text('Delivery Days: ${invoice.data?.deliveryDays}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        Divider(),
      ]),
      build: (context) => <Widget>[
        Column(
          children: [
            Container(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text("S.no",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(
                    child: Text("Delivery Date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Gatepass",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 5),
                Expanded(
                    child: Text("Delivery Centre",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 5),
                Expanded(
                    child: Text("Bags",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 5),
                Expanded(
                    child: Text("Weight(qtl.)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 5),
                Expanded(
                    child: Text("Ag Commission (in Rs.)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 5),
                Expanded(
                    child: Text("Net Amount (in Rs.)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
              ],
            ),
            Divider(),
            ...invoice.data!.buySellData!.map((e) {
              ++index;

              return Column(
                children: [
                  Container(
                    color: index % 2 == 0 ? PdfColors.grey200 : PdfColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(height: 50),
                        Expanded(
                            child: Text("$index",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10))),
                        SizedBox(width: 10),
                        Expanded(
                            child: Text("${e.date}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10))),
                        Expanded(
                            child: Text("${e.gatepass}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10))),
                        SizedBox(width: 5),
                        Expanded(
                            child: Text("${e.warehouseName}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10))),
                        SizedBox(width: 5),
                        Expanded(
                            child: Text("${e.bags}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10))),
                        SizedBox(width: 5),
                        Expanded(
                            child: Text("${e.qty}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10))),
                        SizedBox(width: 5),
                        Expanded(
                            child: Text("${e.agCommisison}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10))),
                        SizedBox(width: 5),
                        Expanded(
                            child: Text("${e.netAmount}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10))),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Divider(height: 1, thickness: 1, color: PdfColors.grey800),
                ],
              );
            }),
            SizedBox(height: 5),
            if (defaultQty > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text("Default Qty.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10))),
                  SizedBox(width: 10),
                  Expanded(
                      child: Text("",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                  SizedBox(width: 5),
                  Expanded(
                      child: Text("",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                  SizedBox(width: 5),
                  Expanded(
                      child: Text("",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                  SizedBox(width: 5),
                  Expanded(
                      child: Text("$defaultQty",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10))),
                  SizedBox(width: 5),
                  Expanded(
                      child: Text("",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                  SizedBox(width: 5),
                  Expanded(
                      child: Text("",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                ],
              ),
            Divider(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text("Total",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text("",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text("",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("$totalBags",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("$totalWeight",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("$agComission",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text(netAmount.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                  ],
                ),
                Divider(),
              ],
            )
          ],
        )
      ],
    ),
  );
  final output = await getApplicationSupportDirectory();

  final file = File('${output.path}/settlement_report.pdf');
  if (file.existsSync()) {
    file.deleteSync();
  }
  await file.writeAsBytes(await pdf.save());

  // Open the generated PDF using a package like `open_file`
  // Make sure to add the open_file package to your pubspec.yaml
  return file;
}

Future<File?> sellerContractPdf(
    SbtSellerContractModel invoice, WidgetRef ref) async {
  final pdf = Document();
  int index = 0;
  final img = await rootBundle.load('assets/images/user_logo.png');
  final imageBytes = img.buffer.asUint8List();
  Image image1 = Image(MemoryImage(imageBytes), width: 20, height: 20);
  num defaultQty = num.parse("${invoice.data?.defaultQty ?? 0}");
  num totalBags = 0;
  num totalWeight = 0;
  num totalEntryLoad = 0;
  num totalLabour = 0;

  num totalClaimAmount = 0;
  num totalMandiTax = 0;
  num totalRent = 0;
  num totalWsa = 0;
  num netAmount = 0;

  if (invoice.data!.buySellData!.length <= 1) {
    for (int i = 0; i < invoice.data!.buySellData!.length; i++) {
      totalBags = num.parse("${invoice.data!.buySellData![i].bags ?? 0}");

      totalWeight = num.parse("${invoice.data!.buySellData![i].qty ?? 0}");

      netAmount = num.parse("${invoice.data!.buySellData![i].netAmount ?? 0}");
      totalEntryLoad =
          num.parse("${invoice.data!.buySellData![i].entryload ?? 0}");
      totalLabour = num.parse("${invoice.data!.buySellData![i].labour ?? 0}");
      totalClaimAmount =
          num.parse("${invoice.data!.buySellData![i].perQtlQualityClaim ?? 0}");

      totalMandiTax =
          num.parse("${invoice.data!.buySellData![i].mandiTax ?? 0}");

      totalRent = num.parse("${invoice.data!.buySellData![i].rent ?? 0}");

      totalWsa = num.parse("${invoice.data!.buySellData![i].wsa ?? 0}");
    }
  } else {
    for (int i = 0; i < invoice.data!.buySellData!.length; i++) {
      totalBags += num.parse("${invoice.data!.buySellData![i].bags ?? 0}");

      totalWeight += num.parse("${invoice.data!.buySellData![i].qty ?? 0}");

      netAmount += num.parse("${invoice.data!.buySellData![i].netAmount ?? 0}");

      totalEntryLoad +=
          num.parse("${invoice.data!.buySellData![i].entryload ?? 0}");
      totalClaimAmount +=
          num.parse("${invoice.data!.buySellData![i].perQtlQualityClaim ?? 0}");
      totalLabour += num.parse("${invoice.data!.buySellData![i].labour ?? 0}");
      totalMandiTax +=
          num.parse("${invoice.data!.buySellData![i].mandiTax ?? 0}");

      totalRent += num.parse("${invoice.data!.buySellData![i].rent ?? 0}");

      totalWsa += num.parse("${invoice.data!.buySellData![i].wsa ?? 0}");
    }
  }
  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a3,
      header: (context) => Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [image1, Text("Sauda Bahi")]),
            Container(
              alignment: Alignment.topCenter,
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, top: 5, bottom: 5),
              decoration:
                  BoxDecoration(border: Border.all(color: PdfColors.black)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Name: ${ref.watch(sharedUtilityProvider).getUser()?.fname ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Address: ${ref.watch(sharedUtilityProvider).getUser()?.address ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "City: ${ref.watch(sharedUtilityProvider).getUser()?.city ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "State: ${ref.watch(sharedUtilityProvider).getUser()?.state ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Phone: ${ref.watch(sharedUtilityProvider).getUser()?.phone ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Email: ${ref.watch(sharedUtilityProvider).getUser()?.email ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            )
          ])),
          Expanded(
              child: Container(
            height: 150,
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 15, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Commodity: ${invoice.data?.commodity}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Buyer Name: ${invoice.data?.buyerName}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Rate: ${invoice.data?.price} rs./Qtl.",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Seller Name: ${invoice.data?.sellerName}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Quantity: ${invoice.data?.quantity}(Qtl.)",
                      style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          )),
          SizedBox(height: 10),
        ]),
        SizedBox(height: 40),
        Text('Seller SBT Contract Note ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        Text('Deal ID - ${invoice.data?.orderId}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 40),
      ]),
      build: (context) => <Widget>[
        Table(border: TableBorder.all(color: PdfColors.black), children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Expanded(
                    child: Text("S.no",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Gatepass",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Bags",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Weight(Qtl.)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Delivery Centre",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Labour",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Entry Load/ Dhalta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Rent",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("WSA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Mandi\nTax",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Quality Claim",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Net Amount",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
              ]),
          ...invoice.data!.buySellData!.map((e) {
            index++;
            return TableRow(children: [
              Expanded(
                  child: Text("$index",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e.date}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e.gatepass}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e.bags}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e.qty}(Qtl.)",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e.warehouseName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      num.parse("${e.labour ?? "0"}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      num.parse("${e.entryload ?? '0'}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(num.parse("${e.rent ?? '0'}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(num.parse("${e.wsa ?? "0"}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      num.parse("${e.mandiTax ?? "0"}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e.perQtlQualityClaim} per Qtl.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      num.parse("${e.netAmount ?? "0.00"}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
            ]);
          })
        ]),
        Column(
          children: [
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text("Total",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 5),
                Expanded(
                    child: Text("$totalBags",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 5),
                Expanded(
                    child: Text(totalWeight.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 5),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(
                    child: Text(totalLabour.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(
                    child: Text(totalEntryLoad.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(
                    child: Text(totalRent.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(
                    child: Text(totalWsa.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(
                    child: Text(totalMandiTax.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(
                    child: Text(totalClaimAmount.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
                Expanded(
                    child: Text(netAmount.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                SizedBox(width: 10),
              ],
            ),
            Divider(),
          ],
        )
      ],
    ),
  );
  final output = await getApplicationSupportDirectory();

  final file = File('${output.path}/seller_settlement_report.pdf');
  await file.writeAsBytes(await pdf.save());

  // Open the generated PDF using a package like `open_file`
  // Make sure to add the open_file package to your pubspec.yaml
  return file;
}

Future<File?> deliverySellerContractPdf(
    SbtSellerContractModel invoice, WidgetRef ref) async {
  final pdf = Document();
  int index = 0;
  final img = await rootBundle.load('assets/images/user_logo.png');
  final imageBytes = img.buffer.asUint8List();
  Image image1 = Image(MemoryImage(imageBytes), width: 20, height: 20);
  num defaultQty = num.parse("${invoice.data?.defaultQty ?? 0}");
  num totalBags = 0;
  num totalWeight = 0;
  num totalEntryLoad = 0;
  num totalLabour = 0;

  num totalClaimAmount = 0;
  num totalMandiTax = 0;
  num totalRent = 0;
  num totalWsa = 0;
  num netAmount = 0;

  if (invoice.data!.buySellData!.length == 1) {
    for (int i = 0; i < invoice.data!.buySellData!.length; i++) {
      totalBags = num.parse("${invoice.data!.buySellData![i].bags ?? 0}");

      totalWeight = num.parse("${invoice.data!.buySellData![i].qty ?? 0}");

      netAmount = num.parse("${invoice.data!.buySellData![i].netAmount ?? 0}");
      totalEntryLoad =
          num.parse("${invoice.data!.buySellData![i].entryload ?? 0}");
      totalLabour = num.parse("${invoice.data!.buySellData![i].labour ?? 0}");
      totalClaimAmount =
          num.parse("${invoice.data!.buySellData![i].perQtlQualityClaim ?? 0}");

      totalMandiTax =
          num.parse("${invoice.data!.buySellData![i].mandiTax ?? 0}");

      totalRent = num.parse("${invoice.data!.buySellData![i].rent ?? 0}");

      totalWsa = num.parse("${invoice.data!.buySellData![i].wsa ?? 0}");
    }
  } else {
    for (int i = 0; i < invoice.data!.buySellData!.length; i++) {
      totalBags += num.parse("${invoice.data!.buySellData![i].bags ?? 0}");

      totalWeight += num.parse("${invoice.data!.buySellData![i].qty ?? 0}");

      netAmount += num.parse("${invoice.data!.buySellData![i].netAmount ?? 0}");

      totalEntryLoad +=
          num.parse("${invoice.data!.buySellData![i].entryload ?? 0}");
      totalClaimAmount +=
          num.parse("${invoice.data!.buySellData![i].perQtlQualityClaim ?? 0}");
      totalLabour += num.parse("${invoice.data!.buySellData![i].labour ?? 0}");
      totalMandiTax +=
          num.parse("${invoice.data!.buySellData![i].mandiTax ?? 0}");

      totalRent += num.parse("${invoice.data!.buySellData![i].rent ?? 0}");

      totalWsa += num.parse("${invoice.data!.buySellData![i].wsa ?? 0}");
    }
  }
  pdf.addPage(
    MultiPage(
        pageFormat: PdfPageFormat.a3,
        header: (context) => Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [image1, Text("Sauda Bahi")]),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: PdfColors.black)),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Name: ${ref.watch(sharedUtilityProvider).getUser()?.fname ?? ""}",
                              style: TextStyle(fontSize: 10)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Address: ${ref.watch(sharedUtilityProvider).getUser()?.address ?? ""}",
                              style: TextStyle(fontSize: 10)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "City: ${ref.watch(sharedUtilityProvider).getUser()?.city ?? ""}",
                              style: TextStyle(fontSize: 10)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "State: ${ref.watch(sharedUtilityProvider).getUser()?.state ?? ""}",
                              style: TextStyle(fontSize: 10)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Phone: ${ref.watch(sharedUtilityProvider).getUser()?.phone ?? ""}",
                              style: TextStyle(fontSize: 10)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Email: ${ref.watch(sharedUtilityProvider).getUser()?.email ?? ""}",
                              style: TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                  )
                ])),
                Expanded(
                    child: Container(
                  height: 150,
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 15, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Commodity: ${invoice.data?.commodity}",
                            style: TextStyle(fontSize: 10)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Buyer Name: ${invoice.data?.buyerName}",
                            style: TextStyle(fontSize: 10)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Rate: ${invoice.data?.price} rs./Qtl.",
                            style: TextStyle(fontSize: 10)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Seller Name: ${invoice.data?.sellerName}",
                            style: TextStyle(fontSize: 10)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Quantity: ${invoice.data?.quantity}(Qtl.)",
                            style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 10),
              ]),
              SizedBox(height: 40),
              Text('Confirm Order Settlement Report ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              Text('Deal ID - ${invoice.data?.orderId}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 40),
            ]),
        build: (context) => <Widget>[
              Table(border: TableBorder.all(color: PdfColors.black), children: [
                TableRow(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      Expanded(
                          child: Text("S.no",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Date",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Gatepass",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Bags",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Weight(Qtl.)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Delivery Centre",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Labour",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Entry Load/ Dhalta",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Rent",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("WSA",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Mandi\nTax",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Quality Claim",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Net Amount",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Vehicle No.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                    ]),
                ...invoice.data!.buySellData!.map((e) {
                  index++;
                  return TableRow(children: [
                    Expanded(
                        child: Text("$index",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text("${e.date}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text("${e.gatepass}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text("${e.bags}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text("${e.qty}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text("${e.warehouseName}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text(
                            num.parse("${e.labour ?? "0"}").toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text(
                            num.parse("${e.entryload ?? '0'}")
                                .toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text(
                            num.parse("${e.rent ?? '0'}").toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text(
                            num.parse("${e.wsa ?? "0"}").toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text(
                            num.parse("${e.mandiTax ?? "0"}")
                                .toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text("${e.perQtlQualityClaim} per Qtl.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text(
                            num.parse("${e.netAmount ?? "0.00"}")
                                .toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                    Expanded(
                        child: Text("${e.vehicleNo ?? "--"}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10))),
                  ]);
                })
              ]),
            ],
        footer: (context) => Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text("Total",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text("--",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text("--",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("$totalBags",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("$totalWeight",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("--",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(totalLabour.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(totalEntryLoad.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(totalRent.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(totalWsa.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(totalMandiTax.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(totalClaimAmount.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(netAmount.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                    SizedBox(width: 10),
                  ],
                ),
                Divider(),
              ],
            )),
  );
  final output = await getApplicationSupportDirectory();

  final file = File('${output.path}/seller_settlement_report.pdf');
  if (file.existsSync()) {
    file.deleteSync();
  }
  await file.writeAsBytes(await pdf.save());

  // Open the generated PDF using a package like `open_file`
  // Make sure to add the open_file package to your pubspec.yaml
  return file;
}

Future<File?> stackContractNotePdf(Map<String, dynamic> stackData,
    WidgetRef ref, String buyerSellerType) async {
  final pdf = Document();
  int index = 0;
  final img = await rootBundle.load('assets/images/user_logo.png');
  final imageBytes = img.buffer.asUint8List();
  Image image1 = Image(MemoryImage(imageBytes), width: 20, height: 20);
  num totalBags = 0;
  num totalWeight = 0;
  num totalLabour = 0;
  num agCommission = 0;

  num totalCashAmount = 0;
  num totalPrice = 0;
  num dealAmount = 0;

  agCommission = num.parse("${stackData['data']['ag_commisssion_amt'] ?? 0}");
  if (stackData['data']['buy_sell_data']!.length == 1) {
    for (int i = 0; i < stackData['data']['buy_sell_data']!.length; i++) {
      totalBags =
          num.parse("${stackData['data']['buy_sell_data']![i]['bags'] ?? 0}");

      totalWeight =
          num.parse("${stackData['data']['buy_sell_data']![i]['qty'] ?? 0}");

      dealAmount = (num.parse(
          "${stackData['data']['buy_sell_data']![i]['loan_amount'] ?? 0}"));

      totalCashAmount = (num.parse(
          "${stackData['data']['buy_sell_data']![i]['cash_amt'] ?? 0}"));
      totalPrice = num.parse(
              "${stackData['data']['buy_sell_data']![i]['deal_amt'] ?? 0}") +
          num.parse("${stackData['data']['ag_commisssion_amt']}");
    }
  } else {
    for (int i = 0; i < stackData['data']['buy_sell_data']!.length; i++) {
      totalBags +=
          num.parse("${stackData['data']['buy_sell_data']![i]['bags'] ?? 0}");

      totalWeight +=
          num.parse("${stackData['data']['buy_sell_data']![i]['qty'] ?? 0}");

      dealAmount += (num.parse(
          "${stackData['data']['buy_sell_data']![i]['loan_amount'] ?? 0}"));

      totalCashAmount += (num.parse(
          "${stackData['data']['buy_sell_data']![i]['cash_amt'] ?? 0}"));
      totalPrice += num.parse(
              "${stackData['data']['buy_sell_data']![i]['deal_amt'] ?? 0}") +
          num.parse("${stackData['data']['ag_commisssion_amt']}");
    }
  }
  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      header: (context) => Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [image1, Text("Apna Godam")]),
            Container(
              alignment: Alignment.topCenter,
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, top: 5, bottom: 5),
              decoration:
                  BoxDecoration(border: Border.all(color: PdfColors.black)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Name: ${ref.watch(sharedUtilityProvider).getUser()?.fname ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Address: ${ref.watch(sharedUtilityProvider).getUser()?.address ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "City: ${ref.watch(sharedUtilityProvider).getUser()?.city ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "State: ${ref.watch(sharedUtilityProvider).getUser()?.state ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Phone: ${ref.watch(sharedUtilityProvider).getUser()?.phone ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Email: ${ref.watch(sharedUtilityProvider).getUser()?.email ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            )
          ])),
          Expanded(
              child: Container(
            height: 150,
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 15, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Commodity: ${stackData['data']['commodity']}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Buyer Name: ${stackData['data']['buyer_name']}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Rate: ${stackData['data']['price']} rs./Qtl.",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Seller Name: ${stackData['data']['seller_name']}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Quantity: ${stackData['data']['quantity']}(Qtl.)",
                      style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          )),
          SizedBox(height: 10),
        ]),
        SizedBox(height: 40),
        Text(
            'Stack ${buyerSellerType == "buy" ? "Buyer" : "Seller"} Contract Note',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        Text('Deal ID - ${stackData['data']['order_id']}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 40),
      ]),
      build: (context) => <Widget>[
        Table(border: TableBorder.all(color: PdfColors.black), children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              decoration: BoxDecoration(
                  color: PdfColors.black,
                  border: Border.all(color: PdfColors.black)),
              children: [
                Expanded(
                    child: Text("S.no",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Gatepass",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Weight(Qtl.)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Bags",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Loan Amount",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Cash Wallet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Total Amount",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
              ]),
          ...stackData['data']['buy_sell_data'].map((e) {
            index++;
            return TableRow(children: [
              Expanded(
                  child: Text("$index",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e['gatepass']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e['qty']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e['bags']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      num.parse("${e['loan_amount'] ?? 0}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e['cash_amt']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      num.parse("${e['deal_amt'] ?? 0}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
            ]);
          })
        ]),
        Table(border: TableBorder.all(color: PdfColors.black), children: [
          TableRow(children: [
            Expanded(
                child: Text("AG Commission",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
            Expanded(
                child: Text("--",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
            Expanded(
                child: Text("--",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
            Expanded(
                child: Text("--",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
            Expanded(
                child: Text("--",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
            Expanded(
                child: Text("--",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
            Expanded(
                child: Text("+${agCommission.toStringAsFixed(2)}",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          ])
        ]),
        Table(children: [
          TableRow(
              decoration: BoxDecoration(
                  color: PdfColors.black,
                  border: Border.all(color: PdfColors.black)),
              children: [
                Expanded(
                    child: Text("Total",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("$totalWeight",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("$totalBags",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text(dealAmount.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text(totalCashAmount.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text(totalPrice.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
              ])
        ])
      ],
    ),
  );
  final output = await getApplicationSupportDirectory();

  final file = File('${output.path}/stack_contract_note_buyer.pdf');
  if (file.existsSync()) {
    file.deleteSync();
  }
  await file.writeAsBytes(await pdf.save());

  // Open the generated PDF using a package like `open_file`
  // Make sure to add the open_file package to your pubspec.yaml
  return file;
}

Future<File?> stackContractNotePdfSeller(Map<String, dynamic> stackData,
    WidgetRef ref, String buyerSellerType) async {
  final pdf = Document();
  int index = 0;
  final img = await rootBundle.load('assets/images/user_logo.png');
  final imageBytes = img.buffer.asUint8List();
  Image image1 = Image(MemoryImage(imageBytes), width: 20, height: 20);
  num totalBags = 0;
  num totalWeight = 0;
  num totalLabour = 0;
  num agCommission = 0;

  num totalPrice = 0;
  num totalGstAmount = 0;

  num dealAmount = 0;

  num netAmount = 0;
  num totalRentAmount = 0;
  num totalLoanAmount = 0;
  num totalInterestAmount = 0;

  num totalPenalAmount = 0;
  num settlementAmount = 0;
  agCommission = num.parse("${stackData['data']['ag_commisssion_amt'] ?? 0}");
  totalRentAmount = num.parse("${stackData['data']['idle_time_rent'] ?? 0}") +
      num.parse("${stackData['data']['idle_capacity_rent'] ?? 0}");

  if (stackData['data']['buy_sell_data']!.length == 1) {
    for (int i = 0; i < stackData['data']['buy_sell_data']!.length; i++) {
      totalBags =
          num.parse("${stackData['data']['buy_sell_data']![i]['bags'] ?? 0}");

      totalWeight =
          num.parse("${stackData['data']['buy_sell_data']![i]['qty'] ?? 0}");

      settlementAmount = num.parse(
          "${stackData['data']['buy_sell_data']![i]['settlement_amt'] ?? 0}");
      totalPrice = (num.parse(
                  "${stackData['data']['buy_sell_data']![i]['price'] ?? 0}") *
              num.parse(
                  "${stackData['data']['buy_sell_data']![i]['qty'] ?? 0}")) -
          num.parse(
              "${stackData['data']['buy_sell_data']![i]['ag_commission'] ?? 0}");

      dealAmount =
          (num.parse("${stackData['data']['buy_sell_data']![i]['qty'] ?? 0}") *
              num.parse("${stackData['data']['price'] ?? 0}"));

      totalLoanAmount = num.parse(
          "${stackData['data']['buy_sell_data']![i]['loan_amt'] ?? 0}");
      totalInterestAmount = num.parse(
          "${stackData['data']['buy_sell_data']![i]['intrest_amt'] ?? 0}");

      totalPenalAmount = num.parse(
          "${stackData['data']['buy_sell_data']![i]['penal_intrest'] ?? 0}");
    }
  } else {
    for (int i = 0; i < stackData['data']['buy_sell_data']!.length; i++) {
      totalBags +=
          num.parse("${stackData['data']['buy_sell_data']![i]['bags'] ?? 0}");

      totalWeight +=
          num.parse("${stackData['data']['buy_sell_data']![i]['qty'] ?? 0}");

      settlementAmount += num.parse(
          "${stackData['data']['buy_sell_data']![i]['settlement_amt'] ?? 0}");
      totalPrice += (num.parse(
                  "${stackData['data']['buy_sell_data']![i]['price'] ?? 0}") *
              num.parse(
                  "${stackData['data']['buy_sell_data']![i]['qty'] ?? 0}")) -
          num.parse(
              "${stackData['data']['buy_sell_data']![i]['ag_commission'] ?? 0}");

      dealAmount +=
          (num.parse("${stackData['data']['buy_sell_data']![i]['qty'] ?? 0}") *
              num.parse("${stackData['data']['price'] ?? 0}"));

      totalLoanAmount += num.parse(
          "${stackData['data']['buy_sell_data']![i]['loan_amt'] ?? 0}");

      totalInterestAmount += num.parse(
          "${stackData['data']['buy_sell_data']![i]['intrest_amt'] ?? 0}");

      totalPenalAmount += num.parse(
          "${stackData['data']['buy_sell_data']![i]['penal_intrest'] ?? 0}");
    }
  }
  settlementAmount = dealAmount - agCommission - totalRentAmount;
  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      header: (context) => Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [image1, Text("Apna Godam")]),
            Container(
              alignment: Alignment.topCenter,
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, top: 5, bottom: 5),
              decoration:
                  BoxDecoration(border: Border.all(color: PdfColors.black)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Name: ${ref.watch(sharedUtilityProvider).getUser()?.fname ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Address: ${ref.watch(sharedUtilityProvider).getUser()?.address ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "City: ${ref.watch(sharedUtilityProvider).getUser()?.city ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "State: ${ref.watch(sharedUtilityProvider).getUser()?.state ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Phone: ${ref.watch(sharedUtilityProvider).getUser()?.phone ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Email: ${ref.watch(sharedUtilityProvider).getUser()?.email ?? ""}",
                        style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            )
          ])),
          Expanded(
              child: Container(
            height: 150,
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 15, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Commodity: ${stackData['data']['commodity']}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Buyer Name: ${stackData['data']['buyer_name']}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Rate: ${stackData['data']['price']} rs./Qtl.",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Seller Name: ${stackData['data']['seller_name']}",
                      style: TextStyle(fontSize: 10)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Quantity: ${stackData['data']['quantity']}(Qtl.)",
                      style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          )),
          SizedBox(height: 10),
        ]),
        SizedBox(height: 40),
        Text(
            'Stack ${buyerSellerType == "buy" ? "Buyer" : "Seller"} Contract Note',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        Text('Deal ID - ${stackData['data']['order_id']}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 40),
      ]),
      build: (context) => <Widget>[
        Table(border: TableBorder.all(color: PdfColors.black), children: [
          TableRow(
              decoration: BoxDecoration(
                  color: PdfColors.black,
                  border: Border.all(color: PdfColors.black)),
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Expanded(
                    child: Text("S.no",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Gatepass",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Weight(Qtl.)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Bags",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Deal Amount",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Loan Amount",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Interest Amount",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Penal Interest Amount",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Total Amount",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: PdfColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold))),
              ]),
          ...stackData['data']['buy_sell_data'].map((e) {
            index++;
            return TableRow(children: [
              Expanded(
                  child: Text("$index",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e['gatepass']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e['qty']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text("${e['bags']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      (num.parse("${e['qty'] ?? 0}") *
                              num.parse("${stackData['data']['price'] ?? 0}"))
                          .toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      num.parse("${e['loan_amt'] ?? 0}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      num.parse("${e['intrest_amt'] ?? 0}").toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      num.parse("${e['penal_intrest'] ?? 0}")
                          .toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
              Expanded(
                  child: Text(
                      ((num.parse("${e['qty'] ?? 0}") *
                                  num.parse(
                                      "${stackData['data']['price'] ?? 0}")) -
                              num.parse("${e['settlement_amt'] ?? 0}"))
                          .toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10))),
            ]);
          })
        ]),
        Table(border: TableBorder.all(color: PdfColors.black), children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Expanded(
                    child: Text("AG Commission",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("-${agCommission.toStringAsFixed(2)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Expanded(
                    child: Text("Rent Amount",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("--",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("-${totalRentAmount.toStringAsFixed(2)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold))),
              ]),
        ]),
        Table(border: TableBorder.all(color: PdfColors.black), children: [
          TableRow(
            decoration: BoxDecoration(
                color: PdfColors.black,
                border: Border.all(color: PdfColors.black)),
            verticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              Expanded(
                  child: Text("Total",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text("--",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text("$totalWeight",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text("$totalBags",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text(totalPrice.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text(totalLoanAmount.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text(totalInterestAmount.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text(totalInterestAmount.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text(settlementAmount.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold))),
            ],
          ),
        ]),
      ],
    ),
  );
  final output = await getApplicationSupportDirectory();

  final file = File('${output.path}/stack_contract_note_seller.pdf');
  if (file.existsSync()) {
    file.deleteSync();
  }
  await file.writeAsBytes(await pdf.save());

  // Open the generated PDF using a package like `open_file`
  // Make sure to add the open_file package to your pubspec.yaml
  return file;
}

Future<File?> buyerSbtsettlementPdf(SbtBuyerContractModel invoice,
    String opening, String closing, WidgetRef ref) async {
  final pdf = Document();
  int index = 0;
  final img = await rootBundle.load('assets/images/user_logo.png');
  final imageBytes = img.buffer.asUint8List();
  Image image1 = Image(MemoryImage(imageBytes), width: 20, height: 20);

  num defaultQty = num.parse("${invoice.data?.defaultQty ?? 0}");
  num totalBags = 0;
  num totalWeight = 0;
  num agComission = 0;
  num netAmount = 0;

  if (invoice.data!.buySellData!.length == 1) {
    for (int i = 0; i < invoice.data!.buySellData!.length; i++) {
      totalBags = num.parse("${invoice.data!.buySellData![i].bags ?? 0}");

      totalWeight = num.parse("${invoice.data!.buySellData![i].qty ?? 0}");
      agComission =
          num.parse("${invoice.data!.buySellData![i].agCommisison ?? 0}");

      netAmount = num.parse("${invoice.data!.buySellData![i].netAmount ?? 0}");
    }
  } else {
    for (int i = 0; i < invoice.data!.buySellData!.length; i++) {
      totalBags += num.parse("${invoice.data!.buySellData![i].bags ?? 0}");

      totalWeight += num.parse("${invoice.data!.buySellData![i].qty ?? 0}");
      agComission +=
          num.parse("${invoice.data!.buySellData![i].agCommisison ?? 0}");

      netAmount += num.parse("${invoice.data!.buySellData![i].netAmount ?? 0}");
    }
  }
  totalWeight = totalWeight + defaultQty;
  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a3,
      header: (context) => Column(children: [
        SizedBox(height: 40),
        Text('Confirmed Order Settlement Report -',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21)),
        SizedBox(height: 10),
        Text('Deal ID - ${invoice.data?.orderId}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text('Order Matching Date ${invoice.data?.orderMatchDate}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        Text('Expiry Date ${invoice.data?.expiryDate}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('MTP Sale',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text('Commodity: ${invoice.data?.commodity}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Buyer Name: ${invoice.data?.buyerName}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text('Rate (in Rs.): ${invoice.data?.price}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Seller Name: ${invoice.data?.sellerName}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text('Quantity(Qtl.): ${invoice.data?.quantity}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Funds Lein: ${invoice.data?.loanType}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text('Delivery Days: ${invoice.data?.deliveryDays}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ],
        ),
        SizedBox(height: 20),
      ]),
      build: (context) => <Widget>[
        Table(border: TableBorder.all(color: PdfColors.black), children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                Expanded(
                    child: Text("S.no",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Delivery Date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Gatepass",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Delivery Centre",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Bags",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Weight(qtl.)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Ag Commission (in Rs.)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Net Amount (in Rs.)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))),
              ]),
          ...invoice.data!.buySellData!.map((e) {
            index++;
            return TableRow(children: [
              Expanded(
                  child: Text("$index",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17))),
              Expanded(
                  child: Text("${e.date}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17))),
              Expanded(
                  child: Text("${e.gatepass}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17))),
              Expanded(
                  child: Text("${e.warehouseName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17))),
              Expanded(
                  child: Text("${e.bags}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17))),
              Expanded(
                  child: Text("${e.qty}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17))),
              Expanded(
                  child: Text("${e.agCommisison}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17))),
              Expanded(
                  child: Text("${e.netAmount}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17))),
            ]);
          })
        ]),
      ],
    ),
  );
  final output = await getApplicationSupportDirectory();

  final file = File('${output.path}/settlement_report.pdf');

  if (file.existsSync()) {
    file.deleteSync();
  }
  await file.writeAsBytes(await pdf.save());

  // Open the generated PDF using a package like `open_file`
  // Make sure to add the open_file package to your pubspec.yaml
  return file;
}

// Generate invoice contract note PDF
Future<File?> invoiceContractNotePdf(
    BuildContext flutterContext, dynamic invoicePdfData, WidgetRef ref) async {
  final pdf = Document();
  final img = await rootBundle.load('assets/images/user_logo.png');
  final imageBytes = img.buffer.asUint8List();
  Image image1 = Image(MemoryImage(imageBytes), width: 20, height: 20);

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      build: (Context context) {
        return Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with logo and title
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1)),
                  color: PdfColors.grey300,
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      image1,
                      SizedBox(width: 10),
                      Text("Apna Godam",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ]),
                    Text(
                      AppLocalizations.of(flutterContext)!.taxInvoice,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Invoice details
              Container(
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Invoice No: ${invoicePdfData.invoiceNumber ?? 'N/A'}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                              maxLines: 1,
                              overflow: TextOverflow.clip),
                          SizedBox(height: 5),
                          Text("Date: ${invoicePdfData.date ?? 'N/A'}",
                              style: TextStyle(fontSize: 9)),
                          SizedBox(height: 5),
                          Text("Type: ${invoicePdfData.type ?? 'N/A'}",
                              style: TextStyle(fontSize: 9)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              "Commodity: ${invoicePdfData.commodityName ?? 'N/A'}",
                              style: TextStyle(fontSize: 9),
                              textAlign: TextAlign.right,
                              maxLines: 2),
                          SizedBox(height: 5),
                          Text(
                              "HSN Code: ${invoicePdfData.hsnCode ?? invoicePdfData.dummyHsn ?? 'N/A'}",
                              style: TextStyle(fontSize: 9),
                              textAlign: TextAlign.right),
                          SizedBox(height: 5),
                          Text(
                              "Address: ${invoicePdfData.termsOfDelivery ?? 'N/A'}",
                              style: TextStyle(fontSize: 9),
                              textAlign: TextAlign.right,
                              maxLines: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Seller and Buyer Details
              Row(
                children: [
                  // Seller Details
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 0.5),
                            bottom: BorderSide(width: 1)),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(flutterContext)!
                                  .sellerDetails,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          SizedBox(height: 5),
                          Text("${invoicePdfData.sellerName ?? 'N/A'}",
                              style: TextStyle(fontSize: 10), maxLines: 2),
                          SizedBox(height: 3),
                          Text("${invoicePdfData.sellerAddress ?? 'N/A'}",
                              style: TextStyle(fontSize: 9), maxLines: 3),
                          SizedBox(height: 3),
                          Text(
                              "${invoicePdfData.sellerDistrict ?? ''}, ${invoicePdfData.sellerState ?? ''} - ${invoicePdfData.sellerPincode ?? ''}",
                              style: TextStyle(fontSize: 9),
                              maxLines: 2),
                          SizedBox(height: 3),
                          Text("GST: ${invoicePdfData.sellerGst ?? 'N/A'}",
                              style: TextStyle(fontSize: 9), maxLines: 1),
                          SizedBox(height: 3),
                          Text(
                              "State Code: ${invoicePdfData.sellerStateCode ?? 'N/A'}",
                              style: TextStyle(fontSize: 9)),
                          if (invoicePdfData.sellerEmail != null &&
                              invoicePdfData.sellerEmail.toString().isNotEmpty)
                            Text("Email: ${invoicePdfData.sellerEmail}",
                                style: TextStyle(fontSize: 9),
                                maxLines: 1,
                                overflow: TextOverflow.clip),
                        ],
                      ),
                    ),
                  ),
                  // Buyer Details
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1)),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(flutterContext)!.buyerDetails,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          SizedBox(height: 5),
                          Text("${invoicePdfData.buyerName ?? 'N/A'}",
                              style: TextStyle(fontSize: 10), maxLines: 2),
                          SizedBox(height: 3),
                          Text("${invoicePdfData.buyerAddress ?? 'N/A'}",
                              style: TextStyle(fontSize: 9), maxLines: 3),
                          SizedBox(height: 3),
                          Text(
                              "${invoicePdfData.buyerDistrict ?? ''}, ${invoicePdfData.buyerState ?? ''} - ${invoicePdfData.buyerPincode ?? ''}",
                              style: TextStyle(fontSize: 9),
                              maxLines: 2),
                          SizedBox(height: 3),
                          Text("GST: ${invoicePdfData.buyerGst ?? 'N/A'}",
                              style: TextStyle(fontSize: 9), maxLines: 1),
                          SizedBox(height: 3),
                          Text(
                              "State Code: ${invoicePdfData.buyerStateCode ?? 'N/A'}",
                              style: TextStyle(fontSize: 9)),
                          if (invoicePdfData.buyerEmail != null &&
                              invoicePdfData.buyerEmail.toString().isNotEmpty)
                            Text("Email: ${invoicePdfData.buyerEmail}",
                                style: TextStyle(fontSize: 9),
                                maxLines: 1,
                                overflow: TextOverflow.clip),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Item Details Table
              Container(
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: PdfColors.grey300),
                      children: [
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                                AppLocalizations.of(flutterContext)!
                                    .description,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10))),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                                AppLocalizations.of(flutterContext)!
                                    .msgQuantity,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10))),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                                AppLocalizations.of(flutterContext)!.rate,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10))),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                                AppLocalizations.of(flutterContext)!
                                    .paymentAmount,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10))),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                                "${invoicePdfData.commodityName ?? 'N/A'}",
                                style: TextStyle(fontSize: 9),
                                maxLines: 2)),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("${invoicePdfData.quantity ?? '0'}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 9))),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("${invoicePdfData.rate ?? '0'}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 9))),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("${invoicePdfData.amount ?? '0'}",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 9))),
                      ],
                    ),
                  ],
                ),
              ),

              // Tax Details and Total
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(flutterContext)!.paymentAmount,
                            style: TextStyle(fontSize: 10)),
                        Text("${invoicePdfData.amount ?? '0'}",
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    if (invoicePdfData.cgst != null &&
                        invoicePdfData.cgst.toString() != '0')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(flutterContext)!.cgst,
                              style: TextStyle(fontSize: 10)),
                          Text("${invoicePdfData.cgst}",
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    if (invoicePdfData.sgst != null &&
                        invoicePdfData.sgst.toString() != '0')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(flutterContext)!.sgst,
                              style: TextStyle(fontSize: 10)),
                          Text("${invoicePdfData.sgst}",
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    if (invoicePdfData.igst != null &&
                        invoicePdfData.igst.toString() != '0')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(flutterContext)!.igst,
                              style: TextStyle(fontSize: 10)),
                          Text("${invoicePdfData.igst}",
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            AppLocalizations.of(flutterContext)!
                                .totalSettlement,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(
                            num.parse(
                                    "${invoicePdfData.totalSettlement ?? '0'}")
                                .toStringAsFixed(2),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),

              Spacer(),

              // Footer
              Container(
                decoration:
                    BoxDecoration(border: Border(top: BorderSide(width: 1))),
                padding: EdgeInsets.all(10),
                child: Text(
                  AppLocalizations.of(flutterContext)!.computerGeneratedInvoice,
                  style: TextStyle(fontSize: 8, color: PdfColors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File(
      '${output.path}/invoice_contract_note_${invoicePdfData.invoiceNumber ?? 'document'}.pdf');
  if (file.existsSync()) {
    file.deleteSync();
  }
  await file.writeAsBytes(await pdf.save());
  return file;
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );

//6673

//6673
