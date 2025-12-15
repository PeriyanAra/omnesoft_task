abstract class Result<T, E extends Exception> {
  const Result();

  factory Result.failure(E exception) => FailureResult(exception);

  factory Result.success(T data) => SuccessResult(data);

  bool get isSuccess => this is SuccessResult<T, E>;
  bool get isFailure => this is FailureResult<T, E>;

  T get data {
    if (this is SuccessResult<T, E>) {
      return (this as SuccessResult<T, E>).data;
    }
    throw StateError('Result is not Success');
  }

  E get exception {
    if (this is FailureResult<T, E>) {
      return (this as FailureResult<T, E>).exception;
    }
    throw StateError('Result is not Failure');
  }

  R when<R>({
    required R Function(T data) success,
    required R Function(E error) failure,
  }) {
    if (this is SuccessResult<T, E>) {
      return success((this as SuccessResult<T, E>).data);
    } else if (this is FailureResult<T, E>) {
      return failure((this as FailureResult<T, E>).exception);
    } else {
      throw StateError('Unhandled Result case');
    }
  }
}

class SuccessResult<T, E extends Exception> extends Result<T, E> {
  const SuccessResult(this.data);

  @override
  final T data;
}

class FailureResult<T, E extends Exception> extends Result<T, E> {
  const FailureResult(this.exception);

  @override
  final E exception;
}
