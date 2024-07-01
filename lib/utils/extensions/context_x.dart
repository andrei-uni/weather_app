import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  bool get isLight {
    return MediaQuery.platformBrightnessOf(this) == Brightness.light;
  }
}
