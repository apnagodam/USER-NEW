// To parse this JSON data, do
//
//     final lpResponseModel = lpResponseModelFromMap(jsonString);

import 'dart:convert';

LpResponseModel lpResponseModelFromMap(String str) => LpResponseModel.fromMap(json.decode(str));

String lpResponseModelToMap(LpResponseModel data) => json.encode(data.toMap());

class LpResponseModel {
  List<CorporateBuyer>? corporateBuyer;
  List<BuyersList>? buyersList;
  List<LpList>? lpList;
  dynamic status;
  dynamic message;

  LpResponseModel({
    this.corporateBuyer,
    this.buyersList,
    this.lpList,
    this.status,
    this.message,
  });

  factory LpResponseModel.fromMap(Map<String, dynamic> json) => LpResponseModel(
    corporateBuyer: json["corporate_buyer"] == null ? [] : List<CorporateBuyer>.from(json["corporate_buyer"]!.map((x) => CorporateBuyer.fromMap(x))),
    buyersList: json["buyers_list"] == null ? [] : List<BuyersList>.from(json["buyers_list"]!.map((x) => BuyersList.fromMap(x))),
    lpList: json["lp_list"] == null ? [] : List<LpList>.from(json["lp_list"]!.map((x) => LpList.fromMap(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "corporate_buyer": corporateBuyer == null ? [] : List<dynamic>.from(corporateBuyer!.map((x) => x.toMap())),
    "buyers_list": buyersList == null ? [] : List<dynamic>.from(buyersList!.map((x) => x.toMap())),
    "lp_list": lpList == null ? [] : List<dynamic>.from(lpList!.map((x) => x.toMap())),
    "status": status,
    "message": message,
  };
}

class BuyersList {
  dynamic name;
  dynamic price;
  dynamic warehouse;
  dynamic commodityHi;
  dynamic commodity;
  dynamic commodityImagePath;

  BuyersList({
    this.name,
    this.price,
    this.warehouse,
    this.commodityHi,
    this.commodity,
    this.commodityImagePath,
  });

  factory BuyersList.fromMap(Map<String, dynamic> json) => BuyersList(
    name: json["name"],
    price: json["price"],
    warehouse: json["warehouse"],
    commodityHi: json["commodity_hi"],
    commodity: json["commodity"],
    commodityImagePath: json["commodity_image_path"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "price": price,
    "warehouse": warehouse,
    "commodity_hi": commodityHi,
    "commodity": commodity,
    "commodity_image_path": commodityImagePath,
  };
}

class CorporateBuyer {
  dynamic commodityId;
  dynamic category;
  dynamic categoryImage;
  dynamic categoryHi;
  dynamic commodityImagePath;
  dynamic terminalId;
  dynamic mandiTax;
  dynamic user;
  dynamic price;
  dynamic quantity;
  dynamic corporateUsersLat;
  dynamic corporateUsersLong;
  dynamic pincode;
  dynamic location;
  dynamic warehouseName;
  dynamic distance;
  dynamic salesStatus;
  dynamic transportPrice;
  dynamic loadingCharge;
  dynamic agCommission;
  dynamic lpCommission;
  dynamic subPrice;
  dynamic deliveryPrice;
  dynamic finalPrice;

  CorporateBuyer({
    this.commodityId,
    this.category,
    this.categoryImage,
    this.categoryHi,
    this.commodityImagePath,
    this.terminalId,
    this.mandiTax,
    this.user,
    this.price,
    this.quantity,
    this.corporateUsersLat,
    this.corporateUsersLong,
    this.pincode,
    this.location,
    this.warehouseName,
    this.distance,
    this.salesStatus,
    this.transportPrice,
    this.loadingCharge,
    this.agCommission,
    this.lpCommission,
    this.subPrice,
    this.deliveryPrice,
    this.finalPrice,
  });

  factory CorporateBuyer.fromMap(Map<String, dynamic> json) => CorporateBuyer(
    commodityId: json["commodity_id"],
    category: json["category"],
    categoryImage: json["category_image"],
    categoryHi: json["category_hi"],
    commodityImagePath: json["commodity_image_path"],
    terminalId: json["terminal_id"],
    mandiTax: json["mandi_tax"],
    user: json["user"],
    price: json["price"],
    quantity: json["quantity"],
    corporateUsersLat: json["corporate_users_lat"],
    corporateUsersLong: json["corporate_users_long"],
    pincode: json["pincode"],
    location: json["location"],
    warehouseName: json["warehouse_name"],
    distance: json["distance"],
    salesStatus: json["sales_status"],
    transportPrice: json["transport_price"],
    loadingCharge: json["loading_charge"],
    agCommission: json["ag_commission"],
    lpCommission: json["lp_commission"],
    subPrice: json["sub_price"],
    deliveryPrice: json["delivery_price"],
    finalPrice: json["final_price"],
  );

  Map<String, dynamic> toMap() => {
    "commodity_id": commodityId,
    "category": category,
    "category_image": categoryImage,
    "category_hi": categoryHi,
    "commodity_image_path": commodityImagePath,
    "terminal_id": terminalId,
    "mandi_tax": mandiTax,
    "user": user,
    "price": price,
    "quantity": quantity,
    "corporate_users_lat": corporateUsersLat,
    "corporate_users_long": corporateUsersLong,
    "pincode": pincode,
    "location": location,
    "warehouse_name": warehouseName,
    "distance": distance,
    "sales_status": salesStatus,
    "transport_price": transportPrice,
    "loading_charge": loadingCharge,
    "ag_commission": agCommission,
    "lp_commission": lpCommission,
    "sub_price": subPrice,
    "delivery_price": deliveryPrice,
    "final_price": finalPrice,
  };
}

class LpList {
  dynamic lpUserId;
  dynamic uniqueId;
  dynamic autoAccept;
  dynamic phone;
  dynamic liveLat;
  dynamic liveLong;
  dynamic name;
  dynamic vehicleId;
  dynamic vehicleType;
  dynamic passportImage;
  dynamic distance;
  dynamic finalPrice;
  dynamic commodityId;
  dynamic quantity;
  dynamic price;
  dynamic userPrice;
  dynamic salesStatus;
  dynamic categoryImage;
  dynamic commodityImagePath;
  dynamic terminalId;
  dynamic agCommission;
  dynamic lpCommission;
  dynamic lpLat;
  dynamic lpLong;
  dynamic corporateUsersLat;
  dynamic corporateUsersLong;
  dynamic subPrice;
  dynamic transportPrice;
  dynamic loadingCharge;
  dynamic mandiTax;
  dynamic user;
  dynamic warehouseName;
  dynamic location;

  LpList({
    this.lpUserId,
    this.uniqueId,
    this.autoAccept,
    this.phone,
    this.liveLat,
    this.liveLong,
    this.name,
    this.vehicleId,
    this.vehicleType,
    this.passportImage,
    this.distance,
    this.finalPrice,
    this.commodityId,
    this.quantity,
    this.price,
    this.userPrice,
    this.salesStatus,
    this.categoryImage,
    this.commodityImagePath,
    this.terminalId,
    this.agCommission,
    this.lpCommission,
    this.lpLat,
    this.lpLong,
    this.corporateUsersLat,
    this.corporateUsersLong,
    this.subPrice,
    this.transportPrice,
    this.loadingCharge,
    this.mandiTax,
    this.user,
    this.warehouseName,
    this.location,
  });

  factory LpList.fromMap(Map<String, dynamic> json) => LpList(
    lpUserId: json["lp_user_id"],
    uniqueId: json["unique_id"],
    autoAccept: json["auto_accept"],
    phone: json["phone"],
    liveLat: json["live_lat"],
    liveLong: json["live_long"],
    name: json["name"],
    vehicleId: json["vehicle_id"],
    vehicleType: json["vehicle_type"],
    passportImage: json["passport_image"],
    distance: json["distance"],
    finalPrice: json["final_price"],
    commodityId: json["commodity_id"],
    quantity: json["quantity"],
    price: json["price"],
    userPrice: json['user_price'],
    salesStatus: json["sales_status"],
    categoryImage: json["category_image"],
    commodityImagePath: json["commodity_image_path"],
    terminalId: json["terminal_id"],
    agCommission: json["ag_commission"],
    lpCommission: json["lp_commission"],
    lpLat: json["lp_lat"],
    lpLong: json["lp_long"],
    corporateUsersLat: json["corporate_users_lat"],
    corporateUsersLong: json["corporate_users_long"],
    subPrice: json["sub_price"],
    transportPrice: json["transport_price"],
    loadingCharge: json["loading_charge"],
    mandiTax: json["mandi_tax"],
    user: json["user"],
    warehouseName: json["warehouse_name"],
    location: json["location"],
  );

  Map<String, dynamic> toMap() => {
    "lp_user_id": lpUserId,
    "unique_id": uniqueId,
    "auto_accept": autoAccept,
    "phone": phone,
    "live_lat": liveLat,
    "live_long": liveLong,
    "name": name,
    "vehicle_id": vehicleId,
    "vehicle_type": vehicleType,
    "passport_image": passportImage,
    "distance": distance,
    "final_price": finalPrice,
    "commodity_id": commodityId,
    "quantity": quantity,
    "price": price,
    "user_price":userPrice,
    "sales_status": salesStatus,
    "category_image": categoryImage,
    "commodity_image_path": commodityImagePath,
    "terminal_id": terminalId,
    "ag_commission": agCommission,
    "lp_commission": lpCommission,
    "lp_lat": lpLat,
    "lp_long": lpLong,
    "corporate_users_lat": corporateUsersLat,
    "corporate_users_long": corporateUsersLong,
    "sub_price": subPrice,
    "transport_price": transportPrice,
    "loading_charge": loadingCharge,
    "mandi_tax": mandiTax,
    "user": user,
    "warehouse_name": warehouseName,
    "location": location,
  };
}
