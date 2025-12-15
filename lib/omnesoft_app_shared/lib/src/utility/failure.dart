class Failure implements Exception {
  const Failure({
    required this.reason,
    required this.message,
    this.exception,
    this.stackTrace,
    this.statusCode,
  });

  final FailureReason reason;
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;
  final int? statusCode;

  @override
  String toString() => '[$reason] $message';
}

enum FailureReason {
  noInternet,
  timeout,
  unauthorized,
  badRequest,
  notFound,
  conflict,
  forbidden,
  tooManyRequests,
  serverError,
  sslError,
  cancelled,
  httpClientError,
  socketError,
  parseError,
  unknown,
}
