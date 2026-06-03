// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$biddingDataHash() => r'8b0e85a912d5106035f3bc2b1838b29555271561';

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

/// See also [biddingData].
@ProviderFor(biddingData)
const biddingDataProvider = BiddingDataFamily();

/// See also [biddingData].
class BiddingDataFamily extends Family<AsyncValue<BiddingResponseModel>> {
  /// See also [biddingData].
  const BiddingDataFamily();

  /// See also [biddingData].
  BiddingDataProvider call({
    String? inventoryId,
    String? status,
  }) {
    return BiddingDataProvider(
      inventoryId: inventoryId,
      status: status,
    );
  }

  @override
  BiddingDataProvider getProviderOverride(
    covariant BiddingDataProvider provider,
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
  String? get name => r'biddingDataProvider';
}

/// See also [biddingData].
class BiddingDataProvider
    extends AutoDisposeFutureProvider<BiddingResponseModel> {
  /// See also [biddingData].
  BiddingDataProvider({
    String? inventoryId,
    String? status,
  }) : this._internal(
          (ref) => biddingData(
            ref as BiddingDataRef,
            inventoryId: inventoryId,
            status: status,
          ),
          from: biddingDataProvider,
          name: r'biddingDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$biddingDataHash,
          dependencies: BiddingDataFamily._dependencies,
          allTransitiveDependencies:
              BiddingDataFamily._allTransitiveDependencies,
          inventoryId: inventoryId,
          status: status,
        );

  BiddingDataProvider._internal(
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
    FutureOr<BiddingResponseModel> Function(BiddingDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BiddingDataProvider._internal(
        (ref) => create(ref as BiddingDataRef),
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
  AutoDisposeFutureProviderElement<BiddingResponseModel> createElement() {
    return _BiddingDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BiddingDataProvider &&
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
mixin BiddingDataRef on AutoDisposeFutureProviderRef<BiddingResponseModel> {
  /// The parameter `inventoryId` of this provider.
  String? get inventoryId;

  /// The parameter `status` of this provider.
  String? get status;
}

class _BiddingDataProviderElement
    extends AutoDisposeFutureProviderElement<BiddingResponseModel>
    with BiddingDataRef {
  _BiddingDataProviderElement(super.provider);

  @override
  String? get inventoryId => (origin as BiddingDataProvider).inventoryId;
  @override
  String? get status => (origin as BiddingDataProvider).status;
}

String _$productQualityHash() => r'd279a69ffd5286a82020f381d2b4c812b1e7e176';

/// See also [productQuality].
@ProviderFor(productQuality)
const productQualityProvider = ProductQualityFamily();

/// See also [productQuality].
class ProductQualityFamily extends Family<AsyncValue<ProductQualityModel>> {
  /// See also [productQuality].
  const ProductQualityFamily();

  /// See also [productQuality].
  ProductQualityProvider call({
    String? id,
  }) {
    return ProductQualityProvider(
      id: id,
    );
  }

  @override
  ProductQualityProvider getProviderOverride(
    covariant ProductQualityProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'productQualityProvider';
}

/// See also [productQuality].
class ProductQualityProvider
    extends AutoDisposeStreamProvider<ProductQualityModel> {
  /// See also [productQuality].
  ProductQualityProvider({
    String? id,
  }) : this._internal(
          (ref) => productQuality(
            ref as ProductQualityRef,
            id: id,
          ),
          from: productQualityProvider,
          name: r'productQualityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productQualityHash,
          dependencies: ProductQualityFamily._dependencies,
          allTransitiveDependencies:
              ProductQualityFamily._allTransitiveDependencies,
          id: id,
        );

  ProductQualityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  Override overrideWith(
    Stream<ProductQualityModel> Function(ProductQualityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductQualityProvider._internal(
        (ref) => create(ref as ProductQualityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<ProductQualityModel> createElement() {
    return _ProductQualityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductQualityProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductQualityRef on AutoDisposeStreamProviderRef<ProductQualityModel> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _ProductQualityProviderElement
    extends AutoDisposeStreamProviderElement<ProductQualityModel>
    with ProductQualityRef {
  _ProductQualityProviderElement(super.provider);

  @override
  String? get id => (origin as ProductQualityProvider).id;
}

String _$warehouseListHash() => r'e68f3c7f85d4592c67010ac7438264a914d8cf3a';

/// See also [warehouseList].
@ProviderFor(warehouseList)
const warehouseListProvider = WarehouseListFamily();

/// See also [warehouseList].
class WarehouseListFamily extends Family<AsyncValue<WarehouseListModel>> {
  /// See also [warehouseList].
  const WarehouseListFamily();

  /// See also [warehouseList].
  WarehouseListProvider call({
    String? id,
  }) {
    return WarehouseListProvider(
      id: id,
    );
  }

  @override
  WarehouseListProvider getProviderOverride(
    covariant WarehouseListProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'warehouseListProvider';
}

/// See also [warehouseList].
class WarehouseListProvider
    extends AutoDisposeStreamProvider<WarehouseListModel> {
  /// See also [warehouseList].
  WarehouseListProvider({
    String? id,
  }) : this._internal(
          (ref) => warehouseList(
            ref as WarehouseListRef,
            id: id,
          ),
          from: warehouseListProvider,
          name: r'warehouseListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$warehouseListHash,
          dependencies: WarehouseListFamily._dependencies,
          allTransitiveDependencies:
              WarehouseListFamily._allTransitiveDependencies,
          id: id,
        );

  WarehouseListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  Override overrideWith(
    Stream<WarehouseListModel> Function(WarehouseListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WarehouseListProvider._internal(
        (ref) => create(ref as WarehouseListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<WarehouseListModel> createElement() {
    return _WarehouseListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WarehouseListProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WarehouseListRef on AutoDisposeStreamProviderRef<WarehouseListModel> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _WarehouseListProviderElement
    extends AutoDisposeStreamProviderElement<WarehouseListModel>
    with WarehouseListRef {
  _WarehouseListProviderElement(super.provider);

  @override
  String? get id => (origin as WarehouseListProvider).id;
}

String _$sbtTermsHash() => r'c0d7724c1d28bc13835fbedb052868e86b42c0be';

/// See also [sbtTerms].
@ProviderFor(sbtTerms)
const sbtTermsProvider = SbtTermsFamily();

/// See also [sbtTerms].
class SbtTermsFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [sbtTerms].
  const SbtTermsFamily();

  /// See also [sbtTerms].
  SbtTermsProvider call({
    String? userType,
    String? productId,
  }) {
    return SbtTermsProvider(
      userType: userType,
      productId: productId,
    );
  }

  @override
  SbtTermsProvider getProviderOverride(
    covariant SbtTermsProvider provider,
  ) {
    return call(
      userType: provider.userType,
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
  String? get name => r'sbtTermsProvider';
}

/// See also [sbtTerms].
class SbtTermsProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [sbtTerms].
  SbtTermsProvider({
    String? userType,
    String? productId,
  }) : this._internal(
          (ref) => sbtTerms(
            ref as SbtTermsRef,
            userType: userType,
            productId: productId,
          ),
          from: sbtTermsProvider,
          name: r'sbtTermsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sbtTermsHash,
          dependencies: SbtTermsFamily._dependencies,
          allTransitiveDependencies: SbtTermsFamily._allTransitiveDependencies,
          userType: userType,
          productId: productId,
        );

  SbtTermsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userType,
    required this.productId,
  }) : super.internal();

  final String? userType;
  final String? productId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(SbtTermsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SbtTermsProvider._internal(
        (ref) => create(ref as SbtTermsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userType: userType,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SbtTermsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SbtTermsProvider &&
        other.userType == userType &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SbtTermsRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `userType` of this provider.
  String? get userType;

  /// The parameter `productId` of this provider.
  String? get productId;
}

class _SbtTermsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SbtTermsRef {
  _SbtTermsProviderElement(super.provider);

  @override
  String? get userType => (origin as SbtTermsProvider).userType;
  @override
  String? get productId => (origin as SbtTermsProvider).productId;
}

String _$wbtTermsHash() => r'e6eed316c41f2b442099f4aa07891ff14e27544e';

/// See also [wbtTerms].
@ProviderFor(wbtTerms)
const wbtTermsProvider = WbtTermsFamily();

/// See also [wbtTerms].
class WbtTermsFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [wbtTerms].
  const WbtTermsFamily();

  /// See also [wbtTerms].
  WbtTermsProvider call({
    String? invId,
  }) {
    return WbtTermsProvider(
      invId: invId,
    );
  }

  @override
  WbtTermsProvider getProviderOverride(
    covariant WbtTermsProvider provider,
  ) {
    return call(
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
  String? get name => r'wbtTermsProvider';
}

/// See also [wbtTerms].
class WbtTermsProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [wbtTerms].
  WbtTermsProvider({
    String? invId,
  }) : this._internal(
          (ref) => wbtTerms(
            ref as WbtTermsRef,
            invId: invId,
          ),
          from: wbtTermsProvider,
          name: r'wbtTermsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$wbtTermsHash,
          dependencies: WbtTermsFamily._dependencies,
          allTransitiveDependencies: WbtTermsFamily._allTransitiveDependencies,
          invId: invId,
        );

  WbtTermsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.invId,
  }) : super.internal();

  final String? invId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(WbtTermsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WbtTermsProvider._internal(
        (ref) => create(ref as WbtTermsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        invId: invId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _WbtTermsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WbtTermsProvider && other.invId == invId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, invId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WbtTermsRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `invId` of this provider.
  String? get invId;
}

class _WbtTermsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with WbtTermsRef {
  _WbtTermsProviderElement(super.provider);

  @override
  String? get invId => (origin as WbtTermsProvider).invId;
}

String _$districtSbtDataHash() => r'66dfd2a04f847d597efe426a4cbaa22bc4b044a9';

/// See also [districtSbtData].
@ProviderFor(districtSbtData)
final districtSbtDataProvider =
    AutoDisposeFutureProvider<DistrictWiseSbtModel>.internal(
  districtSbtData,
  name: r'districtSbtDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$districtSbtDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DistrictSbtDataRef = AutoDisposeFutureProviderRef<DistrictWiseSbtModel>;
String _$commodityByDistictHash() =>
    r'88a97fa55a7ea07a35cce5a24726e4cb8569c2cd';

/// See also [commodityByDistict].
@ProviderFor(commodityByDistict)
const commodityByDistictProvider = CommodityByDistictFamily();

/// See also [commodityByDistict].
class CommodityByDistictFamily
    extends Family<AsyncValue<DistrictWiseCommodityModel>> {
  /// See also [commodityByDistict].
  const CommodityByDistictFamily();

  /// See also [commodityByDistict].
  CommodityByDistictProvider call({
    String? districtId,
  }) {
    return CommodityByDistictProvider(
      districtId: districtId,
    );
  }

  @override
  CommodityByDistictProvider getProviderOverride(
    covariant CommodityByDistictProvider provider,
  ) {
    return call(
      districtId: provider.districtId,
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
  String? get name => r'commodityByDistictProvider';
}

/// See also [commodityByDistict].
class CommodityByDistictProvider
    extends AutoDisposeFutureProvider<DistrictWiseCommodityModel> {
  /// See also [commodityByDistict].
  CommodityByDistictProvider({
    String? districtId,
  }) : this._internal(
          (ref) => commodityByDistict(
            ref as CommodityByDistictRef,
            districtId: districtId,
          ),
          from: commodityByDistictProvider,
          name: r'commodityByDistictProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commodityByDistictHash,
          dependencies: CommodityByDistictFamily._dependencies,
          allTransitiveDependencies:
              CommodityByDistictFamily._allTransitiveDependencies,
          districtId: districtId,
        );

  CommodityByDistictProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.districtId,
  }) : super.internal();

  final String? districtId;

  @override
  Override overrideWith(
    FutureOr<DistrictWiseCommodityModel> Function(
            CommodityByDistictRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CommodityByDistictProvider._internal(
        (ref) => create(ref as CommodityByDistictRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        districtId: districtId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DistrictWiseCommodityModel> createElement() {
    return _CommodityByDistictProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommodityByDistictProvider &&
        other.districtId == districtId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, districtId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CommodityByDistictRef
    on AutoDisposeFutureProviderRef<DistrictWiseCommodityModel> {
  /// The parameter `districtId` of this provider.
  String? get districtId;
}

class _CommodityByDistictProviderElement
    extends AutoDisposeFutureProviderElement<DistrictWiseCommodityModel>
    with CommodityByDistictRef {
  _CommodityByDistictProviderElement(super.provider);

  @override
  String? get districtId => (origin as CommodityByDistictProvider).districtId;
}

String _$deleteOrderHash() => r'2e9cc5ab29e9d881bb2486cdd07cdadfa4c76595';

/// See also [deleteOrder].
@ProviderFor(deleteOrder)
const deleteOrderProvider = DeleteOrderFamily();

/// See also [deleteOrder].
class DeleteOrderFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [deleteOrder].
  const DeleteOrderFamily();

  /// See also [deleteOrder].
  DeleteOrderProvider call({
    String? orderId,
  }) {
    return DeleteOrderProvider(
      orderId: orderId,
    );
  }

  @override
  DeleteOrderProvider getProviderOverride(
    covariant DeleteOrderProvider provider,
  ) {
    return call(
      orderId: provider.orderId,
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
  String? get name => r'deleteOrderProvider';
}

/// See also [deleteOrder].
class DeleteOrderProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [deleteOrder].
  DeleteOrderProvider({
    String? orderId,
  }) : this._internal(
          (ref) => deleteOrder(
            ref as DeleteOrderRef,
            orderId: orderId,
          ),
          from: deleteOrderProvider,
          name: r'deleteOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteOrderHash,
          dependencies: DeleteOrderFamily._dependencies,
          allTransitiveDependencies:
              DeleteOrderFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  DeleteOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String? orderId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(DeleteOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteOrderProvider._internal(
        (ref) => create(ref as DeleteOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _DeleteOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteOrderProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteOrderRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `orderId` of this provider.
  String? get orderId;
}

class _DeleteOrderProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with DeleteOrderRef {
  _DeleteOrderProviderElement(super.provider);

  @override
  String? get orderId => (origin as DeleteOrderProvider).orderId;
}

String _$checkForUserWalletHash() =>
    r'76f88a647669cfaa4e970b50463a23faa0ef7433';

/// See also [checkForUserWallet].
@ProviderFor(checkForUserWallet)
const checkForUserWalletProvider = CheckForUserWalletFamily();

/// See also [checkForUserWallet].
class CheckForUserWalletFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [checkForUserWallet].
  const CheckForUserWalletFamily();

  /// See also [checkForUserWallet].
  CheckForUserWalletProvider call({
    String? districtId,
    String? commodity,
    String? productId,
    String? qty,
    String? type,
    String? price,
    String? loanType,
  }) {
    return CheckForUserWalletProvider(
      districtId: districtId,
      commodity: commodity,
      productId: productId,
      qty: qty,
      type: type,
      price: price,
      loanType: loanType,
    );
  }

  @override
  CheckForUserWalletProvider getProviderOverride(
    covariant CheckForUserWalletProvider provider,
  ) {
    return call(
      districtId: provider.districtId,
      commodity: provider.commodity,
      productId: provider.productId,
      qty: provider.qty,
      type: provider.type,
      price: provider.price,
      loanType: provider.loanType,
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
  String? get name => r'checkForUserWalletProvider';
}

/// See also [checkForUserWallet].
class CheckForUserWalletProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [checkForUserWallet].
  CheckForUserWalletProvider({
    String? districtId,
    String? commodity,
    String? productId,
    String? qty,
    String? type,
    String? price,
    String? loanType,
  }) : this._internal(
          (ref) => checkForUserWallet(
            ref as CheckForUserWalletRef,
            districtId: districtId,
            commodity: commodity,
            productId: productId,
            qty: qty,
            type: type,
            price: price,
            loanType: loanType,
          ),
          from: checkForUserWalletProvider,
          name: r'checkForUserWalletProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkForUserWalletHash,
          dependencies: CheckForUserWalletFamily._dependencies,
          allTransitiveDependencies:
              CheckForUserWalletFamily._allTransitiveDependencies,
          districtId: districtId,
          commodity: commodity,
          productId: productId,
          qty: qty,
          type: type,
          price: price,
          loanType: loanType,
        );

  CheckForUserWalletProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.districtId,
    required this.commodity,
    required this.productId,
    required this.qty,
    required this.type,
    required this.price,
    required this.loanType,
  }) : super.internal();

  final String? districtId;
  final String? commodity;
  final String? productId;
  final String? qty;
  final String? type;
  final String? price;
  final String? loanType;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(CheckForUserWalletRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckForUserWalletProvider._internal(
        (ref) => create(ref as CheckForUserWalletRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        districtId: districtId,
        commodity: commodity,
        productId: productId,
        qty: qty,
        type: type,
        price: price,
        loanType: loanType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _CheckForUserWalletProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckForUserWalletProvider &&
        other.districtId == districtId &&
        other.commodity == commodity &&
        other.productId == productId &&
        other.qty == qty &&
        other.type == type &&
        other.price == price &&
        other.loanType == loanType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, districtId.hashCode);
    hash = _SystemHash.combine(hash, commodity.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, qty.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);
    hash = _SystemHash.combine(hash, loanType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckForUserWalletRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `districtId` of this provider.
  String? get districtId;

  /// The parameter `commodity` of this provider.
  String? get commodity;

  /// The parameter `productId` of this provider.
  String? get productId;

  /// The parameter `qty` of this provider.
  String? get qty;

  /// The parameter `type` of this provider.
  String? get type;

  /// The parameter `price` of this provider.
  String? get price;

  /// The parameter `loanType` of this provider.
  String? get loanType;
}

class _CheckForUserWalletProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with CheckForUserWalletRef {
  _CheckForUserWalletProviderElement(super.provider);

  @override
  String? get districtId => (origin as CheckForUserWalletProvider).districtId;
  @override
  String? get commodity => (origin as CheckForUserWalletProvider).commodity;
  @override
  String? get productId => (origin as CheckForUserWalletProvider).productId;
  @override
  String? get qty => (origin as CheckForUserWalletProvider).qty;
  @override
  String? get type => (origin as CheckForUserWalletProvider).type;
  @override
  String? get price => (origin as CheckForUserWalletProvider).price;
  @override
  String? get loanType => (origin as CheckForUserWalletProvider).loanType;
}

String _$bookingQualityParametersHash() =>
    r'0109e4f6a195ce363165c014e8082b9aebebf024';

/// See also [bookingQualityParameters].
@ProviderFor(bookingQualityParameters)
const bookingQualityParametersProvider = BookingQualityParametersFamily();

/// See also [bookingQualityParameters].
class BookingQualityParametersFamily
    extends Family<AsyncValue<BookingQualityModel>> {
  /// See also [bookingQualityParameters].
  const BookingQualityParametersFamily();

  /// See also [bookingQualityParameters].
  BookingQualityParametersProvider call({
    String? caseId,
  }) {
    return BookingQualityParametersProvider(
      caseId: caseId,
    );
  }

  @override
  BookingQualityParametersProvider getProviderOverride(
    covariant BookingQualityParametersProvider provider,
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
  String? get name => r'bookingQualityParametersProvider';
}

/// See also [bookingQualityParameters].
class BookingQualityParametersProvider
    extends AutoDisposeStreamProvider<BookingQualityModel> {
  /// See also [bookingQualityParameters].
  BookingQualityParametersProvider({
    String? caseId,
  }) : this._internal(
          (ref) => bookingQualityParameters(
            ref as BookingQualityParametersRef,
            caseId: caseId,
          ),
          from: bookingQualityParametersProvider,
          name: r'bookingQualityParametersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookingQualityParametersHash,
          dependencies: BookingQualityParametersFamily._dependencies,
          allTransitiveDependencies:
              BookingQualityParametersFamily._allTransitiveDependencies,
          caseId: caseId,
        );

  BookingQualityParametersProvider._internal(
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
    Stream<BookingQualityModel> Function(BookingQualityParametersRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BookingQualityParametersProvider._internal(
        (ref) => create(ref as BookingQualityParametersRef),
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
  AutoDisposeStreamProviderElement<BookingQualityModel> createElement() {
    return _BookingQualityParametersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookingQualityParametersProvider && other.caseId == caseId;
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
mixin BookingQualityParametersRef
    on AutoDisposeStreamProviderRef<BookingQualityModel> {
  /// The parameter `caseId` of this provider.
  String? get caseId;
}

class _BookingQualityParametersProviderElement
    extends AutoDisposeStreamProviderElement<BookingQualityModel>
    with BookingQualityParametersRef {
  _BookingQualityParametersProviderElement(super.provider);

  @override
  String? get caseId => (origin as BookingQualityParametersProvider).caseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
