// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMandiBhavHash() => r'69f051f3c9d147500422d8060fbbc2a23d92d292';

/// See also [getMandiBhav].
@ProviderFor(getMandiBhav)
final getMandiBhavProvider = AutoDisposeStreamProvider<WbtModel>.internal(
  getMandiBhav,
  name: r'getMandiBhavProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMandiBhavHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetMandiBhavRef = AutoDisposeStreamProviderRef<WbtModel>;
String _$getBiddingDataHash() => r'cd6acf818ec40a91b4d5f4cb8db085926089a415';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getBiddingData].
@ProviderFor(getBiddingData)
const getBiddingDataProvider = GetBiddingDataFamily();

/// See also [getBiddingData].
class GetBiddingDataFamily extends Family<AsyncValue<BiddingResponseModel>> {
  /// See also [getBiddingData].
  const GetBiddingDataFamily();

  /// See also [getBiddingData].
  GetBiddingDataProvider call({
    String? inventoryId,
    String? status,
  }) {
    return GetBiddingDataProvider(
      inventoryId: inventoryId,
      status: status,
    );
  }

  @override
  GetBiddingDataProvider getProviderOverride(
    covariant GetBiddingDataProvider provider,
  ) {
    return call(
      inventoryId: provider.inventoryId,
      status: provider.status,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getBiddingDataProvider';
}

/// See also [getBiddingData].
class GetBiddingDataProvider
    extends AutoDisposeStreamProvider<BiddingResponseModel> {
  /// See also [getBiddingData].
  GetBiddingDataProvider({
    String? inventoryId,
    String? status,
  }) : this._internal(
          (ref) => getBiddingData(
            ref as GetBiddingDataRef,
            inventoryId: inventoryId,
            status: status,
          ),
          from: getBiddingDataProvider,
          name: r'getBiddingDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBiddingDataHash,
          dependencies: GetBiddingDataFamily._dependencies,
          allTransitiveDependencies:
              GetBiddingDataFamily._allTransitiveDependencies,
          inventoryId: inventoryId,
          status: status,
        );

  GetBiddingDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inventoryId,
    required this.status,
  }) : super.internal();

  final String? inventoryId;
  final String? status;

