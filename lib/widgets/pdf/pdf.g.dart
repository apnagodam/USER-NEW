// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$downloadFileHash() => r'5b30b0f9bf1f65f4f019756d255d437df48c5abe';

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

/// See also [downloadFile].
@ProviderFor(downloadFile)
const downloadFileProvider = DownloadFileFamily();

/// See also [downloadFile].
class DownloadFileFamily extends Family<AsyncValue<File?>> {
  /// See also [downloadFile].
  const DownloadFileFamily();

  /// See also [downloadFile].
  DownloadFileProvider call({
    required String? fileName,
    required String? url,
  }) {
    return DownloadFileProvider(
      fileName: fileName,
      url: url,
    );
  }

  @override
  DownloadFileProvider getProviderOverride(
    covariant DownloadFileProvider provider,
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
  String? get name => r'downloadFileProvider';
}

/// See also [downloadFile].
class DownloadFileProvider extends AutoDisposeFutureProvider<File?> {
  /// See also [downloadFile].
  DownloadFileProvider({
    required String? fileName,
    required String? url,
  }) : this._internal(
          (ref) => downloadFile(
            ref as DownloadFileRef,
            fileName: fileName,
            url: url,
          ),
          from: downloadFileProvider,
          name: r'downloadFileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$downloadFileHash,
          dependencies: DownloadFileFamily._dependencies,
          allTransitiveDependencies:
              DownloadFileFamily._allTransitiveDependencies,
          fileName: fileName,
          url: url,
        );

  DownloadFileProvider._internal(
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
    FutureOr<File?> Function(DownloadFileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DownloadFileProvider._internal(
        (ref) => create(ref as DownloadFileRef),
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
    return _DownloadFileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DownloadFileProvider &&
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
mixin DownloadFileRef on AutoDisposeFutureProviderRef<File?> {
  /// The parameter `fileName` of this provider.
  String? get fileName;

  /// The parameter `url` of this provider.
  String? get url;
}

class _DownloadFileProviderElement
    extends AutoDisposeFutureProviderElement<File?> with DownloadFileRef {
  _DownloadFileProviderElement(super.provider);

  @override
  String? get fileName => (origin as DownloadFileProvider).fileName;
  @override
  String? get url => (origin as DownloadFileProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
