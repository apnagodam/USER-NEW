class SbtcmmodityModel {
  SbtcmmodityModel({
      String? status,
      String? message,
      List<Sbtcommodity>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SbtcmmodityModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Sbtcommodity.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<Sbtcommodity>? _data;
SbtcmmodityModel copyWith({  String? status,
  String? message,
  List<Sbtcommodity>? data,
}) => SbtcmmodityModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  List<Sbtcommodity>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Sbtcommodity {
  Sbtcommodity({
      String? state,
      String? city,
      int? commodity,
      String? commodityName,
      int? buyerPrice,
      int? sellerPrice,}){
    _state = state;
    _city = city;
    _commodity = commodity;
    _commodityName = commodityName;
    _buyerPrice = buyerPrice;
    _sellerPrice = sellerPrice;
}

  Sbtcommodity.fromJson(dynamic json) {
    _state = json['state'];
    _city = json['city'];
    _commodity = json['commodity'];
    _commodityName = json['commodity_name'];
    _buyerPrice = json['buyer_price'];
    _sellerPrice = json['seller_price'];
  }
  String? _state;
  String? _city;
  int? _commodity;
  String? _commodityName;
  int? _buyerPrice;
  int? _sellerPrice;
Sbtcommodity copyWith({  String? state,
  String? city,
  int? commodity,
  String? commodityName,
  int? buyerPrice,
  int? sellerPrice,
}) => Sbtcommodity(  state: state ?? _state,
  city: city ?? _city,
  commodity: commodity ?? _commodity,
  commodityName: commodityName ?? _commodityName,
  buyerPrice: buyerPrice ?? _buyerPrice,
  sellerPrice: sellerPrice ?? _sellerPrice,
);
  String? get state => _state;
  String? get city => _city;
  int? get commodity => _commodity;
  String? get commodityName => _commodityName;
  int? get buyerPrice => _buyerPrice;
  int? get sellerPrice => _sellerPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['city'] = _city;
    map['commodity'] = _commodity;
    map['commodity_name'] = _commodityName;
    map['buyer_price'] = _buyerPrice;
    map['seller_price'] = _sellerPrice;
    return map;
  }

}