/// Abstraction for cache database engines. Implementations can be backed by
/// different storage engines (e.g., Sqflite, Isar, Hive, etc.).
abstract class CacheDatabase {
  /// Ensures the underlying database is opened and ready.
  ///
  /// Implementations should use this to trigger any startup logic such as
  /// establishing connections and running pending migrations.
  Future<void> init();

  Future<void> execute(String sql);

  /// Executes a read-only SQL query and returns rows.
  Future<List<Map<String, Object?>>> query(
    String sql, {
    List<Object?> arguments = const [],
  });

  Future<void> close();
}

/// Migration function receives the abstract database interface rather than a
/// concrete engine, keeping migrations reusable across engines.
typedef CacheMigration = Future<void> Function(CacheDatabase db);
