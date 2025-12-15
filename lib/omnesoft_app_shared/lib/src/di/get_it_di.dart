import 'package:get_it/get_it.dart' hide FactoryFunc, FactoryFuncParam, DisposingFunc;
import 'package:omnesoft_task/omnesoft_app_shared/lib/src/core.dart';

class GetItDI implements DI {
  GetItDI() : getIt = GetIt.instance;

  final GetIt getIt;

  @override
  T call<T extends Object>({String? instanceName}) {
    return get(instanceName: instanceName);
  }

  @override
  T get<T extends Object>({String? instanceName}) {
    return getIt.get(instanceName: instanceName);
  }

  @override
  T getWithParam<T extends Object, P>(P param, {String? instanceName}) {
    return getIt.get(instanceName: instanceName, param1: param);
  }

  @override
  bool isRegistered<T extends Object>() {
    return getIt.isRegistered<T>();
  }

  @override
  void registerFactory<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}) {
    return getIt.registerFactory(
      () => factoryFunc(),
      instanceName: instanceName,
    );
  }

  @override
  void registerFactoryParam<T extends Object, P1>(FactoryFuncParam<T, P1> factoryFuncParam, {String? instanceName}) {
    getIt.registerFactoryParam<T, P1, void>(
      (p1, _) => factoryFuncParam(p1),
      instanceName: instanceName,
    );
  }

  @override
  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    getIt.registerLazySingleton(
      () => factoryFunc(),
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  void registerSingleton<T extends Object>(T instance, {String? instanceName, DisposingFunc<T>? dispose}) {
    getIt.registerSingleton(
      instance,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  Future<void> reset() {
    return getIt.reset();
  }
}
