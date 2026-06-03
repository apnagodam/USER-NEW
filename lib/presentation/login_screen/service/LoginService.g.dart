// GENERATED CODE - DO NOT MODIFY BY HAND

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
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
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

String _$sendOtpV1Hash() => r'0f9dece28beac0b0fe6281e0995d4fc0ee1e4e58';

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
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
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

String _$verifyOtpHash() => r'7db05c654e57cb9152c8c969ce180cdb57760b21';

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
class VerifyOtpProvider extends AutoDisposeFutureProvider<AuthenticationModel> {
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
          allTransitiveDependencies: VerifyOtpFamily._allTransitiveDependencies,
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
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
