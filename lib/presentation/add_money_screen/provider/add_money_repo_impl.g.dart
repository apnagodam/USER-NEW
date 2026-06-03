// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_money_repo_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSummaryHash() => r'b52434f1d45b58957bdac3a525f83d87410350da';

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

/// See also [getSummary].
@ProviderFor(getSummary)
const getSummaryProvider = GetSummaryFamily();

/// See also [getSummary].
class GetSummaryFamily extends Family<AsyncValue<AddMoneySummaryModel>> {
  /// See also [getSummary].
  const GetSummaryFamily();

  /// See also [getSummary].
  GetSummaryProvider call({
    required String type,
  }) {
    return GetSummaryProvider(
      type: type,
    );
  }

  @override
  GetSummaryProvider getProviderOverride(
    covariant GetSummaryProvider provider,
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
  String? get name => r'getSummaryProvider';
}

/// See also [getSummary].
class GetSummaryProvider
    extends AutoDisposeFutureProvider<AddMoneySummaryModel> {
  /// See also [getSummary].
  GetSummaryProvider({
    required String type,
  }) : this._internal(
          (ref) => getSummary(
            ref as GetSummaryRef,
            type: type,
          ),
          from: getSummaryProvider,
          name: r'getSummaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSummaryHash,
          dependencies: GetSummaryFamily._dependencies,
          allTransitiveDependencies:
              GetSummaryFamily._allTransitiveDependencies,
          type: type,
        );

  GetSummaryProvider._internal(
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
    FutureOr<AddMoneySummaryModel> Function(GetSummaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSummaryProvider._internal(
        (ref) => create(ref as GetSummaryRef),
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
  AutoDisposeFutureProviderElement<AddMoneySummaryModel> createElement() {
    return _GetSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSummaryProvider && other.type == type;
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
mixin GetSummaryRef on AutoDisposeFutureProviderRef<AddMoneySummaryModel> {
  /// The parameter `type` of this provider.
  String get type;
}

class _GetSummaryProviderElement
    extends AutoDisposeFutureProviderElement<AddMoneySummaryModel>
    with GetSummaryRef {
  _GetSummaryProviderElement(super.provider);

  @override
  String get type => (origin as GetSummaryProvider).type;
}

String _$addMoneyHash() => r'057724a6918ad01f1bd1ac3c0b891f35e3b1de1a';

/// See also [addMoney].
@ProviderFor(addMoney)
const addMoneyProvider = AddMoneyFamily();

/// See also [addMoney].
class AddMoneyFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [addMoney].
  const AddMoneyFamily();

  /// See also [addMoney].
  AddMoneyProvider call({
    String? paymenttype,
    String? receptno,
    String? amount,
    String? amountAccType,
    File? files,
  }) {
    return AddMoneyProvider(
      paymenttype: paymenttype,
      receptno: receptno,
      amount: amount,
      amountAccType: amountAccType,
      files: files,
    );
  }

  @override
  AddMoneyProvider getProviderOverride(
    covariant AddMoneyProvider provider,
  ) {
    return call(
      paymenttype: provider.paymenttype,
      receptno: provider.receptno,
      amount: provider.amount,
      amountAccType: provider.amountAccType,
      files: provider.files,
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
  String? get name => r'addMoneyProvider';
}

/// See also [addMoney].
class AddMoneyProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [addMoney].
  AddMoneyProvider({
    String? paymenttype,
    String? receptno,
    String? amount,
    String? amountAccType,
    File? files,
  }) : this._internal(
          (ref) => addMoney(
            ref as AddMoneyRef,
            paymenttype: paymenttype,
            receptno: receptno,
            amount: amount,
            amountAccType: amountAccType,
            files: files,
          ),
          from: addMoneyProvider,
          name: r'addMoneyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addMoneyHash,
          dependencies: AddMoneyFamily._dependencies,
          allTransitiveDependencies: AddMoneyFamily._allTransitiveDependencies,
          paymenttype: paymenttype,
          receptno: receptno,
          amount: amount,
          amountAccType: amountAccType,
          files: files,
        );

  AddMoneyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.paymenttype,
    required this.receptno,
    required this.amount,
    required this.amountAccType,
    required this.files,
  }) : super.internal();

  final String? paymenttype;
  final String? receptno;
  final String? amount;
  final String? amountAccType;
  final File? files;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(AddMoneyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddMoneyProvider._internal(
        (ref) => create(ref as AddMoneyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        paymenttype: paymenttype,
        receptno: receptno,
        amount: amount,
        amountAccType: amountAccType,
        files: files,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _AddMoneyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddMoneyProvider &&
        other.paymenttype == paymenttype &&
        other.receptno == receptno &&
        other.amount == amount &&
        other.amountAccType == amountAccType &&
        other.files == files;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, paymenttype.hashCode);
    hash = _SystemHash.combine(hash, receptno.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);
    hash = _SystemHash.combine(hash, amountAccType.hashCode);
    hash = _SystemHash.combine(hash, files.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddMoneyRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `paymenttype` of this provider.
  String? get paymenttype;

  /// The parameter `receptno` of this provider.
  String? get receptno;

  /// The parameter `amount` of this provider.
  String? get amount;

  /// The parameter `amountAccType` of this provider.
  String? get amountAccType;

  /// The parameter `files` of this provider.
  File? get files;
}

class _AddMoneyProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with AddMoneyRef {
  _AddMoneyProviderElement(super.provider);

  @override
  String? get paymenttype => (origin as AddMoneyProvider).paymenttype;
  @override
  String? get receptno => (origin as AddMoneyProvider).receptno;
  @override
  String? get amount => (origin as AddMoneyProvider).amount;
  @override
  String? get amountAccType => (origin as AddMoneyProvider).amountAccType;
  @override
  File? get files => (origin as AddMoneyProvider).files;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
