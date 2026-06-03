class Buyersellersbtmodel {
  Buyersellersbtmodel({
      String? status, 
      String? message, 
      List<BuyerData>? buyerData, 
      List<SellerData>? sellerData, 
      List<dynamic>? truckData,}){
    _status = status;
    _message = message;
    _buyerData = buyerData;
    _sellerData = sellerData;
    _truckData = truckData;
}

  Buyersellersbtmodel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['buyer_data'] != null) {
      _buyerData = [];
      json['buyer_data'].forEach((v) {
        _buyerData?.add(BuyerData.fromJson(v));
      });
    }
    if (json['seller_data'] != null) {
      _sellerData = [];
      json['seller_data'].forEach((v) {
        _sellerData?.add(SellerData.fromJson(v));
      });
    }
    if (json['truck_data'] != null) {
      _truckData = [];
      json['truck_data'].forEach((v) {
        _truckData?.add(TruckData.fromJson(v));
      });
    }
  }
  dynamic _status;
  String? _message;
  List<BuyerData>? _buyerData;
  List<SellerData>? _sellerData;
  List<dynamic>? _truckData;
Buyersellersbtmodel copyWith({  String? status,
  String? message,
  List<BuyerData>? buyerData,
  List<SellerData>? sellerData,
  List<dynamic>? truckData,
}) => Buyersellersbtmodel(  status: status ?? _status,
  message: message ?? _message,
  buyerData: buyerData ?? _buyerData,
  sellerData: sellerData ?? _sellerData,
  truckData: truckData ?? _truckData,
);
  dynamic get status => _status;
  String? get message => _message;
  List<BuyerData>? get buyerData => _buyerData;
  List<SellerData>? get sellerData => _sellerData;
  List<dynamic>? get truckData => _truckData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_buyerData != null) {
      map['buyer_data'] = _buyerData?.map((v) => v.toJson()).toList();
    }
    if (_sellerData != null) {
      map['seller_data'] = _sellerData?.map((v) => v.toJson()).toList();
    }
    if (_truckData != null) {
      map['truck_data'] = _truckData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SellerData {
  SellerData({
      String? state, 
      String? pinCode, 
      String? city, 
      String? commodity, 
      int? rate, 
      int? qty, 
      int? userRating, 
      String? date,}){
    _state = state;
    _pinCode = pinCode;
    _city = city;
    _commodity = commodity;
    _rate = rate;
    _qty = qty;
    _userRating = userRating;
    _date = date;
}

  SellerData.fromJson(dynamic json) {
    _state = json['state'];
    _pinCode = json['pin_code'];
    _city = json['city'];
    _commodity = json['commodity'];
    _rate = json['rate'];
    _qty = json['qty'];
    _userRating = json['user_rating'];
    _date = json['date'];
  }
  String? _state;
  String? _pinCode;
  String? _city;
  String? _commodity;
  int? _rate;
  int? _qty;
  int? _userRating;
  String? _date;
SellerData copyWith({  String? state,
  String? pinCode,
  String? city,
  String? commodity,
  int? rate,
  int? qty,
  int? userRating,
  String? date,
}) => SellerData(  state: state ?? _state,
  pinCode: pinCode ?? _pinCode,
  city: city ?? _city,
  commodity: commodity ?? _commodity,
  rate: rate ?? _rate,
  qty: qty ?? _qty,
  userRating: userRating ?? _userRating,
  date: date ?? _date,
);
  String? get state => _state;
  String? get pinCode => _pinCode;
  String? get city => _city;
  String? get commodity => _commodity;
  int? get rate => _rate;
  int? get qty => _qty;
  int? get userRating => _userRating;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['pin_code'] = _pinCode;
    map['city'] = _city;
    map['commodity'] = _commodity;
    map['rate'] = _rate;
    map['qty'] = _qty;
    map['user_rating'] = _userRating;
    map['date'] = _date;
    return map;
  }

}

class BuyerData {
  BuyerData({
      String? state, 
      String? pinCode, 
      String? city, 
      String? commodity, 
      int? rate, 
      int? qty, 
      int? userRating, 
      String? date,}){
    _state = state;
    _pinCode = pinCode;
    _city = city;
    _commodity = commodity;
    _rate = rate;
    _qty = qty;
    _userRating = userRating;
    _date = date;
}

  BuyerData.fromJson(dynamic json) {
    _state = json['state'];
    _pinCode = json['pin_code'];
    _city = json['city'];
    _commodity = json['commodity'];
    _rate = json['rate'];
    _qty = json['qty'];
    _userRating = json['user_rating'];
    _date = json['date'];
  }
  String? _state;
  String? _pinCode;
  String? _city;
  String? _commodity;
  int? _rate;
  int? _qty;
  int? _userRating;
  String? _date;
BuyerData copyWith({  String? state,
  String? pinCode,
  String? city,
  String? commodity,
  int? rate,
  int? qty,
  int? userRating,
  String? date,
}) => BuyerData(  state: state ?? _state,
  pinCode: pinCode ?? _pinCode,
  city: city ?? _city,
  commodity: commodity ?? _commodity,
  rate: rate ?? _rate,
  qty: qty ?? _qty,
  userRating: userRating ?? _userRating,
  date: date ?? _date,
);
  String? get state => _state;
  String? get pinCode => _pinCode;
  String? get city => _city;
  String? get commodity => _commodity;
  int? get rate => _rate;
  int? get qty => _qty;
  int? get userRating => _userRating;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['pin_code'] = _pinCode;
    map['city'] = _city;
    map['commodity'] = _commodity;
    map['rate'] = _rate;
    map['qty'] = _qty;
    map['user_rating'] = _userRating;
    map['date'] = _date;
    return map;
  }

}

class TruckData {
  TruckData({
    String? state,
    String? city,
    String? pinCode,
    int? commodity,
    int? qty,
    String? truckNo,}){
    _state = state;
    _city = city;
    _pinCode = pinCode;
    _commodity = commodity;
    _qty = qty;
    _truckNo = truckNo;
  }

  TruckData.fromJson(dynamic json) {
    _state = json['state'];
    _city = json['city'];
    _pinCode = json['pin_code'];
    _commodity = json['commodity'];
    _qty = json['qty'];
    _truckNo = json['truck_no'];
  }
  String? _state;
  String? _city;
  String? _pinCode;
  int? _commodity;
  int? _qty;
  String? _truckNo;
  TruckData copyWith({  String? state,
    String? city,
    String? pinCode,
    int? commodity,
    int? qty,
    String? truckNo,
  }) => TruckData(  state: state ?? _state,
    city: city ?? _city,
    pinCode: pinCode ?? _pinCode,
    commodity: commodity ?? _commodity,
    qty: qty ?? _qty,
    truckNo: truckNo ?? _truckNo,
  );
  String? get state => _state;
  String? get city => _city;
  String? get pinCode => _pinCode;
  int? get commodity => _commodity;
  int? get qty => _qty;
  String? get truckNo => _truckNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['city'] = _city;
    map['pin_code'] = _pinCode;
    map['commodity'] = _commodity;
    map['qty'] = _qty;
    map['truck_no'] = _truckNo;
    return map;
  }

}
