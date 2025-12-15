import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';
import 'package:omnesoft_task/presentation/common.dart';
import 'package:omnesoft_task/presentation/home/cubit/home_cubit.dart';
import 'package:omnesoft_task/presentation/home/home_screen.dart';
import 'package:omnesoft_task/presentation/home/widgets/home_screen_loaded_content.dart';
import 'package:omnesoft_task/presentation/home/widgets/home_screen_search_bar.dart';
import 'package:omnesoft_task/presentation/home/widgets/vendor_card.dart';
import 'package:omnesoft_task/presentation/theme/omnesoft_theme.dart';
import 'package:omnesoft_task/presentation/view_models/vendor_view_model.dart';

import '../../test_utils/memory_app_storage.dart';
import '../../test_utils/widget_test_overrides.dart';

class _SpyHomeCubit extends Cubit<HomeState> implements HomeCubit {
  _SpyHomeCubit({HomeState? seedState}) : super(seedState ?? HomeLoading());

  int loadVendorsCallCount = 0;
  int loadAdditionalVendorsCallCount = 0;
  int cancelSearchingCallCount = 0;
  final List<String> searchQueries = <String>[];

  Completer<void>? loadVendorsCompleter;

  @override
  Future<void> loadVendors() {
    loadVendorsCallCount += 1;
    return loadVendorsCompleter?.future ?? Future<void>.value();
  }

  @override
  Future<void> loadAdditionalVendors() async {
    if (loadAdditionalVendorsCallCount > 0) return;
    loadAdditionalVendorsCallCount += 1;
  }

  @override
  void searchVendors(String searchQuery) {
    searchQueries.add(searchQuery);
  }

  @override
  void cancelSearching() {
    cancelSearchingCallCount += 1;
  }
}

class _SearchableHomeCubit extends Cubit<HomeState> implements HomeCubit {
  _SearchableHomeCubit({required List<VendorViewModel> vendors})
    : _allVendors = List<VendorViewModel>.of(vendors),
      super(HomeLoaded(vendors: vendors));

  final List<VendorViewModel> _allVendors;

  @override
  Future<void> loadVendors() async {}

  @override
  Future<void> loadAdditionalVendors() async {}

  @override
  void searchVendors(String searchQuery) {
    final filtered =
        _allVendors
            .where(
              (vendor) =>
                  vendor.name.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    emit(HomeLoaded(vendors: filtered, isSearching: true));
  }

  @override
  void cancelSearching() {
    emit(HomeLoaded(vendors: _allVendors));
  }
}

List<VendorViewModel> _buildVendors(int count) {
  return List.generate(count, (index) {
    final id = index + 1;
    return VendorViewModel(
      vendorId: id,
      name: 'Vendor $id',
      location: 'City $id',
      rating: 4.0 + (index % 10) / 10,
      category: 'Category $id',
      image: 'https://picsum.photos/seed/$id/500/500',
    );
  });
}


final class _NoopDI implements DI {
  @override
  T call<T extends Object>({String? instanceName}) =>
      get<T>(instanceName: instanceName);

  @override
  T get<T extends Object>({String? instanceName}) =>
      throw UnimplementedError('No DI registrations in tests');

  @override
  T getWithParam<T extends Object, P>(P param, {String? instanceName}) =>
      throw UnimplementedError('No DI registrations in tests');

  @override
  bool isRegistered<T extends Object>() => false;

  @override
  void registerFactory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) => throw UnimplementedError();

  @override
  void registerFactoryParam<T extends Object, P1>(
    FactoryFuncParam<T, P1> factoryFunc, {
    String? instanceName,
  }) => throw UnimplementedError();

  @override
  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) => throw UnimplementedError();

  @override
  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) => throw UnimplementedError();
}

final class _TestBlocFactory extends BlocFactory {
  _TestBlocFactory({required this.homeCubit}) : super(di: _NoopDI());

  final HomeCubit homeCubit;

