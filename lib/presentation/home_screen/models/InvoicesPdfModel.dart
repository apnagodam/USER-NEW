// To parse this JSON data, do
//
//     final invoicesPdfModel = invoicesPdfModelFromMap(jsondynamic);

import 'dart:convert';

InvoicesPdfModel invoicesPdfModelFromMap(dynamic str) =>
    InvoicesPdfModel.fromMap(json.decode(str));

dynamic invoicesPdfModelToMap(InvoicesPdfModel data) =>
    json.encode(data.toMap());

class InvoicesPdfModel {
  dynamic status;
  dynamic message;
  Data? data;

  InvoicesPdfModel({
    this.status,
    this.message,
    this.data,
  });

  factory InvoicesPdfModel.fromMap(Map<dynamic, dynamic> json) =>
      InvoicesPdfModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<dynamic, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  dynamic commodityName;
  dynamic termsOfDelivery;
  dynamic dummyHsn;
  dynamic sellerName;
  dynamic sellerAddress;
  dynamic sellerDistrict;
  dynamic sellerPincode;
  dynamic sellerState;
  dynamic sellerStateCode;
  dynamic sellerEmail;
  dynamic sellerGst;
  dynamic buyerName;
  dynamic buyerAddress;
  dynamic buyerDistrict;
  dynamic buyerPincode;
  dynamic buyerState;
  dynamic buyerStateCode;
  dynamic buyerEmail;
  dynamic buyerGst;
  dynamic hsnCode;
  dynamic invoiceNumber;
  dynamic date;
  dynamic quantity;
  dynamic rate;
  dynamic amount;
  dynamic type;
  dynamic cgst;
  dynamic sgst;
  dynamic igst;
  dynamic totalSettlement;

  Data({
    this.commodityName,
    this.termsOfDelivery,
    this.dummyHsn,
    this.sellerName,
    this.sellerAddress,
    this.sellerDistrict,
    this.sellerPincode,
    this.sellerState,
    this.sellerStateCode,
    this.sellerEmail,
    this.sellerGst,
    this.buyerName,
    this.buyerAddress,
    this.buyerDistrict,
    this.buyerPincode,
    this.buyerState,
    this.buyerStateCode,
    this.buyerEmail,
    this.buyerGst,
    this.hsnCode,
    this.invoiceNumber,
    this.date,
    this.quantity,
    this.rate,
    this.amount,
    this.type,
    this.cgst,
    this.sgst,
    this.igst,
    this.totalSettlement,
  });

  factory Data.fromMap(Map<dynamic, dynamic> json) => Data(
        commodityName: json["commodity_name"],
        termsOfDelivery: json["terms_of_delivery"],
        dummyHsn: json["dummy_hsn"],
        sellerName: json["seller_name"],
        sellerAddress: json["seller_address"],
        sellerDistrict: json["seller_district"],
        sellerPincode: json["seller_pincode"],
        sellerState: json["seller_state"],
        sellerStateCode: json["seller_state_code"],
        sellerEmail: json["seller_email"],
        sellerGst: json["seller_gst"],
        buyerName: json["buyer_name"],
        buyerAddress: json["buyer_address"],
        buyerDistrict: json["buyer_district"],
        buyerPincode: json["buyer_pincode"],
        buyerState: json["buyer_state"],
        buyerStateCode: json["buyer_state_code"],
        buyerEmail: json["buyer_email"],
        buyerGst: json["buyer_gst"],
        hsnCode: json["hsn_code"],
        invoiceNumber: json["invoice_number"],
        date: json["date"],
        quantity: json["quantity"],
        rate: json["rate"],
        amount: json["amount"],
        type: json["type"],
        cgst: json["cgst"],
        sgst: json["sgst"],
        igst: json["igst"],
        totalSettlement: json["total_settlement"],
      );

  Map<dynamic, dynamic> toMap() => {
        "commodity_name": commodityName,
        "terms_of_delivery": termsOfDelivery,
        "dummy_hsn": dummyHsn,
        "seller_name": sellerName,
        "seller_address": sellerAddress,
        "seller_district": sellerDistrict,
        "seller_pincode": sellerPincode,
        "seller_state": sellerState,
        "seller_state_code": sellerStateCode,
        "seller_email": sellerEmail,
        "seller_gst": sellerGst,
        "buyer_name": buyerName,
        "buyer_address": buyerAddress,
        "buyer_district": buyerDistrict,
        "buyer_pincode": buyerPincode,
        "buyer_state": buyerState,
        "buyer_state_code": buyerStateCode,
        "buyer_email": buyerEmail,
        "buyer_gst": buyerGst,
        "hsn_code": hsnCode,
        "invoice_number": invoiceNumber,
        "date": date,
        "quantity": quantity,
        "rate": rate,
        "amount": amount,
        "type": type,
        "cgst": cgst,
        "sgst": sgst,
        "igst": igst,
        "total_settlement": totalSettlement,
      };
}
