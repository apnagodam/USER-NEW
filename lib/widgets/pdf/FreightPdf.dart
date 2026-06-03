import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'FreightPdf.g.dart';

@riverpod
Future<File?> createFreightPdf(CreateFreightPdfRef ref,
    {required BuildContext context}) async {
  final pdf = pw.Document();
  final img = await rootBundle.load('assets/logo.png');
  final imageBytes = img.buffer.asUint8List();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a3,
      build: (pw.Context buildContext) {
        return pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Column(children: [
            pw.Container(
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                padding: pw.EdgeInsets.all(20),
                child: pw.Row(children: [
                  pw.Image(pw.MemoryImage(imageBytes), height: 25, width: 25),
                  pw.Text('Generated On Apna Godam Portal '),
                  pw.Expanded(
                      child: pw.Center(
                          child: pw.Text("Tax Invoice - Freight",
                              style: pw.TextStyle(
                                  fontSize: Adaptive.sp(20),
                                  fontWeight: pw.FontWeight.bold))))
                ]),
                alignment: pw.Alignment.center),
            pw.Container(
                height: MediaQuery.of(context).size.height / 1.9,
                child: pw.Row(children: [
                  pw.Expanded(
                      child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                              child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            padding: pw.EdgeInsets.all(20),
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Issued By : ',
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                  pw.Text("Ramkaran",
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                  pw.Text(
                                      'Gila Ki Dhani - Bajiya Wali Talai Road,\nSikar',
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                  pw.Text('GSTIN/UIN : 08HJUPS4093H1Z8',
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                  pw.Text('PAN/IT No. : BPIFC5940R',
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                  pw.Text('State Name : Rajasthan',
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                ]),
                          )),
                          pw.Expanded(
                              child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            padding: pw.EdgeInsets.all(20),
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Issued To : ',
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                  pw.Text("Ramkaran",
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                  pw.Text(
                                      'Gila Ki Dhani - Bajiya Wali Talai Road,\nSikar',
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                  pw.Text('GSTIN/UIN : 08HJUPS4093H1Z8',
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                  // pw.Text('PAN/IT No. : BPIFC5940R',
                                  //     style: pw.TextStyle(
                                  //       fontSize: Adaptive.sp(16),
                                  //       fontWeight: pw.FontWeight.normal,
                                  //     ),
                                  //     textAlign: pw.TextAlign.start),
                                  pw.Text('State Name : Rajasthan',
                                      style: pw.TextStyle(
                                        fontSize: Adaptive.sp(16),
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                      textAlign: pw.TextAlign.start),
                                ]),
                          )),
                        ]),
                  )),
                  pw.Expanded(
                      child: pw.Container(
                    alignment: pw.Alignment.topCenter,
                    child: pw.Column(children: [
                      pw.Expanded(
                          child: pw.Container(
                              child: pw.Column(children: [
                        pw.Padding(
                            padding: pw.EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: pw.Row(children: [
                              pw.Expanded(
                                  child: pw.Container(
                                      child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                    pw.Container(
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                          pw.Text("Invoice No.",
                                              style: pw.TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight:
                                                    pw.FontWeight.normal,
                                              ),
                                              textAlign: pw.TextAlign.start),
                                        ])),
                                    pw.Container(
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                          pw.Text("12345",
                                              style: pw.TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                              textAlign: pw.TextAlign.start),
                                        ])),
                                  ]))),
                              pw.Expanded(child: pw.VerticalDivider()),
                              pw.Container(
                                  child: pw.Column(children: [
                                pw.Container(
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                      pw.Text("Date of Settlement",
                                          style: pw.TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: pw.FontWeight.normal,
                                          ),
                                          textAlign: pw.TextAlign.start),
                                    ])),
                                pw.Container(
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                      pw.Text("27-08-2024",
                                          style: pw.TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                          textAlign: pw.TextAlign.start),
                                    ])),
                              ]))
                            ])),
                        pw.Divider(),
                        pw.Padding(
                            padding: pw.EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: pw.Row(children: [
                              pw.Expanded(
                                  child: pw.Container(
                                      child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                    pw.Container(
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                          pw.Text("Motor Vechicle No. :",
                                              style: pw.TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight:
                                                    pw.FontWeight.normal,
                                              ),
                                              textAlign: pw.TextAlign.start),
                                        ])),
                                    pw.Container(
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                          pw.Text("RJ14BT3060",
                                              style: pw.TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                              textAlign: pw.TextAlign.start),
                                        ])),
                                  ]))),
                              pw.Container(
                                  child: pw.Column(children: [
                                pw.Container(
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                      pw.Text("Credit/Cash :",
                                          style: pw.TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: pw.FontWeight.normal,
                                          ),
                                          textAlign: pw.TextAlign.start),
                                    ])),
                                pw.Container(
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                      pw.Text("Credit",
                                          style: pw.TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                          textAlign: pw.TextAlign.start),
                                    ])),
                              ]))
                            ])),
                        pw.Divider(),
                        pw.Padding(
                            padding: pw.EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: pw.Row(children: [
                              pw.Expanded(
                                  child: pw.Container(
                                      child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                    pw.Container(
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                          pw.Text("Billty NO :",
                                              style: pw.TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight:
                                                    pw.FontWeight.normal,
                                              ),
                                              textAlign: pw.TextAlign.start),
                                        ])),
                                    pw.Container(
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                          pw.Text("1003",
                                              style: pw.TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                              textAlign: pw.TextAlign.start),
                                        ])),
                                  ]))),
                              pw.Container(
                                  child: pw.Column(children: [
                                pw.Container(
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                      pw.Text("Billty Date : ",
                                          style: pw.TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: pw.FontWeight.normal,
                                          ),
                                          textAlign: pw.TextAlign.start),
                                    ])),
                                pw.Container(
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                      pw.Text("28/08/2024",
                                          style: pw.TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                          textAlign: pw.TextAlign.start),
                                    ])),
                              ]))
                            ])),
                        pw.Divider(),
                        pw.Padding(
                            padding: pw.EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: pw.Row(children: [
                              pw.Expanded(
                                  child: pw.Container(
                                      child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                    pw.Container(
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                          pw.Text("Place Of Suppply :",
                                              style: pw.TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight:
                                                    pw.FontWeight.normal,
                                              ),
                                              textAlign: pw.TextAlign.start),
                                        ])),
                                    pw.Container(
                                        child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                          pw.Text(
                                              "Netaji Subhash Marg, Chandni Chowk, New Delhi",
                                              style: pw.TextStyle(
                                                fontSize: Adaptive.sp(16),
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                              textAlign: pw.TextAlign.start),
                                        ])),
                                  ]))),
                              pw.Container(
                                  child: pw.Column(children: [
                                pw.Container(
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                      pw.Text("Motor Vechicle No. :",
                                          style: pw.TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: pw.FontWeight.normal,
                                          ),
                                          textAlign: pw.TextAlign.start),
                                    ])),
                                pw.Container(
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                      pw.Text("RJ14BT3060",
                                          style: pw.TextStyle(
                                            fontSize: Adaptive.sp(16),
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                          textAlign: pw.TextAlign.start),
                                    ])),
                              ]))
                            ])),
                        pw.Divider(),
                      ]))),
                    ]),
                  )),
                ])),
            pw.Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: pw.Column(children: [
                  pw.Row(children: [
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Description of Goods ",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Weight (QTL.) ",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Rate (PER QTL.) ",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        padding: pw.EdgeInsets.all(5),
                        alignment: pw.Alignment.center,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("HSN",
                            style: pw.TextStyle(
                              fontSize: Adaptive.sp(16),
                              fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center),
                      ),
                    ),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("AMOUNT (INR.)",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                  ]),
                  pw.Expanded(
                      child: pw.Container(
                          child: pw.Row(children: [
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text("Groundnut Sikai ",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.start),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          padding: pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Weight (QTL.) ",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.start),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          padding: pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Rate (PER QTL.) ",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.start),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          padding: pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("1202",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.start),
                        )),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          padding: pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("AMOUNT (INR.)",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.start),
                        )),
                  ]))),
                  pw.Row(children: [
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(20),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Extra Charge",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(20),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("7300",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                  ]),
                  pw.Row(children: [
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(20),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Deduction",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(20),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("80300",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                  ]),
                  pw.Row(children: [
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Total",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("80300",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                  ]),
                  pw.Row(children: [
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Advance",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("80300",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                  ]),
                  pw.Row(children: [
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Balance",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.normal,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                    pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(5),
                          alignment: pw.Alignment.center,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("80300",
                              style: pw.TextStyle(
                                fontSize: Adaptive.sp(16),
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        )),
                  ]),
                  pw.Container(
                      height: 180,
                      child: pw.Row(children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              padding: pw.EdgeInsets.all(5),
                              alignment: pw.Alignment.centerLeft,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("Amount Chargeable (in words)",
                                        style: pw.TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: pw.FontWeight.normal,
                                        ),
                                        textAlign: pw.TextAlign.center),
                                    pw.Text(
                                        "Eighty Thousands Three Hundred Rupees Only",
                                        style: pw.TextStyle(
                                          fontSize: Adaptive.sp(16),
                                          fontWeight: pw.FontWeight.normal,
                                        ),
                                        textAlign: pw.TextAlign.center)
                                  ]),
                            )),
                        pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              alignment: pw.Alignment.center,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Expanded(
                                        child: pw.Container(
                                      alignment: pw.Alignment.centerLeft,
                                      padding: pw.EdgeInsets.all(5),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all()),
                                      child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text("Company's Bank Details",
                                                style: pw.TextStyle(
                                                  fontSize: Adaptive.sp(16),
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                ),
                                                textAlign: pw.TextAlign.center),
                                            pw.Text(
                                                "A/c Holder's Name : Chirag Logistics Pvt. Ltd.",
                                                style: pw.TextStyle(
                                                  fontSize: Adaptive.sp(16),
                                                  fontWeight:
                                                      pw.FontWeight.normal,
                                                ),
                                                textAlign: pw.TextAlign.center),
                                            pw.Text(
                                                "Bank Name : HDFC Bank Ltd.",
                                                style: pw.TextStyle(
                                                  fontSize: Adaptive.sp(16),
                                                  fontWeight:
                                                      pw.FontWeight.normal,
                                                ),
                                                textAlign: pw.TextAlign.center),
                                            pw.Text(
                                                "A/c No : 54354643643346446",
                                                style: pw.TextStyle(
                                                  fontSize: Adaptive.sp(16),
                                                  fontWeight:
                                                      pw.FontWeight.normal,
                                                ),
                                                textAlign: pw.TextAlign.center),
                                            pw.Text("Branch : VKI Area Jaipur",
                                                style: pw.TextStyle(
                                                  fontSize: Adaptive.sp(16),
                                                  fontWeight:
                                                      pw.FontWeight.normal,
                                                ),
                                                textAlign: pw.TextAlign.center),
                                            pw.Text("IFSC Code : HDFCC0003774",
                                                style: pw.TextStyle(
                                                  fontSize: Adaptive.sp(16),
                                                  fontWeight:
                                                      pw.FontWeight.normal,
                                                ),
                                                textAlign: pw.TextAlign.center)
                                          ]),
                                    )),
                                    pw.Expanded(
                                        child: pw.Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: pw.EdgeInsets.all(5),
                                      alignment: pw.Alignment.centerLeft,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all()),
                                      child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Expanded(child: pw.SizedBox()),
                                            pw.Expanded(
                                                child: pw.Text("Digital Sign",
                                                    style: pw.TextStyle(
                                                      fontSize: Adaptive.sp(16),
                                                      fontWeight:
                                                          pw.FontWeight.normal,
                                                    ),
                                                    textAlign:
                                                        pw.TextAlign.center)),
                                            pw.Expanded(
                                                child: pw.Text(
                                                    "Authorised Signatory",
                                                    style: pw.TextStyle(
                                                      fontSize: Adaptive.sp(16),
                                                      fontWeight:
                                                          pw.FontWeight.normal,
                                                    ),
                                                    textAlign:
                                                        pw.TextAlign.center))
                                          ]),
                                    )),
                                  ]),
                            ))
                      ]))
                ]))
          ]),
        ); // Center
      }));
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

  var filePath = '${appDocumentsDir.path}/agreement.pdf';
  var file = File(filePath);
  await file.writeAsBytes(await pdf.save());

  //context.goNamed(RoutesStrings.profile);

  return file;
}
