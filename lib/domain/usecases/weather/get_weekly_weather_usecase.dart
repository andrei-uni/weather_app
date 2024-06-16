import 'package:result_type/result_type.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/weather_error.dart';
import 'package:weather_app/domain/models/weekly_weather_forecast.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/utils/locator.dart';

class GetWeeklyWeatherUsecase {
  final _weatherRepository = locator<WeatherRepository>();

  Future<Result<WeeklyWeatherForecast, WeatherError>> call(Coordinates coordinates) async {
    return await _weatherRepository.getWeeklyWeather(coordinates);
  }
}
