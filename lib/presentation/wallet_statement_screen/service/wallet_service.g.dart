// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getWalletListHash() => r'1a78f288ff7df94ee5956fe7cc2ef92c3aec3b7b';

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

/// See also [getWalletList].
@ProviderFor(getWalletList)
const getWalletListProvider = GetWalletListFamily();

/// See also [getWalletList].
class GetWalletListFamily
    extends Family<AsyncValue<WalletTransactionListModel>> {
  /// See also [getWalletList].
  const GetWalletListFamily();

  /// See also [getWalletList].
  GetWalletListProvider call({
    required String walletType,
  }) {
    return GetWalletListProvider(
      walletType: walletType,
    );
  }

  @override
  GetWalletListProvider getProviderOverride(
    covariant GetWalletListProvider provider,
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
  String? get name => r'getWalletListProvider';
}

/// See also [getWalletList].
class GetWalletListProvider
    extends AutoDisposeStreamProvider<WalletTransactionListModel> {
  /// See also [getWalletList].
  GetWalletListProvider({
    required String walletType,
  }) : this._internal(
          (ref) => getWalletList(
            ref as GetWalletListRef,
            walletType: walletType,
          ),
          from: getWalletListProvider,
          name: r'getWalletListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getWalletListHash,
          dependencies: GetWalletListFamily._dependencies,
          allTransitiveDependencies:
              GetWalletListFamily._allTransitiveDependencies,
          walletType: walletType,
        );

  GetWalletListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.walletType,
  }) : super.internal();

  final String walletType;

  @override
  Override overrideWith(
    Stream<WalletTransactionListModel> Function(GetWalletListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetWalletListProvider._internal(
        (ref) => create(ref as GetWalletListRef),
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
  AutoDisposeStreamProviderElement<WalletTransactionListModel> createElement() {
    return _GetWalletListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetWalletListProvider && other.walletType == walletType;
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
mixin GetWalletListRef
    on AutoDisposeStreamProviderRef<WalletTransactionListModel> {
  /// The parameter `walletType` of this provider.
  String get walletType;
}

class _GetWalletListProviderElement
    extends AutoDisposeStreamProviderElement<WalletTransactionListModel>
    with GetWalletListRef {
  _GetWalletListProviderElement(super.provider);

  @override
  String get walletType => (origin as GetWalletListProvider).walletType;
}

String _$walletSummaryDataHash() => r'46f4e76eefd0e6569f0a44de76c4517ea4a83b22';

/// See also [walletSummaryData].
@ProviderFor(walletSummaryData)
const walletSummaryDataProvider = WalletSummaryDataFamily();

/// See also [walletSummaryData].
class WalletSummaryDataFamily
    extends Family<AsyncValue<WalletStatementSummaryModel>> {
  /// See also [walletSummaryData].
  const WalletSummaryDataFamily();

  /// See also [walletSummaryData].
  WalletSummaryDataProvider call({
    String? fromDate,
    String? toDate,
    required String walletType,
  }) {
    return WalletSummaryDataProvider(
      fromDate: fromDate,
      toDate: toDate,
      walletType: walletType,
    );
  }

  @override
  WalletSummaryDataProvider getProviderOverride(
    covariant WalletSummaryDataProvider provider,
  ) {
    return call(
      fromDate: provider.fromDate,
      toDate: provider.toDate,
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
  String? get name => r'walletSummaryDataProvider';
}

/// See also [walletSummaryData].
class WalletSummaryDataProvider
    extends AutoDisposeStreamProvider<WalletStatementSummaryModel> {
  /// See also [walletSummaryData].
  WalletSummaryDataProvider({
    String? fromDate,
    String? toDate,
    required String walletType,
  }) : this._internal(
          (ref) => walletSummaryData(
            ref as WalletSummaryDataRef,
            fromDate: fromDate,
            toDate: toDate,
            walletType: walletType,
          ),
          from: walletSummaryDataProvider,
          name: r'walletSummaryDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$walletSummaryDataHash,
          dependencies: WalletSummaryDataFamily._dependencies,
          allTransitiveDependencies:
              WalletSummaryDataFamily._allTransitiveDependencies,
          fromDate: fromDate,
          toDate: toDate,
          walletType: walletType,
        );

  WalletSummaryDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fromDate,
    required this.toDate,
    required this.walletType,
  }) : super.internal();

  final String? fromDate;
  final String? toDate;
  final String walletType;

  @override
  Override overrideWith(
    Stream<WalletStatementSummaryModel> Function(WalletSummaryDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WalletSummaryDataProvider._internal(
        (ref) => create(ref as WalletSummaryDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fromDate: fromDate,
        toDate: toDate,
        walletType: walletType,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<WalletStatementSummaryModel>
      createElement() {
    return _WalletSummaryDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WalletSummaryDataProvider &&
        other.fromDate == fromDate &&
        other.toDate == toDate &&
        other.walletType == walletType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fromDate.hashCode);
    hash = _SystemHash.combine(hash, toDate.hashCode);
    hash = _SystemHash.combine(hash, walletType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WalletSummaryDataRef
    on AutoDisposeStreamProviderRef<WalletStatementSummaryModel> {
  /// The parameter `fromDate` of this provider.
  String? get fromDate;

  /// The parameter `toDate` of this provider.
  String? get toDate;

  /// The parameter `walletType` of this provider.
  String get walletType;
}

class _WalletSummaryDataProviderElement
    extends AutoDisposeStreamProviderElement<WalletStatementSummaryModel>
    with WalletSummaryDataRef {
  _WalletSummaryDataProviderElement(super.provider);

  @override
  String? get fromDate => (origin as WalletSummaryDataProvider).fromDate;
  @override
  String? get toDate => (origin as WalletSummaryDataProvider).toDate;
  @override
  String get walletType => (origin as WalletSummaryDataProvider).walletType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
