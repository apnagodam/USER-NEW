// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SbtService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sbtRequestHash() => r'7c90a6c4843cabf881b36e91b880cdb77999a977';

/// See also [sbtRequest].
@ProviderFor(sbtRequest)
final sbtRequestProvider =
    AutoDisposeStreamProvider<SbtRequestListModel>.internal(
  sbtRequest,
  name: r'sbtRequestProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sbtRequestHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SbtRequestRef = AutoDisposeStreamProviderRef<SbtRequestListModel>;
String _$sbtHoldListHash() => r'bac6090dcbd783e66064abf1eab2e2575f42dbdd';

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

/// See also [sbtHoldList].
@ProviderFor(sbtHoldList)
const sbtHoldListProvider = SbtHoldListFamily();

/// See also [sbtHoldList].
class SbtHoldListFamily extends Family<AsyncValue<SbtHoldListModel>> {
  /// See also [sbtHoldList].
  const SbtHoldListFamily();

  /// See also [sbtHoldList].
  SbtHoldListProvider call({
    String? walletType,
  }) {
    return SbtHoldListProvider(
      walletType: walletType,
    );
  }

  @override
  SbtHoldListProvider getProviderOverride(
    covariant SbtHoldListProvider provider,
  ) {
    return call(
      walletType: provider.walletType,
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
  String? get name => r'sbtHoldListProvider';
}

/// See also [sbtHoldList].
class SbtHoldListProvider extends AutoDisposeStreamProvider<SbtHoldListModel> {
  /// See also [sbtHoldList].
  SbtHoldListProvider({
    String? walletType,
  }) : this._internal(
          (ref) => sbtHoldList(
            ref as SbtHoldListRef,
            walletType: walletType,
          ),
          from: sbtHoldListProvider,
          name: r'sbtHoldListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sbtHoldListHash,
          dependencies: SbtHoldListFamily._dependencies,
          allTransitiveDependencies:
              SbtHoldListFamily._allTransitiveDependencies,
          walletType: walletType,
        );

  SbtHoldListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.walletType,
  }) : super.internal();

  final String? walletType;

  @override
  Override overrideWith(
    Stream<SbtHoldListModel> Function(SbtHoldListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SbtHoldListProvider._internal(
        (ref) => create(ref as SbtHoldListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        walletType: walletType,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SbtHoldListModel> createElement() {
    return _SbtHoldListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SbtHoldListProvider && other.walletType == walletType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, walletType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SbtHoldListRef on AutoDisposeStreamProviderRef<SbtHoldListModel> {
  /// The parameter `walletType` of this provider.
  String? get walletType;
}

class _SbtHoldListProviderElement
    extends AutoDisposeStreamProviderElement<SbtHoldListModel>
    with SbtHoldListRef {
  _SbtHoldListProviderElement(super.provider);

  @override
  String? get walletType => (origin as SbtHoldListProvider).walletType;
}

String _$sbtContactNoteHash() => r'4b1d891e9c28dc1aaeceee6d9b4ec91267940a09';

/// See also [sbtContactNote].
@ProviderFor(sbtContactNote)
final sbtContactNoteProvider =
    AutoDisposeStreamProvider<SbtContractNoteModel>.internal(
  sbtContactNote,
  name: r'sbtContactNoteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sbtContactNoteHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SbtContactNoteRef = AutoDisposeStreamProviderRef<SbtContractNoteModel>;
String _$matchedOrdersHash() => r'a4372847761fcdf9b197c6de92cf24d9af9c872d';

/// See also [matchedOrders].
@ProviderFor(matchedOrders)
final matchedOrdersProvider =
    AutoDisposeStreamProvider<MatchedOrdersModel>.internal(
  matchedOrders,
  name: r'matchedOrdersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$matchedOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MatchedOrdersRef = AutoDisposeStreamProviderRef<MatchedOrdersModel>;
String _$getMatchOrderPrintDataHash() =>
    r'12d14a5351dbe8085e48aec9b7f6223ad96d8400';

/// See also [getMatchOrderPrintData].
@ProviderFor(getMatchOrderPrintData)
const getMatchOrderPrintDataProvider = GetMatchOrderPrintDataFamily();

/// See also [getMatchOrderPrintData].
class GetMatchOrderPrintDataFamily
    extends Family<AsyncValue<MatchOrderPrintModel>> {
  /// See also [getMatchOrderPrintData].
  const GetMatchOrderPrintDataFamily();

  /// See also [getMatchOrderPrintData].
  GetMatchOrderPrintDataProvider call({
    required String orderId,
  }) {
    return GetMatchOrderPrintDataProvider(
      orderId: orderId,
    );
  }

  @override
  GetMatchOrderPrintDataProvider getProviderOverride(
    covariant GetMatchOrderPrintDataProvider provider,
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
  String? get name => r'getMatchOrderPrintDataProvider';
}

/// See also [getMatchOrderPrintData].
class GetMatchOrderPrintDataProvider
    extends AutoDisposeFutureProvider<MatchOrderPrintModel> {
  /// See also [getMatchOrderPrintData].
  GetMatchOrderPrintDataProvider({
    required String orderId,
  }) : this._internal(
          (ref) => getMatchOrderPrintData(
            ref as GetMatchOrderPrintDataRef,
            orderId: orderId,
          ),
          from: getMatchOrderPrintDataProvider,
          name: r'getMatchOrderPrintDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMatchOrderPrintDataHash,
          dependencies: GetMatchOrderPrintDataFamily._dependencies,
          allTransitiveDependencies:
              GetMatchOrderPrintDataFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  GetMatchOrderPrintDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<MatchOrderPrintModel> Function(GetMatchOrderPrintDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMatchOrderPrintDataProvider._internal(
        (ref) => create(ref as GetMatchOrderPrintDataRef),
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
  AutoDisposeFutureProviderElement<MatchOrderPrintModel> createElement() {
    return _GetMatchOrderPrintDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMatchOrderPrintDataProvider && other.orderId == orderId;
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
mixin GetMatchOrderPrintDataRef
    on AutoDisposeFutureProviderRef<MatchOrderPrintModel> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _GetMatchOrderPrintDataProviderElement
    extends AutoDisposeFutureProviderElement<MatchOrderPrintModel>
    with GetMatchOrderPrintDataRef {
  _GetMatchOrderPrintDataProviderElement(super.provider);

  @override
  String get orderId => (origin as GetMatchOrderPrintDataProvider).orderId;
}

String _$orderInventoriesHash() => r'a682ed38af92775ff04a6cfbba157dfac0a7d46d';

/// See also [orderInventories].
@ProviderFor(orderInventories)
const orderInventoriesProvider = OrderInventoriesFamily();

/// See also [orderInventories].
class OrderInventoriesFamily extends Family<AsyncValue<OrderInventoryModel>> {
  /// See also [orderInventories].
  const OrderInventoriesFamily();

  /// See also [orderInventories].
  OrderInventoriesProvider call({
    String? id,
    String? warehouseId,
    String? stackNo,
  }) {
    return OrderInventoriesProvider(
      id: id,
      warehouseId: warehouseId,
      stackNo: stackNo,
    );
  }

  @override
  OrderInventoriesProvider getProviderOverride(
    covariant OrderInventoriesProvider provider,
  ) {
    return call(
      id: provider.id,
      warehouseId: provider.warehouseId,
      stackNo: provider.stackNo,
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
  String? get name => r'orderInventoriesProvider';
}

/// See also [orderInventories].
class OrderInventoriesProvider
    extends AutoDisposeStreamProvider<OrderInventoryModel> {
  /// See also [orderInventories].
  OrderInventoriesProvider({
    String? id,
    String? warehouseId,
    String? stackNo,
  }) : this._internal(
          (ref) => orderInventories(
            ref as OrderInventoriesRef,
            id: id,
            warehouseId: warehouseId,
            stackNo: stackNo,
          ),
          from: orderInventoriesProvider,
          name: r'orderInventoriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderInventoriesHash,
          dependencies: OrderInventoriesFamily._dependencies,
          allTransitiveDependencies:
              OrderInventoriesFamily._allTransitiveDependencies,
          id: id,
          warehouseId: warehouseId,
          stackNo: stackNo,
        );

  OrderInventoriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.warehouseId,
    required this.stackNo,
  }) : super.internal();

  final String? id;
  final String? warehouseId;
  final String? stackNo;

  @override
  Override overrideWith(
    Stream<OrderInventoryModel> Function(OrderInventoriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrderInventoriesProvider._internal(
        (ref) => create(ref as OrderInventoriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        warehouseId: warehouseId,
        stackNo: stackNo,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<OrderInventoryModel> createElement() {
    return _OrderInventoriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderInventoriesProvider &&
        other.id == id &&
        other.warehouseId == warehouseId &&
        other.stackNo == stackNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, warehouseId.hashCode);
    hash = _SystemHash.combine(hash, stackNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderInventoriesRef on AutoDisposeStreamProviderRef<OrderInventoryModel> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `warehouseId` of this provider.
  String? get warehouseId;

  /// The parameter `stackNo` of this provider.
  String? get stackNo;
}

class _OrderInventoriesProviderElement
    extends AutoDisposeStreamProviderElement<OrderInventoryModel>
    with OrderInventoriesRef {
  _OrderInventoriesProviderElement(super.provider);

  @override
  String? get id => (origin as OrderInventoriesProvider).id;
  @override
  String? get warehouseId => (origin as OrderInventoriesProvider).warehouseId;
  @override
  String? get stackNo => (origin as OrderInventoriesProvider).stackNo;
}

String _$markDeliveryHash() => r'6cf7935240aa4893954c00ae9339c2e4ea5bdea1';

/// See also [markDelivery].
@ProviderFor(markDelivery)
const markDeliveryProvider = MarkDeliveryFamily();

/// See also [markDelivery].
class MarkDeliveryFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [markDelivery].
  const MarkDeliveryFamily();

  /// See also [markDelivery].
  MarkDeliveryProvider call({
    required MarkDeliveryRequestModel model,
  }) {
    return MarkDeliveryProvider(
      model: model,
    );
  }

  @override
  MarkDeliveryProvider getProviderOverride(
    covariant MarkDeliveryProvider provider,
  ) {
    return call(
      model: provider.model,
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
  String? get name => r'markDeliveryProvider';
}

/// See also [markDelivery].
class MarkDeliveryProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [markDelivery].
  MarkDeliveryProvider({
    required MarkDeliveryRequestModel model,
  }) : this._internal(
          (ref) => markDelivery(
            ref as MarkDeliveryRef,
            model: model,
          ),
          from: markDeliveryProvider,
          name: r'markDeliveryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$markDeliveryHash,
          dependencies: MarkDeliveryFamily._dependencies,
          allTransitiveDependencies:
              MarkDeliveryFamily._allTransitiveDependencies,
          model: model,
        );

  MarkDeliveryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.model,
  }) : super.internal();

  final MarkDeliveryRequestModel model;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(MarkDeliveryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MarkDeliveryProvider._internal(
        (ref) => create(ref as MarkDeliveryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        model: model,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _MarkDeliveryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MarkDeliveryProvider && other.model == model;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MarkDeliveryRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `model` of this provider.
  MarkDeliveryRequestModel get model;
}

class _MarkDeliveryProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with MarkDeliveryRef {
  _MarkDeliveryProviderElement(super.provider);

  @override
  MarkDeliveryRequestModel get model => (origin as MarkDeliveryProvider).model;
}

String _$sbtTerminalsListHash() => r'8bda03c7e3ed471b3435a447500dbdd19a276bb7';

/// See also [sbtTerminalsList].
@ProviderFor(sbtTerminalsList)
const sbtTerminalsListProvider = SbtTerminalsListFamily();

/// See also [sbtTerminalsList].
class SbtTerminalsListFamily extends Family<AsyncValue<SbtTerminalsListModel>> {
  /// See also [sbtTerminalsList].
  const SbtTerminalsListFamily();

  /// See also [sbtTerminalsList].
  SbtTerminalsListProvider call({
    required String districtId,
  }) {
    return SbtTerminalsListProvider(
      districtId: districtId,
    );
  }

  @override
  SbtTerminalsListProvider getProviderOverride(
    covariant SbtTerminalsListProvider provider,
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
  String? get name => r'sbtTerminalsListProvider';
}

/// See also [sbtTerminalsList].
class SbtTerminalsListProvider
    extends AutoDisposeStreamProvider<SbtTerminalsListModel> {
  /// See also [sbtTerminalsList].
  SbtTerminalsListProvider({
    required String districtId,
  }) : this._internal(
          (ref) => sbtTerminalsList(
            ref as SbtTerminalsListRef,
            districtId: districtId,
          ),
          from: sbtTerminalsListProvider,
          name: r'sbtTerminalsListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sbtTerminalsListHash,
          dependencies: SbtTerminalsListFamily._dependencies,
          allTransitiveDependencies:
              SbtTerminalsListFamily._allTransitiveDependencies,
          districtId: districtId,
        );

  SbtTerminalsListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.districtId,
  }) : super.internal();

  final String districtId;

  @override
  Override overrideWith(
    Stream<SbtTerminalsListModel> Function(SbtTerminalsListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SbtTerminalsListProvider._internal(
        (ref) => create(ref as SbtTerminalsListRef),
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
  AutoDisposeStreamProviderElement<SbtTerminalsListModel> createElement() {
    return _SbtTerminalsListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SbtTerminalsListProvider && other.districtId == districtId;
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
mixin SbtTerminalsListRef
    on AutoDisposeStreamProviderRef<SbtTerminalsListModel> {
  /// The parameter `districtId` of this provider.
  String get districtId;
}

class _SbtTerminalsListProviderElement
    extends AutoDisposeStreamProviderElement<SbtTerminalsListModel>
    with SbtTerminalsListRef {
  _SbtTerminalsListProviderElement(super.provider);

  @override
  String get districtId => (origin as SbtTerminalsListProvider).districtId;
}

String _$sbtStackListHash() => r'1e02515a49ac6c3bd89d6f6753c234938f7be9ec';

/// See also [sbtStackList].
@ProviderFor(sbtStackList)
const sbtStackListProvider = SbtStackListFamily();

/// See also [sbtStackList].
class SbtStackListFamily extends Family<AsyncValue<SbtStacksListModel>> {
  /// See also [sbtStackList].
  const SbtStackListFamily();

  /// See also [sbtStackList].
  SbtStackListProvider call({
    required String warehouseId,
    required String commodityId,
  }) {
    return SbtStackListProvider(
      warehouseId: warehouseId,
      commodityId: commodityId,
    );
  }

  @override
  SbtStackListProvider getProviderOverride(
    covariant SbtStackListProvider provider,
  ) {
    return call(
      warehouseId: provider.warehouseId,
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
  String? get name => r'sbtStackListProvider';
}

/// See also [sbtStackList].
class SbtStackListProvider
    extends AutoDisposeStreamProvider<SbtStacksListModel> {
  /// See also [sbtStackList].
  SbtStackListProvider({
    required String warehouseId,
    required String commodityId,
  }) : this._internal(
          (ref) => sbtStackList(
            ref as SbtStackListRef,
            warehouseId: warehouseId,
            commodityId: commodityId,
          ),
          from: sbtStackListProvider,
          name: r'sbtStackListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sbtStackListHash,
          dependencies: SbtStackListFamily._dependencies,
          allTransitiveDependencies:
              SbtStackListFamily._allTransitiveDependencies,
          warehouseId: warehouseId,
          commodityId: commodityId,
        );

  SbtStackListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.warehouseId,
    required this.commodityId,
  }) : super.internal();

  final String warehouseId;
  final String commodityId;

  @override
  Override overrideWith(
    Stream<SbtStacksListModel> Function(SbtStackListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SbtStackListProvider._internal(
        (ref) => create(ref as SbtStackListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        warehouseId: warehouseId,
        commodityId: commodityId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SbtStacksListModel> createElement() {
    return _SbtStackListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SbtStackListProvider &&
        other.warehouseId == warehouseId &&
        other.commodityId == commodityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, warehouseId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SbtStackListRef on AutoDisposeStreamProviderRef<SbtStacksListModel> {
  /// The parameter `warehouseId` of this provider.
  String get warehouseId;

  /// The parameter `commodityId` of this provider.
  String get commodityId;
}

class _SbtStackListProviderElement
    extends AutoDisposeStreamProviderElement<SbtStacksListModel>
    with SbtStackListRef {
  _SbtStackListProviderElement(super.provider);

  @override
  String get warehouseId => (origin as SbtStackListProvider).warehouseId;
  @override
  String get commodityId => (origin as SbtStackListProvider).commodityId;
}

String _$dispatchRequestNewHash() =>
    r'5ad6cc44997cad9cbdf9cdbf5af51f38b932cb4b';

/// See also [dispatchRequestNew].
@ProviderFor(dispatchRequestNew)
const dispatchRequestNewProvider = DispatchRequestNewFamily();

/// See also [dispatchRequestNew].
class DispatchRequestNewFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [dispatchRequestNew].
  const DispatchRequestNewFamily();

  /// See also [dispatchRequestNew].
  DispatchRequestNewProvider call({
    String? states,
    String? district,
    String? location,
    String? pinCode,
    String? address,
    String? biltyNumber,
    String? sbtOrderId,
    String? mandiComplience,
    String? vehicleNo,
    String? salesStatus,
    String? stackNo,
    String? driverNo,
    String? transporterType,
    String? vehicleType,
    String? tripId,
    File? image,
  }) {
    return DispatchRequestNewProvider(
      states: states,
      district: district,
      location: location,
      pinCode: pinCode,
      address: address,
      biltyNumber: biltyNumber,
      sbtOrderId: sbtOrderId,
      mandiComplience: mandiComplience,
      vehicleNo: vehicleNo,
      salesStatus: salesStatus,
      stackNo: stackNo,
      driverNo: driverNo,
      transporterType: transporterType,
      vehicleType: vehicleType,
      tripId: tripId,
      image: image,
    );
  }

  @override
  DispatchRequestNewProvider getProviderOverride(
    covariant DispatchRequestNewProvider provider,
  ) {
    return call(
      states: provider.states,
      district: provider.district,
      location: provider.location,
      pinCode: provider.pinCode,
      address: provider.address,
      biltyNumber: provider.biltyNumber,
      sbtOrderId: provider.sbtOrderId,
      mandiComplience: provider.mandiComplience,
      vehicleNo: provider.vehicleNo,
      salesStatus: provider.salesStatus,
      stackNo: provider.stackNo,
      driverNo: provider.driverNo,
      transporterType: provider.transporterType,
      vehicleType: provider.vehicleType,
      tripId: provider.tripId,
      image: provider.image,
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
  String? get name => r'dispatchRequestNewProvider';
}

/// See also [dispatchRequestNew].
class DispatchRequestNewProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [dispatchRequestNew].
  DispatchRequestNewProvider({
    String? states,
    String? district,
    String? location,
    String? pinCode,
    String? address,
    String? biltyNumber,
    String? sbtOrderId,
    String? mandiComplience,
    String? vehicleNo,
    String? salesStatus,
    String? stackNo,
    String? driverNo,
    String? transporterType,
    String? vehicleType,
    String? tripId,
    File? image,
  }) : this._internal(
          (ref) => dispatchRequestNew(
            ref as DispatchRequestNewRef,
            states: states,
            district: district,
            location: location,
            pinCode: pinCode,
            address: address,
            biltyNumber: biltyNumber,
            sbtOrderId: sbtOrderId,
            mandiComplience: mandiComplience,
            vehicleNo: vehicleNo,
            salesStatus: salesStatus,
            stackNo: stackNo,
            driverNo: driverNo,
            transporterType: transporterType,
            vehicleType: vehicleType,
            tripId: tripId,
            image: image,
          ),
          from: dispatchRequestNewProvider,
          name: r'dispatchRequestNewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dispatchRequestNewHash,
          dependencies: DispatchRequestNewFamily._dependencies,
          allTransitiveDependencies:
              DispatchRequestNewFamily._allTransitiveDependencies,
          states: states,
          district: district,
          location: location,
          pinCode: pinCode,
          address: address,
          biltyNumber: biltyNumber,
          sbtOrderId: sbtOrderId,
          mandiComplience: mandiComplience,
          vehicleNo: vehicleNo,
          salesStatus: salesStatus,
          stackNo: stackNo,
          driverNo: driverNo,
          transporterType: transporterType,
          vehicleType: vehicleType,
          tripId: tripId,
          image: image,
        );

  DispatchRequestNewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.states,
    required this.district,
    required this.location,
    required this.pinCode,
    required this.address,
    required this.biltyNumber,
    required this.sbtOrderId,
    required this.mandiComplience,
    required this.vehicleNo,
    required this.salesStatus,
    required this.stackNo,
    required this.driverNo,
    required this.transporterType,
    required this.vehicleType,
    required this.tripId,
    required this.image,
  }) : super.internal();

  final String? states;
  final String? district;
  final String? location;
  final String? pinCode;
  final String? address;
  final String? biltyNumber;
  final String? sbtOrderId;
  final String? mandiComplience;
  final String? vehicleNo;
  final String? salesStatus;
  final String? stackNo;
  final String? driverNo;
  final String? transporterType;
  final String? vehicleType;
  final String? tripId;
  final File? image;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(DispatchRequestNewRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DispatchRequestNewProvider._internal(
        (ref) => create(ref as DispatchRequestNewRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        states: states,
        district: district,
        location: location,
        pinCode: pinCode,
        address: address,
        biltyNumber: biltyNumber,
        sbtOrderId: sbtOrderId,
        mandiComplience: mandiComplience,
        vehicleNo: vehicleNo,
        salesStatus: salesStatus,
        stackNo: stackNo,
        driverNo: driverNo,
        transporterType: transporterType,
        vehicleType: vehicleType,
        tripId: tripId,
        image: image,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _DispatchRequestNewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DispatchRequestNewProvider &&
        other.states == states &&
        other.district == district &&
        other.location == location &&
        other.pinCode == pinCode &&
        other.address == address &&
        other.biltyNumber == biltyNumber &&
        other.sbtOrderId == sbtOrderId &&
        other.mandiComplience == mandiComplience &&
        other.vehicleNo == vehicleNo &&
        other.salesStatus == salesStatus &&
        other.stackNo == stackNo &&
        other.driverNo == driverNo &&
        other.transporterType == transporterType &&
        other.vehicleType == vehicleType &&
        other.tripId == tripId &&
        other.image == image;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, states.hashCode);
    hash = _SystemHash.combine(hash, district.hashCode);
    hash = _SystemHash.combine(hash, location.hashCode);
    hash = _SystemHash.combine(hash, pinCode.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, biltyNumber.hashCode);
    hash = _SystemHash.combine(hash, sbtOrderId.hashCode);
    hash = _SystemHash.combine(hash, mandiComplience.hashCode);
    hash = _SystemHash.combine(hash, vehicleNo.hashCode);
    hash = _SystemHash.combine(hash, salesStatus.hashCode);
    hash = _SystemHash.combine(hash, stackNo.hashCode);
    hash = _SystemHash.combine(hash, driverNo.hashCode);
    hash = _SystemHash.combine(hash, transporterType.hashCode);
    hash = _SystemHash.combine(hash, vehicleType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);
    hash = _SystemHash.combine(hash, image.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DispatchRequestNewRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `states` of this provider.
  String? get states;

  /// The parameter `district` of this provider.
  String? get district;

  /// The parameter `location` of this provider.
  String? get location;

  /// The parameter `pinCode` of this provider.
  String? get pinCode;

  /// The parameter `address` of this provider.
  String? get address;

  /// The parameter `biltyNumber` of this provider.
  String? get biltyNumber;

  /// The parameter `sbtOrderId` of this provider.
  String? get sbtOrderId;

  /// The parameter `mandiComplience` of this provider.
  String? get mandiComplience;

  /// The parameter `vehicleNo` of this provider.
  String? get vehicleNo;

  /// The parameter `salesStatus` of this provider.
  String? get salesStatus;

  /// The parameter `stackNo` of this provider.
  String? get stackNo;

  /// The parameter `driverNo` of this provider.
  String? get driverNo;

  /// The parameter `transporterType` of this provider.
  String? get transporterType;

  /// The parameter `vehicleType` of this provider.
  String? get vehicleType;

  /// The parameter `tripId` of this provider.
  String? get tripId;

  /// The parameter `image` of this provider.
  File? get image;
}

class _DispatchRequestNewProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with DispatchRequestNewRef {
  _DispatchRequestNewProviderElement(super.provider);

  @override
  String? get states => (origin as DispatchRequestNewProvider).states;
  @override
  String? get district => (origin as DispatchRequestNewProvider).district;
  @override
  String? get location => (origin as DispatchRequestNewProvider).location;
  @override
  String? get pinCode => (origin as DispatchRequestNewProvider).pinCode;
  @override
  String? get address => (origin as DispatchRequestNewProvider).address;
  @override
  String? get biltyNumber => (origin as DispatchRequestNewProvider).biltyNumber;
  @override
  String? get sbtOrderId => (origin as DispatchRequestNewProvider).sbtOrderId;
  @override
  String? get mandiComplience =>
      (origin as DispatchRequestNewProvider).mandiComplience;
  @override
  String? get vehicleNo => (origin as DispatchRequestNewProvider).vehicleNo;
  @override
  String? get salesStatus => (origin as DispatchRequestNewProvider).salesStatus;
  @override
  String? get stackNo => (origin as DispatchRequestNewProvider).stackNo;
  @override
  String? get driverNo => (origin as DispatchRequestNewProvider).driverNo;
  @override
  String? get transporterType =>
      (origin as DispatchRequestNewProvider).transporterType;
  @override
  String? get vehicleType => (origin as DispatchRequestNewProvider).vehicleType;
  @override
  String? get tripId => (origin as DispatchRequestNewProvider).tripId;
  @override
  File? get image => (origin as DispatchRequestNewProvider).image;
}

String _$dispatchRequestHash() => r'8329fc63232898f094c4255736da22d9b1bd6b36';

/// See also [dispatchRequest].
@ProviderFor(dispatchRequest)
const dispatchRequestProvider = DispatchRequestFamily();

/// See also [dispatchRequest].
class DispatchRequestFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [dispatchRequest].
  const DispatchRequestFamily();

  /// See also [dispatchRequest].
  DispatchRequestProvider call({
    dynamic sbtOrderId,
    dynamic weight,
    dynamic vehicleNo,
    dynamic vehicleType,
    dynamic salesStatus,
    dynamic commodityId,
    dynamic terminalId,
    dynamic stackNo,
    dynamic driverNo,
    dynamic transporterType,
    dynamic tripId,
    File? biltyImage,
    File? kantaParchiImage,
    File? image,
    File? invoiceImage,
  }) {
    return DispatchRequestProvider(
      sbtOrderId: sbtOrderId,
      weight: weight,
      vehicleNo: vehicleNo,
      vehicleType: vehicleType,
      salesStatus: salesStatus,
      commodityId: commodityId,
      terminalId: terminalId,
      stackNo: stackNo,
      driverNo: driverNo,
      transporterType: transporterType,
      tripId: tripId,
      biltyImage: biltyImage,
      kantaParchiImage: kantaParchiImage,
      image: image,
      invoiceImage: invoiceImage,
    );
  }

  @override
  DispatchRequestProvider getProviderOverride(
    covariant DispatchRequestProvider provider,
  ) {
    return call(
      sbtOrderId: provider.sbtOrderId,
      weight: provider.weight,
      vehicleNo: provider.vehicleNo,
      vehicleType: provider.vehicleType,
      salesStatus: provider.salesStatus,
      commodityId: provider.commodityId,
      terminalId: provider.terminalId,
      stackNo: provider.stackNo,
      driverNo: provider.driverNo,
      transporterType: provider.transporterType,
      tripId: provider.tripId,
      biltyImage: provider.biltyImage,
      kantaParchiImage: provider.kantaParchiImage,
      image: provider.image,
      invoiceImage: provider.invoiceImage,
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
  String? get name => r'dispatchRequestProvider';
}

/// See also [dispatchRequest].
class DispatchRequestProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [dispatchRequest].
  DispatchRequestProvider({
    dynamic sbtOrderId,
    dynamic weight,
    dynamic vehicleNo,
    dynamic vehicleType,
    dynamic salesStatus,
    dynamic commodityId,
    dynamic terminalId,
    dynamic stackNo,
    dynamic driverNo,
    dynamic transporterType,
    dynamic tripId,
    File? biltyImage,
    File? kantaParchiImage,
    File? image,
    File? invoiceImage,
  }) : this._internal(
          (ref) => dispatchRequest(
            ref as DispatchRequestRef,
            sbtOrderId: sbtOrderId,
            weight: weight,
            vehicleNo: vehicleNo,
            vehicleType: vehicleType,
            salesStatus: salesStatus,
            commodityId: commodityId,
            terminalId: terminalId,
            stackNo: stackNo,
            driverNo: driverNo,
            transporterType: transporterType,
            tripId: tripId,
            biltyImage: biltyImage,
            kantaParchiImage: kantaParchiImage,
            image: image,
            invoiceImage: invoiceImage,
          ),
          from: dispatchRequestProvider,
          name: r'dispatchRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dispatchRequestHash,
          dependencies: DispatchRequestFamily._dependencies,
          allTransitiveDependencies:
              DispatchRequestFamily._allTransitiveDependencies,
          sbtOrderId: sbtOrderId,
          weight: weight,
          vehicleNo: vehicleNo,
          vehicleType: vehicleType,
          salesStatus: salesStatus,
          commodityId: commodityId,
          terminalId: terminalId,
          stackNo: stackNo,
          driverNo: driverNo,
          transporterType: transporterType,
          tripId: tripId,
          biltyImage: biltyImage,
          kantaParchiImage: kantaParchiImage,
          image: image,
          invoiceImage: invoiceImage,
        );

  DispatchRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sbtOrderId,
    required this.weight,
    required this.vehicleNo,
    required this.vehicleType,
    required this.salesStatus,
    required this.commodityId,
    required this.terminalId,
    required this.stackNo,
    required this.driverNo,
    required this.transporterType,
    required this.tripId,
    required this.biltyImage,
    required this.kantaParchiImage,
    required this.image,
    required this.invoiceImage,
  }) : super.internal();

  final dynamic sbtOrderId;
  final dynamic weight;
  final dynamic vehicleNo;
  final dynamic vehicleType;
  final dynamic salesStatus;
  final dynamic commodityId;
  final dynamic terminalId;
  final dynamic stackNo;
  final dynamic driverNo;
  final dynamic transporterType;
  final dynamic tripId;
  final File? biltyImage;
  final File? kantaParchiImage;
  final File? image;
  final File? invoiceImage;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(DispatchRequestRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DispatchRequestProvider._internal(
        (ref) => create(ref as DispatchRequestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sbtOrderId: sbtOrderId,
        weight: weight,
        vehicleNo: vehicleNo,
        vehicleType: vehicleType,
        salesStatus: salesStatus,
        commodityId: commodityId,
        terminalId: terminalId,
        stackNo: stackNo,
        driverNo: driverNo,
        transporterType: transporterType,
        tripId: tripId,
        biltyImage: biltyImage,
        kantaParchiImage: kantaParchiImage,
        image: image,
        invoiceImage: invoiceImage,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _DispatchRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DispatchRequestProvider &&
        other.sbtOrderId == sbtOrderId &&
        other.weight == weight &&
        other.vehicleNo == vehicleNo &&
        other.vehicleType == vehicleType &&
        other.salesStatus == salesStatus &&
        other.commodityId == commodityId &&
        other.terminalId == terminalId &&
        other.stackNo == stackNo &&
        other.driverNo == driverNo &&
        other.transporterType == transporterType &&
        other.tripId == tripId &&
        other.biltyImage == biltyImage &&
        other.kantaParchiImage == kantaParchiImage &&
        other.image == image &&
        other.invoiceImage == invoiceImage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sbtOrderId.hashCode);
    hash = _SystemHash.combine(hash, weight.hashCode);
    hash = _SystemHash.combine(hash, vehicleNo.hashCode);
    hash = _SystemHash.combine(hash, vehicleType.hashCode);
    hash = _SystemHash.combine(hash, salesStatus.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, stackNo.hashCode);
    hash = _SystemHash.combine(hash, driverNo.hashCode);
    hash = _SystemHash.combine(hash, transporterType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);
    hash = _SystemHash.combine(hash, biltyImage.hashCode);
    hash = _SystemHash.combine(hash, kantaParchiImage.hashCode);
    hash = _SystemHash.combine(hash, image.hashCode);
    hash = _SystemHash.combine(hash, invoiceImage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DispatchRequestRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `sbtOrderId` of this provider.
  dynamic get sbtOrderId;

  /// The parameter `weight` of this provider.
  dynamic get weight;

  /// The parameter `vehicleNo` of this provider.
  dynamic get vehicleNo;

  /// The parameter `vehicleType` of this provider.
  dynamic get vehicleType;

  /// The parameter `salesStatus` of this provider.
  dynamic get salesStatus;

  /// The parameter `commodityId` of this provider.
  dynamic get commodityId;

  /// The parameter `terminalId` of this provider.
  dynamic get terminalId;

  /// The parameter `stackNo` of this provider.
  dynamic get stackNo;

  /// The parameter `driverNo` of this provider.
  dynamic get driverNo;

  /// The parameter `transporterType` of this provider.
  dynamic get transporterType;

  /// The parameter `tripId` of this provider.
  dynamic get tripId;

  /// The parameter `biltyImage` of this provider.
  File? get biltyImage;

  /// The parameter `kantaParchiImage` of this provider.
  File? get kantaParchiImage;

  /// The parameter `image` of this provider.
  File? get image;

  /// The parameter `invoiceImage` of this provider.
  File? get invoiceImage;
}

class _DispatchRequestProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with DispatchRequestRef {
  _DispatchRequestProviderElement(super.provider);

  @override
  dynamic get sbtOrderId => (origin as DispatchRequestProvider).sbtOrderId;
  @override
  dynamic get weight => (origin as DispatchRequestProvider).weight;
  @override
  dynamic get vehicleNo => (origin as DispatchRequestProvider).vehicleNo;
  @override
  dynamic get vehicleType => (origin as DispatchRequestProvider).vehicleType;
  @override
  dynamic get salesStatus => (origin as DispatchRequestProvider).salesStatus;
  @override
  dynamic get commodityId => (origin as DispatchRequestProvider).commodityId;
  @override
  dynamic get terminalId => (origin as DispatchRequestProvider).terminalId;
  @override
  dynamic get stackNo => (origin as DispatchRequestProvider).stackNo;
  @override
  dynamic get driverNo => (origin as DispatchRequestProvider).driverNo;
  @override
  dynamic get transporterType =>
      (origin as DispatchRequestProvider).transporterType;
  @override
  dynamic get tripId => (origin as DispatchRequestProvider).tripId;
  @override
  File? get biltyImage => (origin as DispatchRequestProvider).biltyImage;
  @override
  File? get kantaParchiImage =>
      (origin as DispatchRequestProvider).kantaParchiImage;
  @override
  File? get image => (origin as DispatchRequestProvider).image;
  @override
  File? get invoiceImage => (origin as DispatchRequestProvider).invoiceImage;
}

String _$deleteDispatchRequestHash() =>
    r'046fd19324322f42c4c50b3f0d4533fc417644f3';

/// See also [deleteDispatchRequest].
@ProviderFor(deleteDispatchRequest)
const deleteDispatchRequestProvider = DeleteDispatchRequestFamily();

/// See also [deleteDispatchRequest].
class DeleteDispatchRequestFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [deleteDispatchRequest].
  const DeleteDispatchRequestFamily();

  /// See also [deleteDispatchRequest].
  DeleteDispatchRequestProvider call({
    String? id,
    required String sbtOrderId,
  }) {
    return DeleteDispatchRequestProvider(
      id: id,
      sbtOrderId: sbtOrderId,
    );
  }

  @override
  DeleteDispatchRequestProvider getProviderOverride(
    covariant DeleteDispatchRequestProvider provider,
  ) {
    return call(
      id: provider.id,
      sbtOrderId: provider.sbtOrderId,
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
  String? get name => r'deleteDispatchRequestProvider';
}

/// See also [deleteDispatchRequest].
class DeleteDispatchRequestProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [deleteDispatchRequest].
  DeleteDispatchRequestProvider({
    String? id,
    required String sbtOrderId,
  }) : this._internal(
          (ref) => deleteDispatchRequest(
            ref as DeleteDispatchRequestRef,
            id: id,
            sbtOrderId: sbtOrderId,
          ),
          from: deleteDispatchRequestProvider,
          name: r'deleteDispatchRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteDispatchRequestHash,
          dependencies: DeleteDispatchRequestFamily._dependencies,
          allTransitiveDependencies:
              DeleteDispatchRequestFamily._allTransitiveDependencies,
          id: id,
          sbtOrderId: sbtOrderId,
        );

  DeleteDispatchRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.sbtOrderId,
  }) : super.internal();

  final String? id;
  final String sbtOrderId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(DeleteDispatchRequestRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteDispatchRequestProvider._internal(
        (ref) => create(ref as DeleteDispatchRequestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        sbtOrderId: sbtOrderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _DeleteDispatchRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteDispatchRequestProvider &&
        other.id == id &&
        other.sbtOrderId == sbtOrderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, sbtOrderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteDispatchRequestRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `sbtOrderId` of this provider.
  String get sbtOrderId;
}

class _DeleteDispatchRequestProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with DeleteDispatchRequestRef {
  _DeleteDispatchRequestProviderElement(super.provider);

  @override
  String? get id => (origin as DeleteDispatchRequestProvider).id;
  @override
  String get sbtOrderId => (origin as DeleteDispatchRequestProvider).sbtOrderId;
}

String _$getAddressHash() => r'c39d78fb4e6c2429a9d6854ff5e6a0b6be8072b6';

/// See also [getAddress].
@ProviderFor(getAddress)
const getAddressProvider = GetAddressFamily();

/// See also [getAddress].
class GetAddressFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [getAddress].
  const GetAddressFamily();

  /// See also [getAddress].
  GetAddressProvider call({
    String? pinCode,
  }) {
    return GetAddressProvider(
      pinCode: pinCode,
    );
  }

  @override
  GetAddressProvider getProviderOverride(
    covariant GetAddressProvider provider,
  ) {
    return call(
      pinCode: provider.pinCode,
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
  String? get name => r'getAddressProvider';
}

/// See also [getAddress].
class GetAddressProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [getAddress].
  GetAddressProvider({
    String? pinCode,
  }) : this._internal(
          (ref) => getAddress(
            ref as GetAddressRef,
            pinCode: pinCode,
          ),
          from: getAddressProvider,
          name: r'getAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAddressHash,
          dependencies: GetAddressFamily._dependencies,
          allTransitiveDependencies:
              GetAddressFamily._allTransitiveDependencies,
          pinCode: pinCode,
        );

  GetAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pinCode,
  }) : super.internal();

  final String? pinCode;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(GetAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAddressProvider._internal(
        (ref) => create(ref as GetAddressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pinCode: pinCode,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _GetAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAddressProvider && other.pinCode == pinCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pinCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetAddressRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `pinCode` of this provider.
  String? get pinCode;
}

class _GetAddressProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with GetAddressRef {
  _GetAddressProviderElement(super.provider);

  @override
  String? get pinCode => (origin as GetAddressProvider).pinCode;
}

String _$editDispatchRequestHash() =>
    r'b886324ac380b020a7ccd0d8f49beb777d4fc91d';

/// See also [editDispatchRequest].
@ProviderFor(editDispatchRequest)
const editDispatchRequestProvider = EditDispatchRequestFamily();

/// See also [editDispatchRequest].
class EditDispatchRequestFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [editDispatchRequest].
  const EditDispatchRequestFamily();

  /// See also [editDispatchRequest].
  EditDispatchRequestProvider call({
    String? id,
    File? grnImage,
    String? grnNumber,
    File? kantaParchiImage,
  }) {
    return EditDispatchRequestProvider(
      id: id,
      grnImage: grnImage,
      grnNumber: grnNumber,
      kantaParchiImage: kantaParchiImage,
    );
  }

  @override
  EditDispatchRequestProvider getProviderOverride(
    covariant EditDispatchRequestProvider provider,
  ) {
    return call(
      id: provider.id,
      grnImage: provider.grnImage,
      grnNumber: provider.grnNumber,
      kantaParchiImage: provider.kantaParchiImage,
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
  String? get name => r'editDispatchRequestProvider';
}

/// See also [editDispatchRequest].
class EditDispatchRequestProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [editDispatchRequest].
  EditDispatchRequestProvider({
    String? id,
    File? grnImage,
    String? grnNumber,
    File? kantaParchiImage,
  }) : this._internal(
          (ref) => editDispatchRequest(
            ref as EditDispatchRequestRef,
            id: id,
            grnImage: grnImage,
            grnNumber: grnNumber,
            kantaParchiImage: kantaParchiImage,
          ),
          from: editDispatchRequestProvider,
          name: r'editDispatchRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editDispatchRequestHash,
          dependencies: EditDispatchRequestFamily._dependencies,
          allTransitiveDependencies:
              EditDispatchRequestFamily._allTransitiveDependencies,
          id: id,
          grnImage: grnImage,
          grnNumber: grnNumber,
          kantaParchiImage: kantaParchiImage,
        );

  EditDispatchRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.grnImage,
    required this.grnNumber,
    required this.kantaParchiImage,
  }) : super.internal();

  final String? id;
  final File? grnImage;
  final String? grnNumber;
  final File? kantaParchiImage;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(EditDispatchRequestRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditDispatchRequestProvider._internal(
        (ref) => create(ref as EditDispatchRequestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        grnImage: grnImage,
        grnNumber: grnNumber,
        kantaParchiImage: kantaParchiImage,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _EditDispatchRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditDispatchRequestProvider &&
        other.id == id &&
        other.grnImage == grnImage &&
        other.grnNumber == grnNumber &&
        other.kantaParchiImage == kantaParchiImage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, grnImage.hashCode);
    hash = _SystemHash.combine(hash, grnNumber.hashCode);
    hash = _SystemHash.combine(hash, kantaParchiImage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditDispatchRequestRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `grnImage` of this provider.
  File? get grnImage;

  /// The parameter `grnNumber` of this provider.
  String? get grnNumber;

  /// The parameter `kantaParchiImage` of this provider.
  File? get kantaParchiImage;
}

class _EditDispatchRequestProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with EditDispatchRequestRef {
  _EditDispatchRequestProviderElement(super.provider);

  @override
  String? get id => (origin as EditDispatchRequestProvider).id;
  @override
  File? get grnImage => (origin as EditDispatchRequestProvider).grnImage;
  @override
  String? get grnNumber => (origin as EditDispatchRequestProvider).grnNumber;
  @override
  File? get kantaParchiImage =>
      (origin as EditDispatchRequestProvider).kantaParchiImage;
}

String _$dispatchListingHash() => r'0553a483479a8bdd531a46d24585d7e314a6ee3a';

/// See also [dispatchListing].
@ProviderFor(dispatchListing)
const dispatchListingProvider = DispatchListingFamily();

/// See also [dispatchListing].
class DispatchListingFamily extends Family<AsyncValue<DispatchListingModel>> {
  /// See also [dispatchListing].
  const DispatchListingFamily();

  /// See also [dispatchListing].
  DispatchListingProvider call({
    required String? sbtOrderId,
  }) {
    return DispatchListingProvider(
      sbtOrderId: sbtOrderId,
    );
  }

  @override
  DispatchListingProvider getProviderOverride(
    covariant DispatchListingProvider provider,
  ) {
    return call(
      sbtOrderId: provider.sbtOrderId,
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
  String? get name => r'dispatchListingProvider';
}

/// See also [dispatchListing].
class DispatchListingProvider
    extends AutoDisposeStreamProvider<DispatchListingModel> {
  /// See also [dispatchListing].
  DispatchListingProvider({
    required String? sbtOrderId,
  }) : this._internal(
          (ref) => dispatchListing(
            ref as DispatchListingRef,
            sbtOrderId: sbtOrderId,
          ),
          from: dispatchListingProvider,
          name: r'dispatchListingProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dispatchListingHash,
          dependencies: DispatchListingFamily._dependencies,
          allTransitiveDependencies:
              DispatchListingFamily._allTransitiveDependencies,
          sbtOrderId: sbtOrderId,
        );

  DispatchListingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sbtOrderId,
  }) : super.internal();

  final String? sbtOrderId;

  @override
  Override overrideWith(
    Stream<DispatchListingModel> Function(DispatchListingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DispatchListingProvider._internal(
        (ref) => create(ref as DispatchListingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sbtOrderId: sbtOrderId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<DispatchListingModel> createElement() {
    return _DispatchListingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DispatchListingProvider && other.sbtOrderId == sbtOrderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sbtOrderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DispatchListingRef on AutoDisposeStreamProviderRef<DispatchListingModel> {
  /// The parameter `sbtOrderId` of this provider.
  String? get sbtOrderId;
}

class _DispatchListingProviderElement
    extends AutoDisposeStreamProviderElement<DispatchListingModel>
    with DispatchListingRef {
  _DispatchListingProviderElement(super.provider);

  @override
  String? get sbtOrderId => (origin as DispatchListingProvider).sbtOrderId;
}

String _$getMatchOrderPdfHtmlHash() =>
    r'2e99b32a929a5f88508af517a2c94dedbd03121f';

/// See also [getMatchOrderPdfHtml].
@ProviderFor(getMatchOrderPdfHtml)
const getMatchOrderPdfHtmlProvider = GetMatchOrderPdfHtmlFamily();

/// See also [getMatchOrderPdfHtml].
class GetMatchOrderPdfHtmlFamily extends Family<AsyncValue<String>> {
  /// See also [getMatchOrderPdfHtml].
  const GetMatchOrderPdfHtmlFamily();

  /// See also [getMatchOrderPdfHtml].
  GetMatchOrderPdfHtmlProvider call({
    required String orderId,
  }) {
    return GetMatchOrderPdfHtmlProvider(
      orderId: orderId,
    );
  }

  @override
  GetMatchOrderPdfHtmlProvider getProviderOverride(
    covariant GetMatchOrderPdfHtmlProvider provider,
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
  String? get name => r'getMatchOrderPdfHtmlProvider';
}

/// See also [getMatchOrderPdfHtml].
class GetMatchOrderPdfHtmlProvider extends AutoDisposeFutureProvider<String> {
  /// See also [getMatchOrderPdfHtml].
  GetMatchOrderPdfHtmlProvider({
    required String orderId,
  }) : this._internal(
          (ref) => getMatchOrderPdfHtml(
            ref as GetMatchOrderPdfHtmlRef,
            orderId: orderId,
          ),
          from: getMatchOrderPdfHtmlProvider,
          name: r'getMatchOrderPdfHtmlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMatchOrderPdfHtmlHash,
          dependencies: GetMatchOrderPdfHtmlFamily._dependencies,
          allTransitiveDependencies:
              GetMatchOrderPdfHtmlFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  GetMatchOrderPdfHtmlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<String> Function(GetMatchOrderPdfHtmlRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMatchOrderPdfHtmlProvider._internal(
        (ref) => create(ref as GetMatchOrderPdfHtmlRef),
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
  AutoDisposeFutureProviderElement<String> createElement() {
    return _GetMatchOrderPdfHtmlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMatchOrderPdfHtmlProvider && other.orderId == orderId;
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
mixin GetMatchOrderPdfHtmlRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _GetMatchOrderPdfHtmlProviderElement
    extends AutoDisposeFutureProviderElement<String>
    with GetMatchOrderPdfHtmlRef {
  _GetMatchOrderPdfHtmlProviderElement(super.provider);

  @override
  String get orderId => (origin as GetMatchOrderPdfHtmlProvider).orderId;
}

String _$fetchMatchOrderPrintHash() =>
    r'6768df6e75faa9492e8336f358843b6bb5252071';

/// See also [fetchMatchOrderPrint].
@ProviderFor(fetchMatchOrderPrint)
const fetchMatchOrderPrintProvider = FetchMatchOrderPrintFamily();

/// See also [fetchMatchOrderPrint].
class FetchMatchOrderPrintFamily
    extends Family<AsyncValue<MatchOrderPrintModel>> {
  /// See also [fetchMatchOrderPrint].
  const FetchMatchOrderPrintFamily();

  /// See also [fetchMatchOrderPrint].
  FetchMatchOrderPrintProvider call({
    required String orderId,
  }) {
    return FetchMatchOrderPrintProvider(
      orderId: orderId,
    );
  }

  @override
  FetchMatchOrderPrintProvider getProviderOverride(
    covariant FetchMatchOrderPrintProvider provider,
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
  String? get name => r'fetchMatchOrderPrintProvider';
}

/// See also [fetchMatchOrderPrint].
class FetchMatchOrderPrintProvider
    extends AutoDisposeFutureProvider<MatchOrderPrintModel> {
  /// See also [fetchMatchOrderPrint].
  FetchMatchOrderPrintProvider({
    required String orderId,
  }) : this._internal(
          (ref) => fetchMatchOrderPrint(
            ref as FetchMatchOrderPrintRef,
            orderId: orderId,
          ),
          from: fetchMatchOrderPrintProvider,
          name: r'fetchMatchOrderPrintProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMatchOrderPrintHash,
          dependencies: FetchMatchOrderPrintFamily._dependencies,
          allTransitiveDependencies:
              FetchMatchOrderPrintFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  FetchMatchOrderPrintProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<MatchOrderPrintModel> Function(FetchMatchOrderPrintRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchMatchOrderPrintProvider._internal(
        (ref) => create(ref as FetchMatchOrderPrintRef),
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
  AutoDisposeFutureProviderElement<MatchOrderPrintModel> createElement() {
    return _FetchMatchOrderPrintProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchMatchOrderPrintProvider && other.orderId == orderId;
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
mixin FetchMatchOrderPrintRef
    on AutoDisposeFutureProviderRef<MatchOrderPrintModel> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _FetchMatchOrderPrintProviderElement
    extends AutoDisposeFutureProviderElement<MatchOrderPrintModel>
    with FetchMatchOrderPrintRef {
  _FetchMatchOrderPrintProviderElement(super.provider);

  @override
  String get orderId => (origin as FetchMatchOrderPrintProvider).orderId;
}

String _$dispatchListingNewHash() =>
    r'd7787b3a6b969df523fc5a9687de33f3b9330864';

/// See also [dispatchListingNew].
@ProviderFor(dispatchListingNew)
const dispatchListingNewProvider = DispatchListingNewFamily();

/// See also [dispatchListingNew].
class DispatchListingNewFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [dispatchListingNew].
  const DispatchListingNewFamily();

  /// See also [dispatchListingNew].
  DispatchListingNewProvider call({
    required String? sbtOrderId,
  }) {
    return DispatchListingNewProvider(
      sbtOrderId: sbtOrderId,
    );
  }

  @override
  DispatchListingNewProvider getProviderOverride(
    covariant DispatchListingNewProvider provider,
  ) {
    return call(
      sbtOrderId: provider.sbtOrderId,
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
  String? get name => r'dispatchListingNewProvider';
}

/// See also [dispatchListingNew].
class DispatchListingNewProvider
    extends AutoDisposeStreamProvider<Map<String, dynamic>> {
  /// See also [dispatchListingNew].
  DispatchListingNewProvider({
    required String? sbtOrderId,
  }) : this._internal(
          (ref) => dispatchListingNew(
            ref as DispatchListingNewRef,
            sbtOrderId: sbtOrderId,
          ),
          from: dispatchListingNewProvider,
          name: r'dispatchListingNewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dispatchListingNewHash,
          dependencies: DispatchListingNewFamily._dependencies,
          allTransitiveDependencies:
              DispatchListingNewFamily._allTransitiveDependencies,
          sbtOrderId: sbtOrderId,
        );

  DispatchListingNewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sbtOrderId,
  }) : super.internal();

  final String? sbtOrderId;

  @override
  Override overrideWith(
    Stream<Map<String, dynamic>> Function(DispatchListingNewRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DispatchListingNewProvider._internal(
        (ref) => create(ref as DispatchListingNewRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sbtOrderId: sbtOrderId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Map<String, dynamic>> createElement() {
    return _DispatchListingNewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DispatchListingNewProvider &&
        other.sbtOrderId == sbtOrderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sbtOrderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DispatchListingNewRef
    on AutoDisposeStreamProviderRef<Map<String, dynamic>> {
  /// The parameter `sbtOrderId` of this provider.
  String? get sbtOrderId;
}

class _DispatchListingNewProviderElement
    extends AutoDisposeStreamProviderElement<Map<String, dynamic>>
    with DispatchListingNewRef {
  _DispatchListingNewProviderElement(super.provider);

  @override
  String? get sbtOrderId => (origin as DispatchListingNewProvider).sbtOrderId;
}

String _$dispatchRequestQualityParamsHash() =>
    r'a3a3da8bba1f982e640df6c8b416261c12c40fe5';

/// See also [dispatchRequestQualityParams].
@ProviderFor(dispatchRequestQualityParams)
const dispatchRequestQualityParamsProvider =
    DispatchRequestQualityParamsFamily();

/// See also [dispatchRequestQualityParams].
class DispatchRequestQualityParamsFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [dispatchRequestQualityParams].
  const DispatchRequestQualityParamsFamily();

  /// See also [dispatchRequestQualityParams].
  DispatchRequestQualityParamsProvider call({
    String? id,
    required String sbtOrderId,
  }) {
    return DispatchRequestQualityParamsProvider(
      id: id,
      sbtOrderId: sbtOrderId,
    );
  }

  @override
  DispatchRequestQualityParamsProvider getProviderOverride(
    covariant DispatchRequestQualityParamsProvider provider,
  ) {
    return call(
      id: provider.id,
      sbtOrderId: provider.sbtOrderId,
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
  String? get name => r'dispatchRequestQualityParamsProvider';
}

/// See also [dispatchRequestQualityParams].
class DispatchRequestQualityParamsProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [dispatchRequestQualityParams].
  DispatchRequestQualityParamsProvider({
    String? id,
    required String sbtOrderId,
  }) : this._internal(
          (ref) => dispatchRequestQualityParams(
            ref as DispatchRequestQualityParamsRef,
            id: id,
            sbtOrderId: sbtOrderId,
          ),
          from: dispatchRequestQualityParamsProvider,
          name: r'dispatchRequestQualityParamsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dispatchRequestQualityParamsHash,
          dependencies: DispatchRequestQualityParamsFamily._dependencies,
          allTransitiveDependencies:
              DispatchRequestQualityParamsFamily._allTransitiveDependencies,
          id: id,
          sbtOrderId: sbtOrderId,
        );

  DispatchRequestQualityParamsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.sbtOrderId,
  }) : super.internal();

  final String? id;
  final String sbtOrderId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(
            DispatchRequestQualityParamsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DispatchRequestQualityParamsProvider._internal(
        (ref) => create(ref as DispatchRequestQualityParamsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        sbtOrderId: sbtOrderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _DispatchRequestQualityParamsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DispatchRequestQualityParamsProvider &&
        other.id == id &&
        other.sbtOrderId == sbtOrderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, sbtOrderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DispatchRequestQualityParamsRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `sbtOrderId` of this provider.
  String get sbtOrderId;
}

class _DispatchRequestQualityParamsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with DispatchRequestQualityParamsRef {
  _DispatchRequestQualityParamsProviderElement(super.provider);

  @override
  String? get id => (origin as DispatchRequestQualityParamsProvider).id;
  @override
  String get sbtOrderId =>
      (origin as DispatchRequestQualityParamsProvider).sbtOrderId;
}

String _$finalDispatchSubmissionHash() =>
    r'329f3d2d4d29c9e89469710c6b828cb936e96d3b';

/// See also [finalDispatchSubmission].
@ProviderFor(finalDispatchSubmission)
const finalDispatchSubmissionProvider = FinalDispatchSubmissionFamily();

/// See also [finalDispatchSubmission].
class FinalDispatchSubmissionFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [finalDispatchSubmission].
  const FinalDispatchSubmissionFamily();

  /// See also [finalDispatchSubmission].
  FinalDispatchSubmissionProvider call({
    String? id,
    required String sbtOrderId,
  }) {
    return FinalDispatchSubmissionProvider(
      id: id,
      sbtOrderId: sbtOrderId,
    );
  }

  @override
  FinalDispatchSubmissionProvider getProviderOverride(
    covariant FinalDispatchSubmissionProvider provider,
  ) {
    return call(
      id: provider.id,
      sbtOrderId: provider.sbtOrderId,
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
  String? get name => r'finalDispatchSubmissionProvider';
}

/// See also [finalDispatchSubmission].
class FinalDispatchSubmissionProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [finalDispatchSubmission].
  FinalDispatchSubmissionProvider({
    String? id,
    required String sbtOrderId,
  }) : this._internal(
          (ref) => finalDispatchSubmission(
            ref as FinalDispatchSubmissionRef,
            id: id,
            sbtOrderId: sbtOrderId,
          ),
          from: finalDispatchSubmissionProvider,
          name: r'finalDispatchSubmissionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$finalDispatchSubmissionHash,
          dependencies: FinalDispatchSubmissionFamily._dependencies,
          allTransitiveDependencies:
              FinalDispatchSubmissionFamily._allTransitiveDependencies,
          id: id,
          sbtOrderId: sbtOrderId,
        );

  FinalDispatchSubmissionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.sbtOrderId,
  }) : super.internal();

  final String? id;
  final String sbtOrderId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(FinalDispatchSubmissionRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FinalDispatchSubmissionProvider._internal(
        (ref) => create(ref as FinalDispatchSubmissionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        sbtOrderId: sbtOrderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _FinalDispatchSubmissionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FinalDispatchSubmissionProvider &&
        other.id == id &&
        other.sbtOrderId == sbtOrderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, sbtOrderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FinalDispatchSubmissionRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `sbtOrderId` of this provider.
  String get sbtOrderId;
}

class _FinalDispatchSubmissionProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with FinalDispatchSubmissionRef {
  _FinalDispatchSubmissionProviderElement(super.provider);

  @override
  String? get id => (origin as FinalDispatchSubmissionProvider).id;
  @override
  String get sbtOrderId =>
      (origin as FinalDispatchSubmissionProvider).sbtOrderId;
}

String _$updateDispatchPhotosHash() =>
    r'16949f6c8df4b0d6d00eb6c286f14c7e8be1e24b';

/// See also [updateDispatchPhotos].
@ProviderFor(updateDispatchPhotos)
const updateDispatchPhotosProvider = UpdateDispatchPhotosFamily();

/// See also [updateDispatchPhotos].
class UpdateDispatchPhotosFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [updateDispatchPhotos].
  const UpdateDispatchPhotosFamily();

  /// See also [updateDispatchPhotos].
  UpdateDispatchPhotosProvider call({
    String? dispatchRequestId,
    String? sbtOrderId,
    File? kantaParchiPhoto,
    File? biltyPhoto,
    File? loadTruckPhoto,
    File? truckDriverPhoto,
    dynamic qualityPhoto,
  }) {
    return UpdateDispatchPhotosProvider(
      dispatchRequestId: dispatchRequestId,
      sbtOrderId: sbtOrderId,
      kantaParchiPhoto: kantaParchiPhoto,
      biltyPhoto: biltyPhoto,
      loadTruckPhoto: loadTruckPhoto,
      truckDriverPhoto: truckDriverPhoto,
      qualityPhoto: qualityPhoto,
    );
  }

  @override
  UpdateDispatchPhotosProvider getProviderOverride(
    covariant UpdateDispatchPhotosProvider provider,
  ) {
    return call(
      dispatchRequestId: provider.dispatchRequestId,
      sbtOrderId: provider.sbtOrderId,
      kantaParchiPhoto: provider.kantaParchiPhoto,
      biltyPhoto: provider.biltyPhoto,
      loadTruckPhoto: provider.loadTruckPhoto,
      truckDriverPhoto: provider.truckDriverPhoto,
      qualityPhoto: provider.qualityPhoto,
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
  String? get name => r'updateDispatchPhotosProvider';
}

/// See also [updateDispatchPhotos].
class UpdateDispatchPhotosProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [updateDispatchPhotos].
  UpdateDispatchPhotosProvider({
    String? dispatchRequestId,
    String? sbtOrderId,
    File? kantaParchiPhoto,
    File? biltyPhoto,
    File? loadTruckPhoto,
    File? truckDriverPhoto,
    dynamic qualityPhoto,
  }) : this._internal(
          (ref) => updateDispatchPhotos(
            ref as UpdateDispatchPhotosRef,
            dispatchRequestId: dispatchRequestId,
            sbtOrderId: sbtOrderId,
            kantaParchiPhoto: kantaParchiPhoto,
            biltyPhoto: biltyPhoto,
            loadTruckPhoto: loadTruckPhoto,
            truckDriverPhoto: truckDriverPhoto,
            qualityPhoto: qualityPhoto,
          ),
          from: updateDispatchPhotosProvider,
          name: r'updateDispatchPhotosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateDispatchPhotosHash,
          dependencies: UpdateDispatchPhotosFamily._dependencies,
          allTransitiveDependencies:
              UpdateDispatchPhotosFamily._allTransitiveDependencies,
          dispatchRequestId: dispatchRequestId,
          sbtOrderId: sbtOrderId,
          kantaParchiPhoto: kantaParchiPhoto,
          biltyPhoto: biltyPhoto,
          loadTruckPhoto: loadTruckPhoto,
          truckDriverPhoto: truckDriverPhoto,
          qualityPhoto: qualityPhoto,
        );

  UpdateDispatchPhotosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dispatchRequestId,
    required this.sbtOrderId,
    required this.kantaParchiPhoto,
    required this.biltyPhoto,
    required this.loadTruckPhoto,
    required this.truckDriverPhoto,
    required this.qualityPhoto,
  }) : super.internal();

  final String? dispatchRequestId;
  final String? sbtOrderId;
  final File? kantaParchiPhoto;
  final File? biltyPhoto;
  final File? loadTruckPhoto;
  final File? truckDriverPhoto;
  final dynamic qualityPhoto;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(UpdateDispatchPhotosRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateDispatchPhotosProvider._internal(
        (ref) => create(ref as UpdateDispatchPhotosRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dispatchRequestId: dispatchRequestId,
        sbtOrderId: sbtOrderId,
        kantaParchiPhoto: kantaParchiPhoto,
        biltyPhoto: biltyPhoto,
        loadTruckPhoto: loadTruckPhoto,
        truckDriverPhoto: truckDriverPhoto,
        qualityPhoto: qualityPhoto,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _UpdateDispatchPhotosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateDispatchPhotosProvider &&
        other.dispatchRequestId == dispatchRequestId &&
        other.sbtOrderId == sbtOrderId &&
        other.kantaParchiPhoto == kantaParchiPhoto &&
        other.biltyPhoto == biltyPhoto &&
        other.loadTruckPhoto == loadTruckPhoto &&
        other.truckDriverPhoto == truckDriverPhoto &&
        other.qualityPhoto == qualityPhoto;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dispatchRequestId.hashCode);
    hash = _SystemHash.combine(hash, sbtOrderId.hashCode);
    hash = _SystemHash.combine(hash, kantaParchiPhoto.hashCode);
    hash = _SystemHash.combine(hash, biltyPhoto.hashCode);
    hash = _SystemHash.combine(hash, loadTruckPhoto.hashCode);
    hash = _SystemHash.combine(hash, truckDriverPhoto.hashCode);
    hash = _SystemHash.combine(hash, qualityPhoto.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateDispatchPhotosRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `dispatchRequestId` of this provider.
  String? get dispatchRequestId;

  /// The parameter `sbtOrderId` of this provider.
  String? get sbtOrderId;

  /// The parameter `kantaParchiPhoto` of this provider.
  File? get kantaParchiPhoto;

  /// The parameter `biltyPhoto` of this provider.
  File? get biltyPhoto;

  /// The parameter `loadTruckPhoto` of this provider.
  File? get loadTruckPhoto;

  /// The parameter `truckDriverPhoto` of this provider.
  File? get truckDriverPhoto;

  /// The parameter `qualityPhoto` of this provider.
  dynamic get qualityPhoto;
}

class _UpdateDispatchPhotosProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with UpdateDispatchPhotosRef {
  _UpdateDispatchPhotosProviderElement(super.provider);

  @override
  String? get dispatchRequestId =>
      (origin as UpdateDispatchPhotosProvider).dispatchRequestId;
  @override
  String? get sbtOrderId => (origin as UpdateDispatchPhotosProvider).sbtOrderId;
  @override
  File? get kantaParchiPhoto =>
      (origin as UpdateDispatchPhotosProvider).kantaParchiPhoto;
  @override
  File? get biltyPhoto => (origin as UpdateDispatchPhotosProvider).biltyPhoto;
  @override
  File? get loadTruckPhoto =>
      (origin as UpdateDispatchPhotosProvider).loadTruckPhoto;
  @override
  File? get truckDriverPhoto =>
      (origin as UpdateDispatchPhotosProvider).truckDriverPhoto;
  @override
  dynamic get qualityPhoto =>
      (origin as UpdateDispatchPhotosProvider).qualityPhoto;
}

String _$grnRequestListHash() => r'7430d0330a48776e91fe3791506e94686cc7f708';

/// See also [grnRequestList].
@ProviderFor(grnRequestList)
final grnRequestListProvider =
    AutoDisposeStreamProvider<Map<String, dynamic>>.internal(
  grnRequestList,
  name: r'grnRequestListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$grnRequestListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GrnRequestListRef = AutoDisposeStreamProviderRef<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
