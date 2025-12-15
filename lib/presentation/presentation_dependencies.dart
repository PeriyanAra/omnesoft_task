import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';
import 'package:omnesoft_task/presentation/common.dart';
import 'package:omnesoft_task/presentation/home.dart';

class PresentationDependencies extends PackageDependencies {
  @override
  Future<void> register(DI di) async {
    di
      ..registerFactory<HomeCubit>(() => HomeCubit(vendorRepository: di()))
      ..registerLazySingleton<ThemeCubit>(() => ThemeCubit(preferences: di()));
  }
}
