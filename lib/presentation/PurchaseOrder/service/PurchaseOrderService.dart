import 'dart:convert';
import 'dart:io';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/PurchaseOrder/model/BrokerBuyerModel.dart';
import 'package:apnagodam/presentation/PurchaseOrder/model/PurchaseOrdersListingModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'PurchaseOrderService.g.dart';

// 1. Warehouse, Broker, Buyer provider (GET user_api/getWarehouseData)
final getPoWarehouseDataProvider =
    FutureProvider.autoDispose<PoWarehouseBrokerBuyerModel>((ref) async {
  var response = await ref.watch(dioProvider).get(getPoWarehouseData);
  final data = response.data;
  return PoWarehouseBrokerBuyerModel.fromJson(
      data is String ? jsonDecode(data) : Map<String, dynamic>.from(data));
});

// 2. Commodity provider by terminal_id (POST user_api/getCommodityData)
final getPoCommodityDataProvider =
    FutureProvider.autoDispose.family<PoCommodityListModel, String>(
        (ref, terminalId) async {
  FormData formData = FormData.fromMap({'terminal_id': terminalId});
  var response =
      await ref.watch(dioProvider).post(getPoCommodityData, data: formData);
  final data = response.data;
  return PoCommodityListModel.fromJson(
      data is String ? jsonDecode(data) : Map<String, dynamic>.from(data));
});

// 3. Ship To provider by commodity_id (POST user_api/getShipToUserData)
final getPoShipToUserDataProvider =
    FutureProvider.autoDispose.family<PoShipToBuyerModel, String>(
        (ref, commodityId) async {
  FormData formData = FormData.fromMap({'commodity_id': commodityId});
  var response =
      await ref.watch(dioProvider).post(getPoShipToUserData, data: formData);
  final data = response.data;
  return PoShipToBuyerModel.fromJson(
      data is String ? jsonDecode(data) : Map<String, dynamic>.from(data));
});

// 4. Factory List provider by shipToUserId (POST user_api/getFactoryList)
final getPoFactoryListProvider =
    FutureProvider.autoDispose.family<PoFactoryListModel, String>(
        (ref, shipToUserId) async {
  FormData formData = FormData.fromMap({
    'shipToUserId': shipToUserId,
    'ship_to_user_id': shipToUserId,
  });
  var response =
      await ref.watch(dioProvider).post(getPoFactoryList, data: formData);
  final data = response.data;
  return PoFactoryListModel.fromJson(
      data is String ? jsonDecode(data) : Map<String, dynamic>.from(data));
});

Future<Map<String, dynamic>> updatePurchaseOrder(Ref ref,
    {required String terminalId,
    required String commodityId,
    required String weight,
    required String rate,
    required String date,
    required String expiryDate,
    required String poNumber,
    String? brokerUser,
    required String walletUser,
    required String shipToBuyer,
    required String factoryId,
    required String factoryAddress,
    required String paymentType,
    required String paymentDays,
    required String qualityCondition,
    String? tdsRate,
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
    'broker_user': brokerUser ?? '',
    'broker': brokerUser ?? '',
    'wallet_user': walletUser,
    'buyer_name': walletUser,
    'ship_to_buyer': shipToBuyer,
    'ship_to': shipToBuyer,
    'factory_id': factoryId,
    'factory_name': factoryId,
    'factory_address': factoryAddress,
    'buyer_address': factoryAddress,
    'payment_type': paymentType,
    'payment': paymentType,
    'payment_days': paymentDays,
    'quality_condition': qualityCondition,
    'tds_rate': (tdsRate != null && tdsRate.isNotEmpty) ? tdsRate : '0',
    'tds': (tdsRate != null && tdsRate.isNotEmpty) ? tdsRate : '0',
    if (gstNumber != null && gstNumber.isNotEmpty) 'buyer_gstnumber': gstNumber,
    if (phone != null && phone.isNotEmpty) 'buyer_phone': phone,
    if (pincode != null && pincode.isNotEmpty) 'delivery_pincode': pincode,
    'po_image': await MultipartFile.fromFile(
      poImage.path,
      filename: poImage.path.split('/').last.isNotEmpty
          ? poImage.path.split('/').last
          : 'po_image.jpg',
    ),
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
    String? brokerUser,
    required String walletUser,
    required String shipToBuyer,
    required String factoryId,
    required String factoryAddress,
    required String paymentType,
    required String paymentDays,
    required String qualityCondition,
    String? tdsRate,
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
      brokerUser: brokerUser,
      walletUser: walletUser,
      shipToBuyer: shipToBuyer,
      factoryId: factoryId,
      factoryAddress: factoryAddress,
      paymentType: paymentType,
      paymentDays: paymentDays,
      qualityCondition: qualityCondition,
      tdsRate: tdsRate,
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
