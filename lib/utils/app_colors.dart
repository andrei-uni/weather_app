import 'package:flutter/material.dart';
import 'package:weather_app/utils/extensions/context_x.dart';

abstract class AppColors {
  static Color containerGrey(BuildContext context) {
    return context.isLight ? const Color(0xFFEBEBF4) : const Color(0xFF202328);
  }

  static Color activeBlue(BuildContext context) {
    return context.isLight ? const Color(0xFF55C6FB) : const Color(0xFF01579B);
  }
}
