// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package, duplicate_ignore, unnecessary_cast

part of 'LoginService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sendOtpHash() => r'd336cef737a3a06133cb624b78f3a973583f1e5e';

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

/// See also [sendOtp].
@ProviderFor(sendOtp)
const sendOtpProvider = SendOtpFamily();

/// See also [sendOtp].
class SendOtpFamily extends Family<AsyncValue<OtpResponseModel>> {
  /// See also [sendOtp].
  const SendOtpFamily();

  /// See also [sendOtp].
  SendOtpProvider call({
    String? number,
    String? fcmToken,
  }) {
    return SendOtpProvider(
      number: number,
      fcmToken: fcmToken,
    );
  }

  @override
  SendOtpProvider getProviderOverride(
    covariant SendOtpProvider provider,
  ) {
    return call(
      number: provider.number,
      fcmToken: provider.fcmToken,
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
  String? get name => r'sendOtpProvider';
}

/// See also [sendOtp].
class SendOtpProvider extends AutoDisposeFutureProvider<OtpResponseModel> {
  /// See also [sendOtp].
  SendOtpProvider({
    String? number,
    String? fcmToken,
  }) : this._internal(
          (ref) => sendOtp(
            ref as SendOtpRef,
            number: number,
            fcmToken: fcmToken,
          ),
          from: sendOtpProvider,
          name: r'sendOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendOtpHash,
          dependencies: SendOtpFamily._dependencies,
          allTransitiveDependencies: SendOtpFamily._allTransitiveDependencies,
          number: number,
          fcmToken: fcmToken,
        );

  SendOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
    required this.fcmToken,
  }) : super.internal();

  final String? number;
  final String? fcmToken;

