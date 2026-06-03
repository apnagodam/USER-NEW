// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GstService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$insertGstProfileHash() => r'194026ee86a15f5285159c9fd743583248225254';

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

/// See also [insertGstProfile].
@ProviderFor(insertGstProfile)
const insertGstProfileProvider = InsertGstProfileFamily();

/// See also [insertGstProfile].
class InsertGstProfileFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [insertGstProfile].
  const InsertGstProfileFamily();

  /// See also [insertGstProfile].
  InsertGstProfileProvider call({
    required String? gstNumber,
    required String? stateCode,
    required String? address,
    File? gstImage,
    String? isRequired,
  }) {
    return InsertGstProfileProvider(
      gstNumber: gstNumber,
      stateCode: stateCode,
      address: address,
      gstImage: gstImage,
      isRequired: isRequired,
    );
  }

  @override
  InsertGstProfileProvider getProviderOverride(
    covariant InsertGstProfileProvider provider,
  ) {
    return call(
      gstNumber: provider.gstNumber,
      stateCode: provider.stateCode,
      address: provider.address,
      gstImage: provider.gstImage,
      isRequired: provider.isRequired,
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
  String? get name => r'insertGstProfileProvider';
}

/// See also [insertGstProfile].
class InsertGstProfileProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [insertGstProfile].
  InsertGstProfileProvider({
    required String? gstNumber,
    required String? stateCode,
    required String? address,
    File? gstImage,
    String? isRequired,
  }) : this._internal(
          (ref) => insertGstProfile(
            ref as InsertGstProfileRef,
            gstNumber: gstNumber,
            stateCode: stateCode,
            address: address,
            gstImage: gstImage,
            isRequired: isRequired,
          ),
          from: insertGstProfileProvider,
          name: r'insertGstProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$insertGstProfileHash,
          dependencies: InsertGstProfileFamily._dependencies,
          allTransitiveDependencies:
              InsertGstProfileFamily._allTransitiveDependencies,
          gstNumber: gstNumber,
          stateCode: stateCode,
          address: address,
          gstImage: gstImage,
          isRequired: isRequired,
        );

  InsertGstProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gstNumber,
    required this.stateCode,
    required this.address,
    required this.gstImage,
    required this.isRequired,
  }) : super.internal();

  final String? gstNumber;
  final String? stateCode;
  final String? address;
  final File? gstImage;
  final String? isRequired;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(InsertGstProfileRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InsertGstProfileProvider._internal(
        (ref) => create(ref as InsertGstProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gstNumber: gstNumber,
        stateCode: stateCode,
        address: address,
        gstImage: gstImage,
        isRequired: isRequired,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _InsertGstProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InsertGstProfileProvider &&
        other.gstNumber == gstNumber &&
        other.stateCode == stateCode &&
        other.address == address &&
        other.gstImage == gstImage &&
        other.isRequired == isRequired;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gstNumber.hashCode);
    hash = _SystemHash.combine(hash, stateCode.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, gstImage.hashCode);
    hash = _SystemHash.combine(hash, isRequired.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InsertGstProfileRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `gstNumber` of this provider.
  String? get gstNumber;

  /// The parameter `stateCode` of this provider.
  String? get stateCode;

  /// The parameter `address` of this provider.
  String? get address;

  /// The parameter `gstImage` of this provider.
  File? get gstImage;

  /// The parameter `isRequired` of this provider.
  String? get isRequired;
}

class _InsertGstProfileProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with InsertGstProfileRef {
  _InsertGstProfileProviderElement(super.provider);

  @override
  String? get gstNumber => (origin as InsertGstProfileProvider).gstNumber;
  @override
  String? get stateCode => (origin as InsertGstProfileProvider).stateCode;
  @override
  String? get address => (origin as InsertGstProfileProvider).address;
  @override
  File? get gstImage => (origin as InsertGstProfileProvider).gstImage;
  @override
  String? get isRequired => (origin as InsertGstProfileProvider).isRequired;
}

String _$gstListHash() => r'a80b05e4fac205ed4c1b2dad20f28f9542079ef0';

/// See also [gstList].
@ProviderFor(gstList)
final gstListProvider = AutoDisposeStreamProvider<GstListingModel>.internal(
  gstList,
  name: r'gstListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gstListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GstListRef = AutoDisposeStreamProviderRef<GstListingModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
