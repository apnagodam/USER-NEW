// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LpService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lpDataHash() => r'fde57673b4630ad50ff875db574fa9891d777265';

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

/// See also [lpData].
@ProviderFor(lpData)
const lpDataProvider = LpDataFamily();

/// See also [lpData].
class LpDataFamily extends Family<AsyncValue<LpResponseModel>> {
  /// See also [lpData].
  const LpDataFamily();

  /// See also [lpData].
  LpDataProvider call({
    String? lat,
    String? long,
    String? commodityImage,
    String? commodity,
    String? quantity,
    String? dealType,
    String? pincode,
    String? salesStatus,
  }) {
    return LpDataProvider(
      lat: lat,
      long: long,
      commodityImage: commodityImage,
      commodity: commodity,
      quantity: quantity,
      dealType: dealType,
      pincode: pincode,
      salesStatus: salesStatus,
    );
  }

  @override
  LpDataProvider getProviderOverride(
    covariant LpDataProvider provider,
  ) {
    return call(
      lat: provider.lat,
      long: provider.long,
      commodityImage: provider.commodityImage,
      commodity: provider.commodity,
      quantity: provider.quantity,
      dealType: provider.dealType,
      pincode: provider.pincode,
      salesStatus: provider.salesStatus,
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
  String? get name => r'lpDataProvider';
}

/// See also [lpData].
class LpDataProvider extends AutoDisposeFutureProvider<LpResponseModel> {
  /// See also [lpData].
  LpDataProvider({
    String? lat,
    String? long,
    String? commodityImage,
    String? commodity,
    String? quantity,
    String? dealType,
    String? pincode,
    String? salesStatus,
  }) : this._internal(
          (ref) => lpData(
            ref as LpDataRef,
            lat: lat,
            long: long,
            commodityImage: commodityImage,
            commodity: commodity,
            quantity: quantity,
            dealType: dealType,
            pincode: pincode,
            salesStatus: salesStatus,
          ),
          from: lpDataProvider,
          name: r'lpDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lpDataHash,
          dependencies: LpDataFamily._dependencies,
          allTransitiveDependencies: LpDataFamily._allTransitiveDependencies,
          lat: lat,
          long: long,
          commodityImage: commodityImage,
          commodity: commodity,
          quantity: quantity,
          dealType: dealType,
          pincode: pincode,
          salesStatus: salesStatus,
        );

  LpDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lat,
    required this.long,
    required this.commodityImage,
    required this.commodity,
    required this.quantity,
    required this.dealType,
    required this.pincode,
    required this.salesStatus,
  }) : super.internal();

  final String? lat;
  final String? long;
  final String? commodityImage;
  final String? commodity;
  final String? quantity;
  final String? dealType;
  final String? pincode;
  final String? salesStatus;

