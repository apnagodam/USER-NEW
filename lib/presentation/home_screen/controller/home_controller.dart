import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/progress_dialog_utils.dart';
import '../../../data/apiClient/apiClient.dart';
import '../../LP_list_screen/model/lp_list_model.dart';
import '../../my_order_screen/my_order_screen.dart';
import '../../splash_screen/splash_screen.dart';
import '../models/CommonIndexModel.dart';
import '../models/FinanceTermModel.dart';
import '../models/MandiBhavModal.dart';
import '../models/MyStockModel.dart';
import '../models/UserDetailModal.dart';
import '../models/bnpl_request_list_model.dart';
import '../models/bnpl_summary_list_model.dart';

class HomeController extends GetxController {
  // Rx<HomeModel> homeModelObj = HomeModel().obs;

  UserDetailsModel? userDetailModal;

  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController ownquantitycontroller = TextEditingController();
  TextEditingController commoditycontroller = TextEditingController();
  TextEditingController buyquantityController = TextEditingController();
  TextEditingController buypriceController = TextEditingController();
  TextEditingController buyshipmentController = TextEditingController();
  TextEditingController bnplrequestAmountController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();

  TextEditingController userEmailcontroller = TextEditingController();
  TextEditingController userKycPancontroller = TextEditingController();
  TextEditingController userKycAcccontroller = TextEditingController();
  TextEditingController userKycAadharcontroller = TextEditingController();
  String pan = "";
  String acccount = "";
  String aadhar = "";
  double walletamount = 0.0;
  ScrollController homeviewcontroller = ScrollController();
  String waree = "ware";
  var locall;
  var sanctionlimitermview;
  var face2face;
  var face2facecal;
  bool isLoading = true;
  bool userisLoading = true;
  bool isLoad = true;
  bool ismystockLoad = true;

  var salected = "";
  var salectedSell = "";
  var salectedSellUnder = "";
  var salectedSellUndertwo = "";
  var salectedSellUnderthree = "";
  var inventoriesUrl = "";
  var bankIndex = -1;
  bool orderLoader = false;

  List<OrderData> mandionlist = [];
  List<EmandiData> mandipricelist = [];

  List<BnplListData> bnplrequestList = [];
  List<BnplSummaryData> bnplsummaryList = [];
  CommonIndexModel? commonIndexModel;
  MyStockModel? myStockModel;
  FinanceTermModel? financeTermModel;

  List<LpList> lpdataList = [];

  int currentIndex = 0;

  var lyinLoad = false;
  var lyinLoading = false;
  List<InventoriesData> lyinDatalist = [];

  // List<InventoriesData>lyinNoDatalist = [];
  var totalDatalyin;
  var lyingnextUrl;

  Future ftwofDeal(var sellerId, var lat, var long, var commodity, var bages,
      var salesStatus, var weight, var price, Uint8List image) async {
    update();

    var valueT;
    await ApiClient.f2fDealCreate(sellerId, lat, long, commodity, bages,
            salesStatus, weight, price, image)
        .then((value) {
      update();

      valueT = value;
      if (value != null) {
        if (value["status"] == 1) {
          Get.rawSnackbar(
            message: value["message"],
            duration: const Duration(seconds: 2),
            backgroundColor: ColorConstant.maingreen,
          );
        } else if (value["status"] == 0) {
          Get.rawSnackbar(
            message: value["message"],
            duration: const Duration(seconds: 2),
            backgroundColor: ColorConstant.red500,
          );
        } else {}
      }
    });
    return valueT;
  }

  Future ftwofDealCalculate(var sellerId, var lat, var long, var commodity,
      var bags, var salesStatus, var weight, var price) async {
    update();
    await ApiClient.f2fDealCalculate(
            sellerId, lat, long, commodity, bags, salesStatus, weight, price)
        .then((value) {
      if (value != null) {
        if (value["status"] == 1) {
          face2facecal = value["data"];
          refresh();
          update();
          return face2facecal;
        } else {
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        }
      }
    });
  }

  sellCreateOrder(var lat, var long, var commodityImage, var commodity,
      var quantity, var dealType, var pincode, var salesStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    refresh();
    await ApiClient.sellCreateOrderData(lat, long, commodityImage, commodity,
            quantity, dealType, pincode, salesStatus)
        .then((value) {
      refresh();
      update();
      print(value);
      if (value != null) {
        if (value["status"] == "0") {
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        }
        if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
          Get.offAll(() => SplashScreen());
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        }
        if (value["status"] == "1") {
          Iterable list = value["lp_list"];
          lpdataList = list.map((e) => LpList.fromJson(e)).toList();
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);
        } else {
          /* Get.rawSnackbar(
            message: value["message"],
            duration: const Duration(seconds: 2),
            backgroundColor: ColorConstant.maingreen,
          );*/
        }
      }
    });
  }

  buyCreateOrder(var deliveryAt, var terminalId, var shipmentCode,
      var commodityId, var quantity, var price) async {
    orderLoader = true;
    update();
    await ApiClient.buyCreateOrderData(
            deliveryAt, terminalId, shipmentCode, commodityId, quantity, price)
        .then((value) {
      if (value != null) {
        Get.rawSnackbar(
          message: value["message"],
          duration: const Duration(seconds: 2),
          backgroundColor: ColorConstant.maingreen,
        );
        orderLoader = false;
        update();
        Get.off(() => OrderList());
      } else {
        orderLoader = false;
        update();
      }
    });
  }

  layingAtWarehouseList(page, var commodityID, var search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lyinLoad = true;

    if (page == 1) {
      lyinDatalist = [];
      lyinLoading = true;
    } else {
      lyinLoad = true;

      update();
    }

    await ApiClient.layingAtWarehouseListService(page, commodityID, search)
        .then((value) {
      lyinLoading = false;
      lyinLoad = false;
      update();
      if (value != null) {
        if (value["status"] == "3") {
          prefs.setBool("isLogin", false);
          Get.offAll(() => SplashScreen());
          Get.rawSnackbar(
              message: value["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
        } else {
          myStockModel = MyStockModel.fromJson(value);
          List<InventoriesData> layingListdata = [];
          totalDatalyin = value["inventories"]["total"];
          lyingnextUrl = value["inventories"]["next_page_url"];
          Iterable list = value["inventories"]["data"];
          layingListdata =
              list.map((e) => InventoriesData.fromJson(e)).toList();
          lyinDatalist.addAll(layingListdata);
          lyinLoading = false;
          lyinLoad = false;
          update();
        }
      }
    });
  }

  // File passBookImage,File aadharImage,File profileImage,File gstImage,File panCardImage
  // passBookImage,aadharImage,profileImage,gstImage,panCardImage,profileBase
}
