// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromMap(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromMap(String str) =>
    UserDetailsModel.fromMap(json.decode(str));

String userDetailsModelToMap(UserDetailsModel data) =>
    json.encode(data.toMap());

class UserDetailsModel {
  UserDetails? userDetails;
  dynamic status;
  dynamic message;

  UserDetailsModel({
    this.userDetails,
    this.status,
    this.message,
  });

  factory UserDetailsModel.fromMap(Map<String, dynamic> json) =>
      UserDetailsModel(
        userDetails: json["user_details"] == null
            ? null
            : UserDetails.fromMap(json["user_details"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "user_details": userDetails?.toMap(),
        "status": status,
        "message": message,
      };
}

class UserDetails {
  dynamic id;
  dynamic userId;
  dynamic userType;
  dynamic fname;
  dynamic lname;
  dynamic email;
  dynamic phone;
  dynamic altNumber;
  dynamic whatsapp;
  dynamic dob;
  dynamic referralCode;
  dynamic referralBy;
  dynamic fatherName;
  dynamic category;
  dynamic gstNumber;
  dynamic khasraNo;
  dynamic village;
  dynamic tehsil;
  dynamic district;
  dynamic image;
  dynamic power;
  dynamic holdPower;
  dynamic bnplPowerLimit;
  dynamic bnplPower;
  dynamic bnplUsedPower;
  dynamic isCorporateBnpl;
  dynamic aadharNo;
  dynamic pancardNo;
  dynamic bankName;
  dynamic bankBranch;
  dynamic bankAccNo;
  dynamic bankIfscCode;
  dynamic profileImage;
  dynamic aadharImage;
  dynamic chequeImage;
  dynamic gstImage;
  dynamic pancardImage;
  dynamic firmName;
  dynamic address;
  dynamic areaVilage;
  dynamic city;
  dynamic state;
  dynamic pincode;
  dynamic confirmationCall;
  dynamic mandiLicense;
  dynamic fastPathState;
  dynamic fastPathWorkType;
  dynamic fastPathCommodityId;
  dynamic latitude;
  dynamic longitude;
  dynamic liveLatitude;
  dynamic liveLongitude;
  dynamic transferAmount;
  dynamic verifiedAccount;
  dynamic approvedBy;
  dynamic verifiedBy;
  dynamic isGrading;
  dynamic isLabourCharge;
  dynamic isStackBook;
  dynamic isCkyc;
  dynamic isCibil;
  dynamic sanctionedLimit;
  dynamic isDigitalSignature;
  dynamic rating;
  dynamic tradeTerms;
  dynamic bnplTerms;
  dynamic status;
  dynamic nameLockStatus;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic userTradeStatus;
  dynamic panStatus;
  dynamic itution;

  UserDetails(
      {this.id,
      this.userId,
      this.userType,
      this.fname,
      this.lname,
      this.email,
      this.phone,
      this.altNumber,
      this.whatsapp,
      this.dob,
      this.referralCode,
      this.referralBy,
      this.fatherName,
      this.category,
      this.gstNumber,
      this.khasraNo,
      this.village,
      this.tehsil,
      this.district,
      this.image,
      this.power,
      this.holdPower,
      this.bnplPowerLimit,
      this.bnplPower,
      this.bnplUsedPower,
      this.isCorporateBnpl,
      this.aadharNo,
      this.pancardNo,
      this.bankName,
      this.bankBranch,
      this.bankAccNo,
      this.bankIfscCode,
      this.profileImage,
      this.aadharImage,
      this.chequeImage,
      this.gstImage,
      this.pancardImage,
      this.firmName,
      this.address,
      this.areaVilage,
      this.city,
      this.state,
      this.pincode,
      this.confirmationCall,
      this.mandiLicense,
      this.fastPathState,
      this.fastPathWorkType,
      this.fastPathCommodityId,
      this.latitude,
      this.longitude,
      this.liveLatitude,
      this.liveLongitude,
      this.transferAmount,
      this.verifiedAccount,
      this.approvedBy,
      this.verifiedBy,
      this.isGrading,
      this.isLabourCharge,
      this.isStackBook,
      this.isCkyc,
      this.isCibil,
      this.sanctionedLimit,
      this.isDigitalSignature,
      this.rating,
      this.tradeTerms,
      this.bnplTerms,
      this.status,
      this.nameLockStatus,
      this.createdAt,
      this.updatedAt,
      this.userTradeStatus,
      this.panStatus,
      this.itution});

  factory UserDetails.fromMap(Map<String, dynamic> json) => UserDetails(
      id: json["id"],
      userId: json["user_id"],
      userType: json["user_type"],
      fname: json["fname"],
      lname: json["lname"],
      email: json["email"],
      phone: json["phone"],
      altNumber: json["alt_number"],
      whatsapp: json["whatsapp"],
      dob: json["dob"],
      referralCode: json["referral_code"],
      referralBy: json["referral_by"],
      fatherName: json["father_name"],
      category: json["category"],
      gstNumber: json["gst_number"],
      khasraNo: json["khasra_no"],
      village: json["village"],
      tehsil: json["tehsil"],
      district: json["district"],
      image: json["image"],
      power: json["power"],
      holdPower: json['hold_power'],
      bnplPowerLimit: json["bnpl_power_limit"],
      bnplPower: json["bnpl_power"],
      bnplUsedPower: json["bnpl_used_power"],
      isCorporateBnpl: json["is_corporate_bnpl"],
      aadharNo: json["aadhar_no"],
      pancardNo: json["pancard_no"],
      bankName: json["bank_name"],
      bankBranch: json["bank_branch"],
      bankAccNo: json["bank_acc_no"],
      bankIfscCode: json["bank_ifsc_code"],
      profileImage: json["profile_image"],
      aadharImage: json["aadhar_image"],
      chequeImage: json["cheque_image"],
      gstImage: json["gst_image"],
      pancardImage: json["pancard_image"],
      firmName: json["firm_name"],
      address: json["address"],
      areaVilage: json["area_vilage"],
      city: json["city"],
      state: json["state"],
      pincode: json["pincode"],
      confirmationCall: json["confirmation_call"],
      mandiLicense: json["mandi_license"],
      fastPathState: json["fast_path_state"],
      fastPathWorkType: json["fast_path_work_type"],
      fastPathCommodityId: json["fast_path_commodity_id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      liveLatitude: json["live_latitude"],
      liveLongitude: json["live_longitude"],
      transferAmount: json["transfer_amount"],
      verifiedAccount: json["verified_account"],
      approvedBy: json["approved_by"],
      verifiedBy: json["verified_by"],
      isGrading: json["is_grading"],
      isLabourCharge: json["is_labour_charge"],
      isStackBook: json["is_stack_book"],
      isCkyc: json["is_ckyc"],
      isCibil: json["is_cibil"],
      sanctionedLimit: json["sanctioned_limit"],
      isDigitalSignature: json["is_digital_signature"],
      rating: json["rating"],
      tradeTerms: json["trade_terms"],
      bnplTerms: json["bnpl_terms"],
      status: json["status"],
      nameLockStatus: json["name_lock_status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      userTradeStatus: json["user_trade_status"],
      panStatus: json["pan_status"],
      itution: json['itution']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "user_type": userType,
        "fname": fname,
        "lname": lname,
        "email": email,
        "phone": phone,
        "alt_number": altNumber,
        "whatsapp": whatsapp,
        "dob": dob,
        "referral_code": referralCode,
        "referral_by": referralBy,
        "father_name": fatherName,
        "category": category,
        "gst_number": gstNumber,
        "khasra_no": khasraNo,
        "village": village,
        "tehsil": tehsil,
        "district": district,
        "image": image,
        "power": power,
        "hold_power": holdPower,
        "bnpl_power_limit": bnplPowerLimit,
        "bnpl_power": bnplPower,
        "bnpl_used_power": bnplUsedPower,
        "is_corporate_bnpl": isCorporateBnpl,
        "aadhar_no": aadharNo,
        "pancard_no": pancardNo,
        "bank_name": bankName,
        "bank_branch": bankBranch,
        "bank_acc_no": bankAccNo,
        "bank_ifsc_code": bankIfscCode,
        "profile_image": profileImage,
        "aadhar_image": aadharImage,
        "cheque_image": chequeImage,
        "gst_image": gstImage,
        "pancard_image": pancardImage,
        "firm_name": firmName,
        "address": address,
        "area_vilage": areaVilage,
        "city": city,
        "state": state,
        "pincode": pincode,
        "confirmation_call": confirmationCall,
        "mandi_license": mandiLicense,
        "fast_path_state": fastPathState,
        "fast_path_work_type": fastPathWorkType,
        "fast_path_commodity_id": fastPathCommodityId,
        "latitude": latitude,
        "longitude": longitude,
        "live_latitude": liveLatitude,
        "live_longitude": liveLongitude,
        "transfer_amount": transferAmount,
        "verified_account": verifiedAccount,
        "approved_by": approvedBy,
        "verified_by": verifiedBy,
        "is_grading": isGrading,
        "is_labour_charge": isLabourCharge,
        "is_stack_book": isStackBook,
        "is_ckyc": isCkyc,
        "is_cibil": isCibil,
        "sanctioned_limit": sanctionedLimit,
        "is_digital_signature": isDigitalSignature,
        "rating": rating,
        "trade_terms": tradeTerms,
        "bnpl_terms": bnplTerms,
        "status": status,
        "name_lock_status": nameLockStatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_trade_status": userTradeStatus,
        "pan_status": panStatus,
        "itution": itution
      };
}
