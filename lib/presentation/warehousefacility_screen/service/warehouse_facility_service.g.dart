// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_facility_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$terminalStackDataHash() => r'1c5a2f38330f6c499afb3ff6b69d059767f8fb05';

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

/// See also [terminalStackData].
@ProviderFor(terminalStackData)
const terminalStackDataProvider = TerminalStackDataFamily();

/// See also [terminalStackData].
class TerminalStackDataFamily
    extends Family<AsyncValue<TerminalStackDataModel>> {
  /// See also [terminalStackData].
  const TerminalStackDataFamily();

  /// See also [terminalStackData].
  TerminalStackDataProvider call({
    String? terminalId = "",
    String? commodityId = "",
    String? weightReq = "",
    String? inOutStatus = "",
    String? stackType = "",
    String? vehicleNo = "",
    String? driverNumber = "",
  }) {
    return TerminalStackDataProvider(
      terminalId: terminalId,
      commodityId: commodityId,
      weightReq: weightReq,
      inOutStatus: inOutStatus,
      stackType: stackType,
      vehicleNo: vehicleNo,
      driverNumber: driverNumber,
    );
  }

  @override
  TerminalStackDataProvider getProviderOverride(
    covariant TerminalStackDataProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      commodityId: provider.commodityId,
      weightReq: provider.weightReq,
      inOutStatus: provider.inOutStatus,
      stackType: provider.stackType,
      vehicleNo: provider.vehicleNo,
      driverNumber: provider.driverNumber,
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
  String? get name => r'terminalStackDataProvider';
}

/// See also [terminalStackData].
class TerminalStackDataProvider
    extends AutoDisposeFutureProvider<TerminalStackDataModel> {
  /// See also [terminalStackData].
  TerminalStackDataProvider({
    String? terminalId = "",
    String? commodityId = "",
    String? weightReq = "",
    String? inOutStatus = "",
    String? stackType = "",
    String? vehicleNo = "",
    String? driverNumber = "",
  }) : this._internal(
          (ref) => terminalStackData(
            ref as TerminalStackDataRef,
            terminalId: terminalId,
            commodityId: commodityId,
            weightReq: weightReq,
            inOutStatus: inOutStatus,
            stackType: stackType,
            vehicleNo: vehicleNo,
            driverNumber: driverNumber,
          ),
          from: terminalStackDataProvider,
          name: r'terminalStackDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$terminalStackDataHash,
          dependencies: TerminalStackDataFamily._dependencies,
          allTransitiveDependencies:
              TerminalStackDataFamily._allTransitiveDependencies,
          terminalId: terminalId,
          commodityId: commodityId,
          weightReq: weightReq,
          inOutStatus: inOutStatus,
          stackType: stackType,
          vehicleNo: vehicleNo,
          driverNumber: driverNumber,
        );

  TerminalStackDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.commodityId,
    required this.weightReq,
    required this.inOutStatus,
    required this.stackType,
    required this.vehicleNo,
    required this.driverNumber,
  }) : super.internal();

  final String? terminalId;
  final String? commodityId;
  final String? weightReq;
  final String? inOutStatus;
  final String? stackType;
  final String? vehicleNo;
  final String? driverNumber;

  @override
  Override overrideWith(
    FutureOr<TerminalStackDataModel> Function(TerminalStackDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TerminalStackDataProvider._internal(
        (ref) => create(ref as TerminalStackDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        commodityId: commodityId,
        weightReq: weightReq,
        inOutStatus: inOutStatus,
        stackType: stackType,
        vehicleNo: vehicleNo,
        driverNumber: driverNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TerminalStackDataModel> createElement() {
    return _TerminalStackDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TerminalStackDataProvider &&
        other.terminalId == terminalId &&
        other.commodityId == commodityId &&
        other.weightReq == weightReq &&
        other.inOutStatus == inOutStatus &&
        other.stackType == stackType &&
        other.vehicleNo == vehicleNo &&
        other.driverNumber == driverNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, weightReq.hashCode);
    hash = _SystemHash.combine(hash, inOutStatus.hashCode);
    hash = _SystemHash.combine(hash, stackType.hashCode);
    hash = _SystemHash.combine(hash, vehicleNo.hashCode);
    hash = _SystemHash.combine(hash, driverNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TerminalStackDataRef
    on AutoDisposeFutureProviderRef<TerminalStackDataModel> {
  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `weightReq` of this provider.
  String? get weightReq;

  /// The parameter `inOutStatus` of this provider.
  String? get inOutStatus;

  /// The parameter `stackType` of this provider.
  String? get stackType;

  /// The parameter `vehicleNo` of this provider.
  String? get vehicleNo;

  /// The parameter `driverNumber` of this provider.
  String? get driverNumber;
}

class _TerminalStackDataProviderElement
    extends AutoDisposeFutureProviderElement<TerminalStackDataModel>
    with TerminalStackDataRef {
  _TerminalStackDataProviderElement(super.provider);

  @override
  String? get terminalId => (origin as TerminalStackDataProvider).terminalId;
  @override
  String? get commodityId => (origin as TerminalStackDataProvider).commodityId;
  @override
  String? get weightReq => (origin as TerminalStackDataProvider).weightReq;
  @override
  String? get inOutStatus => (origin as TerminalStackDataProvider).inOutStatus;
  @override
  String? get stackType => (origin as TerminalStackDataProvider).stackType;
  @override
  String? get vehicleNo => (origin as TerminalStackDataProvider).vehicleNo;
  @override
  String? get driverNumber =>
      (origin as TerminalStackDataProvider).driverNumber;
}

String _$stackBookHistoryHash() => r'7cba68346dd135f21dd65b1b2bb664d581ad2d57';

/// See also [stackBookHistory].
@ProviderFor(stackBookHistory)
final stackBookHistoryProvider =
    AutoDisposeStreamProvider<StackBookHistoryModel>.internal(
  stackBookHistory,
  name: r'stackBookHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stackBookHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StackBookHistoryRef
    = AutoDisposeStreamProviderRef<StackBookHistoryModel>;
String _$inwardTripIdListHash() => r'26a64066654669d58682e05024ccce7e41cc4ef2';

/// See also [inwardTripIdList].
@ProviderFor(inwardTripIdList)
const inwardTripIdListProvider = InwardTripIdListFamily();

/// See also [inwardTripIdList].
class InwardTripIdListFamily extends Family<AsyncValue<TripIdModel>> {
  /// See also [inwardTripIdList].
  const InwardTripIdListFamily();

  /// See also [inwardTripIdList].
  InwardTripIdListProvider call({
    String? terminal,
    String? commodity,
  }) {
    return InwardTripIdListProvider(
      terminal: terminal,
      commodity: commodity,
    );
  }

  @override
  InwardTripIdListProvider getProviderOverride(
    covariant InwardTripIdListProvider provider,
  ) {
    return call(
      terminal: provider.terminal,
      commodity: provider.commodity,
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
  String? get name => r'inwardTripIdListProvider';
}

/// See also [inwardTripIdList].
class InwardTripIdListProvider extends AutoDisposeFutureProvider<TripIdModel> {
  /// See also [inwardTripIdList].
  InwardTripIdListProvider({
    String? terminal,
    String? commodity,
  }) : this._internal(
          (ref) => inwardTripIdList(
            ref as InwardTripIdListRef,
            terminal: terminal,
            commodity: commodity,
          ),
          from: inwardTripIdListProvider,
          name: r'inwardTripIdListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$inwardTripIdListHash,
          dependencies: InwardTripIdListFamily._dependencies,
          allTransitiveDependencies:
              InwardTripIdListFamily._allTransitiveDependencies,
          terminal: terminal,
          commodity: commodity,
        );

  InwardTripIdListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminal,
    required this.commodity,
  }) : super.internal();

  final String? terminal;
  final String? commodity;

  @override
  Override overrideWith(
    FutureOr<TripIdModel> Function(InwardTripIdListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InwardTripIdListProvider._internal(
        (ref) => create(ref as InwardTripIdListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminal: terminal,
        commodity: commodity,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TripIdModel> createElement() {
    return _InwardTripIdListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InwardTripIdListProvider &&
        other.terminal == terminal &&
        other.commodity == commodity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminal.hashCode);
    hash = _SystemHash.combine(hash, commodity.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InwardTripIdListRef on AutoDisposeFutureProviderRef<TripIdModel> {
  /// The parameter `terminal` of this provider.
  String? get terminal;

  /// The parameter `commodity` of this provider.
  String? get commodity;
}

class _InwardTripIdListProviderElement
    extends AutoDisposeFutureProviderElement<TripIdModel>
    with InwardTripIdListRef {
  _InwardTripIdListProviderElement(super.provider);

  @override
  String? get terminal => (origin as InwardTripIdListProvider).terminal;
  @override
  String? get commodity => (origin as InwardTripIdListProvider).commodity;
}

String _$outwardTripIdListHash() => r'b341b5a81eb8c0134203d68abef65ce1692ae065';

/// See also [outwardTripIdList].
@ProviderFor(outwardTripIdList)
const outwardTripIdListProvider = OutwardTripIdListFamily();

/// See also [outwardTripIdList].
class OutwardTripIdListFamily extends Family<AsyncValue<TripIdModel>> {
  /// See also [outwardTripIdList].
  const OutwardTripIdListFamily();

  /// See also [outwardTripIdList].
  OutwardTripIdListProvider call({
    String? terminal,
    String? commodity,
  }) {
    return OutwardTripIdListProvider(
      terminal: terminal,
      commodity: commodity,
    );
  }

  @override
  OutwardTripIdListProvider getProviderOverride(
    covariant OutwardTripIdListProvider provider,
  ) {
    return call(
      terminal: provider.terminal,
      commodity: provider.commodity,
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
  String? get name => r'outwardTripIdListProvider';
}

/// See also [outwardTripIdList].
class OutwardTripIdListProvider extends AutoDisposeFutureProvider<TripIdModel> {
  /// See also [outwardTripIdList].
  OutwardTripIdListProvider({
    String? terminal,
    String? commodity,
  }) : this._internal(
          (ref) => outwardTripIdList(
            ref as OutwardTripIdListRef,
            terminal: terminal,
            commodity: commodity,
          ),
          from: outwardTripIdListProvider,
          name: r'outwardTripIdListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$outwardTripIdListHash,
          dependencies: OutwardTripIdListFamily._dependencies,
          allTransitiveDependencies:
              OutwardTripIdListFamily._allTransitiveDependencies,
          terminal: terminal,
          commodity: commodity,
        );

  OutwardTripIdListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminal,
    required this.commodity,
  }) : super.internal();

  final String? terminal;
  final String? commodity;

  @override
  Override overrideWith(
    FutureOr<TripIdModel> Function(OutwardTripIdListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OutwardTripIdListProvider._internal(
        (ref) => create(ref as OutwardTripIdListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminal: terminal,
        commodity: commodity,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TripIdModel> createElement() {
    return _OutwardTripIdListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OutwardTripIdListProvider &&
        other.terminal == terminal &&
        other.commodity == commodity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminal.hashCode);
    hash = _SystemHash.combine(hash, commodity.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OutwardTripIdListRef on AutoDisposeFutureProviderRef<TripIdModel> {
  /// The parameter `terminal` of this provider.
  String? get terminal;

  /// The parameter `commodity` of this provider.
  String? get commodity;
}

class _OutwardTripIdListProviderElement
    extends AutoDisposeFutureProviderElement<TripIdModel>
    with OutwardTripIdListRef {
  _OutwardTripIdListProviderElement(super.provider);

  @override
  String? get terminal => (origin as OutwardTripIdListProvider).terminal;
  @override
  String? get commodity => (origin as OutwardTripIdListProvider).commodity;
}

String _$createStackRequestHash() =>
    r'8a44603e1db959df5fa580ab80f87f273f0d2227';

/// See also [createStackRequest].
@ProviderFor(createStackRequest)
const createStackRequestProvider = CreateStackRequestFamily();

/// See also [createStackRequest].
class CreateStackRequestFamily extends Family<AsyncValue<BaseResponseModel>> {
  /// See also [createStackRequest].
  const CreateStackRequestFamily();

  /// See also [createStackRequest].
  CreateStackRequestProvider call({
    String? stackType = '',
    String? requestWeight = '',
    String? inOutStatus = '',
    String? stackNum = '',
    String? stackRowId = '',
    String? commodityId = '',
    String? vhicalNo = '',
    String? lockInMonth = '',
    String? warehouseRent = '',
    String? driverNumber = '',
    String? releaseInv = '',
    String? releaseBags = '',
    String? transporterType,
    String? tripId,
  }) {
    return CreateStackRequestProvider(
      stackType: stackType,
      requestWeight: requestWeight,
      inOutStatus: inOutStatus,
      stackNum: stackNum,
      stackRowId: stackRowId,
      commodityId: commodityId,
      vhicalNo: vhicalNo,
      lockInMonth: lockInMonth,
      warehouseRent: warehouseRent,
      driverNumber: driverNumber,
      releaseInv: releaseInv,
      releaseBags: releaseBags,
      transporterType: transporterType,
      tripId: tripId,
    );
  }

  @override
  CreateStackRequestProvider getProviderOverride(
    covariant CreateStackRequestProvider provider,
  ) {
    return call(
      stackType: provider.stackType,
      requestWeight: provider.requestWeight,
      inOutStatus: provider.inOutStatus,
      stackNum: provider.stackNum,
      stackRowId: provider.stackRowId,
      commodityId: provider.commodityId,
      vhicalNo: provider.vhicalNo,
      lockInMonth: provider.lockInMonth,
      warehouseRent: provider.warehouseRent,
      driverNumber: provider.driverNumber,
      releaseInv: provider.releaseInv,
      releaseBags: provider.releaseBags,
      transporterType: provider.transporterType,
      tripId: provider.tripId,
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
  String? get name => r'createStackRequestProvider';
}

/// See also [createStackRequest].
class CreateStackRequestProvider
    extends AutoDisposeFutureProvider<BaseResponseModel> {
  /// See also [createStackRequest].
  CreateStackRequestProvider({
    String? stackType = '',
    String? requestWeight = '',
    String? inOutStatus = '',
    String? stackNum = '',
    String? stackRowId = '',
    String? commodityId = '',
    String? vhicalNo = '',
    String? lockInMonth = '',
    String? warehouseRent = '',
    String? driverNumber = '',
    String? releaseInv = '',
    String? releaseBags = '',
    String? transporterType,
    String? tripId,
  }) : this._internal(
          (ref) => createStackRequest(
            ref as CreateStackRequestRef,
            stackType: stackType,
            requestWeight: requestWeight,
            inOutStatus: inOutStatus,
            stackNum: stackNum,
            stackRowId: stackRowId,
            commodityId: commodityId,
            vhicalNo: vhicalNo,
            lockInMonth: lockInMonth,
            warehouseRent: warehouseRent,
            driverNumber: driverNumber,
            releaseInv: releaseInv,
            releaseBags: releaseBags,
            transporterType: transporterType,
            tripId: tripId,
          ),
          from: createStackRequestProvider,
          name: r'createStackRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createStackRequestHash,
          dependencies: CreateStackRequestFamily._dependencies,
          allTransitiveDependencies:
              CreateStackRequestFamily._allTransitiveDependencies,
          stackType: stackType,
          requestWeight: requestWeight,
          inOutStatus: inOutStatus,
          stackNum: stackNum,
          stackRowId: stackRowId,
          commodityId: commodityId,
          vhicalNo: vhicalNo,
          lockInMonth: lockInMonth,
          warehouseRent: warehouseRent,
          driverNumber: driverNumber,
          releaseInv: releaseInv,
          releaseBags: releaseBags,
          transporterType: transporterType,
          tripId: tripId,
        );

  CreateStackRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stackType,
    required this.requestWeight,
    required this.inOutStatus,
    required this.stackNum,
    required this.stackRowId,
    required this.commodityId,
    required this.vhicalNo,
    required this.lockInMonth,
    required this.warehouseRent,
    required this.driverNumber,
    required this.releaseInv,
    required this.releaseBags,
    required this.transporterType,
    required this.tripId,
  }) : super.internal();

  final String? stackType;
  final String? requestWeight;
  final String? inOutStatus;
  final String? stackNum;
  final String? stackRowId;
  final String? commodityId;
  final String? vhicalNo;
  final String? lockInMonth;
  final String? warehouseRent;
  final String? driverNumber;
  final String? releaseInv;
  final String? releaseBags;
  final String? transporterType;
  final String? tripId;

  @override
  Override overrideWith(
    FutureOr<BaseResponseModel> Function(CreateStackRequestRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateStackRequestProvider._internal(
        (ref) => create(ref as CreateStackRequestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stackType: stackType,
        requestWeight: requestWeight,
        inOutStatus: inOutStatus,
        stackNum: stackNum,
        stackRowId: stackRowId,
        commodityId: commodityId,
        vhicalNo: vhicalNo,
        lockInMonth: lockInMonth,
        warehouseRent: warehouseRent,
        driverNumber: driverNumber,
        releaseInv: releaseInv,
        releaseBags: releaseBags,
        transporterType: transporterType,
        tripId: tripId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseResponseModel> createElement() {
    return _CreateStackRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateStackRequestProvider &&
        other.stackType == stackType &&
        other.requestWeight == requestWeight &&
        other.inOutStatus == inOutStatus &&
        other.stackNum == stackNum &&
        other.stackRowId == stackRowId &&
        other.commodityId == commodityId &&
        other.vhicalNo == vhicalNo &&
        other.lockInMonth == lockInMonth &&
        other.warehouseRent == warehouseRent &&
        other.driverNumber == driverNumber &&
        other.releaseInv == releaseInv &&
        other.releaseBags == releaseBags &&
        other.transporterType == transporterType &&
        other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stackType.hashCode);
    hash = _SystemHash.combine(hash, requestWeight.hashCode);
    hash = _SystemHash.combine(hash, inOutStatus.hashCode);
    hash = _SystemHash.combine(hash, stackNum.hashCode);
    hash = _SystemHash.combine(hash, stackRowId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, vhicalNo.hashCode);
    hash = _SystemHash.combine(hash, lockInMonth.hashCode);
    hash = _SystemHash.combine(hash, warehouseRent.hashCode);
    hash = _SystemHash.combine(hash, driverNumber.hashCode);
    hash = _SystemHash.combine(hash, releaseInv.hashCode);
    hash = _SystemHash.combine(hash, releaseBags.hashCode);
    hash = _SystemHash.combine(hash, transporterType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateStackRequestRef on AutoDisposeFutureProviderRef<BaseResponseModel> {
  /// The parameter `stackType` of this provider.
  String? get stackType;

  /// The parameter `requestWeight` of this provider.
  String? get requestWeight;

  /// The parameter `inOutStatus` of this provider.
  String? get inOutStatus;

  /// The parameter `stackNum` of this provider.
  String? get stackNum;

  /// The parameter `stackRowId` of this provider.
  String? get stackRowId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `vhicalNo` of this provider.
  String? get vhicalNo;

  /// The parameter `lockInMonth` of this provider.
  String? get lockInMonth;

  /// The parameter `warehouseRent` of this provider.
  String? get warehouseRent;

  /// The parameter `driverNumber` of this provider.
  String? get driverNumber;

  /// The parameter `releaseInv` of this provider.
  String? get releaseInv;

  /// The parameter `releaseBags` of this provider.
  String? get releaseBags;

  /// The parameter `transporterType` of this provider.
  String? get transporterType;

  /// The parameter `tripId` of this provider.
  String? get tripId;
}

class _CreateStackRequestProviderElement
    extends AutoDisposeFutureProviderElement<BaseResponseModel>
    with CreateStackRequestRef {
  _CreateStackRequestProviderElement(super.provider);

  @override
  String? get stackType => (origin as CreateStackRequestProvider).stackType;
  @override
  String? get requestWeight =>
      (origin as CreateStackRequestProvider).requestWeight;
  @override
  String? get inOutStatus => (origin as CreateStackRequestProvider).inOutStatus;
  @override
  String? get stackNum => (origin as CreateStackRequestProvider).stackNum;
  @override
  String? get stackRowId => (origin as CreateStackRequestProvider).stackRowId;
  @override
  String? get commodityId => (origin as CreateStackRequestProvider).commodityId;
  @override
  String? get vhicalNo => (origin as CreateStackRequestProvider).vhicalNo;
  @override
  String? get lockInMonth => (origin as CreateStackRequestProvider).lockInMonth;
  @override
  String? get warehouseRent =>
      (origin as CreateStackRequestProvider).warehouseRent;
  @override
  String? get driverNumber =>
      (origin as CreateStackRequestProvider).driverNumber;
  @override
  String? get releaseInv => (origin as CreateStackRequestProvider).releaseInv;
  @override
  String? get releaseBags => (origin as CreateStackRequestProvider).releaseBags;
  @override
  String? get transporterType =>
      (origin as CreateStackRequestProvider).transporterType;
  @override
  String? get tripId => (origin as CreateStackRequestProvider).tripId;
}

String _$createStackRequestOutwardsHash() =>
    r'aade37e77ae648a3884b3432d3f9c3d4847321e0';

/// See also [createStackRequestOutwards].
@ProviderFor(createStackRequestOutwards)
const createStackRequestOutwardsProvider = CreateStackRequestOutwardsFamily();

/// See also [createStackRequestOutwards].
class CreateStackRequestOutwardsFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [createStackRequestOutwards].
  const CreateStackRequestOutwardsFamily();

  /// See also [createStackRequestOutwards].
  CreateStackRequestOutwardsProvider call({
    String? stackType = '',
    String? requestWeight = '',
    String? inOutStatus = '',
    String? stackNum = '',
    String? stackRowId = '',
    String? commodityId = '',
    String? vhicalNo = '',
    String? lockInMonth = '',
    String? warehouseRent = '',
    String? driverNumber = '',
    String? releaseInv = '',
    String? releaseBags = '',
    String? transporterType,
    String? tripId,
    String? autoInvoicing,
    String? poIds,
  }) {
    return CreateStackRequestOutwardsProvider(
      stackType: stackType,
      requestWeight: requestWeight,
      inOutStatus: inOutStatus,
      stackNum: stackNum,
      stackRowId: stackRowId,
      commodityId: commodityId,
      vhicalNo: vhicalNo,
      lockInMonth: lockInMonth,
      warehouseRent: warehouseRent,
      driverNumber: driverNumber,
      releaseInv: releaseInv,
      releaseBags: releaseBags,
      transporterType: transporterType,
      tripId: tripId,
      autoInvoicing: autoInvoicing,
      poIds: poIds,
    );
  }

  @override
  CreateStackRequestOutwardsProvider getProviderOverride(
    covariant CreateStackRequestOutwardsProvider provider,
  ) {
    return call(
      stackType: provider.stackType,
      requestWeight: provider.requestWeight,
      inOutStatus: provider.inOutStatus,
      stackNum: provider.stackNum,
      stackRowId: provider.stackRowId,
      commodityId: provider.commodityId,
      vhicalNo: provider.vhicalNo,
      lockInMonth: provider.lockInMonth,
      warehouseRent: provider.warehouseRent,
      driverNumber: provider.driverNumber,
      releaseInv: provider.releaseInv,
      releaseBags: provider.releaseBags,
      transporterType: provider.transporterType,
      tripId: provider.tripId,
      autoInvoicing: provider.autoInvoicing,
      poIds: provider.poIds,
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
  String? get name => r'createStackRequestOutwardsProvider';
}

/// See also [createStackRequestOutwards].
class CreateStackRequestOutwardsProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [createStackRequestOutwards].
  CreateStackRequestOutwardsProvider({
    String? stackType = '',
    String? requestWeight = '',
    String? inOutStatus = '',
    String? stackNum = '',
    String? stackRowId = '',
    String? commodityId = '',
    String? vhicalNo = '',
    String? lockInMonth = '',
    String? warehouseRent = '',
    String? driverNumber = '',
    String? releaseInv = '',
    String? releaseBags = '',
    String? transporterType,
    String? tripId,
    String? autoInvoicing,
    String? poIds,
  }) : this._internal(
          (ref) => createStackRequestOutwards(
            ref as CreateStackRequestOutwardsRef,
            stackType: stackType,
            requestWeight: requestWeight,
            inOutStatus: inOutStatus,
            stackNum: stackNum,
            stackRowId: stackRowId,
            commodityId: commodityId,
            vhicalNo: vhicalNo,
            lockInMonth: lockInMonth,
            warehouseRent: warehouseRent,
            driverNumber: driverNumber,
            releaseInv: releaseInv,
            releaseBags: releaseBags,
            transporterType: transporterType,
            tripId: tripId,
            autoInvoicing: autoInvoicing,
            poIds: poIds,
          ),
          from: createStackRequestOutwardsProvider,
          name: r'createStackRequestOutwardsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createStackRequestOutwardsHash,
          dependencies: CreateStackRequestOutwardsFamily._dependencies,
          allTransitiveDependencies:
              CreateStackRequestOutwardsFamily._allTransitiveDependencies,
          stackType: stackType,
          requestWeight: requestWeight,
          inOutStatus: inOutStatus,
          stackNum: stackNum,
          stackRowId: stackRowId,
          commodityId: commodityId,
          vhicalNo: vhicalNo,
          lockInMonth: lockInMonth,
          warehouseRent: warehouseRent,
          driverNumber: driverNumber,
          releaseInv: releaseInv,
          releaseBags: releaseBags,
          transporterType: transporterType,
          tripId: tripId,
          autoInvoicing: autoInvoicing,
          poIds: poIds,
        );

  CreateStackRequestOutwardsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stackType,
    required this.requestWeight,
    required this.inOutStatus,
    required this.stackNum,
    required this.stackRowId,
    required this.commodityId,
    required this.vhicalNo,
    required this.lockInMonth,
    required this.warehouseRent,
    required this.driverNumber,
    required this.releaseInv,
    required this.releaseBags,
    required this.transporterType,
    required this.tripId,
    required this.autoInvoicing,
    required this.poIds,
  }) : super.internal();

  final String? stackType;
  final String? requestWeight;
  final String? inOutStatus;
  final String? stackNum;
  final String? stackRowId;
  final String? commodityId;
  final String? vhicalNo;
  final String? lockInMonth;
  final String? warehouseRent;
  final String? driverNumber;
  final String? releaseInv;
  final String? releaseBags;
  final String? transporterType;
  final String? tripId;
  final String? autoInvoicing;
  final String? poIds;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(
            CreateStackRequestOutwardsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateStackRequestOutwardsProvider._internal(
        (ref) => create(ref as CreateStackRequestOutwardsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stackType: stackType,
        requestWeight: requestWeight,
        inOutStatus: inOutStatus,
        stackNum: stackNum,
        stackRowId: stackRowId,
        commodityId: commodityId,
        vhicalNo: vhicalNo,
        lockInMonth: lockInMonth,
        warehouseRent: warehouseRent,
        driverNumber: driverNumber,
        releaseInv: releaseInv,
        releaseBags: releaseBags,
        transporterType: transporterType,
        tripId: tripId,
        autoInvoicing: autoInvoicing,
        poIds: poIds,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _CreateStackRequestOutwardsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateStackRequestOutwardsProvider &&
        other.stackType == stackType &&
        other.requestWeight == requestWeight &&
        other.inOutStatus == inOutStatus &&
        other.stackNum == stackNum &&
        other.stackRowId == stackRowId &&
        other.commodityId == commodityId &&
        other.vhicalNo == vhicalNo &&
        other.lockInMonth == lockInMonth &&
        other.warehouseRent == warehouseRent &&
        other.driverNumber == driverNumber &&
        other.releaseInv == releaseInv &&
        other.releaseBags == releaseBags &&
        other.transporterType == transporterType &&
        other.tripId == tripId &&
        other.autoInvoicing == autoInvoicing &&
        other.poIds == poIds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stackType.hashCode);
    hash = _SystemHash.combine(hash, requestWeight.hashCode);
    hash = _SystemHash.combine(hash, inOutStatus.hashCode);
    hash = _SystemHash.combine(hash, stackNum.hashCode);
    hash = _SystemHash.combine(hash, stackRowId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, vhicalNo.hashCode);
    hash = _SystemHash.combine(hash, lockInMonth.hashCode);
    hash = _SystemHash.combine(hash, warehouseRent.hashCode);
    hash = _SystemHash.combine(hash, driverNumber.hashCode);
    hash = _SystemHash.combine(hash, releaseInv.hashCode);
    hash = _SystemHash.combine(hash, releaseBags.hashCode);
    hash = _SystemHash.combine(hash, transporterType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);
    hash = _SystemHash.combine(hash, autoInvoicing.hashCode);
    hash = _SystemHash.combine(hash, poIds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateStackRequestOutwardsRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `stackType` of this provider.
  String? get stackType;

  /// The parameter `requestWeight` of this provider.
  String? get requestWeight;

  /// The parameter `inOutStatus` of this provider.
  String? get inOutStatus;

  /// The parameter `stackNum` of this provider.
  String? get stackNum;

  /// The parameter `stackRowId` of this provider.
  String? get stackRowId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `vhicalNo` of this provider.
  String? get vhicalNo;

  /// The parameter `lockInMonth` of this provider.
  String? get lockInMonth;

  /// The parameter `warehouseRent` of this provider.
  String? get warehouseRent;

  /// The parameter `driverNumber` of this provider.
  String? get driverNumber;

  /// The parameter `releaseInv` of this provider.
  String? get releaseInv;

  /// The parameter `releaseBags` of this provider.
  String? get releaseBags;

  /// The parameter `transporterType` of this provider.
  String? get transporterType;

  /// The parameter `tripId` of this provider.
  String? get tripId;

  /// The parameter `autoInvoicing` of this provider.
  String? get autoInvoicing;

  /// The parameter `poIds` of this provider.
  String? get poIds;
}

class _CreateStackRequestOutwardsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with CreateStackRequestOutwardsRef {
  _CreateStackRequestOutwardsProviderElement(super.provider);

  @override
  String? get stackType =>
      (origin as CreateStackRequestOutwardsProvider).stackType;
  @override
  String? get requestWeight =>
      (origin as CreateStackRequestOutwardsProvider).requestWeight;
  @override
  String? get inOutStatus =>
      (origin as CreateStackRequestOutwardsProvider).inOutStatus;
  @override
  String? get stackNum =>
      (origin as CreateStackRequestOutwardsProvider).stackNum;
  @override
  String? get stackRowId =>
      (origin as CreateStackRequestOutwardsProvider).stackRowId;
  @override
  String? get commodityId =>
      (origin as CreateStackRequestOutwardsProvider).commodityId;
  @override
  String? get vhicalNo =>
      (origin as CreateStackRequestOutwardsProvider).vhicalNo;
  @override
  String? get lockInMonth =>
      (origin as CreateStackRequestOutwardsProvider).lockInMonth;
  @override
  String? get warehouseRent =>
      (origin as CreateStackRequestOutwardsProvider).warehouseRent;
  @override
  String? get driverNumber =>
      (origin as CreateStackRequestOutwardsProvider).driverNumber;
  @override
  String? get releaseInv =>
      (origin as CreateStackRequestOutwardsProvider).releaseInv;
  @override
  String? get releaseBags =>
      (origin as CreateStackRequestOutwardsProvider).releaseBags;
  @override
  String? get transporterType =>
      (origin as CreateStackRequestOutwardsProvider).transporterType;
  @override
  String? get tripId => (origin as CreateStackRequestOutwardsProvider).tripId;
  @override
  String? get autoInvoicing =>
      (origin as CreateStackRequestOutwardsProvider).autoInvoicing;
  @override
  String? get poIds => (origin as CreateStackRequestOutwardsProvider).poIds;
}

String _$inwardsTerminalHash() => r'3ddd09b0041237a67e7aa3ed30b46d8160f8de8d';

/// See also [inwardsTerminal].
@ProviderFor(inwardsTerminal)
const inwardsTerminalProvider = InwardsTerminalFamily();

/// See also [inwardsTerminal].
class InwardsTerminalFamily
    extends Family<AsyncValue<InwardsTerminalResponse>> {
  /// See also [inwardsTerminal].
  const InwardsTerminalFamily();

  /// See also [inwardsTerminal].
  InwardsTerminalProvider call({
    String? terminalId = "",
    String? stackRequestId = "",
    String? commodityId,
  }) {
    return InwardsTerminalProvider(
      terminalId: terminalId,
      stackRequestId: stackRequestId,
      commodityId: commodityId,
    );
  }

  @override
  InwardsTerminalProvider getProviderOverride(
    covariant InwardsTerminalProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      stackRequestId: provider.stackRequestId,
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
  String? get name => r'inwardsTerminalProvider';
}

/// See also [inwardsTerminal].
class InwardsTerminalProvider
    extends AutoDisposeStreamProvider<InwardsTerminalResponse> {
  /// See also [inwardsTerminal].
  InwardsTerminalProvider({
    String? terminalId = "",
    String? stackRequestId = "",
    String? commodityId,
  }) : this._internal(
          (ref) => inwardsTerminal(
            ref as InwardsTerminalRef,
            terminalId: terminalId,
            stackRequestId: stackRequestId,
            commodityId: commodityId,
          ),
          from: inwardsTerminalProvider,
          name: r'inwardsTerminalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$inwardsTerminalHash,
          dependencies: InwardsTerminalFamily._dependencies,
          allTransitiveDependencies:
              InwardsTerminalFamily._allTransitiveDependencies,
          terminalId: terminalId,
          stackRequestId: stackRequestId,
          commodityId: commodityId,
        );

  InwardsTerminalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.stackRequestId,
    required this.commodityId,
  }) : super.internal();

  final String? terminalId;
  final String? stackRequestId;
  final String? commodityId;

  @override
  Override overrideWith(
    Stream<InwardsTerminalResponse> Function(InwardsTerminalRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InwardsTerminalProvider._internal(
        (ref) => create(ref as InwardsTerminalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        stackRequestId: stackRequestId,
        commodityId: commodityId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<InwardsTerminalResponse> createElement() {
    return _InwardsTerminalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InwardsTerminalProvider &&
        other.terminalId == terminalId &&
        other.stackRequestId == stackRequestId &&
        other.commodityId == commodityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, stackRequestId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InwardsTerminalRef
    on AutoDisposeStreamProviderRef<InwardsTerminalResponse> {
  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `stackRequestId` of this provider.
  String? get stackRequestId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;
}

class _InwardsTerminalProviderElement
    extends AutoDisposeStreamProviderElement<InwardsTerminalResponse>
    with InwardsTerminalRef {
  _InwardsTerminalProviderElement(super.provider);

  @override
  String? get terminalId => (origin as InwardsTerminalProvider).terminalId;
  @override
  String? get stackRequestId =>
      (origin as InwardsTerminalProvider).stackRequestId;
  @override
  String? get commodityId => (origin as InwardsTerminalProvider).commodityId;
}

String _$inwardsCommodityHash() => r'5977c3425a8dd2361b567f9f91d01ec243f653fe';

/// See also [inwardsCommodity].
@ProviderFor(inwardsCommodity)
const inwardsCommodityProvider = InwardsCommodityFamily();

/// See also [inwardsCommodity].
class InwardsCommodityFamily
    extends Family<AsyncValue<InwardsTerminalResponse>> {
  /// See also [inwardsCommodity].
  const InwardsCommodityFamily();

  /// See also [inwardsCommodity].
  InwardsCommodityProvider call({
    String? terminalId = "",
    String? stackRequestId = "",
    String? commodityId,
  }) {
    return InwardsCommodityProvider(
      terminalId: terminalId,
      stackRequestId: stackRequestId,
      commodityId: commodityId,
    );
  }

  @override
  InwardsCommodityProvider getProviderOverride(
    covariant InwardsCommodityProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      stackRequestId: provider.stackRequestId,
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
  String? get name => r'inwardsCommodityProvider';
}

/// See also [inwardsCommodity].
class InwardsCommodityProvider
    extends AutoDisposeFutureProvider<InwardsTerminalResponse> {
  /// See also [inwardsCommodity].
  InwardsCommodityProvider({
    String? terminalId = "",
    String? stackRequestId = "",
    String? commodityId,
  }) : this._internal(
          (ref) => inwardsCommodity(
            ref as InwardsCommodityRef,
            terminalId: terminalId,
            stackRequestId: stackRequestId,
            commodityId: commodityId,
          ),
          from: inwardsCommodityProvider,
          name: r'inwardsCommodityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$inwardsCommodityHash,
          dependencies: InwardsCommodityFamily._dependencies,
          allTransitiveDependencies:
              InwardsCommodityFamily._allTransitiveDependencies,
          terminalId: terminalId,
          stackRequestId: stackRequestId,
          commodityId: commodityId,
        );

  InwardsCommodityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.stackRequestId,
    required this.commodityId,
  }) : super.internal();

  final String? terminalId;
  final String? stackRequestId;
  final String? commodityId;

  @override
  Override overrideWith(
    FutureOr<InwardsTerminalResponse> Function(InwardsCommodityRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InwardsCommodityProvider._internal(
        (ref) => create(ref as InwardsCommodityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        stackRequestId: stackRequestId,
        commodityId: commodityId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<InwardsTerminalResponse> createElement() {
    return _InwardsCommodityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InwardsCommodityProvider &&
        other.terminalId == terminalId &&
        other.stackRequestId == stackRequestId &&
        other.commodityId == commodityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, stackRequestId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InwardsCommodityRef
    on AutoDisposeFutureProviderRef<InwardsTerminalResponse> {
  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `stackRequestId` of this provider.
  String? get stackRequestId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;
}

class _InwardsCommodityProviderElement
    extends AutoDisposeFutureProviderElement<InwardsTerminalResponse>
    with InwardsCommodityRef {
  _InwardsCommodityProviderElement(super.provider);

  @override
  String? get terminalId => (origin as InwardsCommodityProvider).terminalId;
  @override
  String? get stackRequestId =>
      (origin as InwardsCommodityProvider).stackRequestId;
  @override
  String? get commodityId => (origin as InwardsCommodityProvider).commodityId;
}

String _$inwardsStackHash() => r'aa7b27afa7b637c37dea58963642e177a78284d0';

/// See also [inwardsStack].
@ProviderFor(inwardsStack)
const inwardsStackProvider = InwardsStackFamily();

/// See also [inwardsStack].
class InwardsStackFamily extends Family<AsyncValue<InwardsTerminalResponse>> {
  /// See also [inwardsStack].
  const InwardsStackFamily();

  /// See also [inwardsStack].
  InwardsStackProvider call({
    String? terminalId = "",
    String? stackRequestId = "",
    String? commodityId,
  }) {
    return InwardsStackProvider(
      terminalId: terminalId,
      stackRequestId: stackRequestId,
      commodityId: commodityId,
    );
  }

  @override
  InwardsStackProvider getProviderOverride(
    covariant InwardsStackProvider provider,
  ) {
    return call(
      terminalId: provider.terminalId,
      stackRequestId: provider.stackRequestId,
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
  String? get name => r'inwardsStackProvider';
}

/// See also [inwardsStack].
class InwardsStackProvider
    extends AutoDisposeFutureProvider<InwardsTerminalResponse> {
  /// See also [inwardsStack].
  InwardsStackProvider({
    String? terminalId = "",
    String? stackRequestId = "",
    String? commodityId,
  }) : this._internal(
          (ref) => inwardsStack(
            ref as InwardsStackRef,
            terminalId: terminalId,
            stackRequestId: stackRequestId,
            commodityId: commodityId,
          ),
          from: inwardsStackProvider,
          name: r'inwardsStackProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$inwardsStackHash,
          dependencies: InwardsStackFamily._dependencies,
          allTransitiveDependencies:
              InwardsStackFamily._allTransitiveDependencies,
          terminalId: terminalId,
          stackRequestId: stackRequestId,
          commodityId: commodityId,
        );

  InwardsStackProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalId,
    required this.stackRequestId,
    required this.commodityId,
  }) : super.internal();

  final String? terminalId;
  final String? stackRequestId;
  final String? commodityId;

  @override
  Override overrideWith(
    FutureOr<InwardsTerminalResponse> Function(InwardsStackRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InwardsStackProvider._internal(
        (ref) => create(ref as InwardsStackRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalId: terminalId,
        stackRequestId: stackRequestId,
        commodityId: commodityId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<InwardsTerminalResponse> createElement() {
    return _InwardsStackProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InwardsStackProvider &&
        other.terminalId == terminalId &&
        other.stackRequestId == stackRequestId &&
        other.commodityId == commodityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, stackRequestId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InwardsStackRef on AutoDisposeFutureProviderRef<InwardsTerminalResponse> {
  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `stackRequestId` of this provider.
  String? get stackRequestId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;
}

class _InwardsStackProviderElement
    extends AutoDisposeFutureProviderElement<InwardsTerminalResponse>
    with InwardsStackRef {
  _InwardsStackProviderElement(super.provider);

  @override
  String? get terminalId => (origin as InwardsStackProvider).terminalId;
  @override
  String? get stackRequestId => (origin as InwardsStackProvider).stackRequestId;
  @override
  String? get commodityId => (origin as InwardsStackProvider).commodityId;
}

String _$inwardsListHash() => r'986d133d744fc73b1f6120e8b54ccdd697317410';

/// See also [inwardsList].
@ProviderFor(inwardsList)
final inwardsListProvider =
    AutoDisposeFutureProvider<InwardsListModel>.internal(
  inwardsList,
  name: r'inwardsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$inwardsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InwardsListRef = AutoDisposeFutureProviderRef<InwardsListModel>;
String _$outwardsListHash() => r'fc82bb5f6e6784f68187505b8d7b9c04bfaca8e3';

/// See also [outwardsList].
@ProviderFor(outwardsList)
final outwardsListProvider =
    AutoDisposeStreamProvider<OutwardsListResponseModel>.internal(
  outwardsList,
  name: r'outwardsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$outwardsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OutwardsListRef
    = AutoDisposeStreamProviderRef<OutwardsListResponseModel>;
String _$rateCardHash() => r'be98629a047714f0507efb089062df1d11cfe55f';

/// See also [rateCard].
@ProviderFor(rateCard)
final rateCardProvider = AutoDisposeFutureProvider<RateCardModel>.internal(
  rateCard,
  name: r'rateCardProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$rateCardHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RateCardRef = AutoDisposeFutureProviderRef<RateCardModel>;
String _$rejectOrderHash() => r'dc4e03e9e3d7e44a8a5d2d563b6ddd85867b92bb';

/// See also [rejectOrder].
@ProviderFor(rejectOrder)
const rejectOrderProvider = RejectOrderFamily();

/// See also [rejectOrder].
class RejectOrderFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [rejectOrder].
  const RejectOrderFamily();

  /// See also [rejectOrder].
  RejectOrderProvider call({
    String? orderId,
  }) {
    return RejectOrderProvider(
      orderId: orderId,
    );
  }

  @override
  RejectOrderProvider getProviderOverride(
    covariant RejectOrderProvider provider,
  ) {
    return call(
      orderId: provider.orderId,
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
  String? get name => r'rejectOrderProvider';
}

/// See also [rejectOrder].
class RejectOrderProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [rejectOrder].
  RejectOrderProvider({
    String? orderId,
  }) : this._internal(
          (ref) => rejectOrder(
            ref as RejectOrderRef,
            orderId: orderId,
          ),
          from: rejectOrderProvider,
          name: r'rejectOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$rejectOrderHash,
          dependencies: RejectOrderFamily._dependencies,
          allTransitiveDependencies:
              RejectOrderFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  RejectOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String? orderId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(RejectOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RejectOrderProvider._internal(
        (ref) => create(ref as RejectOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _RejectOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RejectOrderProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RejectOrderRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `orderId` of this provider.
  String? get orderId;
}

class _RejectOrderProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RejectOrderRef {
  _RejectOrderProviderElement(super.provider);

  @override
  String? get orderId => (origin as RejectOrderProvider).orderId;
}

String _$rejectOutwardsRequestHash() =>
    r'39de35703419b1f567b4b9f8a73860d5c58606f0';

/// See also [rejectOutwardsRequest].
@ProviderFor(rejectOutwardsRequest)
const rejectOutwardsRequestProvider = RejectOutwardsRequestFamily();

/// See also [rejectOutwardsRequest].
class RejectOutwardsRequestFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [rejectOutwardsRequest].
  const RejectOutwardsRequestFamily();

  /// See also [rejectOutwardsRequest].
  RejectOutwardsRequestProvider call({
    String? id,
  }) {
    return RejectOutwardsRequestProvider(
      id: id,
    );
  }

  @override
  RejectOutwardsRequestProvider getProviderOverride(
    covariant RejectOutwardsRequestProvider provider,
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
  String? get name => r'rejectOutwardsRequestProvider';
}

/// See also [rejectOutwardsRequest].
class RejectOutwardsRequestProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [rejectOutwardsRequest].
  RejectOutwardsRequestProvider({
    String? id,
  }) : this._internal(
          (ref) => rejectOutwardsRequest(
            ref as RejectOutwardsRequestRef,
            id: id,
          ),
          from: rejectOutwardsRequestProvider,
          name: r'rejectOutwardsRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$rejectOutwardsRequestHash,
          dependencies: RejectOutwardsRequestFamily._dependencies,
          allTransitiveDependencies:
              RejectOutwardsRequestFamily._allTransitiveDependencies,
          id: id,
        );

  RejectOutwardsRequestProvider._internal(
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
    FutureOr<Map<String, dynamic>> Function(RejectOutwardsRequestRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RejectOutwardsRequestProvider._internal(
        (ref) => create(ref as RejectOutwardsRequestRef),
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
    return _RejectOutwardsRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RejectOutwardsRequestProvider && other.id == id;
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
mixin RejectOutwardsRequestRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _RejectOutwardsRequestProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RejectOutwardsRequestRef {
  _RejectOutwardsRequestProviderElement(super.provider);

  @override
  String? get id => (origin as RejectOutwardsRequestProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
