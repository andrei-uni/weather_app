import 'package:flutter/material.dart';
import 'package:weather_app/utils/extensions/context_x.dart';

abstract class Gradients {
  static Gradient locationItemGradient(BuildContext context) {
    const List<Color> lightColors = [
      Color(0xFF0D48A1),
      Color(0xFF64B5F6),
    ];
    const List<Color> darkColors = [
      Color(0xFF095089),
      Color(0xFF1976D2),
    ];

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: context.isLight ? lightColors : darkColors,
    );
  }
}
