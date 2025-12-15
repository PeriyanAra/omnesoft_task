class AppException implements Exception {
  const AppException({
    required this.message,
    required this.stackTrace,
  });

  final String message;
  final StackTrace stackTrace;

  @override
  // ignore: no_runtimetype_tostring
  String toString() => '$runtimeType: $message';
}
