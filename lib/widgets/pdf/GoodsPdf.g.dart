// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoodsPdf.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createGoodsTaxInvoiceHash() =>
    r'7ed07454224c863714abe4913166fa7eb04a2c3c';

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

/// See also [createGoodsTaxInvoice].
@ProviderFor(createGoodsTaxInvoice)
const createGoodsTaxInvoiceProvider = CreateGoodsTaxInvoiceFamily();

/// See also [createGoodsTaxInvoice].
class CreateGoodsTaxInvoiceFamily extends Family<AsyncValue<File?>> {
  /// See also [createGoodsTaxInvoice].
  const CreateGoodsTaxInvoiceFamily();

  /// See also [createGoodsTaxInvoice].
  CreateGoodsTaxInvoiceProvider call({
    required BuildContext context,
  }) {
    return CreateGoodsTaxInvoiceProvider(
      context: context,
    );
  }

  @override
  CreateGoodsTaxInvoiceProvider getProviderOverride(
    covariant CreateGoodsTaxInvoiceProvider provider,
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
  String? get name => r'createGoodsTaxInvoiceProvider';
}

/// See also [createGoodsTaxInvoice].
class CreateGoodsTaxInvoiceProvider extends AutoDisposeFutureProvider<File?> {
  /// See also [createGoodsTaxInvoice].
  CreateGoodsTaxInvoiceProvider({
    required BuildContext context,
  }) : this._internal(
          (ref) => createGoodsTaxInvoice(
            ref as CreateGoodsTaxInvoiceRef,
            context: context,
          ),
          from: createGoodsTaxInvoiceProvider,
          name: r'createGoodsTaxInvoiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createGoodsTaxInvoiceHash,
          dependencies: CreateGoodsTaxInvoiceFamily._dependencies,
          allTransitiveDependencies:
              CreateGoodsTaxInvoiceFamily._allTransitiveDependencies,
          context: context,
        );

  CreateGoodsTaxInvoiceProvider._internal(
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
    FutureOr<File?> Function(CreateGoodsTaxInvoiceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateGoodsTaxInvoiceProvider._internal(
        (ref) => create(ref as CreateGoodsTaxInvoiceRef),
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
    return _CreateGoodsTaxInvoiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateGoodsTaxInvoiceProvider && other.context == context;
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
mixin CreateGoodsTaxInvoiceRef on AutoDisposeFutureProviderRef<File?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _CreateGoodsTaxInvoiceProviderElement
    extends AutoDisposeFutureProviderElement<File?>
    with CreateGoodsTaxInvoiceRef {
  _CreateGoodsTaxInvoiceProviderElement(super.provider);

  @override
  BuildContext get context => (origin as CreateGoodsTaxInvoiceProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
