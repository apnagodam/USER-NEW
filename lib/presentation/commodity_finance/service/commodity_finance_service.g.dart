// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity_finance_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFinanceListHash() => r'7f1e18cd6ff1b92b16d1f02868d432f324a2b1b0';

/// See also [getFinanceList].
@ProviderFor(getFinanceList)
final getFinanceListProvider =
    AutoDisposeStreamProvider<CommodityFinanceListModel>.internal(
  getFinanceList,
  name: r'getFinanceListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getFinanceListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetFinanceListRef
    = AutoDisposeStreamProviderRef<CommodityFinanceListModel>;
String _$financeBanksListHash() => r'c65c9963ac905ec7c80ab8e3a2d62a105e1abeb3';

/// See also [financeBanksList].
@ProviderFor(financeBanksList)
final financeBanksListProvider =
    AutoDisposeStreamProvider<FinanceBankListResponse>.internal(
  financeBanksList,
  name: r'financeBanksListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$financeBanksListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FinanceBanksListRef
    = AutoDisposeStreamProviderRef<FinanceBankListResponse>;
String _$checkSanctionLimitHash() =>
    r'92c6ce743779ebef129f27c3083cd9a180c5ad76';

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

/// See also [checkSanctionLimit].
@ProviderFor(checkSanctionLimit)
const checkSanctionLimitProvider = CheckSanctionLimitFamily();

/// See also [checkSanctionLimit].
class CheckSanctionLimitFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [checkSanctionLimit].
  const CheckSanctionLimitFamily();

  /// See also [checkSanctionLimit].
  CheckSanctionLimitProvider call({
    String? bankId = "",
  }) {
    return CheckSanctionLimitProvider(
      bankId: bankId,
    );
  }

  @override
  CheckSanctionLimitProvider getProviderOverride(
    covariant CheckSanctionLimitProvider provider,
  ) {
    return call(
      bankId: provider.bankId,
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
  String? get name => r'checkSanctionLimitProvider';
}

/// See also [checkSanctionLimit].
class CheckSanctionLimitProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [checkSanctionLimit].
  CheckSanctionLimitProvider({
    String? bankId = "",
  }) : this._internal(
          (ref) => checkSanctionLimit(
            ref as CheckSanctionLimitRef,
            bankId: bankId,
          ),
          from: checkSanctionLimitProvider,
          name: r'checkSanctionLimitProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkSanctionLimitHash,
          dependencies: CheckSanctionLimitFamily._dependencies,
          allTransitiveDependencies:
              CheckSanctionLimitFamily._allTransitiveDependencies,
          bankId: bankId,
        );

  CheckSanctionLimitProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bankId,
  }) : super.internal();

  final String? bankId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(CheckSanctionLimitRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckSanctionLimitProvider._internal(
        (ref) => create(ref as CheckSanctionLimitRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bankId: bankId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _CheckSanctionLimitProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckSanctionLimitProvider && other.bankId == bankId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bankId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckSanctionLimitRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `bankId` of this provider.
  String? get bankId;
}

class _CheckSanctionLimitProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with CheckSanctionLimitRef {
  _CheckSanctionLimitProviderElement(super.provider);

  @override
  String? get bankId => (origin as CheckSanctionLimitProvider).bankId;
}

String _$applySenctionLimitHash() =>
    r'4738f4d01fd446e4ade2f77dd12f653064c97e48';

/// See also [applySenctionLimit].
@ProviderFor(applySenctionLimit)
const applySenctionLimitProvider = ApplySenctionLimitFamily();

/// See also [applySenctionLimit].
class ApplySenctionLimitFamily extends Family<AsyncValue<BaseResponseModel>> {
  /// See also [applySenctionLimit].
  const ApplySenctionLimitFamily();

  /// See also [applySenctionLimit].
  ApplySenctionLimitProvider call({
    String? bankId = "",
    String? requestedAmount = "",
  }) {
    return ApplySenctionLimitProvider(
      bankId: bankId,
      requestedAmount: requestedAmount,
    );
  }

  @override
  ApplySenctionLimitProvider getProviderOverride(
    covariant ApplySenctionLimitProvider provider,
  ) {
    return call(
      bankId: provider.bankId,
      requestedAmount: provider.requestedAmount,
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
  String? get name => r'applySenctionLimitProvider';
}

/// See also [applySenctionLimit].
class ApplySenctionLimitProvider
    extends AutoDisposeFutureProvider<BaseResponseModel> {
  /// See also [applySenctionLimit].
  ApplySenctionLimitProvider({
    String? bankId = "",
    String? requestedAmount = "",
  }) : this._internal(
          (ref) => applySenctionLimit(
            ref as ApplySenctionLimitRef,
            bankId: bankId,
            requestedAmount: requestedAmount,
          ),
          from: applySenctionLimitProvider,
          name: r'applySenctionLimitProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$applySenctionLimitHash,
          dependencies: ApplySenctionLimitFamily._dependencies,
          allTransitiveDependencies:
              ApplySenctionLimitFamily._allTransitiveDependencies,
          bankId: bankId,
          requestedAmount: requestedAmount,
        );

  ApplySenctionLimitProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bankId,
    required this.requestedAmount,
  }) : super.internal();

  final String? bankId;
  final String? requestedAmount;

  @override
  Override overrideWith(
    FutureOr<BaseResponseModel> Function(ApplySenctionLimitRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApplySenctionLimitProvider._internal(
        (ref) => create(ref as ApplySenctionLimitRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bankId: bankId,
        requestedAmount: requestedAmount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseModel> createElement() {
    return _ApplySenctionLimitProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApplySenctionLimitProvider &&
        other.bankId == bankId &&
        other.requestedAmount == requestedAmount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bankId.hashCode);
    hash = _SystemHash.combine(hash, requestedAmount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ApplySenctionLimitRef on AutoDisposeFutureProviderRef<BaseResponseModel> {
  /// The parameter `bankId` of this provider.
  String? get bankId;

  /// The parameter `requestedAmount` of this provider.
  String? get requestedAmount;
}

class _ApplySenctionLimitProviderElement
    extends AutoDisposeFutureProviderElement<BaseResponseModel>
    with ApplySenctionLimitRef {
  _ApplySenctionLimitProviderElement(super.provider);

  @override
  String? get bankId => (origin as ApplySenctionLimitProvider).bankId;
  @override
  String? get requestedAmount =>
      (origin as ApplySenctionLimitProvider).requestedAmount;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
