import 'package:auto_route/auto_route.dart';
import 'package:charge_me/core/router/router.gr.dart';

import '../application.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
/*    const authenticated = false;

    if (authenticated) {
      // if user is authenticated, continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.push(LoginOptionRoutePage(onResult: (success) {
        // if success == true the navigation will be resumed
        // else it will be aborted
        resolver.next(success);
      }));
    }*/
    if (Application.token != null) {
      resolver.next(true);
    } else {
      resolver.redirect(const SignInFormRoutePage());
    }
  }
}
