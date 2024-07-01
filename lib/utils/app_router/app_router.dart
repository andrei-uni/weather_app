import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:weather_app/presentation/authentication_screen/authentication_screen.dart';
import 'package:weather_app/presentation/current_weather_screen/current_weather_screen.dart';
import 'package:weather_app/presentation/map_screen/map_screen.dart';
import 'package:weather_app/presentation/daily_weather_screen/daily_weather_screen.dart';
import 'package:weather_app/utils/app_router/auth_guard.dart';
import 'package:weather_app/utils/app_router/logged_in_wrapper_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter({
    required this.authenticationBloc,
  });

  final AuthenticationBloc authenticationBloc;

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: LoggedInWrapperRoute.page,
        initial: true,
        guards: [AuthGuard(authenticationBloc: authenticationBloc)],
        children: [
          AutoRoute(page: CurrentWeatherRoute.page, initial: true),
          AutoRoute(page: DailyWeatherRoute.page),
          AutoRoute(page: MapRoute.page),
        ],
      ),
      AutoRoute(
        page: AuthenticationRoute.page,
      ),
    ];
  }
}
