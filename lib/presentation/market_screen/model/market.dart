class WbtMarket {
  WbtMarket({
    dynamic status,
    dynamic message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  WbtMarket.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  dynamic _status;
  dynamic _message;
  List<Data>? _data;
  WbtMarket copyWith({
    dynamic status,
    dynamic message,
    List<Data>? data,
  }) =>
      WbtMarket(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  dynamic get status => _status;
  dynamic get message => _message;
  List<Data>? get data => _data;

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

/*{"id":10204,"seller_id":8148,"seller_cat_id":10204,"quantity":"83.5","bid_status":0,"price":"8500","gatepass":"13436","warehouse":"Chiraag Logistics Warehouse, Manda (Khatushyamji)","commodity":"G Nut Grad","exp_date":"Sep-2024","image":"21ad4a.png","sales_status":2,"buyer_price":0,"min_price":8000,"max_price":8500,"modal_price":9000,"ltp":"8390.0","second_ltp":0,"c_first_price":0,"c_second_price":0,"state":"Sikar","warehouse_code":"082301","price_dif":0,"is_active":0,"seller_is_active":2,"seller_price":"8500","seller_price_diff":0}*/
class Data {
  Data({
    dynamic id,
    dynamic sellerId,
    dynamic sellerCatId,
    dynamic quantity,
    dynamic bidStatus,
    dynamic price,
    dynamic gatepass,
    dynamic warehouse,
    dynamic commodity,
    dynamic expDate,
    dynamic image,
    dynamic salesStatus,
    dynamic buyerPrice,
    dynamic minPrice,
    dynamic maxPrice,
    dynamic modalPrice,
    dynamic ltp,
    dynamic secondLtp,
    dynamic cFirstPrice,
    dynamic cSecondPrice,
    dynamic state,
    dynamic warehouseCode,
    dynamic priceDif,
    dynamic isActive,
    dynamic sellerIsActive,
    dynamic sellerPrice,
    dynamic sellerPriceDiff,
  }) {
    _id = id;
    _sellerId = sellerId;
    _sellerCatId = sellerCatId;
    _quantity = quantity;
    _bidStatus = bidStatus;
    _price = price;
    _gatepass = gatepass;
    _warehouse = warehouse;
    _commodity = commodity;
    _expDate = expDate;
    _image = image;
    _salesStatus = salesStatus;
    _buyerPrice = buyerPrice;
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    _modalPrice = modalPrice;
    _ltp = ltp;
    _secondLtp = secondLtp;
    _cFirstPrice = cFirstPrice;
    _cSecondPrice = cSecondPrice;
    _state = state;
    _warehouseCode = warehouseCode;
    _priceDif = priceDif;
    _isActive = isActive;
    _sellerIsActive = sellerIsActive;
    _sellerPrice = sellerPrice;
    _sellerPriceDiff = sellerPriceDiff;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _sellerId = json['seller_id'];
    _sellerCatId = json['seller_cat_id'];
    _quantity = json['quantity'];
    _bidStatus = json['bid_status'];
    _price = json['price'];
    _gatepass = json['gatepass'];
    _warehouse = json['warehouse'];
    _commodity = json['commodity'];
    _expDate = json['exp_date'];
    _image = json['image'];
    _salesStatus = json['sales_status'];
    _buyerPrice = json['buyer_price'] ?? "";
    _minPrice = json['min_price'];
    _maxPrice = json['max_price'];
    _modalPrice = json['modal_price'];
    _ltp = json['ltp'];
    _secondLtp = json['second_ltp'];
    _cFirstPrice = json['c_first_price'];
    _cSecondPrice = json['c_second_price'];
    _state = json['state'];
    _warehouseCode = json['warehouse_code'];
    _priceDif = json['price_dif'];
    _isActive = json['is_active'];
    _sellerIsActive = json['seller_is_active'];
    _sellerPrice = json['seller_price'] ?? "";
    _sellerPriceDiff = json['seller_price_diff'];
  }
  dynamic _id;
  dynamic _sellerId;
  dynamic _sellerCatId;
  dynamic _quantity;
  dynamic _bidStatus;
  dynamic _price;
  dynamic _gatepass;
  dynamic _warehouse;
  dynamic _commodity;
  dynamic _expDate;
  dynamic _image;
  dynamic _salesStatus;
  dynamic _buyerPrice;
  dynamic _minPrice;
  dynamic _maxPrice;
  dynamic _modalPrice;
  dynamic _ltp;
  dynamic _secondLtp;
  dynamic _cFirstPrice;
  dynamic _cSecondPrice;
  dynamic _state;
  dynamic _warehouseCode;
  dynamic _priceDif;
  dynamic _isActive;
  dynamic _sellerIsActive;
  dynamic _sellerPrice;
  dynamic _sellerPriceDiff;
  Data copyWith({
    dynamic id,
    dynamic sellerId,
    dynamic sellerCatId,
    dynamic quantity,
    dynamic bidStatus,
    dynamic price,
    dynamic gatepass,
    dynamic warehouse,
    dynamic commodity,
    dynamic expDate,
    dynamic image,
    dynamic salesStatus,
    dynamic buyerPrice,
    dynamic minPrice,
    dynamic maxPrice,
    dynamic modalPrice,
    dynamic ltp,
    dynamic secondLtp,
    dynamic cFirstPrice,
    dynamic cSecondPrice,
    dynamic state,
    dynamic warehouseCode,
    dynamic priceDif,
    dynamic isActive,
    dynamic sellerIsActive,
    dynamic sellerPrice,
    dynamic sellerPriceDiff,
  }) =>
      Data(
        id: id ?? _id,
        sellerId: sellerId ?? _sellerId,
        sellerCatId: sellerCatId ?? _sellerCatId,
        quantity: quantity ?? _quantity,
        bidStatus: bidStatus ?? _bidStatus,
        price: price ?? _price,
        gatepass: gatepass ?? _gatepass,
        warehouse: warehouse ?? _warehouse,
        commodity: commodity ?? _commodity,
        expDate: expDate ?? _expDate,
        image: image ?? _image,
        salesStatus: salesStatus ?? _salesStatus,
        buyerPrice: buyerPrice ?? _buyerPrice,
        minPrice: minPrice ?? _minPrice,
        maxPrice: maxPrice ?? _maxPrice,
        modalPrice: modalPrice ?? _modalPrice,
        ltp: ltp ?? _ltp,
        secondLtp: secondLtp ?? _secondLtp,
        cFirstPrice: cFirstPrice ?? _cFirstPrice,
        cSecondPrice: cSecondPrice ?? _cSecondPrice,
        state: state ?? _state,
        warehouseCode: warehouseCode ?? _warehouseCode,
        priceDif: priceDif ?? _priceDif,
        isActive: isActive ?? _isActive,
        sellerIsActive: sellerIsActive ?? _sellerIsActive,
        sellerPrice: sellerPrice ?? _sellerPrice,
        sellerPriceDiff: sellerPriceDiff ?? _sellerPriceDiff,
      );
  dynamic get id => _id;
  dynamic get sellerId => _sellerId;
  dynamic get sellerCatId => _sellerCatId;
  dynamic get quantity => _quantity;
  dynamic get bidStatus => _bidStatus;
  dynamic get price => _price;
  dynamic get gatepass => _gatepass;
  dynamic get warehouse => _warehouse;
  dynamic get commodity => _commodity;
  dynamic get expDate => _expDate;
  dynamic get image => _image;
  dynamic get salesStatus => _salesStatus;
  dynamic get buyerPrice => _buyerPrice;
  dynamic get minPrice => _minPrice;
  dynamic get maxPrice => _maxPrice;
  dynamic get modalPrice => _modalPrice;
  dynamic get ltp => _ltp;
  dynamic get secondLtp => _secondLtp;
  dynamic get cFirstPrice => _cFirstPrice;
  dynamic get cSecondPrice => _cSecondPrice;
  dynamic get state => _state;
  dynamic get warehouseCode => _warehouseCode;
  dynamic get priceDif => _priceDif;
  dynamic get isActive => _isActive;
  dynamic get sellerIsActive => _sellerIsActive;
  dynamic get sellerPrice => _sellerPrice;
  dynamic get sellerPriceDiff => _sellerPriceDiff;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['seller_id'] = _sellerId;
    map['seller_cat_id'] = _sellerCatId;
    map['quantity'] = _quantity;
    map['bid_status'] = _bidStatus;
    map['price'] = _price;
    map['gatepass'] = _gatepass;
    map['warehouse'] = _warehouse;
    map['commodity'] = _commodity;
    map['exp_date'] = _expDate;
    map['image'] = _image;
    map['sales_status'] = _salesStatus;
    map['buyer_price'] = _buyerPrice;
    map['min_price'] = _minPrice;
    map['max_price'] = _maxPrice;
    map['modal_price'] = _modalPrice;
    map['ltp'] = _ltp;
    map['second_ltp'] = _secondLtp;
    map['c_first_price'] = _cFirstPrice;
    map['c_second_price'] = _cSecondPrice;
    map['state'] = _state;
    map['warehouse_code'] = _warehouseCode;
    map['price_dif'] = _priceDif;
    map['is_active'] = _isActive;
    map['seller_is_active'] = _sellerIsActive;
    map['seller_price'] = _sellerPrice;
    map['seller_price_diff'] = _sellerPriceDiff;
    return map;
  }
}
