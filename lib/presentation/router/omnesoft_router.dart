import 'package:auto_route/auto_route.dart';
import 'package:omnesoft_task/presentation/router/omnesoft_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeScreenRoute.page, initial: true),
    AutoRoute(page: VendorDetailsScreenRoute.page),
    AutoRoute(page: SettingsScreenRoute.page),
  ];
}