  @override
  Override overrideWith(
    Stream<BiddingResponseModel> Function(GetBiddingDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBiddingDataProvider._internal(
        (ref) => create(ref as GetBiddingDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        inventoryId: inventoryId,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<BiddingResponseModel> createElement() {
    return _GetBiddingDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBiddingDataProvider &&
        other.inventoryId == inventoryId &&
        other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, inventoryId.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetBiddingDataRef on AutoDisposeStreamProviderRef<BiddingResponseModel> {
  /// The parameter `inventoryId` of this provider.
  String? get inventoryId;

  /// The parameter `status` of this provider.
  String? get status;
}

class _GetBiddingDataProviderElement
    extends AutoDisposeStreamProviderElement<BiddingResponseModel>
    with GetBiddingDataRef {
  _GetBiddingDataProviderElement(super.provider);

  @override
  String? get inventoryId => (origin as GetBiddingDataProvider).inventoryId;
  @override
  String? get status => (origin as GetBiddingDataProvider).status;
}

String _$updateBidHash() => r'33c0fdbfb26bbc3e4cfb9de807be41fed4783772';

/// See also [updateBid].
@ProviderFor(updateBid)
const updateBidProvider = UpdateBidFamily();

/// See also [updateBid].
class UpdateBidFamily extends Family<AsyncValue<BaseResponseModel>> {
  /// See also [updateBid].
  const UpdateBidFamily();

  /// See also [updateBid].
  UpdateBidProvider call({
    String? inventoryId,
    String? price,
  }) {
    return UpdateBidProvider(
      inventoryId: inventoryId,
      price: price,
    );
  }

  @override
  UpdateBidProvider getProviderOverride(
    covariant UpdateBidProvider provider,
  ) {
    return call(
      inventoryId: provider.inventoryId,
      price: provider.price,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateBidProvider';
}

/// See also [updateBid].
class UpdateBidProvider extends AutoDisposeFutureProvider<BaseResponseModel> {
  /// See also [updateBid].
  UpdateBidProvider({
    String? inventoryId,
    String? price,
  }) : this._internal(
          (ref) => updateBid(
            ref as UpdateBidRef,
            inventoryId: inventoryId,
            price: price,
          ),
          from: updateBidProvider,
          name: r'updateBidProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateBidHash,
          dependencies: UpdateBidFamily._dependencies,
          allTransitiveDependencies: UpdateBidFamily._allTransitiveDependencies,
          inventoryId: inventoryId,
          price: price,
        );

  UpdateBidProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inventoryId,
    required this.price,
  }) : super.internal();

  final String? inventoryId;
  final String? price;

  @override
  Override overrideWith(
    FutureOr<BaseResponseModel> Function(UpdateBidRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateBidProvider._internal(
        (ref) => create(ref as UpdateBidRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        inventoryId: inventoryId,
        price: price,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseModel> createElement() {
    return _UpdateBidProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateBidProvider &&
        other.inventoryId == inventoryId &&
        other.price == price;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, inventoryId.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateBidRef on AutoDisposeFutureProviderRef<BaseResponseModel> {
  /// The parameter `inventoryId` of this provider.
  String? get inventoryId;

  /// The parameter `price` of this provider.
  String? get price;
}

class _UpdateBidProviderElement
    extends AutoDisposeFutureProviderElement<BaseResponseModel>
    with UpdateBidRef {
  _UpdateBidProviderElement(super.provider);

  @override
  String? get inventoryId => (origin as UpdateBidProvider).inventoryId;
  @override
  String? get price => (origin as UpdateBidProvider).price;
}

String _$addBidHash() => r'11257781704ee8257760958d797f99e0606cf0cf';

/// See also [addBid].
@ProviderFor(addBid)
const addBidProvider = AddBidFamily();

/// See also [addBid].
class AddBidFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [addBid].
  const AddBidFamily();

  /// See also [addBid].
  AddBidProvider call({
    String? inventoryId,
    String? price,
  }) {
    return AddBidProvider(
      inventoryId: inventoryId,
      price: price,
    );
  }

  @override
  AddBidProvider getProviderOverride(
    covariant AddBidProvider provider,
  ) {
    return call(
      inventoryId: provider.inventoryId,
      price: provider.price,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addBidProvider';
}

/// See also [addBid].
class AddBidProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [addBid].
  AddBidProvider({
    String? inventoryId,
    String? price,
  }) : this._internal(
          (ref) => addBid(
            ref as AddBidRef,
            inventoryId: inventoryId,
            price: price,
          ),
          from: addBidProvider,
          name: r'addBidProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addBidHash,
          dependencies: AddBidFamily._dependencies,
          allTransitiveDependencies: AddBidFamily._allTransitiveDependencies,
          inventoryId: inventoryId,
          price: price,
        );

  AddBidProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inventoryId,
    required this.price,
  }) : super.internal();

  final String? inventoryId;
  final String? price;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(AddBidRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddBidProvider._internal(
        (ref) => create(ref as AddBidRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        inventoryId: inventoryId,
        price: price,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _AddBidProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddBidProvider &&
        other.inventoryId == inventoryId &&
        other.price == price;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, inventoryId.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddBidRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `inventoryId` of this provider.
  String? get inventoryId;

  /// The parameter `price` of this provider.
  String? get price;
}

class _AddBidProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with AddBidRef {
  _AddBidProviderElement(super.provider);

  @override
  String? get inventoryId => (origin as AddBidProvider).inventoryId;
  @override
  String? get price => (origin as AddBidProvider).price;
}

String _$getSbtCommodityHash() => r'41e6150c31e9a1719ea2510c3f2248c6392c84d6';

/// See also [getSbtCommodity].
@ProviderFor(getSbtCommodity)
final getSbtCommodityProvider =
    AutoDisposeFutureProvider<SbtCommodityModel>.internal(
  getSbtCommodity,
  name: r'getSbtCommodityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSbtCommodityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetSbtCommodityRef = AutoDisposeFutureProviderRef<SbtCommodityModel>;
String _$getBuyerSellerListHash() =>
    r'8059c56bcffa1085a222a051bf2ae17989e1d0d3';

/// See also [getBuyerSellerList].
@ProviderFor(getBuyerSellerList)
const getBuyerSellerListProvider = GetBuyerSellerListFamily();

/// See also [getBuyerSellerList].
class GetBuyerSellerListFamily
    extends Family<AsyncValue<BuyerSelletListModel>> {
  /// See also [getBuyerSellerList].
  const GetBuyerSellerListFamily();

  /// See also [getBuyerSellerList].
  GetBuyerSellerListProvider call({
    String? cityState,
    String? commodityId,
  }) {
    return GetBuyerSellerListProvider(
      cityState: cityState,
      commodityId: commodityId,
    );
  }

  @override
  GetBuyerSellerListProvider getProviderOverride(
    covariant GetBuyerSellerListProvider provider,
  ) {
    return call(
      cityState: provider.cityState,
      commodityId: provider.commodityId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getBuyerSellerListProvider';
}

/// See also [getBuyerSellerList].
class GetBuyerSellerListProvider
    extends AutoDisposeStreamProvider<BuyerSelletListModel> {
  /// See also [getBuyerSellerList].
  GetBuyerSellerListProvider({
    String? cityState,
    String? commodityId,
  }) : this._internal(
          (ref) => getBuyerSellerList(
            ref as GetBuyerSellerListRef,
            cityState: cityState,
            commodityId: commodityId,
          ),
          from: getBuyerSellerListProvider,
          name: r'getBuyerSellerListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBuyerSellerListHash,
          dependencies: GetBuyerSellerListFamily._dependencies,
          allTransitiveDependencies:
              GetBuyerSellerListFamily._allTransitiveDependencies,
          cityState: cityState,
          commodityId: commodityId,
        );

  GetBuyerSellerListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityState,
    required this.commodityId,
  }) : super.internal();

  final String? cityState;
  final String? commodityId;

  @override
  Override overrideWith(
    Stream<BuyerSelletListModel> Function(GetBuyerSellerListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBuyerSellerListProvider._internal(
        (ref) => create(ref as GetBuyerSellerListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityState: cityState,
        commodityId: commodityId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<BuyerSelletListModel> createElement() {
    return _GetBuyerSellerListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBuyerSellerListProvider &&
        other.cityState == cityState &&
        other.commodityId == commodityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityState.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetBuyerSellerListRef
    on AutoDisposeStreamProviderRef<BuyerSelletListModel> {
  /// The parameter `cityState` of this provider.
  String? get cityState;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;
}

class _GetBuyerSellerListProviderElement
    extends AutoDisposeStreamProviderElement<BuyerSelletListModel>
    with GetBuyerSellerListRef {
  _GetBuyerSellerListProviderElement(super.provider);

  @override
  String? get cityState => (origin as GetBuyerSellerListProvider).cityState;
  @override
  String? get commodityId => (origin as GetBuyerSellerListProvider).commodityId;
}

String _$sbtBuyAndSellHash() => r'bccf3dbd7a632cabbfc7357c4c92886f74bccb53';

/// See also [sbtBuyAndSell].
@ProviderFor(sbtBuyAndSell)
const sbtBuyAndSellProvider = SbtBuyAndSellFamily();

/// See also [sbtBuyAndSell].
class SbtBuyAndSellFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [sbtBuyAndSell].
  const SbtBuyAndSellFamily();

  /// See also [sbtBuyAndSell].
  SbtBuyAndSellProvider call({
    String? commodity,
    String? qty,
    String? type,
    String? price,
    String? pinCode,
    String? truckNo,
  }) {
    return SbtBuyAndSellProvider(
      commodity: commodity,
      qty: qty,
      type: type,
      price: price,
      pinCode: pinCode,
      truckNo: truckNo,
    );
  }

  @override
  SbtBuyAndSellProvider getProviderOverride(
    covariant SbtBuyAndSellProvider provider,
  ) {
    return call(
      commodity: provider.commodity,
      qty: provider.qty,
      type: provider.type,
      price: provider.price,
      pinCode: provider.pinCode,
      truckNo: provider.truckNo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sbtBuyAndSellProvider';
}

/// See also [sbtBuyAndSell].
class SbtBuyAndSellProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [sbtBuyAndSell].
  SbtBuyAndSellProvider({
    String? commodity,
    String? qty,
    String? type,
    String? price,
    String? pinCode,
    String? truckNo,
  }) : this._internal(
          (ref) => sbtBuyAndSell(
            ref as SbtBuyAndSellRef,
            commodity: commodity,
            qty: qty,
            type: type,
            price: price,
            pinCode: pinCode,
            truckNo: truckNo,
          ),
          from: sbtBuyAndSellProvider,
          name: r'sbtBuyAndSellProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sbtBuyAndSellHash,
          dependencies: SbtBuyAndSellFamily._dependencies,
          allTransitiveDependencies:
              SbtBuyAndSellFamily._allTransitiveDependencies,
          commodity: commodity,
          qty: qty,
          type: type,
          price: price,
          pinCode: pinCode,
          truckNo: truckNo,
        );

  SbtBuyAndSellProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.commodity,
    required this.qty,
    required this.type,
    required this.price,
    required this.pinCode,
    required this.truckNo,
  }) : super.internal();

  final String? commodity;
  final String? qty;
  final String? type;
  final String? price;
  final String? pinCode;
  final String? truckNo;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(SbtBuyAndSellRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SbtBuyAndSellProvider._internal(
        (ref) => create(ref as SbtBuyAndSellRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        commodity: commodity,
        qty: qty,
        type: type,
        price: price,
        pinCode: pinCode,
        truckNo: truckNo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SbtBuyAndSellProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SbtBuyAndSellProvider &&
        other.commodity == commodity &&
        other.qty == qty &&
        other.type == type &&
        other.price == price &&
        other.pinCode == pinCode &&
        other.truckNo == truckNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, commodity.hashCode);
    hash = _SystemHash.combine(hash, qty.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);
    hash = _SystemHash.combine(hash, pinCode.hashCode);
    hash = _SystemHash.combine(hash, truckNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SbtBuyAndSellRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `commodity` of this provider.
  String? get commodity;

  /// The parameter `qty` of this provider.
  String? get qty;

  /// The parameter `type` of this provider.
  String? get type;

  /// The parameter `price` of this provider.
  String? get price;

  /// The parameter `pinCode` of this provider.
  String? get pinCode;

  /// The parameter `truckNo` of this provider.
  String? get truckNo;
}

class _SbtBuyAndSellProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SbtBuyAndSellRef {
  _SbtBuyAndSellProviderElement(super.provider);

  @override
  String? get commodity => (origin as SbtBuyAndSellProvider).commodity;
  @override
  String? get qty => (origin as SbtBuyAndSellProvider).qty;
  @override
  String? get type => (origin as SbtBuyAndSellProvider).type;
  @override
  String? get price => (origin as SbtBuyAndSellProvider).price;
  @override
  String? get pinCode => (origin as SbtBuyAndSellProvider).pinCode;
  @override
  String? get truckNo => (origin as SbtBuyAndSellProvider).truckNo;
}

String _$updateSbtHash() => r'238525e64d78b267eab8b978fe4a8b0caa5ba221';

/// See also [updateSbt].
@ProviderFor(updateSbt)
const updateSbtProvider = UpdateSbtFamily();

/// See also [updateSbt].
class UpdateSbtFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [updateSbt].
  const UpdateSbtFamily();

  /// See also [updateSbt].
  UpdateSbtProvider call({
    required String? productId,
    required String? tradeId,
    required String? commodityId,
    required String? qty,
    required String? price,
    required String? district_id,
    required String? type,
  }) {
    return UpdateSbtProvider(
      productId: productId,
      tradeId: tradeId,
      commodityId: commodityId,
      qty: qty,
      price: price,
      district_id: district_id,
      type: type,
    );
  }

  @override
  UpdateSbtProvider getProviderOverride(
    covariant UpdateSbtProvider provider,
  ) {
    return call(
      productId: provider.productId,
      tradeId: provider.tradeId,
      commodityId: provider.commodityId,
      qty: provider.qty,
      price: provider.price,
      district_id: provider.district_id,
      type: provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateSbtProvider';
}

/// See also [updateSbt].
class UpdateSbtProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [updateSbt].
  UpdateSbtProvider({
    required String? productId,
    required String? tradeId,
    required String? commodityId,
    required String? qty,
    required String? price,
    required String? district_id,
    required String? type,
  }) : this._internal(
          (ref) => updateSbt(
            ref as UpdateSbtRef,
            productId: productId,
            tradeId: tradeId,
            commodityId: commodityId,
            qty: qty,
            price: price,
            district_id: district_id,
            type: type,
          ),
          from: updateSbtProvider,
          name: r'updateSbtProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateSbtHash,
          dependencies: UpdateSbtFamily._dependencies,
          allTransitiveDependencies: UpdateSbtFamily._allTransitiveDependencies,
          productId: productId,
          tradeId: tradeId,
          commodityId: commodityId,
          qty: qty,
          price: price,
          district_id: district_id,
          type: type,
        );

  UpdateSbtProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.tradeId,
    required this.commodityId,
    required this.qty,
    required this.price,
    required this.district_id,
    required this.type,
  }) : super.internal();

  final String? productId;
  final String? tradeId;
  final String? commodityId;
  final String? qty;
  final String? price;
  final String? district_id;
  final String? type;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(UpdateSbtRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateSbtProvider._internal(
        (ref) => create(ref as UpdateSbtRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        tradeId: tradeId,
        commodityId: commodityId,
        qty: qty,
        price: price,
        district_id: district_id,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _UpdateSbtProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateSbtProvider &&
        other.productId == productId &&
        other.tradeId == tradeId &&
        other.commodityId == commodityId &&
        other.qty == qty &&
        other.price == price &&
        other.district_id == district_id &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, tradeId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, qty.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);
    hash = _SystemHash.combine(hash, district_id.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateSbtRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `productId` of this provider.
  String? get productId;

  /// The parameter `tradeId` of this provider.
  String? get tradeId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `qty` of this provider.
  String? get qty;

  /// The parameter `price` of this provider.
  String? get price;

  /// The parameter `district_id` of this provider.
  String? get district_id;

  /// The parameter `type` of this provider.
  String? get type;
}

class _UpdateSbtProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with UpdateSbtRef {
  _UpdateSbtProviderElement(super.provider);

  @override
  String? get productId => (origin as UpdateSbtProvider).productId;
  @override
  String? get tradeId => (origin as UpdateSbtProvider).tradeId;
  @override
  String? get commodityId => (origin as UpdateSbtProvider).commodityId;
  @override
  String? get qty => (origin as UpdateSbtProvider).qty;
  @override
  String? get price => (origin as UpdateSbtProvider).price;
  @override
  String? get district_id => (origin as UpdateSbtProvider).district_id;
  @override
  String? get type => (origin as UpdateSbtProvider).type;
}

String _$matchedOrdersHash() => r'cb4a6368e658c3c7c55016c3d48a23d08191955f';

/// See also [matchedOrders].
@ProviderFor(matchedOrders)
const matchedOrdersProvider = MatchedOrdersFamily();

/// See also [matchedOrders].
class MatchedOrdersFamily extends Family<AsyncValue<MatchedOrdersModel>> {
  /// See also [matchedOrders].
  const MatchedOrdersFamily();

  /// See also [matchedOrders].
  MatchedOrdersProvider call({
    String? productId,
  }) {
    return MatchedOrdersProvider(
      productId: productId,
    );
  }

  @override
  MatchedOrdersProvider getProviderOverride(
    covariant MatchedOrdersProvider provider,
  ) {
    return call(
      productId: provider.productId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'matchedOrdersProvider';
}

/// See also [matchedOrders].
class MatchedOrdersProvider
    extends AutoDisposeFutureProvider<MatchedOrdersModel> {
  /// See also [matchedOrders].
  MatchedOrdersProvider({
    String? productId,
  }) : this._internal(
          (ref) => matchedOrders(
            ref as MatchedOrdersRef,
            productId: productId,
          ),
          from: matchedOrdersProvider,
          name: r'matchedOrdersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$matchedOrdersHash,
          dependencies: MatchedOrdersFamily._dependencies,
          allTransitiveDependencies:
              MatchedOrdersFamily._allTransitiveDependencies,
          productId: productId,
        );

  MatchedOrdersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String? productId;

  @override
  Override overrideWith(
    FutureOr<MatchedOrdersModel> Function(MatchedOrdersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MatchedOrdersProvider._internal(
        (ref) => create(ref as MatchedOrdersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MatchedOrdersModel> createElement() {
    return _MatchedOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MatchedOrdersProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MatchedOrdersRef on AutoDisposeFutureProviderRef<MatchedOrdersModel> {
  /// The parameter `productId` of this provider.
  String? get productId;
}

class _MatchedOrdersProviderElement
    extends AutoDisposeFutureProviderElement<MatchedOrdersModel>
    with MatchedOrdersRef {
  _MatchedOrdersProviderElement(super.provider);

  @override
  String? get productId => (origin as MatchedOrdersProvider).productId;
}

String _$postSbtHash() => r'83d5658ab55fe71060eb79ef682ad49dced989eb';

/// See also [postSbt].
@ProviderFor(postSbt)
const postSbtProvider = PostSbtFamily();

/// See also [postSbt].
class PostSbtFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [postSbt].
  const PostSbtFamily();

  /// See also [postSbt].
  PostSbtProvider call({
    required String? productId,
    required String? commodityId,
    required String? qty,
    required String? price,
    required String? district_id,
    required String? type,
    String? loanType,
    String? schemeId,
  }) {
    return PostSbtProvider(
      productId: productId,
      commodityId: commodityId,
      qty: qty,
      price: price,
      district_id: district_id,
      type: type,
      loanType: loanType,
      schemeId: schemeId,
    );
  }

  @override
  PostSbtProvider getProviderOverride(
    covariant PostSbtProvider provider,
  ) {
    return call(
      productId: provider.productId,
      commodityId: provider.commodityId,
      qty: provider.qty,
      price: provider.price,
      district_id: provider.district_id,
      type: provider.type,
      loanType: provider.loanType,
      schemeId: provider.schemeId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postSbtProvider';
}

/// See also [postSbt].
class PostSbtProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [postSbt].
  PostSbtProvider({
    required String? productId,
    required String? commodityId,
    required String? qty,
    required String? price,
    required String? district_id,
    required String? type,
    String? loanType,
    String? schemeId,
  }) : this._internal(
          (ref) => postSbt(
            ref as PostSbtRef,
            productId: productId,
            commodityId: commodityId,
            qty: qty,
            price: price,
            district_id: district_id,
            type: type,
            loanType: loanType,
            schemeId: schemeId,
          ),
          from: postSbtProvider,
          name: r'postSbtProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postSbtHash,
          dependencies: PostSbtFamily._dependencies,
          allTransitiveDependencies: PostSbtFamily._allTransitiveDependencies,
          productId: productId,
          commodityId: commodityId,
          qty: qty,
          price: price,
          district_id: district_id,
          type: type,
          loanType: loanType,
          schemeId: schemeId,
        );

  PostSbtProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.commodityId,
    required this.qty,
    required this.price,
    required this.district_id,
    required this.type,
    required this.loanType,
    required this.schemeId,
  }) : super.internal();

  final String? productId;
  final String? commodityId;
  final String? qty;
  final String? price;
  final String? district_id;
  final String? type;
  final String? loanType;
  final String? schemeId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(PostSbtRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostSbtProvider._internal(
        (ref) => create(ref as PostSbtRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        commodityId: commodityId,
        qty: qty,
        price: price,
        district_id: district_id,
        type: type,
        loanType: loanType,
        schemeId: schemeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _PostSbtProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostSbtProvider &&
        other.productId == productId &&
        other.commodityId == commodityId &&
        other.qty == qty &&
        other.price == price &&
        other.district_id == district_id &&
        other.type == type &&
        other.loanType == loanType &&
        other.schemeId == schemeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, qty.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);
    hash = _SystemHash.combine(hash, district_id.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, loanType.hashCode);
    hash = _SystemHash.combine(hash, schemeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostSbtRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `productId` of this provider.
  String? get productId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `qty` of this provider.
  String? get qty;

  /// The parameter `price` of this provider.
  String? get price;

  /// The parameter `district_id` of this provider.
  String? get district_id;

  /// The parameter `type` of this provider.
  String? get type;

  /// The parameter `loanType` of this provider.
  String? get loanType;

  /// The parameter `schemeId` of this provider.
  String? get schemeId;
}

class _PostSbtProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with PostSbtRef {
  _PostSbtProviderElement(super.provider);

  @override
  String? get productId => (origin as PostSbtProvider).productId;
  @override
  String? get commodityId => (origin as PostSbtProvider).commodityId;
  @override
  String? get qty => (origin as PostSbtProvider).qty;
  @override
  String? get price => (origin as PostSbtProvider).price;
  @override
  String? get district_id => (origin as PostSbtProvider).district_id;
  @override
  String? get type => (origin as PostSbtProvider).type;
  @override
  String? get loanType => (origin as PostSbtProvider).loanType;
  @override
  String? get schemeId => (origin as PostSbtProvider).schemeId;
}

String _$warehouseDealDataHash() => r'59f7c88dd9c609f14d7f6fa5dc6a4ae1a283c58e';

/// See also [warehouseDealData].
@ProviderFor(warehouseDealData)
const warehouseDealDataProvider = WarehouseDealDataFamily();

/// See also [warehouseDealData].
class WarehouseDealDataFamily extends Family<AsyncValue<WarehouseDealModel>> {
  /// See also [warehouseDealData].
  const WarehouseDealDataFamily();

  /// See also [warehouseDealData].
  WarehouseDealDataProvider call({
    String? type,
    String? page,
  }) {
    return WarehouseDealDataProvider(
      type: type,
      page: page,
    );
  }

  @override
  WarehouseDealDataProvider getProviderOverride(
    covariant WarehouseDealDataProvider provider,
  ) {
    return call(
      type: provider.type,
      page: provider.page,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'warehouseDealDataProvider';
}

/// See also [warehouseDealData].
class WarehouseDealDataProvider
    extends AutoDisposeStreamProvider<WarehouseDealModel> {
  /// See also [warehouseDealData].
  WarehouseDealDataProvider({
    String? type,
    String? page,
  }) : this._internal(
          (ref) => warehouseDealData(
            ref as WarehouseDealDataRef,
            type: type,
            page: page,
          ),
          from: warehouseDealDataProvider,
          name: r'warehouseDealDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$warehouseDealDataHash,
          dependencies: WarehouseDealDataFamily._dependencies,
          allTransitiveDependencies:
              WarehouseDealDataFamily._allTransitiveDependencies,
          type: type,
          page: page,
        );

  WarehouseDealDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.page,
  }) : super.internal();

  final String? type;
  final String? page;

  @override
  Override overrideWith(
    Stream<WarehouseDealModel> Function(WarehouseDealDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WarehouseDealDataProvider._internal(
        (ref) => create(ref as WarehouseDealDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<WarehouseDealModel> createElement() {
    return _WarehouseDealDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WarehouseDealDataProvider &&
        other.type == type &&
        other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WarehouseDealDataRef on AutoDisposeStreamProviderRef<WarehouseDealModel> {
  /// The parameter `type` of this provider.
  String? get type;

  /// The parameter `page` of this provider.
  String? get page;
}

class _WarehouseDealDataProviderElement
    extends AutoDisposeStreamProviderElement<WarehouseDealModel>
    with WarehouseDealDataRef {
  _WarehouseDealDataProviderElement(super.provider);

  @override
  String? get type => (origin as WarehouseDealDataProvider).type;
  @override
  String? get page => (origin as WarehouseDealDataProvider).page;
}

String _$stackBuySellListHash() => r'feb0331ef1243f2dcf3de8590681631a41ed870a';

/// See also [stackBuySellList].
@ProviderFor(stackBuySellList)
const stackBuySellListProvider = StackBuySellListFamily();

/// See also [stackBuySellList].
class StackBuySellListFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [stackBuySellList].
  const StackBuySellListFamily();

  /// See also [stackBuySellList].
  StackBuySellListProvider call({
    String? type,
  }) {
    return StackBuySellListProvider(
      type: type,
    );
  }

  @override
  StackBuySellListProvider getProviderOverride(
    covariant StackBuySellListProvider provider,
  ) {
    return call(
      type: provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'stackBuySellListProvider';
}

/// See also [stackBuySellList].
class StackBuySellListProvider
    extends AutoDisposeStreamProvider<Map<String, dynamic>> {
  /// See also [stackBuySellList].
  StackBuySellListProvider({
    String? type,
  }) : this._internal(
          (ref) => stackBuySellList(
            ref as StackBuySellListRef,
            type: type,
          ),
          from: stackBuySellListProvider,
          name: r'stackBuySellListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stackBuySellListHash,
          dependencies: StackBuySellListFamily._dependencies,
          allTransitiveDependencies:
              StackBuySellListFamily._allTransitiveDependencies,
          type: type,
        );

  StackBuySellListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final String? type;

  @override
  Override overrideWith(
    Stream<Map<String, dynamic>> Function(StackBuySellListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StackBuySellListProvider._internal(
        (ref) => create(ref as StackBuySellListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Map<String, dynamic>> createElement() {
    return _StackBuySellListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StackBuySellListProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StackBuySellListRef
    on AutoDisposeStreamProviderRef<Map<String, dynamic>> {
  /// The parameter `type` of this provider.
  String? get type;
}

class _StackBuySellListProviderElement
    extends AutoDisposeStreamProviderElement<Map<String, dynamic>>
    with StackBuySellListRef {
  _StackBuySellListProviderElement(super.provider);

  @override
  String? get type => (origin as StackBuySellListProvider).type;
}

String _$spotDealDataHash() => r'fbcf23b1b675364e8836f411376d6de93f6b9179';

/// See also [spotDealData].
@ProviderFor(spotDealData)
const spotDealDataProvider = SpotDealDataFamily();

/// See also [spotDealData].
class SpotDealDataFamily extends Family<AsyncValue<SpotDealModel>> {
  /// See also [spotDealData].
  const SpotDealDataFamily();

  /// See also [spotDealData].
  SpotDealDataProvider call({
    String? type,
  }) {
    return SpotDealDataProvider(
      type: type,
    );
  }

  @override
  SpotDealDataProvider getProviderOverride(
    covariant SpotDealDataProvider provider,
  ) {
    return call(
      type: provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'spotDealDataProvider';
}

/// See also [spotDealData].
class SpotDealDataProvider extends AutoDisposeStreamProvider<SpotDealModel> {
  /// See also [spotDealData].
  SpotDealDataProvider({
    String? type,
  }) : this._internal(
          (ref) => spotDealData(
            ref as SpotDealDataRef,
            type: type,
          ),
          from: spotDealDataProvider,
          name: r'spotDealDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$spotDealDataHash,
          dependencies: SpotDealDataFamily._dependencies,
          allTransitiveDependencies:
              SpotDealDataFamily._allTransitiveDependencies,
          type: type,
        );

  SpotDealDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final String? type;

  @override
  Override overrideWith(
    Stream<SpotDealModel> Function(SpotDealDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SpotDealDataProvider._internal(
        (ref) => create(ref as SpotDealDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SpotDealModel> createElement() {
    return _SpotDealDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotDealDataProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SpotDealDataRef on AutoDisposeStreamProviderRef<SpotDealModel> {
  /// The parameter `type` of this provider.
  String? get type;
}

class _SpotDealDataProviderElement
    extends AutoDisposeStreamProviderElement<SpotDealModel>
    with SpotDealDataRef {
  _SpotDealDataProviderElement(super.provider);

  @override
  String? get type => (origin as SpotDealDataProvider).type;
}

String _$f2fDealDataHash() => r'bff8de23ff5eb253ad343eebdcf484047edfbb69';

/// See also [f2fDealData].
@ProviderFor(f2fDealData)
const f2fDealDataProvider = F2fDealDataFamily();

/// See also [f2fDealData].
class F2fDealDataFamily extends Family<AsyncValue<FaceToFaceModel>> {
  /// See also [f2fDealData].
  const F2fDealDataFamily();

  /// See also [f2fDealData].
  F2fDealDataProvider call({
    String? type,
  }) {
    return F2fDealDataProvider(
      type: type,
    );
  }

  @override
  F2fDealDataProvider getProviderOverride(
    covariant F2fDealDataProvider provider,
  ) {
    return call(
      type: provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'f2fDealDataProvider';
}

/// See also [f2fDealData].
class F2fDealDataProvider extends AutoDisposeStreamProvider<FaceToFaceModel> {
  /// See also [f2fDealData].
  F2fDealDataProvider({
    String? type,
  }) : this._internal(
          (ref) => f2fDealData(
            ref as F2fDealDataRef,
            type: type,
          ),
          from: f2fDealDataProvider,
          name: r'f2fDealDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$f2fDealDataHash,
          dependencies: F2fDealDataFamily._dependencies,
          allTransitiveDependencies:
              F2fDealDataFamily._allTransitiveDependencies,
          type: type,
        );

  F2fDealDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final String? type;

  @override
  Override overrideWith(
    Stream<FaceToFaceModel> Function(F2fDealDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: F2fDealDataProvider._internal(
        (ref) => create(ref as F2fDealDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<FaceToFaceModel> createElement() {
    return _F2fDealDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is F2fDealDataProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin F2fDealDataRef on AutoDisposeStreamProviderRef<FaceToFaceModel> {
  /// The parameter `type` of this provider.
  String? get type;
}

class _F2fDealDataProviderElement
    extends AutoDisposeStreamProviderElement<FaceToFaceModel>
    with F2fDealDataRef {
  _F2fDealDataProviderElement(super.provider);

  @override
  String? get type => (origin as F2fDealDataProvider).type;
}

String _$checkLoanStatusHash() => r'310190c78ef42b947005323b99eed0bd9279db20';

/// See also [checkLoanStatus].
@ProviderFor(checkLoanStatus)
const checkLoanStatusProvider = CheckLoanStatusFamily();

/// See also [checkLoanStatus].
class CheckLoanStatusFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [checkLoanStatus].
  const CheckLoanStatusFamily();

  /// See also [checkLoanStatus].
  CheckLoanStatusProvider call({
    String? inventoriesId,
  }) {
    return CheckLoanStatusProvider(
      inventoriesId: inventoriesId,
    );
  }

  @override
  CheckLoanStatusProvider getProviderOverride(
    covariant CheckLoanStatusProvider provider,
  ) {
    return call(
      inventoriesId: provider.inventoriesId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'checkLoanStatusProvider';
}

/// See also [checkLoanStatus].
class CheckLoanStatusProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [checkLoanStatus].
  CheckLoanStatusProvider({
    String? inventoriesId,
  }) : this._internal(
          (ref) => checkLoanStatus(
            ref as CheckLoanStatusRef,
            inventoriesId: inventoriesId,
          ),
          from: checkLoanStatusProvider,
          name: r'checkLoanStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkLoanStatusHash,
          dependencies: CheckLoanStatusFamily._dependencies,
          allTransitiveDependencies:
              CheckLoanStatusFamily._allTransitiveDependencies,
          inventoriesId: inventoriesId,
        );

  CheckLoanStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inventoriesId,
  }) : super.internal();

  final String? inventoriesId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(CheckLoanStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckLoanStatusProvider._internal(
        (ref) => create(ref as CheckLoanStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        inventoriesId: inventoriesId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _CheckLoanStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckLoanStatusProvider &&
        other.inventoriesId == inventoriesId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, inventoriesId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckLoanStatusRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `inventoriesId` of this provider.
  String? get inventoriesId;
}

class _CheckLoanStatusProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with CheckLoanStatusRef {
  _CheckLoanStatusProviderElement(super.provider);

  @override
  String? get inventoriesId =>
      (origin as CheckLoanStatusProvider).inventoriesId;
}

String _$checkLoanActionHash() => r'3f8cf5188219f353835e589d9cf640d06b280fb6';

/// See also [checkLoanAction].
@ProviderFor(checkLoanAction)
const checkLoanActionProvider = CheckLoanActionFamily();

/// See also [checkLoanAction].
class CheckLoanActionFamily
    extends Family<AsyncValue<CheckLoanActionResponse>> {
  /// See also [checkLoanAction].
  const CheckLoanActionFamily();

  /// See also [checkLoanAction].
  CheckLoanActionProvider call({
    String? catName,
    String? invId,
  }) {
    return CheckLoanActionProvider(
      catName: catName,
      invId: invId,
    );
  }

  @override
  CheckLoanActionProvider getProviderOverride(
    covariant CheckLoanActionProvider provider,
  ) {
    return call(
      catName: provider.catName,
      invId: provider.invId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'checkLoanActionProvider';
}

/// See also [checkLoanAction].
class CheckLoanActionProvider
    extends AutoDisposeFutureProvider<CheckLoanActionResponse> {
  /// See also [checkLoanAction].
  CheckLoanActionProvider({
    String? catName,
    String? invId,
  }) : this._internal(
          (ref) => checkLoanAction(
            ref as CheckLoanActionRef,
            catName: catName,
            invId: invId,
          ),
          from: checkLoanActionProvider,
          name: r'checkLoanActionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkLoanActionHash,
          dependencies: CheckLoanActionFamily._dependencies,
          allTransitiveDependencies:
              CheckLoanActionFamily._allTransitiveDependencies,
          catName: catName,
          invId: invId,
        );

  CheckLoanActionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.catName,
    required this.invId,
  }) : super.internal();

  final String? catName;
  final String? invId;

  @override
  Override overrideWith(
    FutureOr<CheckLoanActionResponse> Function(CheckLoanActionRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckLoanActionProvider._internal(
        (ref) => create(ref as CheckLoanActionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        catName: catName,
        invId: invId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CheckLoanActionResponse> createElement() {
    return _CheckLoanActionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckLoanActionProvider &&
        other.catName == catName &&
        other.invId == invId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, catName.hashCode);
    hash = _SystemHash.combine(hash, invId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckLoanActionRef
    on AutoDisposeFutureProviderRef<CheckLoanActionResponse> {
  /// The parameter `catName` of this provider.
  String? get catName;

  /// The parameter `invId` of this provider.
  String? get invId;
}

class _CheckLoanActionProviderElement
    extends AutoDisposeFutureProviderElement<CheckLoanActionResponse>
    with CheckLoanActionRef {
  _CheckLoanActionProviderElement(super.provider);

  @override
  String? get catName => (origin as CheckLoanActionProvider).catName;
  @override
  String? get invId => (origin as CheckLoanActionProvider).invId;
}

String _$warehouseBookingsHash() => r'585b25ab80c481c4ec4a5e18f437e5b65a61849c';

/// See also [warehouseBookings].
@ProviderFor(warehouseBookings)
final warehouseBookingsProvider =
    AutoDisposeStreamProvider<CaseIdStatusModel>.internal(
  warehouseBookings,
  name: r'warehouseBookingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$warehouseBookingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WarehouseBookingsRef = AutoDisposeStreamProviderRef<CaseIdStatusModel>;
String _$rejectQualityHash() => r'a3d71809a0178fb2d8d9098212e48e9f58159b67';

/// See also [rejectQuality].
@ProviderFor(rejectQuality)
const rejectQualityProvider = RejectQualityFamily();

/// See also [rejectQuality].
class RejectQualityFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [rejectQuality].
  const RejectQualityFamily();

  /// See also [rejectQuality].
  RejectQualityProvider call({
    required String caseId,
  }) {
    return RejectQualityProvider(
      caseId: caseId,
    );
  }

  @override
  RejectQualityProvider getProviderOverride(
    covariant RejectQualityProvider provider,
  ) {
    return call(
      caseId: provider.caseId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'rejectQualityProvider';
}

/// See also [rejectQuality].
class RejectQualityProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [rejectQuality].
  RejectQualityProvider({
    required String caseId,
  }) : this._internal(
          (ref) => rejectQuality(
            ref as RejectQualityRef,
            caseId: caseId,
          ),
          from: rejectQualityProvider,
          name: r'rejectQualityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$rejectQualityHash,
          dependencies: RejectQualityFamily._dependencies,
          allTransitiveDependencies:
              RejectQualityFamily._allTransitiveDependencies,
          caseId: caseId,
        );

  RejectQualityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.caseId,
  }) : super.internal();

  final String caseId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(RejectQualityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RejectQualityProvider._internal(
        (ref) => create(ref as RejectQualityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        caseId: caseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _RejectQualityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RejectQualityProvider && other.caseId == caseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, caseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RejectQualityRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `caseId` of this provider.
  String get caseId;
}

class _RejectQualityProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RejectQualityRef {
  _RejectQualityProviderElement(super.provider);

  @override
  String get caseId => (origin as RejectQualityProvider).caseId;
}

String _$apnaWantToSellHash() => r'54b52677721745758ba37b1799ee9c368194f227';

/// See also [apnaWantToSell].
@ProviderFor(apnaWantToSell)
const apnaWantToSellProvider = ApnaWantToSellFamily();

/// See also [apnaWantToSell].
class ApnaWantToSellFamily extends Family<AsyncValue<BaseResponseModel>> {
  /// See also [apnaWantToSell].
  const ApnaWantToSellFamily();

  /// See also [apnaWantToSell].
  ApnaWantToSellProvider call({
    String? inventoryId = "",
    String? price = "",
    String? quantity = "",
    String? rentRowId = "",
    String? interestRowId = "",
    String? mandiAmount = "",
    String? finalSettlementAmount = "",
    String? remFinalAmount = "",
    String? walletSettlementAmount = "",
  }) {
    return ApnaWantToSellProvider(
      inventoryId: inventoryId,
      price: price,
      quantity: quantity,
      rentRowId: rentRowId,
      interestRowId: interestRowId,
      mandiAmount: mandiAmount,
      finalSettlementAmount: finalSettlementAmount,
      remFinalAmount: remFinalAmount,
      walletSettlementAmount: walletSettlementAmount,
    );
  }

  @override
  ApnaWantToSellProvider getProviderOverride(
    covariant ApnaWantToSellProvider provider,
  ) {
    return call(
      inventoryId: provider.inventoryId,
      price: provider.price,
      quantity: provider.quantity,
      rentRowId: provider.rentRowId,
      interestRowId: provider.interestRowId,
      mandiAmount: provider.mandiAmount,
      finalSettlementAmount: provider.finalSettlementAmount,
      remFinalAmount: provider.remFinalAmount,
      walletSettlementAmount: provider.walletSettlementAmount,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'apnaWantToSellProvider';
}

/// See also [apnaWantToSell].
class ApnaWantToSellProvider
    extends AutoDisposeFutureProvider<BaseResponseModel> {
  /// See also [apnaWantToSell].
  ApnaWantToSellProvider({
    String? inventoryId = "",
    String? price = "",
    String? quantity = "",
    String? rentRowId = "",
    String? interestRowId = "",
    String? mandiAmount = "",
    String? finalSettlementAmount = "",
    String? remFinalAmount = "",
    String? walletSettlementAmount = "",
  }) : this._internal(
          (ref) => apnaWantToSell(
            ref as ApnaWantToSellRef,
            inventoryId: inventoryId,
            price: price,
            quantity: quantity,
            rentRowId: rentRowId,
            interestRowId: interestRowId,
            mandiAmount: mandiAmount,
            finalSettlementAmount: finalSettlementAmount,
            remFinalAmount: remFinalAmount,
            walletSettlementAmount: walletSettlementAmount,
          ),
          from: apnaWantToSellProvider,
          name: r'apnaWantToSellProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$apnaWantToSellHash,
          dependencies: ApnaWantToSellFamily._dependencies,
          allTransitiveDependencies:
              ApnaWantToSellFamily._allTransitiveDependencies,
          inventoryId: inventoryId,
          price: price,
          quantity: quantity,
          rentRowId: rentRowId,
          interestRowId: interestRowId,
          mandiAmount: mandiAmount,
          finalSettlementAmount: finalSettlementAmount,
          remFinalAmount: remFinalAmount,
          walletSettlementAmount: walletSettlementAmount,
        );

  ApnaWantToSellProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inventoryId,
    required this.price,
    required this.quantity,
    required this.rentRowId,
    required this.interestRowId,
    required this.mandiAmount,
    required this.finalSettlementAmount,
    required this.remFinalAmount,
    required this.walletSettlementAmount,
  }) : super.internal();

  final String? inventoryId;
  final String? price;
  final String? quantity;
  final String? rentRowId;
  final String? interestRowId;
  final String? mandiAmount;
  final String? finalSettlementAmount;
  final String? remFinalAmount;
  final String? walletSettlementAmount;

  @override
  Override overrideWith(
    FutureOr<BaseResponseModel> Function(ApnaWantToSellRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApnaWantToSellProvider._internal(
        (ref) => create(ref as ApnaWantToSellRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        inventoryId: inventoryId,
        price: price,
        quantity: quantity,
        rentRowId: rentRowId,
        interestRowId: interestRowId,
        mandiAmount: mandiAmount,
        finalSettlementAmount: finalSettlementAmount,
        remFinalAmount: remFinalAmount,
        walletSettlementAmount: walletSettlementAmount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseModel> createElement() {
    return _ApnaWantToSellProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApnaWantToSellProvider &&
        other.inventoryId == inventoryId &&
        other.price == price &&
        other.quantity == quantity &&
        other.rentRowId == rentRowId &&
        other.interestRowId == interestRowId &&
        other.mandiAmount == mandiAmount &&
        other.finalSettlementAmount == finalSettlementAmount &&
        other.remFinalAmount == remFinalAmount &&
        other.walletSettlementAmount == walletSettlementAmount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, inventoryId.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, rentRowId.hashCode);
    hash = _SystemHash.combine(hash, interestRowId.hashCode);
    hash = _SystemHash.combine(hash, mandiAmount.hashCode);
    hash = _SystemHash.combine(hash, finalSettlementAmount.hashCode);
    hash = _SystemHash.combine(hash, remFinalAmount.hashCode);
    hash = _SystemHash.combine(hash, walletSettlementAmount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ApnaWantToSellRef on AutoDisposeFutureProviderRef<BaseResponseModel> {
  /// The parameter `inventoryId` of this provider.
  String? get inventoryId;

  /// The parameter `price` of this provider.
  String? get price;

  /// The parameter `quantity` of this provider.
  String? get quantity;

  /// The parameter `rentRowId` of this provider.
  String? get rentRowId;

  /// The parameter `interestRowId` of this provider.
  String? get interestRowId;

  /// The parameter `mandiAmount` of this provider.
  String? get mandiAmount;

  /// The parameter `finalSettlementAmount` of this provider.
  String? get finalSettlementAmount;

  /// The parameter `remFinalAmount` of this provider.
  String? get remFinalAmount;

  /// The parameter `walletSettlementAmount` of this provider.
  String? get walletSettlementAmount;
}

class _ApnaWantToSellProviderElement
    extends AutoDisposeFutureProviderElement<BaseResponseModel>
    with ApnaWantToSellRef {
  _ApnaWantToSellProviderElement(super.provider);

  @override
  String? get inventoryId => (origin as ApnaWantToSellProvider).inventoryId;
  @override
  String? get price => (origin as ApnaWantToSellProvider).price;
  @override
  String? get quantity => (origin as ApnaWantToSellProvider).quantity;
  @override
  String? get rentRowId => (origin as ApnaWantToSellProvider).rentRowId;
  @override
  String? get interestRowId => (origin as ApnaWantToSellProvider).interestRowId;
  @override
  String? get mandiAmount => (origin as ApnaWantToSellProvider).mandiAmount;
  @override
  String? get finalSettlementAmount =>
      (origin as ApnaWantToSellProvider).finalSettlementAmount;
  @override
  String? get remFinalAmount =>
      (origin as ApnaWantToSellProvider).remFinalAmount;
  @override
  String? get walletSettlementAmount =>
      (origin as ApnaWantToSellProvider).walletSettlementAmount;
}

String _$approveBookingParametersHash() =>
    r'562b0ac18560976dbaa8d6df0d28eb8b5ae46148';

/// See also [approveBookingParameters].
@ProviderFor(approveBookingParameters)
const approveBookingParametersProvider = ApproveBookingParametersFamily();

/// See also [approveBookingParameters].
class ApproveBookingParametersFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [approveBookingParameters].
  const ApproveBookingParametersFamily();

  /// See also [approveBookingParameters].
  ApproveBookingParametersProvider call({
    String? caseId,
  }) {
    return ApproveBookingParametersProvider(
      caseId: caseId,
    );
  }

  @override
  ApproveBookingParametersProvider getProviderOverride(
    covariant ApproveBookingParametersProvider provider,
  ) {
    return call(
      caseId: provider.caseId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'approveBookingParametersProvider';
}

/// See also [approveBookingParameters].
class ApproveBookingParametersProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [approveBookingParameters].
  ApproveBookingParametersProvider({
    String? caseId,
  }) : this._internal(
          (ref) => approveBookingParameters(
            ref as ApproveBookingParametersRef,
            caseId: caseId,
          ),
          from: approveBookingParametersProvider,
          name: r'approveBookingParametersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$approveBookingParametersHash,
          dependencies: ApproveBookingParametersFamily._dependencies,
          allTransitiveDependencies:
              ApproveBookingParametersFamily._allTransitiveDependencies,
          caseId: caseId,
        );

  ApproveBookingParametersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.caseId,
  }) : super.internal();

  final String? caseId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(
            ApproveBookingParametersRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApproveBookingParametersProvider._internal(
        (ref) => create(ref as ApproveBookingParametersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        caseId: caseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _ApproveBookingParametersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApproveBookingParametersProvider && other.caseId == caseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, caseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ApproveBookingParametersRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `caseId` of this provider.
  String? get caseId;
}

class _ApproveBookingParametersProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with ApproveBookingParametersRef {
  _ApproveBookingParametersProviderElement(super.provider);

  @override
  String? get caseId => (origin as ApproveBookingParametersProvider).caseId;
}

String _$faqHash() => r'b38ad8770a17d2dfe2ab804d998ca1694e050e16';

/// See also [faq].
@ProviderFor(faq)
final faqProvider = AutoDisposeStreamProvider<CustomerSupportModel>.internal(
  faq,
  name: r'faqProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$faqHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FaqRef = AutoDisposeStreamProviderRef<CustomerSupportModel>;
String _$disableAccountHash() => r'3fad85f517a791c5e765bd6aa3d4b48bc581d921';

/// See also [disableAccount].
@ProviderFor(disableAccount)
final disableAccountProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  disableAccount,
  name: r'disableAccountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$disableAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DisableAccountRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
