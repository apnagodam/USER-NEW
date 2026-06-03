// To parse this JSON data, do
//
//     final caseIdStatusModel = caseIdStatusModelFromJson(jsonString);

import 'dart:convert';

CaseIdStatusModel caseIdStatusModelFromJson(String str) =>
    CaseIdStatusModel.fromJson(json.decode(str));

String caseIdStatusModelToJson(CaseIdStatusModel data) =>
    json.encode(data.toJson());

class CaseIdStatusModel {
  dynamic status;
  dynamic message;
  List<CaseIdDatum>? data;

  CaseIdStatusModel({
    this.status,
    this.message,
    this.data,
  });

  factory CaseIdStatusModel.fromJson(Map<String, dynamic> json) =>
      CaseIdStatusModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CaseIdDatum>.from(json["data"]!.map((x) => CaseIdDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CaseIdDatum {
  dynamic id;
  dynamic caseId;
  dynamic gatePass;
  dynamic inOut;
  dynamic customerUid;
  dynamic commodityId;
  dynamic terminalId;
  dynamic stackRowId;
  dynamic stackNumber;
  dynamic totalWeight;
  dynamic vehicleNo;
  dynamic noOfBags;
  dynamic driverPhone;
  dynamic cancelNotes;
  dynamic spotToken;
  dynamic isRed;
  dynamic staffId;
  dynamic tripId;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic phone;
  dynamic custFname;
  dynamic cateName;
  dynamic commodityType;
  dynamic warehouseCode;
  dynamic terminalName;
  dynamic truckbook;
  dynamic truckbookDate;
  dynamic labourbook;
  dynamic labourbookDate;
  dynamic firstKantaParchi;
  dynamic fqTagging;
  dynamic firstKantaParchiDate;
  dynamic firstKantaDhramkanta;
  dynamic firstQuality;
  dynamic firstQualityDate;
  dynamic sKParchi;
  dynamic sKParchiDate;
  dynamic sKDhramkanta;
  dynamic sKPAvgWeight;
  dynamic sQualityReport;
  dynamic sQualityDate;
  dynamic sendToLab;
  dynamic cctvDate;
  dynamic cctvReport;
  dynamic ivrReport;
  dynamic gatepassReport;

  CaseIdDatum({
    this.id,
    this.caseId,
    this.gatePass,
    this.inOut,
    this.customerUid,
    this.commodityId,
    this.terminalId,
    this.stackRowId,
    this.stackNumber,
    this.totalWeight,
    this.vehicleNo,
    this.noOfBags,
    this.driverPhone,
    this.cancelNotes,
    this.spotToken,
    this.isRed,
    this.staffId,
    this.tripId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.custFname,
    this.cateName,
    this.commodityType,
    this.warehouseCode,
    this.terminalName,
    this.truckbook,
    this.truckbookDate,
    this.labourbook,
    this.labourbookDate,
    this.firstKantaParchi,
    this.fqTagging,
    this.firstKantaParchiDate,
    this.firstKantaDhramkanta,
    this.firstQuality,
    this.firstQualityDate,
    this.sKParchi,
    this.sKParchiDate,
    this.sKDhramkanta,
    this.sKPAvgWeight,
    this.sQualityReport,
    this.sQualityDate,
    this.sendToLab,
    this.cctvDate,
    this.cctvReport,
    this.ivrReport,
    this.gatepassReport,
  });

  factory CaseIdDatum.fromJson(Map<String, dynamic> json) => CaseIdDatum(
        id: json["id"],
        caseId: json["case_id"],
        gatePass: json["gate_pass"],
        inOut: json["in_out"],
        customerUid: json["customer_uid"],
        commodityId: json["commodity_id"],
        terminalId: json["terminal_id"],
        stackRowId: json["stack_row_id"],
        stackNumber: json["stack_number"],
        totalWeight: json["total_weight"],
        vehicleNo: json["vehicle_no"],
        noOfBags: json["no_of_bags"],
        driverPhone: json["driver_phone"],
        cancelNotes: json["cancel_notes"],
        spotToken: json["spot_token"],
        isRed: json["is_red"],
        staffId: json["staff_id"],
        tripId: json["trip_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        phone: json["phone"],
        custFname: json["cust_fname"],
        cateName: json["cate_name"],
        commodityType: json["commodity_type"],
        warehouseCode: json["warehouse_code"],
        terminalName: json["terminal_name"],
        truckbook: json["truckbook"],
        truckbookDate: json["truckbook_date"],
        labourbook: json["labourbook"],
        labourbookDate: json["labourbook_date"],
        firstKantaParchi: json["first_kanta_parchi"],
        fqTagging: json['f_q_tagging'],
        firstKantaParchiDate: json["first_kanta_parchi_date"],
        firstKantaDhramkanta: json["first_kanta_dhramkanta"],
        firstQuality: json["first_quality"],
        firstQualityDate: json["first_quality_date"],
        sKParchi: json["s_k_parchi"],
        sKParchiDate: json["s_k_parchi_date"],
        sKDhramkanta: json["s_k_dhramkanta"],
        sKPAvgWeight: json["s_k_p_avg_weight"],
        sQualityReport: json["s_quality_report"],
        sQualityDate: json["s_quality_date"],
        sendToLab: json["send_to_lab"],
        cctvDate: json["cctv_date"],
        ivrReport: json['ivr_report'],
        cctvReport: json["cctv_report"],
        gatepassReport: json["gatepass_report"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "case_id": caseId,
        "gate_pass": gatePass,
        "in_out": inOut,
        "customer_uid": customerUid,
        "commodity_id": commodityId,
        "terminal_id": terminalId,
        "stack_row_id": stackRowId,
        "stack_number": stackNumber,
        "total_weight": totalWeight,
        "vehicle_no": vehicleNo,
        "no_of_bags": noOfBags,
        "driver_phone": driverPhone,
        "cancel_notes": cancelNotes,
        "spot_token": spotToken,
        "is_red": isRed,
        "staff_id": staffId,
        "trip_id": tripId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "phone": phone,
        "cust_fname": custFname,
        "cate_name": cateName,
        "commodity_type": commodityType,
        "warehouse_code": warehouseCode,
        "terminal_name": terminalName,
        "truckbook": truckbook,
        "truckbook_date": truckbookDate,
        "labourbook": labourbook,
        "labourbook_date": labourbookDate,
        "first_kanta_parchi": firstKantaParchi,
        "f_q_tagging": fqTagging,
        "first_kanta_parchi_date": firstKantaParchiDate,
        "first_kanta_dhramkanta": firstKantaDhramkanta,
        "first_quality": firstQuality,
        "first_quality_date": firstQualityDate,
        "s_k_parchi": sKParchi,
        "s_k_parchi_date": sKParchiDate,
        "s_k_dhramkanta": sKDhramkanta,
        "s_k_p_avg_weight": sKPAvgWeight,
        "s_quality_report": sQualityReport,
        "s_quality_date": sQualityDate,
        "send_to_lab": sendToLab,
        "cctv_date": cctvDate,
        "cctv_report": cctvReport,
        "ivr_report": ivrReport,
        "gatepass_report": gatepassReport,
      };
}
