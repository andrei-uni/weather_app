import 'package:dio/dio.dart';
import 'package:result_type/result_type.dart';
import 'package:weather_app/data/datasources/weather_service/latitude_longitude_query_parameter.dart';
import 'package:weather_app/data/datasources/weather_service/mappers/weather_condition_mapper.dart';
import 'package:weather_app/data/datasources/weather_service/responses/current_weather_json.dart';
import 'package:weather_app/data/datasources/weather_service/responses/day_json.dart';
import 'package:weather_app/data/datasources/weather_service/responses/get_location_response.dart';
import 'package:weather_app/data/datasources/weather_service/responses/get_weather_response.dart';
import 'package:weather_app/data/datasources/weather_service/responses/hour_json.dart';
import 'package:weather_app/data/datasources/weather_service/weather_service.dart';
import 'package:weather_app/data/datasources/weather_service/dio_exception_to_weather_error_x.dart';
import 'package:weather_app/domain/models/errors/weather_error.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/weather/current_weather_forecast.dart';
import 'package:weather_app/domain/models/weather/daily_weather.dart';
import 'package:weather_app/domain/models/weather/weather.dart';
import 'package:weather_app/domain/models/weather/weather_metrics.dart';
import 'package:weather_app/domain/models/weather/daily_forecast.dart';
import 'package:weather_app/domain/repositories/remote_weather_repository.dart';
import 'package:weather_app/utils/extensions/enumerate_iterable_x.dart';
import 'package:weather_app/utils/locator.dart';

class RemoteWeatherRepositoryImpl implements RemoteWeatherRepository {
  final _weatherService = locator<WeatherService>();

  @override
  Future<Result<CurrentWeatherForecast, WeatherError>> getCurrentWeatherForecast(
    Coordinates coordinates,
  ) async {
    late final GetWeatherForecastResponse response;

    try {
      response = await _weatherService.getWeatherForecast(
        LatitudeLongitudeQueryParameter(
          latitude: coordinates.latitude,
          longitude: coordinates.longitude,
        ),
        1,
      );
    } on DioException catch (e) {
      return Failure(e.toWeatherError());
    }

    final CurrentWeatherJson current = response.current;

    final currentWeather = Weather(
      temperature: current.tempCels,
      weatherCondition: current.condition.toModel(isDay: current.isDay),
    );

    final currentMetrics = WeatherMetrics(
      windSpeed: current.windKph,
      humidity: current.humidity,
      cloudiness: current.cloudiness,
    );

    final List<HourJson> currentDayHours = response.forecast.forecastDays[0].hours;
    final List<Weather> hourlyWeather = [
      for (final hourJson in currentDayHours)
        Weather(
          temperature: hourJson.tempCels,
          weatherCondition: hourJson.condition.toModel(isDay: hourJson.isDay),
        ),
    ];

    return Success(
      CurrentWeatherForecast(
        localtime: response.location.localtime,
        weather: currentWeather,
        currentMetrics: currentMetrics,
        hourlyWeather: hourlyWeather,
      ),
    );
  }

  @override
  Future<Result<DailyForecast, WeatherError>> getDailyWeatherForecast(
    Coordinates coordinates, {
    required int days,
  }) async {
    late final GetWeatherForecastResponse response;

    try {
      response = await _weatherService.getWeatherForecast(
        LatitudeLongitudeQueryParameter(
          latitude: coordinates.latitude,
          longitude: coordinates.longitude,
        ),
        days,
      );
    } on DioException catch (e) {
      return Failure(e.toWeatherError());
    }

    final Iterable<DayJson> daysJson = response.forecast.forecastDays.map((e) => e.day);
    final List<List<HourJson>> daysHours =
        response.forecast.forecastDays.map((e) => e.hours).toList();

    final List<DailyWeather> dailyWeather = [
      for (final (DayJson dayJson, int index) in daysJson.enumerate())
        DailyWeather(
          dayTimeTemperature: dayJson.avgTempCels,
          nightTimeTemperature: daysHours[index][2].tempCels,
          weatherCondition: dayJson.condition.toModel(isDay: true),
        ),
    ];

    return Success(
      DailyForecast(dailyWeather: dailyWeather),
    );
  }

  @override
  Future<String?> getLocationNameByCoordinates(Coordinates coordinates) async {
    try {
      final GetLocationResponse response = await _weatherService.getLocation(
        LatitudeLongitudeQueryParameter(
          latitude: coordinates.latitude,
          longitude: coordinates.longitude,
        ),
      );
      return response.location.name;
    } on DioException {
      return null;
    }
  }
}
