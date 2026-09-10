import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:apnagodam/presentation/dashboard/model/CaseIdStatusModel.dart';
import 'package:apnagodam/presentation/dashboard/model/CustomerSupportModel.dart';
import 'package:apnagodam/presentation/dashboard/model/base_response_model.dart';
import 'package:apnagodam/presentation/dashboard/model/spot_deal_model.dart';
import 'package:apnagodam/presentation/dashboard/model/wahouse_deal_model.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/mybuy_screen/spot_deal_screen.dart';
import 'package:apnagodam/presentation/mybuy_screen/werehouse_deal_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/constants.dart';
import '../../market_screen/model/wbt_model.dart';
import '../../mybuy_screen/face_to_face_deal.dart';
import '../model/CheckLoanAction.dart';
import '../model/MatchedOrdersModel.dart';
import '../model/bidding_response_model.dart';
import '../model/buyer_seller_list_model.dart';
import '../model/face_to_face_model.dart';
import '../../../core/utils/SharedPrefs/SharedUtility.dart';
import 'package:flutter/foundation.dart';
import '../model/sbt_commodity_model.dart';
part 'dashboard_service.g.dart';

@riverpod
Stream<WbtModel> getMandiBhav(GetMandiBhavRef ref) async* {
  var response =
      await ref.watch(dioProvider).post('${BASEURL}user_api/new-taja-bhav');
  yield wbtModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<BiddingResponseModel> getBiddingData(GetBiddingDataRef ref,
    {String? inventoryId, String? status}) async* {
  var response = await ref.watch(dioProvider).get(APNA_U_BIDDING_LIST,
      queryParameters: {'inventory_id': inventoryId, 'status': status});
  yield biddingResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<BaseResponseModel> updateBid(UpdateBidRef ref,
    {String? inventoryId, String? price}) async {
  var response = await ref.watch(dioProvider).post(WBT_UPDATE_SELL_PRICE,
      queryParameters: {'inventory_id': inventoryId, 'price': price},
      options: Options(extra: {'show_loader': true}));
  return baseResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> addBid(AddBidRef ref,
    {String? inventoryId, String? price}) async {
  var response = await ref.watch(dioProvider).post(APNA_U_BID_BY_BUYER,
      queryParameters: {
        'inventory_id': inventoryId,
        'bid_price': price,
        'is_secure': '1'
      },
      options: Options(extra: {'show_loader': true}));
  return response.data;
}

@riverpod
Future<SbtCommodityModel> getSbtCommodity(GetSbtCommodityRef ref) async {
  final prefs = ref.watch(sharedPreferencesProvider);
  const cacheKey = 'cached_sbt_product_list';

  // 1. Try to fetch live SBT product list
  try {
    var response = await ref.watch(dioProvider).get(SBT_COMMODITY_LIST);
    if (response.data != null) {
      final model = sbtCommodityModelFromMap(jsonEncode(response.data));
      if (model.data != null && model.data!.isNotEmpty) {
        // Save live response to cache
        prefs.setString(cacheKey, jsonEncode(response.data));
        return model;
      }
    }
  } catch (e) {
    debugPrint('getSbtCommodity GET error: $e');
  }

  // 2. If unauthenticated (e.g. status "0", "User not found!") or empty response, check cached data
  final cachedJson = prefs.getString(cacheKey);
  if (cachedJson != null && cachedJson.isNotEmpty) {
    try {
      final cachedModel = sbtCommodityModelFromMap(cachedJson);
      if (cachedModel.data != null && cachedModel.data!.isNotEmpty) {
        return cachedModel;
      }
    } catch (e) {
      debugPrint('Error parsing cached SBT data: $e');
    }
  }

  // 3. Fallback: Return official default SBT products list so guest users always see market data
  return SbtCommodityModel(
    status: "1",
    message: "SBT Product List",
    data: defaultSbtCommodityList,
  );
}

@riverpod
Stream<BuyerSelletListModel> getBuyerSellerList(GetBuyerSellerListRef ref,
    {String? cityState, String? commodityId}) async* {
  var response = await ref.watch(dioProvider).get(SBT_BUYER_SELLER,
      queryParameters: {"product_id": cityState, "commodity": commodityId});
  yield buyerSelletListModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> sbtBuyAndSell(SbtBuyAndSellRef ref,
    {String? commodity,
    String? qty,
    String? type,
    String? price,
    String? pinCode,
    String? truckNo}) async {
  var response =
      await ref.watch(dioProvider).post(SBT_BUYANDSELL, queryParameters: {
    'commodity': commodity,
    'qty': qty,
    'type': type,
    'price': price,
    'pincode': pinCode,
    'truck_no': truckNo
  }, options: Options(extra: {'show_loader': true}));

  return response.data;
}

// @Riverpod(keepAlive: true)
// Future<MandiBhavModel> mandiBhav(MandiBhavRef ref) async {
//   var response = await ref.watch(dioProvider).get(MANDIBHAV);
//   return mandiBhavModelFromMap(jsonEncode(response.data));
// }

@riverpod
Future<Map<String, dynamic>> updateSbt(UpdateSbtRef ref,
    {required String? productId,
    required String? tradeId,
    required String? commodityId,
    required String? qty,
    required String? price,
    required String? district_id,
    required String? type}) async {
  var response = await ref.watch(dioProvider).post(sbtUpdate, queryParameters: {
    "product_id": productId,
    "trade_id": tradeId,
    "commodity": commodityId,
    "qty": qty,
    "price": price,
    "district_id": district_id,
    "type": type
  }, options: Options(extra: {'show_loader': true}));
  return response.data;
}

@riverpod
Future<MatchedOrdersModel> matchedOrders(MatchedOrdersRef ref,
    {String? productId}) async {
  var response = await ref
      .watch(dioProvider)
      .get(getMatchingOrders, queryParameters: {"product_id": productId});
  return matchedOrdersModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> postSbt(PostSbtRef ref,
    {required String? productId,
    required String? commodityId,
    required String? qty,
    required String? price,
    required String? district_id,
    required String? type,
    String? loanType,
    String? schemeId}) async {
  var response = await ref.watch(dioProvider).post(postBid, queryParameters: {
    "product_id": productId,
    "commodity": commodityId,
    "qty": qty,
    "price": price,
    "district_id": district_id,
    "type": type,
    "loan_type": loanType ?? "0",
    "scheme_id": schemeId ?? "0"
  }, options: Options(extra: {'show_loader': true}));

  ref.invalidate(getBuyerSellerListProvider);

  ref.invalidate(getSbtCommodityProvider);

  ref.invalidate(matchedOrdersProvider);
  return response.data;
}

@riverpod
Stream<WarehouseDealModel> warehouseDealData(WarehouseDealDataRef ref,
    {String? type, String? page}) async* {
  var response =
      await ref.watch(dioProvider).get(APNA_WAREHOUSE_LIST, queryParameters: {
    'status': type,
    'limit': 15,
    'page': page,
    'search': ref.watch(warehouseDealSearchProvider)
  });
  yield warehouseDealModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<Map<String, dynamic>> stackBuySellList(StackBuySellListRef ref,
    {String? type}) async* {
  var response = await ref
      .watch(dioProvider)
      .post(getStackBuySellListing, queryParameters: {
    'status': type,
  });
  yield response.data;
}

@riverpod
Stream<SpotDealModel> spotDealData(SpotDealDataRef ref, {String? type}) async* {
  var response = await ref.watch(dioProvider).get(APNA_SPOT_DEAL,
      queryParameters: {
        'type': type,
        'limit': 15,
        'search': ref.watch(spotDealSearchProvider)
      });
  yield spotDealModelFromMap(jsonEncode(response.data));
}

@riverpod
Stream<FaceToFaceModel> f2fDealData(F2fDealDataRef ref, {String? type}) async* {
  var response = await ref.watch(dioProvider).get(FTWOF_DEALS,
      queryParameters: {
        'type': type,
        'limit': 15,
        'search': ref.watch(f2fDealSearchProvider)
      });
  yield faceToFaceModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> checkLoanStatus(CheckLoanStatusRef ref,
    {String? inventoriesId}) async {
  var response = await ref
      .watch(dioProvider)
      .get(FINANCEGATEPASS); //queryParameters: {'inventory_id': inventoriesId}
  return response.data;
}

@riverpod
Future<CheckLoanActionResponse> checkLoanAction(CheckLoanActionRef ref,
    {String? catName, String? invId}) async {
  var response = await ref
      .watch(dioProvider)
      .get(LOANPRICE, queryParameters: {'cat_name': catName}); //,"inv_id":invId
  return checkLoanActionResponseFromMap(jsonEncode(response.data));
}

@riverpod
Stream<CaseIdStatusModel> warehouseBookings(WarehouseBookingsRef ref) async* {
  var response = await ref.watch(dioProvider).get(getBookingData);
  yield caseIdStatusModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> rejectQuality(RejectQualityRef ref,
    {required String caseId}) async {
  var response = await ref
      .watch(dioProvider)
      .post(rejectQualityClaim, queryParameters: {'case_id': caseId});
  ref.invalidate(warehouseBookingsProvider);
  return response.data;
}

@riverpod
Future<BaseResponseModel> apnaWantToSell(
  ApnaWantToSellRef ref, {
  String? inventoryId = "",
  String? price = "",
  String? quantity = "",
  String? rentRowId = "",
  String? interestRowId = "",
  String? mandiAmount = "",
  String? finalSettlementAmount = "",
  String? remFinalAmount = "",
  String? walletSettlementAmount = "",
}) async {
  var response =
      await ref.watch(dioProvider).post(APNA_U_WANT_TO_SELL, queryParameters: {
    'inventory_id': inventoryId,
    'price': price,
    'quantity': quantity,
    'rent_rowID': rentRowId,
    'interest_rowID': interestRowId,
    'mandi_amount': mandiAmount,
    'final_settlment_amount': finalSettlementAmount,
    'rem_final_amount': remFinalAmount,
    'walletSatlementAmount': walletSettlementAmount,
  });
  return baseResponseModelFromMap(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> approveBookingParameters(
    ApproveBookingParametersRef ref,
    {String? caseId}) async {
  var response = await ref
      .watch(dioProvider)
      .post(approveBookingQuality, queryParameters: {'case_id': caseId});
  return response.data;
}

@riverpod
Stream<CustomerSupportModel> faq(FaqRef ref) async* {
  var response = await ref.watch(dioProvider).get(getListOfFaq);
  yield customerSupportModelFromJson(jsonEncode(response.data));
}

@riverpod
Future<Map<String, dynamic>> disableAccount(DisableAccountRef ref) async {
  var response = await ref.watch(dioProvider).post(disableUserAccount);
  return response.data;
}
