import 'package:flutter/material.dart';
import 'package:weather_app/presentation/main_app.dart';
import 'package:weather_app/utils/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(const MainApp());
}
