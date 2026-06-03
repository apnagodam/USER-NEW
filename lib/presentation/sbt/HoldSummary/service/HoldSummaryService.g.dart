// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HoldSummaryService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sbtHoldSummaryHash() => r'53a1c5027a83de2d30b5f00f329f8b6cb77d1ecb';

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

/// See also [sbtHoldSummary].
@ProviderFor(sbtHoldSummary)
const sbtHoldSummaryProvider = SbtHoldSummaryFamily();

/// See also [sbtHoldSummary].
class SbtHoldSummaryFamily extends Family<AsyncValue<SbtHoldSummaryModel>> {
  /// See also [sbtHoldSummary].
  const SbtHoldSummaryFamily();

  /// See also [sbtHoldSummary].
  SbtHoldSummaryProvider call({
    String type = "sbt",
  }) {
    return SbtHoldSummaryProvider(
      type: type,
    );
  }

  @override
  SbtHoldSummaryProvider getProviderOverride(
    covariant SbtHoldSummaryProvider provider,
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
  String? get name => r'sbtHoldSummaryProvider';
}

/// See also [sbtHoldSummary].
class SbtHoldSummaryProvider
    extends AutoDisposeStreamProvider<SbtHoldSummaryModel> {
  /// See also [sbtHoldSummary].
  SbtHoldSummaryProvider({
    String type = "sbt",
  }) : this._internal(
          (ref) => sbtHoldSummary(
            ref as SbtHoldSummaryRef,
            type: type,
          ),
          from: sbtHoldSummaryProvider,
          name: r'sbtHoldSummaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sbtHoldSummaryHash,
          dependencies: SbtHoldSummaryFamily._dependencies,
          allTransitiveDependencies:
              SbtHoldSummaryFamily._allTransitiveDependencies,
          type: type,
        );

  SbtHoldSummaryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final String type;

  @override
  Override overrideWith(
    Stream<SbtHoldSummaryModel> Function(SbtHoldSummaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SbtHoldSummaryProvider._internal(
        (ref) => create(ref as SbtHoldSummaryRef),
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
  AutoDisposeStreamProviderElement<SbtHoldSummaryModel> createElement() {
    return _SbtHoldSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SbtHoldSummaryProvider && other.type == type;
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
mixin SbtHoldSummaryRef on AutoDisposeStreamProviderRef<SbtHoldSummaryModel> {
  /// The parameter `type` of this provider.
  String get type;
}

class _SbtHoldSummaryProviderElement
    extends AutoDisposeStreamProviderElement<SbtHoldSummaryModel>
    with SbtHoldSummaryRef {
  _SbtHoldSummaryProviderElement(super.provider);

  @override
  String get type => (origin as SbtHoldSummaryProvider).type;
}

String _$sbtHoldStatementHash() => r'5f2e7fecc9b8cfd996e11b6b2e73132fe7410566';

/// See also [sbtHoldStatement].
@ProviderFor(sbtHoldStatement)
const sbtHoldStatementProvider = SbtHoldStatementFamily();

/// See also [sbtHoldStatement].
class SbtHoldStatementFamily
    extends Family<AsyncValue<HoldStatementListModel>> {
  /// See also [sbtHoldStatement].
  const SbtHoldStatementFamily();

  /// See also [sbtHoldStatement].
  SbtHoldStatementProvider call({
    String? walletType,
  }) {
    return SbtHoldStatementProvider(
      walletType: walletType,
    );
  }

  @override
  SbtHoldStatementProvider getProviderOverride(
    covariant SbtHoldStatementProvider provider,
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
  String? get name => r'sbtHoldStatementProvider';
}

/// See also [sbtHoldStatement].
class SbtHoldStatementProvider
    extends AutoDisposeStreamProvider<HoldStatementListModel> {
  /// See also [sbtHoldStatement].
  SbtHoldStatementProvider({
    String? walletType,
  }) : this._internal(
          (ref) => sbtHoldStatement(
            ref as SbtHoldStatementRef,
            walletType: walletType,
          ),
          from: sbtHoldStatementProvider,
          name: r'sbtHoldStatementProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sbtHoldStatementHash,
          dependencies: SbtHoldStatementFamily._dependencies,
          allTransitiveDependencies:
              SbtHoldStatementFamily._allTransitiveDependencies,
          walletType: walletType,
        );

  SbtHoldStatementProvider._internal(
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
    Stream<HoldStatementListModel> Function(SbtHoldStatementRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SbtHoldStatementProvider._internal(
        (ref) => create(ref as SbtHoldStatementRef),
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
  AutoDisposeStreamProviderElement<HoldStatementListModel> createElement() {
    return _SbtHoldStatementProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SbtHoldStatementProvider && other.walletType == walletType;
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
mixin SbtHoldStatementRef
    on AutoDisposeStreamProviderRef<HoldStatementListModel> {
  /// The parameter `walletType` of this provider.
  String? get walletType;
}

class _SbtHoldStatementProviderElement
    extends AutoDisposeStreamProviderElement<HoldStatementListModel>
    with SbtHoldStatementRef {
  _SbtHoldStatementProviderElement(super.provider);

  @override
  String? get walletType => (origin as SbtHoldStatementProvider).walletType;
}

String _$holdSummaryHash() => r'a4b0f9ad6f61581e00167e40eaa4333103aa0258';

/// See also [holdSummary].
@ProviderFor(holdSummary)
const holdSummaryProvider = HoldSummaryFamily();

/// See also [holdSummary].
class HoldSummaryFamily extends Family<AsyncValue<HoldSummaryModel>> {
  /// See also [holdSummary].
  const HoldSummaryFamily();

  /// See also [holdSummary].
  HoldSummaryProvider call({
    String? type,
  }) {
    return HoldSummaryProvider(
      type: type,
    );
  }

  @override
  HoldSummaryProvider getProviderOverride(
    covariant HoldSummaryProvider provider,
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
  String? get name => r'holdSummaryProvider';
}

/// See also [holdSummary].
class HoldSummaryProvider extends AutoDisposeStreamProvider<HoldSummaryModel> {
  /// See also [holdSummary].
  HoldSummaryProvider({
    String? type,
  }) : this._internal(
          (ref) => holdSummary(
            ref as HoldSummaryRef,
            type: type,
          ),
          from: holdSummaryProvider,
          name: r'holdSummaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$holdSummaryHash,
          dependencies: HoldSummaryFamily._dependencies,
          allTransitiveDependencies:
              HoldSummaryFamily._allTransitiveDependencies,
          type: type,
        );

  HoldSummaryProvider._internal(
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
    Stream<HoldSummaryModel> Function(HoldSummaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HoldSummaryProvider._internal(
        (ref) => create(ref as HoldSummaryRef),
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
  AutoDisposeStreamProviderElement<HoldSummaryModel> createElement() {
    return _HoldSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HoldSummaryProvider && other.type == type;
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
mixin HoldSummaryRef on AutoDisposeStreamProviderRef<HoldSummaryModel> {
  /// The parameter `type` of this provider.
  String? get type;
}

class _HoldSummaryProviderElement
    extends AutoDisposeStreamProviderElement<HoldSummaryModel>
    with HoldSummaryRef {
  _HoldSummaryProviderElement(super.provider);

  @override
  String? get type => (origin as HoldSummaryProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
