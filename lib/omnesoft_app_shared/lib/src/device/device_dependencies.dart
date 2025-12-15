import 'package:omnesoft_task/omnesoft_app_shared/lib/src/core.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/src/device.dart';

class DeviceDependencies extends PackageDependencies {
  @override
  Future<void> register(DI di) async {
    final appKeyValueStorage = await DeviceAppKeyValueStorage.create(
      jsonStringConverter: di(),
    );

    di.registerSingleton<AppKeyValueStorage>(appKeyValueStorage);
  }
}
