import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter  {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      path: '/splash_page',
      page: SplashPageRoute.page,
    ),
    AutoRoute(
      path: '/dashboard_page',
      page: DashboardPageRoute.page,
    ),
  ];
}