  @override
  Override overrideWith(
    FutureOr<OtpResponseModel> Function(SendOtpRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendOtpProvider._internal(
        (ref) => create(ref as SendOtpRef),
        from: from,
        name: name,
        dependencies: dependencies,
        allTransitiveDependencies: allTransitiveDependencies,
        debugGetCreateSourceHash: debugGetCreateSourceHash,
        number: number,
        fcmToken: fcmToken,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OtpResponseModel> createElement() {
    return _SendOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendOtpProvider &&
        other.number == number &&
        other.fcmToken == fcmToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);
    hash = _SystemHash.combine(hash, fcmToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SendOtpRef on AutoDisposeFutureProviderRef<OtpResponseModel> {
  /// The parameter `number` of this provider.
  String? get number;

  /// The parameter `fcmToken` of this provider.
  String? get fcmToken;
}

class _SendOtpProviderElement
    extends AutoDisposeFutureProviderElement<OtpResponseModel> with SendOtpRef {
  _SendOtpProviderElement(super.provider);

  @override
  String? get number => (origin as SendOtpProvider).number;
  @override
  String? get fcmToken => (origin as SendOtpProvider).fcmToken;
}

String _$sendOtpV1Hash() => r'e27b14073e449257e1bb706ea46e094c8b6b060d';

/// See also [sendOtpV1].
@ProviderFor(sendOtpV1)
const sendOtpV1Provider = SendOtpV1Family();

/// See also [sendOtpV1].
class SendOtpV1Family extends Family<AsyncValue<OtpResponseModel>> {
  /// See also [sendOtpV1].
  const SendOtpV1Family();

  /// See also [sendOtpV1].
  SendOtpV1Provider call({
    String? number,
    String? fcmToken,
  }) {
    return SendOtpV1Provider(
      number: number,
      fcmToken: fcmToken,
    );
  }

  @override
  SendOtpV1Provider getProviderOverride(
    covariant SendOtpV1Provider provider,
  ) {
    return call(
      number: provider.number,
      fcmToken: provider.fcmToken,
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
  String? get name => r'sendOtpV1Provider';
}

/// See also [sendOtpV1].
class SendOtpV1Provider extends AutoDisposeFutureProvider<OtpResponseModel> {
  /// See also [sendOtpV1].
  SendOtpV1Provider({
    String? number,
    String? fcmToken,
  }) : this._internal(
          (ref) => sendOtpV1(
            ref as SendOtpV1Ref,
            number: number,
            fcmToken: fcmToken,
          ),
          from: sendOtpV1Provider,
          name: r'sendOtpV1Provider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendOtpV1Hash,
          dependencies: SendOtpV1Family._dependencies,
          allTransitiveDependencies: SendOtpV1Family._allTransitiveDependencies,
          number: number,
          fcmToken: fcmToken,
        );

  SendOtpV1Provider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
    required this.fcmToken,
  }) : super.internal();

  final String? number;
  final String? fcmToken;

  @override
  Override overrideWith(
    FutureOr<OtpResponseModel> Function(SendOtpV1Ref provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendOtpV1Provider._internal(
        (ref) => create(ref as SendOtpV1Ref),
        from: from,
        name: name,
        dependencies: dependencies,
        allTransitiveDependencies: allTransitiveDependencies,
        debugGetCreateSourceHash: debugGetCreateSourceHash,
        number: number,
        fcmToken: fcmToken,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OtpResponseModel> createElement() {
    return _SendOtpV1ProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendOtpV1Provider &&
        other.number == number &&
        other.fcmToken == fcmToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);
    hash = _SystemHash.combine(hash, fcmToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SendOtpV1Ref on AutoDisposeFutureProviderRef<OtpResponseModel> {
  /// The parameter `number` of this provider.
  String? get number;

  /// The parameter `fcmToken` of this provider.
  String? get fcmToken;
}

class _SendOtpV1ProviderElement
    extends AutoDisposeFutureProviderElement<OtpResponseModel>
    with SendOtpV1Ref {
  _SendOtpV1ProviderElement(super.provider);

  @override
  String? get number => (origin as SendOtpV1Provider).number;
  @override
  String? get fcmToken => (origin as SendOtpV1Provider).fcmToken;
}

String _$verifyOtpHash() => r'fa08dffdf212ef54be1297e29965fc71295b9278';

/// See also [verifyOtp].
@ProviderFor(verifyOtp)
const verifyOtpProvider = VerifyOtpFamily();

/// See also [verifyOtp].
class VerifyOtpFamily extends Family<AsyncValue<AuthenticationModel>> {
  /// See also [verifyOtp].
  const VerifyOtpFamily();

  /// See also [verifyOtp].
  VerifyOtpProvider call({
    String? num,
    String? otp,
    String? fcmToken,
  }) {
    return VerifyOtpProvider(
      num: num,
      otp: otp,
      fcmToken: fcmToken,
    );
  }

  @override
  VerifyOtpProvider getProviderOverride(
    covariant VerifyOtpProvider provider,
  ) {
    return call(
      num: provider.num,
      otp: provider.otp,
      fcmToken: provider.fcmToken,
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
  String? get name => r'verifyOtpProvider';
}

/// See also [verifyOtp].
class VerifyOtpProvider
    extends AutoDisposeFutureProvider<AuthenticationModel> {
  /// See also [verifyOtp].
  VerifyOtpProvider({
    String? num,
    String? otp,
    String? fcmToken,
  }) : this._internal(
          (ref) => verifyOtp(
            ref as VerifyOtpRef,
            num: num,
            otp: otp,
            fcmToken: fcmToken,
          ),
          from: verifyOtpProvider,
          name: r'verifyOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$verifyOtpHash,
          dependencies: VerifyOtpFamily._dependencies,
          allTransitiveDependencies:
              VerifyOtpFamily._allTransitiveDependencies,
          num: num,
          otp: otp,
          fcmToken: fcmToken,
        );

  VerifyOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.num,
    required this.otp,
    required this.fcmToken,
  }) : super.internal();

  final String? num;
  final String? otp;
  final String? fcmToken;

  @override
  Override overrideWith(
    FutureOr<AuthenticationModel> Function(VerifyOtpRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VerifyOtpProvider._internal(
        (ref) => create(ref as VerifyOtpRef),
        from: from,
        name: name,
        dependencies: dependencies,
        allTransitiveDependencies: allTransitiveDependencies,
        debugGetCreateSourceHash: debugGetCreateSourceHash,
        num: num,
        otp: otp,
        fcmToken: fcmToken,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AuthenticationModel> createElement() {
    return _VerifyOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VerifyOtpProvider &&
        other.num == num &&
        other.otp == otp &&
        other.fcmToken == fcmToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, num.hashCode);
    hash = _SystemHash.combine(hash, otp.hashCode);
    hash = _SystemHash.combine(hash, fcmToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VerifyOtpRef on AutoDisposeFutureProviderRef<AuthenticationModel> {
  /// The parameter `num` of this provider.
  String? get num;

  /// The parameter `otp` of this provider.
  String? get otp;

  /// The parameter `fcmToken` of this provider.
  String? get fcmToken;
}

class _VerifyOtpProviderElement
    extends AutoDisposeFutureProviderElement<AuthenticationModel>
    with VerifyOtpRef {
  _VerifyOtpProviderElement(super.provider);

  @override
  String? get num => (origin as VerifyOtpProvider).num;
  @override
  String? get otp => (origin as VerifyOtpProvider).otp;
  @override
  String? get fcmToken => (origin as VerifyOtpProvider).fcmToken;
}

// ---------------------------------------------------------------------------
// checkUser
// ---------------------------------------------------------------------------

String _$checkUserHash() => r'c0a1b2c3d4e5f60718293a4b5c6d7e8f90123456';

/// See also [checkUser].
@ProviderFor(checkUser)
const checkUserProvider = CheckUserFamily();

/// See also [checkUser].
class CheckUserFamily extends Family<AsyncValue<CheckUserModel>> {
  /// See also [checkUser].
  const CheckUserFamily();

  /// See also [checkUser].
  CheckUserProvider call({
    required String number,
  }) {
    return CheckUserProvider(
      number: number,
    );
  }

  @override
  CheckUserProvider getProviderOverride(
    covariant CheckUserProvider provider,
  ) {
    return call(
      number: provider.number,
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
  String? get name => r'checkUserProvider';
}

/// See also [checkUser].
class CheckUserProvider
    extends AutoDisposeFutureProvider<CheckUserModel> {
  /// See also [checkUser].
  CheckUserProvider({
    required String number,
  }) : this._internal(
          (ref) => checkUser(
            ref as CheckUserRef,
            number: number,
          ),
          from: checkUserProvider,
          name: r'checkUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkUserHash,
          dependencies: CheckUserFamily._dependencies,
          allTransitiveDependencies:
              CheckUserFamily._allTransitiveDependencies,
          number: number,
        );

  CheckUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
  }) : super.internal();

  final String number;

  @override
  Override overrideWith(
    FutureOr<CheckUserModel> Function(CheckUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckUserProvider._internal(
        (ref) => create(ref as CheckUserRef),
        from: from,
        name: name,
        dependencies: dependencies,
        allTransitiveDependencies: allTransitiveDependencies,
        debugGetCreateSourceHash: debugGetCreateSourceHash,
        number: number,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CheckUserModel> createElement() {
    return _CheckUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckUserProvider && other.number == number;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckUserRef on AutoDisposeFutureProviderRef<CheckUserModel> {
  /// The parameter `number` of this provider.
  String get number;
}

class _CheckUserProviderElement
    extends AutoDisposeFutureProviderElement<CheckUserModel>
    with CheckUserRef {
  _CheckUserProviderElement(super.provider);

  @override
  String get number => (origin as CheckUserProvider).number;
}

// ---------------------------------------------------------------------------
// userRegister
// ---------------------------------------------------------------------------

String _$userRegisterHash() => r'a1b2c3d4e5f60718293a4b5c6d7e8f9012345678';

/// See also [userRegister].
@ProviderFor(userRegister)
const userRegisterProvider = UserRegisterFamily();

/// See also [userRegister].
class UserRegisterFamily extends Family<AsyncValue<UserRegisterResponseModel>> {
  /// See also [userRegister].
  const UserRegisterFamily();

  /// See also [userRegister].
  UserRegisterProvider call({
    required String number,
    required String userName,
    required String fcmToken,
    required int constitutionType,
  }) {
    return UserRegisterProvider(
      number: number,
      userName: userName,
      fcmToken: fcmToken,
      constitutionType: constitutionType,
    );
  }

  @override
  UserRegisterProvider getProviderOverride(
    covariant UserRegisterProvider provider,
  ) {
    return call(
      number: provider.number,
      userName: provider.userName,
      fcmToken: provider.fcmToken,
      constitutionType: provider.constitutionType,
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
  String? get name => r'userRegisterProvider';
}

/// See also [userRegister].
class UserRegisterProvider
    extends AutoDisposeFutureProvider<UserRegisterResponseModel> {
  /// See also [userRegister].
  UserRegisterProvider({
    required String number,
    required String userName,
    required String fcmToken,
    required int constitutionType,
  }) : this._internal(
          (ref) => userRegister(
            ref as UserRegisterRef,
            number: number,
            userName: userName,
            fcmToken: fcmToken,
            constitutionType: constitutionType,
          ),
          from: userRegisterProvider,
          name: r'userRegisterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userRegisterHash,
          dependencies: UserRegisterFamily._dependencies,
          allTransitiveDependencies:
              UserRegisterFamily._allTransitiveDependencies,
          number: number,
          userName: userName,
          fcmToken: fcmToken,
          constitutionType: constitutionType,
        );

  UserRegisterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
    required this.userName,
    required this.fcmToken,
    required this.constitutionType,
  }) : super.internal();

  final String number;
  final String userName;
  final String fcmToken;
  final int constitutionType;

  @override
  Override overrideWith(
    FutureOr<UserRegisterResponseModel> Function(UserRegisterRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserRegisterProvider._internal(
        (ref) => create(ref as UserRegisterRef),
        from: from,
        name: name,
        dependencies: dependencies,
        allTransitiveDependencies: allTransitiveDependencies,
        debugGetCreateSourceHash: debugGetCreateSourceHash,
        number: number,
        userName: userName,
        fcmToken: fcmToken,
        constitutionType: constitutionType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserRegisterResponseModel> createElement() {
    return _UserRegisterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserRegisterProvider &&
        other.number == number &&
        other.userName == userName &&
        other.fcmToken == fcmToken &&
        other.constitutionType == constitutionType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);
    hash = _SystemHash.combine(hash, userName.hashCode);
    hash = _SystemHash.combine(hash, fcmToken.hashCode);
    hash = _SystemHash.combine(hash, constitutionType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserRegisterRef
    on AutoDisposeFutureProviderRef<UserRegisterResponseModel> {
  /// The parameter `number` of this provider.
  String get number;

  /// The parameter `userName` of this provider.
  String get userName;

  /// The parameter `fcmToken` of this provider.
  String get fcmToken;

  /// The parameter `constitutionType` of this provider.
  int get constitutionType;
}

class _UserRegisterProviderElement
    extends AutoDisposeFutureProviderElement<UserRegisterResponseModel>
    with UserRegisterRef {
  _UserRegisterProviderElement(super.provider);

  @override
  String get number => (origin as UserRegisterProvider).number;
  @override
  String get userName => (origin as UserRegisterProvider).userName;
  @override
  String get fcmToken => (origin as UserRegisterProvider).fcmToken;
  @override
  int get constitutionType =>
      (origin as UserRegisterProvider).constitutionType;
}

// ---------------------------------------------------------------------------
// userSendOtp
// ---------------------------------------------------------------------------

String _$userSendOtpHash() => r'b2c3d4e5f60718293a4b5c6d7e8f901234567890';

/// See also [userSendOtp].
@ProviderFor(userSendOtp)
const userSendOtpProvider = UserSendOtpFamily();

/// See also [userSendOtp].
class UserSendOtpFamily extends Family<AsyncValue<UserSendOtpResponseModel>> {
  /// See also [userSendOtp].
  const UserSendOtpFamily();

  /// See also [userSendOtp].
  UserSendOtpProvider call({
    required String userId,
    required String fcmToken,
  }) {
    return UserSendOtpProvider(
      userId: userId,
      fcmToken: fcmToken,
    );
  }

  @override
  UserSendOtpProvider getProviderOverride(
    covariant UserSendOtpProvider provider,
  ) {
    return call(
      userId: provider.userId,
      fcmToken: provider.fcmToken,
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
  String? get name => r'userSendOtpProvider';
}

/// See also [userSendOtp].
class UserSendOtpProvider
    extends AutoDisposeFutureProvider<UserSendOtpResponseModel> {
  /// See also [userSendOtp].
  UserSendOtpProvider({
    required String userId,
    required String fcmToken,
  }) : this._internal(
          (ref) => userSendOtp(
            ref as UserSendOtpRef,
            userId: userId,
            fcmToken: fcmToken,
          ),
          from: userSendOtpProvider,
          name: r'userSendOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userSendOtpHash,
          dependencies: UserSendOtpFamily._dependencies,
          allTransitiveDependencies:
              UserSendOtpFamily._allTransitiveDependencies,
          userId: userId,
          fcmToken: fcmToken,
        );

  UserSendOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.fcmToken,
  }) : super.internal();

  final String userId;
  final String fcmToken;

  @override
  Override overrideWith(
    FutureOr<UserSendOtpResponseModel> Function(UserSendOtpRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserSendOtpProvider._internal(
        (ref) => create(ref as UserSendOtpRef),
        from: from,
        name: name,
        dependencies: dependencies,
        allTransitiveDependencies: allTransitiveDependencies,
        debugGetCreateSourceHash: debugGetCreateSourceHash,
        userId: userId,
        fcmToken: fcmToken,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserSendOtpResponseModel> createElement() {
    return _UserSendOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSendOtpProvider &&
        other.userId == userId &&
        other.fcmToken == fcmToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, fcmToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserSendOtpRef
    on AutoDisposeFutureProviderRef<UserSendOtpResponseModel> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `fcmToken` of this provider.
  String get fcmToken;
}

class _UserSendOtpProviderElement
    extends AutoDisposeFutureProviderElement<UserSendOtpResponseModel>
    with UserSendOtpRef {
  _UserSendOtpProviderElement(super.provider);

  @override
  String get userId => (origin as UserSendOtpProvider).userId;
  @override
  String get fcmToken => (origin as UserSendOtpProvider).fcmToken;
}

// ---------------------------------------------------------------------------
// userVerifyOtp
// ---------------------------------------------------------------------------

String _$userVerifyOtpHash() => r'c3d4e5f60718293a4b5c6d7e8f90123456789012';

/// See also [userVerifyOtp].
@ProviderFor(userVerifyOtp)
const userVerifyOtpProvider = UserVerifyOtpFamily();

/// See also [userVerifyOtp].
class UserVerifyOtpFamily extends Family<AsyncValue<AuthenticationModel>> {
  /// See also [userVerifyOtp].
  const UserVerifyOtpFamily();

  /// See also [userVerifyOtp].
  UserVerifyOtpProvider call({
    required String userId,
    required String otp,
    required String fcmToken,
  }) {
    return UserVerifyOtpProvider(
      userId: userId,
      otp: otp,
      fcmToken: fcmToken,
    );
  }

  @override
  UserVerifyOtpProvider getProviderOverride(
    covariant UserVerifyOtpProvider provider,
  ) {
    return call(
      userId: provider.userId,
      otp: provider.otp,
      fcmToken: provider.fcmToken,
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
  String? get name => r'userVerifyOtpProvider';
}

/// See also [userVerifyOtp].
class UserVerifyOtpProvider
    extends AutoDisposeFutureProvider<AuthenticationModel> {
  /// See also [userVerifyOtp].
  UserVerifyOtpProvider({
    required String userId,
    required String otp,
    required String fcmToken,
  }) : this._internal(
          (ref) => userVerifyOtp(
            ref as UserVerifyOtpRef,
            userId: userId,
            otp: otp,
            fcmToken: fcmToken,
          ),
          from: userVerifyOtpProvider,
          name: r'userVerifyOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userVerifyOtpHash,
          dependencies: UserVerifyOtpFamily._dependencies,
          allTransitiveDependencies:
              UserVerifyOtpFamily._allTransitiveDependencies,
          userId: userId,
          otp: otp,
          fcmToken: fcmToken,
        );

  UserVerifyOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.otp,
    required this.fcmToken,
  }) : super.internal();

  final String userId;
  final String otp;
  final String fcmToken;

  @override
  Override overrideWith(
    FutureOr<AuthenticationModel> Function(UserVerifyOtpRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserVerifyOtpProvider._internal(
        (ref) => create(ref as UserVerifyOtpRef),
        from: from,
        name: name,
        dependencies: dependencies,
        allTransitiveDependencies: allTransitiveDependencies,
        debugGetCreateSourceHash: debugGetCreateSourceHash,
        userId: userId,
        otp: otp,
        fcmToken: fcmToken,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AuthenticationModel> createElement() {
    return _UserVerifyOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserVerifyOtpProvider &&
        other.userId == userId &&
        other.otp == otp &&
        other.fcmToken == fcmToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, otp.hashCode);
    hash = _SystemHash.combine(hash, fcmToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserVerifyOtpRef
    on AutoDisposeFutureProviderRef<AuthenticationModel> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `otp` of this provider.
  String get otp;

  /// The parameter `fcmToken` of this provider.
  String get fcmToken;
}

class _UserVerifyOtpProviderElement
    extends AutoDisposeFutureProviderElement<AuthenticationModel>
    with UserVerifyOtpRef {
  _UserVerifyOtpProviderElement(super.provider);

  @override
  String get userId => (origin as UserVerifyOtpProvider).userId;
  @override
  String get otp => (origin as UserVerifyOtpProvider).otp;
  @override
  String get fcmToken => (origin as UserVerifyOtpProvider).fcmToken;
}

String _$userLogoutHash() => r'userLogoutHash';

/// See also [userLogout].
@ProviderFor(userLogout)
final userLogoutProvider = AutoDisposeFutureProvider<dynamic>.internal(
  userLogout,
  name: r'userLogoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userLogoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserLogoutRef = AutoDisposeFutureProviderRef<dynamic>;
