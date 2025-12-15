import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:omnesoft_task/data/vendor/data_sources/vendor_local_data_source.dart';
import 'package:omnesoft_task/data/vendor/data_sources/vendor_remote_data_source.dart';
import 'package:omnesoft_task/data/vendor/services/mock_vendor_api_service.dart';
import 'package:omnesoft_task/data/vendor/services/vendor_local_service.dart';
import 'package:omnesoft_task/domain/vendor/vendor_entity.dart';
import 'package:omnesoft_task/domain/vendor/vendor_repository.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';
import 'package:omnesoft_task/presentation/home/cubit/home_cubit.dart';

final class _NoopCacheDatabase implements CacheDatabase {
  @override
  Future<void> init() async {}

  @override
  Future<void> execute(String sql) async {}

  @override
  Future<List<Map<String, Object?>>> query(
    String sql, {
    List<Object?> arguments = const [],
  }) async {
    return <Map<String, Object?>>[];
  }

  @override
  Future<void> close() async {}
}

final class _FakeVendorRepository extends VendorRepository {
  _FakeVendorRepository(
    Iterable<Result<List<VendorEntity>, Exception>> responses,
  ) : _responses = Queue<Result<List<VendorEntity>, Exception>>.from(responses),
      super(
        vendorRemoteDataSource: VendorRemoteDataSource(
          mockVendorApiService: MockVendorApiService(),
        ),
        vendorLocalDataSource: VendorLocalDataSource(
          vendorLocalService: VendorLocalService(
            cacheDatabase: _NoopCacheDatabase(),
          ),
        ),
      );

  final Queue<Result<List<VendorEntity>, Exception>> _responses;

  @override
  Future<Result<List<VendorEntity>, Exception>> fetchVendors({
    int limit = 10,
  }) async {
    if (_responses.isEmpty) {
      throw StateError('No fake responses left for fetchVendors()');
    }

    return _responses.removeFirst();
  }
}

List<VendorEntity> _entities(List<String> names) {
  return List.generate(names.length, (index) {
    final id = index + 1;
    return VendorEntity(
      vendorId: id,
      name: names[index],
      location: 'City $id',
      rating: 4.5,
      category: 'Category $id',
      image: 'https://picsum.photos/seed/$id/500/500',
    );
  });
}

Future<List<HomeState>> _recordStates(
  HomeCubit cubit,
  Future<void> Function() action,
) async {
  final states = <HomeState>[];

  final subscription = cubit.stream.listen(states.add);

  await action();             
  await Future<void>.delayed(Duration.zero);

  await subscription.cancel();
  return states;
}

void main() {
  test('loadVendors emits HomeLoading then HomeLoaded on success', () async {
    final repo = _FakeVendorRepository([
      Result.success(_entities(['A', 'B'])),
    ]);
    final cubit = HomeCubit(vendorRepository: repo);
    addTearDown(cubit.close);

    final states = await _recordStates(cubit, cubit.loadVendors);
    expect(states, hasLength(2));
    expect(states.first, isA<HomeLoading>());
    expect(states.last, isA<HomeLoaded>());
    expect((states.last as HomeLoaded).vendors, hasLength(2));
    expect((states.last as HomeLoaded).vendors.first.name, 'A');
  });

  test('loadVendors emits HomeLoading then HomeError on failure', () async {
    final repo = _FakeVendorRepository([Result.failure(Exception('boom'))]);
    final cubit = HomeCubit(vendorRepository: repo);
    addTearDown(cubit.close);

    final states = await _recordStates(cubit, cubit.loadVendors);

    expect(states, hasLength(2));
    expect(states.first, isA<HomeLoading>());
    expect(states.last, isA<HomeError>());
  });

  test('searchVendors emits filtered HomeLoaded (case-insensitive)', () async {
    final repo = _FakeVendorRepository([
      Result.success(_entities(['Acme', 'Beta', 'acorn'])),
    ]);
    final cubit = HomeCubit(vendorRepository: repo);
    addTearDown(cubit.close);

    await cubit.loadVendors();

    final states = await _recordStates(cubit, () async {
      cubit.searchVendors('AC');
    });

    expect(states, hasLength(1));
    final loaded = states.single as HomeLoaded;
    expect(loaded.isSearching, isTrue);
    expect(loaded.vendors.map((v) => v.name), ['Acme', 'acorn']);
  });

  test('cancelSearching restores HomeLoaded with all vendors', () async {
    final repo = _FakeVendorRepository([
      Result.success(_entities(['Acme', 'Beta'])),
    ]);
    final cubit = HomeCubit(vendorRepository: repo);
    addTearDown(cubit.close);

    await cubit.loadVendors();
    cubit.searchVendors('Acme');

    final states = await _recordStates(cubit, () async {
      cubit.cancelSearching();
    });

    expect(states, hasLength(1));
    final loaded = states.single as HomeLoaded;
    expect(loaded.isSearching, isFalse);
    expect(loaded.vendors.map((v) => v.name), ['Acme', 'Beta']);
  });

  test(
    'loadVendors preserves existing searchQuery and filters new data',
    () async {
      final repo = _FakeVendorRepository([
        Result.success(_entities(['Acme', 'Beta'])),
        Result.success(_entities(['Acme Two', 'Gamma'])),
      ]);
      final cubit = HomeCubit(vendorRepository: repo);
      addTearDown(cubit.close);

      await cubit.loadVendors();
      cubit.searchVendors('acme');

      final states = await _recordStates(cubit, cubit.loadVendors);

      expect(states, hasLength(1));
      final loaded = states.single as HomeLoaded;
      expect(loaded.isSearching, isTrue);
      expect(loaded.vendors.map((v) => v.name), ['Acme Two']);
    },
  );

  test(
    'loadAdditionalVendors appends vendors and emits updated HomeLoaded',
    () async {
      final repo = _FakeVendorRepository([
        Result.success(_entities(['A', 'B'])),
        Result.success(_entities(['C'])),
      ]);
      final cubit = HomeCubit(vendorRepository: repo);
      addTearDown(cubit.close);

      await cubit.loadVendors();

      final states = await _recordStates(cubit, cubit.loadAdditionalVendors);

      expect(states, hasLength(1));
      expect(states.single, isA<HomeLoaded>());
      expect((states.single as HomeLoaded).vendors.map((v) => v.name), [
        'A',
        'B',
        'C',
      ]);
    },
  );
}
