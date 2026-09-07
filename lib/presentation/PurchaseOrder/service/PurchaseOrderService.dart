import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/PurchaseOrder/model/PurchaseOrdersListingModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'PurchaseOrderService.g.dart';

Future<Map<String, dynamic>> updatePurchaseOrder(Ref ref,
    {required String terminalId,
    required String commodityId,
    required String weight,
    required String rate,
    required String date,
    required String expiryDate,
    required String poNumber,
    String? broker,
    required String buyerName,
    String? shipTo,
    String? factoryName,
    required String factoryAddress,
    String? payment,
    String? paymentDays,
    required String qualityCondition,
    String? tds,
    String? gstNumber,
    String? phone,
    String? pincode,
    required File poImage}) async {
  FormData formData = FormData.fromMap({
    'terminal_id': terminalId,
    'commodity_id': commodityId,
    'weight': weight,
    'rate': rate,
    'date': date,
    'expiry_date': expiryDate,
    'po_number': poNumber,
    'broker_user': broker ?? '',
    'broker': broker ?? '',
    'wallet_user': buyerName,
    'buyer_name': buyerName,
    'ship_to': shipTo ?? '',
    'factory_name': factoryName ?? '',
    'factory_address': factoryAddress,
    'buyer_address': factoryAddress,
    'payment': payment ?? '',
    'payment_type': payment ?? '',
    'payment_days': paymentDays ?? '',
    'quality_condition': qualityCondition,
    'tds': tds ?? '',
    if (gstNumber != null && gstNumber.isNotEmpty) 'buyer_gstnumber': gstNumber,
    if (phone != null && phone.isNotEmpty) 'buyer_phone': phone,
    if (pincode != null && pincode.isNotEmpty) 'delivery_pincode': pincode,
    'po_image': await MultipartFile.fromFile(poImage.path,
        contentType: DioMediaType("image", "png"), filename: 'po_image.png'),
  });
  var response =
      await ref.watch(dioProvider).post(postPurchaseOrder, data: formData);
  return Map<String, dynamic>.from(response.data);
}

final purchaseOrderServiceProvider = Provider<PurchaseOrderService>((ref) {
  return PurchaseOrderService(ref);
});

class PurchaseOrderService {
  final Ref ref;
  PurchaseOrderService(this.ref);

  Future<Map<String, dynamic>> createPurchaseOrder({
    required String terminalId,
    required String commodityId,
    required String weight,
    required String rate,
    required String date,
    required String expiryDate,
    required String poNumber,
    String? broker,
    required String buyerName,
    String? shipTo,
    String? factoryName,
    required String factoryAddress,
    String? payment,
    String? paymentDays,
    required String qualityCondition,
    String? tds,
    String? gstNumber,
    String? phone,
    String? pincode,
    required File poImage,
  }) {
    return updatePurchaseOrder(
      ref,
      terminalId: terminalId,
      commodityId: commodityId,
      weight: weight,
      rate: rate,
      date: date,
      expiryDate: expiryDate,
      poNumber: poNumber,
      broker: broker,
      buyerName: buyerName,
      shipTo: shipTo,
      factoryName: factoryName,
      factoryAddress: factoryAddress,
      payment: payment,
      paymentDays: paymentDays,
      qualityCondition: qualityCondition,
      tds: tds,
      gstNumber: gstNumber,
      phone: phone,
      pincode: pincode,
      poImage: poImage,
    );
  }
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
