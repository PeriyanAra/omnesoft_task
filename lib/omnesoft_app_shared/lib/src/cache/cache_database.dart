import 'dart:async';
import 'dart:developer';

import 'package:omnesoft_task/omnesoft_app_shared/lib/src/cache/cache_abstraction.dart' as abs;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Sqflite-backed implementation of the cache database engine.
class SqfliteCacheDatabase implements abs.CacheDatabase {
  SqfliteCacheDatabase({
    required this.databaseName,
    required this.migrations,
    this.onConfigure,
  });

  final String databaseName;
  final List<abs.CacheMigration> migrations;
  final FutureOr<void> Function(Database db)? onConfigure;

  Database? _db;

  @override
  Future<void> init() async {
    await _getDatabase();
  }

  Future<Database> _getDatabase() async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  @override
  Future<void> execute(String sql) async {
    final db = await _getDatabase();
    await db.execute(sql);
  }

  @override
  Future<List<Map<String, Object?>>> query(
    String sql, {
    List<Object?> arguments = const [],
  }) async {
    final db = await _getDatabase();
    return db.rawQuery(sql, arguments);
  }

  @override
  Future<void> close() async {
    final current = _db;
    if (current != null && current.isOpen) {
      await current.close();
    }
    _db = null;
  }

  Future<Database> _open() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = p.join(directory.path, databaseName);

    log('[Cache] Sqflite DB path: $dbPath');

    return openDatabase(
      dbPath,
      version: migrations.length,
      onConfigure: (db) async {
        if (onConfigure != null) {
          await onConfigure!(db);
        }
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        for (var i = 0; i < migrations.length; i++) {
          await migrations[i](_SqfliteAdapter(db));
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var i = oldVersion; i < newVersion; i++) {
          await migrations[i](_SqfliteAdapter(db));
        }
      },
    );
  }
}

class _SqfliteAdapter implements abs.CacheDatabase {
  _SqfliteAdapter(this._db);

  final Database _db;

  @override
  Future<void> init() async {}

  @override
  Future<void> execute(String sql) => _db.execute(sql);

  @override
  Future<List<Map<String, Object?>>> query(
    String sql, {
    List<Object?> arguments = const [],
  }) =>
      _db.rawQuery(sql, arguments);

  @override
  Future<void> close() => _db.close();
}
