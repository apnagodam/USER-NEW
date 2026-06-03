// To parse this JSON data, do
//
//     final warehouseReponseModel = warehouseReponseModelFromMap(jsonString);

import 'dart:convert';

WarehouseReponseModel warehouseReponseModelFromMap(String str) =>
    WarehouseReponseModel.fromMap(json.decode(str));

String warehouseReponseModelToMap(WarehouseReponseModel data) =>
    json.encode(data.toMap());

class WarehouseReponseModel {
  List<Terminal>? terminals;
  List<Commodite>? commodites;
  List<Employee>? employee;
  List<Labour>? labour;
  String? status;
  String? message;

  WarehouseReponseModel({
    this.terminals,
    this.commodites,
    this.employee,
    this.labour,
    this.status,
    this.message,
  });

  factory WarehouseReponseModel.fromMap(Map<String, dynamic> json) =>
      WarehouseReponseModel(
        terminals: json["terminals"] == null
            ? []
            : List<Terminal>.from(
                json["terminals"]!.map((x) => Terminal.fromMap(x))),
        commodites: json["commodites"] == null
            ? []
            : List<Commodite>.from(
                json["commodites"]!.map((x) => Commodite.fromMap(x))),
        employee: json["employee"] == null
            ? []
            : List<Employee>.from(
                json["employee"]!.map((x) => Employee.fromMap(x))),
        labour: json["labour"] == null
            ? []
            : List<Labour>.from(json["labour"]!.map((x) => Labour.fromMap(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "terminals": terminals == null
            ? []
            : List<dynamic>.from(terminals!.map((x) => x.toMap())),
        "commodites": commodites == null
            ? []
            : List<dynamic>.from(commodites!.map((x) => x.toMap())),
        "employee": employee == null
            ? []
            : List<dynamic>.from(employee!.map((x) => x.toMap())),
        "labour": labour == null
            ? []
            : List<dynamic>.from(labour!.map((x) => x.toMap())),
        "status": status,
        "message": message,
      };
}

class Commodite {
  dynamic id;
  dynamic parentCat;
  String? category;
  String? categorySName;
  String? categoryHi;
  String? commodityType;
  dynamic hsnCode;
  String? gst;
  String? gstOnRent;
  dynamic agSpotCommission;
  dynamic agEmandiCommission;
  dynamic agF2FCommission;
  String? mandiFees;
  String? loading;
  String? bardana;
  String? freight;
  dynamic stackCommQtlVal;
  dynamic firstMileRate;
  String? image;
  String? imagePath;
  dynamic sequenceId;
  dynamic isGrading;
  dynamic forGrading;
  dynamic debitNoteCharges;
  dynamic lowerCircuit;
  dynamic upperCircuit;
  dynamic isFastPath;
  DateTime? month;
  DateTime? expDate;
  dynamic isActive;
  dynamic qualityPCondition;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  Commodite({
    this.id,
    this.parentCat,
    this.category,
    this.categorySName,
    this.categoryHi,
    this.commodityType,
    this.hsnCode,
    this.gst,
    this.gstOnRent,
    this.agSpotCommission,
    this.agEmandiCommission,
    this.agF2FCommission,
    this.mandiFees,
    this.loading,
    this.bardana,
    this.freight,
    this.stackCommQtlVal,
    this.firstMileRate,
    this.image,
    this.imagePath,
    this.sequenceId,
    this.isGrading,
    this.forGrading,
    this.debitNoteCharges,
    this.lowerCircuit,
    this.upperCircuit,
    this.isFastPath,
    this.month,
    this.expDate,
    this.isActive,
    this.qualityPCondition,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  bool userFilterByCreationDate(String filter) {
    return category.toString().toLowerCase().trim().contains(filter);
  }

  factory Commodite.fromMap(Map<String, dynamic> json) => Commodite(
        id: json["id"],
        parentCat: json["parent_cat"],
        category: json["category"],
        categorySName: json["category_s_name"],
        categoryHi: json["category_hi"],
        commodityType: json["commodity_type"],
        hsnCode: json["hsn_code"],
        gst: json["gst"],
        gstOnRent: json["gst_on_rent"],
        agSpotCommission: json["ag_spot_commission"],
        agEmandiCommission: json["ag_emandi_commission"],
        agF2FCommission: json["ag_f2f_commission"],
        mandiFees: json["mandi_fees"],
        loading: json["loading"],
        bardana: json["bardana"],
        freight: json["freight"],
        stackCommQtlVal: json["stack_comm_qtl_val"],
        firstMileRate: json["first_mile_rate"],
        image: json["image"],
        imagePath: json["image_path"],
        sequenceId: json["sequence_id"],
        isGrading: json["is_grading"],
        forGrading: json["for_grading"],
        debitNoteCharges: json["debit_note_charges"],
        lowerCircuit: json["lower_circuit"],
        upperCircuit: json["upper_circuit"],
        isFastPath: json["is_fast_path"],
        month: json["month"] == null ? null : DateTime.parse(json["month"]),
        expDate:
            json["exp_date"] == null ? null : DateTime.parse(json["exp_date"]),
        isActive: json["is_active"],
        qualityPCondition: json["quality_p_condition"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "parent_cat": parentCat,
        "category": category,
        "category_s_name": categorySName,
        "category_hi": categoryHi,
        "commodity_type": commodityType,
        "hsn_code": hsnCode,
        "gst": gst,
        "gst_on_rent": gstOnRent,
        "ag_spot_commission": agSpotCommission,
        "ag_emandi_commission": agEmandiCommission,
        "ag_f2f_commission": agF2FCommission,
        "mandi_fees": mandiFees,
        "loading": loading,
        "bardana": bardana,
        "freight": freight,
        "stack_comm_qtl_val": stackCommQtlVal,
        "first_mile_rate": firstMileRate,
        "image": image,
        "image_path": imagePath,
        "sequence_id": sequenceId,
        "is_grading": isGrading,
        "for_grading": forGrading,
        "debit_note_charges": debitNoteCharges,
        "lower_circuit": lowerCircuit,
        "upper_circuit": upperCircuit,
        "is_fast_path": isFastPath,
        "month":
            "${month!.year.toString().padLeft(4, '0')}-${month!.month.toString().padLeft(2, '0')}-${month!.day.toString().padLeft(2, '0')}",
        "exp_date":
            "${expDate!.year.toString().padLeft(4, '0')}-${expDate!.month.toString().padLeft(2, '0')}-${expDate!.day.toString().padLeft(2, '0')}",
        "is_active": isActive,
        "quality_p_condition": qualityPCondition,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Employee {
  dynamic id;
  dynamic userId;
  dynamic designationId;
  String? empId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  DateTime? dob;
  DateTime? doj;
  DateTime? doe;
  String? personalPhone;
  String? address;
  String? post;
  String? bankName;
  String? branchName;
  String? accountNo;
  String? ifsCode;
  String? panCard;
  String? aadharCard;
  String? bankPassbook;
  String? passportImage;
  String? aadharImage;
  String? aadharImageB;
  String? pancardImage;
  dynamic terminal;
  dynamic sendEmail;
  String? twoWheelerRate;
  String? fourWheelerRate;
  dynamic enableByUserId;
  dynamic disableByUserId;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  Employee({
    this.id,
    this.userId,
    this.designationId,
    this.empId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.dob,
    this.doj,
    this.doe,
    this.personalPhone,
    this.address,
    this.post,
    this.bankName,
    this.branchName,
    this.accountNo,
    this.ifsCode,
    this.panCard,
    this.aadharCard,
    this.bankPassbook,
    this.passportImage,
    this.aadharImage,
    this.aadharImageB,
    this.pancardImage,
    this.terminal,
    this.sendEmail,
    this.twoWheelerRate,
    this.fourWheelerRate,
    this.enableByUserId,
    this.disableByUserId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["id"],
        userId: json["user_id"],
        designationId: json["designation_id"],
        empId: json["emp_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        doj: json["doj"] == null ? null : DateTime.parse(json["doj"]),
        doe: json["doe"] == null ? null : DateTime.parse(json["doe"]),
        personalPhone: json["personal_phone"],
        address: json["address"],
        post: json["post"],
        bankName: json["bank_name"],
        branchName: json["branch_name"],
        accountNo: json["account_no"],
        ifsCode: json["ifs_code"],
        panCard: json["pan_card"],
        aadharCard: json["aadhar_card"],
        bankPassbook: json["bank_passbook"],
        passportImage: json["passport_image"],
        aadharImage: json["aadhar_image"],
        aadharImageB: json["aadhar_image_b"],
        pancardImage: json["pancard_image"],
        terminal: json["terminal"],
        sendEmail: json["send_email"],
        twoWheelerRate: json["two_wheeler_rate"],
        fourWheelerRate: json["four_wheeler_rate"],
        enableByUserId: json["enable_by_userId"],
        disableByUserId: json["disable_by_userId"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "designation_id": designationId,
        "emp_id": empId,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "doj":
            "${doj!.year.toString().padLeft(4, '0')}-${doj!.month.toString().padLeft(2, '0')}-${doj!.day.toString().padLeft(2, '0')}",
        "doe":
            "${doe!.year.toString().padLeft(4, '0')}-${doe!.month.toString().padLeft(2, '0')}-${doe!.day.toString().padLeft(2, '0')}",
        "personal_phone": personalPhone,
        "address": address,
        "post": post,
        "bank_name": bankName,
        "branch_name": branchName,
        "account_no": accountNo,
        "ifs_code": ifsCode,
        "pan_card": panCard,
        "aadhar_card": aadharCard,
        "bank_passbook": bankPassbook,
        "passport_image": passportImage,
        "aadhar_image": aadharImage,
        "aadhar_image_b": aadharImageB,
        "pancard_image": pancardImage,
        "terminal": terminal,
        "send_email": sendEmail,
        "two_wheeler_rate": twoWheelerRate,
        "four_wheeler_rate": fourWheelerRate,
        "enable_by_userId": enableByUserId,
        "disable_by_userId": disableByUserId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Labour {
  dynamic id;
  String? contractorName;
  String? contractorPhone;
  String? location;
  String? bankName;
  String? bankIfsc;
  String? accountNo;
  String? rate;
  String? panNumber;
  String? gstNumber;
  String? aadharNo;
  String? aadharImage;
  String? pancardImage;
  String? passbookImage;
  String? power;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  Labour({
    this.id,
    this.contractorName,
    this.contractorPhone,
    this.location,
    this.bankName,
    this.bankIfsc,
    this.accountNo,
    this.rate,
    this.panNumber,
    this.gstNumber,
    this.aadharNo,
    this.aadharImage,
    this.pancardImage,
    this.passbookImage,
    this.power,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Labour.fromMap(Map<String, dynamic> json) => Labour(
        id: json["id"],
        contractorName: json["contractor_name"],
        contractorPhone: json["contractor_phone"],
        location: json["location"],
        bankName: json["bank_name"],
        bankIfsc: json["bank_ifsc"],
        accountNo: json["account_no"],
        rate: json["rate"],
        panNumber: json["pan_number"],
        gstNumber: json["gst_number"],
        aadharNo: json["aadhar_no"],
        aadharImage: json["aadhar_image"],
        pancardImage: json["pancard_image"],
        passbookImage: json["passbook_image"],
        power: json["power"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "contractor_name": contractorName,
        "contractor_phone": contractorPhone,
        "location": location,
        "bank_name": bankName,
        "bank_ifsc": bankIfsc,
        "account_no": accountNo,
        "rate": rate,
        "pan_number": panNumber,
        "gst_number": gstNumber,
        "aadhar_no": aadharNo,
        "aadhar_image": aadharImage,
        "pancard_image": pancardImage,
        "passbook_image": passbookImage,
        "power": power,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
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
  String? labourRate;
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
  String? address;
  String? location;
  dynamic area;
  String? district;
  String? state;
  String? areaSqrFt;
  String? rentPerMonth;
  String? capacityInMt;
  String? mandiSamitiName;
  dynamic dharamKantaName;

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
    this.address,
    this.location,
    this.area,
    this.district,
    this.state,
    this.areaSqrFt,
    this.rentPerMonth,
    this.capacityInMt,
    this.mandiSamitiName,
    this.dharamKantaName,
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
        address: json["address"],
        location: json["location"],
        area: json["area"],
        district: json["district"],
        state: json["state"],
        areaSqrFt: json["area_sqr_ft"],
        rentPerMonth: json["rent_per_month"],
        capacityInMt: json["capacity_in_mt"],
        mandiSamitiName: json["mandi_samiti_name"],
        dharamKantaName: json["dharam_kanta_name"],
      );
  bool userFilterByCreationDate(String filter) {
    return name.toString().toLowerCase().trim().contains(filter);
  }

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
        "address": address,
        "location": location,
        "area": area,
        "district": district,
        "state": state,
        "area_sqr_ft": areaSqrFt,
        "rent_per_month": rentPerMonth,
        "capacity_in_mt": capacityInMt,
        "mandi_samiti_name": mandiSamitiName,
        "dharam_kanta_name": dharamKantaName,
      };
}
