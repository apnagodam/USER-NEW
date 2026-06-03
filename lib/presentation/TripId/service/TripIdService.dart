import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/presentation/TripId/model/PoModel.dart';
import 'package:apnagodam/presentation/TripId/model/TripIdTransporterModel.dart';
import 'package:apnagodam/presentation/TripId/model/TripRequestsModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/widgets/pdf/BiltyResponseModel.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';

part 'TripIdService.g.dart';

@riverpod
Stream<TripTransporterModel> tripTransporterList(
    TripTransporterListRef ref) async* {
  var response = await ref.watch(dioProvider).get(getTransporterList);
  yield tripTransporterModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<TripRequestsModel> tripRequests(TripRequestsRef ref) async* {
  var response = await ref.watch(dioProvider).get(getTripRequests);
  yield tripRequestsModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<PoModel> poList(PoListRef ref,
    {String? terminaId, String? commodityId}) async* {
  var response = await ref.watch(dioProvider).get(getPO,
      queryParameters: {'terminal': terminaId, 'commodity': commodityId});
  yield poModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<BiltyResponseData> biltyData(BiltyDataRef ref, {String? tripId}) async {
  var response = await ref
      .watch(dioProvider)
      .get(getBiltyData, queryParameters: {'trip_request_id': tripId});
  return biltyResponseDataFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> createTripid(CreateTripidRef ref,
    {String? source,
    String? fromAddress,
    String? fromPinCode,
    String? fromTerminalId,
    String? to,
    String? toAddress,
    String? toPincode,
    String? toTerminalId,
    String? poId,
    String? commodityId,
    String? transporterId,
    String? rate,
    String? advanceAmount,
    String? paymentTo,
    String? consigneeName,
    String? consigneeNumber,
    String? landmark}) async {
  var response =
      await ref.watch(dioProvider).post(tripidRequestCreate, queryParameters: {
    'from': source,
    // from 1 For from Address And 2 For Warehouse
    'from_address': fromAddress,
    // from 1 h to address aayga  from 2 to h to null
    'from_pincode': fromPinCode,
    // from 1 h to pincode aayga  from 2 to h to null
    'from_warehouse_id': fromTerminalId,
    // from 2 k case m terminal id aaygi from 1 to h to null
    'to': to,
    // to 1 For to Address And 2 For to Warehouse
    'to_address': toAddress,
    // to 1 h to address aayga  to 2 to h to null
    'to_pincode': toPincode,
    // to 1 h to pincode aayga to 2 k case m null
    'to_warehouse_id': toTerminalId,
    // to 2 k case m warehouse id aaygi to 1 k case m null
    'po_id': poId,
    // autoinvoiceing yes h to po id aaygi (api number 6 se )
    'commodity_id': commodityId,
    // required
    'transport_id': transporterId,
    // required
    'rate': rate,
    // required
    'advance_amt': advanceAmount,
    // required
    'payment_to': paymentTo,
    // 1 for driver 2 transporter
    'consignee_name': consigneeName,
    //
    'consignee_number': consigneeNumber,
    //
    'landmark': landmark,
    //
  });
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> updateTripId(
  UpdateTripIdRef ref, {
  String? requestId,
  String? weight,
  String? noOfBags,
  File? kantaParchiImage,
  File? invoiceImage,
  File? eWayBillImage,
  File? mandiTaxDocuments,
  File? qualityReportImage,
}) async {
  FormData formData = FormData.fromMap({
    "request_id": requestId,
    'weight': weight,
    "no_of_bags": noOfBags,
    if (kantaParchiImage != null)
      'kanta_parchi': await MultipartFile.fromFile(
        kantaParchiImage.path ?? "",
        filename: 'kantaParchiImage.png',
        contentType: DioMediaType("media", "png"),
      ),
    if (invoiceImage != null)
      'invoice': await MultipartFile.fromFile(invoiceImage.path ?? "",
          contentType: DioMediaType("media", "png"), filename: 'invoice.png'),
    if (qualityReportImage != null)
      'quality_report': await MultipartFile.fromFile(
          qualityReportImage.path ?? "",
          contentType: DioMediaType("media", "png"),
          filename: 'qualityReport.png'),
    if (eWayBillImage != null)
      'e_way_bill': await MultipartFile.fromFile(eWayBillImage.path ?? "",
          contentType: DioMediaType("media", "png"), filename: 'eWayBill.png'),
    if (mandiTaxDocuments != null)
      'mandi_tax_document': await MultipartFile.fromFile(
          mandiTaxDocuments.path ?? "",
          contentType: DioMediaType("media", "png"),
          filename: 'mandiTaxDocument.png'),
  });
  var response =
      await ref.watch(dioProvider).post(tripIdUpdate, data: formData);
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> rejectTripRequest(
  RejectTripRequestRef ref, {
  String? id,
}) async {
  var response = await ref.watch(dioProvider).post(rejectTripId, data: {
    'id': id,
  });
  return response.data;
}
