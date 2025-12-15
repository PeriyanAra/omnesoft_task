import 'package:omnesoft_task/data.dart';
import 'package:omnesoft_task/domain/vendor/vendor_repository.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';

class DomainDependencies extends PackageDependencies {
  @override
  Future<void> register(DI di) async {
    di.registerLazySingleton<VendorRepository>(() {
      return VendorRepository(
        vendorRemoteDataSource: di<VendorRemoteDataSource>(),
        vendorLocalDataSource: di<VendorLocalDataSource>(),
      );
    });
  }
}
