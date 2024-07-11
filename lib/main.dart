import 'package:flutter/material.dart';
import 'package:weather_app/presentation/main_app.dart';
import 'package:weather_app/utils/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(const MainApp());
}
