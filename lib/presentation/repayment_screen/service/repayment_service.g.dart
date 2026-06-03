// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repayment_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$repaymentTerminalsHash() =>
    r'150f2325a80bf6f9ff13880bed1d9dc069a8ff7a';

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

/// See also [repaymentTerminals].
@ProviderFor(repaymentTerminals)
const repaymentTerminalsProvider = RepaymentTerminalsFamily();

/// See also [repaymentTerminals].
class RepaymentTerminalsFamily extends Family<AsyncValue<RepaymentModel>> {
  /// See also [repaymentTerminals].
  const RepaymentTerminalsFamily();

  /// See also [repaymentTerminals].
  RepaymentTerminalsProvider call({
    String? terminalId = "",
    String? commodityId = "",
    String? type = "",
  }) {
    return RepaymentTerminalsProvider(
      terminalId: terminalId,
      commodityId: commodityId,
      type: type,
    );
  }

  @override
  RepaymentTerminalsProvider getProviderOverride(
    covariant RepaymentTerminalsProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      commodityId: provider.commodityId,
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
  String? get name => r'repaymentTerminalsProvider';
}

/// See also [repaymentTerminals].
class RepaymentTerminalsProvider
    extends AutoDisposeStreamProvider<RepaymentModel> {
  /// See also [repaymentTerminals].
  RepaymentTerminalsProvider({
    String? terminalId = "",
    String? commodityId = "",
    String? type = "",
  }) : this._internal(
          (ref) => repaymentTerminals(
            ref as RepaymentTerminalsRef,
            terminalId: terminalId,
            commodityId: commodityId,
            type: type,
          ),
          from: repaymentTerminalsProvider,
          name: r'repaymentTerminalsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$repaymentTerminalsHash,
          dependencies: RepaymentTerminalsFamily._dependencies,
          allTransitiveDependencies:
              RepaymentTerminalsFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
          type: type,
        );

  RepaymentTerminalsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.commodityId,
    required this.type,
  }) : super.internal();

  final String? terminalId;
  final String? commodityId;
  final String? type;

  @override
  Override overrideWith(
    Stream<RepaymentModel> Function(RepaymentTerminalsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RepaymentTerminalsProvider._internal(
        (ref) => create(ref as RepaymentTerminalsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        commodityId: commodityId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<RepaymentModel> createElement() {
    return _RepaymentTerminalsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RepaymentTerminalsProvider &&
        other.terminalId == terminalId &&
        other.commodityId == commodityId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RepaymentTerminalsRef on AutoDisposeStreamProviderRef<RepaymentModel> {
  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `type` of this provider.
  String? get type;
}

class _RepaymentTerminalsProviderElement
    extends AutoDisposeStreamProviderElement<RepaymentModel>
    with RepaymentTerminalsRef {
  _RepaymentTerminalsProviderElement(super.provider);

  @override
  String? get terminalId => (origin as RepaymentTerminalsProvider).terminalId;
  @override
  String? get commodityId => (origin as RepaymentTerminalsProvider).commodityId;
  @override
  String? get type => (origin as RepaymentTerminalsProvider).type;
}

String _$repaymentCommodityHash() =>
    r'c28d22e79c9dba0713e14d015672fa8c5e52790c';

/// See also [repaymentCommodity].
@ProviderFor(repaymentCommodity)
const repaymentCommodityProvider = RepaymentCommodityFamily();

/// See also [repaymentCommodity].
class RepaymentCommodityFamily extends Family<AsyncValue<RepaymentModel>> {
  /// See also [repaymentCommodity].
  const RepaymentCommodityFamily();

  /// See also [repaymentCommodity].
  RepaymentCommodityProvider call({
    String? terminalId = "",
    String? commodityId = "",
    String? type = "",
  }) {
    return RepaymentCommodityProvider(
      terminalId: terminalId,
      commodityId: commodityId,
      type: type,
    );
  }

  @override
  RepaymentCommodityProvider getProviderOverride(
    covariant RepaymentCommodityProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      commodityId: provider.commodityId,
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
  String? get name => r'repaymentCommodityProvider';
}

/// See also [repaymentCommodity].
class RepaymentCommodityProvider
    extends AutoDisposeStreamProvider<RepaymentModel> {
  /// See also [repaymentCommodity].
  RepaymentCommodityProvider({
    String? terminalId = "",
    String? commodityId = "",
    String? type = "",
  }) : this._internal(
          (ref) => repaymentCommodity(
            ref as RepaymentCommodityRef,
            terminalId: terminalId,
            commodityId: commodityId,
            type: type,
          ),
          from: repaymentCommodityProvider,
          name: r'repaymentCommodityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$repaymentCommodityHash,
          dependencies: RepaymentCommodityFamily._dependencies,
          allTransitiveDependencies:
              RepaymentCommodityFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
          type: type,
        );

  RepaymentCommodityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.commodityId,
    required this.type,
  }) : super.internal();

  final String? terminalId;
  final String? commodityId;
  final String? type;

  @override
  Override overrideWith(
    Stream<RepaymentModel> Function(RepaymentCommodityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RepaymentCommodityProvider._internal(
        (ref) => create(ref as RepaymentCommodityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        commodityId: commodityId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<RepaymentModel> createElement() {
    return _RepaymentCommodityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RepaymentCommodityProvider &&
        other.terminalId == terminalId &&
        other.commodityId == commodityId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RepaymentCommodityRef on AutoDisposeStreamProviderRef<RepaymentModel> {
  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `type` of this provider.
  String? get type;
}

class _RepaymentCommodityProviderElement
    extends AutoDisposeStreamProviderElement<RepaymentModel>
    with RepaymentCommodityRef {
  _RepaymentCommodityProviderElement(super.provider);

  @override
  String? get terminalId => (origin as RepaymentCommodityProvider).terminalId;
  @override
  String? get commodityId => (origin as RepaymentCommodityProvider).commodityId;
  @override
  String? get type => (origin as RepaymentCommodityProvider).type;
}

String _$repaymentStacksHash() => r'437da96722a2e5aaaceb0fae5e02ad17f39f0eb4';

/// See also [repaymentStacks].
@ProviderFor(repaymentStacks)
const repaymentStacksProvider = RepaymentStacksFamily();

/// See also [repaymentStacks].
class RepaymentStacksFamily extends Family<AsyncValue<RepaymentModel>> {
  /// See also [repaymentStacks].
  const RepaymentStacksFamily();

  /// See also [repaymentStacks].
  RepaymentStacksProvider call({
    String? terminalId = "",
    String? commodityId = "",
    String? type = "",
  }) {
    return RepaymentStacksProvider(
      terminalId: terminalId,
      commodityId: commodityId,
      type: type,
    );
  }

  @override
  RepaymentStacksProvider getProviderOverride(
    covariant RepaymentStacksProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      commodityId: provider.commodityId,
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
  String? get name => r'repaymentStacksProvider';
}

/// See also [repaymentStacks].
class RepaymentStacksProvider
    extends AutoDisposeStreamProvider<RepaymentModel> {
  /// See also [repaymentStacks].
  RepaymentStacksProvider({
    String? terminalId = "",
    String? commodityId = "",
    String? type = "",
  }) : this._internal(
          (ref) => repaymentStacks(
            ref as RepaymentStacksRef,
            terminalId: terminalId,
            commodityId: commodityId,
            type: type,
          ),
          from: repaymentStacksProvider,
          name: r'repaymentStacksProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$repaymentStacksHash,
          dependencies: RepaymentStacksFamily._dependencies,
          allTransitiveDependencies:
              RepaymentStacksFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
          type: type,
        );

  RepaymentStacksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.commodityId,
    required this.type,
  }) : super.internal();

  final String? terminalId;
  final String? commodityId;
  final String? type;

  @override
  Override overrideWith(
    Stream<RepaymentModel> Function(RepaymentStacksRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RepaymentStacksProvider._internal(
        (ref) => create(ref as RepaymentStacksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        commodityId: commodityId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<RepaymentModel> createElement() {
    return _RepaymentStacksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RepaymentStacksProvider &&
        other.terminalId == terminalId &&
        other.commodityId == commodityId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RepaymentStacksRef on AutoDisposeStreamProviderRef<RepaymentModel> {
  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `type` of this provider.
  String? get type;
}

class _RepaymentStacksProviderElement
    extends AutoDisposeStreamProviderElement<RepaymentModel>
    with RepaymentStacksRef {
  _RepaymentStacksProviderElement(super.provider);

  @override
  String? get terminalId => (origin as RepaymentStacksProvider).terminalId;
  @override
  String? get commodityId => (origin as RepaymentStacksProvider).commodityId;
  @override
  String? get type => (origin as RepaymentStacksProvider).type;
}

String _$repaymentSettlementHash() =>
    r'62c8ad30e8c02597aa77025f5030b7db8360582a';

/// See also [repaymentSettlement].
@ProviderFor(repaymentSettlement)
const repaymentSettlementProvider = RepaymentSettlementFamily();

/// See also [repaymentSettlement].
class RepaymentSettlementFamily extends Family<AsyncValue<BaseResponseModel>> {
  /// See also [repaymentSettlement].
  const RepaymentSettlementFamily();

  /// See also [repaymentSettlement].
  RepaymentSettlementProvider call({
    String? settlementId = "",
    String? totalSettlementAmount = "",
  }) {
    return RepaymentSettlementProvider(
      settlementId: settlementId,
      totalSettlementAmount: totalSettlementAmount,
    );
  }

  @override
  RepaymentSettlementProvider getProviderOverride(
    covariant RepaymentSettlementProvider provider,
  ) {
    return call(
      settlementId: provider.settlementId,
      totalSettlementAmount: provider.totalSettlementAmount,
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
  String? get name => r'repaymentSettlementProvider';
}

/// See also [repaymentSettlement].
class RepaymentSettlementProvider
    extends AutoDisposeFutureProvider<BaseResponseModel> {
  /// See also [repaymentSettlement].
  RepaymentSettlementProvider({
    String? settlementId = "",
    String? totalSettlementAmount = "",
  }) : this._internal(
          (ref) => repaymentSettlement(
            ref as RepaymentSettlementRef,
            settlementId: settlementId,
            totalSettlementAmount: totalSettlementAmount,
          ),
          from: repaymentSettlementProvider,
          name: r'repaymentSettlementProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$repaymentSettlementHash,
          dependencies: RepaymentSettlementFamily._dependencies,
          allTransitiveDependencies:
              RepaymentSettlementFamily._allTransitiveDependencies,
          settlementId: settlementId,
          totalSettlementAmount: totalSettlementAmount,
        );

  RepaymentSettlementProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.settlementId,
    required this.totalSettlementAmount,
  }) : super.internal();

  final String? settlementId;
  final String? totalSettlementAmount;

  @override
  Override overrideWith(
    FutureOr<BaseResponseModel> Function(RepaymentSettlementRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RepaymentSettlementProvider._internal(
        (ref) => create(ref as RepaymentSettlementRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        settlementId: settlementId,
        totalSettlementAmount: totalSettlementAmount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseModel> createElement() {
    return _RepaymentSettlementProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RepaymentSettlementProvider &&
        other.settlementId == settlementId &&
        other.totalSettlementAmount == totalSettlementAmount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, settlementId.hashCode);
    hash = _SystemHash.combine(hash, totalSettlementAmount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RepaymentSettlementRef
    on AutoDisposeFutureProviderRef<BaseResponseModel> {
  /// The parameter `settlementId` of this provider.
  String? get settlementId;

  /// The parameter `totalSettlementAmount` of this provider.
  String? get totalSettlementAmount;
}

class _RepaymentSettlementProviderElement
    extends AutoDisposeFutureProviderElement<BaseResponseModel>
    with RepaymentSettlementRef {
  _RepaymentSettlementProviderElement(super.provider);

  @override
  String? get settlementId =>
      (origin as RepaymentSettlementProvider).settlementId;
  @override
  String? get totalSettlementAmount =>
      (origin as RepaymentSettlementProvider).totalSettlementAmount;
}

String _$settlementListHash() => r'7519383df1f0aeb7f1d710822bb5620fc2ca313d';

/// See also [settlementList].
@ProviderFor(settlementList)
const settlementListProvider = SettlementListFamily();

/// See also [settlementList].
class SettlementListFamily extends Family<AsyncValue<SettlementListModel>> {
  /// See also [settlementList].
  const SettlementListFamily();

  /// See also [settlementList].
  SettlementListProvider call({
    String? terminalId = "",
    String? commodityId = "",
    String? stackNumber = "",
  }) {
    return SettlementListProvider(
      terminalId: terminalId,
      commodityId: commodityId,
      stackNumber: stackNumber,
    );
  }

  @override
  SettlementListProvider getProviderOverride(
    covariant SettlementListProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      commodityId: provider.commodityId,
      stackNumber: provider.stackNumber,
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
  String? get name => r'settlementListProvider';
}

/// See also [settlementList].
class SettlementListProvider
    extends AutoDisposeStreamProvider<SettlementListModel> {
  /// See also [settlementList].
  SettlementListProvider({
    String? terminalId = "",
    String? commodityId = "",
    String? stackNumber = "",
  }) : this._internal(
          (ref) => settlementList(
            ref as SettlementListRef,
            terminalId: terminalId,
            commodityId: commodityId,
            stackNumber: stackNumber,
          ),
          from: settlementListProvider,
          name: r'settlementListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$settlementListHash,
          dependencies: SettlementListFamily._dependencies,
          allTransitiveDependencies:
              SettlementListFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
          stackNumber: stackNumber,
        );

  SettlementListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.commodityId,
    required this.stackNumber,
  }) : super.internal();

  final String? terminalId;
  final String? commodityId;
  final String? stackNumber;

  @override
  Override overrideWith(
    Stream<SettlementListModel> Function(SettlementListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SettlementListProvider._internal(
        (ref) => create(ref as SettlementListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        commodityId: commodityId,
        stackNumber: stackNumber,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SettlementListModel> createElement() {
    return _SettlementListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SettlementListProvider &&
        other.terminalId == terminalId &&
        other.commodityId == commodityId &&
        other.stackNumber == stackNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, stackNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SettlementListRef on AutoDisposeStreamProviderRef<SettlementListModel> {
  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `stackNumber` of this provider.
  String? get stackNumber;
}

class _SettlementListProviderElement
    extends AutoDisposeStreamProviderElement<SettlementListModel>
    with SettlementListRef {
  _SettlementListProviderElement(super.provider);

  @override
  String? get terminalId => (origin as SettlementListProvider).terminalId;
  @override
  String? get commodityId => (origin as SettlementListProvider).commodityId;
  @override
  String? get stackNumber => (origin as SettlementListProvider).stackNumber;
}

String _$purchaseOrderListOutwardsHash() =>
    r'1eb2cbaf31810c76b7c8cbae3010d0c7b64c856e';

/// See also [purchaseOrderListOutwards].
@ProviderFor(purchaseOrderListOutwards)
const purchaseOrderListOutwardsProvider = PurchaseOrderListOutwardsFamily();

/// See also [purchaseOrderListOutwards].
class PurchaseOrderListOutwardsFamily
    extends Family<AsyncValue<PurchaseOrderTypeModel>> {
  /// See also [purchaseOrderListOutwards].
  const PurchaseOrderListOutwardsFamily();

  /// See also [purchaseOrderListOutwards].
  PurchaseOrderListOutwardsProvider call({
    required String terminalId,
    required String commodityId,
  }) {
    return PurchaseOrderListOutwardsProvider(
      terminalId: terminalId,
      commodityId: commodityId,
    );
  }

  @override
  PurchaseOrderListOutwardsProvider getProviderOverride(
    covariant PurchaseOrderListOutwardsProvider provider,
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
  String? get name => r'purchaseOrderListOutwardsProvider';
}

/// See also [purchaseOrderListOutwards].
class PurchaseOrderListOutwardsProvider
    extends AutoDisposeStreamProvider<PurchaseOrderTypeModel> {
  /// See also [purchaseOrderListOutwards].
  PurchaseOrderListOutwardsProvider({
    required String terminalId,
    required String commodityId,
  }) : this._internal(
          (ref) => purchaseOrderListOutwards(
            ref as PurchaseOrderListOutwardsRef,
            terminalId: terminalId,
            commodityId: commodityId,
          ),
          from: purchaseOrderListOutwardsProvider,
          name: r'purchaseOrderListOutwardsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$purchaseOrderListOutwardsHash,
          dependencies: PurchaseOrderListOutwardsFamily._dependencies,
          allTransitiveDependencies:
              PurchaseOrderListOutwardsFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
        );

  PurchaseOrderListOutwardsProvider._internal(
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
    Stream<PurchaseOrderTypeModel> Function(
            PurchaseOrderListOutwardsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PurchaseOrderListOutwardsProvider._internal(
        (ref) => create(ref as PurchaseOrderListOutwardsRef),
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
  AutoDisposeStreamProviderElement<PurchaseOrderTypeModel> createElement() {
    return _PurchaseOrderListOutwardsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PurchaseOrderListOutwardsProvider &&
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
mixin PurchaseOrderListOutwardsRef
    on AutoDisposeStreamProviderRef<PurchaseOrderTypeModel> {
  /// The parameter `terminalId` of this provider.
  String get terminalId;

  /// The parameter `commodityId` of this provider.
  String get commodityId;
}

class _PurchaseOrderListOutwardsProviderElement
    extends AutoDisposeStreamProviderElement<PurchaseOrderTypeModel>
    with PurchaseOrderListOutwardsRef {
  _PurchaseOrderListOutwardsProviderElement(super.provider);

  @override
  String get terminalId =>
      (origin as PurchaseOrderListOutwardsProvider).terminalId;
  @override
  String get commodityId =>
      (origin as PurchaseOrderListOutwardsProvider).commodityId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
