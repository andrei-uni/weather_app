import 'package:weather_app/domain/models/weather/weather.dart';
import 'package:weather_app/domain/models/weather/weather_metrics.dart';

class CurrentWeatherForecast {
  const CurrentWeatherForecast({
    required this.localtime,
    required this.weather,
    required this.metrics,
    required this.hourlyWeather,
  }) : assert(hourlyWeather.length == 24);

  final DateTime localtime;
  final Weather weather;
  final WeatherMetrics metrics;
  final List<Weather> hourlyWeather;
}
