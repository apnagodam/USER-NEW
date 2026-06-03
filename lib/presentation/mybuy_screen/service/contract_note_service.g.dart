// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_note_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contractNotesHash() => r'c152cab36ef2d8f152ae97463279b8730ded3778';

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

/// See also [contractNotes].
@ProviderFor(contractNotes)
const contractNotesProvider = ContractNotesFamily();

/// See also [contractNotes].
class ContractNotesFamily extends Family<AsyncValue<ContractNoteModel>> {
  /// See also [contractNotes].
  const ContractNotesFamily();

  /// See also [contractNotes].
  ContractNotesProvider call({
    String? dealId = '',
  }) {
    return ContractNotesProvider(
      dealId: dealId,
    );
  }

  @override
  ContractNotesProvider getProviderOverride(
    covariant ContractNotesProvider provider,
  ) {
    return call(
      dealId: provider.dealId,
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
  String? get name => r'contractNotesProvider';
}

/// See also [contractNotes].
class ContractNotesProvider
    extends AutoDisposeFutureProvider<ContractNoteModel> {
  /// See also [contractNotes].
  ContractNotesProvider({
    String? dealId = '',
  }) : this._internal(
          (ref) => contractNotes(
            ref as ContractNotesRef,
            dealId: dealId,
          ),
          from: contractNotesProvider,
          name: r'contractNotesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$contractNotesHash,
          dependencies: ContractNotesFamily._dependencies,
          allTransitiveDependencies:
              ContractNotesFamily._allTransitiveDependencies,
          dealId: dealId,
        );

  ContractNotesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dealId,
  }) : super.internal();

  final String? dealId;

  @override
  Override overrideWith(
    FutureOr<ContractNoteModel> Function(ContractNotesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ContractNotesProvider._internal(
        (ref) => create(ref as ContractNotesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dealId: dealId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ContractNoteModel> createElement() {
    return _ContractNotesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ContractNotesProvider && other.dealId == dealId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dealId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ContractNotesRef on AutoDisposeFutureProviderRef<ContractNoteModel> {
  /// The parameter `dealId` of this provider.
  String? get dealId;
}

class _ContractNotesProviderElement
    extends AutoDisposeFutureProviderElement<ContractNoteModel>
    with ContractNotesRef {
  _ContractNotesProviderElement(super.provider);

  @override
  String? get dealId => (origin as ContractNotesProvider).dealId;
}

String _$stackContractNoteHash() => r'91fe322a2a8418de5cfe9c8a0fa55483080e19c6';

/// See also [stackContractNote].
@ProviderFor(stackContractNote)
const stackContractNoteProvider = StackContractNoteFamily();

/// See also [stackContractNote].
class StackContractNoteFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [stackContractNote].
  const StackContractNoteFamily();

  /// See also [stackContractNote].
  StackContractNoteProvider call({
    required String id,
  }) {
    return StackContractNoteProvider(
      id: id,
    );
  }

  @override
  StackContractNoteProvider getProviderOverride(
    covariant StackContractNoteProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'stackContractNoteProvider';
}

/// See also [stackContractNote].
class StackContractNoteProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [stackContractNote].
  StackContractNoteProvider({
    required String id,
  }) : this._internal(
          (ref) => stackContractNote(
            ref as StackContractNoteRef,
            id: id,
          ),
          from: stackContractNoteProvider,
          name: r'stackContractNoteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stackContractNoteHash,
          dependencies: StackContractNoteFamily._dependencies,
          allTransitiveDependencies:
              StackContractNoteFamily._allTransitiveDependencies,
          id: id,
        );

  StackContractNoteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(StackContractNoteRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StackContractNoteProvider._internal(
        (ref) => create(ref as StackContractNoteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _StackContractNoteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StackContractNoteProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StackContractNoteRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _StackContractNoteProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with StackContractNoteRef {
  _StackContractNoteProviderElement(super.provider);

  @override
  String get id => (origin as StackContractNoteProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
