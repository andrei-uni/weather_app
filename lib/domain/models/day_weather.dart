import 'package:weather_app/domain/models/weather_condition.dart';

class DayWeather {
  DayWeather({
    required this.dayTimeTemperature,
    required this.nightTimeTemperature,
    required this.weatherCondition,
  });

  final double dayTimeTemperature;
  final double nightTimeTemperature;
  final WeatherCondition weatherCondition;
}