  @override
  T get<T extends BlocBase<Object>>() {
    if (T == HomeCubit) return homeCubit as T;
    throw UnimplementedError('No BlocFactory registration for $T');
  }
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await WidgetTestOverrides.install();
  });

  tearDownAll(() async {
    await WidgetTestOverrides.uninstall();
  });

  testWidgets('renders a VendorCard for each vendor', (tester) async {
    final vendors = _buildVendors(3);

    await tester.pumpWidget(
      MaterialApp(
        theme: OmnesoftAppTheme.light(),
        home: Scaffold(
          body: HomeScreenLoadedContent(
            vendors: vendors,
            enablePagination: false,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byType(VendorCard), findsNWidgets(vendors.length));
    expect(find.byIcon(Icons.star_rounded), findsNWidgets(vendors.length));
    expect(
      find.byIcon(Icons.chevron_right_rounded),
      findsNWidgets(vendors.length),
    );

    for (var index = 0; index < vendors.length; index++) {
      final vendor = vendors[index];

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Hero && widget.tag == 'hero-$index',
        ),
        findsOneWidget,
      );

      final cardFinder = find.byType(VendorCard).at(index);
      expect(
        find.descendant(of: cardFinder, matching: find.text(vendor.name)),
        findsOneWidget,
      );
      expect(
        find.descendant(of: cardFinder, matching: find.text(vendor.category)),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardFinder,
          matching: find.text(vendor.rating.toStringAsFixed(1)),
        ),
        findsOneWidget,
      );
    }
  });

  testWidgets('renders an empty state when vendor list is empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: OmnesoftAppTheme.light(),
        home: const Scaffold(
          body: HomeScreenLoadedContent(vendors: <VendorViewModel>[]),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(VendorCard), findsNothing);
    expect(find.text('No vendors found'), findsOneWidget);
  });

  testWidgets(
    'renders a pagination loader at the end when isLoadingMore is true',
    (tester) async {
      final vendors = _buildVendors(2);

      await tester.pumpWidget(
        MaterialApp(
          theme: OmnesoftAppTheme.light(),
          home: Scaffold(body: HomeScreenLoadedContent(vendors: vendors)),
        ),
      );
      await tester.pump();

      expect(find.byType(VendorCard), findsNWidgets(vendors.length));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets('HomeScreen renders loaded vendor list', (tester) async {
    final vendors = _buildVendors(3);
    final homeCubit = _SpyHomeCubit(seedState: HomeLoaded(vendors: vendors));

    await tester.pumpWidget(
      RepositoryProvider<BlocFactory>.value(
        value: _TestBlocFactory(homeCubit: homeCubit),
        child: BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(preferences: InMemoryAppStorage()),
          child: MaterialApp(
            theme: OmnesoftAppTheme.light(),
            home: const HomeScreen(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(homeCubit.loadVendorsCallCount, 1);
    expect(find.byType(HomeScreenLoadedContent), findsOneWidget);
    expect(find.byType(VendorCard), findsNWidgets(vendors.length));
  });

  testWidgets('pull-to-refresh triggers HomeCubit.loadVendors', (tester) async {
    final vendors = _buildVendors(5);
    final cubit = _SpyHomeCubit(seedState: HomeLoaded(vendors: vendors));
    addTearDown(cubit.close);

    cubit.loadVendorsCompleter = Completer<void>();

    await tester.pumpWidget(
      MaterialApp(
        theme: OmnesoftAppTheme.light(),
        home: Scaffold(
          body: BlocProvider<HomeCubit>.value(
            value: cubit,
            child: HomeScreenLoadedContent(
              vendors: vendors,
              enablePagination: false,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, 400));

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(cubit.loadVendorsCallCount, 1);

    cubit.loadVendorsCompleter?.complete();
    await tester.pumpAndSettle();
  });

  testWidgets('Search bar: typing triggers debounced HomeCubit.searchVendors', (
    tester,
  ) async {
    final cubit = _SpyHomeCubit();
    addTearDown(cubit.close);

    await tester.pumpWidget(
      MaterialApp(
        theme: OmnesoftAppTheme.light(),
        home: Scaffold(
          body: BlocProvider<HomeCubit>.value(
            value: cubit,
            child: const HomeScreenSearchBar(),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Vendor 1');
    await tester.pump(const Duration(milliseconds: 299));
    expect(cubit.searchQueries, isEmpty);

    await tester.pump(const Duration(milliseconds: 1));
    expect(cubit.searchQueries, ['Vendor 1']);
  });

  testWidgets(
    'Search bar: clear button calls cancelSearching and clears input',
    (tester) async {
      final cubit = _SpyHomeCubit();
      addTearDown(cubit.close);

      await tester.pumpWidget(
        MaterialApp(
          theme: OmnesoftAppTheme.light(),
          home: Scaffold(
            body: BlocProvider<HomeCubit>.value(
              value: cubit,
              child: const HomeScreenSearchBar(),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Vendor 1');
      await tester.pump();
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump();

      expect(cubit.cancelSearchingCallCount, 1);
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        '',
      );
    },
  );

  testWidgets('HomeScreen search filters vendor list and clear resets it', (
    tester,
  ) async {
    // Arrange
    final vendors = _buildVendors(3);
    final homeCubit = _SearchableHomeCubit(vendors: vendors);

    await tester.pumpWidget(
      RepositoryProvider<BlocFactory>.value(
        value: _TestBlocFactory(homeCubit: homeCubit),
        child: BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(preferences: InMemoryAppStorage()),
          child: MaterialApp(
            theme: OmnesoftAppTheme.light(),
            home: const HomeScreen(),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(VendorCard), findsNWidgets(3));

    await tester.enterText(find.byType(TextField), 'Vendor 2');

    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(VendorCard), findsOneWidget);

    expect(
      find.descendant(
        of: find.byType(VendorCard),
        matching: find.text('Vendor 2'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.byType(VendorCard), findsNWidgets(3));
  });

  testWidgets(
    'scrolling near bottom triggers HomeCubit.loadAdditionalVendors',
    (tester) async {
      final vendors = _buildVendors(40);
      final cubit = _SpyHomeCubit(seedState: HomeLoaded(vendors: vendors));
      addTearDown(cubit.close);

      await tester.pumpWidget(
        MaterialApp(
          theme: OmnesoftAppTheme.light(),
          home: Scaffold(
            body: BlocProvider<HomeCubit>.value(
              value: cubit,
              child: HomeScreenLoadedContent(vendors: vendors),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(find.text(vendors.last.name), 600);
      await tester.pump(const Duration(milliseconds: 300));

      expect(cubit.loadAdditionalVendorsCallCount, 1);
    },
  );

  testWidgets('scrolling does not paginate when enablePagination is false', (
    tester,
  ) async {
    final vendors = _buildVendors(40);
    final cubit = _SpyHomeCubit(seedState: HomeLoaded(vendors: vendors));
    addTearDown(cubit.close);

    await tester.pumpWidget(
      MaterialApp(
        theme: OmnesoftAppTheme.light(),
        home: Scaffold(
          body: BlocProvider<HomeCubit>.value(
            value: cubit,
            child: HomeScreenLoadedContent(
              vendors: vendors,
              enablePagination: false,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text(vendors.last.name), 600);
    await tester.pump(const Duration(milliseconds: 300));

    expect(cubit.loadAdditionalVendorsCallCount, 0);
  });
}
