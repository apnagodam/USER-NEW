import 'dart:convert';

import 'package:apnagodam/core/constants/constants.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/model/available_warehouse_stacks_model.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/model/stack_request_response_model.dart';
import 'package:apnagodam/presentation/warehousefacility_screen/repo/warehouse_facility_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'warehouse_facility_repo_impl.g.dart';

class WarehouseFacilityRepoImpl extends WareHouseFacilityRepo {
  @override
  Future<StackBookResponseModel> createStackRequest(
      {String? stackType = '',
      String? requestWeight = '',
      String? inOutStatus = '',
      String? stackNum = '',
      String? stackRowId = '',
      String? commodityId = '',
      String? vhicalNo = '',
      String? driverNo = "",
      String? lockInMonth = '',
      String? warehouseRent = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    var dio = DioInstance().initDio();
    dio.options.headers = requestHeaders;
    var response = await dio.post(APANA_CREATE_STACK_REQUEST, queryParameters: {
      "stack_type": stackType,
      "request_weight": requestWeight,
      "in_out_status": inOutStatus,
      "stack_number": stackNum,
      "stack_rowId": stackRowId,
      "commodity_id": commodityId,
      "vehicle_no": vhicalNo,
      "driver_number": driverNo,
      "commodity_arrival_date": lockInMonth,
      "warehouse_rent": warehouseRent,
    });
    print(stackBookResponseModelFromMap(jsonEncode(response.data)));
    return stackBookResponseModelFromMap(jsonEncode(response.data));
  }

  @override
  Future<dynamic> getRateCard(
      String? stackId,
      String? stackrequestId,
      String? wareHouseId,
      String? commodityId,
      String? interestRate,
      String? processingFee,
      String? labourCharge,
      String? wareHouseRent,
      {String wsaCharge = "0.0",
      String entryLoadChard = '0.0',
      String exitLoadCharge = "0.0",
      String lockInMonth = "0"}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    var dio = DioInstance().initDio();
    dio.options.headers = requestHeaders;

    var response = await dio.post(APANA_U_RATE_CARD, queryParameters: {
      "stack_id": stackId,
      "stack_request_id": stackrequestId,
      "warehouse_id": wareHouseId,
      "commodity_id": commodityId,
      "interest_rate": interestRate,
      "processing_fee": processingFee,
      "labour_charge": labourCharge,
      "warehouse_rent": wareHouseRent,
      "wsa_charge": wsaCharge,
      "entry_load": entryLoadChard,
      "exit_load": exitLoadCharge,
      "lockin": lockInMonth,
    });

    print(jsonDecode(jsonEncode(response.data)));
    return jsonDecode(jsonEncode(response.data));
  }
}

@riverpod
Future<Map<String, dynamic>> inwardStackBook(InwardStackBookRef ref,
    {var stackrowId,
    var weight,
    var vehicleNo,
    var stackId,
    var salesStatus,
    var commodityId,
    var terminalId,
    var stackNo,
    var driverNo,
    var transporterType,
    var tripId,
    String? fileImage = ""}) async {
  var response =
      await ref.watch(dioProvider).post(APANA_U_ADD_INWORD_REQUEST, data: {
    "stack_request_rowid": stackrowId,
    "request_weight": weight,
    "vehicle_no": vehicleNo,
    "stack_id": stackId,
    "sales_status": salesStatus,
    "commodity_id": commodityId,
    'terminal_id': terminalId,
    "stack_number": stackNo,
    "driver_number": driverNo,
    'transporter_type': transporterType,
    'trip_id': tripId,
    "file": fileImage ?? "",
  });

  return response.data;
}

@riverpod
Future<AvailableWarehouseStacksModel> getAvailableStacks(
    GetAvailableStacksRef ref,
    {required terminalid,
    required commodityid,
    required weightreqst,
    required in_out_status,
    required stack_type,
    required vehicle_no,
    required driverNumber}) async {
  var response = await ref
      .watch(dioProvider)
      .post(WAREHOUSE_TERMINAL_STACK, queryParameters: {
    'terminal_id': terminalid,
    'commodity_id': commodityid,
    'weight_reqst': weightreqst,
    'in_out_status': in_out_status,
    'stack_type': stack_type,
    'vehicle_no': vehicle_no,
    'driver_number': driverNumber
  });

  return availableWarehouseStacksModelFromMap(jsonEncode(response.data));
}
