import 'package:omnesoft_task/infrastructure/cache/tables/vendors_table.sql.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';

class ProjectCacheDependencies extends PackageDependencies {
  @override
  Future<void> register(DI di) async {
    final migrations = <CacheMigration>[
      (CacheDatabase db) async {
        await db.execute(createVendorsTableSql);
      },
    ];

    final cacheDb = SqfliteCacheDatabase(
      databaseName: 'omnesoft_task_cache.db',
      migrations: migrations,
    );

    await cacheDb.init();

    di.registerLazySingleton<CacheDatabase>(() => cacheDb);
  }
}
