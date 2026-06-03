// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FreightPdf.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createFreightPdfHash() => r'13ea7aae3c31bb2ead06ae2bce6704802e04ef0c';

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

/// See also [createFreightPdf].
@ProviderFor(createFreightPdf)
const createFreightPdfProvider = CreateFreightPdfFamily();

/// See also [createFreightPdf].
class CreateFreightPdfFamily extends Family<AsyncValue<File?>> {
  /// See also [createFreightPdf].
  const CreateFreightPdfFamily();

  /// See also [createFreightPdf].
  CreateFreightPdfProvider call({
    required BuildContext context,
  }) {
    return CreateFreightPdfProvider(
      context: context,
    );
  }

  @override
  CreateFreightPdfProvider getProviderOverride(
    covariant CreateFreightPdfProvider provider,
  ) {
    return call(
      context: provider.context,
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
  String? get name => r'createFreightPdfProvider';
}

/// See also [createFreightPdf].
class CreateFreightPdfProvider extends AutoDisposeFutureProvider<File?> {
  /// See also [createFreightPdf].
  CreateFreightPdfProvider({
    required BuildContext context,
  }) : this._internal(
          (ref) => createFreightPdf(
            ref as CreateFreightPdfRef,
            context: context,
          ),
          from: createFreightPdfProvider,
          name: r'createFreightPdfProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createFreightPdfHash,
          dependencies: CreateFreightPdfFamily._dependencies,
          allTransitiveDependencies:
              CreateFreightPdfFamily._allTransitiveDependencies,
          context: context,
        );

  CreateFreightPdfProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  Override overrideWith(
    FutureOr<File?> Function(CreateFreightPdfRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateFreightPdfProvider._internal(
        (ref) => create(ref as CreateFreightPdfRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<File?> createElement() {
    return _CreateFreightPdfProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateFreightPdfProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateFreightPdfRef on AutoDisposeFutureProviderRef<File?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _CreateFreightPdfProviderElement
    extends AutoDisposeFutureProviderElement<File?> with CreateFreightPdfRef {
  _CreateFreightPdfProviderElement(super.provider);

  @override
  BuildContext get context => (origin as CreateFreightPdfProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
