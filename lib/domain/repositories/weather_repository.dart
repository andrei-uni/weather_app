import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/current_weather_forecast.dart';
import 'package:weather_app/domain/models/weekly_weather_forecast.dart';

abstract class WeatherRepository {
  Future<CurrentWeatherForecast?> getCurrentWeather(Coordinates coordinates);

  Future<WeeklyWeatherForecast?> getWeeklyWeather(Coordinates coordinates);
}
