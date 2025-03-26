import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/router/router.gr.dart';

import '../../feature/auth/view/login_option_page.dart';
import '../../feature/auth/view/register_form_page.dart';

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
    AutoRoute(
      path: '/notification_page',
      page: NotificationPageRoute.page,
    ),
    AutoRoute(
      path: '/login_option_page',
      page: LoginOptionRoutePage.page,
    ),
    AutoRoute(
      path: '/register_form_page',
      page: RegisterFormRoutePage.page,
    ),
    AutoRoute(
      path: '/sign_in_form_page',
      page: SignInFormRoutePage.page,
    ),
    AutoRoute(
      path: '/register_form_otp_page',
      page: RegisterFormOtpRoutePage.page,
    ),
  ];
}
