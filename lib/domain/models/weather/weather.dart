import 'package:weather_app/domain/models/weather/weather_condition.dart';

class Weather {
  Weather({
    required this.temperature,
    required this.weatherCondition,
  });

  final double temperature;
  final WeatherCondition weatherCondition;
}
