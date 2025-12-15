import 'package:omnesoft_task/omnesoft_app_shared/lib/src/core/di.dart';

abstract class PackageDependencies {
  Future<void> register(DI di);
}
