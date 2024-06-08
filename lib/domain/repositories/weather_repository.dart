import 'package:weather_app/domain/models/current_weather_forecast.dart';
import 'package:weather_app/domain/models/weekly_weather_forecast.dart';

abstract class WeatherRepository {
  Future<CurrentWeatherForecast?> getCurrentWeather({
    required double latitude,
    required double longitude,
  });

  Future<WeeklyWeatherForecast?> getWeeklyWeather({
    required double latitude,
    required double longitude,
  });
}
