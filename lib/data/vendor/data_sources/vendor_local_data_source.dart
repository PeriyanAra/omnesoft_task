import 'package:omnesoft_task/data/vendor/services/vendor_local_service.dart';
import 'package:omnesoft_task/data/vendor/vendor_dto.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';

class VendorLocalDataSource {
  const VendorLocalDataSource({required VendorLocalService vendorLocalService})
      : _vendorLocalService = vendorLocalService;

  final VendorLocalService _vendorLocalService;

  Future<Result<List<VendorDto>, Exception>> fetchVendors() async {
    try {
      final vendors = await _vendorLocalService.fetchVendors();

      return Result.success(vendors.map(VendorDto.fromJson).toList());
    } catch (e) {
      return Result.failure(Exception(e));
    }
  }

  Future<Result<void, Exception>> cacheVendors(List<Map<String, dynamic>> vendors) async {
    try {
      await _vendorLocalService.cacheVendors(vendors);

      return Result.success(null);
    } catch (e) {
      return Result.failure(Exception(e));
    }
  }
}
