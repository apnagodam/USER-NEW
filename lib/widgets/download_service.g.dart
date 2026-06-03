// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$downloadFileBGHash() => r'0f5fba3a6ef0ac2fde914062572553a38edcea63';

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

/// See also [downloadFileBG].
@ProviderFor(downloadFileBG)
const downloadFileBGProvider = DownloadFileBGFamily();

/// See also [downloadFileBG].
class DownloadFileBGFamily extends Family<AsyncValue<File?>> {
  /// See also [downloadFileBG].
  const DownloadFileBGFamily();

  /// See also [downloadFileBG].
  DownloadFileBGProvider call({
    required String? fileName,
    required String? url,
  }) {
    return DownloadFileBGProvider(
      fileName: fileName,
      url: url,
    );
  }

  @override
  DownloadFileBGProvider getProviderOverride(
    covariant DownloadFileBGProvider provider,
  ) {
    return call(
      fileName: provider.fileName,
      url: provider.url,
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
  String? get name => r'downloadFileBGProvider';
}

/// See also [downloadFileBG].
class DownloadFileBGProvider extends AutoDisposeFutureProvider<File?> {
  /// See also [downloadFileBG].
  DownloadFileBGProvider({
    required String? fileName,
    required String? url,
  }) : this._internal(
          (ref) => downloadFileBG(
            ref as DownloadFileBGRef,
            fileName: fileName,
            url: url,
          ),
          from: downloadFileBGProvider,
          name: r'downloadFileBGProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$downloadFileBGHash,
          dependencies: DownloadFileBGFamily._dependencies,
          allTransitiveDependencies:
              DownloadFileBGFamily._allTransitiveDependencies,
          fileName: fileName,
          url: url,
        );

  DownloadFileBGProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fileName,
    required this.url,
  }) : super.internal();

  final String? fileName;
  final String? url;

  @override
  Override overrideWith(
    FutureOr<File?> Function(DownloadFileBGRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DownloadFileBGProvider._internal(
        (ref) => create(ref as DownloadFileBGRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fileName: fileName,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<File?> createElement() {
    return _DownloadFileBGProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DownloadFileBGProvider &&
        other.fileName == fileName &&
        other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fileName.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DownloadFileBGRef on AutoDisposeFutureProviderRef<File?> {
  /// The parameter `fileName` of this provider.
  String? get fileName;

  /// The parameter `url` of this provider.
  String? get url;
}

class _DownloadFileBGProviderElement
    extends AutoDisposeFutureProviderElement<File?> with DownloadFileBGRef {
  _DownloadFileBGProviderElement(super.provider);

  @override
  String? get fileName => (origin as DownloadFileBGProvider).fileName;
  @override
  String? get url => (origin as DownloadFileBGProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
