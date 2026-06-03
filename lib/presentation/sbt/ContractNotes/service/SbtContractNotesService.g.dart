// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SbtContractNotesService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$buyerContractNoteHash() => r'508b1d60815ab528e3a2f792d74638a23dff9539';

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

/// See also [buyerContractNote].
@ProviderFor(buyerContractNote)
const buyerContractNoteProvider = BuyerContractNoteFamily();

/// See also [buyerContractNote].
class BuyerContractNoteFamily
    extends Family<AsyncValue<SbtBuyerContractModel>> {
  /// See also [buyerContractNote].
  const BuyerContractNoteFamily();

  /// See also [buyerContractNote].
  BuyerContractNoteProvider call({
    String? orderId,
    String? type,
  }) {
    return BuyerContractNoteProvider(
      orderId: orderId,
      type: type,
    );
  }

  @override
  BuyerContractNoteProvider getProviderOverride(
    covariant BuyerContractNoteProvider provider,
  ) {
    return call(
      orderId: provider.orderId,
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
  String? get name => r'buyerContractNoteProvider';
}

/// See also [buyerContractNote].
class BuyerContractNoteProvider
    extends AutoDisposeStreamProvider<SbtBuyerContractModel> {
  /// See also [buyerContractNote].
  BuyerContractNoteProvider({
    String? orderId,
    String? type,
  }) : this._internal(
          (ref) => buyerContractNote(
            ref as BuyerContractNoteRef,
            orderId: orderId,
            type: type,
          ),
          from: buyerContractNoteProvider,
          name: r'buyerContractNoteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$buyerContractNoteHash,
          dependencies: BuyerContractNoteFamily._dependencies,
          allTransitiveDependencies:
              BuyerContractNoteFamily._allTransitiveDependencies,
          orderId: orderId,
          type: type,
        );

  BuyerContractNoteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
    required this.type,
  }) : super.internal();

  final String? orderId;
  final String? type;

  @override
  Override overrideWith(
    Stream<SbtBuyerContractModel> Function(BuyerContractNoteRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BuyerContractNoteProvider._internal(
        (ref) => create(ref as BuyerContractNoteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SbtBuyerContractModel> createElement() {
    return _BuyerContractNoteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BuyerContractNoteProvider &&
        other.orderId == orderId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BuyerContractNoteRef
    on AutoDisposeStreamProviderRef<SbtBuyerContractModel> {
  /// The parameter `orderId` of this provider.
  String? get orderId;

  /// The parameter `type` of this provider.
  String? get type;
}

class _BuyerContractNoteProviderElement
    extends AutoDisposeStreamProviderElement<SbtBuyerContractModel>
    with BuyerContractNoteRef {
  _BuyerContractNoteProviderElement(super.provider);

  @override
  String? get orderId => (origin as BuyerContractNoteProvider).orderId;
  @override
  String? get type => (origin as BuyerContractNoteProvider).type;
}

String _$sellerContractNoteHash() =>
    r'ae1f76f2569f940a0fe1bda280a1b5a1023437d1';

/// See also [sellerContractNote].
@ProviderFor(sellerContractNote)
const sellerContractNoteProvider = SellerContractNoteFamily();

/// See also [sellerContractNote].
class SellerContractNoteFamily
    extends Family<AsyncValue<SbtSellerContractModel>> {
  /// See also [sellerContractNote].
  const SellerContractNoteFamily();

  /// See also [sellerContractNote].
  SellerContractNoteProvider call({
    String? orderId,
    String? type,
  }) {
    return SellerContractNoteProvider(
      orderId: orderId,
      type: type,
    );
  }

  @override
  SellerContractNoteProvider getProviderOverride(
    covariant SellerContractNoteProvider provider,
  ) {
    return call(
      orderId: provider.orderId,
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
  String? get name => r'sellerContractNoteProvider';
}

/// See also [sellerContractNote].
class SellerContractNoteProvider
    extends AutoDisposeStreamProvider<SbtSellerContractModel> {
  /// See also [sellerContractNote].
  SellerContractNoteProvider({
    String? orderId,
    String? type,
  }) : this._internal(
          (ref) => sellerContractNote(
            ref as SellerContractNoteRef,
            orderId: orderId,
            type: type,
          ),
          from: sellerContractNoteProvider,
          name: r'sellerContractNoteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sellerContractNoteHash,
          dependencies: SellerContractNoteFamily._dependencies,
          allTransitiveDependencies:
              SellerContractNoteFamily._allTransitiveDependencies,
          orderId: orderId,
          type: type,
        );

  SellerContractNoteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
    required this.type,
  }) : super.internal();

  final String? orderId;
  final String? type;

  @override
  Override overrideWith(
    Stream<SbtSellerContractModel> Function(SellerContractNoteRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SellerContractNoteProvider._internal(
        (ref) => create(ref as SellerContractNoteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SbtSellerContractModel> createElement() {
    return _SellerContractNoteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SellerContractNoteProvider &&
        other.orderId == orderId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SellerContractNoteRef
    on AutoDisposeStreamProviderRef<SbtSellerContractModel> {
  /// The parameter `orderId` of this provider.
  String? get orderId;

  /// The parameter `type` of this provider.
  String? get type;
}

class _SellerContractNoteProviderElement
    extends AutoDisposeStreamProviderElement<SbtSellerContractModel>
    with SellerContractNoteRef {
  _SellerContractNoteProviderElement(super.provider);

  @override
  String? get orderId => (origin as SellerContractNoteProvider).orderId;
  @override
  String? get type => (origin as SellerContractNoteProvider).type;
}

String _$buyerContractNoteSBTHash() =>
    r'314e4c19b8a6b1223bfee02b7306b627cd3c5735';

/// See also [buyerContractNoteSBT].
@ProviderFor(buyerContractNoteSBT)
const buyerContractNoteSBTProvider = BuyerContractNoteSBTFamily();

/// See also [buyerContractNoteSBT].
class BuyerContractNoteSBTFamily
    extends Family<AsyncValue<SbtBuyerContractModel>> {
  /// See also [buyerContractNoteSBT].
  const BuyerContractNoteSBTFamily();

  /// See also [buyerContractNoteSBT].
  BuyerContractNoteSBTProvider call({
    String? orderId,
    String? type,
  }) {
    return BuyerContractNoteSBTProvider(
      orderId: orderId,
      type: type,
    );
  }

  @override
  BuyerContractNoteSBTProvider getProviderOverride(
    covariant BuyerContractNoteSBTProvider provider,
  ) {
    return call(
      orderId: provider.orderId,
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
  String? get name => r'buyerContractNoteSBTProvider';
}

/// See also [buyerContractNoteSBT].
class BuyerContractNoteSBTProvider
    extends AutoDisposeStreamProvider<SbtBuyerContractModel> {
  /// See also [buyerContractNoteSBT].
  BuyerContractNoteSBTProvider({
    String? orderId,
    String? type,
  }) : this._internal(
          (ref) => buyerContractNoteSBT(
            ref as BuyerContractNoteSBTRef,
            orderId: orderId,
            type: type,
          ),
          from: buyerContractNoteSBTProvider,
          name: r'buyerContractNoteSBTProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$buyerContractNoteSBTHash,
          dependencies: BuyerContractNoteSBTFamily._dependencies,
          allTransitiveDependencies:
              BuyerContractNoteSBTFamily._allTransitiveDependencies,
          orderId: orderId,
          type: type,
        );

  BuyerContractNoteSBTProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
    required this.type,
  }) : super.internal();

  final String? orderId;
  final String? type;

  @override
  Override overrideWith(
    Stream<SbtBuyerContractModel> Function(BuyerContractNoteSBTRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BuyerContractNoteSBTProvider._internal(
        (ref) => create(ref as BuyerContractNoteSBTRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SbtBuyerContractModel> createElement() {
    return _BuyerContractNoteSBTProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BuyerContractNoteSBTProvider &&
        other.orderId == orderId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BuyerContractNoteSBTRef
    on AutoDisposeStreamProviderRef<SbtBuyerContractModel> {
  /// The parameter `orderId` of this provider.
  String? get orderId;

  /// The parameter `type` of this provider.
  String? get type;
}

class _BuyerContractNoteSBTProviderElement
    extends AutoDisposeStreamProviderElement<SbtBuyerContractModel>
    with BuyerContractNoteSBTRef {
  _BuyerContractNoteSBTProviderElement(super.provider);

  @override
  String? get orderId => (origin as BuyerContractNoteSBTProvider).orderId;
  @override
  String? get type => (origin as BuyerContractNoteSBTProvider).type;
}

String _$sellerContractNoteSBTHash() =>
    r'89f57fa0ccc07a9810aa64ad2d2ac19539309c43';

/// See also [sellerContractNoteSBT].
@ProviderFor(sellerContractNoteSBT)
const sellerContractNoteSBTProvider = SellerContractNoteSBTFamily();

/// See also [sellerContractNoteSBT].
class SellerContractNoteSBTFamily
    extends Family<AsyncValue<SbtSellerContractModel>> {
  /// See also [sellerContractNoteSBT].
  const SellerContractNoteSBTFamily();

  /// See also [sellerContractNoteSBT].
  SellerContractNoteSBTProvider call({
    String? orderId,
    String? type,
  }) {
    return SellerContractNoteSBTProvider(
      orderId: orderId,
      type: type,
    );
  }

  @override
  SellerContractNoteSBTProvider getProviderOverride(
    covariant SellerContractNoteSBTProvider provider,
  ) {
    return call(
      orderId: provider.orderId,
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
  String? get name => r'sellerContractNoteSBTProvider';
}

/// See also [sellerContractNoteSBT].
class SellerContractNoteSBTProvider
    extends AutoDisposeStreamProvider<SbtSellerContractModel> {
  /// See also [sellerContractNoteSBT].
  SellerContractNoteSBTProvider({
    String? orderId,
    String? type,
  }) : this._internal(
          (ref) => sellerContractNoteSBT(
            ref as SellerContractNoteSBTRef,
            orderId: orderId,
            type: type,
          ),
          from: sellerContractNoteSBTProvider,
          name: r'sellerContractNoteSBTProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sellerContractNoteSBTHash,
          dependencies: SellerContractNoteSBTFamily._dependencies,
          allTransitiveDependencies:
              SellerContractNoteSBTFamily._allTransitiveDependencies,
          orderId: orderId,
          type: type,
        );

  SellerContractNoteSBTProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
    required this.type,
  }) : super.internal();

  final String? orderId;
  final String? type;

  @override
  Override overrideWith(
    Stream<SbtSellerContractModel> Function(SellerContractNoteSBTRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SellerContractNoteSBTProvider._internal(
        (ref) => create(ref as SellerContractNoteSBTRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<SbtSellerContractModel> createElement() {
    return _SellerContractNoteSBTProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SellerContractNoteSBTProvider &&
        other.orderId == orderId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SellerContractNoteSBTRef
    on AutoDisposeStreamProviderRef<SbtSellerContractModel> {
  /// The parameter `orderId` of this provider.
  String? get orderId;

  /// The parameter `type` of this provider.
  String? get type;
}

class _SellerContractNoteSBTProviderElement
    extends AutoDisposeStreamProviderElement<SbtSellerContractModel>
    with SellerContractNoteSBTRef {
  _SellerContractNoteSBTProviderElement(super.provider);

  @override
  String? get orderId => (origin as SellerContractNoteSBTProvider).orderId;
  @override
  String? get type => (origin as SellerContractNoteSBTProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
