import 'dart:async';

typedef FactoryFunc<T> = T Function();
typedef FactoryFuncParam<T, P1> = T Function(P1 param1);
typedef DisposingFunc<T> = FutureOr<void> Function(T param);

abstract class DI {
  T call<T extends Object>({String? instanceName});

  T get<T extends Object>({String? instanceName});

  T getWithParam<T extends Object, P>(
    P param, {
    String? instanceName,
  });

  bool isRegistered<T extends Object>();

  void registerFactory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  });

  void registerFactoryParam<T extends Object, P1>(
    FactoryFuncParam<T, P1> factoryFunc, {
    String? instanceName,
  });

  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });

  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });
}
