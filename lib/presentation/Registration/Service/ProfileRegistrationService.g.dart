// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileRegistrationService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bankListHash() => r'3b11b7773075d767cedfecb4be9fd80714fe04b2';

/// See also [bankList].
@ProviderFor(bankList)
final bankListProvider = AutoDisposeStreamProvider<BankListModel>.internal(
  bankList,
  name: r'bankListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$bankListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BankListRef = AutoDisposeStreamProviderRef<BankListModel>;
String _$registerUserHash() => r'95600afa094e871ca1ba0976eebc756507d29ddb';

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

/// See also [registerUser].
@ProviderFor(registerUser)
const registerUserProvider = RegisterUserFamily();

/// See also [registerUser].
class RegisterUserFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [registerUser].
  const RegisterUserFamily();

  /// See also [registerUser].
  RegisterUserProvider call({
    String? panCard,
    String? phone,
    String? userName,
    String? constitution,
    String? email,
    String? adharNo,
    String? address,
    String? locationState,
    String? district,
    String? pincode,
    String? bankName,
    String? bankBranch,
    String? bankAccount,
    String? ifscCode,
    String? propDocType,
    String? propDocNumber,
    String? firmName,
    String? partnerDirectorCount,
    File? panCardImage,
    File? profileImage,
    File? chequeImage,
    File? aadharImage,
    File? adharBackImage,
    File? proprietorProof,
    File? moaAoa,
    File? boardResolution,
    File? directorProof,
  }) {
    return RegisterUserProvider(
      panCard: panCard,
      phone: phone,
      userName: userName,
      constitution: constitution,
      email: email,
      adharNo: adharNo,
      address: address,
      locationState: locationState,
      district: district,
      pincode: pincode,
      bankName: bankName,
      bankBranch: bankBranch,
      bankAccount: bankAccount,
      ifscCode: ifscCode,
      propDocType: propDocType,
      propDocNumber: propDocNumber,
      firmName: firmName,
      partnerDirectorCount: partnerDirectorCount,
      panCardImage: panCardImage,
      profileImage: profileImage,
      chequeImage: chequeImage,
      aadharImage: aadharImage,
      adharBackImage: adharBackImage,
      proprietorProof: proprietorProof,
      moaAoa: moaAoa,
      boardResolution: boardResolution,
      directorProof: directorProof,
    );
  }

  @override
  RegisterUserProvider getProviderOverride(
    covariant RegisterUserProvider provider,
  ) {
    return call(
      panCard: provider.panCard,
      phone: provider.phone,
      userName: provider.userName,
      constitution: provider.constitution,
      email: provider.email,
      adharNo: provider.adharNo,
      address: provider.address,
      locationState: provider.locationState,
      district: provider.district,
      pincode: provider.pincode,
      bankName: provider.bankName,
      bankBranch: provider.bankBranch,
      bankAccount: provider.bankAccount,
      ifscCode: provider.ifscCode,
      propDocType: provider.propDocType,
      propDocNumber: provider.propDocNumber,
      firmName: provider.firmName,
      partnerDirectorCount: provider.partnerDirectorCount,
      panCardImage: provider.panCardImage,
      profileImage: provider.profileImage,
      chequeImage: provider.chequeImage,
      aadharImage: provider.aadharImage,
      adharBackImage: provider.adharBackImage,
      proprietorProof: provider.proprietorProof,
      moaAoa: provider.moaAoa,
      boardResolution: provider.boardResolution,
      directorProof: provider.directorProof,
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
  String? get name => r'registerUserProvider';
}

/// See also [registerUser].
class RegisterUserProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [registerUser].
  RegisterUserProvider({
    String? panCard,
    String? phone,
    String? userName,
    String? constitution,
    String? email,
    String? adharNo,
    String? address,
    String? locationState,
    String? district,
    String? pincode,
    String? bankName,
    String? bankBranch,
    String? bankAccount,
    String? ifscCode,
    String? propDocType,
    String? propDocNumber,
    String? firmName,
    String? partnerDirectorCount,
    File? panCardImage,
    File? profileImage,
    File? chequeImage,
    File? aadharImage,
    File? adharBackImage,
    File? proprietorProof,
    File? moaAoa,
    File? boardResolution,
    File? directorProof,
  }) : this._internal(
          (ref) => registerUser(
            ref as RegisterUserRef,
            panCard: panCard,
            phone: phone,
            userName: userName,
            constitution: constitution,
            email: email,
            adharNo: adharNo,
            address: address,
            locationState: locationState,
            district: district,
            pincode: pincode,
            bankName: bankName,
            bankBranch: bankBranch,
            bankAccount: bankAccount,
            ifscCode: ifscCode,
            propDocType: propDocType,
            propDocNumber: propDocNumber,
            firmName: firmName,
            partnerDirectorCount: partnerDirectorCount,
            panCardImage: panCardImage,
            profileImage: profileImage,
            chequeImage: chequeImage,
            aadharImage: aadharImage,
            adharBackImage: adharBackImage,
            proprietorProof: proprietorProof,
            moaAoa: moaAoa,
            boardResolution: boardResolution,
            directorProof: directorProof,
          ),
          from: registerUserProvider,
          name: r'registerUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registerUserHash,
          dependencies: RegisterUserFamily._dependencies,
          allTransitiveDependencies:
              RegisterUserFamily._allTransitiveDependencies,
          panCard: panCard,
          phone: phone,
          userName: userName,
          constitution: constitution,
          email: email,
          adharNo: adharNo,
          address: address,
          locationState: locationState,
          district: district,
          pincode: pincode,
          bankName: bankName,
          bankBranch: bankBranch,
          bankAccount: bankAccount,
          ifscCode: ifscCode,
          propDocType: propDocType,
          propDocNumber: propDocNumber,
          firmName: firmName,
          partnerDirectorCount: partnerDirectorCount,
          panCardImage: panCardImage,
          profileImage: profileImage,
          chequeImage: chequeImage,
          aadharImage: aadharImage,
          adharBackImage: adharBackImage,
          proprietorProof: proprietorProof,
          moaAoa: moaAoa,
          boardResolution: boardResolution,
          directorProof: directorProof,
        );

  RegisterUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.panCard,
    required this.phone,
    required this.userName,
    required this.constitution,
    required this.email,
    required this.adharNo,
    required this.address,
    required this.locationState,
    required this.district,
    required this.pincode,
    required this.bankName,
    required this.bankBranch,
    required this.bankAccount,
    required this.ifscCode,
    required this.propDocType,
    required this.propDocNumber,
    required this.firmName,
    required this.partnerDirectorCount,
    required this.panCardImage,
    required this.profileImage,
    required this.chequeImage,
    required this.aadharImage,
    required this.adharBackImage,
    required this.proprietorProof,
    required this.moaAoa,
    required this.boardResolution,
    required this.directorProof,
  }) : super.internal();

  final String? panCard;
  final String? phone;
  final String? userName;
  final String? constitution;
  final String? email;
  final String? adharNo;
  final String? address;
  final String? locationState;
  final String? district;
  final String? pincode;
  final String? bankName;
  final String? bankBranch;
  final String? bankAccount;
  final String? ifscCode;
  final String? propDocType;
  final String? propDocNumber;
  final String? firmName;
  final String? partnerDirectorCount;
  final File? panCardImage;
  final File? profileImage;
  final File? chequeImage;
  final File? aadharImage;
  final File? adharBackImage;
  final File? proprietorProof;
  final File? moaAoa;
  final File? boardResolution;
  final File? directorProof;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(RegisterUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterUserProvider._internal(
        (ref) => create(ref as RegisterUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        panCard: panCard,
        phone: phone,
        userName: userName,
        constitution: constitution,
        email: email,
        adharNo: adharNo,
        address: address,
        locationState: locationState,
        district: district,
        pincode: pincode,
        bankName: bankName,
        bankBranch: bankBranch,
        bankAccount: bankAccount,
        ifscCode: ifscCode,
        propDocType: propDocType,
        propDocNumber: propDocNumber,
        firmName: firmName,
        partnerDirectorCount: partnerDirectorCount,
        panCardImage: panCardImage,
        profileImage: profileImage,
        chequeImage: chequeImage,
        aadharImage: aadharImage,
        adharBackImage: adharBackImage,
        proprietorProof: proprietorProof,
        moaAoa: moaAoa,
        boardResolution: boardResolution,
        directorProof: directorProof,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _RegisterUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterUserProvider &&
        other.panCard == panCard &&
        other.phone == phone &&
        other.userName == userName &&
        other.constitution == constitution &&
        other.email == email &&
        other.adharNo == adharNo &&
        other.address == address &&
        other.locationState == locationState &&
        other.district == district &&
        other.pincode == pincode &&
        other.bankName == bankName &&
        other.bankBranch == bankBranch &&
        other.bankAccount == bankAccount &&
        other.ifscCode == ifscCode &&
        other.propDocType == propDocType &&
        other.propDocNumber == propDocNumber &&
        other.firmName == firmName &&
        other.partnerDirectorCount == partnerDirectorCount &&
        other.panCardImage == panCardImage &&
        other.profileImage == profileImage &&
        other.chequeImage == chequeImage &&
        other.aadharImage == aadharImage &&
        other.adharBackImage == adharBackImage &&
        other.proprietorProof == proprietorProof &&
        other.moaAoa == moaAoa &&
        other.boardResolution == boardResolution &&
        other.directorProof == directorProof;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, panCard.hashCode);
    hash = _SystemHash.combine(hash, phone.hashCode);
    hash = _SystemHash.combine(hash, userName.hashCode);
    hash = _SystemHash.combine(hash, constitution.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, adharNo.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, locationState.hashCode);
    hash = _SystemHash.combine(hash, district.hashCode);
    hash = _SystemHash.combine(hash, pincode.hashCode);
    hash = _SystemHash.combine(hash, bankName.hashCode);
    hash = _SystemHash.combine(hash, bankBranch.hashCode);
    hash = _SystemHash.combine(hash, bankAccount.hashCode);
    hash = _SystemHash.combine(hash, ifscCode.hashCode);
    hash = _SystemHash.combine(hash, propDocType.hashCode);
    hash = _SystemHash.combine(hash, propDocNumber.hashCode);
    hash = _SystemHash.combine(hash, firmName.hashCode);
    hash = _SystemHash.combine(hash, partnerDirectorCount.hashCode);
    hash = _SystemHash.combine(hash, panCardImage.hashCode);
    hash = _SystemHash.combine(hash, profileImage.hashCode);
    hash = _SystemHash.combine(hash, chequeImage.hashCode);
    hash = _SystemHash.combine(hash, aadharImage.hashCode);
    hash = _SystemHash.combine(hash, adharBackImage.hashCode);
    hash = _SystemHash.combine(hash, proprietorProof.hashCode);
    hash = _SystemHash.combine(hash, moaAoa.hashCode);
    hash = _SystemHash.combine(hash, boardResolution.hashCode);
    hash = _SystemHash.combine(hash, directorProof.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegisterUserRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `panCard` of this provider.
  String? get panCard;

  /// The parameter `phone` of this provider.
  String? get phone;

  /// The parameter `userName` of this provider.
  String? get userName;

  /// The parameter `constitution` of this provider.
  String? get constitution;

  /// The parameter `email` of this provider.
  String? get email;

  /// The parameter `adharNo` of this provider.
  String? get adharNo;

  /// The parameter `address` of this provider.
  String? get address;

  /// The parameter `locationState` of this provider.
  String? get locationState;

  /// The parameter `district` of this provider.
  String? get district;

  /// The parameter `pincode` of this provider.
  String? get pincode;

  /// The parameter `bankName` of this provider.
  String? get bankName;

  /// The parameter `bankBranch` of this provider.
  String? get bankBranch;

  /// The parameter `bankAccount` of this provider.
  String? get bankAccount;

  /// The parameter `ifscCode` of this provider.
  String? get ifscCode;

  /// The parameter `propDocType` of this provider.
  String? get propDocType;

  /// The parameter `propDocNumber` of this provider.
  String? get propDocNumber;

  /// The parameter `firmName` of this provider.
  String? get firmName;

  /// The parameter `partnerDirectorCount` of this provider.
  String? get partnerDirectorCount;

  /// The parameter `panCardImage` of this provider.
  File? get panCardImage;

  /// The parameter `profileImage` of this provider.
  File? get profileImage;

  /// The parameter `chequeImage` of this provider.
  File? get chequeImage;

  /// The parameter `aadharImage` of this provider.
  File? get aadharImage;

  /// The parameter `adharBackImage` of this provider.
  File? get adharBackImage;

  /// The parameter `proprietorProof` of this provider.
  File? get proprietorProof;

  /// The parameter `moaAoa` of this provider.
  File? get moaAoa;

  /// The parameter `boardResolution` of this provider.
  File? get boardResolution;

  /// The parameter `directorProof` of this provider.
  File? get directorProof;
}

class _RegisterUserProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RegisterUserRef {
  _RegisterUserProviderElement(super.provider);

  @override
  String? get panCard => (origin as RegisterUserProvider).panCard;
  @override
  String? get phone => (origin as RegisterUserProvider).phone;
  @override
  String? get userName => (origin as RegisterUserProvider).userName;
  @override
  String? get constitution => (origin as RegisterUserProvider).constitution;
  @override
  String? get email => (origin as RegisterUserProvider).email;
  @override
  String? get adharNo => (origin as RegisterUserProvider).adharNo;
  @override
  String? get address => (origin as RegisterUserProvider).address;
  @override
  String? get locationState => (origin as RegisterUserProvider).locationState;
  @override
  String? get district => (origin as RegisterUserProvider).district;
  @override
  String? get pincode => (origin as RegisterUserProvider).pincode;
  @override
  String? get bankName => (origin as RegisterUserProvider).bankName;
  @override
  String? get bankBranch => (origin as RegisterUserProvider).bankBranch;
  @override
  String? get bankAccount => (origin as RegisterUserProvider).bankAccount;
  @override
  String? get ifscCode => (origin as RegisterUserProvider).ifscCode;
  @override
  String? get propDocType => (origin as RegisterUserProvider).propDocType;
  @override
  String? get propDocNumber => (origin as RegisterUserProvider).propDocNumber;
  @override
  String? get firmName => (origin as RegisterUserProvider).firmName;
  @override
  String? get partnerDirectorCount =>
      (origin as RegisterUserProvider).partnerDirectorCount;
  @override
  File? get panCardImage => (origin as RegisterUserProvider).panCardImage;
  @override
  File? get profileImage => (origin as RegisterUserProvider).profileImage;
  @override
  File? get chequeImage => (origin as RegisterUserProvider).chequeImage;
  @override
  File? get aadharImage => (origin as RegisterUserProvider).aadharImage;
  @override
  File? get adharBackImage => (origin as RegisterUserProvider).adharBackImage;
  @override
  File? get proprietorProof => (origin as RegisterUserProvider).proprietorProof;
  @override
  File? get moaAoa => (origin as RegisterUserProvider).moaAoa;
  @override
  File? get boardResolution => (origin as RegisterUserProvider).boardResolution;
  @override
  File? get directorProof => (origin as RegisterUserProvider).directorProof;
}

String _$registerOldUserHash() => r'e97cb859aaa7b94533a14c07c9dc5dd0a8158aa6';

/// See also [registerOldUser].
@ProviderFor(registerOldUser)
const registerOldUserProvider = RegisterOldUserFamily();

/// See also [registerOldUser].
class RegisterOldUserFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [registerOldUser].
  const RegisterOldUserFamily();

  /// See also [registerOldUser].
  RegisterOldUserProvider call({
    String? panCard,
    String? phone,
    String? userName,
    String? constitution,
    String? email,
    String? adharNo,
    String? address,
    String? locationState,
    String? district,
    String? pincode,
    String? bankName,
    String? bankBranch,
    String? bankAccount,
    String? ifscCode,
    String? propDocType,
    String? propDocNumber,
    String? firmName,
    String? partnerDirectorCount,
    File? panCardImage,
    File? profileImage,
    File? chequeImage,
    File? aadharImage,
    File? adharBackImage,
    File? proprietorProof,
    File? moaAoa,
    File? boardResolution,
    File? directorProof,
  }) {
    return RegisterOldUserProvider(
      panCard: panCard,
      phone: phone,
      userName: userName,
      constitution: constitution,
      email: email,
      adharNo: adharNo,
      address: address,
      locationState: locationState,
      district: district,
      pincode: pincode,
      bankName: bankName,
      bankBranch: bankBranch,
      bankAccount: bankAccount,
      ifscCode: ifscCode,
      propDocType: propDocType,
      propDocNumber: propDocNumber,
      firmName: firmName,
      partnerDirectorCount: partnerDirectorCount,
      panCardImage: panCardImage,
      profileImage: profileImage,
      chequeImage: chequeImage,
      aadharImage: aadharImage,
      adharBackImage: adharBackImage,
      proprietorProof: proprietorProof,
      moaAoa: moaAoa,
      boardResolution: boardResolution,
      directorProof: directorProof,
    );
  }

  @override
  RegisterOldUserProvider getProviderOverride(
    covariant RegisterOldUserProvider provider,
  ) {
    return call(
      panCard: provider.panCard,
      phone: provider.phone,
      userName: provider.userName,
      constitution: provider.constitution,
      email: provider.email,
      adharNo: provider.adharNo,
      address: provider.address,
      locationState: provider.locationState,
      district: provider.district,
      pincode: provider.pincode,
      bankName: provider.bankName,
      bankBranch: provider.bankBranch,
      bankAccount: provider.bankAccount,
      ifscCode: provider.ifscCode,
      propDocType: provider.propDocType,
      propDocNumber: provider.propDocNumber,
      firmName: provider.firmName,
      partnerDirectorCount: provider.partnerDirectorCount,
      panCardImage: provider.panCardImage,
      profileImage: provider.profileImage,
      chequeImage: provider.chequeImage,
      aadharImage: provider.aadharImage,
      adharBackImage: provider.adharBackImage,
      proprietorProof: provider.proprietorProof,
      moaAoa: provider.moaAoa,
      boardResolution: provider.boardResolution,
      directorProof: provider.directorProof,
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
  String? get name => r'registerOldUserProvider';
}

/// See also [registerOldUser].
class RegisterOldUserProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [registerOldUser].
  RegisterOldUserProvider({
    String? panCard,
    String? phone,
    String? userName,
    String? constitution,
    String? email,
    String? adharNo,
    String? address,
    String? locationState,
    String? district,
    String? pincode,
    String? bankName,
    String? bankBranch,
    String? bankAccount,
    String? ifscCode,
    String? propDocType,
    String? propDocNumber,
    String? firmName,
    String? partnerDirectorCount,
    File? panCardImage,
    File? profileImage,
    File? chequeImage,
    File? aadharImage,
    File? adharBackImage,
    File? proprietorProof,
    File? moaAoa,
    File? boardResolution,
    File? directorProof,
  }) : this._internal(
          (ref) => registerOldUser(
            ref as RegisterOldUserRef,
            panCard: panCard,
            phone: phone,
            userName: userName,
            constitution: constitution,
            email: email,
            adharNo: adharNo,
            address: address,
            locationState: locationState,
            district: district,
            pincode: pincode,
            bankName: bankName,
            bankBranch: bankBranch,
            bankAccount: bankAccount,
            ifscCode: ifscCode,
            propDocType: propDocType,
            propDocNumber: propDocNumber,
            firmName: firmName,
            partnerDirectorCount: partnerDirectorCount,
            panCardImage: panCardImage,
            profileImage: profileImage,
            chequeImage: chequeImage,
            aadharImage: aadharImage,
            adharBackImage: adharBackImage,
            proprietorProof: proprietorProof,
            moaAoa: moaAoa,
            boardResolution: boardResolution,
            directorProof: directorProof,
          ),
          from: registerOldUserProvider,
          name: r'registerOldUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registerOldUserHash,
          dependencies: RegisterOldUserFamily._dependencies,
          allTransitiveDependencies:
              RegisterOldUserFamily._allTransitiveDependencies,
          panCard: panCard,
          phone: phone,
          userName: userName,
          constitution: constitution,
          email: email,
          adharNo: adharNo,
          address: address,
          locationState: locationState,
          district: district,
          pincode: pincode,
          bankName: bankName,
          bankBranch: bankBranch,
          bankAccount: bankAccount,
          ifscCode: ifscCode,
          propDocType: propDocType,
          propDocNumber: propDocNumber,
          firmName: firmName,
          partnerDirectorCount: partnerDirectorCount,
          panCardImage: panCardImage,
          profileImage: profileImage,
          chequeImage: chequeImage,
          aadharImage: aadharImage,
          adharBackImage: adharBackImage,
          proprietorProof: proprietorProof,
          moaAoa: moaAoa,
          boardResolution: boardResolution,
          directorProof: directorProof,
        );

  RegisterOldUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.panCard,
    required this.phone,
    required this.userName,
    required this.constitution,
    required this.email,
    required this.adharNo,
    required this.address,
    required this.locationState,
    required this.district,
    required this.pincode,
    required this.bankName,
    required this.bankBranch,
    required this.bankAccount,
    required this.ifscCode,
    required this.propDocType,
    required this.propDocNumber,
    required this.firmName,
    required this.partnerDirectorCount,
    required this.panCardImage,
    required this.profileImage,
    required this.chequeImage,
    required this.aadharImage,
    required this.adharBackImage,
    required this.proprietorProof,
    required this.moaAoa,
    required this.boardResolution,
    required this.directorProof,
  }) : super.internal();

  final String? panCard;
  final String? phone;
  final String? userName;
  final String? constitution;
  final String? email;
  final String? adharNo;
  final String? address;
  final String? locationState;
  final String? district;
  final String? pincode;
  final String? bankName;
  final String? bankBranch;
  final String? bankAccount;
  final String? ifscCode;
  final String? propDocType;
  final String? propDocNumber;
  final String? firmName;
  final String? partnerDirectorCount;
  final File? panCardImage;
  final File? profileImage;
  final File? chequeImage;
  final File? aadharImage;
  final File? adharBackImage;
  final File? proprietorProof;
  final File? moaAoa;
  final File? boardResolution;
  final File? directorProof;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(RegisterOldUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterOldUserProvider._internal(
        (ref) => create(ref as RegisterOldUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        panCard: panCard,
        phone: phone,
        userName: userName,
        constitution: constitution,
        email: email,
        adharNo: adharNo,
        address: address,
        locationState: locationState,
        district: district,
        pincode: pincode,
        bankName: bankName,
        bankBranch: bankBranch,
        bankAccount: bankAccount,
        ifscCode: ifscCode,
        propDocType: propDocType,
        propDocNumber: propDocNumber,
        firmName: firmName,
        partnerDirectorCount: partnerDirectorCount,
        panCardImage: panCardImage,
        profileImage: profileImage,
        chequeImage: chequeImage,
        aadharImage: aadharImage,
        adharBackImage: adharBackImage,
        proprietorProof: proprietorProof,
        moaAoa: moaAoa,
        boardResolution: boardResolution,
        directorProof: directorProof,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _RegisterOldUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterOldUserProvider &&
        other.panCard == panCard &&
        other.phone == phone &&
        other.userName == userName &&
        other.constitution == constitution &&
        other.email == email &&
        other.adharNo == adharNo &&
        other.address == address &&
        other.locationState == locationState &&
        other.district == district &&
        other.pincode == pincode &&
        other.bankName == bankName &&
        other.bankBranch == bankBranch &&
        other.bankAccount == bankAccount &&
        other.ifscCode == ifscCode &&
        other.propDocType == propDocType &&
        other.propDocNumber == propDocNumber &&
        other.firmName == firmName &&
        other.partnerDirectorCount == partnerDirectorCount &&
        other.panCardImage == panCardImage &&
        other.profileImage == profileImage &&
        other.chequeImage == chequeImage &&
        other.aadharImage == aadharImage &&
        other.adharBackImage == adharBackImage &&
        other.proprietorProof == proprietorProof &&
        other.moaAoa == moaAoa &&
        other.boardResolution == boardResolution &&
        other.directorProof == directorProof;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, panCard.hashCode);
    hash = _SystemHash.combine(hash, phone.hashCode);
    hash = _SystemHash.combine(hash, userName.hashCode);
    hash = _SystemHash.combine(hash, constitution.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, adharNo.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, locationState.hashCode);
    hash = _SystemHash.combine(hash, district.hashCode);
    hash = _SystemHash.combine(hash, pincode.hashCode);
    hash = _SystemHash.combine(hash, bankName.hashCode);
    hash = _SystemHash.combine(hash, bankBranch.hashCode);
    hash = _SystemHash.combine(hash, bankAccount.hashCode);
    hash = _SystemHash.combine(hash, ifscCode.hashCode);
    hash = _SystemHash.combine(hash, propDocType.hashCode);
    hash = _SystemHash.combine(hash, propDocNumber.hashCode);
    hash = _SystemHash.combine(hash, firmName.hashCode);
    hash = _SystemHash.combine(hash, partnerDirectorCount.hashCode);
    hash = _SystemHash.combine(hash, panCardImage.hashCode);
    hash = _SystemHash.combine(hash, profileImage.hashCode);
    hash = _SystemHash.combine(hash, chequeImage.hashCode);
    hash = _SystemHash.combine(hash, aadharImage.hashCode);
    hash = _SystemHash.combine(hash, adharBackImage.hashCode);
    hash = _SystemHash.combine(hash, proprietorProof.hashCode);
    hash = _SystemHash.combine(hash, moaAoa.hashCode);
    hash = _SystemHash.combine(hash, boardResolution.hashCode);
    hash = _SystemHash.combine(hash, directorProof.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegisterOldUserRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `panCard` of this provider.
  String? get panCard;

  /// The parameter `phone` of this provider.
  String? get phone;

  /// The parameter `userName` of this provider.
  String? get userName;

  /// The parameter `constitution` of this provider.
  String? get constitution;

  /// The parameter `email` of this provider.
  String? get email;

  /// The parameter `adharNo` of this provider.
  String? get adharNo;

  /// The parameter `address` of this provider.
  String? get address;

  /// The parameter `locationState` of this provider.
  String? get locationState;

  /// The parameter `district` of this provider.
  String? get district;

  /// The parameter `pincode` of this provider.
  String? get pincode;

  /// The parameter `bankName` of this provider.
  String? get bankName;

  /// The parameter `bankBranch` of this provider.
  String? get bankBranch;

  /// The parameter `bankAccount` of this provider.
  String? get bankAccount;

  /// The parameter `ifscCode` of this provider.
  String? get ifscCode;

  /// The parameter `propDocType` of this provider.
  String? get propDocType;

  /// The parameter `propDocNumber` of this provider.
  String? get propDocNumber;

  /// The parameter `firmName` of this provider.
  String? get firmName;

  /// The parameter `partnerDirectorCount` of this provider.
  String? get partnerDirectorCount;

  /// The parameter `panCardImage` of this provider.
  File? get panCardImage;

  /// The parameter `profileImage` of this provider.
  File? get profileImage;

  /// The parameter `chequeImage` of this provider.
  File? get chequeImage;

  /// The parameter `aadharImage` of this provider.
  File? get aadharImage;

  /// The parameter `adharBackImage` of this provider.
  File? get adharBackImage;

  /// The parameter `proprietorProof` of this provider.
  File? get proprietorProof;

  /// The parameter `moaAoa` of this provider.
  File? get moaAoa;

  /// The parameter `boardResolution` of this provider.
  File? get boardResolution;

  /// The parameter `directorProof` of this provider.
  File? get directorProof;
}

class _RegisterOldUserProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RegisterOldUserRef {
  _RegisterOldUserProviderElement(super.provider);

  @override
  String? get panCard => (origin as RegisterOldUserProvider).panCard;
  @override
  String? get phone => (origin as RegisterOldUserProvider).phone;
  @override
  String? get userName => (origin as RegisterOldUserProvider).userName;
  @override
  String? get constitution => (origin as RegisterOldUserProvider).constitution;
  @override
  String? get email => (origin as RegisterOldUserProvider).email;
  @override
  String? get adharNo => (origin as RegisterOldUserProvider).adharNo;
  @override
  String? get address => (origin as RegisterOldUserProvider).address;
  @override
  String? get locationState =>
      (origin as RegisterOldUserProvider).locationState;
  @override
  String? get district => (origin as RegisterOldUserProvider).district;
  @override
  String? get pincode => (origin as RegisterOldUserProvider).pincode;
  @override
  String? get bankName => (origin as RegisterOldUserProvider).bankName;
  @override
  String? get bankBranch => (origin as RegisterOldUserProvider).bankBranch;
  @override
  String? get bankAccount => (origin as RegisterOldUserProvider).bankAccount;
  @override
  String? get ifscCode => (origin as RegisterOldUserProvider).ifscCode;
  @override
  String? get propDocType => (origin as RegisterOldUserProvider).propDocType;
  @override
  String? get propDocNumber =>
      (origin as RegisterOldUserProvider).propDocNumber;
  @override
  String? get firmName => (origin as RegisterOldUserProvider).firmName;
  @override
  String? get partnerDirectorCount =>
      (origin as RegisterOldUserProvider).partnerDirectorCount;
  @override
  File? get panCardImage => (origin as RegisterOldUserProvider).panCardImage;
  @override
  File? get profileImage => (origin as RegisterOldUserProvider).profileImage;
  @override
  File? get chequeImage => (origin as RegisterOldUserProvider).chequeImage;
  @override
  File? get aadharImage => (origin as RegisterOldUserProvider).aadharImage;
  @override
  File? get adharBackImage =>
      (origin as RegisterOldUserProvider).adharBackImage;
  @override
  File? get proprietorProof =>
      (origin as RegisterOldUserProvider).proprietorProof;
  @override
  File? get moaAoa => (origin as RegisterOldUserProvider).moaAoa;
  @override
  File? get boardResolution =>
      (origin as RegisterOldUserProvider).boardResolution;
  @override
  File? get directorProof => (origin as RegisterOldUserProvider).directorProof;
}

String _$directorsPartnersListHash() =>
    r'58f69c599d3d8d0873e8163ce0e02429dbeb0ffb';

/// See also [directorsPartnersList].
@ProviderFor(directorsPartnersList)
final directorsPartnersListProvider =
    AutoDisposeStreamProvider<ListOfDirectorsModel>.internal(
  directorsPartnersList,
  name: r'directorsPartnersListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$directorsPartnersListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DirectorsPartnersListRef
    = AutoDisposeStreamProviderRef<ListOfDirectorsModel>;
String _$sendVerifyDirectorOtpHash() =>
    r'48df5c00dc43211af66124818c0a1823755fc288';

/// See also [sendVerifyDirectorOtp].
@ProviderFor(sendVerifyDirectorOtp)
const sendVerifyDirectorOtpProvider = SendVerifyDirectorOtpFamily();

/// See also [sendVerifyDirectorOtp].
class SendVerifyDirectorOtpFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [sendVerifyDirectorOtp].
  const SendVerifyDirectorOtpFamily();

  /// See also [sendVerifyDirectorOtp].
  SendVerifyDirectorOtpProvider call({
    String? phoneNumber,
    String? id,
  }) {
    return SendVerifyDirectorOtpProvider(
      phoneNumber: phoneNumber,
      id: id,
    );
  }

  @override
  SendVerifyDirectorOtpProvider getProviderOverride(
    covariant SendVerifyDirectorOtpProvider provider,
  ) {
    return call(
      phoneNumber: provider.phoneNumber,
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
  String? get name => r'sendVerifyDirectorOtpProvider';
}

/// See also [sendVerifyDirectorOtp].
class SendVerifyDirectorOtpProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [sendVerifyDirectorOtp].
  SendVerifyDirectorOtpProvider({
    String? phoneNumber,
    String? id,
  }) : this._internal(
          (ref) => sendVerifyDirectorOtp(
            ref as SendVerifyDirectorOtpRef,
            phoneNumber: phoneNumber,
            id: id,
          ),
          from: sendVerifyDirectorOtpProvider,
          name: r'sendVerifyDirectorOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendVerifyDirectorOtpHash,
          dependencies: SendVerifyDirectorOtpFamily._dependencies,
          allTransitiveDependencies:
              SendVerifyDirectorOtpFamily._allTransitiveDependencies,
          phoneNumber: phoneNumber,
          id: id,
        );

  SendVerifyDirectorOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.phoneNumber,
    required this.id,
  }) : super.internal();

  final String? phoneNumber;
  final String? id;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(SendVerifyDirectorOtpRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendVerifyDirectorOtpProvider._internal(
        (ref) => create(ref as SendVerifyDirectorOtpRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        phoneNumber: phoneNumber,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SendVerifyDirectorOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendVerifyDirectorOtpProvider &&
        other.phoneNumber == phoneNumber &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phoneNumber.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SendVerifyDirectorOtpRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `phoneNumber` of this provider.
  String? get phoneNumber;

  /// The parameter `id` of this provider.
  String? get id;
}

class _SendVerifyDirectorOtpProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SendVerifyDirectorOtpRef {
  _SendVerifyDirectorOtpProviderElement(super.provider);

  @override
  String? get phoneNumber =>
      (origin as SendVerifyDirectorOtpProvider).phoneNumber;
  @override
  String? get id => (origin as SendVerifyDirectorOtpProvider).id;
}

String _$editDirectorPartnerHash() =>
    r'f3bc64889dd472f11023971abbb8dd359ab9c4c4';

/// See also [editDirectorPartner].
@ProviderFor(editDirectorPartner)
const editDirectorPartnerProvider = EditDirectorPartnerFamily();

/// See also [editDirectorPartner].
class EditDirectorPartnerFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [editDirectorPartner].
  const EditDirectorPartnerFamily();

  /// See also [editDirectorPartner].
  EditDirectorPartnerProvider call({
    required String personName,
    required String id,
    required String phoneNumber,
    required String panNo,
    required String aadharNo,
    required String otp,
    File? profilePhoto,
  }) {
    return EditDirectorPartnerProvider(
      personName: personName,
      id: id,
      phoneNumber: phoneNumber,
      panNo: panNo,
      aadharNo: aadharNo,
      otp: otp,
      profilePhoto: profilePhoto,
    );
  }

  @override
  EditDirectorPartnerProvider getProviderOverride(
    covariant EditDirectorPartnerProvider provider,
  ) {
    return call(
      personName: provider.personName,
      id: provider.id,
      phoneNumber: provider.phoneNumber,
      panNo: provider.panNo,
      aadharNo: provider.aadharNo,
      otp: provider.otp,
      profilePhoto: provider.profilePhoto,
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
  String? get name => r'editDirectorPartnerProvider';
}

/// See also [editDirectorPartner].
class EditDirectorPartnerProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [editDirectorPartner].
  EditDirectorPartnerProvider({
    required String personName,
    required String id,
    required String phoneNumber,
    required String panNo,
    required String aadharNo,
    required String otp,
    File? profilePhoto,
  }) : this._internal(
          (ref) => editDirectorPartner(
            ref as EditDirectorPartnerRef,
            personName: personName,
            id: id,
            phoneNumber: phoneNumber,
            panNo: panNo,
            aadharNo: aadharNo,
            otp: otp,
            profilePhoto: profilePhoto,
          ),
          from: editDirectorPartnerProvider,
          name: r'editDirectorPartnerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editDirectorPartnerHash,
          dependencies: EditDirectorPartnerFamily._dependencies,
          allTransitiveDependencies:
              EditDirectorPartnerFamily._allTransitiveDependencies,
          personName: personName,
          id: id,
          phoneNumber: phoneNumber,
          panNo: panNo,
          aadharNo: aadharNo,
          otp: otp,
          profilePhoto: profilePhoto,
        );

  EditDirectorPartnerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.personName,
    required this.id,
    required this.phoneNumber,
    required this.panNo,
    required this.aadharNo,
    required this.otp,
    required this.profilePhoto,
  }) : super.internal();

  final String personName;
  final String id;
  final String phoneNumber;
  final String panNo;
  final String aadharNo;
  final String otp;
  final File? profilePhoto;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(EditDirectorPartnerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditDirectorPartnerProvider._internal(
        (ref) => create(ref as EditDirectorPartnerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        personName: personName,
        id: id,
        phoneNumber: phoneNumber,
        panNo: panNo,
        aadharNo: aadharNo,
        otp: otp,
        profilePhoto: profilePhoto,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _EditDirectorPartnerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditDirectorPartnerProvider &&
        other.personName == personName &&
        other.id == id &&
        other.phoneNumber == phoneNumber &&
        other.panNo == panNo &&
        other.aadharNo == aadharNo &&
        other.otp == otp &&
        other.profilePhoto == profilePhoto;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, personName.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, phoneNumber.hashCode);
    hash = _SystemHash.combine(hash, panNo.hashCode);
    hash = _SystemHash.combine(hash, aadharNo.hashCode);
    hash = _SystemHash.combine(hash, otp.hashCode);
    hash = _SystemHash.combine(hash, profilePhoto.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditDirectorPartnerRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `personName` of this provider.
  String get personName;

  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `phoneNumber` of this provider.
  String get phoneNumber;

  /// The parameter `panNo` of this provider.
  String get panNo;

  /// The parameter `aadharNo` of this provider.
  String get aadharNo;

  /// The parameter `otp` of this provider.
  String get otp;

  /// The parameter `profilePhoto` of this provider.
  File? get profilePhoto;
}

class _EditDirectorPartnerProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with EditDirectorPartnerRef {
  _EditDirectorPartnerProviderElement(super.provider);

  @override
  String get personName => (origin as EditDirectorPartnerProvider).personName;
  @override
  String get id => (origin as EditDirectorPartnerProvider).id;
  @override
  String get phoneNumber => (origin as EditDirectorPartnerProvider).phoneNumber;
  @override
  String get panNo => (origin as EditDirectorPartnerProvider).panNo;
  @override
  String get aadharNo => (origin as EditDirectorPartnerProvider).aadharNo;
  @override
  String get otp => (origin as EditDirectorPartnerProvider).otp;
  @override
  File? get profilePhoto =>
      (origin as EditDirectorPartnerProvider).profilePhoto;
}

String _$addDirectorDetailsHash() =>
    r'02e38473e5b7dc7a5b09efd2d1952f03233ce97b';

/// See also [addDirectorDetails].
@ProviderFor(addDirectorDetails)
const addDirectorDetailsProvider = AddDirectorDetailsFamily();

/// See also [addDirectorDetails].
class AddDirectorDetailsFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [addDirectorDetails].
  const AddDirectorDetailsFamily();

  /// See also [addDirectorDetails].
  AddDirectorDetailsProvider call({
    required String personName,
    required String phoneNumber,
    required String panNo,
    required String aadharNo,
    required String otp,
    required File profilePhoto,
  }) {
    return AddDirectorDetailsProvider(
      personName: personName,
      phoneNumber: phoneNumber,
      panNo: panNo,
      aadharNo: aadharNo,
      otp: otp,
      profilePhoto: profilePhoto,
    );
  }

  @override
  AddDirectorDetailsProvider getProviderOverride(
    covariant AddDirectorDetailsProvider provider,
  ) {
    return call(
      personName: provider.personName,
      phoneNumber: provider.phoneNumber,
      panNo: provider.panNo,
      aadharNo: provider.aadharNo,
      otp: provider.otp,
      profilePhoto: provider.profilePhoto,
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
  String? get name => r'addDirectorDetailsProvider';
}

/// See also [addDirectorDetails].
class AddDirectorDetailsProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [addDirectorDetails].
  AddDirectorDetailsProvider({
    required String personName,
    required String phoneNumber,
    required String panNo,
    required String aadharNo,
    required String otp,
    required File profilePhoto,
  }) : this._internal(
          (ref) => addDirectorDetails(
            ref as AddDirectorDetailsRef,
            personName: personName,
            phoneNumber: phoneNumber,
            panNo: panNo,
            aadharNo: aadharNo,
            otp: otp,
            profilePhoto: profilePhoto,
          ),
          from: addDirectorDetailsProvider,
          name: r'addDirectorDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addDirectorDetailsHash,
          dependencies: AddDirectorDetailsFamily._dependencies,
          allTransitiveDependencies:
              AddDirectorDetailsFamily._allTransitiveDependencies,
          personName: personName,
          phoneNumber: phoneNumber,
          panNo: panNo,
          aadharNo: aadharNo,
          otp: otp,
          profilePhoto: profilePhoto,
        );

  AddDirectorDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.personName,
    required this.phoneNumber,
    required this.panNo,
    required this.aadharNo,
    required this.otp,
    required this.profilePhoto,
  }) : super.internal();

  final String personName;
  final String phoneNumber;
  final String panNo;
  final String aadharNo;
  final String otp;
  final File profilePhoto;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(AddDirectorDetailsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddDirectorDetailsProvider._internal(
        (ref) => create(ref as AddDirectorDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        personName: personName,
        phoneNumber: phoneNumber,
        panNo: panNo,
        aadharNo: aadharNo,
        otp: otp,
        profilePhoto: profilePhoto,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _AddDirectorDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddDirectorDetailsProvider &&
        other.personName == personName &&
        other.phoneNumber == phoneNumber &&
        other.panNo == panNo &&
        other.aadharNo == aadharNo &&
        other.otp == otp &&
        other.profilePhoto == profilePhoto;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, personName.hashCode);
    hash = _SystemHash.combine(hash, phoneNumber.hashCode);
    hash = _SystemHash.combine(hash, panNo.hashCode);
    hash = _SystemHash.combine(hash, aadharNo.hashCode);
    hash = _SystemHash.combine(hash, otp.hashCode);
    hash = _SystemHash.combine(hash, profilePhoto.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddDirectorDetailsRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `personName` of this provider.
  String get personName;

  /// The parameter `phoneNumber` of this provider.
  String get phoneNumber;

  /// The parameter `panNo` of this provider.
  String get panNo;

  /// The parameter `aadharNo` of this provider.
  String get aadharNo;

  /// The parameter `otp` of this provider.
  String get otp;

  /// The parameter `profilePhoto` of this provider.
  File get profilePhoto;
}

class _AddDirectorDetailsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with AddDirectorDetailsRef {
  _AddDirectorDetailsProviderElement(super.provider);

  @override
  String get personName => (origin as AddDirectorDetailsProvider).personName;
  @override
  String get phoneNumber => (origin as AddDirectorDetailsProvider).phoneNumber;
  @override
  String get panNo => (origin as AddDirectorDetailsProvider).panNo;
  @override
  String get aadharNo => (origin as AddDirectorDetailsProvider).aadharNo;
  @override
  String get otp => (origin as AddDirectorDetailsProvider).otp;
  @override
  File get profilePhoto => (origin as AddDirectorDetailsProvider).profilePhoto;
}

String _$sendDirectorOtpHash() => r'1e1509027b1624a666404809941466f3d6b5fc69';

/// See also [sendDirectorOtp].
@ProviderFor(sendDirectorOtp)
const sendDirectorOtpProvider = SendDirectorOtpFamily();

/// See also [sendDirectorOtp].
class SendDirectorOtpFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [sendDirectorOtp].
  const SendDirectorOtpFamily();

  /// See also [sendDirectorOtp].
  SendDirectorOtpProvider call({
    String? phoneNumber,
  }) {
    return SendDirectorOtpProvider(
      phoneNumber: phoneNumber,
    );
  }

  @override
  SendDirectorOtpProvider getProviderOverride(
    covariant SendDirectorOtpProvider provider,
  ) {
    return call(
      phoneNumber: provider.phoneNumber,
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
  String? get name => r'sendDirectorOtpProvider';
}

/// See also [sendDirectorOtp].
class SendDirectorOtpProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [sendDirectorOtp].
  SendDirectorOtpProvider({
    String? phoneNumber,
  }) : this._internal(
          (ref) => sendDirectorOtp(
            ref as SendDirectorOtpRef,
            phoneNumber: phoneNumber,
          ),
          from: sendDirectorOtpProvider,
          name: r'sendDirectorOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendDirectorOtpHash,
          dependencies: SendDirectorOtpFamily._dependencies,
          allTransitiveDependencies:
              SendDirectorOtpFamily._allTransitiveDependencies,
          phoneNumber: phoneNumber,
        );

  SendDirectorOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.phoneNumber,
  }) : super.internal();

  final String? phoneNumber;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(SendDirectorOtpRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendDirectorOtpProvider._internal(
        (ref) => create(ref as SendDirectorOtpRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SendDirectorOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendDirectorOtpProvider && other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phoneNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SendDirectorOtpRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `phoneNumber` of this provider.
  String? get phoneNumber;
}

class _SendDirectorOtpProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SendDirectorOtpRef {
  _SendDirectorOtpProviderElement(super.provider);

  @override
  String? get phoneNumber => (origin as SendDirectorOtpProvider).phoneNumber;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
