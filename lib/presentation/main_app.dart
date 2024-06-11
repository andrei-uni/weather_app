import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:weather_app/presentation/authentication_screen/authentication_screen.dart';
import 'package:weather_app/presentation/current_weather_screen/current_weather_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  static ThemeData get theme {
    final baseTheme = ThemeData.dark();

    return baseTheme.copyWith(
      textTheme: GoogleFonts.rubikTextTheme(baseTheme.textTheme),
    );
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        darkTheme: theme,
        themeMode: ThemeMode.dark,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state) {
                case Authenticated(:final coordinates):
                  _navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      return CurrentWeatherScreen(coordinates: coordinates);
                    }),
                    (route) => false,
                  );

                case Unauthenticated():
                  _navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      return const AuthenticationScreen();
                    }),
                    (route) => false,
                  );
                  
                case Unknown():
                  break;
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (_) => MaterialPageRoute(builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
