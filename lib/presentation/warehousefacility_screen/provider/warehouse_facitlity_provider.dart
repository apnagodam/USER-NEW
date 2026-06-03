import 'package:apnagodam/presentation/warehousefacility_screen/repo_impl/warehouse_facility_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

var warehouseFacilityprovider = Provider((ref) => WarehouseFacilityRepoImpl());

/////////////riverpod generator code
// @riverpod
// Future<StackBookResponseModel> createStackRequest(CreateStackRequestRef ref,
//     {String? stackType = '',
//     String? requestWeight = '',
//     String? inOutStatus = '',
//     String? stackNum = '',
//     String? stackRowId = '',
//     String? commodityId = '',
//     String? vhicalNo = '',
//     String? driverNo = "",
//     String? lockInMonth = '',
//     String? warehouseRent = ''}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   Map<String, String> requestHeaders = {
//     'language': prefs.getString("lang").toString(),
//     'Authorization': prefs.getString("token").toString(),
//     'lat': prefs.getString("lat").toString(),
//     'long': prefs.getString("long").toString(),
//   };
//   var dio = DioInstance().initDio();
//   dio.options.headers = requestHeaders;
//   var response = await dio.post(APANA_CREATE_STACK_REQUEST, queryParameters: {
//     "stack_type": stackType,
//     "request_weight": requestWeight,
//     "in_out_status": inOutStatus,
//     "stack_number": stackNum,
//     "stack_rowId": stackRowId,
//     "commodity_id": commodityId,
//     "vehicle_no": vhicalNo,
//     "driver_number": driverNo,
//     "commodity_arrival_date": lockInMonth,
//     "warehouse_rent": warehouseRent,
//   });
//   print(stackBookResponseModelFromMap(jsonEncode(response.data)));
//   return stackBookResponseModelFromMap(jsonEncode(response.data));
// }

// @riverpod
// Future<dynamic> getRateCard(
//     GetRateCardRef ref,
//     String? stackId,
//     String? stackrequestId,
//     String? wareHouseId,
//     String? commodityId,
//     String? interestRate,
//     String? processingFee,
//     String? labourCharge,
//     String? wareHouseRent,
//     {String wsaCharge = "0.0",
//     String entryLoadChard = '0.0',
//     String exitLoadCharge = "0.0",
//     String lockInMonth = "0"}) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   Map<String, String> requestHeaders = {
//     'language': prefs.getString("lang").toString(),
//     'Authorization': prefs.getString("token").toString(),
//     'lat': prefs.getString("lat").toString(),
//     'long': prefs.getString("long").toString(),
//   };
//   var dio = DioInstance().initDio();
//   dio.options.headers = requestHeaders;

//   var response = await dio.post(APANA_U_RATE_CARD, queryParameters: {
//     "stack_id": stackId,
//     "stack_request_id": stackrequestId,
//     "warehouse_id": wareHouseId,
//     "commodity_id": commodityId,
//     "interest_rate": interestRate,
//     "processing_fee": processingFee,
//     "labour_charge": labourCharge,
//     "warehouse_rent": wareHouseRent,
//     "wsa_charge": wsaCharge,
//     "entry_load": entryLoadChard,
//     "exit_load": exitLoadCharge,
//     "lockin": lockInMonth,
//   });

//   print(jsonDecode(jsonEncode(response.data)));
//   return jsonDecode(jsonEncode(jsonEncode(response.data)));
// }
