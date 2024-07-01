import 'package:result_type/result_type.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/errors/weather_error.dart';
import 'package:weather_app/domain/models/weather/daily_forecast.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/utils/locator.dart';

class GetDailyWeatherForecastUsecase {
  final _weatherRepository = locator<WeatherRepository>();

  Future<Result<DailyForecast, WeatherError>> call(
    Coordinates coordinates, {
    required int days,
  }) async {
    return await _weatherRepository.getDailyWeatherForecast(coordinates, days: days);
  }
}
