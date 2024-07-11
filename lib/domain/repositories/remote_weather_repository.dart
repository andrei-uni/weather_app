import 'package:result_type/result_type.dart';
import 'package:weather_app/domain/models/errors/weather_error.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/weather/current_weather_forecast.dart';
import 'package:weather_app/domain/models/weather/daily_forecast.dart';

abstract class RemoteWeatherRepository {
  Future<Result<CurrentWeatherForecast, WeatherError>> getCurrentWeatherForecast(
    Coordinates coordinates,
  );

  Future<Result<DailyForecast, WeatherError>> getDailyWeatherForecast(
    Coordinates coordinates, {
    required int days,
  });

  Future<String?> getLocationNameByCoordinates(Coordinates coordinates);
}
