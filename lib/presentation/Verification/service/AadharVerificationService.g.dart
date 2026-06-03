// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AadharVerificationService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sendAadharVerificationOtpHash() =>
    r'c66fd1ba7ab6a6d2e0ca3c5c98144d0f7290153f';

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

/// See also [sendAadharVerificationOtp].
@ProviderFor(sendAadharVerificationOtp)
const sendAadharVerificationOtpProvider = SendAadharVerificationOtpFamily();

/// See also [sendAadharVerificationOtp].
class SendAadharVerificationOtpFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [sendAadharVerificationOtp].
  const SendAadharVerificationOtpFamily();

  /// See also [sendAadharVerificationOtp].
  SendAadharVerificationOtpProvider call({
    required String aadharNo,
  }) {
    return SendAadharVerificationOtpProvider(
      aadharNo: aadharNo,
    );
  }

  @override
  SendAadharVerificationOtpProvider getProviderOverride(
    covariant SendAadharVerificationOtpProvider provider,
  ) {
    return call(
      aadharNo: provider.aadharNo,
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
  String? get name => r'sendAadharVerificationOtpProvider';
}

/// See also [sendAadharVerificationOtp].
class SendAadharVerificationOtpProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [sendAadharVerificationOtp].
  SendAadharVerificationOtpProvider({
    required String aadharNo,
  }) : this._internal(
          (ref) => sendAadharVerificationOtp(
            ref as SendAadharVerificationOtpRef,
            aadharNo: aadharNo,
          ),
          from: sendAadharVerificationOtpProvider,
          name: r'sendAadharVerificationOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendAadharVerificationOtpHash,
          dependencies: SendAadharVerificationOtpFamily._dependencies,
          allTransitiveDependencies:
              SendAadharVerificationOtpFamily._allTransitiveDependencies,
          aadharNo: aadharNo,
        );

  SendAadharVerificationOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.aadharNo,
  }) : super.internal();

  final String aadharNo;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(
            SendAadharVerificationOtpRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendAadharVerificationOtpProvider._internal(
        (ref) => create(ref as SendAadharVerificationOtpRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        aadharNo: aadharNo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SendAadharVerificationOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendAadharVerificationOtpProvider &&
        other.aadharNo == aadharNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, aadharNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SendAadharVerificationOtpRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `aadharNo` of this provider.
  String get aadharNo;
}

class _SendAadharVerificationOtpProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SendAadharVerificationOtpRef {
  _SendAadharVerificationOtpProviderElement(super.provider);

  @override
  String get aadharNo => (origin as SendAadharVerificationOtpProvider).aadharNo;
}

String _$verifyAadharVerificationOtpHash() =>
    r'ddf32d68d15cffc5f293bec5c08cff0d1d57b031';

/// See also [verifyAadharVerificationOtp].
@ProviderFor(verifyAadharVerificationOtp)
const verifyAadharVerificationOtpProvider = VerifyAadharVerificationOtpFamily();

/// See also [verifyAadharVerificationOtp].
class VerifyAadharVerificationOtpFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [verifyAadharVerificationOtp].
  const VerifyAadharVerificationOtpFamily();

  /// See also [verifyAadharVerificationOtp].
  VerifyAadharVerificationOtpProvider call({
    required String aadharNo,
    required String requestId,
    required String otp,
  }) {
    return VerifyAadharVerificationOtpProvider(
      aadharNo: aadharNo,
      requestId: requestId,
      otp: otp,
    );
  }

  @override
  VerifyAadharVerificationOtpProvider getProviderOverride(
    covariant VerifyAadharVerificationOtpProvider provider,
  ) {
    return call(
      aadharNo: provider.aadharNo,
      requestId: provider.requestId,
      otp: provider.otp,
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
  String? get name => r'verifyAadharVerificationOtpProvider';
}

/// See also [verifyAadharVerificationOtp].
class VerifyAadharVerificationOtpProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [verifyAadharVerificationOtp].
  VerifyAadharVerificationOtpProvider({
    required String aadharNo,
    required String requestId,
    required String otp,
  }) : this._internal(
          (ref) => verifyAadharVerificationOtp(
            ref as VerifyAadharVerificationOtpRef,
            aadharNo: aadharNo,
            requestId: requestId,
            otp: otp,
          ),
          from: verifyAadharVerificationOtpProvider,
          name: r'verifyAadharVerificationOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$verifyAadharVerificationOtpHash,
          dependencies: VerifyAadharVerificationOtpFamily._dependencies,
          allTransitiveDependencies:
              VerifyAadharVerificationOtpFamily._allTransitiveDependencies,
          aadharNo: aadharNo,
          requestId: requestId,
          otp: otp,
        );

  VerifyAadharVerificationOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.aadharNo,
    required this.requestId,
    required this.otp,
  }) : super.internal();

  final String aadharNo;
  final String requestId;
  final String otp;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(
            VerifyAadharVerificationOtpRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VerifyAadharVerificationOtpProvider._internal(
        (ref) => create(ref as VerifyAadharVerificationOtpRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        aadharNo: aadharNo,
        requestId: requestId,
        otp: otp,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _VerifyAadharVerificationOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VerifyAadharVerificationOtpProvider &&
        other.aadharNo == aadharNo &&
        other.requestId == requestId &&
        other.otp == otp;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, aadharNo.hashCode);
    hash = _SystemHash.combine(hash, requestId.hashCode);
    hash = _SystemHash.combine(hash, otp.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VerifyAadharVerificationOtpRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `aadharNo` of this provider.
  String get aadharNo;

  /// The parameter `requestId` of this provider.
  String get requestId;

  /// The parameter `otp` of this provider.
  String get otp;
}

class _VerifyAadharVerificationOtpProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with VerifyAadharVerificationOtpRef {
  _VerifyAadharVerificationOtpProviderElement(super.provider);

  @override
  String get aadharNo =>
      (origin as VerifyAadharVerificationOtpProvider).aadharNo;
  @override
  String get requestId =>
      (origin as VerifyAadharVerificationOtpProvider).requestId;
  @override
  String get otp => (origin as VerifyAadharVerificationOtpProvider).otp;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