  @override
  Override overrideWith(
    FutureOr<LpResponseModel> Function(LpDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LpDataProvider._internal(
        (ref) => create(ref as LpDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lat: lat,
        long: long,
        commodityImage: commodityImage,
        commodity: commodity,
        quantity: quantity,
        dealType: dealType,
        pincode: pincode,
        salesStatus: salesStatus,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LpResponseModel> createElement() {
    return _LpDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LpDataProvider &&
        other.lat == lat &&
        other.long == long &&
        other.commodityImage == commodityImage &&
        other.commodity == commodity &&
        other.quantity == quantity &&
        other.dealType == dealType &&
        other.pincode == pincode &&
        other.salesStatus == salesStatus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lat.hashCode);
    hash = _SystemHash.combine(hash, long.hashCode);
    hash = _SystemHash.combine(hash, commodityImage.hashCode);
    hash = _SystemHash.combine(hash, commodity.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, dealType.hashCode);
    hash = _SystemHash.combine(hash, pincode.hashCode);
    hash = _SystemHash.combine(hash, salesStatus.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LpDataRef on AutoDisposeFutureProviderRef<LpResponseModel> {
  /// The parameter `lat` of this provider.
  String? get lat;

  /// The parameter `long` of this provider.
  String? get long;

  /// The parameter `commodityImage` of this provider.
  String? get commodityImage;

  /// The parameter `commodity` of this provider.
  String? get commodity;

  /// The parameter `quantity` of this provider.
  String? get quantity;

  /// The parameter `dealType` of this provider.
  String? get dealType;

  /// The parameter `pincode` of this provider.
  String? get pincode;

  /// The parameter `salesStatus` of this provider.
  String? get salesStatus;
}

class _LpDataProviderElement
    extends AutoDisposeFutureProviderElement<LpResponseModel> with LpDataRef {
  _LpDataProviderElement(super.provider);

  @override
  String? get lat => (origin as LpDataProvider).lat;
  @override
  String? get long => (origin as LpDataProvider).long;
  @override
  String? get commodityImage => (origin as LpDataProvider).commodityImage;
  @override
  String? get commodity => (origin as LpDataProvider).commodity;
  @override
  String? get quantity => (origin as LpDataProvider).quantity;
  @override
  String? get dealType => (origin as LpDataProvider).dealType;
  @override
  String? get pincode => (origin as LpDataProvider).pincode;
  @override
  String? get salesStatus => (origin as LpDataProvider).salesStatus;
}

String _$allBookingsHash() => r'3820c20c44739b1bb6cb7e33da807da08b3dc261';

/// See also [allBookings].
@ProviderFor(allBookings)
const allBookingsProvider = AllBookingsFamily();

/// See also [allBookings].
class AllBookingsFamily extends Family<AsyncValue<AllBookingsModel>> {
  /// See also [allBookings].
  const AllBookingsFamily();

  /// See also [allBookings].
  AllBookingsProvider call({
    String? status,
  }) {
    return AllBookingsProvider(
      status: status,
    );
  }

  @override
  AllBookingsProvider getProviderOverride(
    covariant AllBookingsProvider provider,
  ) {
    return call(
      status: provider.status,
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
  String? get name => r'allBookingsProvider';
}

/// See also [allBookings].
class AllBookingsProvider extends AutoDisposeStreamProvider<AllBookingsModel> {
  /// See also [allBookings].
  AllBookingsProvider({
    String? status,
  }) : this._internal(
          (ref) => allBookings(
            ref as AllBookingsRef,
            status: status,
          ),
          from: allBookingsProvider,
          name: r'allBookingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$allBookingsHash,
          dependencies: AllBookingsFamily._dependencies,
          allTransitiveDependencies:
              AllBookingsFamily._allTransitiveDependencies,
          status: status,
        );

  AllBookingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final String? status;

  @override
  Override overrideWith(
    Stream<AllBookingsModel> Function(AllBookingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AllBookingsProvider._internal(
        (ref) => create(ref as AllBookingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<AllBookingsModel> createElement() {
    return _AllBookingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllBookingsProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AllBookingsRef on AutoDisposeStreamProviderRef<AllBookingsModel> {
  /// The parameter `status` of this provider.
  String? get status;
}

class _AllBookingsProviderElement
    extends AutoDisposeStreamProviderElement<AllBookingsModel>
    with AllBookingsRef {
  _AllBookingsProviderElement(super.provider);

  @override
  String? get status => (origin as AllBookingsProvider).status;
}

String _$bookingRequestHash() => r'78f0527e4be9b6d67c26af6235b05b2a7c68e251';

/// See also [bookingRequest].
@ProviderFor(bookingRequest)
const bookingRequestProvider = BookingRequestFamily();

/// See also [bookingRequest].
class BookingRequestFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [bookingRequest].
  const BookingRequestFamily();

  /// See also [bookingRequest].
  BookingRequestProvider call({
    String? lpUserId,
    String? commodityId,
    String? quantity,
    String? price,
    String? salesStatus,
    String? catImage,
    String? commodityImagePath,
    String? terminalId,
    String? agCommission,
    String? lpCommision,
    String? user,
    String? distance,
    String? lpLat,
    String? lpLong,
    String? corpLat,
    String? corpLong,
    String? finalPrice,
    String? subPrice,
    String? transportPrice,
    String? loadingCharge,
    String? mandiTax,
  }) {
    return BookingRequestProvider(
      lpUserId: lpUserId,
      commodityId: commodityId,
      quantity: quantity,
      price: price,
      salesStatus: salesStatus,
      catImage: catImage,
      commodityImagePath: commodityImagePath,
      terminalId: terminalId,
      agCommission: agCommission,
      lpCommision: lpCommision,
      user: user,
      distance: distance,
      lpLat: lpLat,
      lpLong: lpLong,
      corpLat: corpLat,
      corpLong: corpLong,
      finalPrice: finalPrice,
      subPrice: subPrice,
      transportPrice: transportPrice,
      loadingCharge: loadingCharge,
      mandiTax: mandiTax,
    );
  }

  @override
  BookingRequestProvider getProviderOverride(
    covariant BookingRequestProvider provider,
  ) {
    return call(
      lpUserId: provider.lpUserId,
      commodityId: provider.commodityId,
      quantity: provider.quantity,
      price: provider.price,
      salesStatus: provider.salesStatus,
      catImage: provider.catImage,
      commodityImagePath: provider.commodityImagePath,
      terminalId: provider.terminalId,
      agCommission: provider.agCommission,
      lpCommision: provider.lpCommision,
      user: provider.user,
      distance: provider.distance,
      lpLat: provider.lpLat,
      lpLong: provider.lpLong,
      corpLat: provider.corpLat,
      corpLong: provider.corpLong,
      finalPrice: provider.finalPrice,
      subPrice: provider.subPrice,
      transportPrice: provider.transportPrice,
      loadingCharge: provider.loadingCharge,
      mandiTax: provider.mandiTax,
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
  String? get name => r'bookingRequestProvider';
}

/// See also [bookingRequest].
class BookingRequestProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [bookingRequest].
  BookingRequestProvider({
    String? lpUserId,
    String? commodityId,
    String? quantity,
    String? price,
    String? salesStatus,
    String? catImage,
    String? commodityImagePath,
    String? terminalId,
    String? agCommission,
    String? lpCommision,
    String? user,
    String? distance,
    String? lpLat,
    String? lpLong,
    String? corpLat,
    String? corpLong,
    String? finalPrice,
    String? subPrice,
    String? transportPrice,
    String? loadingCharge,
    String? mandiTax,
  }) : this._internal(
          (ref) => bookingRequest(
            ref as BookingRequestRef,
            lpUserId: lpUserId,
            commodityId: commodityId,
            quantity: quantity,
            price: price,
            salesStatus: salesStatus,
            catImage: catImage,
            commodityImagePath: commodityImagePath,
            terminalId: terminalId,
            agCommission: agCommission,
            lpCommision: lpCommision,
            user: user,
            distance: distance,
            lpLat: lpLat,
            lpLong: lpLong,
            corpLat: corpLat,
            corpLong: corpLong,
            finalPrice: finalPrice,
            subPrice: subPrice,
            transportPrice: transportPrice,
            loadingCharge: loadingCharge,
            mandiTax: mandiTax,
          ),
          from: bookingRequestProvider,
          name: r'bookingRequestProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookingRequestHash,
          dependencies: BookingRequestFamily._dependencies,
          allTransitiveDependencies:
              BookingRequestFamily._allTransitiveDependencies,
          lpUserId: lpUserId,
          commodityId: commodityId,
          quantity: quantity,
          price: price,
          salesStatus: salesStatus,
          catImage: catImage,
          commodityImagePath: commodityImagePath,
          terminalId: terminalId,
          agCommission: agCommission,
          lpCommision: lpCommision,
          user: user,
          distance: distance,
          lpLat: lpLat,
          lpLong: lpLong,
          corpLat: corpLat,
          corpLong: corpLong,
          finalPrice: finalPrice,
          subPrice: subPrice,
          transportPrice: transportPrice,
          loadingCharge: loadingCharge,
          mandiTax: mandiTax,
        );

  BookingRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lpUserId,
    required this.commodityId,
    required this.quantity,
    required this.price,
    required this.salesStatus,
    required this.catImage,
    required this.commodityImagePath,
    required this.terminalId,
    required this.agCommission,
    required this.lpCommision,
    required this.user,
    required this.distance,
    required this.lpLat,
    required this.lpLong,
    required this.corpLat,
    required this.corpLong,
    required this.finalPrice,
    required this.subPrice,
    required this.transportPrice,
    required this.loadingCharge,
    required this.mandiTax,
  }) : super.internal();

  final String? lpUserId;
  final String? commodityId;
  final String? quantity;
  final String? price;
  final String? salesStatus;
  final String? catImage;
  final String? commodityImagePath;
  final String? terminalId;
  final String? agCommission;
  final String? lpCommision;
  final String? user;
  final String? distance;
  final String? lpLat;
  final String? lpLong;
  final String? corpLat;
  final String? corpLong;
  final String? finalPrice;
  final String? subPrice;
  final String? transportPrice;
  final String? loadingCharge;
  final String? mandiTax;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(BookingRequestRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BookingRequestProvider._internal(
        (ref) => create(ref as BookingRequestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lpUserId: lpUserId,
        commodityId: commodityId,
        quantity: quantity,
        price: price,
        salesStatus: salesStatus,
        catImage: catImage,
        commodityImagePath: commodityImagePath,
        terminalId: terminalId,
        agCommission: agCommission,
        lpCommision: lpCommision,
        user: user,
        distance: distance,
        lpLat: lpLat,
        lpLong: lpLong,
        corpLat: corpLat,
        corpLong: corpLong,
        finalPrice: finalPrice,
        subPrice: subPrice,
        transportPrice: transportPrice,
        loadingCharge: loadingCharge,
        mandiTax: mandiTax,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _BookingRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookingRequestProvider &&
        other.lpUserId == lpUserId &&
        other.commodityId == commodityId &&
        other.quantity == quantity &&
        other.price == price &&
        other.salesStatus == salesStatus &&
        other.catImage == catImage &&
        other.commodityImagePath == commodityImagePath &&
        other.terminalId == terminalId &&
        other.agCommission == agCommission &&
        other.lpCommision == lpCommision &&
        other.user == user &&
        other.distance == distance &&
        other.lpLat == lpLat &&
        other.lpLong == lpLong &&
        other.corpLat == corpLat &&
        other.corpLong == corpLong &&
        other.finalPrice == finalPrice &&
        other.subPrice == subPrice &&
        other.transportPrice == transportPrice &&
        other.loadingCharge == loadingCharge &&
        other.mandiTax == mandiTax;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lpUserId.hashCode);
    hash = _SystemHash.combine(hash, commodityId.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, price.hashCode);
    hash = _SystemHash.combine(hash, salesStatus.hashCode);
    hash = _SystemHash.combine(hash, catImage.hashCode);
    hash = _SystemHash.combine(hash, commodityImagePath.hashCode);
    hash = _SystemHash.combine(hash, terminalId.hashCode);
    hash = _SystemHash.combine(hash, agCommission.hashCode);
    hash = _SystemHash.combine(hash, lpCommision.hashCode);
    hash = _SystemHash.combine(hash, user.hashCode);
    hash = _SystemHash.combine(hash, distance.hashCode);
    hash = _SystemHash.combine(hash, lpLat.hashCode);
    hash = _SystemHash.combine(hash, lpLong.hashCode);
    hash = _SystemHash.combine(hash, corpLat.hashCode);
    hash = _SystemHash.combine(hash, corpLong.hashCode);
    hash = _SystemHash.combine(hash, finalPrice.hashCode);
    hash = _SystemHash.combine(hash, subPrice.hashCode);
    hash = _SystemHash.combine(hash, transportPrice.hashCode);
    hash = _SystemHash.combine(hash, loadingCharge.hashCode);
    hash = _SystemHash.combine(hash, mandiTax.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BookingRequestRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `lpUserId` of this provider.
  String? get lpUserId;

  /// The parameter `commodityId` of this provider.
  String? get commodityId;

  /// The parameter `quantity` of this provider.
  String? get quantity;

  /// The parameter `price` of this provider.
  String? get price;

  /// The parameter `salesStatus` of this provider.
  String? get salesStatus;

  /// The parameter `catImage` of this provider.
  String? get catImage;

  /// The parameter `commodityImagePath` of this provider.
  String? get commodityImagePath;

  /// The parameter `terminalId` of this provider.
  String? get terminalId;

  /// The parameter `agCommission` of this provider.
  String? get agCommission;

  /// The parameter `lpCommision` of this provider.
  String? get lpCommision;

  /// The parameter `user` of this provider.
  String? get user;

  /// The parameter `distance` of this provider.
  String? get distance;

  /// The parameter `lpLat` of this provider.
  String? get lpLat;

  /// The parameter `lpLong` of this provider.
  String? get lpLong;

  /// The parameter `corpLat` of this provider.
  String? get corpLat;

  /// The parameter `corpLong` of this provider.
  String? get corpLong;

  /// The parameter `finalPrice` of this provider.
  String? get finalPrice;

  /// The parameter `subPrice` of this provider.
  String? get subPrice;

  /// The parameter `transportPrice` of this provider.
  String? get transportPrice;

  /// The parameter `loadingCharge` of this provider.
  String? get loadingCharge;

  /// The parameter `mandiTax` of this provider.
  String? get mandiTax;
}

class _BookingRequestProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with BookingRequestRef {
  _BookingRequestProviderElement(super.provider);

  @override
  String? get lpUserId => (origin as BookingRequestProvider).lpUserId;
  @override
  String? get commodityId => (origin as BookingRequestProvider).commodityId;
  @override
  String? get quantity => (origin as BookingRequestProvider).quantity;
  @override
  String? get price => (origin as BookingRequestProvider).price;
  @override
  String? get salesStatus => (origin as BookingRequestProvider).salesStatus;
  @override
  String? get catImage => (origin as BookingRequestProvider).catImage;
  @override
  String? get commodityImagePath =>
      (origin as BookingRequestProvider).commodityImagePath;
  @override
  String? get terminalId => (origin as BookingRequestProvider).terminalId;
  @override
  String? get agCommission => (origin as BookingRequestProvider).agCommission;
  @override
  String? get lpCommision => (origin as BookingRequestProvider).lpCommision;
  @override
  String? get user => (origin as BookingRequestProvider).user;
  @override
  String? get distance => (origin as BookingRequestProvider).distance;
  @override
  String? get lpLat => (origin as BookingRequestProvider).lpLat;
  @override
  String? get lpLong => (origin as BookingRequestProvider).lpLong;
  @override
  String? get corpLat => (origin as BookingRequestProvider).corpLat;
  @override
  String? get corpLong => (origin as BookingRequestProvider).corpLong;
  @override
  String? get finalPrice => (origin as BookingRequestProvider).finalPrice;
  @override
  String? get subPrice => (origin as BookingRequestProvider).subPrice;
  @override
  String? get transportPrice =>
      (origin as BookingRequestProvider).transportPrice;
  @override
  String? get loadingCharge => (origin as BookingRequestProvider).loadingCharge;
  @override
  String? get mandiTax => (origin as BookingRequestProvider).mandiTax;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
