import 'dart:async';

import 'package:meta/meta.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/src/exceptions.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/src/utility/result.dart';

typedef LocalDbCallInvoker<T> = Future<T> Function();

const Duration _localDbCallTimeout = Duration(seconds: 5);

abstract class BaseRepository {
  @protected
  Future<Result<T, AppException>> guardLocalDbCall<T>({
    required LocalDbCallInvoker<T> invoker,
    Duration? timeout,
  }) async {
    try {
      final effectiveTimeout = timeout ?? _localDbCallTimeout;
      final data = await invoker().timeout(effectiveTimeout);
      return Result.success(data);
    } on TimeoutException catch (ex, stackTrace) {
      return Result.failure(
        AppException(
          message: ex.toString(),
          stackTrace: stackTrace,
        ),
      );
    } on Exception catch (ex, stackTrace) {
      return Result.failure(
        AppException(
          message: ex.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
