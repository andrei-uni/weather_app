import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/data/datasources/weather_service/latitude_longitude.dart';
import 'package:weather_app/data/datasources/weather_service/responses/get_weather_response.dart';

part 'weather_service.g.dart';

@RestApi(baseUrl: 'https://api.weatherapi.com/v1')
abstract class WeatherService {
  factory WeatherService(Dio dio, {String baseUrl}) = _WeatherService;

  @GET('/forecast.json')
  Future<GetWeatherResponse> getWeather(
    @Query('q') LatitudeLongitude latitudeLongitude,
    @Query('days') int days,
  );
}
