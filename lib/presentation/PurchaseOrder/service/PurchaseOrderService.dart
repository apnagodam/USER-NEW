import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/PurchaseOrder/model/PurchaseOrdersListingModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'PurchaseOrderService.g.dart';

@riverpod
Future<Map<String, dynamic>> updatePurchaseOrder(Ref ref,
    {required String terminalId,
    required String commodityId,
    required String weight,
    required String rate,
    required String date,
    required String expiryDate,
    required String poNumber,
    required String gstNumber,
    required String broker,
    required String buyerName,
    required String phone,
    required String address,
    required String pincode,
    required String qualityCondition,
    required File poImage}) async {
  FormData formData = FormData.fromMap({
    'terminal_id': terminalId,
    'commodity_id': commodityId,
    'weight': weight,
    'rate': rate,
    'date': date,
    'expiry_date': expiryDate,
    'po_number': poNumber,
    'buyer_gstnumber': gstNumber,
    'broker_user': broker, //broker
    'wallet_user': buyerName,//buyer_name
    'buyer_phone': phone,
    'buyer_address': address,
    'delivery_pincode': pincode,
    'quality_condition': qualityCondition,
    'po_image': await MultipartFile.fromFile(poImage.path,
        contentType: DioMediaType("image", "png"), filename: 'po_image.png'),
  });
  var response =
      await ref.watch(dioProvider).post(postPurchaseOrder, data: formData);
  return response.data;
}

@riverpod
Stream<PurchaseOrdersListingModel> purchaseOrdersList(Ref ref) async* {
  var response = await ref.watch(dioProvider).get(getPurchaseOrders);
  yield purchaseOrdersListingModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> deletePO(Ref ref, {String? id}) async {
  var response = await ref
      .watch(dioProvider)
      .post(deletePurchaseOrders, queryParameters: {"id": id});

  ref.invalidate(purchaseOrdersListProvider);
  return response.data;
}

@riverpod
Future<Map<String, dynamic>> editPo(Ref ref,
    {String? id, String? pendingQty, String? expiry, String? remark}) async {
  var response = await ref.watch(dioProvider).post(updatePUrchaseOrders,
      queryParameters: {
        'id': id,
        'pending_qty': pendingQty,
        'expiry_date': expiry,
        'remark': remark
      });

  ref.invalidate(purchaseOrdersListProvider);
  return response.data;
}
