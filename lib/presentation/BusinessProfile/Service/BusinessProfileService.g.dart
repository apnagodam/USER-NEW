// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BusinessProfileService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$businessProfilesHash() => r'7c26a9c4a897c74e1aebb505b89f32aa5bb8206f';

/// See also [businessProfiles].
@ProviderFor(businessProfiles)
final businessProfilesProvider =
    AutoDisposeStreamProvider<BusinessLIstingModel>.internal(
  businessProfiles,
  name: r'businessProfilesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$businessProfilesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BusinessProfilesRef
    = AutoDisposeStreamProviderRef<BusinessLIstingModel>;
String _$addBusinessProfileHash() =>
    r'cc967e04d1f1dcb97f33c4e1e52b6539d0abc2d7';

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

/// See also [addBusinessProfile].
@ProviderFor(addBusinessProfile)
const addBusinessProfileProvider = AddBusinessProfileFamily();

/// See also [addBusinessProfile].
class AddBusinessProfileFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [addBusinessProfile].
  const AddBusinessProfileFamily();

  /// See also [addBusinessProfile].
  AddBusinessProfileProvider call({
    required Map<String, dynamic> data,
  }) {
    return AddBusinessProfileProvider(
      data: data,
    );
  }

  @override
  AddBusinessProfileProvider getProviderOverride(
    covariant AddBusinessProfileProvider provider,
  ) {
    return call(
      data: provider.data,
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
  String? get name => r'addBusinessProfileProvider';
}

/// See also [addBusinessProfile].
class AddBusinessProfileProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [addBusinessProfile].
  AddBusinessProfileProvider({
    required Map<String, dynamic> data,
  }) : this._internal(
          (ref) => addBusinessProfile(
            ref as AddBusinessProfileRef,
            data: data,
          ),
          from: addBusinessProfileProvider,
          name: r'addBusinessProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addBusinessProfileHash,
          dependencies: AddBusinessProfileFamily._dependencies,
          allTransitiveDependencies:
              AddBusinessProfileFamily._allTransitiveDependencies,
          data: data,
        );

  AddBusinessProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.data,
  }) : super.internal();

  final Map<String, dynamic> data;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(AddBusinessProfileRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddBusinessProfileProvider._internal(
        (ref) => create(ref as AddBusinessProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        data: data,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _AddBusinessProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddBusinessProfileProvider && other.data == data;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddBusinessProfileRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `data` of this provider.
  Map<String, dynamic> get data;
}

class _AddBusinessProfileProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with AddBusinessProfileRef {
  _AddBusinessProfileProviderElement(super.provider);

  @override
  Map<String, dynamic> get data => (origin as AddBusinessProfileProvider).data;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
