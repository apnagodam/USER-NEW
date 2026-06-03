import 'dart:convert';

import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/presentation/LP_list_screen/google_map_screen.dart';
import 'package:apnagodam/presentation/LP_list_screen/model/LpResponseModel.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../model/All_bookings_model.dart';

part 'LpService.g.dart';

@riverpod
Future<LpResponseModel> lpData(LpDataRef ref,
    {String? lat,
    String? long,
    String? commodityImage,
    String? commodity,
    String? quantity,
    String? dealType,
    String? pincode,
    String? salesStatus}) async {
  var response =
      await ref.watch(dioProvider).post(SELL_ORDER_CREATE, queryParameters: {
    'live_latitude': "$lat",
    'live_longitude': "$long",
    'commodity_image': commodityImage,
    'commodity': commodity,
    'quantity': quantity,
    'deal_type': dealType,
    'pincode': pincode,
    'sales_status': salesStatus,
  });
  return lpResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<AllBookingsModel> allBookings(
  AllBookingsRef ref, {
  String? status,
}) async* {
  var response = await ref
      .watch(dioProvider)
      .get(APNA_USER_ALL_BOOKINGS, queryParameters: {'status': status});
  yield allBookingsModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> bookingRequest(
  BookingRequestRef ref, {
  String? lpUserId,
  String? commodityId,
  String? quantity,
  String? price,
  String? salesStatus,
  String? catImage,
  String? commodityImagePath,
  String? terminalId,
  String? agCommission,
  String? lpCommision,
  String? user,
  String? distance,
  String? lpLat,
  String? lpLong,
  String? corpLat,
  String? corpLong,
  String? finalPrice,
  String? subPrice,
  String? transportPrice,
  String? loadingCharge,
  String? mandiTax,
}) async {
  var response = await ref
      .watch(dioProvider)
      .post(APNA_U_ON_BOOK_MGP_LP, queryParameters: {
    "lp_user_id": lpUserId,
    "commodity_id": commodityId,
    "quantity": quantity,
    "price": price,
    "sales_status": salesStatus,
    "category_image": catImage,
    "commodity_image_path": commodityImagePath,
    "terminal_id": terminalId,
    "ag_commission": agCommission,
    "lp_commission": lpCommision,
    "user": user,
    "distance": distance,
    "lp_lat": lpLat,
    "lp_long": lpLong,
    "corporate_users_lat": corpLat,
    "corporate_users_long": corpLong,
    "final_price": finalPrice,
    "sub_price": subPrice,
    "transport_price": transportPrice,
    "loading_charge": loadingCharge,
    "mandi_tax": mandiTax
  });
  return response.data;
}
