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
        AutoRoute(
          path: '/language_page',
          page: SelectLanguagePageRoute.page,
        ),
        AutoRoute(
          path: '/setting_page',
          page: SettingRoutePage.page,
        ),
        AutoRoute(
          path: '/edit_profile_page',
          page: EditProfilePageRoute.page,
        ),
        AutoRoute(
          path: '/support_service_page',
          page: SupportServicePage.page,
        ),
        AutoRoute(
          path: '/term_of_use_page',
          page: TermsOfUsePage.page,
        ),
        AutoRoute(
          path: '/wallet_page',
          page: WalletRoutePage.page,
        ),
        AutoRoute(
          path: '/about_app_page',
          page: AboutAppRoutePage.page,
        ),
        AutoRoute(
          path: '/AccountSetupConnectorRoutePage',
          page: AccountSetupConnectorRoutePage.page,
        ),
        AutoRoute(
          path: '/AccountSetupLocationRoutePage',
          page: AccountSetupLocationRoutePage.page,
        ),
        AutoRoute(
          path: '/AccountSetupUserRoutePage',
          page: AccountSetupUserRoutePage.page,
        ),
        AutoRoute(
          path: '/yandex_map_page',
          page: YandexMapPageRoute.page,
        ),
        AutoRoute(
          path: '/Password_change_page',
          page: PasswordChangeRoutePage.page,
        ),
        AutoRoute(
          path: '/Accept_privacy_page',
          page: AcceptPrivacyPoliceRoutePage.page,
        ),
        AutoRoute(
          path: '/Payment_page',
          page: PaymentPageRoute.page,
        ),
        AutoRoute(
          path: '/scanner_page',
          page: ScannerRoutePage.page,
        ),
        AutoRoute(
          path: '/account_setup_car_page',
          page: AccountSetupCarRoutePage.page,
        ),
        AutoRoute(
          path: '/booking_page',
          page: BookingRoutePage.page,
        ),
        AutoRoute(
          path: '/charging_page',
          page: ChargingRoutePage.page,
        ),
        AutoRoute(
          path: '/finish_page',
          page: FinishRoutePage.page,
        ),
        AutoRoute(
          path: '/status_page',
          page: StatusPageRoute.page,
        ),
      ];
}
