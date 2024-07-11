import 'package:auto_route/auto_route.dart';
import 'package:weather_app/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:weather_app/utils/app_router/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard({
    required this.authenticationBloc,
  });

  final AuthenticationBloc authenticationBloc;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    switch (authenticationBloc.state) {
      case Authenticated():
        resolver.next();
        return;

      case Unauthenticated():
        resolver.redirect(AuthenticationRoute());
        return;

      case Unknown():
        await for (final _ in authenticationBloc.stream) {
          onNavigation(resolver, router);
          return;
        }
    }
  }
}
