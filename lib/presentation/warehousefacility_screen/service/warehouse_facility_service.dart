import 'dart:convert';

import 'package:apnagodam/presentation/dashboard/model/base_response_model.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/model/InwardsTerminalResponse.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/model/OutwardsListResponseModel.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/model/StackBookHistoryModel.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/model/TripIdModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/constants.dart';
import '../../my_Stock/my_stock_impl/service/my_stock_impl.dart';
import '../model/RateCardModel.dart';
import '../model/inward_list_model.dart';
import '../model/terminal_stack_data_model.dart';

part 'warehouse_facility_service.g.dart';

@riverpod
Future<TerminalStackDataModel> terminalStackData(TerminalStackDataRef ref,
    {String? terminalId = "",
    String? commodityId = "",
    String? weightReq = "",
    String? inOutStatus = "",
    String? stackType = "",
    String? vehicleNo = "",
    String? driverNumber = ""}) async {
  var response =
      await ref.watch(dioProvider).post(WAREHOUSE_TERMINAL_STACK, data: {
    'terminal_id': terminalId,
    'commodity_id': commodityId,
    'weight_reqst': weightReq,
    'in_out_status': inOutStatus,
    'stack_type': stackType,
    'vehicle_no': vehicleNo,
    'driver_number': driverNumber
  });
  return terminalStackDataModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<StackBookHistoryModel> stackBookHistory(
  Ref ref,
) async* {
  var response = await ref.watch(dioProvider).get(getWarehouseHistory);
  yield stackBookHistoryModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<TripIdModel> inwardTripIdList(InwardTripIdListRef ref,
    {String? terminal, String? commodity}) async {
  var response = await ref.watch(dioProvider).post(getInwardTripList,
      data: {'terminal': terminal, 'commodity': commodity});
  return tripIdModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<TripIdModel> outwardTripIdList(OutwardTripIdListRef ref,
    {String? terminal, String? commodity}) async {
  var response = await ref.watch(dioProvider).post(getOutwardTripList,
      data: {'terminal': terminal, 'commodity': commodity});
  return tripIdModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<BaseResponseModel> createStackRequest(CreateStackRequestRef ref,
    {String? stackType = '',
    String? requestWeight = '',
    String? inOutStatus = '',
    String? stackNum = '',
    String? stackRowId = '',
    String? commodityId = '',
    String? vhicalNo = '',
    String? lockInMonth = '',
    String? warehouseRent = '',
    String? driverNumber = '',
    String? releaseInv = '',
    String? releaseBags = '',
    String? transporterType,
    String? tripId}) async {
  var response =
      await ref.watch(dioProvider).post(APANA_CREATE_STACK_REQUEST, data: {
    'stack_type': stackType,
    'request_weight': requestWeight,
    'in_out_status': inOutStatus,
    'stack_number': stackNum,
    'stack_rowId': stackRowId.toString(),
    'commodity_id': commodityId,
    'vehicle_no': vhicalNo,
    'commodity_arrival_date': lockInMonth,
    'warehouse_rent': warehouseRent,
    'driver_number': driverNumber,
    "transporter_type": transporterType,
    "trip_id": tripId
    // 'release_weight': releaseInv,
    // 'release_bags': releaseBags
  });
  return baseResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> createStackRequestOutwards(
    CreateStackRequestOutwardsRef ref,
    {String? stackType = '',
    String? requestWeight = '',
    String? inOutStatus = '',
    String? stackNum = '',
    String? stackRowId = '',
    String? commodityId = '',
    String? vhicalNo = '',
    String? lockInMonth = '',
    String? warehouseRent = '',
    String? driverNumber = '',
    String? releaseInv = '',
    String? releaseBags = '',
    String? transporterType,
    String? tripId,
    String? autoInvoicing,
    String? poIds}) async {
  var response =
      await ref.watch(dioProvider).post(createStackRequestOutward, data: {
    'stack_type': stackType,
    'request_weight': requestWeight,
    'in_out_status': inOutStatus,
    'stack_number': stackNum,
    'stack_rowId': stackRowId.toString(),
    'commodity_id': commodityId,
    'vehicle_no': vhicalNo,
    'commodity_arrival_date': lockInMonth,
    'warehouse_rent': warehouseRent,
    'driver_number': driverNumber,
    "transporter_type": transporterType,
    "trip_id": tripId,
    "auto_invoicing": autoInvoicing,
    "po_ids": poIds
    // 'release_weight': releaseInv,
    // 'release_bags': releaseBags
  });
  return response.data;
}

@riverpod
Stream<InwardsTerminalResponse> inwardsTerminal(InwardsTerminalRef ref,
    {String? terminalId = "",
    String? stackRequestId = "",
    String? commodityId}) async* {
  var response = await ref
      .watch(dioProvider)
      .post(APNA_U_GET_INWARDREQUEST, queryParameters: {
    "type": "Terminal",
    "terminal_id": terminalId,
    "stack_request_id": stackRequestId,
    "commodity": commodityId
  });
  yield inwardsTerminalResponseFromMap(jsonEncode(response.data));
}

@riverpod
Future<InwardsTerminalResponse> inwardsCommodity(InwardsCommodityRef ref,
    {String? terminalId = "",
    String? stackRequestId = "",
    String? commodityId}) async {
  var response = await ref
      .watch(dioProvider)
      .post(APNA_U_GET_INWARDREQUEST, queryParameters: {
    "type": "Terminal",
    "terminal_id": terminalId,
    "stack_request_id": stackRequestId,
    "commodity": commodityId
  });
  return inwardsTerminalResponseFromMap(jsonEncode(response.data));
}

@riverpod
Future<InwardsTerminalResponse> inwardsStack(InwardsStackRef ref,
    {String? terminalId = "",
    String? stackRequestId = "",
    String? commodityId}) async {
  var response = await ref
      .watch(dioProvider)
      .post(APNA_U_GET_INWARDREQUEST, queryParameters: {
    "type": "Terminal",
    "terminal_id": terminalId,
    "stack_request_id": stackRequestId,
    "commodity": commodityId
  });
  return inwardsTerminalResponseFromMap(jsonEncode(response.data));
}


// AFTER (Future)
@riverpod
Future<InwardsListModel> inwardsList(InwardsListRef ref) async {
  var response = await ref.watch(dioProvider).get(
      APANA_U_GET_INWORD_REQUEST_LIST,
      queryParameters: {'limit': 35, 'search': ''});
  return inwardsListModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<OutwardsListResponseModel> outwardsList(OutwardsListRef ref) async* {
  var response = await ref.watch(dioProvider).post(getOutwardsRequests);
  yield outwardsListResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<RateCardModel> rateCard(RateCardRef ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var response = await ref
      .watch(dioProvider)
      .get(GET_RATECARD_LASTID, queryParameters: {'limit': 35, 'search': ''});

  return rateCardModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> rejectOrder(RejectOrderRef ref,
    {String? orderId}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var response = await ref
      .watch(dioProvider)
      .get(APANA_U_REJECT_INWORD_REQUEST, queryParameters: {'id': orderId});
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> rejectOutwardsRequest(RejectOutwardsRequestRef ref,
    {String? id}) async {
  var response = await ref
      .watch(dioProvider)
      .post(rejectOutwardRequest, queryParameters: {'id': id});
  return response.data;
}
