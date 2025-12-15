import 'package:omnesoft_task/data/vendor.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';

class VendorRemoteDataSource {
  VendorRemoteDataSource({required MockVendorApiService mockVendorApiService})
      : _mockVendorApiService = mockVendorApiService;

  final MockVendorApiService _mockVendorApiService;

  Future<Result<List<VendorDto>, Exception>> getVendors({
    int limit = 10,
  }) async {
    try {
      final vendors = await _mockVendorApiService.fetchVendors(
        limit: limit,
      );
      
      return Result.success(vendors.map(VendorDto.fromJson).toList());
    } catch (e) {
      return Result.failure(Exception(e));
    }
  }
}
