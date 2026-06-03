// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_stock_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myStockHash() => r'f8780f5ccb31363cb1b30dad6b594751bb8d1d8a';

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

/// See also [myStock].
@ProviderFor(myStock)
const myStockProvider = MyStockFamily();

/// See also [myStock].
class MyStockFamily extends Family<AsyncValue<StockResponseModel>> {
  /// See also [myStock].
  const MyStockFamily();

  /// See also [myStock].
  MyStockProvider call(
    dynamic page,
    dynamic url,
    dynamic search,
    dynamic commodityid,
    dynamic salesstatus,
    dynamic warehouseid,
  ) {
    return MyStockProvider(
      page,
      url,
      search,
      commodityid,
      salesstatus,
      warehouseid,
    );
  }

  @override
  MyStockProvider getProviderOverride(
    covariant MyStockProvider provider,
  ) {
    return call(
      provider.page,
      provider.url,
      provider.search,
      provider.commodityid,
      provider.salesstatus,
      provider.warehouseid,
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
  String? get name => r'myStockProvider';
}

/// See also [myStock].
class MyStockProvider extends AutoDisposeStreamProvider<StockResponseModel> {
  /// See also [myStock].
  MyStockProvider(
    dynamic page,
    dynamic url,
    dynamic search,
    dynamic commodityid,
    dynamic salesstatus,
    dynamic warehouseid,
  ) : this._internal(
          (ref) => myStock(
            ref as MyStockRef,
            page,
            url,
            search,
            commodityid,
            salesstatus,
            warehouseid,
          ),
          from: myStockProvider,
          name: r'myStockProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myStockHash,
          dependencies: MyStockFamily._dependencies,
          allTransitiveDependencies: MyStockFamily._allTransitiveDependencies,
          page: page,
          url: url,
          search: search,
          commodityid: commodityid,
          salesstatus: salesstatus,
          warehouseid: warehouseid,
        );

  MyStockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.url,
    required this.search,
    required this.commodityid,
    required this.salesstatus,
    required this.warehouseid,
  }) : super.internal();

  final dynamic page;
  final dynamic url;
  final dynamic search;
  final dynamic commodityid;
  final dynamic salesstatus;
  final dynamic warehouseid;

