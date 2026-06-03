// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TripIdService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tripTransporterListHash() =>
    r'978b62726fba24c4fc42ac7ee01759af8bedc21f';

/// See also [tripTransporterList].
@ProviderFor(tripTransporterList)
final tripTransporterListProvider =
    AutoDisposeStreamProvider<TripTransporterModel>.internal(
  tripTransporterList,
  name: r'tripTransporterListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tripTransporterListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TripTransporterListRef
    = AutoDisposeStreamProviderRef<TripTransporterModel>;
String _$tripRequestsHash() => r'55e8d3c1eacde9dda75c90c0bfb1331f3c341e2c';

/// See also [tripRequests].
@ProviderFor(tripRequests)
final tripRequestsProvider =
    AutoDisposeStreamProvider<TripRequestsModel>.internal(
  tripRequests,
  name: r'tripRequestsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tripRequestsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TripRequestsRef = AutoDisposeStreamProviderRef<TripRequestsModel>;
String _$poListHash() => r'482978502b6841ede7e871176dd878716eb6c6be';

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

/// See also [poList].
@ProviderFor(poList)
const poListProvider = PoListFamily();

/// See also [poList].
class PoListFamily extends Family<AsyncValue<PoModel>> {
  /// See also [poList].
  const PoListFamily();

  /// See also [poList].
  PoListProvider call({
    String? terminaId,
    String? commodityId,
  }) {
    return PoListProvider(
      terminaId: terminaId,
      commodityId: commodityId,
    );
  }

  @override
  PoListProvider getProviderOverride(
    covariant PoListProvider provider,
  ) {
    return call(
      terminaId: provider.terminaId,
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
  String? get name => r'poListProvider';
}

/// See also [poList].
class PoListProvider extends AutoDisposeStreamProvider<PoModel> {
  /// See also [poList].
  PoListProvider({
    String? terminaId,
    String? commodityId,
  }) : this._internal(
          (ref) => poList(
            ref as PoListRef,
            terminaId: terminaId,
            commodityId: commodityId,
          ),
          from: poListProvider,
          name: r'poListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$poListHash,
          dependencies: PoListFamily._dependencies,
          allTransitiveDependencies: PoListFamily._allTransitiveDependencies,
          terminaId: terminaId,
          commodityId: commodityId,
        );

  PoListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.terminaId,
    required this.commodityId,
  }) : super.internal();

  final String? terminaId;
  final String? commodityId;

  @override
  Override overrideWith(
    Stream<PoModel> Function(PoListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PoListProvider._internal(
        (ref) => create(ref as PoListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        terminaId: terminaId,
        commodityId: commodityId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<PoModel> createElement() {
    return _PoListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PoListProvider &&
        other.terminaId == terminaId &&
        other.commodityId == commodityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, terminaId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PoListRef on AutoDisposeStreamProviderRef<PoModel> {
  /// The parameter `terminaId` of this provider.
  String? get terminaId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;
}

class _PoListProviderElement extends AutoDisposeStreamProviderElement<PoModel>
    with PoListRef {
  _PoListProviderElement(super.provider);

  @override
  String? get terminaId => (origin as PoListProvider).terminaId;
  @override
  String? get commodityId => (origin as PoListProvider).commodityId;
}

String _$biltyDataHash() => r'd2122f7681db3ce01141cc4ac1083fce3fb88d26';

/// See also [biltyData].
@ProviderFor(biltyData)
const biltyDataProvider = BiltyDataFamily();

/// See also [biltyData].
class BiltyDataFamily extends Family<AsyncValue<BiltyResponseData>> {
  /// See also [biltyData].
  const BiltyDataFamily();

  /// See also [biltyData].
  BiltyDataProvider call({
    String? tripId,
  }) {
    return BiltyDataProvider(
      tripId: tripId,
    );
  }

  @override
  BiltyDataProvider getProviderOverride(
    covariant BiltyDataProvider provider,
  ) {
    return call(
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
  String? get name => r'biltyDataProvider';
}

/// See also [biltyData].
class BiltyDataProvider extends AutoDisposeFutureProvider<BiltyResponseData> {
  /// See also [biltyData].
  BiltyDataProvider({
    String? tripId,
  }) : this._internal(
          (ref) => biltyData(
            ref as BiltyDataRef,
            tripId: tripId,
          ),
          from: biltyDataProvider,
          name: r'biltyDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$biltyDataHash,
          dependencies: BiltyDataFamily._dependencies,
          allTransitiveDependencies: BiltyDataFamily._allTransitiveDependencies,
          tripId: tripId,
        );

  BiltyDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripId,
  }) : super.internal();

  final String? tripId;

  @override
  Override overrideWith(
    FutureOr<BiltyResponseData> Function(BiltyDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BiltyDataProvider._internal(
        (ref) => create(ref as BiltyDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripId: tripId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BiltyResponseData> createElement() {
    return _BiltyDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BiltyDataProvider && other.tripId == tripId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BiltyDataRef on AutoDisposeFutureProviderRef<BiltyResponseData> {
  /// The parameter `tripId` of this provider.
  String? get tripId;
}

class _BiltyDataProviderElement
    extends AutoDisposeFutureProviderElement<BiltyResponseData>
    with BiltyDataRef {
  _BiltyDataProviderElement(super.provider);

  @override
  String? get tripId => (origin as BiltyDataProvider).tripId;
}

String _$createTripidHash() => r'51138aec56340a33859922e30b6197daf93e01df';

/// See also [createTripid].
@ProviderFor(createTripid)
const createTripidProvider = CreateTripidFamily();

/// See also [createTripid].
class CreateTripidFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [createTripid].
  const CreateTripidFamily();

  /// See also [createTripid].
  CreateTripidProvider call({
    String? source,
    String? fromAddress,
    String? fromPinCode,
    String? fromTerminalId,
    String? to,
    String? toAddress,
    String? toPincode,
    String? toTerminalId,
    String? poId,
    String? commodityId,
    String? transporterId,
    String? rate,
    String? advanceAmount,
    String? paymentTo,
    String? consigneeName,
    String? consigneeNumber,
    String? landmark,
  }) {
    return CreateTripidProvider(
      source: source,
      fromAddress: fromAddress,
      fromPinCode: fromPinCode,
      fromTerminalId: fromTerminalId,
      to: to,
      toAddress: toAddress,
      toPincode: toPincode,
      toTerminalId: toTerminalId,
      poId: poId,
      commodityId: commodityId,
      transporterId: transporterId,
      rate: rate,
      advanceAmount: advanceAmount,
      paymentTo: paymentTo,
      consigneeName: consigneeName,
      consigneeNumber: consigneeNumber,
      landmark: landmark,
    );
  }

  @override
  CreateTripidProvider getProviderOverride(
    covariant CreateTripidProvider provider,
  ) {
    return call(
      source: provider.source,
      fromAddress: provider.fromAddress,
      fromPinCode: provider.fromPinCode,
      fromTerminalId: provider.fromTerminalId,
      to: provider.to,
      toAddress: provider.toAddress,
      toPincode: provider.toPincode,
      toTerminalId: provider.toTerminalId,
      poId: provider.poId,
      commodityId: provider.commodityId,
      transporterId: provider.transporterId,
      rate: provider.rate,
      advanceAmount: provider.advanceAmount,
      paymentTo: provider.paymentTo,
      consigneeName: provider.consigneeName,
      consigneeNumber: provider.consigneeNumber,
      landmark: provider.landmark,
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
  String? get name => r'createTripidProvider';
}

/// See also [createTripid].
class CreateTripidProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [createTripid].
  CreateTripidProvider({
    String? source,
    String? fromAddress,
    String? fromPinCode,
    String? fromTerminalId,
    String? to,
    String? toAddress,
    String? toPincode,
    String? toTerminalId,
    String? poId,
    String? commodityId,
    String? transporterId,
    String? rate,
    String? advanceAmount,
    String? paymentTo,
    String? consigneeName,
    String? consigneeNumber,
    String? landmark,
  }) : this._internal(
          (ref) => createTripid(
            ref as CreateTripidRef,
            source: source,
            fromAddress: fromAddress,
            fromPinCode: fromPinCode,
            fromTerminalId: fromTerminalId,
            to: to,
            toAddress: toAddress,
            toPincode: toPincode,
            toTerminalId: toTerminalId,
            poId: poId,
            commodityId: commodityId,
            transporterId: transporterId,
            rate: rate,
            advanceAmount: advanceAmount,
            paymentTo: paymentTo,
            consigneeName: consigneeName,
            consigneeNumber: consigneeNumber,
            landmark: landmark,
          ),
          from: createTripidProvider,
          name: r'createTripidProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createTripidHash,
          dependencies: CreateTripidFamily._dependencies,
          allTransitiveDependencies:
              CreateTripidFamily._allTransitiveDependencies,
          source: source,
          fromAddress: fromAddress,
          fromPinCode: fromPinCode,
          fromTerminalId: fromTerminalId,
          to: to,
          toAddress: toAddress,
          toPincode: toPincode,
          toTerminalId: toTerminalId,
          poId: poId,
          commodityId: commodityId,
          transporterId: transporterId,
          rate: rate,
          advanceAmount: advanceAmount,
          paymentTo: paymentTo,
          consigneeName: consigneeName,
          consigneeNumber: consigneeNumber,
          landmark: landmark,
        );

  CreateTripidProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.source,
    required this.fromAddress,
    required this.fromPinCode,
    required this.fromTerminalId,
    required this.to,
    required this.toAddress,
    required this.toPincode,
    required this.toTerminalId,
    required this.poId,
    required this.commodityId,
    required this.transporterId,
    required this.rate,
    required this.advanceAmount,
    required this.paymentTo,
    required this.consigneeName,
    required this.consigneeNumber,
    required this.landmark,
  }) : super.internal();

  final String? source;
  final String? fromAddress;
  final String? fromPinCode;
  final String? fromTerminalId;
  final String? to;
  final String? toAddress;
  final String? toPincode;
  final String? toTerminalId;
  final String? poId;
  final String? commodityId;
  final String? transporterId;
  final String? rate;
  final String? advanceAmount;
  final String? paymentTo;
  final String? consigneeName;
  final String? consigneeNumber;
  final String? landmark;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(CreateTripidRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateTripidProvider._internal(
        (ref) => create(ref as CreateTripidRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        source: source,
        fromAddress: fromAddress,
        fromPinCode: fromPinCode,
        fromTerminalId: fromTerminalId,
        to: to,
        toAddress: toAddress,
        toPincode: toPincode,
        toTerminalId: toTerminalId,
        poId: poId,
        commodityId: commodityId,
        transporterId: transporterId,
        rate: rate,
        advanceAmount: advanceAmount,
        paymentTo: paymentTo,
        consigneeName: consigneeName,
        consigneeNumber: consigneeNumber,
        landmark: landmark,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _CreateTripidProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateTripidProvider &&
        other.source == source &&
        other.fromAddress == fromAddress &&
        other.fromPinCode == fromPinCode &&
        other.fromTerminalId == fromTerminalId &&
        other.to == to &&
        other.toAddress == toAddress &&
        other.toPincode == toPincode &&
        other.toTerminalId == toTerminalId &&
        other.poId == poId &&
        other.commodityId == commodityId &&
        other.transporterId == transporterId &&
        other.rate == rate &&
        other.advanceAmount == advanceAmount &&
        other.paymentTo == paymentTo &&
        other.consigneeName == consigneeName &&
        other.consigneeNumber == consigneeNumber &&
        other.landmark == landmark;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, source.hashCode);
    hash = _SystemHash.combine(hash, fromAddress.hashCode);
    hash = _SystemHash.combine(hash, fromPinCode.hashCode);
    hash = _SystemHash.combine(hash, fromTerminalId.hashCode);
    hash = _SystemHash.combine(hash, to.hashCode);
    hash = _SystemHash.combine(hash, toAddress.hashCode);
    hash = _SystemHash.combine(hash, toPincode.hashCode);
    hash = _SystemHash.combine(hash, toTerminalId.hashCode);
    hash = _SystemHash.combine(hash, poId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, transporterId.hashCode);
    hash = _SystemHash.combine(hash, rate.hashCode);
    hash = _SystemHash.combine(hash, advanceAmount.hashCode);
    hash = _SystemHash.combine(hash, paymentTo.hashCode);
    hash = _SystemHash.combine(hash, consigneeName.hashCode);
    hash = _SystemHash.combine(hash, consigneeNumber.hashCode);
    hash = _SystemHash.combine(hash, landmark.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateTripidRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `source` of this provider.
  String? get source;

  /// The parameter `fromAddress` of this provider.
  String? get fromAddress;

  /// The parameter `fromPinCode` of this provider.
  String? get fromPinCode;

  /// The parameter `fromTerminalId` of this provider.
  String? get fromTerminalId;

  /// The parameter `to` of this provider.
  String? get to;

  /// The parameter `toAddress` of this provider.
  String? get toAddress;

  /// The parameter `toPincode` of this provider.
  String? get toPincode;

  /// The parameter `toTerminalId` of this provider.
  String? get toTerminalId;

  /// The parameter `poId` of this provider.
  String? get poId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `transporterId` of this provider.
  String? get transporterId;

  /// The parameter `rate` of this provider.
  String? get rate;

  /// The parameter `advanceAmount` of this provider.
  String? get advanceAmount;

  /// The parameter `paymentTo` of this provider.
  String? get paymentTo;

  /// The parameter `consigneeName` of this provider.
  String? get consigneeName;

  /// The parameter `consigneeNumber` of this provider.
  String? get consigneeNumber;

  /// The parameter `landmark` of this provider.
  String? get landmark;
}

class _CreateTripidProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with CreateTripidRef {
  _CreateTripidProviderElement(super.provider);

  @override
  String? get source => (origin as CreateTripidProvider).source;
  @override
  String? get fromAddress => (origin as CreateTripidProvider).fromAddress;
  @override
  String? get fromPinCode => (origin as CreateTripidProvider).fromPinCode;
  @override
  String? get fromTerminalId => (origin as CreateTripidProvider).fromTerminalId;
  @override
  String? get to => (origin as CreateTripidProvider).to;
  @override
  String? get toAddress => (origin as CreateTripidProvider).toAddress;
  @override
  String? get toPincode => (origin as CreateTripidProvider).toPincode;
  @override
  String? get toTerminalId => (origin as CreateTripidProvider).toTerminalId;
  @override
  String? get poId => (origin as CreateTripidProvider).poId;
  @override
  String? get commodityId => (origin as CreateTripidProvider).commodityId;
  @override
  String? get transporterId => (origin as CreateTripidProvider).transporterId;
  @override
  String? get rate => (origin as CreateTripidProvider).rate;
  @override
  String? get advanceAmount => (origin as CreateTripidProvider).advanceAmount;
  @override
  String? get paymentTo => (origin as CreateTripidProvider).paymentTo;
  @override
  String? get consigneeName => (origin as CreateTripidProvider).consigneeName;
  @override
  String? get consigneeNumber =>
      (origin as CreateTripidProvider).consigneeNumber;
  @override
  String? get landmark => (origin as CreateTripidProvider).landmark;
}

String _$updateTripIdHash() => r'10b03f76c7792cde483e09a7fa903b9393987a1f';

/// See also [updateTripId].
@ProviderFor(updateTripId)
const updateTripIdProvider = UpdateTripIdFamily();

/// See also [updateTripId].
class UpdateTripIdFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [updateTripId].
  const UpdateTripIdFamily();

  /// See also [updateTripId].
  UpdateTripIdProvider call({
    String? requestId,
    String? weight,
    String? noOfBags,
    File? kantaParchiImage,
    File? invoiceImage,
    File? eWayBillImage,
    File? mandiTaxDocuments,
    File? qualityReportImage,
  }) {
    return UpdateTripIdProvider(
      requestId: requestId,
      weight: weight,
      noOfBags: noOfBags,
      kantaParchiImage: kantaParchiImage,
      invoiceImage: invoiceImage,
      eWayBillImage: eWayBillImage,
      mandiTaxDocuments: mandiTaxDocuments,
      qualityReportImage: qualityReportImage,
    );
  }

  @override
  UpdateTripIdProvider getProviderOverride(
    covariant UpdateTripIdProvider provider,
  ) {
    return call(
      requestId: provider.requestId,
      weight: provider.weight,
      noOfBags: provider.noOfBags,
      kantaParchiImage: provider.kantaParchiImage,
      invoiceImage: provider.invoiceImage,
      eWayBillImage: provider.eWayBillImage,
      mandiTaxDocuments: provider.mandiTaxDocuments,
      qualityReportImage: provider.qualityReportImage,
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
  String? get name => r'updateTripIdProvider';
}

/// See also [updateTripId].
class UpdateTripIdProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [updateTripId].
  UpdateTripIdProvider({
    String? requestId,
    String? weight,
    String? noOfBags,
    File? kantaParchiImage,
    File? invoiceImage,
    File? eWayBillImage,
    File? mandiTaxDocuments,
    File? qualityReportImage,
  }) : this._internal(
          (ref) => updateTripId(
            ref as UpdateTripIdRef,
            requestId: requestId,
            weight: weight,
            noOfBags: noOfBags,
            kantaParchiImage: kantaParchiImage,
            invoiceImage: invoiceImage,
            eWayBillImage: eWayBillImage,
            mandiTaxDocuments: mandiTaxDocuments,
            qualityReportImage: qualityReportImage,
          ),
          from: updateTripIdProvider,
          name: r'updateTripIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateTripIdHash,
          dependencies: UpdateTripIdFamily._dependencies,
          allTransitiveDependencies:
              UpdateTripIdFamily._allTransitiveDependencies,
          requestId: requestId,
          weight: weight,
          noOfBags: noOfBags,
          kantaParchiImage: kantaParchiImage,
          invoiceImage: invoiceImage,
          eWayBillImage: eWayBillImage,
          mandiTaxDocuments: mandiTaxDocuments,
          qualityReportImage: qualityReportImage,
        );

  UpdateTripIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.requestId,
    required this.weight,
    required this.noOfBags,
    required this.kantaParchiImage,
    required this.invoiceImage,
    required this.eWayBillImage,
    required this.mandiTaxDocuments,
    required this.qualityReportImage,
  }) : super.internal();

  final String? requestId;
  final String? weight;
  final String? noOfBags;
  final File? kantaParchiImage;
  final File? invoiceImage;
  final File? eWayBillImage;
  final File? mandiTaxDocuments;
  final File? qualityReportImage;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(UpdateTripIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateTripIdProvider._internal(
        (ref) => create(ref as UpdateTripIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        requestId: requestId,
        weight: weight,
        noOfBags: noOfBags,
        kantaParchiImage: kantaParchiImage,
        invoiceImage: invoiceImage,
        eWayBillImage: eWayBillImage,
        mandiTaxDocuments: mandiTaxDocuments,
        qualityReportImage: qualityReportImage,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _UpdateTripIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateTripIdProvider &&
        other.requestId == requestId &&
        other.weight == weight &&
        other.noOfBags == noOfBags &&
        other.kantaParchiImage == kantaParchiImage &&
        other.invoiceImage == invoiceImage &&
        other.eWayBillImage == eWayBillImage &&
        other.mandiTaxDocuments == mandiTaxDocuments &&
        other.qualityReportImage == qualityReportImage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, requestId.hashCode);
    hash = _SystemHash.combine(hash, weight.hashCode);
    hash = _SystemHash.combine(hash, noOfBags.hashCode);
    hash = _SystemHash.combine(hash, kantaParchiImage.hashCode);
    hash = _SystemHash.combine(hash, invoiceImage.hashCode);
    hash = _SystemHash.combine(hash, eWayBillImage.hashCode);
    hash = _SystemHash.combine(hash, mandiTaxDocuments.hashCode);
    hash = _SystemHash.combine(hash, qualityReportImage.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateTripIdRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `requestId` of this provider.
  String? get requestId;

  /// The parameter `weight` of this provider.
  String? get weight;

  /// The parameter `noOfBags` of this provider.
  String? get noOfBags;

  /// The parameter `kantaParchiImage` of this provider.
  File? get kantaParchiImage;

  /// The parameter `invoiceImage` of this provider.
  File? get invoiceImage;

  /// The parameter `eWayBillImage` of this provider.
  File? get eWayBillImage;

  /// The parameter `mandiTaxDocuments` of this provider.
  File? get mandiTaxDocuments;

  /// The parameter `qualityReportImage` of this provider.
  File? get qualityReportImage;
}

class _UpdateTripIdProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with UpdateTripIdRef {
  _UpdateTripIdProviderElement(super.provider);

  @override
  String? get requestId => (origin as UpdateTripIdProvider).requestId;
  @override
  String? get weight => (origin as UpdateTripIdProvider).weight;
  @override
  String? get noOfBags => (origin as UpdateTripIdProvider).noOfBags;
  @override
  File? get kantaParchiImage =>
      (origin as UpdateTripIdProvider).kantaParchiImage;
  @override
  File? get invoiceImage => (origin as UpdateTripIdProvider).invoiceImage;
  @override
  File? get eWayBillImage => (origin as UpdateTripIdProvider).eWayBillImage;
  @override
  File? get mandiTaxDocuments =>
      (origin as UpdateTripIdProvider).mandiTaxDocuments;
  @override
  File? get qualityReportImage =>
      (origin as UpdateTripIdProvider).qualityReportImage;
}

String _$rejectTripRequestHash() => r'b27f8db4a56a785960bb73564a1a86f1279c87ca';

/// See also [rejectTripRequest].
@ProviderFor(rejectTripRequest)
const rejectTripRequestProvider = RejectTripRequestFamily();

/// See also [rejectTripRequest].
class RejectTripRequestFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [rejectTripRequest].
  const RejectTripRequestFamily();

  /// See also [rejectTripRequest].
  RejectTripRequestProvider call({
    String? id,
  }) {
    return RejectTripRequestProvider(
      id: id,
    );
  }

  @override
  RejectTripRequestProvider getProviderOverride(
    covariant RejectTripRequestProvider provider,
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
  String? get name => r'rejectTripRequestProvider';
}

/// See also [rejectTripRequest].
class RejectTripRequestProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [rejectTripRequest].
  RejectTripRequestProvider({
    String? id,
  }) : this._internal(
          (ref) => rejectTripRequest(
            ref as RejectTripRequestRef,
            id: id,
          ),
          from: rejectTripRequestProvider,
          name: r'rejectTripRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$rejectTripRequestHash,
          dependencies: RejectTripRequestFamily._dependencies,
          allTransitiveDependencies:
              RejectTripRequestFamily._allTransitiveDependencies,
          id: id,
        );

  RejectTripRequestProvider._internal(
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
    FutureOr<Map<String, dynamic>> Function(RejectTripRequestRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RejectTripRequestProvider._internal(
        (ref) => create(ref as RejectTripRequestRef),
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
    return _RejectTripRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RejectTripRequestProvider && other.id == id;
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
mixin RejectTripRequestRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _RejectTripRequestProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RejectTripRequestRef {
  _RejectTripRequestProviderElement(super.provider);

  @override
  String? get id => (origin as RejectTripRequestProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
