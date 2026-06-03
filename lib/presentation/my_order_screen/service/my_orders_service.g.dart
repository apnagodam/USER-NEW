// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_orders_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getWantToSellResponseHash() =>
    r'd22489043df106aa955238297244e0f84a7e01fa';

/// See also [getWantToSellResponse].
@ProviderFor(getWantToSellResponse)
final getWantToSellResponseProvider =
    AutoDisposeStreamProvider<MyOrdersResponseModel>.internal(
  getWantToSellResponse,
  name: r'getWantToSellResponseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getWantToSellResponseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetWantToSellResponseRef
    = AutoDisposeStreamProviderRef<MyOrdersResponseModel>;
String _$cancelOrdersHash() => r'722846aa2505d0e695ec9efe08ae5b8369135caf';

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

/// See also [cancelOrders].
@ProviderFor(cancelOrders)
const cancelOrdersProvider = CancelOrdersFamily();

/// See also [cancelOrders].
class CancelOrdersFamily extends Family<AsyncValue<BaseResponseModel>> {
  /// See also [cancelOrders].
  const CancelOrdersFamily();

  /// See also [cancelOrders].
  CancelOrdersProvider call({
    String? id = "",
  }) {
    return CancelOrdersProvider(
      id: id,
    );
  }

  @override
  CancelOrdersProvider getProviderOverride(
    covariant CancelOrdersProvider provider,
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
  String? get name => r'cancelOrdersProvider';
}

/// See also [cancelOrders].
class CancelOrdersProvider
    extends AutoDisposeFutureProvider<BaseResponseModel> {
  /// See also [cancelOrders].
  CancelOrdersProvider({
    String? id = "",
  }) : this._internal(
          (ref) => cancelOrders(
            ref as CancelOrdersRef,
            id: id,
          ),
          from: cancelOrdersProvider,
          name: r'cancelOrdersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cancelOrdersHash,
          dependencies: CancelOrdersFamily._dependencies,
          allTransitiveDependencies:
              CancelOrdersFamily._allTransitiveDependencies,
          id: id,
        );

  CancelOrdersProvider._internal(
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
    FutureOr<BaseResponseModel> Function(CancelOrdersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CancelOrdersProvider._internal(
        (ref) => create(ref as CancelOrdersRef),
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
  AutoDisposeFutureProviderElement<BaseResponseModel> createElement() {
    return _CancelOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CancelOrdersProvider && other.id == id;
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
mixin CancelOrdersRef on AutoDisposeFutureProviderRef<BaseResponseModel> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _CancelOrdersProviderElement
    extends AutoDisposeFutureProviderElement<BaseResponseModel>
    with CancelOrdersRef {
  _CancelOrdersProviderElement(super.provider);

  @override
  String? get id => (origin as CancelOrdersProvider).id;
}

String _$updateMyOrderHash() => r'58c3372abb8b8a183fb24eb59b444c847a32cccb';

/// See also [updateMyOrder].
@ProviderFor(updateMyOrder)
const updateMyOrderProvider = UpdateMyOrderFamily();

/// See also [updateMyOrder].
class UpdateMyOrderFamily extends Family<AsyncValue<BaseResponseModel>> {
  /// See also [updateMyOrder].
  const UpdateMyOrderFamily();

  /// See also [updateMyOrder].
  UpdateMyOrderProvider call({
    String? id = "",
    String? quantity = "",
    String? price,
  }) {
    return UpdateMyOrderProvider(
      id: id,
      quantity: quantity,
      price: price,
    );
  }

  @override
  UpdateMyOrderProvider getProviderOverride(
    covariant UpdateMyOrderProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'updateMyOrderProvider';
}

/// See also [updateMyOrder].
class UpdateMyOrderProvider
    extends AutoDisposeFutureProvider<BaseResponseModel> {
  /// See also [updateMyOrder].
  UpdateMyOrderProvider({
    String? id = "",
    String? quantity = "",
    String? price,
  }) : this._internal(
          (ref) => updateMyOrder(
            ref as UpdateMyOrderRef,
            id: id,
            quantity: quantity,
            price: price,
          ),
          from: updateMyOrderProvider,
          name: r'updateMyOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateMyOrderHash,
          dependencies: UpdateMyOrderFamily._dependencies,
          allTransitiveDependencies:
              UpdateMyOrderFamily._allTransitiveDependencies,
          id: id,
          quantity: quantity,
          price: price,
        );

  UpdateMyOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.quantity,
    required this.price,
  }) : super.internal();

  final String? id;
  final String? quantity;
  final String? price;

  @override
  Override overrideWith(
    FutureOr<BaseResponseModel> Function(UpdateMyOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateMyOrderProvider._internal(
        (ref) => create(ref as UpdateMyOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        quantity: quantity,
        price: price,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseModel> createElement() {
    return _UpdateMyOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateMyOrderProvider &&
        other.id == id &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateMyOrderRef on AutoDisposeFutureProviderRef<BaseResponseModel> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `quantity` of this provider.
  String? get quantity;

  /// The parameter `price` of this provider.
  String? get price;
}

class _UpdateMyOrderProviderElement
    extends AutoDisposeFutureProviderElement<BaseResponseModel>
    with UpdateMyOrderRef {
  _UpdateMyOrderProviderElement(super.provider);

  @override
  String? get id => (origin as UpdateMyOrderProvider).id;
  @override
  String? get quantity => (origin as UpdateMyOrderProvider).quantity;
  @override
  String? get price => (origin as UpdateMyOrderProvider).price;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
