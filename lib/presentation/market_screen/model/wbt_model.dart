// To parse this JSON data, do
//
//     final wbtModel = wbtModelFromMap(jsonString);

import 'dart:convert';

WbtModel wbtModelFromMap(String str) => WbtModel.fromMap(json.decode(str));

String wbtModelToMap(WbtModel data) => json.encode(data.toMap());

class WbtModel {
  dynamic status;
  dynamic message;
  List<Datum>? data;

  WbtModel({
    this.status,
    this.message,
    this.data,
  });

  factory WbtModel.fromMap(Map<String, dynamic> json) => WbtModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] is List
            ? List<Datum>.from((json["data"] as List)
                .map((x) => Datum.fromMap(x as Map<String, dynamic>)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  dynamic id;
  dynamic sellerId;
  dynamic sellerCatId;
  dynamic bidStatus;
  dynamic quantity;
  dynamic price;
  dynamic gatepass;
  dynamic warehouse;
  dynamic commodity;
  dynamic expDate;
  dynamic image;
  dynamic salesStatus;
  dynamic buyerPrice;
  dynamic cFirstPrice;
  dynamic cSecondPrice;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic modalPrice;
  dynamic ltp;
  dynamic secondLtp;
  dynamic isActive;
  dynamic priceDif;
  dynamic sellerIsActive;
  dynamic sellerPrice;
  dynamic sellerPriceDiff;
  dynamic state;
  dynamic warehouseCode;
  List<Conversation>? conversation;
  Inventory? inventory;

  Datum({
    this.id,
    this.sellerId,
    this.sellerCatId,
    this.bidStatus,
    this.quantity,
    this.price,
    this.gatepass,
    this.warehouse,
    this.commodity,
    this.expDate,
    this.image,
    this.salesStatus,
    this.buyerPrice,
    this.cFirstPrice,
    this.cSecondPrice,
    this.minPrice,
    this.maxPrice,
    this.modalPrice,
    this.ltp,
    this.secondLtp,
    this.isActive,
    this.priceDif,
    this.sellerIsActive,
    this.sellerPrice,
    this.sellerPriceDiff,
    this.state,
    this.warehouseCode,
    this.conversation,
    this.inventory,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sellerId: json["seller_id"],
        sellerCatId: json["seller_cat_id"],
        bidStatus: json["bid_status"],
        quantity: json["quantity"],
        price: json["price"],
        gatepass: json["gatepass"],
        warehouse: json["warehouse"],
        commodity: json["commodity"],
        expDate: json["exp_date"],
        image: json["image"],
        salesStatus: json["sales_status"],
        buyerPrice: json["buyer_price"],
        cFirstPrice: json["c_first_price"],
        cSecondPrice: json["c_second_price"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        modalPrice: json["modal_price"],
        ltp: json["ltp"],
        secondLtp: json["second_ltp"],
        isActive: json["is_active"],
        priceDif: json["price_dif"],
        sellerIsActive: json["seller_is_active"],
        sellerPrice: json["seller_price"],
        sellerPriceDiff: json["seller_price_diff"],
        state: json["state"],
        warehouseCode: json["warehouse_code"],
        conversation: json["conversation"] is List
            ? List<Conversation>.from((json["conversation"] as List)
                .map((x) => Conversation.fromMap(x as Map<String, dynamic>)))
            : [],
        inventory: json["inventory"] is Map
            ? Inventory.fromMap(json["inventory"] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "seller_id": sellerId,
        "seller_cat_id": sellerCatId,
        "bid_status": bidStatus,
        "quantity": quantity,
        "price": price,
        "gatepass": gatepass,
        "warehouse": warehouse,
        "commodity": commodity,
        "exp_date": expDate,
        "image": image,
        "sales_status": salesStatus,
        "buyer_price": buyerPrice,
        "c_first_price": cFirstPrice,
        "c_second_price": cSecondPrice,
        "min_price": minPrice,
        "max_price": maxPrice,
        "modal_price": modalPrice,
        "ltp": ltp,
        "second_ltp": secondLtp,
        "is_active": isActive,
        "price_dif": priceDif,
        "seller_is_active": sellerIsActive,
        "seller_price": sellerPrice,
        "seller_price_diff": sellerPriceDiff,
        "state": state,
        "warehouse_code": warehouseCode,
        "conversation": conversation == null
            ? []
            : List<dynamic>.from(conversation!.map((x) => x.toMap())),
        "inventory": inventory?.toMap(),
      };
}

class Conversation {
  dynamic id;
  dynamic buySellId;
  dynamic userId;
  dynamic price;
  dynamic isSecure;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Conversation({
    this.id,
    this.buySellId,
    this.userId,
    this.price,
    this.isSecure,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Conversation.fromMap(Map<String, dynamic> json) => Conversation(
        id: json["id"],
        buySellId: json["buy_sell_id"],
        userId: json["user_id"],
        price: json["price"],
        isSecure: json["is_secure"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "buy_sell_id": buySellId,
        "user_id": userId,
        "price": price,
        "is_secure": isSecure,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Inventory {
  dynamic id;
  dynamic userId;
  dynamic caseId;
  dynamic warehouseId;
  dynamic commodity;
  dynamic weightBridgeNo;
  dynamic truckNo;
  dynamic stackNo;
  dynamic lotNo;
  dynamic netWeight;
  dynamic type;
  dynamic quantity;
  dynamic bags;
  dynamic sellQuantity;
  dynamic price;
  dynamic gatePassWr;
  dynamic qualityCategory;
  dynamic origin;
  dynamic image;
  dynamic file;
  dynamic rentRowId;
  dynamic interestRowId;
  dynamic mandiAmount;
  dynamic settlmentAmount;
  dynamic remAmount;
  dynamic lessOldNegWalletSattlement;
  dynamic walletSatlementAmount;
  dynamic isLiquidation;
  dynamic rentRate;
  dynamic salesStatus;
  dynamic lienBeg;
  dynamic unlienBeg;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  Warehouse? warehouse;
  Category? category;

  Inventory({
    this.id,
    this.userId,
    this.caseId,
    this.warehouseId,
    this.commodity,
    this.weightBridgeNo,
    this.truckNo,
    this.stackNo,
    this.lotNo,
    this.netWeight,
    this.type,
    this.quantity,
    this.bags,
    this.sellQuantity,
    this.price,
    this.gatePassWr,
    this.qualityCategory,
    this.origin,
    this.image,
    this.file,
    this.rentRowId,
    this.interestRowId,
    this.mandiAmount,
    this.settlmentAmount,
    this.remAmount,
    this.lessOldNegWalletSattlement,
    this.walletSatlementAmount,
    this.isLiquidation,
    this.rentRate,
    this.salesStatus,
    this.lienBeg,
    this.unlienBeg,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.warehouse,
    this.category,
  });

  factory Inventory.fromMap(Map<String, dynamic> json) => Inventory(
        id: json["id"],
        userId: json["user_id"],
        caseId: json["case_id"],
        warehouseId: json["warehouse_id"],
        commodity: json["commodity"],
        weightBridgeNo: json["weight_bridge_no"],
        truckNo: json["truck_no"],
        stackNo: json["stack_no"],
        lotNo: json["lot_no"],
        netWeight: json["net_weight"],
        type: json["type"],
        quantity: json["quantity"],
        bags: json["bags"],
        sellQuantity: json["sell_quantity"],
        price: json["price"],
        gatePassWr: json["gate_pass_wr"],
        qualityCategory: json["quality_category"],
        origin: json["origin"],
        image: json["image"],
        file: json["file"],
        rentRowId: json["rent_row_id"],
        interestRowId: json["interest_row_id"],
        mandiAmount: json["mandi_amount"],
        settlmentAmount: json["settlment_amount"],
        remAmount: json["rem_amount"],
        lessOldNegWalletSattlement: json["less_old_neg_wallet_sattlement"],
        walletSatlementAmount: json["walletSatlementAmount"],
        isLiquidation: json["is_liquidation"],
        rentRate: json["rent_rate"],
        salesStatus: json["sales_status"],
        lienBeg: json["lien_beg"],
        unlienBeg: json["unlien_beg"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        warehouse: json["warehouse"] is Map
            ? Warehouse.fromMap(json["warehouse"] as Map<String, dynamic>)
            : null,
        category: json["category"] is Map
            ? Category.fromMap(json["category"] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "case_id": caseId,
        "warehouse_id": warehouseId,
        "commodity": commodity,
        "weight_bridge_no": weightBridgeNo,
        "truck_no": truckNo,
        "stack_no": stackNo,
        "lot_no": lotNo,
        "net_weight": netWeight,
        "type": type,
        "quantity": quantity,
        "bags": bags,
        "sell_quantity": sellQuantity,
        "price": price,
        "gate_pass_wr": gatePassWr,
        "quality_category": qualityCategory,
        "origin": origin,
        "image": image,
        "file": file,
        "rent_row_id": rentRowId,
        "interest_row_id": interestRowId,
        "mandi_amount": mandiAmount,
        "settlment_amount": settlmentAmount,
        "rem_amount": remAmount,
        "less_old_neg_wallet_sattlement": lessOldNegWalletSattlement,
        "walletSatlementAmount": walletSatlementAmount,
        "is_liquidation": isLiquidation,
        "rent_rate": rentRate,
        "sales_status": salesStatus,
        "lien_beg": lienBeg,
        "unlien_beg": unlienBeg,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "warehouse": warehouse?.toMap(),
        "category": category?.toMap(),
      };
}

class Category {
  dynamic id;
  dynamic parentCat;
  dynamic category;
  dynamic categorySName;
  dynamic categoryHi;
  dynamic commodityType;
  dynamic hsnCode;
  dynamic gst;
  dynamic gstOnRent;
  dynamic agSpotCommission;
  dynamic agEmandiCommission;
  dynamic agF2FCommission;
  dynamic mandiFees;
  dynamic loading;
  dynamic bardana;
  dynamic freight;
  dynamic stackCommQtlVal;
  dynamic firstMileRate;
  dynamic image;
  dynamic imagePath;
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
  dynamic createdAt;
  dynamic updatedAt;

  Category({
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

  factory Category.fromMap(Map<String, dynamic> json) => Category(
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
        month: json["month"] == null || json["month"].toString().isEmpty
            ? null
            : DateTime.tryParse(json["month"].toString()),
        expDate: json["exp_date"] == null || json["exp_date"].toString().isEmpty
            ? null
            : DateTime.tryParse(json["exp_date"].toString()),
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
        "month": month == null
            ? null
            : "${month!.year.toString().padLeft(4, '0')}-${month!.month.toString().padLeft(2, '0')}-${month!.day.toString().padLeft(2, '0')}",
        "exp_date": expDate == null
            ? null
            : "${expDate!.year.toString().padLeft(4, '0')}-${expDate!.month.toString().padLeft(2, '0')}-${expDate!.day.toString().padLeft(2, '0')}",
        "is_active": isActive,
        "quality_p_condition": qualityPCondition,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Warehouse {
  dynamic id;
  dynamic wspId;
  dynamic mandiSamitiId;
  dynamic warehouseCode;
  dynamic type;
  dynamic name;
  dynamic nameHi;
  dynamic facilityIds;
  dynamic bankIds;
  dynamic image;
  dynamic gstImage;
  dynamic gatepassStart;
  dynamic gatepassEnd;
  dynamic noOfStacks;
  dynamic dharamKanta;
  dynamic labourContractor;
  dynamic contractorPhone;
  dynamic labourRate;
  dynamic latitude;
  dynamic longitude;
  dynamic pincode;
  dynamic agrementFromDate;
  dynamic agrementToDate;
  dynamic terminalOpenDate;
  dynamic terminalCloseDate;
  dynamic rentAmount;
  dynamic gstArrNumber;
  dynamic agShare;
  dynamic wdraAgreement;
  dynamic wdraAgreementId;
  dynamic wspRent;
  dynamic fixRentPerMonth;
  dynamic minRent;
  dynamic maxRent;
  dynamic wspSharing;
  dynamic lockIn;
  dynamic mixLockIn;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  WarehouseRent? warehouseRent;

  Warehouse({
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
    this.warehouseRent,
  });

  factory Warehouse.fromMap(Map<String, dynamic> json) => Warehouse(
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
        warehouseRent: json["warehouse_rent"] is Map
            ? WarehouseRent.fromMap(json["warehouse_rent"] as Map<String, dynamic>)
            : null,
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
        "warehouse_rent": warehouseRent?.toMap(),
      };
}

class WarehouseRent {
  dynamic id;
  dynamic warehouseId;
  dynamic address;
  dynamic location;
  dynamic area;
  dynamic district;
  dynamic state;
  dynamic areaSqrFt;
  dynamic rentPerMonth;
  dynamic capacityInMt;
  dynamic nearbyTransporterInfo;
  dynamic nearbyMandiInfo;
  dynamic nearbyCropInfo;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  Districts? districts;

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
        districts: json["districts"] is Map
            ? Districts.fromMap(json["districts"] as Map<String, dynamic>)
            : null,
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
      };
}

class Districts {
  dynamic id;
  dynamic stateCode;
  dynamic districtCode;
  dynamic name;

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
