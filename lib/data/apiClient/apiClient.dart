import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/color_constant.dart';

class ApiClient extends GetConnect implements GetxService {
  static Future<dynamic> doLogin(
    var number,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Content-type': 'multipart/form-data',
      'language': prefs.getString("lang").toString(),
    };

    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "${BASEURL}api/apna_send_otp?number=$number&app_type=User&otp_type=&token="));
    request.fields['number'] = number;

    request.headers.addAll(requestHeaders);
    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);
      var data = jsonDecode(alldata);
      if (value.statusCode == 200) {
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future<dynamic> doOTPVerify(var number, var otp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Content-type': 'multipart/form-data',
      'language': prefs.getString("lang").toString(),
    };

    var request = http.MultipartRequest("POST", Uri.parse(DOOTPVERIFY));
    request.fields['number'] = number;
    request.fields['otp'] = otp.toString();

    request.headers.addAll(requestHeaders);
    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);
      var data = jsonDecode(alldata);
      if (value.statusCode == 200) {
        if (data["status"] == 1) {
          Get.rawSnackbar(
              message: data["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.maingreen);

          return data;
        } else if (data["status"] == "0") {
          Get.rawSnackbar(
              message: data["message"],
              duration: const Duration(seconds: 2),
              backgroundColor: ColorConstant.red500);
          return null;
        }
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future<dynamic> signUpSendOtpData(
    var number,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Content-type': 'multipart/form-data',
      'language': prefs.getString("lang").toString(),
    };

    var request = http.MultipartRequest("POST", Uri.parse(SIGN_UP_OTP_SEND));
    request.fields['number'] = number;

    request.headers.addAll(requestHeaders);
    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);
      var data = jsonDecode(alldata);
      if (value.statusCode == 200) {
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future<dynamic> signUpVerifyOtpData(var number, var name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Content-type': 'multipart/form-data',
      'language': prefs.getString("lang").toString(),
    };

    var request = http.MultipartRequest("POST", Uri.parse(DOSIGNUPOTPVERIFY));
    request.fields['number'] = number;
    request.fields['name'] = name.toString();
    request.fields['user_type'] = "1";
    request.fields['token'] = "";
    request.fields['referred_by'] = "";
    request.fields['btn_type'] = "signupBtn";

    request.headers.addAll(requestHeaders);
    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);
      var data = jsonDecode(alldata);
      if (value.statusCode == 200) {
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future<dynamic> f2fDealCreate(
      var sellerId,
      var lat,
      var long,
      var commodity,
      var bags,
      var salesStatus,
      var weight,
      var price,
      Uint8List image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': lat,
      'long': long,
    };
    print(requestHeaders);

    var request = http.MultipartRequest("POST", Uri.parse(FTWOF_DEAL_CREATE));
    request.fields['seller_id'] = sellerId.toString().trim();
    request.fields['seller_lat'] = lat.toString().trim();
    request.fields['seller_long'] = long.toString().trim();
    request.fields['commodity'] = commodity.toString().trim();
    request.fields['bags'] = bags.toString().trim();
    request.fields['sales_status'] = salesStatus.toString().trim();
    request.fields['weight'] = weight.toString().trim();
    request.fields['price'] = price.toString().trim();
    request.fields['image'] = base64Encode(image);
    request.headers.addAll(requestHeaders);

    print(request.fields);

    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);

      if (value.statusCode == 200) {
        var data = jsonDecode(alldata);
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future<dynamic> f2fDealCalculate(var sellerId, var lat, var long,
      var commodity, var bags, var salesStatus, var weight, var price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': lat,
      'long': long,
    };

    var request =
        http.MultipartRequest("POST", Uri.parse(FTWOF_DEAL_CALCULATION));
    request.fields['seller_id'] = sellerId.toString().trim();
    request.fields['seller_lat'] = lat.toString().trim();
    request.fields['seller_long'] = long.toString().trim();
    request.fields['commodity_id'] = commodity.toString().trim();
    request.fields['bags'] = bags.toString().trim();
    request.fields['sales_status'] = salesStatus.toString().trim();
    request.fields['weight'] = weight.toString().trim();
    request.fields['price'] = price.toString().trim();
    request.headers.addAll(requestHeaders);
    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);

      if (value.statusCode == 200) {
        var data = jsonDecode(alldata);
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future sellCreateOrderData(
      var lat,
      var long,
      var commodityImage,
      var commodity,
      var quantity,
      var dealType,
      var pincode,
      var salesStatus) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Map<String, String> requestHeaders = {
        'language': prefs.getString("lang").toString(),
        'Authorization': prefs.getString("token").toString(),
        'lat': lat,
        'long': long,
      };

      var request = http.MultipartRequest("POST", Uri.parse(SELL_ORDER_CREATE));
      request.fields['live_latitude'] = lat;
      request.fields['live_latitude'] = long;
      request.fields['commodity_image'] = commodityImage;
      request.fields['commodity'] = commodity;
      request.fields['quantity'] = quantity;
      request.fields['deal_type'] = dealType;
      request.fields['pincode'] = pincode;
      request.fields['sales_status'] = salesStatus;

      request.headers.addAll(requestHeaders);

      print(request.fields);
      print(SELL_ORDER_CREATE);

      var data1 = await request.send().then((value) async {
        var res = await value.stream.toBytes();
        var alldata = String.fromCharCodes(res);

        if (value.statusCode == 200) {
          var data = jsonDecode(alldata);

          return data;
        } else {
          return null;
        }
      });
      return data1;
    } catch (error) {
      return error;
    }
  }

  static Future buyCreateOrderData(var deliveryAt, var terminalId,
      var shipmentCode, var commodityId, var quantity, var price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };

    var request = http.MultipartRequest("POST", Uri.parse(BUY_ORDER_CREATE));
    request.fields['delivery_at'] = deliveryAt;
    request.fields['terminal_id'] = terminalId;
    request.fields['shipment_pincode'] = shipmentCode;
    request.fields['commodity_id'] = commodityId;
    request.fields['quantity'] = quantity;
    request.fields['price'] = price;

    request.headers.addAll(requestHeaders);

    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);

      if (value.statusCode == 200) {
        var data = jsonDecode(alldata);
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future apnafinaceListData(var url, var search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'seller_lat': prefs.getString("lat").toString(),
      'seller_long': prefs.getString("long").toString(),
    };
    var stackinwardurl = url == ""
        ? "$APANA_U_FINANCE_LIST?limit=15&page=1&search=$search"
        : "$url&search=$search&limit=15";
    print(stackinwardurl);
    print(requestHeaders);
    final res =
        await http.get(Uri.parse(stackinwardurl), headers: requestHeaders);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      return null;
    }
  }

  static Future layingAtWarehouseListService(
      var page, var commodityID, var search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'seller_lat': prefs.getString("lat").toString(),
      'seller_long': prefs.getString("long").toString(),
    };
    var URL =
        "$APNAUCOMMODITYBIDDING?limit=15&page=$page&commodity_id=$commodityID&search=$search";
    final res = await http.get(Uri.parse(URL), headers: requestHeaders);
    print(URL);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      return null;
    }
  }

  static Future<dynamic> apanaUpdateUserProfileandPassbookDataService(
      String profile,
      String passbook,
      String panCard,
      String gst,
      String aadhar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    var body = {
      "pass_book": passbook,
      "aadhar_image": aadhar,
      "profile_image": profile,
      "gst_image": gst,
      "pancard_image": panCard,
    };
    final res = await http.post(Uri.parse(APNA_U_UPDATE_USER_IMAGE),
        headers: requestHeaders, body: body);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      return null;
    }
  }

  static Future<dynamic> apanaUpdateUserDataService(
      var email,
      var whatsupNumber,
      var panNumber,
      var aadharNumber,
      var address,
      var areaVillage,
      var city,
      var district,
      var state,
      var pincode,
      File panCardImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };

    var request = http.MultipartRequest("POST", Uri.parse(APNA_U_UPDATE_USER));
    request.fields['email'] = email;
    request.fields['whatsapp'] = whatsupNumber;
    request.fields['pancard_no'] = panNumber;
    request.fields['aadhar_no'] = aadharNumber;
    request.fields['address'] = address;
    request.fields['area_vilage'] = areaVillage;
    request.fields['city'] = city;
    request.fields['district'] = district;
    request.fields['state'] = state;
    request.fields['pincode'] = pincode;

    if (panCardImage.path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
          'hidden_pancard_image', panCardImage.path));
    }

    request.headers.addAll(requestHeaders);
    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);
      if (value.statusCode == 200) {
        var data = jsonDecode(alldata);
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future<dynamic> apnauOnBookMgpLpServiceMul(
      var lpuserId,
      var commodityId,
      var quantity,
      var price,
      var salesStatus,
      var categoryImage,
      var commodityImagePath,
      var terminalId,
      var agCommission,
      var lpCommission,
      var user,
      var distance,
      var lpLat,
      var lpLong,
      var corporateUsersLat,
      var corporateUsersLong,
      var finalPrice,
      var subPrice,
      var transportPrice,
      var loadingCharge,
      var mandiTax) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };

    var request =
        http.MultipartRequest("POST", Uri.parse(APNA_U_ON_BOOK_MGP_LP));
    request.fields['lp_user_id'] = lpuserId.toString();
    request.fields['commodity_id'] = commodityId.toString();
    request.fields['quantity'] = quantity.toString();
    request.fields['price'] = price.toString();
    request.fields['sales_status'] = salesStatus.toString();
    request.fields['category_image'] = categoryImage.toString();
    request.fields['commodity_image_path'] = commodityImagePath.toString();
    request.fields['terminal_id'] = terminalId.toString();
    request.fields['ag_commission'] = agCommission.toString();
    request.fields['lp_commission'] = lpCommission.toString();
    request.fields['user'] = user.toString();
    request.fields['distance'] = distance.toString();
    request.fields['lp_lat'] = lpLat.toString();
    request.fields['lp_long'] = lpLong.toString();
    request.fields['corporate_users_lat'] = corporateUsersLat.toString();
    request.fields['corporate_users_long'] = corporateUsersLong.toString();
    request.fields['final_price'] = finalPrice.toString();
    request.fields['sub_price'] = subPrice.toString();
    request.fields['transport_price'] = transportPrice.toString();
    request.fields['loading_charge'] = loadingCharge.toString();
    request.fields['mandi_tax'] = mandiTax.toString();
    request.headers.addAll(requestHeaders);

    print(request.fields);
    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);
      if (value.statusCode == 200) {
        var data = jsonDecode(alldata);
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future<dynamic> apnauOnBookMgpLpService(
      var lpuserId,
      var commodityId,
      var quantity,
      var price,
      var salesStatus,
      var categoryImage,
      var commodityImagePath,
      var terminalId,
      var agCommission,
      var lpCommission,
      var user,
      var distance,
      var lpLat,
      var lpLong,
      var corporateUsersLat,
      var corporateUsersLong,
      var finalPrice,
      var subPrice,
      var transportPrice,
      var loadingCharge,
      var mandiTax) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };

    Map<String, String> requestBody = {
      'lp_user_id': lpuserId.toString(),
      'commodity_id': commodityId.toString(),
      'quantity': quantity.toString(),
      'price': price.toString(),
      'sales_status': salesStatus.toString(),
      'category_image': categoryImage.toString(),
      'commodity_image_path': commodityImagePath.toString(),
      'terminal_id': terminalId.toString(),
      'ag_commission': agCommission.toString(),
      'lp_commission': lpCommission.toString(),
      'user': user.toString(),
      'distance': distance.toString(),
      'lp_lat': lpLat.toString(),
      'lp_long': lpLong.toString(),
      'corporate_users_lat': corporateUsersLat.toString(),
      'corporate_users_long': corporateUsersLong.toString(),
      'final_price': finalPrice.toString(),
      'sub_price': subPrice.toString(),
      'transport_price': transportPrice.toString(),
      'loading_charge': loadingCharge.toString(),
      'mandi_tax': mandiTax.toString(),
    };

    final res = await http.post(Uri.parse(APNA_U_ON_BOOK_MGP_LP),
        headers: requestHeaders, body: requestBody);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      return null;
    }
  }

  static apnauserViewBookingService(var bookingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    final res = await http.get(
        Uri.parse("$APNA_USER_VIEW_BOOKING?booking_id=$bookingId"),
        headers: requestHeaders);
    print(res.request!.url);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data);
      return data;
    } else {
      return null;
    }
  }

  static apnauserAllBookingService(var status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    final res = await http.get(
        Uri.parse(
          "$APNA_USER_ALL_BOOKINGS?status=$status",
        ),
        headers: requestHeaders);
    print(res.request!.url);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      return null;
    }
  }

  static apnauserCancilBookingService(
      var bookingId, var lpUserId, var cancilreson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };

    var request =
        http.MultipartRequest("POST", Uri.parse(APNA_USER_CANCEL_BOOKINGS));
    request.fields['booking_id'] = bookingId;
    request.fields['lp_user_id'] = lpUserId;
    request.fields['reason'] = "";

    request.headers.addAll(requestHeaders);
    print(request.fields);
    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);
      if (value.statusCode == 200) {
        var data = jsonDecode(alldata);
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }

  static Future<dynamic> submitWeightRequst(bookingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    var body = {"booking_id": bookingId};
    final res = await http.post(Uri.parse(APNA_USER_ACCEPT_PRICE_REQUEST),
        headers: requestHeaders, body: body);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      return null;
    }
  }

  static Future<dynamic> submitPriceRequst(bookingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    var body = {"booking_id": bookingId, "Deal_Type": "LP_Deal"};
    final res = await http.post(Uri.parse(APNA_USER_ACCEPT_WEIGHT_REQUEST),
        headers: requestHeaders, body: body);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      return null;
    }
  }

  static Future commodity_data_Service(
      List commodityId, List warehouseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Authorization': prefs.getString("token").toString(),
      'seller_lat': prefs.getString("lat").toString(),
      'seller_long': prefs.getString("long").toString(),
    };
    var body = {"commodity_id": commodityId, "warehouse_id": warehouseId};

    String jsonString = jsonEncode(body);

    final res = await http.post(Uri.parse(USER_COMMODITY_DATA),
        headers: requestHeaders, body: jsonString);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      return null;
    }
  }

  static user_coomodity_list_service() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'language': prefs.getString("lang").toString(),
      'Authorization': prefs.getString("token").toString(),
      'lat': prefs.getString("lat").toString(),
      'long': prefs.getString("long").toString(),
    };
    var request = http.MultipartRequest(
      "get",
      Uri.parse(USER_COMMODITY_LIST),
    );

    request.headers.addAll(requestHeaders);
    print(requestHeaders);

    var data1 = await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);

      if (value.statusCode == 200) {
        var data = jsonDecode(alldata);
        return data;
      } else {
        return null;
      }
    });
    return data1;
  }
}
