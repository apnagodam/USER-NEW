// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PurchaseOrderService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updatePurchaseOrderHash() =>
    r'7739cb20a733d4207620257b35faae9763557e92';

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

/// See also [updatePurchaseOrder].
@ProviderFor(updatePurchaseOrder)
const updatePurchaseOrderProvider = UpdatePurchaseOrderFamily();

/// See also [updatePurchaseOrder].
class UpdatePurchaseOrderFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [updatePurchaseOrder].
  const UpdatePurchaseOrderFamily();

  /// See also [updatePurchaseOrder].
  UpdatePurchaseOrderProvider call({
    required String terminalId,
    required String commodityId,
    required String weight,
    required String rate,
    required String date,
    required String expiryDate,
    required String poNumber,
    required String gstNumber,
    required String broker,
    required String buyerName,
    required String phone,
    required String address,
    required String pincode,
    required String qualityCondition,
    required File poImage,
  }) {
    return UpdatePurchaseOrderProvider(
      terminalId: terminalId,
      commodityId: commodityId,
      weight: weight,
      rate: rate,
      date: date,
      expiryDate: expiryDate,
      poNumber: poNumber,
      gstNumber: gstNumber,
      broker: broker,
      buyerName: buyerName,
      phone: phone,
      address: address,
      pincode: pincode,
      qualityCondition: qualityCondition,
      poImage: poImage,
    );
  }

  @override
  UpdatePurchaseOrderProvider getProviderOverride(
    covariant UpdatePurchaseOrderProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      commodityId: provider.commodityId,
      weight: provider.weight,
      rate: provider.rate,
      date: provider.date,
      expiryDate: provider.expiryDate,
      poNumber: provider.poNumber,
      gstNumber: provider.gstNumber,
      broker: provider.broker,
      buyerName: provider.buyerName,
      phone: provider.phone,
      address: provider.address,
      pincode: provider.pincode,
      qualityCondition: provider.qualityCondition,
      poImage: provider.poImage,
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
  String? get name => r'updatePurchaseOrderProvider';
}

