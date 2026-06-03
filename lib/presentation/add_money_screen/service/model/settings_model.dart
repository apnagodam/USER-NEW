// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromMap(jsonString);

import 'dart:convert';

SettingsModel settingsModelFromMap(String str) => SettingsModel.fromMap(json.decode(str));

String settingsModelToMap(SettingsModel data) => json.encode(data.toMap());

class SettingsModel {
  Settings? settings;
  String? status;
  String? message;

  SettingsModel({
    this.settings,
    this.status,
    this.message,
  });

  factory SettingsModel.fromMap(Map<String, dynamic> json) => SettingsModel(
    settings: json["settings"] == null ? null : Settings.fromMap(json["settings"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "settings": settings?.toMap(),
    "status": status,
    "message": message,
  };
}

class Settings {
  dynamic id;
  String? loadingCharge;
  dynamic caseLabourRate;
  dynamic agCommission;
  dynamic dodoMaxWeight;
  dynamic agEmandiCommission;
  dynamic agSpotCommission;
  dynamic agLogisticMarkup;
  dynamic lpRange;
  dynamic routeRange;
  dynamic buyerMinQuantity;
  dynamic sellerMinQuantity;
  dynamic firstMileDistance;
  dynamic lpCommission;
  dynamic bnplLimit;
  dynamic bnplInterestRate;
  dynamic minLtv;
  dynamic redGatepassQuantity;
  dynamic intentionLpLimit;
  String? accountHolder;
  String? accountNumber;
  String? ifsc;
  String? bank;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  Settings({
    this.id,
    this.loadingCharge,
    this.caseLabourRate,
    this.agCommission,
    this.dodoMaxWeight,
    this.agEmandiCommission,
    this.agSpotCommission,
    this.agLogisticMarkup,
    this.lpRange,
    this.routeRange,
    this.buyerMinQuantity,
    this.sellerMinQuantity,
    this.firstMileDistance,
    this.lpCommission,
    this.bnplLimit,
    this.bnplInterestRate,
    this.minLtv,
    this.redGatepassQuantity,
    this.intentionLpLimit,
    this.accountHolder,
    this.accountNumber,
    this.ifsc,
    this.bank,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Settings.fromMap(Map<String, dynamic> json) => Settings(
    id: json["id"],
    loadingCharge: json["loading_charge"],
    caseLabourRate: json["case_labour_rate"],
    agCommission: json["ag_commission"],
    dodoMaxWeight: json["dodo_max_weight"],
    agEmandiCommission: json["ag_emandi_commission"],
    agSpotCommission: json["ag_spot_commission"],
    agLogisticMarkup: json["ag_logistic_markup"],
    lpRange: json["lp_range"],
    routeRange: json["route_range"],
    buyerMinQuantity: json["buyer_min_quantity"],
    sellerMinQuantity: json["seller_min_quantity"],
    firstMileDistance: json["first_mile_distance"],
    lpCommission: json["lp_commission"],
    bnplLimit: json["bnpl_limit"],
    bnplInterestRate: json["bnpl_interest_rate"],
    minLtv: json["min_ltv"],
    redGatepassQuantity: json["red_gatepass_quantity"],
    intentionLpLimit: json["intention_lp_limit"],
    accountHolder: json["account_holder"],
    accountNumber: json["account_number"],
    ifsc: json["ifsc"],
    bank: json["bank"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "loading_charge": loadingCharge,
    "case_labour_rate": caseLabourRate,
    "ag_commission": agCommission,
    "dodo_max_weight": dodoMaxWeight,
    "ag_emandi_commission": agEmandiCommission,
    "ag_spot_commission": agSpotCommission,
    "ag_logistic_markup": agLogisticMarkup,
    "lp_range": lpRange,
    "route_range": routeRange,
    "buyer_min_quantity": buyerMinQuantity,
    "seller_min_quantity": sellerMinQuantity,
    "first_mile_distance": firstMileDistance,
    "lp_commission": lpCommission,
    "bnpl_limit": bnplLimit,
    "bnpl_interest_rate": bnplInterestRate,
    "min_ltv": minLtv,
    "red_gatepass_quantity": redGatepassQuantity,
    "intention_lp_limit": intentionLpLimit,
    "account_holder": accountHolder,
    "account_number": accountNumber,
    "ifsc": ifsc,
    "bank": bank,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
