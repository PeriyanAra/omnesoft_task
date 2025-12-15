import 'package:omnesoft_task/data/database_constants.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';

class VendorLocalService {
  const VendorLocalService({required CacheDatabase cacheDatabase})
    : _cacheDatabase = cacheDatabase;

  final CacheDatabase _cacheDatabase;

  Future<List<Map<String, dynamic>>> fetchVendors() async {
    final rows = await _cacheDatabase.query(
      'SELECT * FROM ${DatabaseConstants.vendorsTable}',
    );

    return rows;
  }

  Future<void> cacheVendors(List<Map<String, dynamic>> vendors) async {
    await _cacheDatabase.query('DELETE FROM ${DatabaseConstants.vendorsTable}');

    for (final vendor in vendors) {
      await _cacheDatabase.query(
        'INSERT INTO ${DatabaseConstants.vendorsTable} ('
        '${DatabaseConstants.vendorId}, ${DatabaseConstants.name}, '
        '${DatabaseConstants.location}, ${DatabaseConstants.rating}, '
        '${DatabaseConstants.category}, ${DatabaseConstants.image}'
        ') VALUES (?, ?, ?, ?, ?, ?)',
        arguments: [
          vendor[DatabaseConstants.vendorId],
          vendor[DatabaseConstants.name],
          vendor[DatabaseConstants.location],
          vendor[DatabaseConstants.rating],
          vendor[DatabaseConstants.category],
          vendor[DatabaseConstants.image],
        ],
      );
    }
  }
}
