import 'package:apnagodam/presentation/warehousefacility_screen/model/stack_request_response_model.dart';

abstract class WareHouseFacilityRepo {
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
      String? warehouseRent = ''});

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
      String lockInMonth = "0"});
}