  @override
  Override overrideWith(
    Stream<StockResponseModel> Function(MyStockRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyStockProvider._internal(
        (ref) => create(ref as MyStockRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        url: url,
        search: search,
        commodityid: commodityid,
        salesstatus: salesstatus,
        warehouseid: warehouseid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<StockResponseModel> createElement() {
    return _MyStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyStockProvider &&
        other.page == page &&
        other.url == url &&
        other.search == search &&
        other.commodityid == commodityid &&
        other.salesstatus == salesstatus &&
        other.warehouseid == warehouseid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);
    hash = _SystemHash.combine(hash, commodityid.hashCode);
    hash = _SystemHash.combine(hash, salesstatus.hashCode);
    hash = _SystemHash.combine(hash, warehouseid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MyStockRef on AutoDisposeStreamProviderRef<StockResponseModel> {
  /// The parameter `page` of this provider.
  dynamic get page;

  /// The parameter `url` of this provider.
  dynamic get url;

  /// The parameter `search` of this provider.
  dynamic get search;

  /// The parameter `commodityid` of this provider.
  dynamic get commodityid;

  /// The parameter `salesstatus` of this provider.
  dynamic get salesstatus;

  /// The parameter `warehouseid` of this provider.
  dynamic get warehouseid;
}

class _MyStockProviderElement
    extends AutoDisposeStreamProviderElement<StockResponseModel>
    with MyStockRef {
  _MyStockProviderElement(super.provider);

  @override
  dynamic get page => (origin as MyStockProvider).page;
  @override
  dynamic get url => (origin as MyStockProvider).url;
  @override
  dynamic get search => (origin as MyStockProvider).search;
  @override
  dynamic get commodityid => (origin as MyStockProvider).commodityid;
  @override
  dynamic get salesstatus => (origin as MyStockProvider).salesstatus;
  @override
  dynamic get warehouseid => (origin as MyStockProvider).warehouseid;
}

String _$getEmandiSellDataHash() => r'8905c0d1f0bafe78bd7272d8e98a38ea3bec6e07';

/// See also [getEmandiSellData].
@ProviderFor(getEmandiSellData)
const getEmandiSellDataProvider = GetEmandiSellDataFamily();

/// See also [getEmandiSellData].
class GetEmandiSellDataFamily
    extends Family<AsyncValue<EmandiSellResponseModel>> {
  /// See also [getEmandiSellData].
  const GetEmandiSellDataFamily();

  /// See also [getEmandiSellData].
  GetEmandiSellDataProvider call(
    String inventoryId,
    String commodityId,
  ) {
    return GetEmandiSellDataProvider(
      inventoryId,
      commodityId,
    );
  }

  @override
  GetEmandiSellDataProvider getProviderOverride(
    covariant GetEmandiSellDataProvider provider,
  ) {
    return call(
      provider.inventoryId,
      provider.commodityId,
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
  String? get name => r'getEmandiSellDataProvider';
}

/// See also [getEmandiSellData].
class GetEmandiSellDataProvider
    extends AutoDisposeFutureProvider<EmandiSellResponseModel> {
  /// See also [getEmandiSellData].
  GetEmandiSellDataProvider(
    String inventoryId,
    String commodityId,
  ) : this._internal(
          (ref) => getEmandiSellData(
            ref as GetEmandiSellDataRef,
            inventoryId,
            commodityId,
          ),
          from: getEmandiSellDataProvider,
          name: r'getEmandiSellDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getEmandiSellDataHash,
          dependencies: GetEmandiSellDataFamily._dependencies,
          allTransitiveDependencies:
              GetEmandiSellDataFamily._allTransitiveDependencies,
          inventoryId: inventoryId,
          commodityId: commodityId,
        );

  GetEmandiSellDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inventoryId,
    required this.commodityId,
  }) : super.internal();

  final String inventoryId;
  final String commodityId;

  @override
  Override overrideWith(
    FutureOr<EmandiSellResponseModel> Function(GetEmandiSellDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetEmandiSellDataProvider._internal(
        (ref) => create(ref as GetEmandiSellDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        inventoryId: inventoryId,
        commodityId: commodityId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<EmandiSellResponseModel> createElement() {
    return _GetEmandiSellDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEmandiSellDataProvider &&
        other.inventoryId == inventoryId &&
        other.commodityId == commodityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, inventoryId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetEmandiSellDataRef
    on AutoDisposeFutureProviderRef<EmandiSellResponseModel> {
  /// The parameter `inventoryId` of this provider.
  String get inventoryId;

  /// The parameter `commodityId` of this provider.
  String get commodityId;
}

class _GetEmandiSellDataProviderElement
    extends AutoDisposeFutureProviderElement<EmandiSellResponseModel>
    with GetEmandiSellDataRef {
  _GetEmandiSellDataProviderElement(super.provider);

  @override
  String get inventoryId => (origin as GetEmandiSellDataProvider).inventoryId;
  @override
  String get commodityId => (origin as GetEmandiSellDataProvider).commodityId;
}

String _$getWantToSellResponseHash() =>
    r'c9149e0363d9d492cbab80bf29748976510d2ea8';

/// See also [getWantToSellResponse].
@ProviderFor(getWantToSellResponse)
const getWantToSellResponseProvider = GetWantToSellResponseFamily();

/// See also [getWantToSellResponse].
class GetWantToSellResponseFamily
    extends Family<AsyncValue<WantToSellResponseModel>> {
  /// See also [getWantToSellResponse].
  const GetWantToSellResponseFamily();

  /// See also [getWantToSellResponse].
  GetWantToSellResponseProvider call(
    String inventoryId,
    String price,
  ) {
    return GetWantToSellResponseProvider(
      inventoryId,
      price,
    );
  }

  @override
  GetWantToSellResponseProvider getProviderOverride(
    covariant GetWantToSellResponseProvider provider,
  ) {
    return call(
      provider.inventoryId,
      provider.price,
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
  String? get name => r'getWantToSellResponseProvider';
}

/// See also [getWantToSellResponse].
class GetWantToSellResponseProvider
    extends AutoDisposeFutureProvider<WantToSellResponseModel> {
  /// See also [getWantToSellResponse].
  GetWantToSellResponseProvider(
    String inventoryId,
    String price,
  ) : this._internal(
          (ref) => getWantToSellResponse(
            ref as GetWantToSellResponseRef,
            inventoryId,
            price,
          ),
          from: getWantToSellResponseProvider,
          name: r'getWantToSellResponseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getWantToSellResponseHash,
          dependencies: GetWantToSellResponseFamily._dependencies,
          allTransitiveDependencies:
              GetWantToSellResponseFamily._allTransitiveDependencies,
          inventoryId: inventoryId,
          price: price,
        );

  GetWantToSellResponseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inventoryId,
    required this.price,
  }) : super.internal();

  final String inventoryId;
  final String price;

  @override
  Override overrideWith(
    FutureOr<WantToSellResponseModel> Function(
            GetWantToSellResponseRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetWantToSellResponseProvider._internal(
        (ref) => create(ref as GetWantToSellResponseRef),
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
  AutoDisposeFutureProviderElement<WantToSellResponseModel> createElement() {
    return _GetWantToSellResponseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetWantToSellResponseProvider &&
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
mixin GetWantToSellResponseRef
    on AutoDisposeFutureProviderRef<WantToSellResponseModel> {
  /// The parameter `inventoryId` of this provider.
  String get inventoryId;

  /// The parameter `price` of this provider.
  String get price;
}

class _GetWantToSellResponseProviderElement
    extends AutoDisposeFutureProviderElement<WantToSellResponseModel>
    with GetWantToSellResponseRef {
  _GetWantToSellResponseProviderElement(super.provider);

  @override
  String get inventoryId =>
      (origin as GetWantToSellResponseProvider).inventoryId;
  @override
  String get price => (origin as GetWantToSellResponseProvider).price;
}

String _$stacksTerminalListHash() =>
    r'3a6304ea5e9812c6c8371fe90a7f371a2c6aa695';

/// See also [stacksTerminalList].
@ProviderFor(stacksTerminalList)
final stacksTerminalListProvider =
    AutoDisposeFutureProvider<StacksTerminalListModel>.internal(
  stacksTerminalList,
  name: r'stacksTerminalListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stacksTerminalListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StacksTerminalListRef
    = AutoDisposeFutureProviderRef<StacksTerminalListModel>;
String _$stacksCommodityListHash() =>
    r'65cf2c4653d1f2693c7f61fb9c89428a1f419919';

/// See also [stacksCommodityList].
@ProviderFor(stacksCommodityList)
const stacksCommodityListProvider = StacksCommodityListFamily();

/// See also [stacksCommodityList].
class StacksCommodityListFamily
    extends Family<AsyncValue<StacksCommodityListModel>> {
  /// See also [stacksCommodityList].
  const StacksCommodityListFamily();

  /// See also [stacksCommodityList].
  StacksCommodityListProvider call({
    required String terminalId,
  }) {
    return StacksCommodityListProvider(
      terminalId: terminalId,
    );
  }

  @override
  StacksCommodityListProvider getProviderOverride(
    covariant StacksCommodityListProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
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
  String? get name => r'stacksCommodityListProvider';
}

/// See also [stacksCommodityList].
class StacksCommodityListProvider
    extends AutoDisposeFutureProvider<StacksCommodityListModel> {
  /// See also [stacksCommodityList].
  StacksCommodityListProvider({
    required String terminalId,
  }) : this._internal(
          (ref) => stacksCommodityList(
            ref as StacksCommodityListRef,
            terminalId: terminalId,
          ),
          from: stacksCommodityListProvider,
          name: r'stacksCommodityListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stacksCommodityListHash,
          dependencies: StacksCommodityListFamily._dependencies,
          allTransitiveDependencies:
              StacksCommodityListFamily._allTransitiveDependencies,
          terminalId: terminalId,
        );

  StacksCommodityListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
  }) : super.internal();

  final String terminalId;

  @override
  Override overrideWith(
    FutureOr<StacksCommodityListModel> Function(StacksCommodityListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StacksCommodityListProvider._internal(
        (ref) => create(ref as StacksCommodityListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<StacksCommodityListModel> createElement() {
    return _StacksCommodityListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StacksCommodityListProvider &&
        other.terminalId == terminalId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StacksCommodityListRef
    on AutoDisposeFutureProviderRef<StacksCommodityListModel> {
  /// The parameter `terminalId` of this provider.
  String get terminalId;
}

class _StacksCommodityListProviderElement
    extends AutoDisposeFutureProviderElement<StacksCommodityListModel>
    with StacksCommodityListRef {
  _StacksCommodityListProviderElement(super.provider);

  @override
  String get terminalId => (origin as StacksCommodityListProvider).terminalId;
}

String _$stacksListHash() => r'7ad8d7cb1b857fc716a419f5a9c413eee0de0c9f';

/// See also [stacksList].
@ProviderFor(stacksList)
const stacksListProvider = StacksListFamily();

/// See also [stacksList].
class StacksListFamily extends Family<AsyncValue<StacksListModel>> {
  /// See also [stacksList].
  const StacksListFamily();

  /// See also [stacksList].
  StacksListProvider call({
    required String terminalId,
    required String commodityId,
  }) {
    return StacksListProvider(
      terminalId: terminalId,
      commodityId: commodityId,
    );
  }

  @override
  StacksListProvider getProviderOverride(
    covariant StacksListProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
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
  String? get name => r'stacksListProvider';
}

/// See also [stacksList].
class StacksListProvider extends AutoDisposeFutureProvider<StacksListModel> {
  /// See also [stacksList].
  StacksListProvider({
    required String terminalId,
    required String commodityId,
  }) : this._internal(
          (ref) => stacksList(
            ref as StacksListRef,
            terminalId: terminalId,
            commodityId: commodityId,
          ),
          from: stacksListProvider,
          name: r'stacksListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stacksListHash,
          dependencies: StacksListFamily._dependencies,
          allTransitiveDependencies:
              StacksListFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
        );

  StacksListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.commodityId,
  }) : super.internal();

  final String terminalId;
  final String commodityId;

  @override
  Override overrideWith(
    FutureOr<StacksListModel> Function(StacksListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StacksListProvider._internal(
        (ref) => create(ref as StacksListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        commodityId: commodityId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<StacksListModel> createElement() {
    return _StacksListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StacksListProvider &&
        other.terminalId == terminalId &&
        other.commodityId == commodityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StacksListRef on AutoDisposeFutureProviderRef<StacksListModel> {
  /// The parameter `terminalId` of this provider.
  String get terminalId;

  /// The parameter `commodityId` of this provider.
  String get commodityId;
}

class _StacksListProviderElement
    extends AutoDisposeFutureProviderElement<StacksListModel>
    with StacksListRef {
  _StacksListProviderElement(super.provider);

  @override
  String get terminalId => (origin as StacksListProvider).terminalId;
  @override
  String get commodityId => (origin as StacksListProvider).commodityId;
}

String _$updateSellerPriceHash() => r'edb9f861443ec645ea35250c51ff5d04b8270f91';

/// See also [updateSellerPrice].
@ProviderFor(updateSellerPrice)
const updateSellerPriceProvider = UpdateSellerPriceFamily();

/// See also [updateSellerPrice].
class UpdateSellerPriceFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [updateSellerPrice].
  const UpdateSellerPriceFamily();

  /// See also [updateSellerPrice].
  UpdateSellerPriceProvider call({
    required String stackId,
    required String price,
  }) {
    return UpdateSellerPriceProvider(
      stackId: stackId,
      price: price,
    );
  }

  @override
  UpdateSellerPriceProvider getProviderOverride(
    covariant UpdateSellerPriceProvider provider,
  ) {
    return call(
      stackId: provider.stackId,
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
  String? get name => r'updateSellerPriceProvider';
}

/// See also [updateSellerPrice].
class UpdateSellerPriceProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [updateSellerPrice].
  UpdateSellerPriceProvider({
    required String stackId,
    required String price,
  }) : this._internal(
          (ref) => updateSellerPrice(
            ref as UpdateSellerPriceRef,
            stackId: stackId,
            price: price,
          ),
          from: updateSellerPriceProvider,
          name: r'updateSellerPriceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateSellerPriceHash,
          dependencies: UpdateSellerPriceFamily._dependencies,
          allTransitiveDependencies:
              UpdateSellerPriceFamily._allTransitiveDependencies,
          stackId: stackId,
          price: price,
        );

  UpdateSellerPriceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stackId,
    required this.price,
  }) : super.internal();

  final String stackId;
  final String price;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(UpdateSellerPriceRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateSellerPriceProvider._internal(
        (ref) => create(ref as UpdateSellerPriceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stackId: stackId,
        price: price,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _UpdateSellerPriceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateSellerPriceProvider &&
        other.stackId == stackId &&
        other.price == price;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stackId.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateSellerPriceRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `stackId` of this provider.
  String get stackId;

  /// The parameter `price` of this provider.
  String get price;
}

class _UpdateSellerPriceProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with UpdateSellerPriceRef {
  _UpdateSellerPriceProviderElement(super.provider);

  @override
  String get stackId => (origin as UpdateSellerPriceProvider).stackId;
  @override
  String get price => (origin as UpdateSellerPriceProvider).price;
}

String _$stackSellTermsHash() => r'a9bbb5b4ac6330c3835908705602be12ea093392';

/// See also [stackSellTerms].
@ProviderFor(stackSellTerms)
const stackSellTermsProvider = StackSellTermsFamily();

/// See also [stackSellTerms].
class StackSellTermsFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [stackSellTerms].
  const StackSellTermsFamily();

  /// See also [stackSellTerms].
  StackSellTermsProvider call({
    required String stackId,
  }) {
    return StackSellTermsProvider(
      stackId: stackId,
    );
  }

  @override
  StackSellTermsProvider getProviderOverride(
    covariant StackSellTermsProvider provider,
  ) {
    return call(
      stackId: provider.stackId,
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
  String? get name => r'stackSellTermsProvider';
}

/// See also [stackSellTerms].
class StackSellTermsProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [stackSellTerms].
  StackSellTermsProvider({
    required String stackId,
  }) : this._internal(
          (ref) => stackSellTerms(
            ref as StackSellTermsRef,
            stackId: stackId,
          ),
          from: stackSellTermsProvider,
          name: r'stackSellTermsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stackSellTermsHash,
          dependencies: StackSellTermsFamily._dependencies,
          allTransitiveDependencies:
              StackSellTermsFamily._allTransitiveDependencies,
          stackId: stackId,
        );

  StackSellTermsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stackId,
  }) : super.internal();

  final String stackId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(StackSellTermsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StackSellTermsProvider._internal(
        (ref) => create(ref as StackSellTermsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stackId: stackId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _StackSellTermsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StackSellTermsProvider && other.stackId == stackId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stackId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StackSellTermsRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `stackId` of this provider.
  String get stackId;
}

class _StackSellTermsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with StackSellTermsRef {
  _StackSellTermsProviderElement(super.provider);

  @override
  String get stackId => (origin as StackSellTermsProvider).stackId;
}

String _$deleteSellerPriceHash() => r'c630056ce1a0fab499bdcf857a50472e25e7b03b';

/// See also [deleteSellerPrice].
@ProviderFor(deleteSellerPrice)
const deleteSellerPriceProvider = DeleteSellerPriceFamily();

/// See also [deleteSellerPrice].
class DeleteSellerPriceFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [deleteSellerPrice].
  const DeleteSellerPriceFamily();

  /// See also [deleteSellerPrice].
  DeleteSellerPriceProvider call({
    required String stackId,
  }) {
    return DeleteSellerPriceProvider(
      stackId: stackId,
    );
  }

  @override
  DeleteSellerPriceProvider getProviderOverride(
    covariant DeleteSellerPriceProvider provider,
  ) {
    return call(
      stackId: provider.stackId,
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
  String? get name => r'deleteSellerPriceProvider';
}

/// See also [deleteSellerPrice].
class DeleteSellerPriceProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [deleteSellerPrice].
  DeleteSellerPriceProvider({
    required String stackId,
  }) : this._internal(
          (ref) => deleteSellerPrice(
            ref as DeleteSellerPriceRef,
            stackId: stackId,
          ),
          from: deleteSellerPriceProvider,
          name: r'deleteSellerPriceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteSellerPriceHash,
          dependencies: DeleteSellerPriceFamily._dependencies,
          allTransitiveDependencies:
              DeleteSellerPriceFamily._allTransitiveDependencies,
          stackId: stackId,
        );

  DeleteSellerPriceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stackId,
  }) : super.internal();

  final String stackId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(DeleteSellerPriceRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteSellerPriceProvider._internal(
        (ref) => create(ref as DeleteSellerPriceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stackId: stackId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _DeleteSellerPriceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteSellerPriceProvider && other.stackId == stackId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stackId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteSellerPriceRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `stackId` of this provider.
  String get stackId;
}

class _DeleteSellerPriceProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with DeleteSellerPriceRef {
  _DeleteSellerPriceProviderElement(super.provider);

  @override
  String get stackId => (origin as DeleteSellerPriceProvider).stackId;
}

String _$bidSellStackHash() => r'0841888b42f7fa0538951e6c704f8de6c64871a7';

/// See also [bidSellStack].
@ProviderFor(bidSellStack)
const bidSellStackProvider = BidSellStackFamily();

/// See also [bidSellStack].
class BidSellStackFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [bidSellStack].
  const BidSellStackFamily();

  /// See also [bidSellStack].
  BidSellStackProvider call({
    required String price,
    required String liftingDays,
    required String id,
    required String walletType,
    String? loanType,
    String? schemeId,
  }) {
    return BidSellStackProvider(
      price: price,
      liftingDays: liftingDays,
      id: id,
      walletType: walletType,
      loanType: loanType,
      schemeId: schemeId,
    );
  }

  @override
  BidSellStackProvider getProviderOverride(
    covariant BidSellStackProvider provider,
  ) {
    return call(
      price: provider.price,
      liftingDays: provider.liftingDays,
      id: provider.id,
      walletType: provider.walletType,
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
  String? get name => r'bidSellStackProvider';
}

/// See also [bidSellStack].
class BidSellStackProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [bidSellStack].
  BidSellStackProvider({
    required String price,
    required String liftingDays,
    required String id,
    required String walletType,
    String? loanType,
    String? schemeId,
  }) : this._internal(
          (ref) => bidSellStack(
            ref as BidSellStackRef,
            price: price,
            liftingDays: liftingDays,
            id: id,
            walletType: walletType,
            loanType: loanType,
            schemeId: schemeId,
          ),
          from: bidSellStackProvider,
          name: r'bidSellStackProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bidSellStackHash,
          dependencies: BidSellStackFamily._dependencies,
          allTransitiveDependencies:
              BidSellStackFamily._allTransitiveDependencies,
          price: price,
          liftingDays: liftingDays,
          id: id,
          walletType: walletType,
          loanType: loanType,
          schemeId: schemeId,
        );

  BidSellStackProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.price,
    required this.liftingDays,
    required this.id,
    required this.walletType,
    required this.loanType,
    required this.schemeId,
  }) : super.internal();

  final String price;
  final String liftingDays;
  final String id;
  final String walletType;
  final String? loanType;
  final String? schemeId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(BidSellStackRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BidSellStackProvider._internal(
        (ref) => create(ref as BidSellStackRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        price: price,
        liftingDays: liftingDays,
        id: id,
        walletType: walletType,
        loanType: loanType,
        schemeId: schemeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _BidSellStackProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BidSellStackProvider &&
        other.price == price &&
        other.liftingDays == liftingDays &&
        other.id == id &&
        other.walletType == walletType &&
        other.loanType == loanType &&
        other.schemeId == schemeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);
    hash = _SystemHash.combine(hash, liftingDays.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, walletType.hashCode);
    hash = _SystemHash.combine(hash, loanType.hashCode);
    hash = _SystemHash.combine(hash, schemeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BidSellStackRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `price` of this provider.
  String get price;

  /// The parameter `liftingDays` of this provider.
  String get liftingDays;

  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `walletType` of this provider.
  String get walletType;

  /// The parameter `loanType` of this provider.
  String? get loanType;

  /// The parameter `schemeId` of this provider.
  String? get schemeId;
}

class _BidSellStackProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with BidSellStackRef {
  _BidSellStackProviderElement(super.provider);

  @override
  String get price => (origin as BidSellStackProvider).price;
  @override
  String get liftingDays => (origin as BidSellStackProvider).liftingDays;
  @override
  String get id => (origin as BidSellStackProvider).id;
  @override
  String get walletType => (origin as BidSellStackProvider).walletType;
  @override
  String? get loanType => (origin as BidSellStackProvider).loanType;
  @override
  String? get schemeId => (origin as BidSellStackProvider).schemeId;
}

String _$stackSettlementHash() => r'e62f99a77b5fb1d090ca4b5ac0f2c96431702353';

/// See also [stackSettlement].
@ProviderFor(stackSettlement)
const stackSettlementProvider = StackSettlementFamily();

/// See also [stackSettlement].
class StackSettlementFamily extends Family<AsyncValue<StackSettlementModel>> {
  /// See also [stackSettlement].
  const StackSettlementFamily();

  /// See also [stackSettlement].
  StackSettlementProvider call({
    required String terminalId,
    required String commodityId,
    required String stackId,
    required String price,
  }) {
    return StackSettlementProvider(
      terminalId: terminalId,
      commodityId: commodityId,
      stackId: stackId,
      price: price,
    );
  }

  @override
  StackSettlementProvider getProviderOverride(
    covariant StackSettlementProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      commodityId: provider.commodityId,
      stackId: provider.stackId,
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
  String? get name => r'stackSettlementProvider';
}

/// See also [stackSettlement].
class StackSettlementProvider
    extends AutoDisposeStreamProvider<StackSettlementModel> {
  /// See also [stackSettlement].
  StackSettlementProvider({
    required String terminalId,
    required String commodityId,
    required String stackId,
    required String price,
  }) : this._internal(
          (ref) => stackSettlement(
            ref as StackSettlementRef,
            terminalId: terminalId,
            commodityId: commodityId,
            stackId: stackId,
            price: price,
          ),
          from: stackSettlementProvider,
          name: r'stackSettlementProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stackSettlementHash,
          dependencies: StackSettlementFamily._dependencies,
          allTransitiveDependencies:
              StackSettlementFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
          stackId: stackId,
          price: price,
        );

  StackSettlementProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.commodityId,
    required this.stackId,
    required this.price,
  }) : super.internal();

  final String terminalId;
  final String commodityId;
  final String stackId;
  final String price;

  @override
  Override overrideWith(
    Stream<StackSettlementModel> Function(StackSettlementRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StackSettlementProvider._internal(
        (ref) => create(ref as StackSettlementRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        commodityId: commodityId,
        stackId: stackId,
        price: price,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<StackSettlementModel> createElement() {
    return _StackSettlementProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StackSettlementProvider &&
        other.terminalId == terminalId &&
        other.commodityId == commodityId &&
        other.stackId == stackId &&
        other.price == price;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, stackId.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StackSettlementRef on AutoDisposeStreamProviderRef<StackSettlementModel> {
  /// The parameter `terminalId` of this provider.
  String get terminalId;

  /// The parameter `commodityId` of this provider.
  String get commodityId;

  /// The parameter `stackId` of this provider.
  String get stackId;

  /// The parameter `price` of this provider.
  String get price;
}

class _StackSettlementProviderElement
    extends AutoDisposeStreamProviderElement<StackSettlementModel>
    with StackSettlementRef {
  _StackSettlementProviderElement(super.provider);

  @override
  String get terminalId => (origin as StackSettlementProvider).terminalId;
  @override
  String get commodityId => (origin as StackSettlementProvider).commodityId;
  @override
  String get stackId => (origin as StackSettlementProvider).stackId;
  @override
  String get price => (origin as StackSettlementProvider).price;
}

String _$stackWantToSellHash() => r'af7459c6c8deee1a5523e42da599edc47c851c2b';

/// See also [stackWantToSell].
@ProviderFor(stackWantToSell)
const stackWantToSellProvider = StackWantToSellFamily();

/// See also [stackWantToSell].
class StackWantToSellFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [stackWantToSell].
  const StackWantToSellFamily();

  /// See also [stackWantToSell].
  StackWantToSellProvider call({
    required String terminalId,
    required String commodityId,
    required String stackId,
    required String price,
  }) {
    return StackWantToSellProvider(
      terminalId: terminalId,
      commodityId: commodityId,
      stackId: stackId,
      price: price,
    );
  }

  @override
  StackWantToSellProvider getProviderOverride(
    covariant StackWantToSellProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      commodityId: provider.commodityId,
      stackId: provider.stackId,
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
  String? get name => r'stackWantToSellProvider';
}

/// See also [stackWantToSell].
class StackWantToSellProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [stackWantToSell].
  StackWantToSellProvider({
    required String terminalId,
    required String commodityId,
    required String stackId,
    required String price,
  }) : this._internal(
          (ref) => stackWantToSell(
            ref as StackWantToSellRef,
            terminalId: terminalId,
            commodityId: commodityId,
            stackId: stackId,
            price: price,
          ),
          from: stackWantToSellProvider,
          name: r'stackWantToSellProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stackWantToSellHash,
          dependencies: StackWantToSellFamily._dependencies,
          allTransitiveDependencies:
              StackWantToSellFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
          stackId: stackId,
          price: price,
        );

  StackWantToSellProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.commodityId,
    required this.stackId,
    required this.price,
  }) : super.internal();

  final String terminalId;
  final String commodityId;
  final String stackId;
  final String price;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(StackWantToSellRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StackWantToSellProvider._internal(
        (ref) => create(ref as StackWantToSellRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        commodityId: commodityId,
        stackId: stackId,
        price: price,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _StackWantToSellProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StackWantToSellProvider &&
        other.terminalId == terminalId &&
        other.commodityId == commodityId &&
        other.stackId == stackId &&
        other.price == price;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, stackId.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StackWantToSellRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `terminalId` of this provider.
  String get terminalId;

  /// The parameter `commodityId` of this provider.
  String get commodityId;

  /// The parameter `stackId` of this provider.
  String get stackId;

  /// The parameter `price` of this provider.
  String get price;
}

class _StackWantToSellProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with StackWantToSellRef {
  _StackWantToSellProviderElement(super.provider);

  @override
  String get terminalId => (origin as StackWantToSellProvider).terminalId;
  @override
  String get commodityId => (origin as StackWantToSellProvider).commodityId;
  @override
  String get stackId => (origin as StackWantToSellProvider).stackId;
  @override
  String get price => (origin as StackWantToSellProvider).price;
}

String _$stackSellListHash() => r'37d964242d562eb357bced60fcd5fc1800c3f65e';

/// See also [stackSellList].
@ProviderFor(stackSellList)
final stackSellListProvider =
    AutoDisposeStreamProvider<StackSellListModel>.internal(
  stackSellList,
  name: r'stackSellListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stackSellListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StackSellListRef = AutoDisposeStreamProviderRef<StackSellListModel>;
String _$stackOrderListHash() => r'0449f07e851ad75929378c79df5dc6a7cac1d9a9';

/// See also [stackOrderList].
@ProviderFor(stackOrderList)
final stackOrderListProvider =
    AutoDisposeStreamProvider<Map<String, dynamic>>.internal(
  stackOrderList,
  name: r'stackOrderListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stackOrderListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StackOrderListRef = AutoDisposeStreamProviderRef<Map<String, dynamic>>;
String _$initDioHash() => r'8550577c4339d97a2134efde0bef307d7c8b059b';

/// See also [initDio].
@ProviderFor(initDio)
final initDioProvider = AutoDisposeProvider<Dio>.internal(
  initDio,
  name: r'initDioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$initDioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InitDioRef = AutoDisposeProviderRef<Dio>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
