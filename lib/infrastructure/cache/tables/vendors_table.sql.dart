import 'package:omnesoft_task/data/database_constants.dart';

const String createVendorsTableSql = '''
CREATE TABLE IF NOT EXISTS ${DatabaseConstants.vendorsTable} (
  ${DatabaseConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${DatabaseConstants.vendorId} INTEGER NOT NULL,
  ${DatabaseConstants.name} TEXT NOT NULL,
  ${DatabaseConstants.location} TEXT NOT NULL,
  ${DatabaseConstants.rating} REAL NOT NULL,
  ${DatabaseConstants.category} TEXT NOT NULL,
  ${DatabaseConstants.image} TEXT NOT NULL
);
''';
