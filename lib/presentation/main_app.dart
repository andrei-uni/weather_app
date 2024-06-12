import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:weather_app/utils/app_router/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  static ThemeData get theme {
    final baseTheme = ThemeData.dark();

    return baseTheme.copyWith(
      textTheme: GoogleFonts.rubikTextTheme(baseTheme.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: Builder(builder: (context) {
        final authBloc = context.read<AuthenticationBloc>();
        final router = AppRouter(authenticationBloc: authBloc);
        return MaterialApp.router(
          routerConfig: router.config(
            reevaluateListenable: ReevaluateListenable.stream(authBloc.stream),
          ),
          darkTheme: theme,
          themeMode: ThemeMode.dark,
        );
      }),
    );
  }
}
