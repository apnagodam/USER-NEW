class MyorderModel {
  MyorderModel({
      OrderList? orderList, 
      String? status, 
      String? message,}){
    _orderList = orderList;
    _status = status;
    _message = message;
}

  MyorderModel.fromJson(dynamic json) {
    _orderList = json['order_list'];
    _status = json['status'];
    _message = json['message'];
  }
  OrderList? _orderList;
  String? _status;
  String? _message;
MyorderModel copyWith({  OrderList? orderList,
  String? status,
  String? message,
}) => MyorderModel(  orderList: orderList ?? _orderList,
  status: status ?? _status,
  message: message ?? _message,
);
  OrderList? get orderList => _orderList;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_list'] = _orderList;
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

class OrderList {
  OrderList({
      int? currentPage, 
      List<OrdermodelData>? data, 
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      dynamic nextPageUrl, 
      String? path, 
      String? perPage, 
      dynamic prevPageUrl, 
      int? to, 
      int? total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  OrderList.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(OrdermodelData.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  List<OrdermodelData>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  String? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;
OrderList copyWith({  int? currentPage,
  List<OrdermodelData>? data,
  String? firstPageUrl,
  int? from,
  int? lastPage,
  String? lastPageUrl,
  List<Links>? links,
  dynamic nextPageUrl,
  String? path,
  String? perPage,
  dynamic prevPageUrl,
  int? to,
  int? total,
}) => OrderList(  currentPage: currentPage ?? _currentPage,
  data: data ?? _data,
  firstPageUrl: firstPageUrl ?? _firstPageUrl,
  from: from ?? _from,
  lastPage: lastPage ?? _lastPage,
  lastPageUrl: lastPageUrl ?? _lastPageUrl,
  links: links ?? _links,
  nextPageUrl: nextPageUrl ?? _nextPageUrl,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  prevPageUrl: prevPageUrl ?? _prevPageUrl,
  to: to ?? _to,
  total: total ?? _total,
);
  int? get currentPage => _currentPage;
  List<OrdermodelData>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  String? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;
Links copyWith({  dynamic url,
  String? label,
  bool? active,
}) => Links(  url: url ?? _url,
  label: label ?? _label,
  active: active ?? _active,
);
  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

class OrdermodelData {
  OrdermodelData({
      int? id, 
      int? userId, 
      int? terminalId, 
      int? commodityId, 
      String? pincode, 
      String? location, 
      String? price, 
      dynamic quantity,
      dynamic amount, 
      int? requestedQuantity, 
      int? deliveryAt, 
      dynamic transportCost, 
      String? corporateUsersLat, 
      String? corporateUsersLong, 
      int? empId, 
      int? status, 
      String? createdAt, 
      String? updatedAt, 
      int? ordersCount, 
      Commodity? commodity, 
      Warehouses? warehouses,}){
    _id = id;
    _userId = userId;
    _terminalId = terminalId;
    _commodityId = commodityId;
    _pincode = pincode;
    _location = location;
    _price = price;
    _quantity = quantity;
    _amount = amount;
    _requestedQuantity = requestedQuantity;
    _deliveryAt = deliveryAt;
    _transportCost = transportCost;
    _corporateUsersLat = corporateUsersLat;
    _corporateUsersLong = corporateUsersLong;
    _empId = empId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _ordersCount = ordersCount;
    _commodity = commodity;
    _warehouses = warehouses;
}

  OrdermodelData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _terminalId = json['terminal_id'];
    _commodityId = json['commodity_id'];
    _pincode = json['pincode'];
    _location = json['location'];
    _price = json['price'];
    _quantity = json['quantity'];
    _amount = json['amount'];
    _requestedQuantity = json['requested_quantity'];
    _deliveryAt = json['delivery_at'];
    _transportCost = json['transport_cost'];
    _corporateUsersLat = json['corporate_users_lat'];
    _corporateUsersLong = json['corporate_users_long'];
    _empId = json['emp_id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _ordersCount = json['orders_count'];
    _commodity = json['commodity'] != null ? Commodity.fromJson(json['commodity']) : null;
    _warehouses = json['warehouses'] != null ? Warehouses.fromJson(json['warehouses']) : null;
  }
  int? _id;
  int? _userId;
  int? _terminalId;
  int? _commodityId;
  String? _pincode;
  String? _location;
  String? _price;
  dynamic _quantity;
  dynamic _amount;
  int? _requestedQuantity;
  int? _deliveryAt;
  dynamic _transportCost;
  String? _corporateUsersLat;
  String? _corporateUsersLong;
  int? _empId;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  int? _ordersCount;
  Commodity? _commodity;
  Warehouses? _warehouses;
OrdermodelData copyWith({  int? id,
  int? userId,
  int? terminalId,
  int? commodityId,
  String? pincode,
  String? location,
  String? price,
  dynamic quantity,
  dynamic amount,
  int? requestedQuantity,
  int? deliveryAt,
  dynamic transportCost,
  String? corporateUsersLat,
  String? corporateUsersLong,
  int? empId,
  int? status,
  String? createdAt,
  String? updatedAt,
  int? ordersCount,
  Commodity? commodity,
  Warehouses? warehouses,
}) => OrdermodelData(  id: id ?? _id,
  userId: userId ?? _userId,
  terminalId: terminalId ?? _terminalId,
  commodityId: commodityId ?? _commodityId,
  pincode: pincode ?? _pincode,
  location: location ?? _location,
  price: price ?? _price,
  quantity: quantity ?? _quantity,
  amount: amount ?? _amount,
  requestedQuantity: requestedQuantity ?? _requestedQuantity,
  deliveryAt: deliveryAt ?? _deliveryAt,
  transportCost: transportCost ?? _transportCost,
  corporateUsersLat: corporateUsersLat ?? _corporateUsersLat,
  corporateUsersLong: corporateUsersLong ?? _corporateUsersLong,
  empId: empId ?? _empId,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  ordersCount: ordersCount ?? _ordersCount,
  commodity: commodity ?? _commodity,
  warehouses: warehouses ?? _warehouses,
);
  int? get id => _id;
  int? get userId => _userId;
  int? get terminalId => _terminalId;
  int? get commodityId => _commodityId;
  String? get pincode => _pincode;
  String? get location => _location;
  String? get price => _price;
  dynamic get quantity => _quantity;
  dynamic get amount => _amount;
  int? get requestedQuantity => _requestedQuantity;
  int? get deliveryAt => _deliveryAt;
  dynamic get transportCost => _transportCost;
  String? get corporateUsersLat => _corporateUsersLat;
  String? get corporateUsersLong => _corporateUsersLong;
  int? get empId => _empId;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get ordersCount => _ordersCount;
  Commodity? get commodity => _commodity;
  Warehouses? get warehouses => _warehouses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['terminal_id'] = _terminalId;
    map['commodity_id'] = _commodityId;
    map['pincode'] = _pincode;
    map['location'] = _location;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['amount'] = _amount;
    map['requested_quantity'] = _requestedQuantity;
    map['delivery_at'] = _deliveryAt;
    map['transport_cost'] = _transportCost;
    map['corporate_users_lat'] = _corporateUsersLat;
    map['corporate_users_long'] = _corporateUsersLong;
    map['emp_id'] = _empId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['orders_count'] = _ordersCount;
    if (_commodity != null) {
      map['commodity'] = _commodity?.toJson();
    }
    if (_warehouses != null) {
      map['warehouses'] = _warehouses?.toJson();
    }
    return map;
  }

}

class Warehouses {
  Warehouses({
      int? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Warehouses.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
Warehouses copyWith({  int? id,
  String? name,
}) => Warehouses(  id: id ?? _id,
  name: name ?? _name,
);
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

class Commodity {
  Commodity({
      int? id, 
      String? category, 
      String? categoryHi,}){
    _id = id;
    _category = category;
    _categoryHi = categoryHi;
}

  Commodity.fromJson(dynamic json) {
    _id = json['id'];
    _category = json['category'];
    _categoryHi = json['category_hi'];
  }
  int? _id;
  String? _category;
  String? _categoryHi;
Commodity copyWith({  int? id,
  String? category,
  String? categoryHi,
}) => Commodity(  id: id ?? _id,
  category: category ?? _category,
  categoryHi: categoryHi ?? _categoryHi,
);
  int? get id => _id;
  String? get category => _category;
  String? get categoryHi => _categoryHi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category'] = _category;
    map['category_hi'] = _categoryHi;
    return map;
  }

}