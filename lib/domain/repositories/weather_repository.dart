import 'package:result_type/result_type.dart';
import 'package:weather_app/domain/models/weather_error.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/current_weather_forecast.dart';
import 'package:weather_app/domain/models/weekly_weather_forecast.dart';

abstract class WeatherRepository {
  Future<Result<CurrentWeatherForecast, WeatherError>> getCurrentWeather(
    Coordinates coordinates,
  );

  Future<Result<WeeklyWeatherForecast, WeatherError>> getWeeklyWeather(
    Coordinates coordinates,
  );
}
