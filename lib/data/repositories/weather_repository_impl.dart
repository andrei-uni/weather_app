import 'package:dio/dio.dart';
import 'package:result_type/result_type.dart';
import 'package:weather_app/data/datasources/weather_service/latitude_longitude.dart';
import 'package:weather_app/data/datasources/weather_service/mappers/error_mapper.dart';
import 'package:weather_app/data/datasources/weather_service/mappers/location_mapper.dart';
import 'package:weather_app/data/datasources/weather_service/mappers/weather_condition_mapper.dart';
import 'package:weather_app/data/datasources/weather_service/responses/day_json.dart';
import 'package:weather_app/data/datasources/weather_service/responses/error_response.dart';
import 'package:weather_app/data/datasources/weather_service/responses/get_weather_response.dart';
import 'package:weather_app/data/datasources/weather_service/responses/hour_json.dart';
import 'package:weather_app/data/datasources/weather_service/weather_service.dart';
import 'package:weather_app/domain/models/weather_error.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/day_weather.dart';
import 'package:weather_app/domain/models/weather.dart';
import 'package:weather_app/domain/models/current_weather_forecast.dart';
import 'package:weather_app/domain/models/weather_metrics.dart';
import 'package:weather_app/domain/models/weekly_weather_forecast.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/utils/locator.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final _weatherService = locator<WeatherService>();

  WeatherError _toWeatherError(DioException dioException) {
    final errorResponse = dioException.response;
    if (errorResponse == null) {
      return NoConnection();
    }
    return ErrorResponse.fromJson(errorResponse.data).error.toModel();
  }

  @override
  Future<Result<CurrentWeatherForecast, WeatherError>> getCurrentWeather(
    Coordinates coordinates,
  ) async {
    late final GetWeatherResponse response;

    try {
      final httpResponse = await _weatherService.getWeather(
        LatitudeLongitude(
          latitude: coordinates.latitude,
          longitude: coordinates.longitude,
        ),
        1,
      );
      response = httpResponse.data;
    } on DioException catch (e) {
      return Failure(_toWeatherError(e));
    }

    final currentWeather = Weather(
      temperature: response.current.tempCels,
      weatherCondition: response.current.condition.toModel(isDay: response.current.isDay),
    );

    final currentMetrics = WeatherMetrics(
      windSpeed: response.current.windKph,
      humidity: response.current.humidity,
      cloudiness: response.current.cloudiness,
    );

    final List<HourJson> currentDayHours = response.forecast.forecastDays[0].hours;
    final List<Weather> hourlyWeather = [
      for (final hourJson in currentDayHours)
        Weather(
          temperature: hourJson.tempCels,
          weatherCondition: hourJson.condition.toModel(isDay: response.current.isDay),
        ),
    ];

    return Success(
      CurrentWeatherForecast(
        location: response.location.toModel(),
        currentWeather: currentWeather,
        currentMetrics: currentMetrics,
        hourlyWeather: hourlyWeather,
      ),
    );
  }

  @override
  Future<Result<WeeklyWeatherForecast, WeatherError>> getWeeklyWeather(
    Coordinates coordinates,
  ) async {
    late final GetWeatherResponse response;

    try {
      final httpResponse = await _weatherService.getWeather(
        LatitudeLongitude(
          latitude: coordinates.latitude,
          longitude: coordinates.longitude,
        ),
        7,
      );
      response = httpResponse.data;
    } on DioException catch (e) {
      return Failure(_toWeatherError(e));
    }

    final List<DayJson> days = response.forecast.forecastDays.map((e) => e.day).toList();
    final List<List<HourJson>> daysHours =
        response.forecast.forecastDays.map((e) => e.hours).toList();

    final List<DayWeather> dailyWeather = [
      for (var i = 0; i < days.length; i++)
        DayWeather(
          dayTimeTemperature: days[i].avgTempCels,
          nightTimeTemperature: daysHours[i][2].tempCels,
          weatherCondition: days[i].condition.toModel(isDay: true),
        ),
    ];

    return Success(
      WeeklyWeatherForecast(dailyWeather: dailyWeather),
    );
  }
}
