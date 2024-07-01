import 'package:result_type/result_type.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/errors/weather_error.dart';
import 'package:weather_app/domain/models/weather/current_weather_forecast.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/utils/locator.dart';

class GetCurrentWeatherForecastUsecase {
  final _weatherRepository = locator<WeatherRepository>();

  Future<Result<CurrentWeatherForecast, WeatherError>> call(Coordinates coordinates) async {
    return await _weatherRepository.getCurrentWeatherForecast(coordinates);
  }
}
