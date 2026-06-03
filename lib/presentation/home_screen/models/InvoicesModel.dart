// To parse this JSON data, do
//
//     final invoicesModel = invoicesModelFromMap(jsonString);

import 'dart:convert';

InvoicesModel invoicesModelFromMap(String str) => InvoicesModel.fromMap(json.decode(str));

String invoicesModelToMap(InvoicesModel data) => json.encode(data.toMap());

class InvoicesModel {
    dynamic status;
    dynamic message;
    List<InvoicesDatum>? data;

    InvoicesModel({
        this.status,
        this.message,
        this.data,
    });

    factory InvoicesModel.fromMap(Map<String, dynamic> json) => InvoicesModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<InvoicesDatum>.from(json["data"]!.map((x) => InvoicesDatum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class InvoicesDatum {
    dynamic id;
    dynamic invoiceNumber;
    dynamic date;
    dynamic rate;
    dynamic qty;
    dynamic gstAmount;
    dynamic dealType;
    dynamic commodity;
    dynamic location;
    dynamic type;
    dynamic buyerSellerName;

    InvoicesDatum({
        this.id,
        this.invoiceNumber,
        this.date,
        this.rate,
        this.qty,
        this.gstAmount,
        this.dealType,
        this.commodity,
        this.location,
        this.type,
        this.buyerSellerName,
    });

    factory InvoicesDatum.fromMap(Map<String, dynamic> json) => InvoicesDatum(
        id: json["id"],
        invoiceNumber: json["invoice_number"],
        date: json["date"],
        rate: json["rate"],
        qty: json["qty"],
        gstAmount: json["gst_amount"],
        dealType: json["deal_type"],
        commodity: json["commodity"],
        location: json["location"],
        type: json["type"],
        buyerSellerName: json["buyer_seller_name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "invoice_number": invoiceNumber,
        "date": date,
        "rate": rate,
        "qty": qty,
        "gst_amount": gstAmount,
        "deal_type": dealType,
        "commodity": commodity,
        "location": location,
        "type": type,
        "buyer_seller_name": buyerSellerName,
    };
}
