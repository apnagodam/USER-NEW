import 'package:apnagodam/presentation/home_screen/stock_summary.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/color_constant.dart';
import '../../../data/apiClient/apiClient.dart';
import '../../splash_screen/splash_screen.dart';
import '../summary_model/user_commodity_model.dart';

class SummaryController extends GetxController {
  bool isLoad = true;

  // CommonIndexModel? commonIndexModel;
  List<WareHousedata> summaryTerminalList = [];
  List<CommodityDataL> summaryCommdityList = [];
  var selectedCommdityList = [];
  var selectedTerminalList = [];
  var commodityId;
  var warehouseId;
  var commodityData;
  List<ChartData> chartData = [];

  @override
  void onInit() {
    user_coomodity_list();
    user_coomodity_data(selectedCommdityList, selectedTerminalList);
    super.onInit();
  }

  Future user_coomodity_list() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // update();
    await ApiClient.user_coomodity_list_service().then((value) {
      update();
      if (value != null) {
        if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
        } else {
          Iterable sclist = value["data"];
          summaryCommdityList =
              sclist.map((e) => CommodityDataL.fromJson(e)).toList();
          commodityId = value["id"].toString();

          Iterable stlist = value["ware_housedata"];
          summaryTerminalList =
              stlist.map((e) => WareHousedata.fromJson(e)).toList();
          warehouseId = value["id"].toString();
        }
      }
    });
  }

  Future user_coomodity_data(List commodityId, List warehouseId) async {
    isLoad = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await ApiClient.commodity_data_Service(commodityId, warehouseId)
        .then((value) {
      update();
      isLoad = false;
      if (value != null) {
        if (value["status"] == "3") {
        } else {
          commodityData = value["data"];
          print(commodityData);
          print("commodityData");
        }
      }
    });
  }
}
