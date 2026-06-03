// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MandiTaxProfileService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statesListHash() => r'595b19987c66eac4c12dc0e6e1b0afc6a2891580';

/// See also [statesList].
@ProviderFor(statesList)
final statesListProvider =
    AutoDisposeStreamProvider<StatesResponseModel>.internal(
  statesList,
  name: r'statesListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$statesListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatesListRef = AutoDisposeStreamProviderRef<StatesResponseModel>;
String _$statesListNewHash() => r'd9737a1525de92e47771ce74e29049b2f27c98c8';

/// See also [statesListNew].
@ProviderFor(statesListNew)
final statesListNewProvider =
    AutoDisposeStreamProvider<StatesResponseModel>.internal(
  statesListNew,
  name: r'statesListNewProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statesListNewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatesListNewRef = AutoDisposeStreamProviderRef<StatesResponseModel>;
String _$districtListHash() => r'b3f679caf4d20380200fe9a367351e57102cfcb1';

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

/// See also [districtList].
@ProviderFor(districtList)
const districtListProvider = DistrictListFamily();

/// See also [districtList].
class DistrictListFamily extends Family<AsyncValue<DistrictsResponseModel>> {
  /// See also [districtList].
  const DistrictListFamily();

  /// See also [districtList].
  DistrictListProvider call({
    String? code,
  }) {
    return DistrictListProvider(
      code: code,
    );
  }

  @override
  DistrictListProvider getProviderOverride(
    covariant DistrictListProvider provider,
  ) {
    return call(
      code: provider.code,
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
  String? get name => r'districtListProvider';
}

/// See also [districtList].
class DistrictListProvider
    extends AutoDisposeStreamProvider<DistrictsResponseModel> {
  /// See also [districtList].
  DistrictListProvider({
    String? code,
  }) : this._internal(
          (ref) => districtList(
            ref as DistrictListRef,
            code: code,
          ),
          from: districtListProvider,
          name: r'districtListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$districtListHash,
          dependencies: DistrictListFamily._dependencies,
          allTransitiveDependencies:
              DistrictListFamily._allTransitiveDependencies,
          code: code,
        );

  DistrictListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.code,
  }) : super.internal();

  final String? code;

  @override
  Override overrideWith(
    Stream<DistrictsResponseModel> Function(DistrictListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DistrictListProvider._internal(
        (ref) => create(ref as DistrictListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        code: code,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<DistrictsResponseModel> createElement() {
    return _DistrictListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DistrictListProvider && other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DistrictListRef on AutoDisposeStreamProviderRef<DistrictsResponseModel> {
  /// The parameter `code` of this provider.
  String? get code;
}

class _DistrictListProviderElement
    extends AutoDisposeStreamProviderElement<DistrictsResponseModel>
    with DistrictListRef {
  _DistrictListProviderElement(super.provider);

  @override
  String? get code => (origin as DistrictListProvider).code;
}

String _$districtListNewHash() => r'17808642bcb9289970b1b65e9dc6bb2dc9df1a4d';

/// See also [districtListNew].
@ProviderFor(districtListNew)
const districtListNewProvider = DistrictListNewFamily();

/// See also [districtListNew].
class DistrictListNewFamily extends Family<AsyncValue<DistrictsResponseModel>> {
  /// See also [districtListNew].
  const DistrictListNewFamily();

  /// See also [districtListNew].
  DistrictListNewProvider call({
    String? code,
  }) {
    return DistrictListNewProvider(
      code: code,
    );
  }

  @override
  DistrictListNewProvider getProviderOverride(
    covariant DistrictListNewProvider provider,
  ) {
    return call(
      code: provider.code,
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
  String? get name => r'districtListNewProvider';
}

/// See also [districtListNew].
class DistrictListNewProvider
    extends AutoDisposeStreamProvider<DistrictsResponseModel> {
  /// See also [districtListNew].
  DistrictListNewProvider({
    String? code,
  }) : this._internal(
          (ref) => districtListNew(
            ref as DistrictListNewRef,
            code: code,
          ),
          from: districtListNewProvider,
          name: r'districtListNewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$districtListNewHash,
          dependencies: DistrictListNewFamily._dependencies,
          allTransitiveDependencies:
              DistrictListNewFamily._allTransitiveDependencies,
          code: code,
        );

  DistrictListNewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.code,
  }) : super.internal();

  final String? code;

  @override
  Override overrideWith(
    Stream<DistrictsResponseModel> Function(DistrictListNewRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DistrictListNewProvider._internal(
        (ref) => create(ref as DistrictListNewRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        code: code,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<DistrictsResponseModel> createElement() {
    return _DistrictListNewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DistrictListNewProvider && other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DistrictListNewRef
    on AutoDisposeStreamProviderRef<DistrictsResponseModel> {
  /// The parameter `code` of this provider.
  String? get code;
}

class _DistrictListNewProviderElement
    extends AutoDisposeStreamProviderElement<DistrictsResponseModel>
    with DistrictListNewRef {
  _DistrictListNewProviderElement(super.provider);

  @override
  String? get code => (origin as DistrictListNewProvider).code;
}

String _$mandiTaxProfilesHash() => r'b5c0fa5022020215aed10ea9f4a4050550b36e8a';

/// See also [mandiTaxProfiles].
@ProviderFor(mandiTaxProfiles)
final mandiTaxProfilesProvider =
    AutoDisposeStreamProvider<MandiTaxProfileListingModel>.internal(
  mandiTaxProfiles,
  name: r'mandiTaxProfilesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mandiTaxProfilesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MandiTaxProfilesRef
    = AutoDisposeStreamProviderRef<MandiTaxProfileListingModel>;
String _$cAndFDetailsHash() => r'df34283147f18ecde51e0738846a711af1c998e4';

/// See also [cAndFDetails].
@ProviderFor(cAndFDetails)
const cAndFDetailsProvider = CAndFDetailsFamily();

/// See also [cAndFDetails].
class CAndFDetailsFamily extends Family<AsyncValue<CandFModel>> {
  /// See also [cAndFDetails].
  const CAndFDetailsFamily();

  /// See also [cAndFDetails].
  CAndFDetailsProvider call({
    required String stateId,
  }) {
    return CAndFDetailsProvider(
      stateId: stateId,
    );
  }

  @override
  CAndFDetailsProvider getProviderOverride(
    covariant CAndFDetailsProvider provider,
  ) {
    return call(
      stateId: provider.stateId,
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
  String? get name => r'cAndFDetailsProvider';
}

/// See also [cAndFDetails].
class CAndFDetailsProvider extends AutoDisposeStreamProvider<CandFModel> {
  /// See also [cAndFDetails].
  CAndFDetailsProvider({
    required String stateId,
  }) : this._internal(
          (ref) => cAndFDetails(
            ref as CAndFDetailsRef,
            stateId: stateId,
          ),
          from: cAndFDetailsProvider,
          name: r'cAndFDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cAndFDetailsHash,
          dependencies: CAndFDetailsFamily._dependencies,
          allTransitiveDependencies:
              CAndFDetailsFamily._allTransitiveDependencies,
          stateId: stateId,
        );

  CAndFDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stateId,
  }) : super.internal();

  final String stateId;

  @override
  Override overrideWith(
    Stream<CandFModel> Function(CAndFDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CAndFDetailsProvider._internal(
        (ref) => create(ref as CAndFDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stateId: stateId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<CandFModel> createElement() {
    return _CAndFDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CAndFDetailsProvider && other.stateId == stateId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stateId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CAndFDetailsRef on AutoDisposeStreamProviderRef<CandFModel> {
  /// The parameter `stateId` of this provider.
  String get stateId;
}

class _CAndFDetailsProviderElement
    extends AutoDisposeStreamProviderElement<CandFModel> with CAndFDetailsRef {
  _CAndFDetailsProviderElement(super.provider);

  @override
  String get stateId => (origin as CAndFDetailsProvider).stateId;
}

String _$submitMandiTaxProfileHash() =>
    r'48eb4c12f6689ffe2d63213db678a7e683a7a0d1';

/// See also [submitMandiTaxProfile].
@ProviderFor(submitMandiTaxProfile)
const submitMandiTaxProfileProvider = SubmitMandiTaxProfileFamily();

/// See also [submitMandiTaxProfile].
class SubmitMandiTaxProfileFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [submitMandiTaxProfile].
  const SubmitMandiTaxProfileFamily();

  /// See also [submitMandiTaxProfile].
  SubmitMandiTaxProfileProvider call({
    String? mandiState,
    String? isLicense,
    String? licenseType,
    String? district,
    String? licenseNumber,
    String? issueDate,
    String? expiryDate,
    String? refNumber,
    String? id,
    File? image,
  }) {
    return SubmitMandiTaxProfileProvider(
      mandiState: mandiState,
      isLicense: isLicense,
      licenseType: licenseType,
      district: district,
      licenseNumber: licenseNumber,
      issueDate: issueDate,
      expiryDate: expiryDate,
      refNumber: refNumber,
      id: id,
      image: image,
    );
  }

  @override
  SubmitMandiTaxProfileProvider getProviderOverride(
    covariant SubmitMandiTaxProfileProvider provider,
  ) {
    return call(
      mandiState: provider.mandiState,
      isLicense: provider.isLicense,
      licenseType: provider.licenseType,
      district: provider.district,
      licenseNumber: provider.licenseNumber,
      issueDate: provider.issueDate,
      expiryDate: provider.expiryDate,
      refNumber: provider.refNumber,
      id: provider.id,
      image: provider.image,
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
  String? get name => r'submitMandiTaxProfileProvider';
}

/// See also [submitMandiTaxProfile].
class SubmitMandiTaxProfileProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [submitMandiTaxProfile].
  SubmitMandiTaxProfileProvider({
    String? mandiState,
    String? isLicense,
    String? licenseType,
    String? district,
    String? licenseNumber,
    String? issueDate,
    String? expiryDate,
    String? refNumber,
    String? id,
    File? image,
  }) : this._internal(
          (ref) => submitMandiTaxProfile(
            ref as SubmitMandiTaxProfileRef,
            mandiState: mandiState,
            isLicense: isLicense,
            licenseType: licenseType,
            district: district,
            licenseNumber: licenseNumber,
            issueDate: issueDate,
            expiryDate: expiryDate,
            refNumber: refNumber,
            id: id,
            image: image,
          ),
          from: submitMandiTaxProfileProvider,
          name: r'submitMandiTaxProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$submitMandiTaxProfileHash,
          dependencies: SubmitMandiTaxProfileFamily._dependencies,
          allTransitiveDependencies:
              SubmitMandiTaxProfileFamily._allTransitiveDependencies,
          mandiState: mandiState,
          isLicense: isLicense,
          licenseType: licenseType,
          district: district,
          licenseNumber: licenseNumber,
          issueDate: issueDate,
          expiryDate: expiryDate,
          refNumber: refNumber,
          id: id,
          image: image,
        );

  SubmitMandiTaxProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mandiState,
    required this.isLicense,
    required this.licenseType,
    required this.district,
    required this.licenseNumber,
    required this.issueDate,
    required this.expiryDate,
    required this.refNumber,
    required this.id,
    required this.image,
  }) : super.internal();

  final String? mandiState;
  final String? isLicense;
  final String? licenseType;
  final String? district;
  final String? licenseNumber;
  final String? issueDate;
  final String? expiryDate;
  final String? refNumber;
  final String? id;
  final File? image;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(SubmitMandiTaxProfileRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubmitMandiTaxProfileProvider._internal(
        (ref) => create(ref as SubmitMandiTaxProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mandiState: mandiState,
        isLicense: isLicense,
        licenseType: licenseType,
        district: district,
        licenseNumber: licenseNumber,
        issueDate: issueDate,
        expiryDate: expiryDate,
        refNumber: refNumber,
        id: id,
        image: image,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SubmitMandiTaxProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubmitMandiTaxProfileProvider &&
        other.mandiState == mandiState &&
        other.isLicense == isLicense &&
        other.licenseType == licenseType &&
        other.district == district &&
        other.licenseNumber == licenseNumber &&
        other.issueDate == issueDate &&
        other.expiryDate == expiryDate &&
        other.refNumber == refNumber &&
        other.id == id &&
        other.image == image;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mandiState.hashCode);
    hash = _SystemHash.combine(hash, isLicense.hashCode);
    hash = _SystemHash.combine(hash, licenseType.hashCode);
    hash = _SystemHash.combine(hash, district.hashCode);
    hash = _SystemHash.combine(hash, licenseNumber.hashCode);
    hash = _SystemHash.combine(hash, issueDate.hashCode);
    hash = _SystemHash.combine(hash, expiryDate.hashCode);
    hash = _SystemHash.combine(hash, refNumber.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, image.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubmitMandiTaxProfileRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `mandiState` of this provider.
  String? get mandiState;

  /// The parameter `isLicense` of this provider.
  String? get isLicense;

  /// The parameter `licenseType` of this provider.
  String? get licenseType;

  /// The parameter `district` of this provider.
  String? get district;

  /// The parameter `licenseNumber` of this provider.
  String? get licenseNumber;

  /// The parameter `issueDate` of this provider.
  String? get issueDate;

  /// The parameter `expiryDate` of this provider.
  String? get expiryDate;

  /// The parameter `refNumber` of this provider.
  String? get refNumber;

  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `image` of this provider.
  File? get image;
}

class _SubmitMandiTaxProfileProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SubmitMandiTaxProfileRef {
  _SubmitMandiTaxProfileProviderElement(super.provider);

  @override
  String? get mandiState =>
      (origin as SubmitMandiTaxProfileProvider).mandiState;
  @override
  String? get isLicense => (origin as SubmitMandiTaxProfileProvider).isLicense;
  @override
  String? get licenseType =>
      (origin as SubmitMandiTaxProfileProvider).licenseType;
  @override
  String? get district => (origin as SubmitMandiTaxProfileProvider).district;
  @override
  String? get licenseNumber =>
      (origin as SubmitMandiTaxProfileProvider).licenseNumber;
  @override
  String? get issueDate => (origin as SubmitMandiTaxProfileProvider).issueDate;
  @override
  String? get expiryDate =>
      (origin as SubmitMandiTaxProfileProvider).expiryDate;
  @override
  String? get refNumber => (origin as SubmitMandiTaxProfileProvider).refNumber;
  @override
  String? get id => (origin as SubmitMandiTaxProfileProvider).id;
  @override
  File? get image => (origin as SubmitMandiTaxProfileProvider).image;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
