import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/presentation/current_weather_screen/current_weather_screen.dart';

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
    return MaterialApp(
      darkTheme: theme,
      themeMode: ThemeMode.dark,
      home: const CurrentWeatherScreen(
        coordinates: Coordinates(
          latitude: 55.741439,
          longitude: 37.621902,
        ),
      ),
    );
  }
}
