import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/sbt/service/model/DispatchListingModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/MarkDeliveryRequestModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/MatchedOrdersModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/MatchOrderPrintModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/OrderInventoryModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/SbtContractListModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/SbtHoldListModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/SbtRequestListModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/SbtStacksListModel.dart';
import 'package:apnagodam/presentation/sbt/service/model/SbtTerminalsListModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'SbtService.g.dart';

@riverpod
Stream<SbtRequestListModel> sbtRequest(SbtRequestRef ref) async* {
  var response = await ref.watch(dioProvider).post(getSbtRequest);
  yield sbtRequestListModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<SbtHoldListModel> sbtHoldList(SbtHoldListRef ref,
    {String? walletType}) async* {
  var response = await ref
      .watch(dioProvider)
      .post(getSbtHoldList, queryParameters: {'wallet_type': walletType});
  yield sbtHoldListModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<SbtContractNoteModel> sbtContactNote(SbtContactNoteRef ref) async* {
  var response = await ref.watch(dioProvider).post(getSbtContractList);
  yield sbtContractNoteModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<MatchedOrdersModel> matchedOrders(MatchedOrdersRef ref) async* {
  var response = await ref.watch(dioProvider).post(getMatchedOrders);
  yield matchedOrdersModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<MatchOrderPrintModel> getMatchOrderPrintData(
    GetMatchOrderPrintDataRef ref,
    {required String orderId}) async {
  var response = await ref
      .watch(dioProvider)
      .post(getMatchOrderPrint, queryParameters: {'order_id': orderId});
  return matchOrderPrintModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<OrderInventoryModel> orderInventories(OrderInventoriesRef ref,
    {String? id, String? warehouseId, String? stackNo}) async* {
  var response = await ref.watch(dioProvider).post(getOrderInventories,
      queryParameters: {
        'id': id,
        'warehouse_id': warehouseId,
        'stack_no': stackNo
      });
  yield orderInventoryModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> markDelivery(MarkDeliveryRef ref,
    {required MarkDeliveryRequestModel model}) async {
 var response = await ref.read(dioProvider).post(
    postDelivery, data: {
    "order_deal_id": "${model.order_deal_id}",
    "inventory_id": model.inventory_id
  });
  return response.data;
}

@riverpod
Stream<SbtTerminalsListModel> sbtTerminalsList(Ref ref,
    {required String districtId}) async* {
  var response = await ref.watch(dioProvider).post(
      getDeliveryMarkingTerminalList,
      queryParameters: {'district_id': districtId});
  yield sbtTerminalsListModelFromJson(jsonEncode(response.data));
}

@riverpod
Stream<SbtStacksListModel> sbtStackList(Ref ref,
    {required String warehouseId, required String commodityId}) async* {
  var response = await ref.watch(dioProvider).post(getDeliveryMarkingStackList,
      queryParameters: {
        'warehouse_id': warehouseId,
        "commodity_id": commodityId
      });
  yield sbtStacksListModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> dispatchRequestNew(Ref ref,
    {String? states,
    String? district,
    String? location,
    String? pinCode,
    String? address,
    String? biltyNumber,
    String? sbtOrderId,
    String? mandiComplience,
    String? vehicleNo,
    String? salesStatus,
    String? stackNo,
    String? driverNo,
    String? transporterType,
    String? vehicleType,
    String? tripId,
    File? image}) async {
  final formData = FormData.fromMap({
    "states": states,
    "district": district,
    "location": location,
    "pin_code": pinCode,
    "address": address,
    "bilty_number": biltyNumber,
    "sbt_order_id": sbtOrderId,
    "mandi_compliance": mandiComplience,
    "vehicle_number": vehicleNo,
    "sales_status": salesStatus,
    "stack_number": stackNo,
    "driver_number": driverNo,
    "transport_type": transporterType,
    "vehicle_type": vehicleType,
    "trip_id": tripId,
    "image": image != null
        ? await MultipartFile.fromFile(image.path, filename: 'image')
        : "",
  });
  var response =
      await ref.watch(dioProvider).post(postDispatchRequest, data: formData);

  return response.data;
}

@riverpod
Future<Map<String, dynamic>> dispatchRequest(DispatchRequestRef ref,
    {var sbtOrderId,
    var weight,
    var vehicleNo,
    var vehicleType,
    var salesStatus,
    var commodityId,
    var terminalId,
    var stackNo,
    var driverNo,
    var transporterType,
    var tripId,
    File? biltyImage,
    File? kantaParchiImage,
    File? image,
    File? invoiceImage}) async {
  final formData = FormData.fromMap({
    "sbt_order_id": sbtOrderId,
    "weight": weight,
    "vehicle_number": vehicleNo,
    "vehicle_type": vehicleType,
    "sales_status": salesStatus,
    "commodity_id": commodityId,
    "terminal_id": terminalId,
    "stack_number": stackNo,
    "driver_number": driverNo,
    "transport_type": transporterType,
    "trip_id": tripId,
    "billty": biltyImage != null
        ? await MultipartFile.fromFile(biltyImage.path, filename: 'billty')
        : "",
    "kanta_parchi": kantaParchiImage != null
        ? await MultipartFile.fromFile(kantaParchiImage.path, filename: 'kanta')
        : "",
    "image": image != null
        ? await MultipartFile.fromFile(image.path, filename: 'image')
        : "",
    "invoice_image": invoiceImage != null
        ? await MultipartFile.fromFile(invoiceImage.path)
        : "",
  });
  var response =
      await ref.watch(dioProvider).post(postDispatchRequest, data: formData);

  return response.data;
}

@riverpod
Future<Map<String, dynamic>> deleteDispatchRequest(DeleteDispatchRequestRef ref,
    {String? id, required String sbtOrderId}) async {
  final formData = FormData.fromMap({"id": id, "order_id": sbtOrderId});
  var response =
      await ref.watch(dioProvider).post(rejectDispatchRequest, data: formData);
  ref.invalidate(dispatchListingNewProvider);
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> getAddress(Ref ref, {String? pinCode}) async {
  try {
    final formData = FormData.fromMap({"pincode": pinCode});
    var response =
        await ref.watch(dioProvider).post(addressFromPincode, data: formData);
    if (response.data is Map<String, dynamic>) {
      return response.data;
    }
    return {
      'status': '0',
      'message': 'Unable to fetch location. Please change the pincode.'
    };
  } catch (e) {
    return {
      'status': '0',
      'message': 'Unable to fetch location. Please change the pincode.'
    };
  }
}

@riverpod
Future<Map<String, dynamic>> editDispatchRequest(EditDispatchRequestRef ref,
    {String? id,
    File? grnImage,
    String? grnNumber,
    File? kantaParchiImage}) async {
  final formData = FormData.fromMap({
    "id": id,
    "grn_number": grnNumber,
    "grn_image": grnImage != null
        ? await MultipartFile.fromFile(grnImage.path, filename: 'grn')
        : "",
    "receving_kp_photo": kantaParchiImage != null
        ? await MultipartFile.fromFile(kantaParchiImage.path, filename: 'kanta')
        : "",
  });

  var response =
      await ref.watch(dioProvider).post(updateDispatchRequest, data: formData);
  if (response.data['status'].toString() == "1") {
    ref.invalidate(dispatchListingNewProvider);
    Fluttertoast.showToast(
        msg: response.data['message'].toString(),
        backgroundColor: ColorConstant.maingreen);
  } else {
    Fluttertoast.showToast(
        msg: response.data['message'].toString(),
        backgroundColor: ColorConstant.red500);
  }

  return response.data;
}

@riverpod
Stream<DispatchListingModel> dispatchListing(DispatchListingRef ref,
    {required String? sbtOrderId}) async* {
  var response = await ref.watch(dioProvider).post(getDispatchListingSBT,
      queryParameters: {'sbt_order_id': sbtOrderId});
  yield dispatchListingModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<String> getMatchOrderPdfHtml(GetMatchOrderPdfHtmlRef ref,
    {required String orderId}) async {
  var response = await ref
      .watch(dioProvider)
      .get(getMatchOrderPdf, queryParameters: {'order_id': orderId});
  // The API returns a URL to the PDF
  return response.data['url'] ??
      response.data['pdf_url'] ??
      response.data.toString();
}

@riverpod
Future<MatchOrderPrintModel> fetchMatchOrderPrint(FetchMatchOrderPrintRef ref,
    {required String orderId}) async {
  var response = await ref
      .watch(dioProvider)
      .post(getMatchOrderPrint, queryParameters: {'order_id': orderId});
  return matchOrderPrintModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<Map<String, dynamic>> dispatchListingNew(Ref ref,
    {required String? sbtOrderId}) async* {
  var response = await ref
      .watch(dioProvider)
      .get(getDispatchListing, queryParameters: {'sbt_order_id': sbtOrderId});
  yield response.data;
}

@riverpod
Future<Map<String, dynamic>> dispatchRequestQualityParams(Ref ref,
    {String? id, required String sbtOrderId}) async {
  final formData = FormData.fromMap({"id": id, "sbt_order_id": sbtOrderId});
  var response = await ref
      .watch(dioProvider)
      .post(getDispatchQualityParams, data: formData);
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> finalDispatchSubmission(Ref ref,
    {String? id, required String sbtOrderId}) async {
  final formData = FormData.fromMap({"id": id, "sbt_order_id": sbtOrderId});
  var response = await ref
      .watch(dioProvider)
      .post(finalSubmitDispatchRequest, data: formData);
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> updateDispatchPhotos(
  Ref ref, {
  String? dispatchRequestId,
  String? sbtOrderId,
  File? kantaParchiPhoto,
  File? biltyPhoto,
  File? loadTruckPhoto,
  File? truckDriverPhoto,
  qualityPhoto,
}) async {
  final formData = FormData.fromMap({
    "id": dispatchRequestId,
    "kanta_parchi_photo": kantaParchiPhoto != null
        ? await MultipartFile.fromFile(kantaParchiPhoto.path,
            filename: 'kanta_parchi_photo')
        : "",
    "bilty": biltyPhoto != null
        ? await MultipartFile.fromFile(biltyPhoto.path, filename: 'bilty_photo')
        : "",
    "load_truck_photo": loadTruckPhoto != null
        ? await MultipartFile.fromFile(loadTruckPhoto.path,
            filename: 'load_truck_photo')
        : "",
    "truck_driver_photo": truckDriverPhoto != null
        ? await MultipartFile.fromFile(truckDriverPhoto.path,
            filename: 'truck_driver_photo')
        : "",
    "quality_photo": qualityPhoto != null
        ? await MultipartFile.fromFile(qualityPhoto.path,
            filename: 'quality_photo')
        : "",
  });
  var response = await ref
      .watch(dioProvider)
      .post(updateDispatchPhotosEndpoint, data: formData);
  return response.data;
}

@riverpod
Stream<Map<String, dynamic>> grnRequestList(Ref ref) async* {
  var response = await ref.watch(dioProvider).post(getGrnRequestList);

  yield response.data;
}
