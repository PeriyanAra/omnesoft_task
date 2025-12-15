import 'dart:async';
import 'dart:io';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

/// Test-only overrides to make widget tests deterministic when widgets use:
/// - `CachedNetworkImage` (network + caching)
/// - `path_provider` (platform channels)
class WidgetTestOverrides {
  WidgetTestOverrides._();

  static late final Directory _tempDirectory;
  static late final PathProviderPlatform _originalPathProviderPlatform;
  static late final HttpOverrides? _originalHttpOverrides;

  static Future<void> install() async {
    _tempDirectory = Directory.systemTemp.createTempSync('omnesoft_task_test_');

    _originalPathProviderPlatform = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _FakePathProviderPlatform(
      basePath: _tempDirectory.path,
    );

    _originalHttpOverrides = HttpOverrides.current;
    HttpOverrides.global = _FakeHttpOverrides();
  }

  static Future<void> uninstall() async {
    PathProviderPlatform.instance = _originalPathProviderPlatform;
    HttpOverrides.global = _originalHttpOverrides;

    if (_tempDirectory.existsSync()) {
      await _tempDirectory.delete(recursive: true);
    }
  }
}

class _FakePathProviderPlatform extends PathProviderPlatform {
  _FakePathProviderPlatform({required this.basePath});

  final String basePath;

  String get _temp => basePath;

  @override
  Future<String?> getTemporaryPath() async => _temp;

  @override
  Future<String?> getApplicationSupportPath() async => _temp;

  @override
  Future<String?> getLibraryPath() async => _temp;

  @override
  Future<String?> getApplicationDocumentsPath() async => _temp;

  @override
  Future<String?> getApplicationCachePath() async => _temp;

  @override
  Future<String?> getExternalStoragePath() async => _temp;

  @override
  Future<List<String>?> getExternalCachePaths() async => <String>[_temp];

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async =>
      <String>[_temp];

  @override
  Future<String?> getDownloadsPath() async => _temp;
}

class _FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _FakeHttpClient();
}

class _FakeHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async {
    return _FakeHttpClientRequest(url, method: method);
  }

  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return _FakeHttpClientRequest(url, method: 'GET');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpClientRequest implements HttpClientRequest {
  _FakeHttpClientRequest(this.url, {required String method}) : _method = method;

  final Uri url;

  final String _method;

  @override
  final HttpHeaders headers = _FakeHttpHeaders();

  @override
  String get method => _method;

  @override
  bool followRedirects = true;

  @override
  int maxRedirects = 5;

  @override
  bool persistentConnection = false;

  @override
  Future<HttpClientResponse> close() async => _FakeHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpClientResponse extends Stream<List<int>>
    implements HttpClientResponse {
  static const List<int> _transparentImage = <int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ];

  final Stream<List<int>> _innerStream = Stream<List<int>>.fromIterable(
    const <List<int>>[_transparentImage],
  );

  @override
  int get statusCode => 200;

  @override
  String get reasonPhrase => 'OK';

  @override
  bool get isRedirect => false;

  @override
  List<RedirectInfo> get redirects => const <RedirectInfo>[];

  @override
  bool get persistentConnection => false;

  @override
  X509Certificate? get certificate => null;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  HttpHeaders get headers => _FakeHttpHeaders();

  @override
  int get contentLength => _transparentImage.length;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _innerStream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
