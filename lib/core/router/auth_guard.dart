import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/router/router.gr.dart';

import '../application.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (Application.token != null) {
      resolver.next(true);
    } else {
      resolver.redirect(const SignInFormRoutePage());
    }
  }
}