/// See also [updatePurchaseOrder].
class UpdatePurchaseOrderProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [updatePurchaseOrder].
  UpdatePurchaseOrderProvider({
    required String terminalId,
    required String commodityId,
    required String weight,
    required String rate,
    required String date,
    required String expiryDate,
    required String poNumber,
    required String gstNumber,
    required String broker,
    required String buyerName,
    required String phone,
    required String address,
    required String pincode,
    required String qualityCondition,
    required File poImage,
  }) : this._internal(
          (ref) => updatePurchaseOrder(
            ref as UpdatePurchaseOrderRef,
            terminalId: terminalId,
            commodityId: commodityId,
            weight: weight,
            rate: rate,
            date: date,
            expiryDate: expiryDate,
            poNumber: poNumber,
            gstNumber: gstNumber,
            broker: broker,
            buyerName: buyerName,
            phone: phone,
            address: address,
            pincode: pincode,
            qualityCondition: qualityCondition,
            poImage: poImage,
          ),
          from: updatePurchaseOrderProvider,
          name: r'updatePurchaseOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updatePurchaseOrderHash,
          dependencies: UpdatePurchaseOrderFamily._dependencies,
          allTransitiveDependencies:
              UpdatePurchaseOrderFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
          weight: weight,
          rate: rate,
          date: date,
          expiryDate: expiryDate,
          poNumber: poNumber,
          gstNumber: gstNumber,
          broker: broker,
          buyerName: buyerName,
          phone: phone,
          address: address,
          pincode: pincode,
          qualityCondition: qualityCondition,
          poImage: poImage,
        );

  UpdatePurchaseOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.commodityId,
    required this.weight,
    required this.rate,
    required this.date,
    required this.expiryDate,
    required this.poNumber,
    required this.gstNumber,
    required this.broker,
    required this.buyerName,
    required this.phone,
    required this.address,
    required this.pincode,
    required this.qualityCondition,
    required this.poImage,
  }) : super.internal();

  final String terminalId;
  final String commodityId;
  final String weight;
  final String rate;
  final String date;
  final String expiryDate;
  final String poNumber;
  final String gstNumber;
  final String broker;
  final String buyerName;
  final String phone;
  final String address;
  final String pincode;
  final String qualityCondition;
  final File poImage;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(UpdatePurchaseOrderRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdatePurchaseOrderProvider._internal(
        (ref) => create(ref as UpdatePurchaseOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        commodityId: commodityId,
        weight: weight,
        rate: rate,
        date: date,
        expiryDate: expiryDate,
        poNumber: poNumber,
        gstNumber: gstNumber,
        broker: broker,
        buyerName: buyerName,
        phone: phone,
        address: address,
        pincode: pincode,
        qualityCondition: qualityCondition,
        poImage: poImage,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _UpdatePurchaseOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdatePurchaseOrderProvider &&
        other.terminalId == terminalId &&
        other.commodityId == commodityId &&
        other.weight == weight &&
        other.rate == rate &&
        other.date == date &&
        other.expiryDate == expiryDate &&
        other.poNumber == poNumber &&
        other.gstNumber == gstNumber &&
        other.broker == broker &&
        other.buyerName == buyerName &&
        other.phone == phone &&
        other.address == address &&
        other.pincode == pincode &&
        other.qualityCondition == qualityCondition &&
        other.poImage == poImage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, weight.hashCode);
    hash = _SystemHash.combine(hash, rate.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);
    hash = _SystemHash.combine(hash, expiryDate.hashCode);
    hash = _SystemHash.combine(hash, poNumber.hashCode);
    hash = _SystemHash.combine(hash, gstNumber.hashCode);
    hash = _SystemHash.combine(hash, broker.hashCode);
    hash = _SystemHash.combine(hash, buyerName.hashCode);
    hash = _SystemHash.combine(hash, phone.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, pincode.hashCode);
    hash = _SystemHash.combine(hash, qualityCondition.hashCode);
    hash = _SystemHash.combine(hash, poImage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdatePurchaseOrderRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `terminalId` of this provider.
  String get terminalId;

  /// The parameter `commodityId` of this provider.
  String get commodityId;

  /// The parameter `weight` of this provider.
  String get weight;

  /// The parameter `rate` of this provider.
  String get rate;

  /// The parameter `date` of this provider.
  String get date;

  /// The parameter `expiryDate` of this provider.
  String get expiryDate;

  /// The parameter `poNumber` of this provider.
  String get poNumber;

  /// The parameter `gstNumber` of this provider.
  String get gstNumber;

  /// The parameter `broker` of this provider.
  String get broker;

  /// The parameter `buyerName` of this provider.
  String get buyerName;

  /// The parameter `phone` of this provider.
  String get phone;

  /// The parameter `address` of this provider.
  String get address;

  /// The parameter `pincode` of this provider.
  String get pincode;

  /// The parameter `qualityCondition` of this provider.
  String get qualityCondition;

  /// The parameter `poImage` of this provider.
  File get poImage;
}

class _UpdatePurchaseOrderProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with UpdatePurchaseOrderRef {
  _UpdatePurchaseOrderProviderElement(super.provider);

  @override
  String get terminalId => (origin as UpdatePurchaseOrderProvider).terminalId;
  @override
  String get commodityId => (origin as UpdatePurchaseOrderProvider).commodityId;
  @override
  String get weight => (origin as UpdatePurchaseOrderProvider).weight;
  @override
  String get rate => (origin as UpdatePurchaseOrderProvider).rate;
  @override
  String get date => (origin as UpdatePurchaseOrderProvider).date;
  @override
  String get expiryDate => (origin as UpdatePurchaseOrderProvider).expiryDate;
  @override
  String get poNumber => (origin as UpdatePurchaseOrderProvider).poNumber;
  @override
  String get gstNumber => (origin as UpdatePurchaseOrderProvider).gstNumber;
  @override
  String get broker => (origin as UpdatePurchaseOrderProvider).broker;
  @override
  String get buyerName => (origin as UpdatePurchaseOrderProvider).buyerName;
  @override
  String get phone => (origin as UpdatePurchaseOrderProvider).phone;
  @override
  String get address => (origin as UpdatePurchaseOrderProvider).address;
  @override
  String get pincode => (origin as UpdatePurchaseOrderProvider).pincode;
  @override
  String get qualityCondition =>
      (origin as UpdatePurchaseOrderProvider).qualityCondition;
  @override
  File get poImage => (origin as UpdatePurchaseOrderProvider).poImage;
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
