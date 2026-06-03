// To parse this JSON data, do
//
//     final dispatchListingModel = dispatchListingModelFromMap(jsonString);

import 'dart:convert';

DispatchListingModel dispatchListingModelFromMap(String str) => DispatchListingModel.fromMap(json.decode(str));

String dispatchListingModelToMap(DispatchListingModel data) => json.encode(data.toMap());

class DispatchListingModel {
    dynamic status;
    dynamic message;
    List<Datum>? data;

    DispatchListingModel({
        this.status,
        this.message,
        this.data,
    });

    factory DispatchListingModel.fromMap(Map<String, dynamic> json) => DispatchListingModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    dynamic id;
    dynamic requestDate;
    dynamic orderId;
    dynamic salesStatus;
    dynamic weight;
    dynamic vehicleNumber;
    dynamic driverNumber;
    dynamic checkKantaParchi;
    dynamic kantaParchi;
    dynamic checkBillty;
    dynamic billty;
    dynamic checkInvoice;
    dynamic invoiceCopy;
    dynamic checkGrn;
    dynamic grn;
    dynamic checkRecevingKantaParchi;
    dynamic recevingKantaParchi;
    dynamic status;

    Datum({
        this.id,
        this.requestDate,
        this.orderId,
        this.salesStatus,
        this.weight,
        this.vehicleNumber,
        this.driverNumber,
        this.checkKantaParchi,
        this.kantaParchi,
        this.checkBillty,
        this.billty,
        this.checkInvoice,
        this.invoiceCopy,
        this.checkGrn,
        this.grn,
        this.checkRecevingKantaParchi,
        this.recevingKantaParchi,
        this.status,
    });

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        requestDate: json["request_date"],
        orderId: json["order_id"],
        salesStatus: json["sales_status"],
        weight: json["weight"],
        vehicleNumber: json["vehicle_number"],
        driverNumber: json["driver_number"],
        checkKantaParchi: json["check_kanta_parchi"],
        kantaParchi: json["kanta_parchi"],
        checkBillty: json["check_billty"],
        billty: json["billty"],
        checkInvoice: json["check_invoice"],
        invoiceCopy: json["invoice_copy"],
        checkGrn: json["check_grn"],
        grn: json["grn"],
        checkRecevingKantaParchi: json["check_receving_kanta_parchi"],
        recevingKantaParchi: json["receving_kanta_parchi"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "request_date": requestDate,
        "order_id": orderId,
        "sales_status": salesStatus,
        "weight": weight,
        "vehicle_number": vehicleNumber,
        "driver_number": driverNumber,
        "check_kanta_parchi": checkKantaParchi,
        "kanta_parchi": kantaParchi,
        "check_billty": checkBillty,
        "billty": billty,
        "check_invoice": checkInvoice,
        "invoice_copy": invoiceCopy,
        "check_grn": checkGrn,
        "grn": grn,
        "check_receving_kanta_parchi": checkRecevingKantaParchi,
        "receving_kanta_parchi": recevingKantaParchi,
        "status": status,
    };
}
