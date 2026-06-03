// To parse this JSON data, do
//
//     final terminalsModel = terminalsModelFromMap(jsonString);

import 'dart:convert';

TerminalsModel terminalsModelFromMap(String str) =>
    TerminalsModel.fromMap(json.decode(str));

String terminalsModelToMap(TerminalsModel data) => json.encode(data.toMap());

class TerminalsModel {
  List<Terminal>? terminals;
  String? status;
  String? message;

  TerminalsModel({
    this.terminals,
    this.status,
    this.message,
  });

  factory TerminalsModel.fromMap(Map<String, dynamic> json) => TerminalsModel(
        terminals: json["terminals"] == null
            ? []
            : List<Terminal>.from(
                json["terminals"]!.map((x) => Terminal.fromMap(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "terminals": terminals == null
            ? []
            : List<dynamic>.from(terminals!.map((x) => x.toMap())),
        "status": status,
        "message": message,
      };
}

class Terminal {
  dynamic id;
  dynamic wspId;
  dynamic mandiSamitiId;
  String? warehouseCode;
  dynamic type;
  String? name;
  dynamic nameHi;
  String? facilityIds;
  String? bankIds;
  String? image;
  String? gstImage;
  dynamic gatepassStart;
  dynamic gatepassEnd;
  dynamic noOfStacks;
  dynamic dharamKanta;
  dynamic labourContractor;
  dynamic contractorPhone;
  dynamic labourRate;
  String? latitude;
  String? longitude;
  String? pincode;
  String? agrementFromDate;
  String? agrementToDate;
  String? terminalOpenDate;
  dynamic terminalCloseDate;
  dynamic rentAmount;
  String? gstArrNumber;
  dynamic agShare;
  dynamic wdraAgreement;
  String? wdraAgreementId;
  dynamic wspRent;
  dynamic fixRentPerMonth;
  dynamic minRent;
  dynamic maxRent;
  dynamic wspSharing;
  dynamic lockIn;
  dynamic mixLockIn;
  dynamic status;
  String? createdAt;
  String? updatedAt;
  MandiSamiti? mandiSamiti;
  TeminalType? teminalType;
  WarehouseRent? warehouseRent;

  Terminal({
    this.id,
    this.wspId,
    this.mandiSamitiId,
    this.warehouseCode,
    this.type,
    this.name,
    this.nameHi,
    this.facilityIds,
    this.bankIds,
    this.image,
    this.gstImage,
    this.gatepassStart,
    this.gatepassEnd,
    this.noOfStacks,
    this.dharamKanta,
    this.labourContractor,
    this.contractorPhone,
    this.labourRate,
    this.latitude,
    this.longitude,
    this.pincode,
    this.agrementFromDate,
    this.agrementToDate,
    this.terminalOpenDate,
    this.terminalCloseDate,
    this.rentAmount,
    this.gstArrNumber,
    this.agShare,
    this.wdraAgreement,
    this.wdraAgreementId,
    this.wspRent,
    this.fixRentPerMonth,
    this.minRent,
    this.maxRent,
    this.wspSharing,
    this.lockIn,
    this.mixLockIn,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.mandiSamiti,
    this.teminalType,
    this.warehouseRent,
  });

  factory Terminal.fromMap(Map<String, dynamic> json) => Terminal(
        id: json["id"],
        wspId: json["wsp_id"],
        mandiSamitiId: json["mandi_samiti_id"],
        warehouseCode: json["warehouse_code"],
        type: json["type"],
        name: json["name"],
        nameHi: json["name_hi"],
        facilityIds: json["facility_ids"],
        bankIds: json["bank_ids"],
        image: json["image"],
        gstImage: json["gst_image"],
        gatepassStart: json["gatepass_start"],
        gatepassEnd: json["gatepass_end"],
        noOfStacks: json["no_of_stacks"],
        dharamKanta: json["dharam_kanta"],
        labourContractor: json["labour_contractor"],
        contractorPhone: json["contractor_phone"],
        labourRate: json["labour_rate"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        pincode: json["pincode"],
        agrementFromDate: json["agrement_from_date"],
        agrementToDate: json["agrement_to_date"],
        terminalOpenDate: json["terminal_open_date"],
        terminalCloseDate: json["terminal_close_date"],
        rentAmount: json["rent_amount"],
        gstArrNumber: json["gst_arr_number"],
        agShare: json["ag_share"],
        wdraAgreement: json["wdra_agreement"],
        wdraAgreementId: json["wdra_agreement_id"],
        wspRent: json["wsp_rent"],
        fixRentPerMonth: json["fix_rent_per_month"],
        minRent: json["min_rent"],
        maxRent: json["max_rent"],
        wspSharing: json["wsp_sharing"],
        lockIn: json["lock_in"],
        mixLockIn: json["mix_lock_in"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        mandiSamiti: json["mandi_samiti"] == null
            ? null
            : MandiSamiti.fromMap(json["mandi_samiti"]),
        teminalType: json["teminal_type"] == null
            ? null
            : TeminalType.fromMap(json["teminal_type"]),
        warehouseRent: json["warehouse_rent"] == null
            ? null
            : WarehouseRent.fromMap(json["warehouse_rent"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "wsp_id": wspId,
        "mandi_samiti_id": mandiSamitiId,
        "warehouse_code": warehouseCode,
        "type": type,
        "name": name,
        "name_hi": nameHi,
        "facility_ids": facilityIds,
        "bank_ids": bankIds,
        "image": image,
        "gst_image": gstImage,
        "gatepass_start": gatepassStart,
        "gatepass_end": gatepassEnd,
        "no_of_stacks": noOfStacks,
        "dharam_kanta": dharamKanta,
        "labour_contractor": labourContractor,
        "contractor_phone": contractorPhone,
        "labour_rate": labourRate,
        "latitude": latitude,
        "longitude": longitude,
        "pincode": pincode,
        "agrement_from_date": agrementFromDate,
        "agrement_to_date": agrementToDate,
        "terminal_open_date": terminalOpenDate,
        "terminal_close_date": terminalCloseDate,
        "rent_amount": rentAmount,
        "gst_arr_number": gstArrNumber,
        "ag_share": agShare,
        "wdra_agreement": wdraAgreement,
        "wdra_agreement_id": wdraAgreementId,
        "wsp_rent": wspRent,
        "fix_rent_per_month": fixRentPerMonth,
        "min_rent": minRent,
        "max_rent": maxRent,
        "wsp_sharing": wspSharing,
        "lock_in": lockIn,
        "mix_lock_in": mixLockIn,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "mandi_samiti": mandiSamiti?.toMap(),
        "teminal_type": teminalType?.toMap(),
        "warehouse_rent": warehouseRent?.toMap(),
      };
}

class MandiSamiti {
  dynamic id;
  String? name;
  String? mandiSamitiClass;
  String? secretaryName;
  String? phone;
  String? stdCode;
  String? telNo;
  String? fax;
  String? email;
  dynamic address;
  dynamic district;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  MandiSamiti({
    this.id,
    this.name,
    this.mandiSamitiClass,
    this.secretaryName,
    this.phone,
    this.stdCode,
    this.telNo,
    this.fax,
    this.email,
    this.address,
    this.district,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory MandiSamiti.fromMap(Map<String, dynamic> json) => MandiSamiti(
        id: json["id"],
        name: json["name"],
        mandiSamitiClass: json["class"],
        secretaryName: json["secretary_name"],
        phone: json["phone"],
        stdCode: json["std_code"],
        telNo: json["tel_no"],
        fax: json["fax"],
        email: json["email"],
        address: json["address"],
        district: json["district"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "class": mandiSamitiClass,
        "secretary_name": secretaryName,
        "phone": phone,
        "std_code": stdCode,
        "tel_no": telNo,
        "fax": fax,
        "email": email,
        "address": address,
        "district": district,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class TeminalType {
  dynamic id;
  String? name;
  String? createdAt;
  String? updatedAt;

  TeminalType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory TeminalType.fromMap(Map<String, dynamic> json) => TeminalType(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class WarehouseRent {
  dynamic id;
  dynamic warehouseId;
  String? address;
  String? location;
  dynamic area;
  String? district;
  String? state;
  String? areaSqrFt;
  String? rentPerMonth;
  String? capacityInMt;
  String? nearbyTransporterInfo;
  String? nearbyMandiInfo;
  String? nearbyCropInfo;
  dynamic status;
  String? createdAt;
  String? updatedAt;
  Districts? districts;
  States? states;

  WarehouseRent({
    this.id,
    this.warehouseId,
    this.address,
    this.location,
    this.area,
    this.district,
    this.state,
    this.areaSqrFt,
    this.rentPerMonth,
    this.capacityInMt,
    this.nearbyTransporterInfo,
    this.nearbyMandiInfo,
    this.nearbyCropInfo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.districts,
    this.states,
  });

  factory WarehouseRent.fromMap(Map<String, dynamic> json) => WarehouseRent(
        id: json["id"],
        warehouseId: json["warehouse_id"],
        address: json["address"],
        location: json["location"],
        area: json["area"],
        district: json["district"],
        state: json["state"],
        areaSqrFt: json["area_sqr_ft"],
        rentPerMonth: json["rent_per_month"],
        capacityInMt: json["capacity_in_mt"],
        nearbyTransporterInfo: json["nearby_transporter_info"],
        nearbyMandiInfo: json["nearby_mandi_info"],
        nearbyCropInfo: json["nearby_crop_info"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        districts: json["districts"] == null
            ? null
            : Districts.fromMap(json["districts"]),
        states: json["states"] == null ? null : States.fromMap(json["states"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "warehouse_id": warehouseId,
        "address": address,
        "location": location,
        "area": area,
        "district": district,
        "state": state,
        "area_sqr_ft": areaSqrFt,
        "rent_per_month": rentPerMonth,
        "capacity_in_mt": capacityInMt,
        "nearby_transporter_info": nearbyTransporterInfo,
        "nearby_mandi_info": nearbyMandiInfo,
        "nearby_crop_info": nearbyCropInfo,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "districts": districts?.toMap(),
        "states": states?.toMap(),
      };
}

class Districts {
  dynamic id;
  dynamic stateCode;
  dynamic districtCode;
  String? name;

  Districts({
    this.id,
    this.stateCode,
    this.districtCode,
    this.name,
  });

  factory Districts.fromMap(Map<String, dynamic> json) => Districts(
        id: json["id"],
        stateCode: json["state_code"],
        districtCode: json["district_code"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "state_code": stateCode,
        "district_code": districtCode,
        "name": name,
      };
}

class States {
  dynamic id;
  String? name;
  dynamic code;
  dynamic countryId;

  States({
    this.id,
    this.name,
    this.code,
    this.countryId,
  });

  factory States.fromMap(Map<String, dynamic> json) => States(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
        "country_id": countryId,
      };
}
