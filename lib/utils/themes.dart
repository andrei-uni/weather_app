import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Themes {
  static ThemeData get lightTheme {
    final baseTheme = ThemeData();
    return _getSharedTheme(baseTheme);
  }

  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark();
    return _getSharedTheme(baseTheme);
  }

  static ThemeData _getSharedTheme(ThemeData baseTheme) {
    return baseTheme.copyWith(
      textTheme: GoogleFonts.rubikTextTheme(baseTheme.textTheme),
    );
  }
}
