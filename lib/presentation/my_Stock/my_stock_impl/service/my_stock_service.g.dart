// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_stock_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myStockHash() => r'f8eda4ca87e3da79d5ef26d39a9aade00314e89f';

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
class MyStockFamily extends Family<AsyncValue<List<Datum>>> {
  /// See also [myStock].
  const MyStockFamily();

  /// See also [myStock].
  MyStockProvider call({
    String? page,
    String? search = "",
    String? limit = "3",
  }) {
    return MyStockProvider(
      page: page,
      search: search,
      limit: limit,
    );
  }

  @override
  MyStockProvider getProviderOverride(
    covariant MyStockProvider provider,
  ) {
    return call(
      page: provider.page,
      search: provider.search,
      limit: provider.limit,
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
class MyStockProvider extends AutoDisposeFutureProvider<List<Datum>> {
  /// See also [myStock].
  MyStockProvider({
    String? page,
    String? search = "",
    String? limit = "3",
  }) : this._internal(
          (ref) => myStock(
            ref as MyStockRef,
            page: page,
            search: search,
            limit: limit,
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
          search: search,
          limit: limit,
        );

  MyStockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.search,
    required this.limit,
  }) : super.internal();

  final String? page;
  final String? search;
  final String? limit;

  @override
  Override overrideWith(
    FutureOr<List<Datum>> Function(MyStockRef provider) create,
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
        search: search,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Datum>> createElement() {
    return _MyStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyStockProvider &&
        other.page == page &&
        other.search == search &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MyStockRef on AutoDisposeFutureProviderRef<List<Datum>> {
  /// The parameter `page` of this provider.
  String? get page;

  /// The parameter `search` of this provider.
  String? get search;

  /// The parameter `limit` of this provider.
  String? get limit;
}

class _MyStockProviderElement
    extends AutoDisposeFutureProviderElement<List<Datum>> with MyStockRef {
  _MyStockProviderElement(super.provider);

  @override
  String? get page => (origin as MyStockProvider).page;
  @override
  String? get search => (origin as MyStockProvider).search;
  @override
  String? get limit => (origin as MyStockProvider).limit;
}

String _$getEmandiSellDataHash() => r'd25b6bdbefdd1c75a93e17350f9276cfbd26e6e2';

/// See also [getEmandiSellData].
@ProviderFor(getEmandiSellData)
const getEmandiSellDataProvider = GetEmandiSellDataFamily();

/// See also [getEmandiSellData].
class GetEmandiSellDataFamily
    extends Family<AsyncValue<EmandiSellResponseModel>> {
  /// See also [getEmandiSellData].
  const GetEmandiSellDataFamily();

  /// See also [getEmandiSellData].
  GetEmandiSellDataProvider call({
    String? inventoryId,
    String? commodityId,
  }) {
    return GetEmandiSellDataProvider(
      inventoryId: inventoryId,
      commodityId: commodityId,
    );
  }

  @override
  GetEmandiSellDataProvider getProviderOverride(
    covariant GetEmandiSellDataProvider provider,
  ) {
    return call(
      inventoryId: provider.inventoryId,
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
  String? get name => r'getEmandiSellDataProvider';
}

/// See also [getEmandiSellData].
class GetEmandiSellDataProvider
    extends AutoDisposeFutureProvider<EmandiSellResponseModel> {
  /// See also [getEmandiSellData].
  GetEmandiSellDataProvider({
    String? inventoryId,
    String? commodityId,
  }) : this._internal(
          (ref) => getEmandiSellData(
            ref as GetEmandiSellDataRef,
            inventoryId: inventoryId,
            commodityId: commodityId,
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

  final String? inventoryId;
  final String? commodityId;

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
  String? get inventoryId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;
}

class _GetEmandiSellDataProviderElement
    extends AutoDisposeFutureProviderElement<EmandiSellResponseModel>
    with GetEmandiSellDataRef {
  _GetEmandiSellDataProviderElement(super.provider);

  @override
  String? get inventoryId => (origin as GetEmandiSellDataProvider).inventoryId;
  @override
  String? get commodityId => (origin as GetEmandiSellDataProvider).commodityId;
}

String _$getWantToSellResponseHash() =>
    r'7ee308b73722bc6c1ef673507e3af9eae28ff391';

/// See also [getWantToSellResponse].
@ProviderFor(getWantToSellResponse)
const getWantToSellResponseProvider = GetWantToSellResponseFamily();

/// See also [getWantToSellResponse].
class GetWantToSellResponseFamily
    extends Family<AsyncValue<WantToSellResponseModel>> {
  /// See also [getWantToSellResponse].
  const GetWantToSellResponseFamily();

  /// See also [getWantToSellResponse].
  GetWantToSellResponseProvider call({
    String? inventoryId,
    String? price,
  }) {
    return GetWantToSellResponseProvider(
      inventoryId: inventoryId,
      price: price,
    );
  }

  @override
  GetWantToSellResponseProvider getProviderOverride(
    covariant GetWantToSellResponseProvider provider,
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
  String? get name => r'getWantToSellResponseProvider';
}

/// See also [getWantToSellResponse].
class GetWantToSellResponseProvider
    extends AutoDisposeFutureProvider<WantToSellResponseModel> {
  /// See also [getWantToSellResponse].
  GetWantToSellResponseProvider({
    String? inventoryId,
    String? price,
  }) : this._internal(
          (ref) => getWantToSellResponse(
            ref as GetWantToSellResponseRef,
            inventoryId: inventoryId,
            price: price,
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

  final String? inventoryId;
  final String? price;

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
  String? get inventoryId;

  /// The parameter `price` of this provider.
  String? get price;
}

class _GetWantToSellResponseProviderElement
    extends AutoDisposeFutureProviderElement<WantToSellResponseModel>
    with GetWantToSellResponseRef {
  _GetWantToSellResponseProviderElement(super.provider);

  @override
  String? get inventoryId =>
      (origin as GetWantToSellResponseProvider).inventoryId;
  @override
  String? get price => (origin as GetWantToSellResponseProvider).price;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
