import 'package:weather_app/domain/models/weather/weather_condition.dart';

class DailyWeather {
  const DailyWeather({
    required this.dayTimeTemperature,
    required this.nightTimeTemperature,
    required this.weatherCondition,
  });

  final double dayTimeTemperature;
  final double nightTimeTemperature;
  final WeatherCondition weatherCondition;
}
