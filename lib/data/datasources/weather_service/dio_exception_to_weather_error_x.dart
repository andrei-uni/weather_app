import 'package:dio/dio.dart';
import 'package:weather_app/data/datasources/weather_service/mappers/error_mapper.dart';
import 'package:weather_app/data/datasources/weather_service/responses/error_json.dart';
import 'package:weather_app/data/datasources/weather_service/responses/error_response.dart';
import 'package:weather_app/domain/models/errors/weather_error.dart';

extension DioExceptionToWeatherErrorX on DioException {
  WeatherError toWeatherError() {
    final Response<dynamic>? errorResponse = response;

    if (errorResponse == null) {
      return NoConnection();
    }
    
    final ErrorJson errorJson = ErrorResponse.fromJson(errorResponse.data).error;
    
    return errorJson.toModel();
  }
}
