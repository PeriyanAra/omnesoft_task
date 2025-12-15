import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';
import 'package:omnesoft_task/presentation/common/cubits/theme_cubit/theme_cubit.dart';
import 'package:omnesoft_task/presentation/home/widgets/home_screen_loaded_content.dart';
import 'package:omnesoft_task/presentation/router/omnesoft_router.gr.dart';
import 'package:omnesoft_task/presentation/theme/omnesoft_theme.dart';
import 'package:omnesoft_task/presentation/vendor_details/vendor_details_screen.dart';
import 'package:omnesoft_task/presentation/vendor_details/widgets/value_container.dart';
import 'package:omnesoft_task/presentation/view_models/vendor_view_model.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../test_utils/memory_app_storage.dart';

void main() {
  late final Directory tempDirectory;
  late final PathProviderPlatform originalPathProviderPlatform;
  late final HttpOverrides? originalHttpOverrides;
  Future<void> pumpApp(
    WidgetTester tester, {
    required List<VendorViewModel> vendors,
  }) async {
    final appRouter = _TestAppRouter(vendors: vendors);

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(preferences: InMemoryAppStorage()),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: appRouter.config(),
          theme: OmnesoftAppTheme.light(),
        ),
      ),
    );
    // Initial frame only
    await tester.pump();
  }

  Finder homeVendorName(String name) {
    return find.descendant(
      of: find.byType(HomeScreenLoadedContent),
      matching: find.text(name),
    );
  }

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    tempDirectory = Directory.systemTemp.createTempSync('omnesoft_task_test_');

    originalPathProviderPlatform = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _FakePathProviderPlatform(
      basePath: tempDirectory.path,
    );

    originalHttpOverrides = HttpOverrides.current;
    HttpOverrides.global = _FakeHttpOverrides();
  });

  tearDownAll(() async {
    PathProviderPlatform.instance = originalPathProviderPlatform;
    HttpOverrides.global = originalHttpOverrides;

    if (tempDirectory.existsSync()) {
      await tempDirectory.delete(recursive: true);
    }
  });

  testWidgets(
    'Navigation: tap vendor card opens VendorDetailsScreen with correct content',
    (tester) async {
      final vendors = [
        VendorViewModel(
          vendorId: 1,
          name: 'Acme Corp',
          location: 'Yerevan',
          rating: 4.2,
          category: 'Electronics',
          image: 'https://picsum.photos/seed/1/500/500',
        ),
        VendorViewModel(
          vendorId: 2,
          name: 'Omne Fashion',
          location: 'Gyumri',
          rating: 3.8,
          category: 'Fashion',
          image: 'https://picsum.photos/seed/2/500/500',
        ),
      ];

      await pumpApp(tester, vendors: vendors);

      expect(find.byType(VendorDetailsScreen), findsNothing);
      expect(homeVendorName('Acme Corp'), findsOneWidget);

      await tester.tap(homeVendorName('Acme Corp'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byType(VendorDetailsScreen), findsOneWidget);

      expect(
        find.descendant(
          of: find.byType(VendorDetailsScreen),
          matching: find.text('Acme Corp'),
        ),
        findsAtLeastNWidgets(1),
      );

      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);

      expect(
        find.descendant(
          of: find.byType(OmnesoftAppBar),
          matching: find.text(vendors.first.rating.toStringAsFixed(1)),
        ),
        findsOneWidget,
      );

      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);

      expect(
        find.descendant(
          of: find.byType(ValueContainer),
          matching: find.text(vendors.first.category),
        ),
        findsOneWidget,
      );

      expect(
        find.descendant(
          of: find.byType(ValueContainer),
          matching: find.text(vendors.first.location),
        ),
        findsOneWidget,
      );

      expect(find.byType(ValueContainer), findsNWidgets(2));

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Hero && widget.tag == 'hero-0',
        ),
        findsAtLeastNWidgets(1),
      );
    },
  );

  testWidgets(
    'Navigation: tapping the second vendor uses hero-1 tag and shows its details',
    (tester) async {
      final vendors = [
        VendorViewModel(
          vendorId: 1,
          name: 'Acme Corp',
          location: 'Yerevan',
          rating: 4.2,
          category: 'Electronics',
          image: 'https://picsum.photos/seed/1/500/500',
        ),
        VendorViewModel(
          vendorId: 2,
          name: 'Omne Fashion',
          location: 'Gyumri',
          rating: 3.8,
          category: 'Fashion',
          image: 'https://picsum.photos/seed/2/500/500',
        ),
      ];

      await pumpApp(tester, vendors: vendors);

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Hero && widget.tag == 'hero-1',
        ),
        findsOneWidget,
      );
      await tester.tap(homeVendorName('Omne Fashion'));
      await tester.pumpAndSettle();

      expect(find.byType(VendorDetailsScreen), findsOneWidget);
      expect(find.text('Omne Fashion'), findsOneWidget);
      expect(find.text(vendors[1].rating.toStringAsFixed(1)), findsOneWidget);
      expect(find.text(vendors[1].category), findsOneWidget);
      expect(find.text(vendors[1].location), findsOneWidget);
      expect(find.byType(ValueContainer), findsNWidgets(2));

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Hero && widget.tag == 'hero-1',
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets('Navigation: back button pops VendorDetailsScreen', (
    tester,
  ) async {
    final vendors = [
      VendorViewModel(
        vendorId: 1,
        name: 'Acme Corp',
        location: 'Yerevan',
        rating: 4.2,
        category: 'Electronics',
        image: 'https://picsum.photos/seed/1/500/500',
      ),
    ];

    await pumpApp(tester, vendors: vendors);

    await tester.tap(homeVendorName('Acme Corp'));
    await tester.pumpAndSettle();
    expect(find.byType(VendorDetailsScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle();

    expect(find.byType(VendorDetailsScreen), findsNothing);
    expect(homeVendorName('Acme Corp'), findsOneWidget);
  });
}

class _TestAppRouter extends RootStackRouter {
  _TestAppRouter({required this.vendors});

  final List<VendorViewModel> vendors;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: PageInfo(
        '_TestHomeRoute',
        builder: (_) => _TestHomeScreen(vendors: vendors),
      ),
      initial: true,
    ),
    AutoRoute(page: VendorDetailsScreenRoute.page),
  ];
}

class _TestHomeScreen extends StatelessWidget {
  const _TestHomeScreen({required this.vendors});

  final List<VendorViewModel> vendors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenLoadedContent(vendors: vendors, enablePagination: false),
    );
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
  }) async => <String>[_temp];

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
  static const _transparentImage = <int>[
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

  final Stream<List<int>> _innerStream = Stream<List<int>>.fromIterable(const [
    _transparentImage,
  ]);

  @override
  int get statusCode => 200;

  @override
  String get reasonPhrase => 'OK';

  @override
  bool get isRedirect => false;

  @override
  List<RedirectInfo> get redirects => const [];

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
