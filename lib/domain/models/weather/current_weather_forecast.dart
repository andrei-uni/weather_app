import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/models/weather/weather.dart';
import 'package:weather_app/domain/models/weather/weather_metrics.dart';

class CurrentWeatherForecast {
  CurrentWeatherForecast({
    required this.location,
    required this.currentWeather,
    required this.currentMetrics,
    required this.hourlyWeather,
  }) : assert(hourlyWeather.length == 24);

  final Location location;
  final Weather currentWeather;
  final WeatherMetrics currentMetrics;
  final List<Weather> hourlyWeather;
}
