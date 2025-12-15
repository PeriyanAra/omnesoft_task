import 'package:omnesoft_task/data/vendor.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';

class DataDependencies extends PackageDependencies {
  @override
  Future<void> register(DI di) async {
    di
    ..registerLazySingleton<MockVendorApiService>(() {
      return MockVendorApiService();
    })
    ..registerLazySingleton<VendorLocalService>(() {
      return VendorLocalService(cacheDatabase: di());
    })
    ..registerLazySingleton<VendorLocalDataSource>(() {
      return VendorLocalDataSource(vendorLocalService: di());
    })
    ..registerLazySingleton<VendorRemoteDataSource>(() {
      return VendorRemoteDataSource(mockVendorApiService: di());
    });
  }
}
