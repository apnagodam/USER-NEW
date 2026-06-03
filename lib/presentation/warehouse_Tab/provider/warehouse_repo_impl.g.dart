// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_repo_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getinwardsSummaryHash() => r'fb3ba9a7f435910b29fe2bd3bb0b2fbdc6676701';

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

/// See also [getinwardsSummary].
@ProviderFor(getinwardsSummary)
const getinwardsSummaryProvider = GetinwardsSummaryFamily();

/// See also [getinwardsSummary].
class GetinwardsSummaryFamily extends Family<AsyncValue<InwardsSummaryModel>> {
  /// See also [getinwardsSummary].
  const GetinwardsSummaryFamily();

  /// See also [getinwardsSummary].
  GetinwardsSummaryProvider call({
    String search = '',
    int page = 0,
    int limit = 30,
  }) {
    return GetinwardsSummaryProvider(
      search: search,
      page: page,
      limit: limit,
    );
  }

  @override
  GetinwardsSummaryProvider getProviderOverride(
    covariant GetinwardsSummaryProvider provider,
  ) {
    return call(
      search: provider.search,
      page: provider.page,
      limit: provider.limit,
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
  String? get name => r'getinwardsSummaryProvider';
}

/// See also [getinwardsSummary].
class GetinwardsSummaryProvider
    extends AutoDisposeFutureProvider<InwardsSummaryModel> {
  /// See also [getinwardsSummary].
  GetinwardsSummaryProvider({
    String search = '',
    int page = 0,
    int limit = 30,
  }) : this._internal(
          (ref) => getinwardsSummary(
            ref as GetinwardsSummaryRef,
            search: search,
            page: page,
            limit: limit,
          ),
          from: getinwardsSummaryProvider,
          name: r'getinwardsSummaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getinwardsSummaryHash,
          dependencies: GetinwardsSummaryFamily._dependencies,
          allTransitiveDependencies:
              GetinwardsSummaryFamily._allTransitiveDependencies,
          search: search,
          page: page,
          limit: limit,
        );

  GetinwardsSummaryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.search,
    required this.page,
    required this.limit,
  }) : super.internal();

  final String search;
  final int page;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<InwardsSummaryModel> Function(GetinwardsSummaryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetinwardsSummaryProvider._internal(
        (ref) => create(ref as GetinwardsSummaryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        search: search,
        page: page,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<InwardsSummaryModel> createElement() {
    return _GetinwardsSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetinwardsSummaryProvider &&
        other.search == search &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetinwardsSummaryRef
    on AutoDisposeFutureProviderRef<InwardsSummaryModel> {
  /// The parameter `search` of this provider.
  String get search;

  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _GetinwardsSummaryProviderElement
    extends AutoDisposeFutureProviderElement<InwardsSummaryModel>
    with GetinwardsSummaryRef {
  _GetinwardsSummaryProviderElement(super.provider);

  @override
  String get search => (origin as GetinwardsSummaryProvider).search;
  @override
  int get page => (origin as GetinwardsSummaryProvider).page;
  @override
  int get limit => (origin as GetinwardsSummaryProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
