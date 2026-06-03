// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getInvoicePdfHash() => r'eda44476f47c5b6d0681995dc6d28aabe2799b79';

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

/// See also [getInvoicePdf].
@ProviderFor(getInvoicePdf)
const getInvoicePdfProvider = GetInvoicePdfFamily();

/// See also [getInvoicePdf].
class GetInvoicePdfFamily extends Family<AsyncValue<InvoicesPdfModel>> {
  /// See also [getInvoicePdf].
  const GetInvoicePdfFamily();

  /// See also [getInvoicePdf].
  GetInvoicePdfProvider call({
    required String? invoiceId,
  }) {
    return GetInvoicePdfProvider(
      invoiceId: invoiceId,
    );
  }

  @override
  GetInvoicePdfProvider getProviderOverride(
    covariant GetInvoicePdfProvider provider,
  ) {
    return call(
      invoiceId: provider.invoiceId,
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
  String? get name => r'getInvoicePdfProvider';
}

/// See also [getInvoicePdf].
class GetInvoicePdfProvider
    extends AutoDisposeFutureProvider<InvoicesPdfModel> {
  /// See also [getInvoicePdf].
  GetInvoicePdfProvider({
    required String? invoiceId,
  }) : this._internal(
          (ref) => getInvoicePdf(
            ref as GetInvoicePdfRef,
            invoiceId: invoiceId,
          ),
          from: getInvoicePdfProvider,
          name: r'getInvoicePdfProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getInvoicePdfHash,
          dependencies: GetInvoicePdfFamily._dependencies,
          allTransitiveDependencies:
              GetInvoicePdfFamily._allTransitiveDependencies,
          invoiceId: invoiceId,
        );

  GetInvoicePdfProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.invoiceId,
  }) : super.internal();

  final String? invoiceId;

