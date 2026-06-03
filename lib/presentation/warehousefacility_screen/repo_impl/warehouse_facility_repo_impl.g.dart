// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_facility_repo_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inwardStackBookHash() => r'75217ef35ff7391f20c54198a8f078ddff0be80f';

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

/// See also [inwardStackBook].
@ProviderFor(inwardStackBook)
const inwardStackBookProvider = InwardStackBookFamily();

/// See also [inwardStackBook].
class InwardStackBookFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [inwardStackBook].
  const InwardStackBookFamily();

  /// See also [inwardStackBook].
  InwardStackBookProvider call({
    dynamic stackrowId,
    dynamic weight,
    dynamic vehicleNo,
    dynamic stackId,
    dynamic salesStatus,
    dynamic commodityId,
    dynamic terminalId,
    dynamic stackNo,
    dynamic driverNo,
    dynamic transporterType,
    dynamic tripId,
    String? fileImage = "",
  }) {
    return InwardStackBookProvider(
      stackrowId: stackrowId,
      weight: weight,
      vehicleNo: vehicleNo,
      stackId: stackId,
      salesStatus: salesStatus,
      commodityId: commodityId,
      terminalId: terminalId,
      stackNo: stackNo,
      driverNo: driverNo,
      transporterType: transporterType,
      tripId: tripId,
      fileImage: fileImage,
    );
  }

  @override
  InwardStackBookProvider getProviderOverride(
    covariant InwardStackBookProvider provider,
  ) {
    return call(
      stackrowId: provider.stackrowId,
      weight: provider.weight,
      vehicleNo: provider.vehicleNo,
      stackId: provider.stackId,
      salesStatus: provider.salesStatus,
      commodityId: provider.commodityId,
      terminalId: provider.terminalId,
      stackNo: provider.stackNo,
      driverNo: provider.driverNo,
      transporterType: provider.transporterType,
      tripId: provider.tripId,
      fileImage: provider.fileImage,
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
  String? get name => r'inwardStackBookProvider';
}

/// See also [inwardStackBook].
class InwardStackBookProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [inwardStackBook].
  InwardStackBookProvider({
    dynamic stackrowId,
    dynamic weight,
    dynamic vehicleNo,
    dynamic stackId,
    dynamic salesStatus,
    dynamic commodityId,
    dynamic terminalId,
    dynamic stackNo,
    dynamic driverNo,
    dynamic transporterType,
    dynamic tripId,
    String? fileImage = "",
  }) : this._internal(
          (ref) => inwardStackBook(
            ref as InwardStackBookRef,
            stackrowId: stackrowId,
            weight: weight,
            vehicleNo: vehicleNo,
            stackId: stackId,
            salesStatus: salesStatus,
            commodityId: commodityId,
            terminalId: terminalId,
            stackNo: stackNo,
            driverNo: driverNo,
            transporterType: transporterType,
            tripId: tripId,
            fileImage: fileImage,
          ),
          from: inwardStackBookProvider,
          name: r'inwardStackBookProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$inwardStackBookHash,
          dependencies: InwardStackBookFamily._dependencies,
          allTransitiveDependencies:
              InwardStackBookFamily._allTransitiveDependencies,
          stackrowId: stackrowId,
          weight: weight,
          vehicleNo: vehicleNo,
          stackId: stackId,
          salesStatus: salesStatus,
          commodityId: commodityId,
          terminalId: terminalId,
          stackNo: stackNo,
          driverNo: driverNo,
          transporterType: transporterType,
          tripId: tripId,
          fileImage: fileImage,
        );

  InwardStackBookProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.stackrowId,
    required this.weight,
    required this.vehicleNo,
    required this.stackId,
    required this.salesStatus,
    required this.commodityId,
    required this.terminalId,
    required this.stackNo,
    required this.driverNo,
    required this.transporterType,
    required this.tripId,
    required this.fileImage,
  }) : super.internal();

  final dynamic stackrowId;
  final dynamic weight;
  final dynamic vehicleNo;
  final dynamic stackId;
  final dynamic salesStatus;
  final dynamic commodityId;
  final dynamic terminalId;
  final dynamic stackNo;
  final dynamic driverNo;
  final dynamic transporterType;
  final dynamic tripId;
  final String? fileImage;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(InwardStackBookRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InwardStackBookProvider._internal(
        (ref) => create(ref as InwardStackBookRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        stackrowId: stackrowId,
        weight: weight,
        vehicleNo: vehicleNo,
        stackId: stackId,
        salesStatus: salesStatus,
        commodityId: commodityId,
        terminalId: terminalId,
        stackNo: stackNo,
        driverNo: driverNo,
        transporterType: transporterType,
        tripId: tripId,
        fileImage: fileImage,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _InwardStackBookProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InwardStackBookProvider &&
        other.stackrowId == stackrowId &&
        other.weight == weight &&
        other.vehicleNo == vehicleNo &&
        other.stackId == stackId &&
        other.salesStatus == salesStatus &&
        other.commodityId == commodityId &&
        other.terminalId == terminalId &&
        other.stackNo == stackNo &&
        other.driverNo == driverNo &&
        other.transporterType == transporterType &&
        other.tripId == tripId &&
        other.fileImage == fileImage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, stackrowId.hashCode);
    hash = _SystemHash.combine(hash, weight.hashCode);
    hash = _SystemHash.combine(hash, vehicleNo.hashCode);
    hash = _SystemHash.combine(hash, stackId.hashCode);
    hash = _SystemHash.combine(hash, salesStatus.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, stackNo.hashCode);
    hash = _SystemHash.combine(hash, driverNo.hashCode);
    hash = _SystemHash.combine(hash, transporterType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);
    hash = _SystemHash.combine(hash, fileImage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InwardStackBookRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `stackrowId` of this provider.
  dynamic get stackrowId;

  /// The parameter `weight` of this provider.
  dynamic get weight;

  /// The parameter `vehicleNo` of this provider.
  dynamic get vehicleNo;

  /// The parameter `stackId` of this provider.
  dynamic get stackId;

  /// The parameter `salesStatus` of this provider.
  dynamic get salesStatus;

  /// The parameter `commodityId` of this provider.
  dynamic get commodityId;

  /// The parameter `terminalId` of this provider.
  dynamic get terminalId;

  /// The parameter `stackNo` of this provider.
  dynamic get stackNo;

  /// The parameter `driverNo` of this provider.
  dynamic get driverNo;

  /// The parameter `transporterType` of this provider.
  dynamic get transporterType;

  /// The parameter `tripId` of this provider.
  dynamic get tripId;

  /// The parameter `fileImage` of this provider.
  String? get fileImage;
}

class _InwardStackBookProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with InwardStackBookRef {
  _InwardStackBookProviderElement(super.provider);

  @override
  dynamic get stackrowId => (origin as InwardStackBookProvider).stackrowId;
  @override
  dynamic get weight => (origin as InwardStackBookProvider).weight;
  @override
  dynamic get vehicleNo => (origin as InwardStackBookProvider).vehicleNo;
  @override
  dynamic get stackId => (origin as InwardStackBookProvider).stackId;
  @override
  dynamic get salesStatus => (origin as InwardStackBookProvider).salesStatus;
  @override
  dynamic get commodityId => (origin as InwardStackBookProvider).commodityId;
  @override
  dynamic get terminalId => (origin as InwardStackBookProvider).terminalId;
  @override
  dynamic get stackNo => (origin as InwardStackBookProvider).stackNo;
  @override
  dynamic get driverNo => (origin as InwardStackBookProvider).driverNo;
  @override
  dynamic get transporterType =>
      (origin as InwardStackBookProvider).transporterType;
  @override
  dynamic get tripId => (origin as InwardStackBookProvider).tripId;
  @override
  String? get fileImage => (origin as InwardStackBookProvider).fileImage;
}

String _$getAvailableStacksHash() =>
    r'c612b59c397b3ed29d933e8e5d728340e9422403';

/// See also [getAvailableStacks].
@ProviderFor(getAvailableStacks)
const getAvailableStacksProvider = GetAvailableStacksFamily();

/// See also [getAvailableStacks].
class GetAvailableStacksFamily
    extends Family<AsyncValue<AvailableWarehouseStacksModel>> {
  /// See also [getAvailableStacks].
  const GetAvailableStacksFamily();

  /// See also [getAvailableStacks].
  GetAvailableStacksProvider call({
    required dynamic terminalid,
    required dynamic commodityid,
    required dynamic weightreqst,
    required dynamic in_out_status,
    required dynamic stack_type,
    required dynamic vehicle_no,
    required dynamic driverNumber,
  }) {
    return GetAvailableStacksProvider(
      terminalid: terminalid,
      commodityid: commodityid,
      weightreqst: weightreqst,
      in_out_status: in_out_status,
      stack_type: stack_type,
      vehicle_no: vehicle_no,
      driverNumber: driverNumber,
    );
  }

  @override
  GetAvailableStacksProvider getProviderOverride(
    covariant GetAvailableStacksProvider provider,
  ) {
    return call(
      terminalid: provider.terminalid,
      commodityid: provider.commodityid,
      weightreqst: provider.weightreqst,
      in_out_status: provider.in_out_status,
      stack_type: provider.stack_type,
      vehicle_no: provider.vehicle_no,
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
  String? get name => r'getAvailableStacksProvider';
}

/// See also [getAvailableStacks].
class GetAvailableStacksProvider
    extends AutoDisposeFutureProvider<AvailableWarehouseStacksModel> {
  /// See also [getAvailableStacks].
  GetAvailableStacksProvider({
    required dynamic terminalid,
    required dynamic commodityid,
    required dynamic weightreqst,
    required dynamic in_out_status,
    required dynamic stack_type,
    required dynamic vehicle_no,
    required dynamic driverNumber,
  }) : this._internal(
          (ref) => getAvailableStacks(
            ref as GetAvailableStacksRef,
            terminalid: terminalid,
            commodityid: commodityid,
            weightreqst: weightreqst,
            in_out_status: in_out_status,
            stack_type: stack_type,
            vehicle_no: vehicle_no,
            driverNumber: driverNumber,
          ),
          from: getAvailableStacksProvider,
          name: r'getAvailableStacksProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAvailableStacksHash,
          dependencies: GetAvailableStacksFamily._dependencies,
          allTransitiveDependencies:
              GetAvailableStacksFamily._allTransitiveDependencies,
          terminalid: terminalid,
          commodityid: commodityid,
          weightreqst: weightreqst,
          in_out_status: in_out_status,
          stack_type: stack_type,
          vehicle_no: vehicle_no,
          driverNumber: driverNumber,
        );

  GetAvailableStacksProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminalid,
    required this.commodityid,
    required this.weightreqst,
    required this.in_out_status,
    required this.stack_type,
    required this.vehicle_no,
    required this.driverNumber,
  }) : super.internal();

  final dynamic terminalid;
  final dynamic commodityid;
  final dynamic weightreqst;
  final dynamic in_out_status;
  final dynamic stack_type;
  final dynamic vehicle_no;
  final dynamic driverNumber;

  @override
  Override overrideWith(
    FutureOr<AvailableWarehouseStacksModel> Function(
            GetAvailableStacksRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAvailableStacksProvider._internal(
        (ref) => create(ref as GetAvailableStacksRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminalid: terminalid,
        commodityid: commodityid,
        weightreqst: weightreqst,
        in_out_status: in_out_status,
        stack_type: stack_type,
        vehicle_no: vehicle_no,
        driverNumber: driverNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AvailableWarehouseStacksModel>
      createElement() {
    return _GetAvailableStacksProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAvailableStacksProvider &&
        other.terminalid == terminalid &&
        other.commodityid == commodityid &&
        other.weightreqst == weightreqst &&
        other.in_out_status == in_out_status &&
        other.stack_type == stack_type &&
        other.vehicle_no == vehicle_no &&
        other.driverNumber == driverNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminalid.hashCode);
    hash = _SystemHash.combine(hash, commodityid.hashCode);
    hash = _SystemHash.combine(hash, weightreqst.hashCode);
    hash = _SystemHash.combine(hash, in_out_status.hashCode);
    hash = _SystemHash.combine(hash, stack_type.hashCode);
    hash = _SystemHash.combine(hash, vehicle_no.hashCode);
    hash = _SystemHash.combine(hash, driverNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetAvailableStacksRef
    on AutoDisposeFutureProviderRef<AvailableWarehouseStacksModel> {
  /// The parameter `terminalid` of this provider.
  dynamic get terminalid;

  /// The parameter `commodityid` of this provider.
  dynamic get commodityid;

  /// The parameter `weightreqst` of this provider.
  dynamic get weightreqst;

  /// The parameter `in_out_status` of this provider.
  dynamic get in_out_status;

  /// The parameter `stack_type` of this provider.
  dynamic get stack_type;

  /// The parameter `vehicle_no` of this provider.
  dynamic get vehicle_no;

  /// The parameter `driverNumber` of this provider.
  dynamic get driverNumber;
}

class _GetAvailableStacksProviderElement
    extends AutoDisposeFutureProviderElement<AvailableWarehouseStacksModel>
    with GetAvailableStacksRef {
  _GetAvailableStacksProviderElement(super.provider);

  @override
  dynamic get terminalid => (origin as GetAvailableStacksProvider).terminalid;
  @override
  dynamic get commodityid => (origin as GetAvailableStacksProvider).commodityid;
  @override
  dynamic get weightreqst => (origin as GetAvailableStacksProvider).weightreqst;
  @override
  dynamic get in_out_status =>
      (origin as GetAvailableStacksProvider).in_out_status;
  @override
  dynamic get stack_type => (origin as GetAvailableStacksProvider).stack_type;
  @override
  dynamic get vehicle_no => (origin as GetAvailableStacksProvider).vehicle_no;
  @override
  dynamic get driverNumber =>
      (origin as GetAvailableStacksProvider).driverNumber;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
