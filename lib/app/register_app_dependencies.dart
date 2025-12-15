import 'package:omnesoft_task/data/data_dependencies.dart';
import 'package:omnesoft_task/domain/domain_dependencies.dart';
import 'package:omnesoft_task/infrastructure/cache/project_cache_dependencies.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';
import 'package:omnesoft_task/presentation/presentation_dependencies.dart';

Future<void> registerAppDependencies({required DI di}) async {
  final dependenciesList = <PackageDependencies>[
    CoreDependencies(),
    DeviceDependencies(),
    ProjectCacheDependencies(),
    DataDependencies(),
    DomainDependencies(),
    PresentationDependencies(),
  ];

  for (final dependencies in dependenciesList) {
    await dependencies.register(di);
  }
}