  @override
  Override overrideWith(
    FutureOr<InvoicesPdfModel> Function(GetInvoicePdfRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetInvoicePdfProvider._internal(
        (ref) => create(ref as GetInvoicePdfRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        invoiceId: invoiceId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<InvoicesPdfModel> createElement() {
    return _GetInvoicePdfProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetInvoicePdfProvider && other.invoiceId == invoiceId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, invoiceId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetInvoicePdfRef on AutoDisposeFutureProviderRef<InvoicesPdfModel> {
  /// The parameter `invoiceId` of this provider.
  String? get invoiceId;
}

class _GetInvoicePdfProviderElement
    extends AutoDisposeFutureProviderElement<InvoicesPdfModel>
    with GetInvoicePdfRef {
  _GetInvoicePdfProviderElement(super.provider);

  @override
  String? get invoiceId => (origin as GetInvoicePdfProvider).invoiceId;
}

String _$getInvoicesHash() => r'191f0f3f4003bfd44b18e7442c9746bb8bc49769';

/// See also [getInvoices].
@ProviderFor(getInvoices)
const getInvoicesProvider = GetInvoicesFamily();

/// See also [getInvoices].
class GetInvoicesFamily extends Family<AsyncValue<InvoicesModel>> {
  /// See also [getInvoices].
  const GetInvoicesFamily();

  /// See also [getInvoices].
  GetInvoicesProvider call({
    required String? type,
  }) {
    return GetInvoicesProvider(
      type: type,
    );
  }

  @override
  GetInvoicesProvider getProviderOverride(
    covariant GetInvoicesProvider provider,
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
  String? get name => r'getInvoicesProvider';
}

/// See also [getInvoices].
class GetInvoicesProvider extends AutoDisposeFutureProvider<InvoicesModel> {
  /// See also [getInvoices].
  GetInvoicesProvider({
    required String? type,
  }) : this._internal(
          (ref) => getInvoices(
            ref as GetInvoicesRef,
            type: type,
          ),
          from: getInvoicesProvider,
          name: r'getInvoicesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getInvoicesHash,
          dependencies: GetInvoicesFamily._dependencies,
          allTransitiveDependencies:
              GetInvoicesFamily._allTransitiveDependencies,
          type: type,
        );

  GetInvoicesProvider._internal(
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
    FutureOr<InvoicesModel> Function(GetInvoicesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetInvoicesProvider._internal(
        (ref) => create(ref as GetInvoicesRef),
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
  AutoDisposeFutureProviderElement<InvoicesModel> createElement() {
    return _GetInvoicesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetInvoicesProvider && other.type == type;
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
mixin GetInvoicesRef on AutoDisposeFutureProviderRef<InvoicesModel> {
  /// The parameter `type` of this provider.
  String? get type;
}

class _GetInvoicesProviderElement
    extends AutoDisposeFutureProviderElement<InvoicesModel>
    with GetInvoicesRef {
  _GetInvoicesProviderElement(super.provider);

  @override
  String? get type => (origin as GetInvoicesProvider).type;
}

String _$homeDataHash() => r'3708ef8148207526c92ad60046f3ed19475869a0';

/// See also [homeData].
@ProviderFor(homeData)
final homeDataProvider = AutoDisposeStreamProvider<HomeResponseModel>.internal(
  homeData,
  name: r'homeDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$homeDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeDataRef = AutoDisposeStreamProviderRef<HomeResponseModel>;
String _$getGraphDataHash() => r'381c90857d1808fb077b5b9cf328e8a0601e9f8d';

/// See also [getGraphData].
@ProviderFor(getGraphData)
const getGraphDataProvider = GetGraphDataFamily();

/// See also [getGraphData].
class GetGraphDataFamily extends Family<AsyncValue<GraphModel>> {
  /// See also [getGraphData].
  const GetGraphDataFamily();

  /// See also [getGraphData].
  GetGraphDataProvider call({
    String? id,
  }) {
    return GetGraphDataProvider(
      id: id,
    );
  }

  @override
  GetGraphDataProvider getProviderOverride(
    covariant GetGraphDataProvider provider,
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
  String? get name => r'getGraphDataProvider';
}

/// See also [getGraphData].
class GetGraphDataProvider extends AutoDisposeFutureProvider<GraphModel> {
  /// See also [getGraphData].
  GetGraphDataProvider({
    String? id,
  }) : this._internal(
          (ref) => getGraphData(
            ref as GetGraphDataRef,
            id: id,
          ),
          from: getGraphDataProvider,
          name: r'getGraphDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getGraphDataHash,
          dependencies: GetGraphDataFamily._dependencies,
          allTransitiveDependencies:
              GetGraphDataFamily._allTransitiveDependencies,
          id: id,
        );

  GetGraphDataProvider._internal(
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
    FutureOr<GraphModel> Function(GetGraphDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetGraphDataProvider._internal(
        (ref) => create(ref as GetGraphDataRef),
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
  AutoDisposeFutureProviderElement<GraphModel> createElement() {
    return _GetGraphDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetGraphDataProvider && other.id == id;
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
mixin GetGraphDataRef on AutoDisposeFutureProviderRef<GraphModel> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _GetGraphDataProviderElement
    extends AutoDisposeFutureProviderElement<GraphModel> with GetGraphDataRef {
  _GetGraphDataProviderElement(super.provider);

  @override
  String? get id => (origin as GetGraphDataProvider).id;
}

String _$terminalListHash() => r'ada26cb9b70f9f237137deb18476341327cb88af';

/// See also [terminalList].
@ProviderFor(terminalList)
final terminalListProvider = AutoDisposeFutureProvider<TerminalsModel>.internal(
  terminalList,
  name: r'terminalListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$terminalListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TerminalListRef = AutoDisposeFutureProviderRef<TerminalsModel>;
String _$bnplListHash() => r'2c970ec74f42d6c81aad861e37a62882f926b3d7';

/// See also [bnplList].
@ProviderFor(bnplList)
final bnplListProvider = AutoDisposeStreamProvider<BnplListModel>.internal(
  bnplList,
  name: r'bnplListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$bnplListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BnplListRef = AutoDisposeStreamProviderRef<BnplListModel>;
String _$bnplAddRequestHash() => r'7b5bdbbcefcdaa18a08fad020c334a551c12e8fe';

/// See also [bnplAddRequest].
@ProviderFor(bnplAddRequest)
const bnplAddRequestProvider = BnplAddRequestFamily();

/// See also [bnplAddRequest].
class BnplAddRequestFamily extends Family<AsyncValue<dynamic>> {
  /// See also [bnplAddRequest].
  const BnplAddRequestFamily();

  /// See also [bnplAddRequest].
  BnplAddRequestProvider call({
    String? requestAmount,
  }) {
    return BnplAddRequestProvider(
      requestAmount: requestAmount,
    );
  }

  @override
  BnplAddRequestProvider getProviderOverride(
    covariant BnplAddRequestProvider provider,
  ) {
    return call(
      requestAmount: provider.requestAmount,
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
  String? get name => r'bnplAddRequestProvider';
}

/// See also [bnplAddRequest].
class BnplAddRequestProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [bnplAddRequest].
  BnplAddRequestProvider({
    String? requestAmount,
  }) : this._internal(
          (ref) => bnplAddRequest(
            ref as BnplAddRequestRef,
            requestAmount: requestAmount,
          ),
          from: bnplAddRequestProvider,
          name: r'bnplAddRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bnplAddRequestHash,
          dependencies: BnplAddRequestFamily._dependencies,
          allTransitiveDependencies:
              BnplAddRequestFamily._allTransitiveDependencies,
          requestAmount: requestAmount,
        );

  BnplAddRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.requestAmount,
  }) : super.internal();

  final String? requestAmount;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(BnplAddRequestRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BnplAddRequestProvider._internal(
        (ref) => create(ref as BnplAddRequestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        requestAmount: requestAmount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _BnplAddRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BnplAddRequestProvider &&
        other.requestAmount == requestAmount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, requestAmount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BnplAddRequestRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `requestAmount` of this provider.
  String? get requestAmount;
}

class _BnplAddRequestProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with BnplAddRequestRef {
  _BnplAddRequestProviderElement(super.provider);

  @override
  String? get requestAmount => (origin as BnplAddRequestProvider).requestAmount;
}

String _$bnplDeleteRequestHash() => r'0a74720790e4e6133e9064c8dbdc951339f997cd';

/// See also [bnplDeleteRequest].
@ProviderFor(bnplDeleteRequest)
const bnplDeleteRequestProvider = BnplDeleteRequestFamily();

/// See also [bnplDeleteRequest].
class BnplDeleteRequestFamily extends Family<AsyncValue<dynamic>> {
  /// See also [bnplDeleteRequest].
  const BnplDeleteRequestFamily();

  /// See also [bnplDeleteRequest].
  BnplDeleteRequestProvider call({
    String? id,
  }) {
    return BnplDeleteRequestProvider(
      id: id,
    );
  }

  @override
  BnplDeleteRequestProvider getProviderOverride(
    covariant BnplDeleteRequestProvider provider,
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
  String? get name => r'bnplDeleteRequestProvider';
}

/// See also [bnplDeleteRequest].
class BnplDeleteRequestProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [bnplDeleteRequest].
  BnplDeleteRequestProvider({
    String? id,
  }) : this._internal(
          (ref) => bnplDeleteRequest(
            ref as BnplDeleteRequestRef,
            id: id,
          ),
          from: bnplDeleteRequestProvider,
          name: r'bnplDeleteRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bnplDeleteRequestHash,
          dependencies: BnplDeleteRequestFamily._dependencies,
          allTransitiveDependencies:
              BnplDeleteRequestFamily._allTransitiveDependencies,
          id: id,
        );

  BnplDeleteRequestProvider._internal(
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
    FutureOr<dynamic> Function(BnplDeleteRequestRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BnplDeleteRequestProvider._internal(
        (ref) => create(ref as BnplDeleteRequestRef),
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
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _BnplDeleteRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BnplDeleteRequestProvider && other.id == id;
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
mixin BnplDeleteRequestRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _BnplDeleteRequestProviderElement
    extends AutoDisposeFutureProviderElement<dynamic>
    with BnplDeleteRequestRef {
  _BnplDeleteRequestProviderElement(super.provider);

  @override
  String? get id => (origin as BnplDeleteRequestProvider).id;
}

String _$apnaFinanceListHash() => r'3d052ac22fe137f6a3d98aee697bc068c6a9584d';

/// See also [apnaFinanceList].
@ProviderFor(apnaFinanceList)
const apnaFinanceListProvider = ApnaFinanceListFamily();

/// See also [apnaFinanceList].
class ApnaFinanceListFamily extends Family<AsyncValue<AnpnaFinanceListModel>> {
  /// See also [apnaFinanceList].
  const ApnaFinanceListFamily();

  /// See also [apnaFinanceList].
  ApnaFinanceListProvider call({
    String? search,
  }) {
    return ApnaFinanceListProvider(
      search: search,
    );
  }

  @override
  ApnaFinanceListProvider getProviderOverride(
    covariant ApnaFinanceListProvider provider,
  ) {
    return call(
      search: provider.search,
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
  String? get name => r'apnaFinanceListProvider';
}

/// See also [apnaFinanceList].
class ApnaFinanceListProvider
    extends AutoDisposeFutureProvider<AnpnaFinanceListModel> {
  /// See also [apnaFinanceList].
  ApnaFinanceListProvider({
    String? search,
  }) : this._internal(
          (ref) => apnaFinanceList(
            ref as ApnaFinanceListRef,
            search: search,
          ),
          from: apnaFinanceListProvider,
          name: r'apnaFinanceListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$apnaFinanceListHash,
          dependencies: ApnaFinanceListFamily._dependencies,
          allTransitiveDependencies:
              ApnaFinanceListFamily._allTransitiveDependencies,
          search: search,
        );

  ApnaFinanceListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.search,
  }) : super.internal();

  final String? search;

  @override
  Override overrideWith(
    FutureOr<AnpnaFinanceListModel> Function(ApnaFinanceListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApnaFinanceListProvider._internal(
        (ref) => create(ref as ApnaFinanceListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        search: search,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AnpnaFinanceListModel> createElement() {
    return _ApnaFinanceListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApnaFinanceListProvider && other.search == search;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ApnaFinanceListRef
    on AutoDisposeFutureProviderRef<AnpnaFinanceListModel> {
  /// The parameter `search` of this provider.
  String? get search;
}

class _ApnaFinanceListProviderElement
    extends AutoDisposeFutureProviderElement<AnpnaFinanceListModel>
    with ApnaFinanceListRef {
  _ApnaFinanceListProviderElement(super.provider);

  @override
  String? get search => (origin as ApnaFinanceListProvider).search;
}

String _$applyForLoanHash() => r'186f1157b10770cb6347f64a98b66366016c51e2';

/// See also [applyForLoan].
@ProviderFor(applyForLoan)
const applyForLoanProvider = ApplyForLoanFamily();

/// See also [applyForLoan].
class ApplyForLoanFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [applyForLoan].
  const ApplyForLoanFamily();

  /// See also [applyForLoan].
  ApplyForLoanProvider call({
    String? inventoryId,
    String? bankId,
    String? quantity,
    String? disbursement,
    String? loanAmount,
  }) {
    return ApplyForLoanProvider(
      inventoryId: inventoryId,
      bankId: bankId,
      quantity: quantity,
      disbursement: disbursement,
      loanAmount: loanAmount,
    );
  }

  @override
  ApplyForLoanProvider getProviderOverride(
    covariant ApplyForLoanProvider provider,
  ) {
    return call(
      inventoryId: provider.inventoryId,
      bankId: provider.bankId,
      quantity: provider.quantity,
      disbursement: provider.disbursement,
      loanAmount: provider.loanAmount,
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
  String? get name => r'applyForLoanProvider';
}

/// See also [applyForLoan].
class ApplyForLoanProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [applyForLoan].
  ApplyForLoanProvider({
    String? inventoryId,
    String? bankId,
    String? quantity,
    String? disbursement,
    String? loanAmount,
  }) : this._internal(
          (ref) => applyForLoan(
            ref as ApplyForLoanRef,
            inventoryId: inventoryId,
            bankId: bankId,
            quantity: quantity,
            disbursement: disbursement,
            loanAmount: loanAmount,
          ),
          from: applyForLoanProvider,
          name: r'applyForLoanProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$applyForLoanHash,
          dependencies: ApplyForLoanFamily._dependencies,
          allTransitiveDependencies:
              ApplyForLoanFamily._allTransitiveDependencies,
          inventoryId: inventoryId,
          bankId: bankId,
          quantity: quantity,
          disbursement: disbursement,
          loanAmount: loanAmount,
        );

  ApplyForLoanProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.inventoryId,
    required this.bankId,
    required this.quantity,
    required this.disbursement,
    required this.loanAmount,
  }) : super.internal();

  final String? inventoryId;
  final String? bankId;
  final String? quantity;
  final String? disbursement;
  final String? loanAmount;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(ApplyForLoanRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApplyForLoanProvider._internal(
        (ref) => create(ref as ApplyForLoanRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        inventoryId: inventoryId,
        bankId: bankId,
        quantity: quantity,
        disbursement: disbursement,
        loanAmount: loanAmount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _ApplyForLoanProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApplyForLoanProvider &&
        other.inventoryId == inventoryId &&
        other.bankId == bankId &&
        other.quantity == quantity &&
        other.disbursement == disbursement &&
        other.loanAmount == loanAmount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, inventoryId.hashCode);
    hash = _SystemHash.combine(hash, bankId.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, disbursement.hashCode);
    hash = _SystemHash.combine(hash, loanAmount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ApplyForLoanRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `inventoryId` of this provider.
  String? get inventoryId;

  /// The parameter `bankId` of this provider.
  String? get bankId;

  /// The parameter `quantity` of this provider.
  String? get quantity;

  /// The parameter `disbursement` of this provider.
  String? get disbursement;

  /// The parameter `loanAmount` of this provider.
  String? get loanAmount;
}

class _ApplyForLoanProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with ApplyForLoanRef {
  _ApplyForLoanProviderElement(super.provider);

  @override
  String? get inventoryId => (origin as ApplyForLoanProvider).inventoryId;
  @override
  String? get bankId => (origin as ApplyForLoanProvider).bankId;
  @override
  String? get quantity => (origin as ApplyForLoanProvider).quantity;
  @override
  String? get disbursement => (origin as ApplyForLoanProvider).disbursement;
  @override
  String? get loanAmount => (origin as ApplyForLoanProvider).loanAmount;
}

String _$signUpUserOtpHash() => r'454790f68f86659f730552aa4cc498d538de9932';

/// See also [signUpUserOtp].
@ProviderFor(signUpUserOtp)
const signUpUserOtpProvider = SignUpUserOtpFamily();

/// See also [signUpUserOtp].
class SignUpUserOtpFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [signUpUserOtp].
  const SignUpUserOtpFamily();

  /// See also [signUpUserOtp].
  SignUpUserOtpProvider call({
    String? number,
    String? otp,
  }) {
    return SignUpUserOtpProvider(
      number: number,
      otp: otp,
    );
  }

  @override
  SignUpUserOtpProvider getProviderOverride(
    covariant SignUpUserOtpProvider provider,
  ) {
    return call(
      number: provider.number,
      otp: provider.otp,
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
  String? get name => r'signUpUserOtpProvider';
}

/// See also [signUpUserOtp].
class SignUpUserOtpProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [signUpUserOtp].
  SignUpUserOtpProvider({
    String? number,
    String? otp,
  }) : this._internal(
          (ref) => signUpUserOtp(
            ref as SignUpUserOtpRef,
            number: number,
            otp: otp,
          ),
          from: signUpUserOtpProvider,
          name: r'signUpUserOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$signUpUserOtpHash,
          dependencies: SignUpUserOtpFamily._dependencies,
          allTransitiveDependencies:
              SignUpUserOtpFamily._allTransitiveDependencies,
          number: number,
          otp: otp,
        );

  SignUpUserOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
    required this.otp,
  }) : super.internal();

  final String? number;
  final String? otp;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(SignUpUserOtpRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SignUpUserOtpProvider._internal(
        (ref) => create(ref as SignUpUserOtpRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        number: number,
        otp: otp,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SignUpUserOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SignUpUserOtpProvider &&
        other.number == number &&
        other.otp == otp;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);
    hash = _SystemHash.combine(hash, otp.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SignUpUserOtpRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `number` of this provider.
  String? get number;

  /// The parameter `otp` of this provider.
  String? get otp;
}

class _SignUpUserOtpProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SignUpUserOtpRef {
  _SignUpUserOtpProviderElement(super.provider);

  @override
  String? get number => (origin as SignUpUserOtpProvider).number;
  @override
  String? get otp => (origin as SignUpUserOtpProvider).otp;
}

String _$signUpUserHash() => r'aeaffed1d911fbae681ab30d87da597bdab4399d';

/// See also [signUpUser].
@ProviderFor(signUpUser)
const signUpUserProvider = SignUpUserFamily();

/// See also [signUpUser].
class SignUpUserFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [signUpUser].
  const SignUpUserFamily();

  /// See also [signUpUser].
  SignUpUserProvider call({
    String? number,
    String? userName,
    String? constitutionType,
  }) {
    return SignUpUserProvider(
      number: number,
      userName: userName,
      constitutionType: constitutionType,
    );
  }

  @override
  SignUpUserProvider getProviderOverride(
    covariant SignUpUserProvider provider,
  ) {
    return call(
      number: provider.number,
      userName: provider.userName,
      constitutionType: provider.constitutionType,
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
  String? get name => r'signUpUserProvider';
}

/// See also [signUpUser].
class SignUpUserProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [signUpUser].
  SignUpUserProvider({
    String? number,
    String? userName,
    String? constitutionType,
  }) : this._internal(
          (ref) => signUpUser(
            ref as SignUpUserRef,
            number: number,
            userName: userName,
            constitutionType: constitutionType,
          ),
          from: signUpUserProvider,
          name: r'signUpUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$signUpUserHash,
          dependencies: SignUpUserFamily._dependencies,
          allTransitiveDependencies:
              SignUpUserFamily._allTransitiveDependencies,
          number: number,
          userName: userName,
          constitutionType: constitutionType,
        );

  SignUpUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
    required this.userName,
    required this.constitutionType,
  }) : super.internal();

  final String? number;
  final String? userName;
  final String? constitutionType;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(SignUpUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SignUpUserProvider._internal(
        (ref) => create(ref as SignUpUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        number: number,
        userName: userName,
        constitutionType: constitutionType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SignUpUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SignUpUserProvider &&
        other.number == number &&
        other.userName == userName &&
        other.constitutionType == constitutionType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);
    hash = _SystemHash.combine(hash, userName.hashCode);
    hash = _SystemHash.combine(hash, constitutionType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SignUpUserRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `number` of this provider.
  String? get number;

  /// The parameter `userName` of this provider.
  String? get userName;

  /// The parameter `constitutionType` of this provider.
  String? get constitutionType;
}

class _SignUpUserProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SignUpUserRef {
  _SignUpUserProviderElement(super.provider);

  @override
  String? get number => (origin as SignUpUserProvider).number;
  @override
  String? get userName => (origin as SignUpUserProvider).userName;
  @override
  String? get constitutionType =>
      (origin as SignUpUserProvider).constitutionType;
}

String _$summaryDataHash() => r'70e18afb498017c6d86971922fea7e5aa0cbe4cd';

/// See also [summaryData].
@ProviderFor(summaryData)
final summaryDataProvider =
    AutoDisposeStreamProvider<SummaryCommodityModel>.internal(
  summaryData,
  name: r'summaryDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$summaryDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SummaryDataRef = AutoDisposeStreamProviderRef<SummaryCommodityModel>;
String _$userSummaryDataHash() => r'635736c4071df73cdbc47c6d4db01196a53ad7c6';

/// See also [userSummaryData].
@ProviderFor(userSummaryData)
final userSummaryDataProvider =
    AutoDisposeStreamProvider<SummaryFilterResponseModel>.internal(
  userSummaryData,
  name: r'userSummaryDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userSummaryDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserSummaryDataRef
    = AutoDisposeStreamProviderRef<SummaryFilterResponseModel>;
String _$financeTermDataHash() => r'f5ae0437de336846260ba88ded14dcf61fb2dfa7';

/// See also [financeTermData].
@ProviderFor(financeTermData)
const financeTermDataProvider = FinanceTermDataFamily();

/// See also [financeTermData].
class FinanceTermDataFamily extends Family<AsyncValue<FinanceTermModel>> {
  /// See also [financeTermData].
  const FinanceTermDataFamily();

  /// See also [financeTermData].
  FinanceTermDataProvider call({
    String? bankId,
    String? inventoryId,
  }) {
    return FinanceTermDataProvider(
      bankId: bankId,
      inventoryId: inventoryId,
    );
  }

  @override
  FinanceTermDataProvider getProviderOverride(
    covariant FinanceTermDataProvider provider,
  ) {
    return call(
      bankId: provider.bankId,
      inventoryId: provider.inventoryId,
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
  String? get name => r'financeTermDataProvider';
}

/// See also [financeTermData].
class FinanceTermDataProvider
    extends AutoDisposeFutureProvider<FinanceTermModel> {
  /// See also [financeTermData].
  FinanceTermDataProvider({
    String? bankId,
    String? inventoryId,
  }) : this._internal(
          (ref) => financeTermData(
            ref as FinanceTermDataRef,
            bankId: bankId,
            inventoryId: inventoryId,
          ),
          from: financeTermDataProvider,
          name: r'financeTermDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$financeTermDataHash,
          dependencies: FinanceTermDataFamily._dependencies,
          allTransitiveDependencies:
              FinanceTermDataFamily._allTransitiveDependencies,
          bankId: bankId,
          inventoryId: inventoryId,
        );

  FinanceTermDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bankId,
    required this.inventoryId,
  }) : super.internal();

  final String? bankId;
  final String? inventoryId;

  @override
  Override overrideWith(
    FutureOr<FinanceTermModel> Function(FinanceTermDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FinanceTermDataProvider._internal(
        (ref) => create(ref as FinanceTermDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bankId: bankId,
        inventoryId: inventoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FinanceTermModel> createElement() {
    return _FinanceTermDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FinanceTermDataProvider &&
        other.bankId == bankId &&
        other.inventoryId == inventoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bankId.hashCode);
    hash = _SystemHash.combine(hash, inventoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FinanceTermDataRef on AutoDisposeFutureProviderRef<FinanceTermModel> {
  /// The parameter `bankId` of this provider.
  String? get bankId;

  /// The parameter `inventoryId` of this provider.
  String? get inventoryId;
}

class _FinanceTermDataProviderElement
    extends AutoDisposeFutureProviderElement<FinanceTermModel>
    with FinanceTermDataRef {
  _FinanceTermDataProviderElement(super.provider);

  @override
  String? get bankId => (origin as FinanceTermDataProvider).bankId;
  @override
  String? get inventoryId => (origin as FinanceTermDataProvider).inventoryId;
}

String _$indexDataHash() => r'479af535078ce2dba18e0ca80d00b41c40781708';

/// See also [indexData].
@ProviderFor(indexData)
final indexDataProvider = FutureProvider<IndexDataModel>.internal(
  indexData,
  name: r'indexDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$indexDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IndexDataRef = FutureProviderRef<IndexDataModel>;
String _$uploadKycImagesHash() => r'04b9da5b052cc9ed50098b8bd17657bd316e2819';

/// See also [uploadKycImages].
@ProviderFor(uploadKycImages)
const uploadKycImagesProvider = UploadKycImagesFamily();

/// See also [uploadKycImages].
class UploadKycImagesFamily extends Family<AsyncValue<BaseResponseModel>> {
  /// See also [uploadKycImages].
  const UploadKycImagesFamily();

  /// See also [uploadKycImages].
  UploadKycImagesProvider call({
    File? profile,
    File? passbook,
    File? panCard,
    File? gst,
    File? aadhar,
    File? aadharBack,
  }) {
    return UploadKycImagesProvider(
      profile: profile,
      passbook: passbook,
      panCard: panCard,
      gst: gst,
      aadhar: aadhar,
      aadharBack: aadharBack,
    );
  }

  @override
  UploadKycImagesProvider getProviderOverride(
    covariant UploadKycImagesProvider provider,
  ) {
    return call(
      profile: provider.profile,
      passbook: provider.passbook,
      panCard: provider.panCard,
      gst: provider.gst,
      aadhar: provider.aadhar,
      aadharBack: provider.aadharBack,
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
  String? get name => r'uploadKycImagesProvider';
}

/// See also [uploadKycImages].
class UploadKycImagesProvider
    extends AutoDisposeFutureProvider<BaseResponseModel> {
  /// See also [uploadKycImages].
  UploadKycImagesProvider({
    File? profile,
    File? passbook,
    File? panCard,
    File? gst,
    File? aadhar,
    File? aadharBack,
  }) : this._internal(
          (ref) => uploadKycImages(
            ref as UploadKycImagesRef,
            profile: profile,
            passbook: passbook,
            panCard: panCard,
            gst: gst,
            aadhar: aadhar,
            aadharBack: aadharBack,
          ),
          from: uploadKycImagesProvider,
          name: r'uploadKycImagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$uploadKycImagesHash,
          dependencies: UploadKycImagesFamily._dependencies,
          allTransitiveDependencies:
              UploadKycImagesFamily._allTransitiveDependencies,
          profile: profile,
          passbook: passbook,
          panCard: panCard,
          gst: gst,
          aadhar: aadhar,
          aadharBack: aadharBack,
        );

  UploadKycImagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.profile,
    required this.passbook,
    required this.panCard,
    required this.gst,
    required this.aadhar,
    required this.aadharBack,
  }) : super.internal();

  final File? profile;
  final File? passbook;
  final File? panCard;
  final File? gst;
  final File? aadhar;
  final File? aadharBack;

  @override
  Override overrideWith(
    FutureOr<BaseResponseModel> Function(UploadKycImagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UploadKycImagesProvider._internal(
        (ref) => create(ref as UploadKycImagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        profile: profile,
        passbook: passbook,
        panCard: panCard,
        gst: gst,
        aadhar: aadhar,
        aadharBack: aadharBack,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseModel> createElement() {
    return _UploadKycImagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UploadKycImagesProvider &&
        other.profile == profile &&
        other.passbook == passbook &&
        other.panCard == panCard &&
        other.gst == gst &&
        other.aadhar == aadhar &&
        other.aadharBack == aadharBack;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, profile.hashCode);
    hash = _SystemHash.combine(hash, passbook.hashCode);
    hash = _SystemHash.combine(hash, panCard.hashCode);
    hash = _SystemHash.combine(hash, gst.hashCode);
    hash = _SystemHash.combine(hash, aadhar.hashCode);
    hash = _SystemHash.combine(hash, aadharBack.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UploadKycImagesRef on AutoDisposeFutureProviderRef<BaseResponseModel> {
  /// The parameter `profile` of this provider.
  File? get profile;

  /// The parameter `passbook` of this provider.
  File? get passbook;

  /// The parameter `panCard` of this provider.
  File? get panCard;

  /// The parameter `gst` of this provider.
  File? get gst;

  /// The parameter `aadhar` of this provider.
  File? get aadhar;

  /// The parameter `aadharBack` of this provider.
  File? get aadharBack;
}

class _UploadKycImagesProviderElement
    extends AutoDisposeFutureProviderElement<BaseResponseModel>
    with UploadKycImagesRef {
  _UploadKycImagesProviderElement(super.provider);

  @override
  File? get profile => (origin as UploadKycImagesProvider).profile;
  @override
  File? get passbook => (origin as UploadKycImagesProvider).passbook;
  @override
  File? get panCard => (origin as UploadKycImagesProvider).panCard;
  @override
  File? get gst => (origin as UploadKycImagesProvider).gst;
  @override
  File? get aadhar => (origin as UploadKycImagesProvider).aadhar;
  @override
  File? get aadharBack => (origin as UploadKycImagesProvider).aadharBack;
}

String _$updateKycUserDetailsHash() =>
    r'2821eb4c58bff581118c0af148db6b8580387334';

/// See also [updateKycUserDetails].
@ProviderFor(updateKycUserDetails)
const updateKycUserDetailsProvider = UpdateKycUserDetailsFamily();

/// See also [updateKycUserDetails].
class UpdateKycUserDetailsFamily extends Family<AsyncValue<BaseResponseModel>> {
  /// See also [updateKycUserDetails].
  const UpdateKycUserDetailsFamily();

  /// See also [updateKycUserDetails].
  UpdateKycUserDetailsProvider call({
    String? email = "",
    String? whatsupNumber = "",
    String? panNumber = "",
    String? aadharNumber = "",
    String? address = "",
    String? areaVillage = "",
    String? city = "",
    String? district = "",
    String? selectedState = "",
    String? pincode = "",
    File? panCardFile,
  }) {
    return UpdateKycUserDetailsProvider(
      email: email,
      whatsupNumber: whatsupNumber,
      panNumber: panNumber,
      aadharNumber: aadharNumber,
      address: address,
      areaVillage: areaVillage,
      city: city,
      district: district,
      selectedState: selectedState,
      pincode: pincode,
      panCardFile: panCardFile,
    );
  }

  @override
  UpdateKycUserDetailsProvider getProviderOverride(
    covariant UpdateKycUserDetailsProvider provider,
  ) {
    return call(
      email: provider.email,
      whatsupNumber: provider.whatsupNumber,
      panNumber: provider.panNumber,
      aadharNumber: provider.aadharNumber,
      address: provider.address,
      areaVillage: provider.areaVillage,
      city: provider.city,
      district: provider.district,
      selectedState: provider.selectedState,
      pincode: provider.pincode,
      panCardFile: provider.panCardFile,
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
  String? get name => r'updateKycUserDetailsProvider';
}

/// See also [updateKycUserDetails].
class UpdateKycUserDetailsProvider
    extends AutoDisposeFutureProvider<BaseResponseModel> {
  /// See also [updateKycUserDetails].
  UpdateKycUserDetailsProvider({
    String? email = "",
    String? whatsupNumber = "",
    String? panNumber = "",
    String? aadharNumber = "",
    String? address = "",
    String? areaVillage = "",
    String? city = "",
    String? district = "",
    String? selectedState = "",
    String? pincode = "",
    File? panCardFile,
  }) : this._internal(
          (ref) => updateKycUserDetails(
            ref as UpdateKycUserDetailsRef,
            email: email,
            whatsupNumber: whatsupNumber,
            panNumber: panNumber,
            aadharNumber: aadharNumber,
            address: address,
            areaVillage: areaVillage,
            city: city,
            district: district,
            selectedState: selectedState,
            pincode: pincode,
            panCardFile: panCardFile,
          ),
          from: updateKycUserDetailsProvider,
          name: r'updateKycUserDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateKycUserDetailsHash,
          dependencies: UpdateKycUserDetailsFamily._dependencies,
          allTransitiveDependencies:
              UpdateKycUserDetailsFamily._allTransitiveDependencies,
          email: email,
          whatsupNumber: whatsupNumber,
          panNumber: panNumber,
          aadharNumber: aadharNumber,
          address: address,
          areaVillage: areaVillage,
          city: city,
          district: district,
          selectedState: selectedState,
          pincode: pincode,
          panCardFile: panCardFile,
        );

  UpdateKycUserDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
    required this.whatsupNumber,
    required this.panNumber,
    required this.aadharNumber,
    required this.address,
    required this.areaVillage,
    required this.city,
    required this.district,
    required this.selectedState,
    required this.pincode,
    required this.panCardFile,
  }) : super.internal();

  final String? email;
  final String? whatsupNumber;
  final String? panNumber;
  final String? aadharNumber;
  final String? address;
  final String? areaVillage;
  final String? city;
  final String? district;
  final String? selectedState;
  final String? pincode;
  final File? panCardFile;

  @override
  Override overrideWith(
    FutureOr<BaseResponseModel> Function(UpdateKycUserDetailsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateKycUserDetailsProvider._internal(
        (ref) => create(ref as UpdateKycUserDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
        whatsupNumber: whatsupNumber,
        panNumber: panNumber,
        aadharNumber: aadharNumber,
        address: address,
        areaVillage: areaVillage,
        city: city,
        district: district,
        selectedState: selectedState,
        pincode: pincode,
        panCardFile: panCardFile,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseModel> createElement() {
    return _UpdateKycUserDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateKycUserDetailsProvider &&
        other.email == email &&
        other.whatsupNumber == whatsupNumber &&
        other.panNumber == panNumber &&
        other.aadharNumber == aadharNumber &&
        other.address == address &&
        other.areaVillage == areaVillage &&
        other.city == city &&
        other.district == district &&
        other.selectedState == selectedState &&
        other.pincode == pincode &&
        other.panCardFile == panCardFile;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, whatsupNumber.hashCode);
    hash = _SystemHash.combine(hash, panNumber.hashCode);
    hash = _SystemHash.combine(hash, aadharNumber.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, areaVillage.hashCode);
    hash = _SystemHash.combine(hash, city.hashCode);
    hash = _SystemHash.combine(hash, district.hashCode);
    hash = _SystemHash.combine(hash, selectedState.hashCode);
    hash = _SystemHash.combine(hash, pincode.hashCode);
    hash = _SystemHash.combine(hash, panCardFile.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateKycUserDetailsRef
    on AutoDisposeFutureProviderRef<BaseResponseModel> {
  /// The parameter `email` of this provider.
  String? get email;

  /// The parameter `whatsupNumber` of this provider.
  String? get whatsupNumber;

  /// The parameter `panNumber` of this provider.
  String? get panNumber;

  /// The parameter `aadharNumber` of this provider.
  String? get aadharNumber;

  /// The parameter `address` of this provider.
  String? get address;

  /// The parameter `areaVillage` of this provider.
  String? get areaVillage;

  /// The parameter `city` of this provider.
  String? get city;

  /// The parameter `district` of this provider.
  String? get district;

  /// The parameter `selectedState` of this provider.
  String? get selectedState;

  /// The parameter `pincode` of this provider.
  String? get pincode;

  /// The parameter `panCardFile` of this provider.
  File? get panCardFile;
}

class _UpdateKycUserDetailsProviderElement
    extends AutoDisposeFutureProviderElement<BaseResponseModel>
    with UpdateKycUserDetailsRef {
  _UpdateKycUserDetailsProviderElement(super.provider);

  @override
  String? get email => (origin as UpdateKycUserDetailsProvider).email;
  @override
  String? get whatsupNumber =>
      (origin as UpdateKycUserDetailsProvider).whatsupNumber;
  @override
  String? get panNumber => (origin as UpdateKycUserDetailsProvider).panNumber;
  @override
  String? get aadharNumber =>
      (origin as UpdateKycUserDetailsProvider).aadharNumber;
  @override
  String? get address => (origin as UpdateKycUserDetailsProvider).address;
  @override
  String? get areaVillage =>
      (origin as UpdateKycUserDetailsProvider).areaVillage;
  @override
  String? get city => (origin as UpdateKycUserDetailsProvider).city;
  @override
  String? get district => (origin as UpdateKycUserDetailsProvider).district;
  @override
  String? get selectedState =>
      (origin as UpdateKycUserDetailsProvider).selectedState;
  @override
  String? get pincode => (origin as UpdateKycUserDetailsProvider).pincode;
  @override
  File? get panCardFile => (origin as UpdateKycUserDetailsProvider).panCardFile;
}

String _$warehouseDataHash() => r'd066a27de106d5a77a296f469e3c0a0411207ad0';

/// See also [warehouseData].
@ProviderFor(warehouseData)
final warehouseDataProvider =
    AutoDisposeFutureProvider<WarehouseReponseModel>.internal(
  warehouseData,
  name: r'warehouseDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$warehouseDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WarehouseDataRef = AutoDisposeFutureProviderRef<WarehouseReponseModel>;
String _$warehousesListHash() => r'222e309be0f494a97fc0c5f62cdf339eae395aff';

/// See also [warehousesList].
@ProviderFor(warehousesList)
final warehousesListProvider = StreamProvider<TerminalsListModel>.internal(
  warehousesList,
  name: r'warehousesListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$warehousesListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WarehousesListRef = StreamProviderRef<TerminalsListModel>;
String _$getBrokerNamesHash() => r'bd31c6994804574af7920a8546a6c46a526d9b43';

/// See also [getBrokerNames].
@ProviderFor(getBrokerNames)
final getBrokerNamesProvider =
    AutoDisposeStreamProvider<BrokerBuyerModel>.internal(
  getBrokerNames,
  name: r'getBrokerNamesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBrokerNamesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetBrokerNamesRef = AutoDisposeStreamProviderRef<BrokerBuyerModel>;
String _$userDetailsHash() => r'f2437a30f4821d8a84948b9ad2d3241d3b24e645';

/// See also [userDetails].
@ProviderFor(userDetails)
final userDetailsProvider =
    AutoDisposeStreamProvider<AuthenticationModel>.internal(
  userDetails,
  name: r'userDetailsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userDetailsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserDetailsRef = AutoDisposeStreamProviderRef<AuthenticationModel>;
String _$qualityParametersHash() => r'20eecba5632ec6dfedc21ace144a91ad2a71e198';

/// See also [qualityParameters].
@ProviderFor(qualityParameters)
const qualityParametersProvider = QualityParametersFamily();

/// See also [qualityParameters].
class QualityParametersFamily extends Family<AsyncValue<QualityParamsModel>> {
  /// See also [qualityParameters].
  const QualityParametersFamily();

  /// See also [qualityParameters].
  QualityParametersProvider call({
    required String stateCode,
    required String districtId,
    required String commodityId,
  }) {
    return QualityParametersProvider(
      stateCode: stateCode,
      districtId: districtId,
      commodityId: commodityId,
    );
  }

  @override
  QualityParametersProvider getProviderOverride(
    covariant QualityParametersProvider provider,
  ) {
    return call(
      stateCode: provider.stateCode,
      districtId: provider.districtId,
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
  String? get name => r'qualityParametersProvider';
}

/// See also [qualityParameters].
class QualityParametersProvider
    extends AutoDisposeStreamProvider<QualityParamsModel> {
  /// See also [qualityParameters].
  QualityParametersProvider({
    required String stateCode,
    required String districtId,
    required String commodityId,
  }) : this._internal(
          (ref) => qualityParameters(
            ref as QualityParametersRef,
            stateCode: stateCode,
            districtId: districtId,
            commodityId: commodityId,
          ),
          from: qualityParametersProvider,
          name: r'qualityParametersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$qualityParametersHash,
          dependencies: QualityParametersFamily._dependencies,
          allTransitiveDependencies:
              QualityParametersFamily._allTransitiveDependencies,
          stateCode: stateCode,
          districtId: districtId,
          commodityId: commodityId,
        );

  QualityParametersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stateCode,
    required this.districtId,
    required this.commodityId,
  }) : super.internal();

  final String stateCode;
  final String districtId;
  final String commodityId;

  @override
  Override overrideWith(
    Stream<QualityParamsModel> Function(QualityParametersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QualityParametersProvider._internal(
        (ref) => create(ref as QualityParametersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stateCode: stateCode,
        districtId: districtId,
        commodityId: commodityId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<QualityParamsModel> createElement() {
    return _QualityParametersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QualityParametersProvider &&
        other.stateCode == stateCode &&
        other.districtId == districtId &&
        other.commodityId == commodityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stateCode.hashCode);
    hash = _SystemHash.combine(hash, districtId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QualityParametersRef on AutoDisposeStreamProviderRef<QualityParamsModel> {
  /// The parameter `stateCode` of this provider.
  String get stateCode;

  /// The parameter `districtId` of this provider.
  String get districtId;

  /// The parameter `commodityId` of this provider.
  String get commodityId;
}

class _QualityParametersProviderElement
    extends AutoDisposeStreamProviderElement<QualityParamsModel>
    with QualityParametersRef {
  _QualityParametersProviderElement(super.provider);

  @override
  String get stateCode => (origin as QualityParametersProvider).stateCode;
  @override
  String get districtId => (origin as QualityParametersProvider).districtId;
  @override
  String get commodityId => (origin as QualityParametersProvider).commodityId;
}

String _$calculateQualityPriceHash() =>
    r'cf0e055202bebb2ba30aabd2a8987014beee02fb';

/// See also [calculateQualityPrice].
@ProviderFor(calculateQualityPrice)
const calculateQualityPriceProvider = CalculateQualityPriceFamily();

/// See also [calculateQualityPrice].
class CalculateQualityPriceFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [calculateQualityPrice].
  const CalculateQualityPriceFamily();

  /// See also [calculateQualityPrice].
  CalculateQualityPriceProvider call({
    required Map<String, dynamic> data,
  }) {
    return CalculateQualityPriceProvider(
      data: data,
    );
  }

  @override
  CalculateQualityPriceProvider getProviderOverride(
    covariant CalculateQualityPriceProvider provider,
  ) {
    return call(
      data: provider.data,
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
  String? get name => r'calculateQualityPriceProvider';
}

/// See also [calculateQualityPrice].
class CalculateQualityPriceProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [calculateQualityPrice].
  CalculateQualityPriceProvider({
    required Map<String, dynamic> data,
  }) : this._internal(
          (ref) => calculateQualityPrice(
            ref as CalculateQualityPriceRef,
            data: data,
          ),
          from: calculateQualityPriceProvider,
          name: r'calculateQualityPriceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$calculateQualityPriceHash,
          dependencies: CalculateQualityPriceFamily._dependencies,
          allTransitiveDependencies:
              CalculateQualityPriceFamily._allTransitiveDependencies,
          data: data,
        );

  CalculateQualityPriceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.data,
  }) : super.internal();

  final Map<String, dynamic> data;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(CalculateQualityPriceRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CalculateQualityPriceProvider._internal(
        (ref) => create(ref as CalculateQualityPriceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        data: data,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _CalculateQualityPriceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalculateQualityPriceProvider && other.data == data;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CalculateQualityPriceRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `data` of this provider.
  Map<String, dynamic> get data;
}

class _CalculateQualityPriceProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with CalculateQualityPriceRef {
  _CalculateQualityPriceProviderElement(super.provider);

  @override
  Map<String, dynamic> get data =>
      (origin as CalculateQualityPriceProvider).data;
}

String _$punchBuySellOrderHash() => r'ad84e94f516422ad6b88ed8cdccef669d87f1d83';

/// See also [punchBuySellOrder].
@ProviderFor(punchBuySellOrder)
const punchBuySellOrderProvider = PunchBuySellOrderFamily();

/// See also [punchBuySellOrder].
class PunchBuySellOrderFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [punchBuySellOrder].
  const PunchBuySellOrderFamily();

  /// See also [punchBuySellOrder].
  PunchBuySellOrderProvider call({
    String? deliveryAt,
    String? terminalId,
    String? shipmentCode,
    String? commodityId,
    String? quantity,
    String? price,
  }) {
    return PunchBuySellOrderProvider(
      deliveryAt: deliveryAt,
      terminalId: terminalId,
      shipmentCode: shipmentCode,
      commodityId: commodityId,
      quantity: quantity,
      price: price,
    );
  }

  @override
  PunchBuySellOrderProvider getProviderOverride(
    covariant PunchBuySellOrderProvider provider,
  ) {
    return call(
      deliveryAt: provider.deliveryAt,
      terminalId: provider.terminalId,
      shipmentCode: provider.shipmentCode,
      commodityId: provider.commodityId,
      quantity: provider.quantity,
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
  String? get name => r'punchBuySellOrderProvider';
}

/// See also [punchBuySellOrder].
class PunchBuySellOrderProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [punchBuySellOrder].
  PunchBuySellOrderProvider({
    String? deliveryAt,
    String? terminalId,
    String? shipmentCode,
    String? commodityId,
    String? quantity,
    String? price,
  }) : this._internal(
          (ref) => punchBuySellOrder(
            ref as PunchBuySellOrderRef,
            deliveryAt: deliveryAt,
            terminalId: terminalId,
            shipmentCode: shipmentCode,
            commodityId: commodityId,
            quantity: quantity,
            price: price,
          ),
          from: punchBuySellOrderProvider,
          name: r'punchBuySellOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$punchBuySellOrderHash,
          dependencies: PunchBuySellOrderFamily._dependencies,
          allTransitiveDependencies:
              PunchBuySellOrderFamily._allTransitiveDependencies,
          deliveryAt: deliveryAt,
          terminalId: terminalId,
          shipmentCode: shipmentCode,
          commodityId: commodityId,
          quantity: quantity,
          price: price,
        );

  PunchBuySellOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.deliveryAt,
    required this.terminalId,
    required this.shipmentCode,
    required this.commodityId,
    required this.quantity,
    required this.price,
  }) : super.internal();

  final String? deliveryAt;
  final String? terminalId;
  final String? shipmentCode;
  final String? commodityId;
  final String? quantity;
  final String? price;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(PunchBuySellOrderRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PunchBuySellOrderProvider._internal(
        (ref) => create(ref as PunchBuySellOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        deliveryAt: deliveryAt,
        terminalId: terminalId,
        shipmentCode: shipmentCode,
        commodityId: commodityId,
        quantity: quantity,
        price: price,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _PunchBuySellOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PunchBuySellOrderProvider &&
        other.deliveryAt == deliveryAt &&
        other.terminalId == terminalId &&
        other.shipmentCode == shipmentCode &&
        other.commodityId == commodityId &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deliveryAt.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, shipmentCode.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PunchBuySellOrderRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `deliveryAt` of this provider.
  String? get deliveryAt;

  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `shipmentCode` of this provider.
  String? get shipmentCode;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `quantity` of this provider.
  String? get quantity;

  /// The parameter `price` of this provider.
  String? get price;
}

class _PunchBuySellOrderProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with PunchBuySellOrderRef {
  _PunchBuySellOrderProviderElement(super.provider);

  @override
  String? get deliveryAt => (origin as PunchBuySellOrderProvider).deliveryAt;
  @override
  String? get terminalId => (origin as PunchBuySellOrderProvider).terminalId;
  @override
  String? get shipmentCode =>
      (origin as PunchBuySellOrderProvider).shipmentCode;
  @override
  String? get commodityId => (origin as PunchBuySellOrderProvider).commodityId;
  @override
  String? get quantity => (origin as PunchBuySellOrderProvider).quantity;
  @override
  String? get price => (origin as PunchBuySellOrderProvider).price;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
