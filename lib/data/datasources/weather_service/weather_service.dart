import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/data/datasources/weather_service/latitude_longitude_query_parameter.dart';
import 'package:weather_app/data/datasources/weather_service/responses/get_location_response.dart';
import 'package:weather_app/data/datasources/weather_service/responses/get_weather_response.dart';

part 'weather_service.g.dart';

@RestApi(baseUrl: 'https://api.weatherapi.com/v1')
abstract class WeatherService {
  factory WeatherService(Dio dio, {String baseUrl}) = _WeatherService;

  @GET('/forecast.json')
  Future<GetWeatherForecastResponse> getWeatherForecast(
    @Query('q') LatitudeLongitudeQueryParameter latitudeLongitude,
    @Query('days') int days,
  );

  @GET('/current.json')
  Future<GetLocationResponse> getLocation(
    @Query('q') LatitudeLongitudeQueryParameter latitudeLongitude,
  );
}
