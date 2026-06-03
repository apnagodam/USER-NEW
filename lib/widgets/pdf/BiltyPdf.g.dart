// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BiltyPdf.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createBiltyPdfHash() => r'e7cb8149e030bb407e7a72c3687a7312d8e68906';

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

/// See also [createBiltyPdf].
@ProviderFor(createBiltyPdf)
const createBiltyPdfProvider = CreateBiltyPdfFamily();

/// See also [createBiltyPdf].
class CreateBiltyPdfFamily extends Family<AsyncValue<File?>> {
  /// See also [createBiltyPdf].
  const CreateBiltyPdfFamily();

  /// See also [createBiltyPdf].
  CreateBiltyPdfProvider call({
    required BuildContext context,
    required BiltyResponseData model,
  }) {
    return CreateBiltyPdfProvider(
      context: context,
      model: model,
    );
  }

  @override
  CreateBiltyPdfProvider getProviderOverride(
    covariant CreateBiltyPdfProvider provider,
  ) {
    return call(
      context: provider.context,
      model: provider.model,
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
  String? get name => r'createBiltyPdfProvider';
}

/// See also [createBiltyPdf].
class CreateBiltyPdfProvider extends AutoDisposeFutureProvider<File?> {
  /// See also [createBiltyPdf].
  CreateBiltyPdfProvider({
    required BuildContext context,
    required BiltyResponseData model,
  }) : this._internal(
          (ref) => createBiltyPdf(
            ref as CreateBiltyPdfRef,
            context: context,
            model: model,
          ),
          from: createBiltyPdfProvider,
          name: r'createBiltyPdfProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createBiltyPdfHash,
          dependencies: CreateBiltyPdfFamily._dependencies,
          allTransitiveDependencies:
              CreateBiltyPdfFamily._allTransitiveDependencies,
          context: context,
          model: model,
        );

  CreateBiltyPdfProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.model,
  }) : super.internal();

  final BuildContext context;
  final BiltyResponseData model;

  @override
  Override overrideWith(
    FutureOr<File?> Function(CreateBiltyPdfRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateBiltyPdfProvider._internal(
        (ref) => create(ref as CreateBiltyPdfRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        model: model,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<File?> createElement() {
    return _CreateBiltyPdfProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateBiltyPdfProvider &&
        other.context == context &&
        other.model == model;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateBiltyPdfRef on AutoDisposeFutureProviderRef<File?> {
  /// The parameter `context` of this provider.
  BuildContext get context;

  /// The parameter `model` of this provider.
  BiltyResponseData get model;
}

class _CreateBiltyPdfProviderElement
    extends AutoDisposeFutureProviderElement<File?> with CreateBiltyPdfRef {
  _CreateBiltyPdfProviderElement(super.provider);

  @override
  BuildContext get context => (origin as CreateBiltyPdfProvider).context;
  @override
  BiltyResponseData get model => (origin as CreateBiltyPdfProvider).model;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
