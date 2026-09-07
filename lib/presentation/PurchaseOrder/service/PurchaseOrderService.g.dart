// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PurchaseOrderService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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

String _$purchaseOrdersListHash() =>
    r'f4e2c3c382d70b863b947f30554e1e1399fa9f64';

/// See also [purchaseOrdersList].
@ProviderFor(purchaseOrdersList)
final purchaseOrdersListProvider =
    AutoDisposeStreamProvider<PurchaseOrdersListingModel>.internal(
  purchaseOrdersList,
  name: r'purchaseOrdersListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$purchaseOrdersListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PurchaseOrdersListRef
    = AutoDisposeStreamProviderRef<PurchaseOrdersListingModel>;
String _$deletePOHash() => r'c94cf85181c05f944de185f7e453bb261648a12e';

/// See also [deletePO].
@ProviderFor(deletePO)
const deletePOProvider = DeletePOFamily();

/// See also [deletePO].
class DeletePOFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [deletePO].
  const DeletePOFamily();

  /// See also [deletePO].
  DeletePOProvider call({
    String? id,
  }) {
    return DeletePOProvider(
      id: id,
    );
  }

  @override
  DeletePOProvider getProviderOverride(
    covariant DeletePOProvider provider,
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
  String? get name => r'deletePOProvider';
}

/// See also [deletePO].
class DeletePOProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [deletePO].
  DeletePOProvider({
    String? id,
  }) : this._internal(
          (ref) => deletePO(
            ref as DeletePORef,
            id: id,
          ),
          from: deletePOProvider,
          name: r'deletePOProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deletePOHash,
          dependencies: DeletePOFamily._dependencies,
          allTransitiveDependencies: DeletePOFamily._allTransitiveDependencies,
          id: id,
        );

  DeletePOProvider._internal(
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
    FutureOr<Map<String, dynamic>> Function(DeletePORef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeletePOProvider._internal(
        (ref) => create(ref as DeletePORef),
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
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _DeletePOProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeletePOProvider && other.id == id;
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
mixin DeletePORef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _DeletePOProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with DeletePORef {
  _DeletePOProviderElement(super.provider);

  @override
  String? get id => (origin as DeletePOProvider).id;
}

String _$editPoHash() => r'bf28e7076d97bb41a6d34bd9a41ea986354e2d7e';

/// See also [editPo].
@ProviderFor(editPo)
const editPoProvider = EditPoFamily();

/// See also [editPo].
class EditPoFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [editPo].
  const EditPoFamily();

  /// See also [editPo].
  EditPoProvider call({
    String? id,
    String? pendingQty,
    String? expiry,
    String? remark,
  }) {
    return EditPoProvider(
      id: id,
      pendingQty: pendingQty,
      expiry: expiry,
      remark: remark,
    );
  }

  @override
  EditPoProvider getProviderOverride(
    covariant EditPoProvider provider,
  ) {
    return call(
      id: provider.id,
      pendingQty: provider.pendingQty,
      expiry: provider.expiry,
      remark: provider.remark,
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
  String? get name => r'editPoProvider';
}

/// See also [editPo].
class EditPoProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [editPo].
  EditPoProvider({
    String? id,
    String? pendingQty,
    String? expiry,
    String? remark,
  }) : this._internal(
          (ref) => editPo(
            ref as EditPoRef,
            id: id,
            pendingQty: pendingQty,
            expiry: expiry,
            remark: remark,
          ),
          from: editPoProvider,
          name: r'editPoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editPoHash,
          dependencies: EditPoFamily._dependencies,
          allTransitiveDependencies: EditPoFamily._allTransitiveDependencies,
          id: id,
          pendingQty: pendingQty,
          expiry: expiry,
          remark: remark,
        );

  EditPoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.pendingQty,
    required this.expiry,
    required this.remark,
  }) : super.internal();

  final String? id;
  final String? pendingQty;
  final String? expiry;
  final String? remark;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(EditPoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditPoProvider._internal(
        (ref) => create(ref as EditPoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        pendingQty: pendingQty,
        expiry: expiry,
        remark: remark,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _EditPoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditPoProvider &&
        other.id == id &&
        other.pendingQty == pendingQty &&
        other.expiry == expiry &&
        other.remark == remark;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, pendingQty.hashCode);
    hash = _SystemHash.combine(hash, expiry.hashCode);
    hash = _SystemHash.combine(hash, remark.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditPoRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `pendingQty` of this provider.
  String? get pendingQty;

  /// The parameter `expiry` of this provider.
  String? get expiry;

  /// The parameter `remark` of this provider.
  String? get remark;
}

class _EditPoProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with EditPoRef {
  _EditPoProviderElement(super.provider);

  @override
  String? get id => (origin as EditPoProvider).id;
  @override
  String? get pendingQty => (origin as EditPoProvider).pendingQty;
  @override
  String? get expiry => (origin as EditPoProvider).expiry;
  @override
  String? get remark => (origin as EditPoProvider).remark;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
