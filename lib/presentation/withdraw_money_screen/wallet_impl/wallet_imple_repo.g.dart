// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_imple_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getWalletListHash() => r'01d3cb8c8633840a0a53a948404b5b796687d929';

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
class GetWalletListFamily extends Family<AsyncValue<WalletWithdrawlModel>> {
  /// See also [getWalletList].
  const GetWalletListFamily();

  /// See also [getWalletList].
  GetWalletListProvider call({
    required String? walletType,
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
    extends AutoDisposeStreamProvider<WalletWithdrawlModel> {
  /// See also [getWalletList].
  GetWalletListProvider({
    required String? walletType,
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

  final String? walletType;

  @override
  Override overrideWith(
    Stream<WalletWithdrawlModel> Function(GetWalletListRef provider) create,
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
  AutoDisposeStreamProviderElement<WalletWithdrawlModel> createElement() {
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
mixin GetWalletListRef on AutoDisposeStreamProviderRef<WalletWithdrawlModel> {
  /// The parameter `walletType` of this provider.
  String? get walletType;
}

class _GetWalletListProviderElement
    extends AutoDisposeStreamProviderElement<WalletWithdrawlModel>
    with GetWalletListRef {
  _GetWalletListProviderElement(super.provider);

  @override
  String? get walletType => (origin as GetWalletListProvider).walletType;
}

String _$withdrawMoneyHash() => r'a12a5da9389285dc3beb96397df817575b3a3f4b';

/// See also [withdrawMoney].
@ProviderFor(withdrawMoney)
const withdrawMoneyProvider = WithdrawMoneyFamily();

/// See also [withdrawMoney].
class WithdrawMoneyFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [withdrawMoney].
  const WithdrawMoneyFamily();

  /// See also [withdrawMoney].
  WithdrawMoneyProvider call({
    String? requestAmount,
    String? walletType,
  }) {
    return WithdrawMoneyProvider(
      requestAmount: requestAmount,
      walletType: walletType,
    );
  }

  @override
  WithdrawMoneyProvider getProviderOverride(
    covariant WithdrawMoneyProvider provider,
  ) {
    return call(
      requestAmount: provider.requestAmount,
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
  String? get name => r'withdrawMoneyProvider';
}

/// See also [withdrawMoney].
class WithdrawMoneyProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [withdrawMoney].
  WithdrawMoneyProvider({
    String? requestAmount,
    String? walletType,
  }) : this._internal(
          (ref) => withdrawMoney(
            ref as WithdrawMoneyRef,
            requestAmount: requestAmount,
            walletType: walletType,
          ),
          from: withdrawMoneyProvider,
          name: r'withdrawMoneyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$withdrawMoneyHash,
          dependencies: WithdrawMoneyFamily._dependencies,
          allTransitiveDependencies:
              WithdrawMoneyFamily._allTransitiveDependencies,
          requestAmount: requestAmount,
          walletType: walletType,
        );

  WithdrawMoneyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.requestAmount,
    required this.walletType,
  }) : super.internal();

  final String? requestAmount;
  final String? walletType;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(WithdrawMoneyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WithdrawMoneyProvider._internal(
        (ref) => create(ref as WithdrawMoneyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        requestAmount: requestAmount,
        walletType: walletType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _WithdrawMoneyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WithdrawMoneyProvider &&
        other.requestAmount == requestAmount &&
        other.walletType == walletType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, requestAmount.hashCode);
    hash = _SystemHash.combine(hash, walletType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WithdrawMoneyRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `requestAmount` of this provider.
  String? get requestAmount;

  /// The parameter `walletType` of this provider.
  String? get walletType;
}

class _WithdrawMoneyProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with WithdrawMoneyRef {
  _WithdrawMoneyProviderElement(super.provider);

  @override
  String? get requestAmount => (origin as WithdrawMoneyProvider).requestAmount;
  @override
  String? get walletType => (origin as WithdrawMoneyProvider).walletType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
