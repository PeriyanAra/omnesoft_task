import 'package:omnesoft_task/data.dart';
import 'package:omnesoft_task/domain/vendor/vendor_entity.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';

class VendorRepository extends BaseRepository {
  VendorRepository({
    required VendorRemoteDataSource vendorRemoteDataSource,
    required VendorLocalDataSource vendorLocalDataSource,
  }) : _vendorLocalDataSource = vendorLocalDataSource,
       _vendorRemoteDataSource = vendorRemoteDataSource;

  final VendorRemoteDataSource _vendorRemoteDataSource;
  final VendorLocalDataSource _vendorLocalDataSource;

  Future<Result<List<VendorEntity>, Exception>> fetchVendors({
    int limit = 10,
  }) async {
    final remoteResponse = await _vendorRemoteDataSource.getVendors(
      limit: limit,
    );

    if (remoteResponse.isSuccess) {
      await _vendorLocalDataSource.cacheVendors(
        remoteResponse.data.map((vendorDto) => vendorDto.toJson()).toList(),
      );

      return Result.success(
        remoteResponse.data.map((vendorDto) => vendorDto.toEntity()).toList(),
      );
    } else {
      final localResponse = await _vendorLocalDataSource.fetchVendors();

      if (localResponse.isSuccess) {
        return Result.success(
          localResponse.data.map((vendorDto) => vendorDto.toEntity()).toList(),
        );
      } else {
        return Result.failure(remoteResponse.exception);
      }
    }
  }
}
