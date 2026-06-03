// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPdfDataHash() => r'fa3c4f2e52938d9930556908b59d2b3aca0a5104';

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

/// See also [getPdfData].
@ProviderFor(getPdfData)
const getPdfDataProvider = GetPdfDataFamily();

/// See also [getPdfData].
class GetPdfDataFamily extends Family<AsyncValue<PdfResponseModel>> {
  /// See also [getPdfData].
  const GetPdfDataFamily();

  /// See also [getPdfData].
  GetPdfDataProvider call({
    String? invId,
  }) {
    return GetPdfDataProvider(
      invId: invId,
    );
  }

  @override
  GetPdfDataProvider getProviderOverride(
    covariant GetPdfDataProvider provider,
  ) {
    return call(
      invId: provider.invId,
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
  String? get name => r'getPdfDataProvider';
}

/// See also [getPdfData].
class GetPdfDataProvider extends AutoDisposeFutureProvider<PdfResponseModel> {
  /// See also [getPdfData].
  GetPdfDataProvider({
    String? invId,
  }) : this._internal(
          (ref) => getPdfData(
            ref as GetPdfDataRef,
            invId: invId,
          ),
          from: getPdfDataProvider,
          name: r'getPdfDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPdfDataHash,
          dependencies: GetPdfDataFamily._dependencies,
          allTransitiveDependencies:
              GetPdfDataFamily._allTransitiveDependencies,
          invId: invId,
        );

  GetPdfDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.invId,
  }) : super.internal();

  final String? invId;

  @override
  Override overrideWith(
    FutureOr<PdfResponseModel> Function(GetPdfDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPdfDataProvider._internal(
        (ref) => create(ref as GetPdfDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        invId: invId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PdfResponseModel> createElement() {
    return _GetPdfDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPdfDataProvider && other.invId == invId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, invId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetPdfDataRef on AutoDisposeFutureProviderRef<PdfResponseModel> {
  /// The parameter `invId` of this provider.
  String? get invId;
}

class _GetPdfDataProviderElement
    extends AutoDisposeFutureProviderElement<PdfResponseModel>
    with GetPdfDataRef {
  _GetPdfDataProviderElement(super.provider);

  @override
  String? get invId => (origin as GetPdfDataProvider).invId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
