class MandiBhavModal {
  MandiBhavModal({
      List<OrderData>? orderData, 
      List<EmandiData>? emandiData, 
      String? status, 
      String? message,}){
    _orderData = orderData;
    _emandiData = emandiData;
    _status = status;
    _message = message;
}

  MandiBhavModal.fromJson(dynamic json) {
    if (json['order_data'] != null) {
      _orderData = [];
      json['order_data'].forEach((v) {
        _orderData?.add(OrderData.fromJson(v));
      });
    }
    if (json['emandi_data'] != null) {
      _emandiData = [];
      json['emandi_data'].forEach((v) {
        _emandiData?.add(EmandiData.fromJson(v));
      });
    }
    _status = json['status'];
    _message = json['message'];
  }
  List<OrderData>? _orderData;
  List<EmandiData>? _emandiData;
  String? _status;
  String? _message;
MandiBhavModal copyWith({  List<OrderData>? orderData,
  List<EmandiData>? emandiData,
  String? status,
  String? message,
}) => MandiBhavModal(  orderData: orderData ?? _orderData,
  emandiData: emandiData ?? _emandiData,
  status: status ?? _status,
  message: message ?? _message,
);
  List<OrderData>? get orderData => _orderData;
  List<EmandiData>? get emandiData => _emandiData;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_orderData != null) {
      map['order_data'] = _orderData?.map((v) => v.toJson()).toList();
    }
    if (_emandiData != null) {
      map['emandi_data'] = _emandiData?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class EmandiData {
  EmandiData({
      String? price, 
      String? commodity, 
      String? commodityImg, 
      String? state, 
      String? mandiName, 
      String? createdAt,}){
    _price = price;
    _commodity = commodity;
    _commodityImg = commodityImg;
    _state = state;
    _mandiName = mandiName;
    _createdAt = createdAt;
}

  EmandiData.fromJson(dynamic json) {
    _price = json['price'];
    _commodity = json['commodity'];
    _commodityImg = json['commodity_img'];
    _state = json['state'];
    _mandiName = json['mandi_name'];
    _createdAt = json['created_at'];
  }
  String? _price;
  String? _commodity;
  String? _commodityImg;
  String? _state;
  String? _mandiName;
  String? _createdAt;
EmandiData copyWith({  String? price,
  String? commodity,
  String? commodityImg,
  String? state,
  String? mandiName,
  String? createdAt,
}) => EmandiData(  price: price ?? _price,
  commodity: commodity ?? _commodity,
  commodityImg: commodityImg ?? _commodityImg,
  state: state ?? _state,
  mandiName: mandiName ?? _mandiName,
  createdAt: createdAt ?? _createdAt,
);
  String? get price => _price;
  String? get commodity => _commodity;
  String? get commodityImg => _commodityImg;
  String? get state => _state;
  String? get mandiName => _mandiName;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    map['commodity'] = _commodity;
    map['commodity_img'] = _commodityImg;
    map['state'] = _state;
    map['mandi_name'] = _mandiName;
    map['created_at'] = _createdAt;
    return map;
  }

}

class OrderData {
  OrderData({
      dynamic price, 
      String? commodity, 
      String? commodityImg, 
      String? state, 
      String? mandiName, 
      String? createdAt,}){
    _price = price;
    _commodity = commodity;
    _commodityImg = commodityImg;
    _state = state;
    _mandiName = mandiName;
    _createdAt = createdAt;
}

  OrderData.fromJson(dynamic json) {
    _price = json['price'];
    _commodity = json['commodity'];
    _commodityImg = json['commodity_img'];
    _state = json['state'];
    _mandiName = json['mandi_name'];
    _createdAt = json['created_at'];
  }
  dynamic _price;
  String? _commodity;
  String? _commodityImg;
  String? _state;
  String? _mandiName;
  String? _createdAt;
OrderData copyWith({  dynamic price,
  String? commodity,
  String? commodityImg,
  String? state,
  String? mandiName,
  String? createdAt,
}) => OrderData(  price: price ?? _price,
  commodity: commodity ?? _commodity,
  commodityImg: commodityImg ?? _commodityImg,
  state: state ?? _state,
  mandiName: mandiName ?? _mandiName,
  createdAt: createdAt ?? _createdAt,
);
  dynamic get price => _price;
  String? get commodity => _commodity;
  String? get commodityImg => _commodityImg;
  String? get state => _state;
  String? get mandiName => _mandiName;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    map['commodity'] = _commodity;
    map['commodity_img'] = _commodityImg;
    map['state'] = _state;
    map['mandi_name'] = _mandiName;
    map['created_at'] = _createdAt;
    return map;
  }

}